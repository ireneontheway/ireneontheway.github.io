# Contribution

## Clone Repo

Fork my repo on [GitHub](https://github.com/ireneontheway/ireneontheway.github.io) and clone it.

```
git clone https://github.com/ireneontheway/ireneontheway.github.io 
```

## Directory structure

The directory structure is maintained in the `SUMMARY.md` file.
After starting `mdbook`,it will automatically generate directories 
and files according to the `SUMMARY.md`.The commands to start document 
preview under each system are as follows:

- Window

```
bin\win\mdbook serve
```

- Mac

```
bin/mac/mdbook serve
```

- Linux 

```
bin/linux/mdbook serve
```

-  Mac and Linux systems need to give mdbook executable permission：
 
```
sudo chmod 755 bin/mac/mdbook

sudo chmod 755 bin/linux/mdbook
```

## Write articles

The document is written under `./src`, you can use mdbook to preview.
Mdbook manual is [here](https://mdbook.budshome.com).


## Preview

After executing the above command, you can open 
[`http://localhost:3000/`](http://localhost:3000/)
 with your browser to preview articles.

![Preview](../images/preview.png)