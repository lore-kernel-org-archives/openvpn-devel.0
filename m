References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
	<20151125075416.GR24952@...1296...>
	<CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5655C387.40805@...1227...>
Date: Wed, 25 Nov 2015 15:19:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>
Content-Type: multipart/alternative;
	boundary="------------020900010300090808040506"
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020900010300090808040506
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 25.11.15 um 15:15 schrieb Selva Nair:
> Hi,
>
> On Wed, Nov 25, 2015 at 2:54 AM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Wed, Nov 25, 2015 at 08:31:23AM +0300, ValdikSS wrote:
>     > I need help with 2.3 build system. While the code itself would
>     compile fine, it won't link because I can't figure out how to link
>     libraries available in vista+
>     > only for vista+ build and do not link it for XP.
>
>     Cross-build using ubuntu 14.04 and mingw64, and run configure with
>     "configure ... LIBS='-lwhatyouneed'" for the vista+ build.
>
>     For 2.3, that should be good enough.
>
>
> Aha, so original question about building for winxp is probably related
> to the extra libs added to Makefile.am?  I think it should not be
> there in the patch for 2.3 so that the code builds cleanly for XP+
> with the current 2.3 build setup. Then build specially for vista+ as
> Gert wrote above.

I am not sure if we want to ship separate WIN XP and Vista+ versions.

Arne

--------------020900010300090808040506
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <br>
    <div class=3D"moz-cite-prefix">Am 25.11.15 um 15:15 schrieb Selva
      Nair:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=3D97cfo0-uzeMFQKki3sWg@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">Hi,<br>
          <br>
        </div>
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Wed, Nov 25, 2015 at 2:54 AM, Gert
            Doering <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1=
296...</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div id=3D":29m" class=3D"a3s" style=3D"overflow:hidden">Hi,<=
br>
                <span class=3D""><br>
                  On Wed, Nov 25, 2015 at 08:31:23AM +0300, ValdikSS
                  wrote:<br>
                  &gt; I need help with 2.3 build system. While the code
                  itself would compile fine, it won't link because I
                  can't figure out how to link libraries available in
                  vista+<br>
                  &gt; only for vista+ build and do not link it for XP.<br>
                  <br>
                </span>Cross-build using ubuntu 14.04 and mingw64, and
                run configure with<br>
                "configure ... LIBS=3D'-lwhatyouneed'" for the vista+
                build.<br>
                <br>
                For 2.3, that should be good enough.</div>
            </blockquote>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">Aha, so original question about
          building for winxp is probably related to the extra libs added
          to Makefile.am?=A0 I think it should not be there in the patch
          for 2.3 so that the code builds cleanly for XP+ with the
          current 2.3 build setup. Then build specially for vista+ as
          Gert wrote above.<br>
        </div>
      </div>
    </blockquote>
    <br>
    I am not sure if we want to ship separate WIN XP and Vista+
    versions.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------020900010300090808040506--

