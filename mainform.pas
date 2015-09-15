unit MainForm;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls;

const
    ImageSize: integer = 40;

type

    TImageArray = array of TImage;
    { TFormMain }
    TFormMain = class(TForm)
        GroupBoxPlayer1: TGroupBox;
        GroupBoxPlayer2: TGroupBox;
        GamePanel: TPanel;
        procedure FormCreate(Sender: TObject);
        procedure MouseDownOnImage(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: integer);
    private
        { private declarations }
        DraggableCrosses: array of TImage;
        procedure AddImagesToPanel(Target: TObject; Image: TPicture;
            var HolderArray: TImageArray);
    public
        { public declarations }
    end;

var
    FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.AddImagesToPanel(Target: TObject; Image: TPicture;
    var HolderArray: TImageArray);
const
    NumberOfDraggable: integer = 5;
var
    i: integer;
    TempImage: TImage;
begin
    SetLength(HolderArray, NumberOfDraggable);
    for I := 0 to High(DraggableCrosses) do
    begin
        DraggableCrosses[i] := TImage.Create(GroupBoxPlayer1);
        with DraggableCrosses[i] do
        begin
            Width := ImageSize;
            Height := ImageSize;
            Top := 0;
            Left := i * ImageSize;
            Parent := GroupBoxPlayer1;
            OnMouseDown := @MouseDownOnImage;
            Picture := Image;
        end;
    end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
const
    Offsets: integer = 10;
var
    Image: TPicture;
begin
    Image := TPicture.Create();
    with Image.Bitmap.Canvas do
    begin
        Brush.Color := clForm;
        Pen.Color := clBlue;
        Pen.Width := 2;
        Image.Bitmap.SetSize(ImageSize, ImageSize);
        FillRect(0, 0, ImageSize, ImageSize);
        Line(Offsets, Offsets, ImageSize - Offsets, ImageSize - Offsets);
        Line(ImageSize - Offsets, Offsets, Offsets, ImageSize - Offsets);
    end;
    AddImagesToPanel(GroupBoxPlayer1, Image, DraggableCrosses);
end;

procedure TFormMain.MouseDownOnImage(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: integer);
begin
    with Sender as TImage do
    begin
        BeginDrag(True);
    end;
end;


end.
