MIME-Version: 1.0
In-Reply-To: <1450056335-18444-1-git-send-email-fish.thss@...277...>
References: <1450055187-17397-1-git-send-email-fish.thss@...277...>
	<1450056335-18444-1-git-send-email-fish.thss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 14 Dec 2015 12:01:18 -0500
Message-ID: <CAKuzo_jwN79GhubM4Dgp4=dnZwJVvTiEMEzUp4k-FWBqQ2dwPA@...278...>
Content-Type: multipart/alternative; boundary=089e012298ec564b3b0526dea0d6
Subject: Re: [Openvpn-devel] [PATCH] Make "block-outside-dns" option
	platform agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e012298ec564b3b0526dea0d6
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Dec 13, 2015 at 8:25 PM, Fish <fish.thss@...277...> wrote:

> Make the "block-outside-dns" option agnostic of Windows versions by
> dynamically
> loading WFP-related functions. Cross-compiled on Linux and tested on
> Windows
> XP/10.
> ---
>  src/openvpn/Makefile.am |   2 +-
>  src/openvpn/init.c      |   4 -
>  src/openvpn/options.c   |  17 ++-
>  src/openvpn/win32.c     | 114 ++++++++-------
>  src/openvpn/win32.h     |   1 +
>  src/openvpn/win32_wfp.h | 359
> ++++++++++++++++++++++++++++++++++++++++++++++++


Looks good, including the attribution to the right mingw upstream..

But won't build, as the new header (win32_wfp.h) is not added to
src/openvpn/Makefile.am --- without that it wont get into the
dist tarball etc..

Next time please append a version number to the mail header:
something like [PATCH v2] would do. I'm getting confused with
too many versions :)

Thanks,

Selva

--089e012298ec564b3b0526dea0d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Dec 13, 2015 at 8:25 PM, Fi=
sh <span dir=3D"ltr">&lt;<a href=3D"mailto:fish.thss@...277..." target=3D"_=
blank">fish.thss@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span>Make the &quot;block-outside-dns&quot; option agnostic of Win=
dows versions by dynamically<br>
loading WFP-related functions. Cross-compiled on Linux and tested on Window=
s<br>
XP/10.<br>
---<br>
=C2=A0src/openvpn/Makefile.am |=C2=A0 =C2=A02 +-<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 -<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0|=C2=A0 17 ++-<br>
=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0| 114 ++++++++-------<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
</span>=C2=A0src/openvpn/win32_wfp.h | 359 ++++++++++++++++++++++++++++++++=
++++++++++++++++</blockquote></div><br></div><div class=3D"gmail_extra">Loo=
ks good, including the attribution to the right mingw upstream..<br><br></d=
iv><div class=3D"gmail_extra">But won&#39;t build, as the new header (win32=
_wfp.h) is not added to <br>src/openvpn/Makefile.am --- without that it won=
t get into the <br>dist tarball etc..<br><br>Next time please append a vers=
ion number to the mail header: <br>something like [PATCH v2] would do. I&#3=
9;m getting confused with <br>too many versions :)<br></div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">Thanks,<br><br></div><div =
class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra"><br></div></div>

--089e012298ec564b3b0526dea0d6--

