MIME-Version: 1.0
Date: Mon, 25 Feb 2013 14:19:10 +0200
Message-ID: <CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=-JZpr3=g@...278...>
From: Sagi Gidali <gidalis@...277...>
Content-Type: multipart/alternative; boundary=f46d04428cfc64fed904d68b8cdb
Subject: [Openvpn-devel] Problem with compiling openvpn-gui on ubuntu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f46d04428cfc64fed904d68b8cdb
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I've installed all required programs as written in 1.

apt-get install git-core mingw-w64 gcc-4.6-arm-linux-gnueabi man2html
dos2unix nsis unzip

Then, I've executed the command ./configure
--prefix=/usr/local/i586-mingw32 --host=i586-mingw32msvc inside OpenVPN-Gui
source folder.

It completed successfully, then when I execute the command make i get the
following error:

main.c:26:21: fatal error: windows.h: No such file or directory
compilation terminated.
make[1]: *** [main.o] Error 1

What I'm doing wrong?

Thanks,
Sagi

[1]
https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem

--f46d04428cfc64fed904d68b8cdb
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:arial,sans-seri=
f;font-size:12.800000190734863px">Hi All,</div><div style=3D"color:rgb(0,0,=
0);font-family:arial,sans-serif;font-size:12.800000190734863px"><br></div><=
div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.800=
000190734863px">
I&#39;ve installed all required programs as written in 1.</div><div style=
=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.800000190734=
863px"><br></div><div style=3D"color:rgb(0,0,0);font-family:arial,sans-seri=
f;font-size:12.800000190734863px">
<span style=3D"background-color:rgb(247,247,247);font-size:13px">apt-get in=
stall git-core mingw-w64 gcc-4.6-arm-linux-gnueabi man2html dos2unix nsis u=
nzip</span></div><div style=3D"color:rgb(0,0,0);font-family:arial,sans-seri=
f;font-size:12.800000190734863px">
<br></div><div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-=
size:12.800000190734863px">Then, I&#39;ve executed the command=A0./configur=
e --prefix=3D/usr/local/i586-mingw32 --host=3Di586-mingw32msvc inside OpenV=
PN-Gui source folder.</div>
<div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.80=
0000190734863px"><br></div><div style=3D"color:rgb(0,0,0);font-family:arial=
,sans-serif;font-size:12.800000190734863px">It completed successfully, then=
 when I execute the command make i get the following error:</div>
<div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.80=
0000190734863px"><br></div><div style=3D"color:rgb(0,0,0);font-family:arial=
,sans-serif;font-size:12.800000190734863px"><div>main.c:26:21: fatal error:=
 windows.h: No such file or directory</div>
<div>compilation terminated.</div><div>make[1]: *** [main.o] Error 1</div><=
/div><div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:=
12.800000190734863px"><br></div><div style=3D"color:rgb(0,0,0);font-family:=
arial,sans-serif;font-size:12.800000190734863px">
What I&#39;m doing wrong?</div><div style=3D"color:rgb(0,0,0);font-family:a=
rial,sans-serif;font-size:12.800000190734863px"><br></div><div style=3D"col=
or:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.800000190734863px">
Thanks,</div><div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;fo=
nt-size:12.800000190734863px">Sagi</div><div style=3D"color:rgb(0,0,0);font=
-family:arial,sans-serif;font-size:12.800000190734863px"><br></div><div sty=
le=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001907=
34863px">
[1]=A0<a href=3D"https://community.openvpn.net/openvpn/wiki/BuildingUsingGe=
nericBuildsystem" target=3D"_blank">https://community.openvpn.net/openvpn/w=
iki/BuildingUsingGenericBuildsystem</a><br></div></div>

--f46d04428cfc64fed904d68b8cdb--

