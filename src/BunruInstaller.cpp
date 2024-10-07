#include <iostream>
#include <filesystem>
#include <string>
#include <cstdlib>

namespace fs = std::filesystem;

fs::path current_path = fs::current_path();
fs::path bunru_path = current_path / "bin/bunru";
fs::path target_path = "/usr/local/bin/bunru";

bool reinstalling = false;
bool alreadyinstalled()
{
    if (fs::exists(target_path)) 
    {
        return true;
    }
    else if (!fs::exists(target_path))
    {
        return false;
    }
}

void InstallBunru()
{
    if (alreadyinstalled() == true) 
    {
        std::cerr << "Error: BUNRU is already installed at " << target_path << "." << std::endl;
    }

    try 
    {
        fs::copy(bunru_path, target_path);
        if (reinstalling == false)
        {
            std::cout << "BUNRU installed successfully! You can now close the installer." << std::endl;
        }
    }
    catch (const fs::filesystem_error& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
    }
}

void UninstallBunru()
{
    if (alreadyinstalled() == true)
    {
        fs::remove_all(target_path);
    } 
    else if (alreadyinstalled() == false)
    {
        std::cerr << "You don't have BUNRU installed, please reopen the installer, if the error continues, redownload/download the latest release from the Github Repository (https://github.com/DustoGuss/bunru)" << std::endl;
    }
}

int main()
{
    char proceed;
    alreadyinstalled();
    if (alreadyinstalled() == false) 
    {
        std::cout << "Welcome to the BUNRU Installer! Proceed with the installation? (y/n) ";
        std::cin >> proceed;

        if (proceed == 'y' || proceed == 'Y') 
        {
            InstallBunru();
        } 
        else 
        {
            std::cout << "\nInstallation canceled. Goodbye! :D" << std::endl;
        }
    } 
    else 
    {
        std::cout << "Welcome to the BUNRU Installer! It seems like you already installed BUNRU, do you want to reinstall or uninstall BUNRU? (r: reinstall/u: uninstall): ";
        std::cin >> proceed;

        if (proceed == 'r' || proceed == 'R')
        {
            std::cout << "\nReinstalling...\n" << std::endl;
            reinstalling = true;
            UninstallBunru();
            InstallBunru();
            std::cout << "BUNRU succesfully reinstalled! :D" << std::endl;
        } else if (proceed == 'u' || proceed == 'U')
        {
            std::cout << "\nUninstalling BUNRU...\n" << std::endl;
            UninstallBunru();
            std::cout << "BUNRU succesfully uninstalled! :D" << std::endl;
        }
    }
    return 0;
}
