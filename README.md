# cthulhu-kraken-fighter
Process kraken ocr on a whole folder with just one simple command line

## Requierements
- Have Kraken installed on a virtual python env (https://kraken.re/main/index.html)

## Usage

```
Usage: cthulhu input_directory  [{-s|--alto}] [{-o|--output} output_directory] \
               [{-m|--model} model_path]
options:
-h, --help		            show this help message and quit
-a, --alto		            make outputfile in alto format
-o, --output=DIR	        set output directory, default is 'output'
-m, --model=MODEL_PATH	  specify the model to use

```

