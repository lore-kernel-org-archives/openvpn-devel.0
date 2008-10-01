Message-Id: <48E3FF17.7D5B.00BC.0@...1133...>
Date: Wed, 01 Oct 2008 22:55:00 +0200
From: "Svein Hansen" <Svein.Hansen@...1133...>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part94BD32B4.0__="
Subject: [Openvpn-devel] Req: UAC in Vista and updated prebuilds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part94BD32B4.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi 

  

Two requests: 

  

1:  Prebuilt openvpn for RC12 (and upcoming releases) 

I want to include my own configuration files in the installer. 

Can someone upload to: https://secure.openvpn.net/devel/ when a new
release/bugfix is released? 

Please... 

  

2: Add support for UAC(if:enabled) in Vista: Set "RUNASADMIN" for the
GUI in the installer. 

(When connecting to OpenVPN in Vista I need admin-rights to set routes.)


I have included some code in the openvpn.nsi, but i don't know if this
is the best way to solve the problem.  

  

; tap-64bit: 

  

  DetailPrint "We are running on a 64-bit system."
  SetRegView 64
  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
  SetRegView 32 

  

  SetOutPath "$INSTDIR\bin" 

  

  File "${GEN}\tapinstall\amd64\tapinstall.exe" 

  

  SetOutPath "$INSTDIR\driver" 

  

  File "${GEN}\driver\amd64\OemWin2k.inf"
  File "${GEN}\driver\amd64\${PRODUCT_TAP_ID}.cat"
  File "${GEN}\driver\amd64\${TAPDRV}" 

  

goto tapend 

  

tap-32bit: 

  

  DetailPrint "We are running on a 32-bit system."
  WriteRegStr HKLM "Software\Microsoft\Windows
NT\CurrentVersion\AppCompatFlags\Layers"
"$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN" 

  

  SetOutPath "$INSTDIR\bin"
  File "${GEN}\tapinstall\i386\tapinstall.exe" 

  

  SetOutPath "$INSTDIR\driver"
  File "${GEN}\driver\i386\OemWin2k.inf"
  File "${GEN}\driver\i386\${PRODUCT_TAP_ID}.cat"
  File "${GEN}\driver\i386\${TAPDRV}" 

  

  tapend: 

  

This works on both 32- and 64-bit Vista 

(I can't see that this would cause problems for XP) 

So my question is: 

Can this be included in the source? 

  

Svein Hansen 


--=__Part94BD32B4.0__=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<html>
  <head>
    <style type=3D"text/css">
      <!--
        body { margin-bottom: 1px; margin-top: 4px; margin-right: 4px; marg=
in-left: 4px; line-height: normal; font-variant: normal }
        p { margin-top: 0; margin-bottom: 0 }
      -->
    </style>
=20=20=20=20
  </head>
  <body style=3D"margin-top: 4px; margin-bottom: 1px; font-size: 10pt; marg=
in-right: 4px; font-style: normal; margin-left: 4px; line-height: normal; f=
ont-weight: normal; font-family: Segoe UI; font-variant: normal">
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Hi      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Two requests:      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        1:&#160;&nbsp;Prebuilt openvpn for RC12 &#40;and upcoming releases&=
#41;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        I want to include my own configuration files in the installer.     =
 </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Can someone upload to: <a href=3D"https://secure.openvpn.net/devel/=
">https://secure.openvpn.net/devel/</a>&#160;when a new release/bugfix is r=
eleased&#63;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Please...      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        2: Add support for UAC&#40;if:enabled&#41;&#160;in Vista: Set &quot=
;RUNASADMIN&quot; for the&#160;GUI in the installer.      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#40;When connecting to OpenVPN in Vista I need admin-rights to set=
 routes.&#41;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        I have&#160;included some code in the openvpn.nsi&#44; but i don&#3=
9;t know if this is&#160;the best way to&#160;solve the problem.&#160;     =
 </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#59; tap-64bit:      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;DetailPrint &quot;We are running on a 64-bit system.&qu=
ot;<br>&#160;&nbsp;SetRegView 64<br>&#160;&nbsp;WriteRegStr HKLM &quot;Soft=
ware&#92;Microsoft&#92;Windows NT&#92;CurrentVersion&#92;AppCompatFlags&#92=
;Layers&quot; &quot;&#36;INSTDIR&#92;bin&#92;openvpn-gui-1.0.3.exe&quot; &q=
uot;RUNASADMIN&quot;<br>&#160;&nbsp;SetRegView 32      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;SetOutPath &quot;&#36;INSTDIR&#92;bin&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;File &quot;&#36;&#123;GEN&#125;&#92;tapinstall&#92;amd6=
4&#92;tapinstall.exe&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;SetOutPath &quot;&#36;INSTDIR&#92;driver&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;File &quot;&#36;&#123;GEN&#125;&#92;driver&#92;amd64&#9=
2;OemWin2k.inf&quot;<br>&#160;&nbsp;File &quot;&#36;&#123;GEN&#125;&#92;dri=
ver&#92;amd64&#92;&#36;&#123;PRODUCT_TAP_ID&#125;.cat&quot;<br>&#160;&nbsp;=
File &quot;&#36;&#123;GEN&#125;&#92;driver&#92;amd64&#92;&#36;&#123;TAPDRV&=
#125;&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        goto tapend      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        tap-32bit:      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;DetailPrint &quot;We are running on a 32-bit system.&qu=
ot;<br>&#160;&nbsp;WriteRegStr HKLM &quot;Software&#92;Microsoft&#92;Window=
s NT&#92;CurrentVersion&#92;AppCompatFlags&#92;Layers&quot; &quot;&#36;INST=
DIR&#92;bin&#92;openvpn-gui-1.0.3.exe&quot; &quot;RUNASADMIN&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;SetOutPath &quot;&#36;INSTDIR&#92;bin&quot;<br>&#160;&n=
bsp;File &quot;&#36;&#123;GEN&#125;&#92;tapinstall&#92;i386&#92;tapinstall.=
exe&quot;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;SetOutPath &quot;&#36;INSTDIR&#92;driver&quot;<br>&#160=
;&nbsp;File &quot;&#36;&#123;GEN&#125;&#92;driver&#92;i386&#92;OemWin2k.inf=
&quot;<br>&#160;&nbsp;File &quot;&#36;&#123;GEN&#125;&#92;driver&#92;i386&#=
92;&#36;&#123;PRODUCT_TAP_ID&#125;.cat&quot;<br>&#160;&nbsp;File &quot;&#36=
;&#123;GEN&#125;&#92;driver&#92;i386&#92;&#36;&#123;TAPDRV&#125;&quot;     =
 </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;&nbsp;tapend:      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        This works on both 32- and 64-bit Vista      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#40;I can&#39;t see that this would&#160;cause problems for XP&#41=
;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        So my question is:      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Can this be included in the source&#63;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        &#160;      </p>
    </div>
    <div>
      <p style=3D"margin-bottom: 0; margin-top: 0">
        Svein Hansen
      </p>
    </div>
  </body>
</html>

--=__Part94BD32B4.0__=--

