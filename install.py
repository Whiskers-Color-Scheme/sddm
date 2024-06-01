import subprocess
import argparse
import os

accents = ["banana", "blueberry", "cherry", "grape", "kiwi", "tangerine"]
themes = ["panther", "tiger"]

def has_program(program):
    try:
        subprocess.run(f"command -v {program} > /dev/null 2>&1", shell=True, check=True)
        return True
    except:
        return False

if __name__ == '__main__':

    parser = argparse.ArgumentParser(prog="Installer",description="Whisker SDDM theme installer")
    parser.add_argument("-t", "--theme", choices=themes, default="panther", nargs="?", help="The theme to install")
    parser.add_argument("-a", "--accent", choices=accents, default="banana", nargs="?", help="Choose an accent color. Default is banana")
    parser.add_argument("-b", "--background", type=str, default=None, nargs="?", help="The background image.")


    args = parser.parse_args()
    theme = args.theme
    accent = args.accent
    background_path = args.background

    if background_path is not None:
        if not os.path.exists(background_path) or not background_path.endswith(tuple(["png", "jpg", "jpeg"])):
            print("Invalid background image.")
            exit(1)

    if accent == "banana":
        accent_color = "#FFE072" if theme == "panther" else "#A87B0A"
        accent_hover = "#ffefb8" if theme == "panther" else "#866208"
    if accent == "blueberry":
        accent_color = "#A5CEFF" if theme == "panther" else "#5284BE"
        accent_hover = "#d2e6ff" if theme == "panther" else "#3b699e"
    if accent == "cherry":
        accent_color = "#FF8C7C" if theme == "panther" else "#B43A2A"
        accent_hover = "#ffc5bd" if theme == "panther" else "#902e22"
    if accent == "grape":
        accent_color = "#FFAAF5" if theme == "panther" else "#7D0E70"
        accent_hover = "#ffd4fa" if theme == "panther" else "#640b5a"
    if accent == "kiwi":
        accent_color = "#B1E380" if theme == "panther" else "#6A9534"
        accent_hover = "#d8f1bf" if theme == "panther" else "#55772a"
    if accent == "tangerine":
        accent_color = "#FFB26C" if theme == "panther" else "#C15D01"
        accent_hover = "#ffd8b5" if theme == "panther" else "#9a4a01"

    script_dir = os.path.dirname(__file__)
    temp_dir = "/tmp/whiskers-sddm-theme"

    subprocess.run(f"rm -rf {temp_dir}", shell=True)
    subprocess.run(f"mkdir -p {temp_dir}", shell=True)
    subprocess.run(f"cp -r {script_dir}/themes/{theme}/* {temp_dir}", shell=True)
    
    if background_path:
        file_name = os.path.basename(background_path)
        subprocess.run(f"cp {background_path} {temp_dir}/{file_name}", shell=True)

    conf_file = ""

    with open(f"{temp_dir}/theme.conf", "r") as file:
        for line in file:
            
            if background_path and line.rstrip() == 'UseCustomBackground="false"':
                conf_file += f'UseCustomBackground="true"\n'

            elif background_path and line.rstrip() == 'CustomBackground=""':
                file_name = os.path.basename(background_path)
                conf_file += f'CustomBackground="{file_name}"\n'
            
            elif line.rstrip() == 'AccentColor=""':
                conf_file += f'AccentColor="{accent_color}"\n'
            
            elif line.rstrip() == 'AccentColorHover=""':
                conf_file += f'AccentColorHover="{accent_hover}"\n'

            else:
                conf_file += line

    with open(f"{temp_dir}/theme.conf", "w") as file:
        file.write(conf_file)

    theme_dir_name = f"whiskers-{theme}"

    subprocess.run(f"sudo rm -rf /usr/share/sddm/themes/{theme_dir_name}", shell=True)
    subprocess.run(f"sudo cp -r {temp_dir} /usr/share/sddm/themes/{theme_dir_name}", shell=True)

    if not os.path.exists("/etc/sddm.conf"):
        subprocess.run("sudo touch /etc/sddm.conf", shell=True)

    print(f"""
Please add/edit the following content to your /etc/sddm.conf file:
[Theme]
Current={theme_dir_name}
""")
    
    _ = input("\n\n\nClick enter to continue...")
    
    if has_program("nvim"):
        subprocess.run(f"sudo nvim /etc/sddm.conf", shell=True)
    elif has_program("vim"):
        subprocess.run(f"sudo vim /etc/sddm.conf", shell=True)
    elif has_program("vi"):
        subprocess.run(f"sudo vi /etc/sddm.conf", shell=True)
    elif has_program("micro"):
        subprocess.run(f"sudo micro /etc/sddm.conf", shell=True)
    elif has_program("gedit"):
        subprocess.run(f"sudo gedit /etc/sddm.conf", shell=True)
    elif has_program("nano"):
        subprocess.run(f"sudo nano /etc/sddm.conf", shell=True)
    else:
        print("Couldn't find a program to edit /etc/sddm.conf")

    print("Assuming you changed the conf file you can now reboot the pc and see the changes :D")