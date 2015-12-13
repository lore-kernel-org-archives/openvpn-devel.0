MIME-Version: 1.0
In-Reply-To: <1449794790-45430-1-git-send-email-fish.thss@...277...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
	<1449794790-45430-1-git-send-email-fish.thss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 13 Dec 2015 16:13:39 -0500
Message-ID: <CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9ef8d3260526ce0870
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
To: Fish <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443d9ef8d3260526ce0870
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 10, 2015 at 7:46 PM, Fish <fish.thss@...277...> wrote:

> Based on release/2.3 branch and ValdikSS's v9 patch, this patch is
> cross-compiled on Linux and tested on Windows XP/10. The VC project file is
> left untouched - you might want to add rpcrt4.lib to compile and link it
> under
> MSVC.
>

Builds on 2.3 out of the box (i.e., target  WINXP).
The implementation looks fine, and works on win7 and 10, but I've
no XP machines for the crucial test.

A minor suggestion: All those prototypes taken from mingw (32 or -w64?)
may be better placed in new header file to be included only from win32.c --
-- preferably with a license matching the source (PD or ZPL?).  Makes
win32.c less cluttered as well.

I'm not familiar with the policy of OpenVPN on license-related
matters, though.

Selva

--001a11443d9ef8d3260526ce0870
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 7:46 PM, Fi=
sh <span dir=3D"ltr">&lt;<a href=3D"mailto:fish.thss@...277..." target=3D"_=
blank">fish.thss@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div>Based on release/2.3 branch and ValdikSS&#39;s v9 patch, this =
patch is<br>
cross-compiled on Linux and tested on Windows XP/10. The VC project file is=
<br>
left untouched - you might want to add rpcrt4.lib to compile and link it un=
der<br>
MSVC.</div></blockquote></div><br></div><div class=3D"gmail_extra">Builds o=
n 2.3 out of the box (i.e., target=C2=A0 WINXP).<br></div><div class=3D"gma=
il_extra">The implementation looks fine, and works on win7 and 10, but I&#3=
9;ve <br>no XP machines for the crucial test.<br><br></div><div class=3D"gm=
ail_extra">A minor suggestion: All those prototypes taken from mingw (32 or=
 -w64?) <br>may be better placed in new header file to be included only fro=
m win32.c -- <br>-- preferably with a license matching the source (PD or ZP=
L?).=C2=A0 Makes<br>win32.c less cluttered as well. <br><br>I&#39;m not fam=
iliar with the policy of OpenVPN on license-related <br>matters, though.<br=
></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selv=
a<br></div></div>

--001a11443d9ef8d3260526ce0870--

