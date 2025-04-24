
import os
import rasterio
import numpy as np
from abc import ABC, abstractmethod

# Abstraktní třída pro výpočet vegetačních indexů
class Calculation(ABC):
    def __init__(self, raster, bands, base_name):
        self.raster = raster  # Uložení rasteru jako atribut třídy
        self.bands = bands  # Uložení funkce mapování pásem jako atribut třídy
        self.base_name = base_name  # Název vstupního souboru bez přípony

    @abstractmethod
    def get_index(self):
        pass

    @abstractmethod
    def get_name(self):
        pass

    def save_index(self, path):
        index = self.get_index()
        output_filename = f"{self.base_name}_{self.get_name()}.tif"
        output_path = os.path.join(path, output_filename)

        if os.path.exists(output_path):
            os.remove(output_path)

        meta = self.raster.meta
        meta.update(dtype='float32', count=1)

        with rasterio.open(output_path, 'w', **meta) as dst:
            dst.write(index, 1)

        print(f"{self.get_name()} index has been created and saved to: {output_path}")

# Třídy pro výpočet vegetačních indexů
class NdviCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        red_band = self.raster.read(self.bands['B4']).astype('float32')
        return (nir_band - red_band) / (nir_band + red_band + 1e-10)

    def get_name(self):
        return "NDVI"

class NdwiCalculation(Calculation):
    def get_index(self):
        green_band = self.raster.read(self.bands['B3']).astype('float32')
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        return (green_band - nir_band) / (green_band + nir_band + 1e-10)

    def get_name(self):
        return "NDWI"

class SrCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        red_band = self.raster.read(self.bands['B4']).astype('float32')
        return nir_band / (red_band + 1e-10)

    def get_name(self):
        return "SR"

class NdmiCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        swir_band = self.raster.read(self.bands['B11']).astype('float32')
        return (nir_band - swir_band) / (nir_band + swir_band + 1e-10)

    def get_name(self):
        return "NDMI"

class GndviCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        green_band = self.raster.read(self.bands['B3']).astype('float32')
        return (nir_band - green_band) / (nir_band + green_band + 1e-10)

    def get_name(self):
        return "GNDVI"

class McariCalculation(Calculation):
    def get_index(self):
        red_band = self.raster.read(self.bands['B4']).astype('float32')
        green_band = self.raster.read(self.bands['B3']).astype('float32')
        blue_band = self.raster.read(self.bands['B2']).astype('float32')
        return ((red_band - green_band) - 0.2 * (red_band - blue_band)) / (red_band / green_band + 1e-10)

    def get_name(self):
        return "MCARI"

class EviCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        red_band = self.raster.read(self.bands['B4']).astype('float32')
        blue_band = self.raster.read(self.bands['B2']).astype('float32')
        return 2.5 * (nir_band - red_band) / (nir_band + 6 * red_band - 7.5 * blue_band + 1)

    def get_name(self):
        return "EVI"

class SaviCalculation(Calculation):
    def get_index(self):
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        red_band = self.raster.read(self.bands['B4']).astype('float32')
        L = 0.428
        return ((nir_band - red_band) / (nir_band + red_band + L)) * (1.0 + L)

    def get_name(self):
        return "SAVI"

class MsiCalculation(Calculation):
    def get_index(self):
        swir_band = self.raster.read(self.bands['B11']).astype('float32')
        nir_band = self.raster.read(self.bands['B8']).astype('float32')
        return swir_band / (nir_band + 1e-10)

    def get_name(self):
        return "MSI"

class Calculator:
    def __init__(self, calculations):
        self.m_calculations = calculations

    def save_all_indices(self, path):
        for calculation in self.m_calculations:
            calculation.save_index(path)

if __name__ == "__main__":
    raster_path = "E:/Mendelu/predmety/Tvorba_Software/navrhovy_vzor/Indices_calculation/input/S2_03_20_2024_slp.tif"
    output_folder = "E:/Mendelu/predmety/Tvorba_Software/navrhovy_vzor/Indices_calculation/output"
    base_name = os.path.splitext(os.path.basename(raster_path))[0]  # Získání názvu souboru bez přípony

    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
        print("Output folder created.")

    bands_mapping = {
        'B1': 1, 'B2': 2, 'B3': 3, 'B4': 4,
        'B5': 3, 'B6': 5, 'B7': 6, 'B8': 7,
        'B8A': 8, 'B9': 9, 'B10': 10, 'B11': 11, 'B12': 12
    }

    with rasterio.open(raster_path) as raster:
        calculations = [cls(raster, bands_mapping, base_name) for cls in [NdviCalculation, NdwiCalculation, SrCalculation, NdmiCalculation, GndviCalculation, McariCalculation, EviCalculation, SaviCalculation, MsiCalculation]]
        calculator = Calculator(calculations)
        calculator.save_all_indices(output_folder)

    print("The script is finished!")