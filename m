MIME-Version: 1.0
In-Reply-To: <CAKuzo_iuc6HAJJv6ec99TiUYSpcSichHJfD50an9s9EtZQ=1Hw@...278...>
References: <1463195570-27908-1-git-send-email-selva.nair@...277...>
	<CAKuzo_iuc6HAJJv6ec99TiUYSpcSichHJfD50an9s9EtZQ=1Hw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 May 2016 00:45:49 -0400
Message-ID: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
Content-Type: multipart/alternative; boundary=001a11448a9e9ce67a053367002a
Subject: Re: [Openvpn-devel] [PATCH (master)] Properly handle possible
	realloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11448a9e9ce67a053367002a
Content-Type: text/plain; charset=UTF-8

On Sat, May 14, 2016 at 8:31 AM, Selva Nair <selva.nair@...277...> wrote:

> On Fri, May 13, 2016 at 11:12 PM, Selva Nair <selva.nair@...277...> wrote:
>
>> ---
>>  src/openvpnserv/interactive.c |   10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>
>
> Please ignore this patch. It is broken -- patch made prematurely before a
> fixup was committed,
>

While redoing this patch I tested what actually happens on malloc or realloc
failure and found a real bug. The patch in the next email addresses that.

Selva

--001a11448a9e9ce67a053367002a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, May 14, 2016 at 8:31 AM, <span>Selva</span> Nair <span dir=3D"ltr">=
&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank"><span>selva</=
span>.<span>nair</span>@gmail.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><span><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Fri, May 13, 2016 at 11:12 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>---<br>
=C2=A0src/openvpnserv/interactive.c |=C2=A0 =C2=A010 +++++++---<br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)</div></blockquote></d=
iv><br><br></div></span><div class=3D"gmail_extra">Please ignore this patch=
. It is broken -- patch made prematurely before a fixup was committed,</div=
></blockquote></div><br>While redoing this patch I tested what actually hap=
pens on <span>malloc</span> or <span>realloc</span> failure and found a rea=
l bug. The patch in the next email addresses that.<br><br></div><div class=
=3D"gmail_extra"><span>Selva</span><br></div></div>

--001a11448a9e9ce67a053367002a--

