MIME-Version: 1.0
From: Rafael Gava <gava100@...277...>
Date: Tue, 18 Aug 2020 00:06:18 -0300
Message-ID: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000006c1efe05ad1e2ca9"
Subject: [Openvpn-devel]  2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000006c1efe05ad1e2ca9
Content-Type: text/plain; charset="UTF-8"

Hello Everyone

Could you please give me an insight of what is going here... :-)

I'm trying to use and test the openvpn version 2.5_beta1 with the wintun
interface on a windows 10 machine based on a release built from the source
code.
In order to do that, I'm using the openvpn-vagrant with the
openvpn-build-bionic vm to generate a nsis installer. Well, so far, I'm
building an unsigned release.
After setting the environment variables, downloading the code and running
the ./openvpn-build/windows-nsis/build-complete script, the compilation
completes successfully and an exe file is generated.

In a Windows 10 machine, the installation of this generated exe runs ok but
when I try to connect to a server from the Openvpn-GUI using the wintun
interface, I always get the following error:

2020-08-17 19:15:39 us=419470 Outgoing Data Channel: Using 160 bit message
hash 'SHA1' for HMAC authentication
2020-08-17 19:15:39 us=419470 Incoming Data Channel: Cipher 'BF-CBC'
initialized with 128 bit key
2020-08-17 19:15:39 us=419470 WARNING: INSECURE cipher (BF-CBC) with block
size less than 128 bit (64 bit).  This allows attacks like SWEET32.
Mitigate by using a --cipher with a larger block size (e.g. AES-256-CBC).
Support for these insecure ciphers will be removed in OpenVPN 2.6.
2020-08-17 19:15:39 us=419470 Incoming Data Channel: Using 160 bit message
hash 'SHA1' for HMAC authentication
2020-08-17 19:15:39 us=419470 WARNING: cipher with small block size in use,
reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.
2020-08-17 19:15:39 us=419470 interactive service msg_channel=0
2020-08-17 19:15:39 us=421471 ROUTE_GATEWAY 10.1.1.1/255.255.0.0 I=10
HWADDR=92:e9:37:4c:bb:99
2020-08-17 19:15:39 us=421471 open_tun
2020-08-17 19:15:39 us=424470 MANAGEMENT: Client disconnected
2020-08-17 19:15:39 us=424470 ERROR:  Wintun requires SYSTEM privileges and
therefore should be used with interactive service. If you want to use
openvpn from the command line, you need to do SYSTEM elevation yourself
(for example with psexec).
2020-08-17 19:15:39 us=424470 Exiting due to fatal error

It seems that the openvpn.exe is unable to open the pipe with the
Interactive Service (interactive service msg_channel=0). If I download and
install the OpenVPN-2.5-beta.msi from the openvpn.net, wintun works
perfectly.

So, now is the point that I'm stuck. What am I doing wrong or missing?

Moreover, I have a couple questions that you guys might help:

1) Is there any problem in using openvpn with the wintun interface from an
unsigned built release?
2) Is there any problem with wintun in using an unsigned nsis installer
than the .msi one?
3) I'm also trying to generate a msi installer with vagrant msibuilder but
I'm getting the following error:

PS O:\windows-msi> cscript build.wsf msi
Microsoft (R) Windows Script Host Version 5.812
Copyright (C) Microsoft Corporation. All rights reserved.

BUILD: tmp\x86\msi.wixobj
RUN: "C:\Program Files (x86)\WiX Toolset v3.11\bin\candle.exe" -nologo -ext
WixNetFxExtension -arch "x86" -dPRODUCT_PUBLISHER="OpenVPN Technologies,
Inc." -dPRODUCT_NAME="OpenVPN" -dPRODUCT_VERSION="2.5.003"
-dPACKAGE_VERSION="2.5-20200304" -dPRODUCT_TAP_WIN_NAME="TAP-Windows"
-dPRODUCT_TAP_WIN_COMPONENT_ID="tap0901" -dPRODUCT_PLATFORM="x86"
-dPRODUCT_CODE="
{E5931AF4-2A8F-48A5-AFC8-E996BB49D024}"
-dUPGRADE_CODE="{1195A47B-A37A-4055-9D34-B7A691F7E97B}"
-dCONFIG_EXTENSION="ovpn" -dPROGRAM_FILES_DIR="ProgramFilesFolder"
-dOPENSSL_PLAT="" -out "tmp\x86\msi.wixobj" "msi.wxs"
msi.wxs
O:\windows-msi\msi.wxs(724) : error CNDL0104 : Not a valid source file;
detail: 'yes' is an unexpected token. Expecting
white space. Line 724, position 157.

O:\windows-msi\build.wsf(163, 20) Microsoft JScript runtime error: WiX
compiler returned non-zero.

PS O:\windows-msi>

Please, any help is very welcome!

Thanks in Advance

Rafael

--0000000000006c1efe05ad1e2ca9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Everyone<br><br>Could you please give me an insight =
of what is going here... :-)<br><br>I&#39;m trying to use and test the open=
vpn version 2.5_beta1 with the wintun interface on a windows 10 machine bas=
ed on a release built from the source code.<br>In order to do that, I&#39;m=
 using the openvpn-vagrant with the openvpn-build-bionic vm to generate a n=
sis installer. Well, so far, I&#39;m building an unsigned release.<br>After=
 setting the environment variables, downloading the code and running the ./=
