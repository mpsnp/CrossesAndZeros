unit MainForm;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls;

const
    ImageSize: integer = 40;

type

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
    public
        { public declarations }
    end;

var
    FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }


procedure TFormMain.FormCreate(Sender: TObject);
const
    NumberOfDraggable: integer = 5;
    Offsets: integer = 10;
var
    i: integer;
    TempImage: TImage;
begin
    SetLength(DraggableCrosses, NumberOfDraggable);
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
            with Picture.Bitmap.Canvas do
            begin
                Brush.Color := clForm;
                Pen.Color := clBlue;
                Pen.Width := 2;
                Picture.Bitmap.SetSize(ImageSize, ImageSize);
                FillRect(0, 0, ImageSize, ImageSize);
                Line(Offsets, Offsets, ImageSize - Offsets, ImageSize - Offsets);
                Line(ImageSize - Offsets, Offsets, Offsets, ImageSize - Offsets);
            end;
        end;
    end;
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

