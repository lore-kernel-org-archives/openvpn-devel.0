MIME-Version: 1.0
References: <CAKuzo_iSUX0h25O36dfZCuhRM_OCNvJttgQiM2WBGwLQnhO=xA@...278...>
In-Reply-To: <CAKuzo_iSUX0h25O36dfZCuhRM_OCNvJttgQiM2WBGwLQnhO=xA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 15 Oct 2018 17:06:50 -0400
Message-ID: <CAKuzo_jCffsmuA6VW-+xqPicGeL1P-CK4pH4BoDy_xWS+Z0ZOw@...278...>
Content-Type: multipart/alternative; boundary="000000000000e89d4105784ad1fe"
Subject: Re: [Openvpn-devel] rsa signature with PSS padding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e89d4105784ad1fe
Content-Type: text/plain; charset="UTF-8"

Replying to self :)

On Fri, Oct 12, 2018 at 12:24 PM Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> My testing shows that OpenSSL 1.1.1 likes to use PSS even for TLS 1.2, so,
> even in the short-term, this can't be worked around by just disabling TLS
> 1.3.
>
> Now, for cryptoapicert, it would have been easy to support PSS using
> Windows CNG API provided OpenSSL passes the hash and ask to sign with PSS
> padding. But it doesn't. Instead, it adds the padding and ask us to sign
> that padded data as is (i.e. padding none). In fact rsa_sign() callback is
> not even called when padding is PSS -- it just jumps to rsa_priv_enc
> callback. As far as I can see signing pre-padded hash is not supported by
> CNG (does it?).
>
> Any suggestions on what do we do?
>

Looks like we can hook on to EVP_PKEY methods and get the hash and padding
info to use with CNG. Still figuring out the best way to do this.

Thanks,

Selva

--000000000000e89d4105784ad1fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Replying to self :)<br><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr">On Fri, Oct 12, 2018 at 12:24 PM Selva Nair &lt;<a href=3D"mai=
lto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi,<br><=
br></div><div>My testing shows that OpenSSL 1.1.1 likes to use PSS even for=
 TLS 1.2, so, even in the short-term, this can&#39;t be worked around by ju=
st disabling TLS 1.3.<br><br></div><div>Now, for cryptoapicert, it would ha=
ve been easy to support PSS using Windows CNG API provided OpenSSL passes t=
he hash and ask to sign with PSS padding. But it doesn&#39;t. Instead, it a=
dds the padding and ask us to sign that padded data as is (i.e. padding non=
e). In fact rsa_sign() callback is not even called when padding is PSS -- i=
t just jumps to rsa_priv_enc callback. As far as I can see signing pre-padd=
ed hash is not supported by CNG (does it?).<br></div><div><br>Any suggestio=
ns on what do we do?</div></div></blockquote><div><br></div><div>Looks like=
 we can hook on to EVP_PKEY methods and get the hash and padding info to us=
e with CNG. Still figuring out the best way to do this.<br><br></div><div>T=
hanks,<br><br></div><div>Selva</div></div></div>

--000000000000e89d4105784ad1fe--

