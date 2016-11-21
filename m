MIME-Version: 1.0
In-Reply-To: <201611211618.uALGIWgC023644@...2054...>
References: <1479676734-21630-1-git-send-email-selva.nair@...277...>
	<201611211618.uALGIWgC023644@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Nov 2016 17:17:10 -0500
Message-ID: <CAKuzo_g8yiAsBsoVViFwSxOu8xokgT3GY=taa9-NuF=v+r2u+Q@...278...>
Content-Type: multipart/alternative; boundary=001a1149b9a88fe37d0541d705ab
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Do not set ipv6 address if
 '--ip-win32 manual' is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149b9a88fe37d0541d705ab
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 21, 2016 at 11:18 AM, Gert Doering <gert@...1296...> wrote:

> This solves the issue at hand for the time being, without breaking
> people's configs by removing "ip-win32 manual", and without changing
> expectations "how things work on Windows".
>
> For 2.5, we should look at removing the "ip-win32 manual" code path (and
> maybe map it in the other direction, setting "--ifconfig_nexec" instead)
>
> Your patch has been applied to the master branch.
>

While this skips setting the ipv6 address when --ifconfig-noexec is in use,
the code still tries to delete the ipv6 address and fails during SIGHUP
restarts. Its a non-fatal failure, so ignore for now?

Selva

--001a1149b9a88fe37d0541d705ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Nov 21, 2016 at 11:18 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div id=3D":3xb" class=3D"a3s a=
XjCH m15887ae97f753a72">This solves the issue at hand for the time being, w=
ithout breaking<br>
people&#39;s configs by removing &quot;<span class=3D"il">ip</span>-<span c=
lass=3D"il">win32</span> manual&quot;, and without changing<br>
expectations &quot;how things work on Windows&quot;.<br>
<br>
For 2.5, we should look at removing the &quot;<span class=3D"il">ip</span>-=
<span class=3D"il">win32</span> manual&quot; code path (and<br>
maybe map it in the other direction, setting &quot;--ifconfig_nexec&quot; i=
nstead)<br>
<br>
Your patch has been applied to the master branch.</div></blockquote></div><=
br>While this skips setting the ipv6 address when --ifconfig-noexec is in u=
se, the code still tries to delete the ipv6 address and fails during SIGHUP=
 restarts. Its a non-fatal failure, so ignore for now?</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a1149b9a88fe37d0541d705ab--

