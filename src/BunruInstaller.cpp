#include <iostream>
#include <filesystem>
#include <string>
#include <cstdlib>

namespace fs = std::filesystem;

int main()
{
    char proceed;
    std::cout << "Welcome to the BUNRU Installer! Proceed with the installation? (y/n) ";
    std::cin >> proceed;

    if (proceed == 'y' || proceed == 'Y') 
    {
        fs::path current_path = fs::current_path();
        fs::path bunru_path = current_path / "bin/bunru";
        fs::path target_path = "/usr/local/bin/bunru";

        if (fs::exists(target_path)) 
        {
            std::cerr << "Error: BUNRU is already installed at " << target_path << "." << std::endl;
            return 1;
        }

        try 
        {
            fs::copy(bunru_path, target_path);
            std::cout << "BUNRU installed successfully! You can now close the installer." << std::endl;
        }
        catch (const fs::filesystem_error& e)
        {
            std::cerr << "Error: " << e.what() << std::endl;
            return 1;
        }
    } 
    else 
    {
        std::cout << "Installation canceled. Goodbye!" << std::endl;
    }

    return 0;
}