openvpn-build/windows-nsis/build-complete script, the compilation completes=
=C2=A0successfully and an exe file is generated.<br><br>In a Windows 10 mac=
hine, the installation of this generated exe runs ok but when I try to conn=
ect to a server from the Openvpn-GUI using the wintun interface, I always g=
et the following error:<br><br>		2020-08-17 19:15:39 us=3D419470 Outgoing D=
ata Channel: Using 160 bit message hash &#39;SHA1&#39; for HMAC authenticat=
ion<br>		2020-08-17 19:15:39 us=3D419470 Incoming Data Channel: Cipher &#39=
;BF-CBC&#39; initialized with 128 bit key<br>		2020-08-17 19:15:39 us=3D419=
470 WARNING: INSECURE cipher (BF-CBC) with block size less than 128 bit (64=
 bit).=C2=A0 This allows attacks like SWEET32.=C2=A0 Mitigate by using a --=
cipher with a larger block size (e.g. AES-256-CBC). Support for these insec=
ure ciphers will be removed in OpenVPN 2.6.<br>		2020-08-17 19:15:39 us=3D4=
19470 Incoming Data Channel: Using 160 bit message hash &#39;SHA1&#39; for =
HMAC authentication<br>		2020-08-17 19:15:39 us=3D419470 WARNING: cipher wi=
th small block size in use, reducing reneg-bytes to 64MB to mitigate SWEET3=
2 attacks.<br>		2020-08-17 19:15:39 us=3D419470 interactive service msg_cha=
nnel=3D0<br>		2020-08-17 19:15:39 us=3D421471 ROUTE_GATEWAY <a href=3D"http=
://10.1.1.1/255.255.0.0">10.1.1.1/255.255.0.0</a> I=3D10 HWADDR=3D92:e9:37:=
4c:bb:99<br>		2020-08-17 19:15:39 us=3D421471 open_tun<br>		2020-08-17 19:1=
5:39 us=3D424470 MANAGEMENT: Client disconnected<br>		2020-08-17 19:15:39 u=
s=3D424470 ERROR: =C2=A0Wintun requires SYSTEM privileges and therefore sho=
uld be used with interactive service. If you want to use openvpn from the c=
ommand line, you need to do SYSTEM elevation yourself (for example with pse=
xec).<br>		2020-08-17 19:15:39 us=3D424470 Exiting due to fatal error<br><b=
r>It seems that the openvpn.exe is unable to open the pipe with the Interac=
tive Service (interactive service msg_channel=3D0). If I download and insta=
ll the OpenVPN-2.5-beta.msi from the <a href=3D"http://openvpn.net">openvpn=
.net</a>, wintun works perfectly.<br><br>So, now is the point that I&#39;m =
stuck. What am I doing wrong or missing?<br><br>Moreover, I have a couple q=
uestions that you guys might help:<br><br>	1) Is there any problem in using=
 openvpn with the wintun interface from an unsigned built release? <br>	2) =
Is there any problem with wintun in using an unsigned nsis installer than t=
he .msi one?<br>	3) I&#39;m also trying to generate a msi installer with va=
grant msibuilder but I&#39;m getting the following error:<br>	<br>		PS O:\w=
indows-msi&gt; cscript build.wsf msi<br>		Microsoft (R) Windows Script Host=
 Version 5.812<br>		Copyright (C) Microsoft Corporation. All rights reserve=
d.<br><br>		BUILD: tmp\x86\msi.wixobj<br>		RUN: &quot;C:\Program Files (x86=
)\WiX Toolset v3.11\bin\candle.exe&quot; -nologo -ext WixNetFxExtension -ar=
ch &quot;x86&quot; -dPRODUCT_PUBLISHER=3D&quot;OpenVPN Technologies, Inc.&q=
uot; -dPRODUCT_NAME=3D&quot;OpenVPN&quot; -dPRODUCT_VERSION=3D&quot;2.5.003=
&quot; -dPACKAGE_VERSION=3D&quot;2.5-20200304&quot; -dPRODUCT_TAP_WIN_NAME=
=3D&quot;TAP-Windows&quot; -dPRODUCT_TAP_WIN_COMPONENT_ID=3D&quot;tap0901&q=
uot; -dPRODUCT_PLATFORM=3D&quot;x86&quot; -dPRODUCT_CODE=3D&quot;<br>		{E59=
31AF4-2A8F-48A5-AFC8-E996BB49D024}&quot; -dUPGRADE_CODE=3D&quot;{1195A47B-A=
37A-4055-9D34-B7A691F7E97B}&quot; -dCONFIG_EXTENSION=3D&quot;ovpn&quot; -dP=
ROGRAM_FILES_DIR=3D&quot;ProgramFilesFolder&quot; -dOPENSSL_PLAT=3D&quot;&q=
uot; -out &quot;tmp\x86\msi.wixobj&quot; &quot;msi.wxs&quot;<br>		msi.wxs<b=
r>		O:\windows-msi\msi.wxs(724) : error CNDL0104 : Not a valid source file;=
 detail: &#39;yes&#39; is an unexpected token. Expecting<br>		white space. =
Line 724, position 157.<br><br>		O:\windows-msi\build.wsf(163, 20) Microsof=
t JScript runtime error: WiX compiler returned non-zero.<br><br>		PS O:\win=
dows-msi&gt;<br><br>Please, any help is very welcome!<br><br>Thanks in Adva=
nce<br><br>Rafael<br><br>	<br></div>

--0000000000006c1efe05ad1e2ca9--

