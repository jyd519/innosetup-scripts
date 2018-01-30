#define AppId "{INSERT HERE YOUR GUID}"
#define AppName "My App"
#define AppVersion "1.7"

[CustomMessages]
english.NewerVersionExists=A newer version of {#AppName} is already installed.%n%nInstaller version: {#AppVersion}%nCurrent version:
[Code]
// find current version before installation
function InitializeSetup: Boolean;
var Version: String;
begin
  if RegValueExists(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#AppId}_is1', 'DisplayVersion') then
    begin
      RegQueryStringValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#AppId}_is1', 'DisplayVersion', Version);
      if Version > '{#AppVersion}' then
        begin
          MsgBox(ExpandConstant('{cm:NewerVersionExists} '+Version), mbInformation, MB_OK);
          Result := False;
        end
      else
        begin
          Result := True;
        end
    end
  else
    begin
      Result := True;
    end
end;
