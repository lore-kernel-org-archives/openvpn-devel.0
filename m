Message-ID: <512E53CA.5070004@...515...>
Date: Wed, 27 Feb 2013 20:43:22 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=-JZpr3=g@...278...>
In-Reply-To: <CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=-JZpr3=g@...278...>
Content-Type: multipart/alternative;
	boundary="------------000000010902080503080300"
Subject: Re: [Openvpn-devel] Problem with compiling openvpn-gui on ubuntu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sagi Gidali <gidalis@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000000010902080503080300
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

You can use openvpn-build to build openvpn and it's dependencies,
including the OpenVPN-GUI - that should just work. Once the build is
finished, you can probably hack the openvpn-build scripts to only build
the GUI.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]
openvpn-build/generic/build
openvpn-build/windows-nsis/build-complete


> Hi All,
>
> I've installed all required programs as written in 1.
>
> apt-get install git-core mingw-w64 gcc-4.6-arm-linux-gnueabi man2html
> dos2unix nsis unzip
>
> Then, I've executed the command ./configure
> --prefix=3D/usr/local/i586-mingw32 --host=3Di586-mingw32msvc inside
> OpenVPN-Gui source folder.
>
> It completed successfully, then when I execute the command make i get
> the following error:
>
> main.c:26:21: fatal error: windows.h: No such file or directory
> compilation terminated.
> make[1]: *** [main.o] Error 1
>
> What I'm doing wrong?
>
> Thanks,
> Sagi
>
> [1] https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuilds=
ystem



--------------000000010902080503080300
Content-Type: text/html; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-15"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      You can use openvpn-build to build openvpn and it's dependencies,
      including the OpenVPN-GUI - that should just work. Once the build
      is finished, you can probably hack the openvpn-build scripts to
      only build the GUI.<br>
      <br>
      Best regards,<br>
      <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
      <br>
      [1]<br>
      openvpn-build/generic/build<br>
      openvpn-build/windows-nsis/build-complete<br>
      <br>
      <br>
    </div>
    <blockquote
cite=3D"mid:CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=3D-JZpr3=3Dg@...1811...=
.."
      type=3D"cite">
      <div dir=3D"ltr">
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">Hi
          All,</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">I've
          installed all required programs as written in 1.</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><span
            style=3D"background-color:rgb(247,247,247);font-size:13px">apt-=
get
            install git-core mingw-w64 gcc-4.6-arm-linux-gnueabi
            man2html dos2unix nsis unzip</span></div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">Then,
          I've executed the command=A0./configure
          --prefix=3D/usr/local/i586-mingw32 --host=3Di586-mingw32msvc
          inside OpenVPN-Gui source folder.</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">It
          completed successfully, then when I execute the command make i
          get the following error:</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">
          <div>main.c:26:21: fatal error: windows.h: No such file or
            directory</div>
          <div>compilation terminated.</div>
          <div>make[1]: *** [main.o] Error 1</div>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">What
          I'm doing wrong?</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">Thanks,</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">Sagi</div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px"><br>
        </div>
        <div
style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-size:12.8000001=
90734863px">[1]=A0<a
            moz-do-not-send=3D"true"
href=3D"https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuil=
dsystem"
            target=3D"_blank">https://community.openvpn.net/openvpn/wiki/Bu=
ildingUsingGenericBuildsystem</a><br>
        </div>
      </div>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------000000010902080503080300--

