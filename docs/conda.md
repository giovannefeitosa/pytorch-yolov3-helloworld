# Work with conda

I had problems with running poetry commands, so I tried conda (mamba)

```
mamba env create --prefix $PWD/python_modules -f conda-environment.yml
```

```
conda activate $PWD/python_modules
```

After this, `poetry install` worked

> Open `./test.md`
