MIME-Version: 1.0
In-Reply-To: <f4082329-79a1-06c0-5ad3-662364caeb3f@...277...>
References: <f4082329-79a1-06c0-5ad3-662364caeb3f@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Aug 2016 10:54:01 -0400
Message-ID: <CAKuzo_hHgxKBM5d6_21LeY6x0KVwLk7DbthGHvNioHntazAnDg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c124e34d3cfc6053a59c166
Subject: Re: [Openvpn-devel] Error: when using --tun-ipv6,
 if you have more than one TAP-Windows adapter,
 you must also specify --dev-node
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c124e34d3cfc6053a59c166
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Aug 18, 2016 at 9:11 AM, debbie10t <debbie10t@...277...> wrote:

> Thu Aug 18 13:54:41 2016 us=240792 MANAGEMENT:
>  >STATE:1471524881,ASSIGN_IP,,10.8.0.6,,,,,12fc:1918::10:8:0:1000
> Thu Aug 18 13:54:41 2016 us=240792 MANAGEMENT: Client disconnected
> Thu Aug 18 13:54:41 2016 us=240792 Error: When using --tun-ipv6, if you
> have more than one TAP-Windows adapter, you must also specify --dev-node
> Thu Aug 18 13:54:41 2016 us=240792 Exiting due to fatal error
>

You are right, the error message is confusing (see below) but what its
trying to say is that _either_ exactly one tap adapter and no --dev-node in
config  _or_ "--dev-node name" with name referring to an existing adapter
is required. That somewhat strange requirement is related to the
"IFCONFIG_BEFORE_TUN" that was mentioned in connection with the
ifconfig-noexec discussion. There is a patch from Heiko for relaxing that
requirement, so hopefully it will get fixed soon..

As for the error message, the code that tries to guess the dev-node fails
in two ways (i) if the specified dev-node is not found or (ii) more than
one TAP adapters are found. When do_ifconfig is called without a "guessed"
adapter name, the error shown is the same regardless of why the guess
failed. Anyway a successful guess doesn't really mean that the tun open
will succeed later so the whole logic behind this looks like a poor hack.
Once the above mentioned patch is reviewed and merged, the guessing game
could be avoided and that error will not happen.

Selva

--94eb2c124e34d3cfc6053a59c166
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Aug 18, 2016 at 9:11 AM, debbie=
10t <span dir=3D"ltr">&lt;<a href=3D"mailto:debbie10t@...277..." target=3D"=
_blank">debbie10t@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>=
Thu Aug 18 13:54:41 2016 us=3D240792 MANAGEMENT:<br>
=C2=A0&gt;STATE:1471524881,ASSIGN_IP,,<wbr>10.8.0.6,,,,,12fc:1918::10:8:0<w=
br>:1000<br>
Thu Aug 18 13:54:41 2016 us=3D240792 MANAGEMENT: Client disconnected<br>
Thu Aug 18 13:54:41 2016 us=3D240792 Error: When using --tun-ipv6, if you<b=
r>
have more than one TAP-Windows adapter, you must also specify --dev-node<br>
Thu Aug 18 13:54:41 2016 us=3D240792 Exiting due to fatal error<br></div></=
blockquote></div><div class=3D"gmail_extra"><br></div>You are right, the er=
ror message is confusing (see below) but what its trying to say is that _ei=
ther_ exactly one tap adapter and no --dev-node in config =C2=A0_or_ &quot;=
--dev-node name&quot; with name referring to an existing adapter is require=
d. That somewhat strange requirement is=C2=A0related to the &quot;IFCONFIG_=
BEFORE_TUN&quot; that was mentioned in connection with the ifconfig-noexec =
discussion. There is a patch from Heiko for relaxing that requirement, so h=
opefully it will get fixed soon..</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">As for the error message, the code that tries t=
o guess the dev-node fails in two ways (i) if the specified dev-node is not=
 found or (ii) more than one TAP adapters are found. When do_ifconfig is ca=
lled without a &quot;guessed&quot; adapter name, the error shown is the sam=
e regardless of why the guess failed.=C2=A0Anyway a successful guess doesn&=
#39;t really mean that the tun open will succeed later so the whole logic b=
ehind this looks like a poor hack. Once the above mentioned patch is review=
ed and merged, the guessing game could be avoided and that error will not h=
appen.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>Selva</div></div>

--94eb2c124e34d3cfc6053a59c166--

