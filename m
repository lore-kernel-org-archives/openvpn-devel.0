MIME-Version: 1.0
In-Reply-To: <1482078820-14635-1-git-send-email-steffan@...1856...>
References: <1482078820-14635-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Dec 2016 12:45:06 -0500
Message-ID: <CAKuzo_ge1S6BFPaTmipkTq9_gMYgYFBWWprKKEOpNvGeJjt_ag@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12542248dc7b0543f25ea2
Subject: Re: [Openvpn-devel] [PATCH] reformatting: fix style in crypto*.{c,
	h}
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

--94eb2c12542248dc7b0543f25ea2
Content-Type: text/plain; charset=UTF-8

Hi,

Not a comprehensive review, but a couple of teeny things I noticed ..

On Sun, Dec 18, 2016 at 11:33 AM, Steffan Karger <steffan@...1856...> wrote:

in crypto.c

@@ -1389,13 +1396,15 @@ read_key_file(struct key2 *key2, const char *file,
> const unsigned int flags)
>      {
>          if (!key2->n)
>          {
> -            msg(M_FATAL, "Insufficient key material or header text not
> found in file '%s' (%d/%d/%d bytes found/min/m
> ax)",
> +            msg(M_FATAL,
> +                "Insufficient key material or header text not found in
> file '%s' (%d/%d/%d bytes found/min/max)",
>                  error_filename, count, onekeylen, keylen);
>          }
>
>          if (state != PARSE_FINISHED)
>          {
> -            msg(M_FATAL, "Footer text not found in file '%s' (%d/%d/%d
> bytes found/min/max)",
>

wrong indent :)


> +           msg(M_FATAL,
> +                "Footer text not found in file '%s' (%d/%d/%d bytes
> found/min/max)",
>                  error_filename, count, onekeylen, keylen);
>          }
>      }
>


In cryptoapi.c

@@ -290,7 +305,8 @@ rsa_priv_enc(int flen, const unsigned char *from,
> unsigned char *to, RSA *rsa, i
>
>  /* decrypt */
>  static int
> -rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA
> *rsa, int padding)
> +rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA
> *rsa,
> +        int padding)
>  {
>      /* I haven't been able to trigger this one, but I want to know if it
> happens... */
>      assert(0);
>

following this there is a

static int init(RSA *rsa)

which appears unused (at least mingw always complains so)
Can it be removed?

> @@ -509,7 +534,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx,
const char *cert_prop)
>         goto err;
>   }
>    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa',
so
>-  * we decrease it here with RSA_free(), or it will never be cleaned up.
*/
>+   * we decrease it here with RSA_free(), or it will never be cleaned up.
*/

Add a new line before the closing */ ?

Further, cryptoapi.c has a few for loops with opening brace on same line as
for, those could be wrapped with a new line?

Otherwise all look "safe and good" white space changes.

Selva

--94eb2c12542248dc7b0543f25ea2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Not a comprehensive review, but a couple of teeny things I not=
iced .. <br><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
>On Sun, Dec 18, 2016 at 11:33 AM, Steffan Karger <span dir=3D"ltr">&lt;<a =
href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>=
&gt;</span> wrote:<br><br>in crypto.c <br><br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">@@ -1389,13 +1396,15 @@ read_key_file(struct key2 *key=
2, const char *file, const unsigned int flags)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =
{<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!key2-&gt;n)<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>-=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(M_FATAL, &quot;Insuffi=
cient key material or header text not found in file &#39;%s&#39; (%d/%d/%d =
bytes found/min/m<br>ax)&quot;,<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(M_FATAL,<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;Insuffic=
ient key material or header text not found in file &#39;%s&#39; (%d/%d/%d b=
ytes found/min/max)&quot;,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_filename, count, =
onekeylen, keylen);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<b=
r><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state !=3D PARSE=
_FINISHED)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>-=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(M_FATAL, &=
quot;Footer text not found in file &#39;%s&#39; (%d/%d/%d bytes found/min/m=
ax)&quot;,<br></blockquote><div><br></div><div>wrong indent :) <br>=C2=A0<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg(M_FATAL,<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;Footer text not found in file &#39;%s&#39; (%d/%d/%d bytes found/=
min/max)&quot;,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_filename, count, onekeylen=
, keylen);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=
=C2=A0=C2=A0=C2=A0 }<br></blockquote><br><br></div><div class=3D"gmail_quot=
e">In cryptoapi.c<br><br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div id=3D"m_1759413011848454181gmail-m_92=
22290181503992921:3ou" class=3D"m_1759413011848454181gmail-m_92222901815039=
92921a3s m_1759413011848454181gmail-m_9222290181503992921aXjCH m_1759413011=
848454181gmail-m_9222290181503992921m15912ca952fe2648">@@ -290,7 +305,8 @@ =
rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *r=
sa, i<br>
<br>
=C2=A0/* decrypt */<br>
=C2=A0static int<br>
-rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa, int padding)<br>
+rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int padding)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* I haven&#39;t been able to trigger this one, but I w=
ant to know if it happens... */<br>
=C2=A0 =C2=A0 =C2=A0assert(0);</div></blockquote></div></div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">following this there is a=
 <br><br>static int init(RSA *rsa)<br></div><div class=3D"gmail_extra"><br>=
which appears unused (at least mingw always complains so)<br></div><div cla=
ss=3D"gmail_extra">Can it be removed?<br><br></div><div class=3D"gmail_extr=
a">&gt; @@ -509,7 +534,7 @@ SSL_CTX_use_CryptoAPI_certific<wbr>ate(SSL_CTX =
*ssl_ctx, const char *cert_prop)<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 g=
oto err;<br>&gt;=C2=A0=C2=A0 }<br>&gt; =C2=A0=C2=A0 /* SSL_CTX_use_RSAPriva=
teKey() increased the reference count in &#39;rsa&#39;, so<br>
&gt;-=C2=A0 * we decrease it here with RSA_free(), or it will never be clea=
ned up. */<br>
&gt;+=C2=A0=C2=A0 * we decrease it here with RSA_free(), or it will never b=
e cleaned up. */<br><br></div><div class=3D"gmail_extra">Add a new line bef=
ore the closing */ ?<br><br></div><div class=3D"gmail_extra">Further, crypt=
oapi.c has a few for loops with opening brace on same line as for, those co=
uld be wrapped with a new line?<br><br></div><div class=3D"gmail_extra">Oth=
erwise all look &quot;safe and good&quot; white space changes.<br>=C2=A0<br=
></div><div class=3D"gmail_extra">Selva<br></div></div>

--94eb2c12542248dc7b0543f25ea2--

