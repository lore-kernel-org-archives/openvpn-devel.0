MIME-Version: 1.0
In-Reply-To: <20171205085711.25075-1-a@...2181...>
References: <20171205085711.25075-1-a@...2181...>
From: "sameer.s.athaley" <sameera.athaley@...277...>
Date: Wed, 6 Dec 2017 09:44:24 +0530
Message-ID: <CADtuLXQT6OTq8gwY5pLYxaDw-qXg+5n0HLeBrvHOzQhgcAutjQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1a60f6cc4128055fa42fc7"
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: fix typ0 in comment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--94eb2c1a60f6cc4128055fa42fc7
Content-Type: text/plain; charset="UTF-8"

How the fuck unsubscribe this, its very annoynng

On 05-Dec-2017 2:28 PM, "Antonio Quartulli" <a@...2181...> wrote:

> From: Antonio Quartulli <antonio@...515...>
>
> the function used to set the verify callback in mbedTLS is
> actually called mbedtls_ssl_conf_verify() and it is invoked
> in key_state_ssl_init().
>
> Fix comment accordingly.
>
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/ssl_verify_mbedtls.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_
> mbedtls.h
> index 8b0a5ae9..2fba362f 100644
> --- a/src/openvpn/ssl_verify_mbedtls.h
> +++ b/src/openvpn/ssl_verify_mbedtls.h
> @@ -48,9 +48,9 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;
>   * This callback function is called when a new TLS session is being setup
> to
>   * determine whether the remote OpenVPN peer's certificate is allowed to
>   * connect. It is called for once for every certificate in the chain. The
> - * callback functionality is configured in the \c init_ssl() function,
> which
> - * calls the mbed TLS library's \c ssl_set_verify_callback() function
> with \c
> - * verify_callback() as its callback argument.
> + * callback functionality is configured in the \c key_state_ssl_init()
> function,
> + * which calls the mbed TLS library's \c mbedtls_ssl_conf_verify()
> function with
> + * \c verify_callback() as its callback argument.
>   *
>   * It checks *flags and registers the certificate hash. If these steps
> succeed,
>   * it calls the \c verify_cert() function, which performs OpenVPN-specific
> --
> 2.15.1
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--94eb2c1a60f6cc4128055fa42fc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">How the fuck unsubscribe this, its very annoynng=C2=A0</d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 05-Dec-2017=
 2:28 PM, &quot;Antonio Quartulli&quot; &lt;a@...2181...&gt; wrote:<br type=
=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">From: Antonio Quartulli &lt=
;<a href=3D"mailto:antonio@...515...">antonio@...515...</a>&gt;<br>
<br>
the function used to set the verify callback in mbedTLS is<br>
actually called mbedtls_ssl_conf_verify() and it is invoked<br>
in key_state_ssl_init().<br>
<br>
Fix comment accordingly.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:antonio@...515...">a=
ntonio@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ssl_verify_<wbr>mbedtls.h | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/ssl_verify_<wbr>mbedtls.h b/src/openvpn/ssl_verify=
_<wbr>mbedtls.h<br>
index 8b0a5ae9..2fba362f 100644<br>
--- a/src/openvpn/ssl_verify_<wbr>mbedtls.h<br>
+++ b/src/openvpn/ssl_verify_<wbr>mbedtls.h<br>
@@ -48,9 +48,9 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;<br>
=C2=A0 * This callback function is called when a new TLS session is being s=
etup to<br>
=C2=A0 * determine whether the remote OpenVPN peer&#39;s certificate is all=
owed to<br>
=C2=A0 * connect. It is called for once for every certificate in the chain.=
 The<br>
- * callback functionality is configured in the \c init_ssl() function, whi=
ch<br>
- * calls the mbed TLS library&#39;s \c ssl_set_verify_callback() function =
with \c<br>
- * verify_callback() as its callback argument.<br>
+ * callback functionality is configured in the \c key_state_ssl_init() fun=
ction,<br>
+ * which calls the mbed TLS library&#39;s \c mbedtls_ssl_conf_verify() fun=
ction with<br>
+ * \c verify_callback() as its callback argument.<br>
=C2=A0 *<br>
=C2=A0 * It checks *flags and registers the certificate hash. If these step=
s succeed,<br>
=C2=A0 * it calls the \c verify_cert() function, which performs OpenVPN-spe=
cific<br>
--<br>
2.15.1<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div></div>

--94eb2c1a60f6cc4128055fa42fc7--

