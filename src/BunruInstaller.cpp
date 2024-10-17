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
    std::string proceed;
    alreadyinstalled();
    if (alreadyinstalled() == false) 
    {
        std::cout << "Welcome to the BUNRU Installer! Proceed with the installation? (y/n) ";
        std::getline(std::cin, proceed);
        if (proceed.length() == 1)
        {
            char c = proceed[0];
            if (c == 'y' || c == 'Y') 
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
            std::cerr << "\nUnknown \'" << proceed << "\'" << std::endl;
            return 1;
        }
    } 
    else 
    {
        std::cout << "Welcome to the BUNRU Installer! It seems like you already installed BUNRU, do you want to reinstall or uninstall BUNRU? (r: reinstall/u: uninstall): ";
        std::getline(std::cin, proceed);
        if (proceed.length() == 1)
        {
            char c = proceed[0];           
            if (c == 'r' || c == 'R')
            {
                std::cout << "\nReinstalling...\n" << std::endl;
                reinstalling = true;
                UninstallBunru();
                InstallBunru();
                std::cout << "BUNRU succesfully reinstalled! :D" << std::endl;
            } else if (c == 'u' || c == 'U')
            {
                std::cout << "\nUninstalling BUNRU...\n" << std::endl;
                UninstallBunru();
                std::cout << "BUNRU succesfully uninstalled! :D" << std::endl;
            }

        }
        else
        {
            std::cerr << "\nUnknown \'" << proceed << "\'" << std::endl;
            return 1;
        }
    }
    return 0;
}
