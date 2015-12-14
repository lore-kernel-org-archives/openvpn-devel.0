MIME-Version: 1.0
In-Reply-To: <014001d13605$2dec6ae0$89c540a0$@gmail.com>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
	<1449794790-45430-1-git-send-email-fish.thss@...277...>
	<CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
	<014001d13605$2dec6ae0$89c540a0$@gmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 13 Dec 2015 20:08:42 -0500
Message-ID: <CAKuzo_imF4mU8Qp9j_MtnKXS4VTP983htXyXQ9E_ZbOn7KsZaw@...278...>
Content-Type: multipart/alternative; boundary=047d7ba97a888f74100526d151b7
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
	agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7ba97a888f74100526d151b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 13, 2015 at 7:20 PM, Fish Wang <fish.thss@...277...> wrote:

> Will do. However, I=E2=80=99m by no means a license expert. Based on Lice=
nsing
> Terms page on MinGW=E2=80=99s website ([1], win32api), I believe the code=
 I
> stripped out of MinGW should be fine as long as a copy of the notice and
> its license [2] is included. Please correct me if I=E2=80=99m wrong.


I thought those headers are from the mingw-w64 (a different code base
from mingw32)..

Anyway, I did not mean to imply any licensing issues with extracting
parts from mingw32 or mingw-w64 --- both have permissive licenses
so there is no clash. However, some GPL projects have clear guidelines
of how to incorporate code from other licenses.

Personally I prefer to keep public domain code (and minor edits to it)
in a  separate file which clearly indicates its in PD with the original
notice so that one wouldn't slap on a GPL header on it later. While
some projects want all their additions to be GPL keeping the original
in PD etc..(Fro example, see various practices disscussed in
https://www.softwarefreedom.org/resources/2007/gpl-non-gpl-collaboration.pdf
).

Better wait for a core developer to comment on this..

Selva

--047d7ba97a888f74100526d151b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Dec 13, 2015 at 7:20 PM, Fi=
sh Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:fish.thss@...277..." target=
=3D"_blank">fish.thss@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Will do. However, I=E2=80=99m by no means =
a license expert. Based on Licensing Terms page on MinGW=E2=80=99s website =
([1], win32api), I believe the code I stripped out of MinGW should be fine =
as long as a copy of the notice and its license [2] is included. Please cor=
rect me if I=E2=80=99m wrong.</blockquote></div><br>I thought those headers=
 are from the mingw-w64 (a different code base<br>from mingw32).. <br><br>A=
nyway, I did not mean to imply any licensing issues with extracting <br>par=
ts from mingw32 or mingw-w64 --- both have permissive licenses <br>so there=
 is no clash. However, some GPL projects have clear guidelines <br>of how t=
o incorporate code from other licenses. <br><br>Personally I prefer to keep=
 public domain code (and minor edits to it) <br>in a=C2=A0 separate file wh=
ich clearly indicates its in PD with the original <br>notice so that one wo=
uldn&#39;t slap on a GPL header on it later. While <br>some projects want a=
ll their additions to be GPL keeping the original <br>in PD etc..(Fro examp=
le, see various practices disscussed in=C2=A0 <br><a href=3D"https://www.so=
ftwarefreedom.org/resources/2007/gpl-non-gpl-collaboration.pdf" target=3D"_=
blank">https://www.softwarefreedom.org/resources/2007/gpl-non-gpl-collabora=
tion.pdf</a>).<br><br></div><div class=3D"gmail_extra">Better wait for a co=
re developer to comment on this..<br><br></div><div class=3D"gmail_extra">S=
elva<br></div></div>

--047d7ba97a888f74100526d151b7--

