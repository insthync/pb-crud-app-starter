# Regenerate the documentation illustrations on Windows with System.Drawing.
# No application database or browser is used.
Add-Type -AssemblyName System.Drawing
$ErrorActionPreference = 'Stop'
function New-Canvas([int]$Height) {
    $script:canvas = [Drawing.Bitmap]::new(1440, $Height)
    $script:graphics = [Drawing.Graphics]::FromImage($script:canvas)
    $script:graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $script:graphics.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    $script:graphics.Clear([Drawing.ColorTranslator]::FromHtml('#F3F6F3'))
}
function Box([int]$X, [int]$Y, [int]$Width, [int]$Height, [string]$Color) {
    $brush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($Color))
    $script:graphics.FillRectangle($brush, $X, $Y, $Width, $Height)
    $brush.Dispose()
}
function Label([string]$Text, [int]$X, [int]$Y, [int]$Size = 24, [string]$Color = '#203A35', [int]$Width = 1300) {
    $font = [Drawing.Font]::new('Tahoma', $Size, [Drawing.FontStyle]::Regular, [Drawing.GraphicsUnit]::Pixel)
    $brush = [Drawing.SolidBrush]::new([Drawing.ColorTranslator]::FromHtml($Color))
    $script:graphics.DrawString($Text, $font, $brush, [Drawing.RectangleF]::new($X, $Y, $Width, 150))
    $font.Dispose(); $brush.Dispose()
}
function Save-Canvas([string]$Name) {
    $script:canvas.Save((Join-Path $PSScriptRoot $Name), [Drawing.Imaging.ImageFormat]::Png)
    $script:graphics.Dispose(); $script:canvas.Dispose()
}
New-Canvas 790
Label 'จาก starter สู่เว็บใหม่ของคุณ' 54 34 40
Label 'หนึ่งแอป = หนึ่ง repository + หนึ่งฐานข้อมูล' 56 96 25 '#647770'
$steps = @(
    @('01', 'สร้าง repo ใหม่', "Use this template`nตั้งชื่อเว็บที่ต้องการ"),
    @('02', 'Clone ลงเครื่อง', "ตรวจ origin ให้ตรง repo ใหม่`nไม่คัดลอกฐานข้อมูลเดิม"),
    @('03', 'เปิดใน Codex', "เลือกโฟลเดอร์แอปใหม่`nอ่าน AGENTS.md และ docs"),
    @('04', 'ส่งโจทย์ของเว็บ', "ฟิลด์ + ขั้นตอน + สิทธิ์`nระบุกฎและเกณฑ์ตรวจรับ"),
    @('05', 'พัฒนาและทดสอบ', "ข้อมูลสมมติ + API tests`nตรวจ desktop และมือถือ"),
    @('06', 'เริ่มใช้งานแอป', "Setup บัญชีและฐานข้อมูลใหม่`nบันทึกงานและ HANDOFF")
)
for ($i = 0; $i -lt $steps.Count; $i++) {
    $x = 54 + ($i % 3) * 454
    $y = 174 + [Math]::Floor($i / 3) * 260
    Box $x $y 424 224 '#FFFFFF'
    Box $x $y 7 224 '#156859'
    Label $steps[$i][0] ($x + 26) ($y + 18) 28 '#156859' 360
    Label $steps[$i][1] ($x + 26) ($y + 66) 29 '#203A35' 360
    Label $steps[$i][2] ($x + 26) ($y + 122) 23 '#647770' 366
}
Label 'อ่านจากซ้ายไปขวาทีละแถว  •  การเผยแพร่ขึ้นโฮสต์เป็นขั้นตอนแยกหลังทดสอบ' 56 721 24 '#647770'
Save-Canvas 'bootstrap-workflow.png'

New-Canvas 750
Label 'ใครทำอะไรได้ใน starter' 54 34 40
Label 'บัญชีที่ active และเข้าสู่ระบบ ใช้ข้อมูลรายการร่วมกันภายในทีม' 56 96 25 '#647770'
$rows = @(
    @('ผู้ใช้', 'อ่านรายการ', 'เพิ่ม / แก้ไข / ลบ', 'จัดการสมาชิก'),
    @('Guest', 'ไม่ได้', 'ไม่ได้', 'ไม่ได้'),
    @('viewer', 'ได้', 'ไม่ได้', 'ไม่ได้'),
    @('editor', 'ได้', 'ได้', 'ไม่ได้'),
    @('admin', 'ได้', 'ได้', 'บัญชีอื่นเท่านั้น')
)
$columns = @(78, 364, 669, 1054)
for ($r = 0; $r -lt $rows.Count; $r++) {
    $rowY = 170 + $r * 76
    $color = if ($r -eq 0) { '#156859' } elseif ($r % 2) { '#FFFFFF' } else { '#E7EFE9' }
    $textColor = if ($r -eq 0) { '#FFFFFF' } else { '#203A35' }
    Box 54 $rowY 1332 74 $color
    for ($c = 0; $c -lt 4; $c++) { Label $rows[$r][$c] $columns[$c] ($rowY + 20) 26 $textColor 325 }
}
Box 54 584 1332 110 '#DEEDE5'
Label 'PocketBase superuser ใช้ที่ dashboard /_/' 78 600 27 '#156859'
Label 'ใช้ดูแลฐานข้อมูลและกู้บัญชี  •  บัญชีหน้าเว็บอยู่ใน users และไม่ใช่ superuser' 78 644 23 '#203A35'
Label 'สมัครใหม่เป็น viewer  •  Admin แก้ชื่อ / สิทธิ์ / เปิดปิดบัญชีอื่นได้' 56 710 22 '#647770'
Save-Canvas 'bootstrap-roles.png'
