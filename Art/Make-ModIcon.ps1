# About/ModIcon.png: a 64x64 square of the mod's own south-facing emperor penguin - head, flippers
# and the top of the white front - scaled to 128. The full sprite is 58x114 on a 256x256 canvas,
# and at the ~32 px the mod list actually draws it reads as a thin vertical smudge. No new art:
# this is Peso penguin's texture, cropped.
#
# The crop is the top 64 px of the sprite's bounding box (x 99..156, y 40..153), squared off and
# centred on the bird: x 96, y 36. Kept so the crop can be redone rather than guessed at.
Add-Type -AssemblyName System.Drawing
$src = 'C:\Users\nelim\Documents\rimworld\Penguins\Mod\Textures\Things\Pawn\Animal\Penguins\emperor_penguin_south.png'
$dst = 'C:\Users\nelim\Documents\rimworld\Penguins\Mod\About\ModIcon.png'
$bmp = [System.Drawing.Bitmap]::FromFile($src)
$out = New-Object System.Drawing.Bitmap 128,128,([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($out)
$g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.Clear([System.Drawing.Color]::Transparent)
$g.DrawImage($bmp,(New-Object System.Drawing.Rectangle 0,0,128,128),(New-Object System.Drawing.Rectangle 96,36,64,64),[System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose(); $out.Save($dst,[System.Drawing.Imaging.ImageFormat]::Png); $out.Dispose(); $bmp.Dispose()
"$dst : $((Get-Item $dst).Length) bytes"
