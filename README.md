# BUNRU
BUNRU (NASM Builder and Runner) is a Linux CLI tool that builds, runs, and debugs your NASM code.
--
![BUNRU](https://github.com/user-attachments/assets/fef27d4a-7c30-4b00-acde-f212fe94ae58)
--
## How to Install
**Note:** Since BUNRU is a **NASM** Builder and Runner, you will need to have [NASM](https://www.nasm.us/) installed on your computer before you install BUNRU.

### Option 1: The Lazy Way
- Go to the [Releases Page](https://github.com/DustoGuss/bunru/releases), download, and extract the latest release.

### Option 2: Git Clone
- Clone the BUNRU repository by running:
  ```bash
  git clone https://github.com/DustoGuss/bunru.git

***ON YOUR TERMINAL, ENTER THE BUNRU DIRECTORY AND RUN THE BUNRU INSTALLER WITH ```sudo ./BunruInstaller```***

***THE BUNRU INSTALLER AUTOMATICALLY MOVES BUNRU TO THE ```/usr/local/bin``` FOLDER, IF IT DOESN'T WORK, PLEASE DO IT MANUALLY.***

## How to use BUNRU
  Run BUNRU with the following command:
  ```bunru <file(s)> <flag>```
  ### FLAGS TABLE:
  
  | Flag   | Description                                                                                                                                     |
  |--------|-------------------------------------------------------------------------------------------------------------------------------------------------| 
  | `-b`   | Builds the file(s).                                                                                                                             |
  | `-d`   | Debugs the input file(s) (it builds and runs your code but it deletes the executable and the .o file after it debugs).                          | 
  | `-r`   | Build and executes the file(s).                                                                                                                 |
  | `-bin` | Creates a bin file.                                                                                                                             |

  ### EXAMPLES:
  ```bunru main -r``` build and executes ```main.asm```.
  
  ```bunru main -d``` debugs ```main.asm```.
  
  ```bunru main test uhh -b``` builds ```main.asm```, ```test.s``` and ```uhh.asm```.



  


