unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    commandbtn: TButton;
    iconimg: TImage;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    workingdirbtn: TButton;
    terminal: TCheckBox;
    nametxt: TEdit;
    commenttxt: TEdit;
    commandtxt: TEdit;
    workingdirtxt: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure commandbtnClick(Sender: TObject);
    procedure iconimgClick(Sender: TObject);
    procedure workingdirbtnClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    imagefilename:string;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.commandbtnClick(Sender: TObject);
begin
  if OpenDialog1.Execute then commandtxt.text:=OpenDialog1.FileName;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
var Desktop:tstringlist;
begin
  if (trim(nametxt.text)='') or (trim(commandtxt.text)='') then exit;
  if SaveDialog1.Execute then
  begin
      desktop:=tstringlist.Create;
      try
        desktop.Add('[Desktop Entry]');
        desktop.Add('Type=Application');
        desktop.Add('Encoding=UTF-8');
        desktop.Add('Name='+nametxt.text);
        desktop.Add('Comment='+commenttxt.text);
        desktop.Add('Exec='+commandtxt.text);
        if trim(workingdirtxt.text)<>'' then desktop.Add('Path='+workingdirtxt.text);
        desktop.Add('Icon='+imagefilename);
        if not terminal.Checked then
        begin
           desktop.Add('Terminal=false');
        end else
        begin
          desktop.Add('Terminal=true');
        end;

        try

          desktop.SaveToFile(SaveDialog1.FileName);

        except

          ShowMessage('Cannot save file due to permission error.');

        end;

      finally
        desktop.free;
      end;
  end;
end;

procedure TMainForm.iconimgClick(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    try
      iconimg.Picture.LoadFromFile(OpenDialog2.FileName);
      imagefilename:=OpenDialog2.FileName;
    except
      iconimg.Picture.Clear;
    end;
  end;
end;

procedure TMainForm.workingdirbtnClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute then workingdirtxt.text:=SelectDirectoryDialog1.FileName;
end;

end.

