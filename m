MIME-Version: 1.0
In-Reply-To: <20170510184753.27145-1-valdikss@...277...>
References: <20170510184753.27145-1-valdikss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 May 2017 15:59:00 -0400
Message-ID: <CAKuzo_h4_KUYUmz7jiZVRqbwWk77bgcfZaNiPuomVOiy1zvLnQ@...278...>
Content-Type: multipart/alternative; boundary=001a113a4084795bbc054f30e8f3
Subject: Re: [Openvpn-devel] [PATCH v2] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: ValdikSS <iam@...2070...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a4084795bbc054f30e8f3
Content-Type: text/plain; charset=UTF-8

On Wed, May 10, 2017 at 2:47 PM, ValdikSS <valdikss@...277...> wrote:

>
> Windows 10 before Creators Update used to resolve DNS using all
> available adapters and IP addresses in parallel. Now it still
> resolves addresses using all available adapters but in a round-robin
> way, beginning with random adapter.
> This behaviour introduces significant delay when block-outside-dns is
> in use. Fortunately, setting low metric for the TAP interface solves
> this issue, making Windows always pick TAP adapter first and disable
> round-robin.
> ---
>  src/openvpn/block_dns.c       | 78 ++++++++++++++++++++++++++++++
> +++++++++++++
>  src/openvpn/block_dns.h       | 30 +++++++++++++++++
>  src/openvpn/init.c            |  4 +--
>  src/openvpn/win32.c           | 39 ++++++++++++++++++++--
>  src/openvpn/win32.h           |  2 +-
>  src/openvpnserv/interactive.c | 70 +++++++++++++++++++++++++++++++++++---
>  6 files changed, 213 insertions(+), 10 deletions(-)



Looks good now.  ACK from me.

Did a quick test on Win7 -- metric changes to 3 and gets restored
independently for v4 and v6. No idea whether this resolves the Win 10 issue,
but should not have any adverse effects except for the metric change
which will also affect the metric of routes added.

Cross compiles without issues for 32 bit and 64 bit -- tested on Debain 8.7
with
mingw32-w64 included in the distribution.

Selva

--001a113a4084795bbc054f30e8f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, May 10, 2017 at 2:47 PM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D"=
mailto:valdikss@...277..." target=3D"_blank">valdikss@...277...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
Windows 10 before Creators Update used to resolve DNS using all<br>
available adapters and IP addresses in parallel. Now it still<br>
resolves addresses using all available adapters but in a round-robin<br>
way, beginning with random adapter.<br>
This behaviour introduces significant delay when block-outside-dns is<br>
in use. Fortunately, setting low metric for the TAP interface solves<br>
</span>this issue, making Windows always pick TAP adapter first and disable=
<br>
round-robin.<br>
---<br>
=C2=A0src/openvpn/block_dns.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 78 ++++++++++++++=
++++++++++++++++<wbr>+++++++++++++<br>
<span class=3D"">=C2=A0src/openvpn/block_dns.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| =
30 +++++++++++++++++<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4=
 +--<br>
</span>=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
39 ++++++++++++++++++++--<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2=
 +-<br>
=C2=A0src/openvpnserv/interactive.c | 70 ++++++++++++++++++++++++++++++<wbr=
>+++++---<br>
=C2=A06 files changed, 213 insertions(+), 10 deletions(-)</blockquote></div=
><br><br></div><div class=3D"gmail_extra">Looks good now.=C2=A0 ACK from me=
.<br><br>Did a quick test on Win7 -- metric changes to 3 and gets restored<=
br>independently for v4 and v6. No idea whether this resolves the Win 10 is=
sue,<br></div><div class=3D"gmail_extra">but should not have any adverse ef=
fects except for the metric change<br>which will also affect the metric of =
routes added.<br></div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Cross compiles without issues for 32 bit and 64 bit -- tested o=
n Debain 8.7 with<br></div><div class=3D"gmail_extra">mingw32-w64 included =
in the distribution.<br><br></div><div class=3D"gmail_extra">Selva<br></div=
></div>

--001a113a4084795bbc054f30e8f3--

