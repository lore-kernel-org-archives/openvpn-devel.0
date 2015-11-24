MIME-Version: 1.0
In-Reply-To: <564DE8B3.9030803@...2070...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 23 Nov 2015 22:07:59 -0500
Message-ID: <CAKuzo_iAXpkCSEOaF+q2EN4=Rav5jf1mjCFh4EXLJG7EtX=PAw@...278...>
Content-Type: multipart/alternative; boundary=001a114b2a524b2a9f052540a770
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
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114b2a524b2a9f052540a770
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Nov 19, 2015 at 10:20 AM, ValdikSS <iam@...2070...> wrote:

> This option blocks all out-of-tunnel communication on TCP/UDP port 53
> (except
> for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.
>

This version looks fine and works as promised (tested on Win 7 and 10).

I'm told many win10 users badly need this, so ACK from me.

Note: The patch appears damaged by the mailer. To test I had to pull the
block-external-dns-master branch (with last
commit 76dddc52cc3da95a0681ca660d264e297bf39039)
from https://github.com/ValdikSS/openvpn-with-patches

Selva

--001a114b2a524b2a9f052540a770
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Nov 19, 2015 at 10:20 AM, Valdi=
kSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blan=
k">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div style=3D"o=
verflow:hidden">This option blocks all out-of-tunnel communication on TCP/U=
DP port 53 (except<br>
for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.</div></blo=
ckquote></div><div class=3D"gmail_extra"><br></div>This version looks fine =
and works as promised (tested on Win 7 and 10).=C2=A0</div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">I&#39;m told many win10 use=
rs badly need this, so ACK from me.</div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Note: The patch ap=
pears damaged by the mailer. To test I had to pull the=C2=A0</div><div clas=
s=3D"gmail_extra">block-external-dns-master branch (with last commit=C2=A07=
6dddc52cc3da95a0681ca660d264e297bf39039)</div></div><div class=3D"gmail_ext=
ra">from=C2=A0<a href=3D"https://github.com/ValdikSS/openvpn-with-patches" =
target=3D"_blank">https://github.com/ValdikSS/openvpn-with-patches</a></div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div=
></div>

--001a114b2a524b2a9f052540a770--

