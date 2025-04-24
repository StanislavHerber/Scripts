import os
import rasterio
import numpy as np
from abc import ABC, abstractmethod

# Abstraktní třída pro výpočet vegetačních indexů
class Calculation(ABC):
    def __init__(self, raster, bands):
        self.raster = raster
        self.bands = bands  # Dictionary do ktereho se budou ukladat jednotlive indexy

    @abstractmethod
    def get_index(self):
        pass

    @abstractmethod
    def get_name(self):
        pass

# Třída pro výpočet NDVI indexu
# vezme raster -> určení jednotlivých pásem -> vložení formule pro výpočet -> pojmenování výstupu
class NdviCalculation(Calculation):
    def __init__(self, raster, bands):
        super().__init__(raster, bands)  # Volá konstruktor nadřazené třídy Calculation a předává mu parametry

    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')  # Načtení NIR pásma
        red_band = self.raster.read(self.bands['B3']).astype('float32')  # Načtení červeného pásma
        ndvi = (nir_band - red_band) / (nir_band + red_band + 1e-10)  # Výpočet NDVI
        average_ndvi = np.nanmean(ndvi)  # Test průměrné hodnoty indexu
        return ndvi

    def get_name(self):
        return "NDVI"

# Třída pro výpočet NDWI indexu
class NdwiCalculation(Calculation):
    def __init__(self, raster, bands):
        super().__init__(raster, bands)

    def get_index(self):
        green_band = self.raster.read(self.bands['B3']).astype('float32')  # Green band
        nir_band = self.raster.read(self.bands['B8']).astype('float32')  # NIR band
        ndwi = (green_band - nir_band) / (green_band + nir_band + 1e-10)  # Výpočet NDWI
        return ndwi

    def get_name(self):
        return "NDWI"

# Třída pro výpočet SR indexu
class SrCalculation(Calculation):
    def __init__(self, raster, bands):
        super().__init__(raster, bands)

    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')  # NIR band
        red_band = self.raster.read(self.bands['B4']).astype('float32')  # Red band
        sr = nir_band / (red_band + 1e-10)
        return sr

    def get_name(self):
        return "SR"

# Hlavni procesor
class Calculator:
    def __init__(self, calculations):
        self.m_calculations = calculations  # toto je dynamicke pole vypoctu, ktere je zatim prazdne

    def add_calculation(self, new_calculation):
        self.m_calculations.append(new_calculation)  # pridavam do seznamu novy index

    def make_calculation(self, calculation_name):
        # toto je klicova metoda, provede konkretni vypocet
        for calculation in self.m_calculations:
            if calculation.get_name() == calculation_name:
                print("Index exists!")
                return calculation.get_index()  # pokud jsme v seznamu dosli na index, ktery odpovida hledanemu jmenu, tak vratime vysledledek
        # pokud projdeme cely seznam, ale nikde neni index s pozadovanym jmenem, meli bychom vyhodit vyjimku, nebo alespon vypsat chybu atp.
        print(f"Error: index with name {calculation_name} not found")
        return 0

    def print_all_indices(self):
        # metoda pro vypsani vsech prumernych hodnot vypocitanych indexu
        for calculation in self.m_calculations:
            print(f"{calculation.get_name()}: {calculation.get_index().mean()}")

# Použití
if __name__ == "__main__":
    raster_path = "E:/Mendelu/predmety/Tvorba_Software/navrhovy_vzor/Indices_calculation/input/image_s2.tif"  # Cesta k vstupnímu rasteru
    output_folder = "E:/Mendelu/predmety/Tvorba_Software/navrhovy_vzor/Indices_calculation/output"  # Cesta k výstupní složce
    print("Input and output folders are set to: ", raster_path, " and ", output_folder)
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)  # Kontrola a vytvoření výstupní složky, pokud neexistuje
        print("Output folder created.")

    bands_mapping = {
        'B1':1,
        'B2':2,
        'B3':3,
        'B4':4,
        'B5':3,
        'B6':5,
        'B7':6,
        'B8':7,
        'B8A':8,
        'B9':9,
        'B10':10,
        'B11':11,
        'B12':12
    }

    with rasterio.open(raster_path) as raster:
        # Vytvoření instancí všech výpočtů
        ndvi_calculation = NdviCalculation(raster, bands_mapping)
        ndwi_calculation = NdwiCalculation(raster, bands_mapping)
        sr_calculation = SrCalculation(raster, bands_mapping)

        # Přidání všech výpočtů do seznamu
        calculations = [ndvi_calculation,sr_calculation, ndwi_calculation]

        calculator = Calculator(calculations)

        # Výpočet a uložení všech indexů
        for calculation_name in ["NDVI","NDWI","SR"]:
            result = calculator.make_calculation(calculation_name)
            output_path = os.path.join(output_folder, f"{calculation_name}.tif")

            # Check if the file exists and delete it if it does
            if os.path.exists(output_path):
                os.remove(output_path)

            # Aktualizace metadat pro výstupní raster
            meta = raster.meta
            meta.update(dtype='float32', count=1)

            # Zápis indexu do výstupního souboru
            with rasterio.open(output_path, 'w', **meta) as dst:
                dst.write(result, 1)

            print(f"{calculation_name} index has been created and saved to: {output_path}")

        # Print all indices that were calculated
        calculator.print_all_indices()
        print("The Script is finished!")