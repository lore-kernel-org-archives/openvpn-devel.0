MIME-Version: 1.0
In-Reply-To: <d7fde34c-2244-aed1-6ecc-9f5c5d9d9b3b@...515...>
References: <d7fde34c-2244-aed1-6ecc-9f5c5d9d9b3b@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Aug 2016 11:03:57 -0400
Message-ID: <CAKuzo_g2_gkXSuQF1hd4s1wGWdwM9eQk5_c_ZRXmSnFWUY+k4g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c09593e6a6375053ad298c5
Subject: Re: [Openvpn-devel] Combined Windows installers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c09593e6a6375053ad298c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 5:26 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> 2) Bundle 32-bit and 64-bit OpenVPN in one installer
>
> Here one would select the installer based on OS (XP or Vista+), but
> bitness would not matter:
>
> - NDIS5 + openvpn i686 + openvpn x86_64
> - NDIS6 + openvpn i686 + openvpn x86_64)
>
>
> 3) Bundle everything together
>
> - NDIS5 + NDIS6 + openvpn i686 + openvpn x86_64)
>
> ---
>
> We discussed this a bit on #openvpn-devel, and option 2 had the most
> votes. The problem with options 1 and 3 is that they'd require changes
> to openvpn-build, which would have to be scrapped when Windows XP and
> tap-windows (NDIS 5) support is dropped. And that is going to happen
> fairly soon.
>
> The 32/64-bit divide, on the other hand, is not disappearing in the near
> future, so having a 32/64-bit combined installer makes sense.
>
> Thoughts?
>

+1 for option (2).

(3) Would have been ideal but as you say it may not be worth the effort as
support for XP will be removed soon... Option (2) looks like a good
compromise. Bundling 64/32 together and choosing the appropriate one would
also mean all 64 bit hosts will get 64 bit installations -- that is, no
more WoW64 concerns.

Selva

--94eb2c09593e6a6375053ad298c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Aug 24, 2016 at 5:26 AM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt=
;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div>2) Bundle 32-bit and 64-bit Ope=
nVPN in one installer<br>
<br>
Here one would select the installer based on OS (XP or Vista+), but<br>
bitness would not matter:<br>
<br>
- NDIS5 + openvpn i686 + openvpn x86_64<br>
- NDIS6 + openvpn i686 + openvpn x86_64)<br>
<br>
<br>
3) Bundle everything together<br>
<br>
- NDIS5 + NDIS6 + openvpn i686 + openvpn x86_64)<br>
<br>
---<br>
<br>
We discussed this a bit on #openvpn-devel, and option 2 had the most<br>
votes. The problem with options 1 and 3 is that they&#39;d require changes<=
br>
to openvpn-build, which would have to be scrapped when Windows XP and<br>
tap-windows (NDIS 5) support is dropped. And that is going to happen<br>
fairly soon.<br>
<br>
The 32/64-bit divide, on the other hand, is not disappearing in the near<br>
future, so having a 32/64-bit combined installer makes sense.</div><div><br=
></div><div>Thoughts?</div></blockquote></div><div class=3D"gmail_extra"><b=
r></div>+1 for option (2).</div><div class=3D"gmail_extra"><br>(3) Would ha=
ve been ideal but as you say it may not be worth the effort as support for =
XP will be removed soon... Option (2) looks like a good compromise. Bundlin=
g 64/32 together and choosing the appropriate one would also mean all 64 bi=
t hosts will get 64 bit installations -- that is, no more WoW64 concerns.</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</=
div></div>

--94eb2c09593e6a6375053ad298c5--

