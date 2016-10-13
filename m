MIME-Version: 1.0
In-Reply-To: <1476257569-16301-1-git-send-email-steffan@...1856...>
References: <CAA1AbxK+21uBLt2S4Og_mbCUM7zjf+uj3NxAuOA=0GwT44ZE-g@...278...>
	<1476257569-16301-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 13 Oct 2016 00:31:51 -0400
Message-ID: <CAKuzo_jzFwnt1rZ86g-mPRSm00VtUWWNxXfG+zmZWis-N9KSdQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c07067ee9d7f6053eb797f0
Subject: Re: [Openvpn-devel] [PATCH v2] Check --ncp-ciphers list on startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c07067ee9d7f6053eb797f0
Content-Type: text/plain; charset=UTF-8

On Wed, Oct 12, 2016 at 3:32 AM, Steffan Karger <steffan@...1856...> wrote:

> Currently, if --ncp-ciphers contains an invalid cipher, OpenVPN will only
> error out when that cipher is selected by negotiation.  That's not very
> friendly to the user, so check the list on startup, and give a clear error
> message immediately.
>
> This patches changes the cipher_kt_get() to let the caller decide what
> action to take if no valid cipher was found.  This enables us to print all
> invalid ciphers in the list, instead of just the first invalid cipher.
>
> This should fix trac #737.
>
> v2: improve tls_check_ncp_cipher_list() with Selva's review suggestions.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/crypto.c         |  5 +++++
>  src/openvpn/crypto_backend.h |  3 ++-
>  src/openvpn/crypto_mbedtls.c | 15 ++++++++++-----
>  src/openvpn/crypto_openssl.c | 17 ++++++++++++-----
>  src/openvpn/options.c        |  5 +++++
>  src/openvpn/ssl.c            | 22 ++++++++++++++++++++++
>  src/openvpn/ssl.h            |  9 +++++++++
>  7 files changed, 65 insertions(+), 11 deletions(-)



Looks good now. ACK.

Selva

--94eb2c07067ee9d7f6053eb797f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Oct 12, 2016 at 3:32 AM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Current=
ly, if --ncp-ciphers contains an invalid cipher, OpenVPN will only<br>
error out when that cipher is selected by negotiation.=C2=A0 That&#39;s not=
 very<br>
friendly to the user, so check the list on startup, and give a clear error<=
br>
message immediately.<br>
<br>
This patches changes the cipher_kt_get() to let the caller decide what<br>
action to take if no valid cipher was found.=C2=A0 This enables us to print=
 all<br>
invalid ciphers in the list, instead of just the first invalid cipher.<br>
<br>
This should fix trac #737.<br>
<br>
</span>v2: improve tls_check_ncp_cipher_list() with Selva&#39;s review sugg=
estions.<br>
<span class=3D""><br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856...">ste=
ffan@...1856...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++=
<br>
=C2=A0src/openvpn/crypto_backend.h |=C2=A0 3 ++-<br>
=C2=A0src/openvpn/crypto_mbedtls.c | 15 ++++++++++-----<br>
=C2=A0src/openvpn/crypto_openssl.c | 17 ++++++++++++-----<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
</span>=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
2 ++++++++++++++++++++++<br>
=C2=A0src/openvpn/ssl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 =
+++++++++<br>
=C2=A07 files changed, 65 insertions(+), 11 deletions(-)</blockquote></div>=
<br><br></div><div class=3D"gmail_extra">Looks good now. ACK.<br><br></div>=
<div class=3D"gmail_extra">Selva<br></div></div>

--94eb2c07067ee9d7f6053eb797f0--

