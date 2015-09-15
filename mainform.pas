unit MainForm;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls;

const
    ImageSize: integer = 40;

type
    TDrawProc = procedure(Bitmap: TBitmap; Offsets: integer) of object;

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
        DraggableZeros: array of TImage;
        procedure AddImagesToPanel(Target: TObject; Image: TPicture;
            var HolderArray: TImageArray);
        function GenerateImage(Offsets: integer; DrawerFunc: TDrawProc): TPicture;
        procedure DrawCross(DestinationBitmap: TBitmap; Offsets: integer);
        procedure DrawZero(DestinationBitmap: TBitmap; Offsets: integer);
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
    for I := 0 to High(HolderArray) do
    begin
        HolderArray[i] := TImage.Create(GroupBoxPlayer1);
        with HolderArray[i] do
        begin
            Width := ImageSize;
            Height := ImageSize;
            Top := 0;
            Left := i * ImageSize;
            Parent := Target as TWinControl;
            OnMouseDown := @MouseDownOnImage;
            Picture := Image;
        end;
    end;
end;

function TFormMain.GenerateImage(Offsets: integer; DrawerFunc: TDrawProc
    ): TPicture;
begin
    Result := TPicture.Create();
    with Result.Bitmap.Canvas do
    begin
        Brush.Color := clForm;
        Pen.Color := clBlue;
        Pen.Width := 2;
        Result.Bitmap.SetSize(ImageSize, ImageSize);
        FillRect(0, 0, ImageSize, ImageSize);
        DrawerFunc(Result.Bitmap, Offsets);
    end;
end;

procedure TFormMain.DrawCross(DestinationBitmap: TBitmap; Offsets: integer);
begin
    DestinationBitmap.Canvas.Line(Offsets, Offsets, ImageSize - Offsets, ImageSize - Offsets);
    DestinationBitmap.Canvas.Line(ImageSize - Offsets, Offsets, Offsets, ImageSize - Offsets);
end;

procedure TFormMain.DrawZero(DestinationBitmap: TBitmap; Offsets: integer);
begin
    DestinationBitmap.Canvas.Ellipse(Offsets, Offsets, ImageSize - Offsets, ImageSize - Offsets);
end;

procedure TFormMain.FormCreate(Sender: TObject);
const
    Offsets: integer = 10;
begin
    AddImagesToPanel(GroupBoxPlayer1, GenerateImage(Offsets, @DrawCross), DraggableCrosses);
    AddImagesToPanel(GroupBoxPlayer2, GenerateImage(Offsets, @DrawZero), DraggableZeros);
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
