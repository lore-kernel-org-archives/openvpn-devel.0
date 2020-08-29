MIME-Version: 1.0
References: <20200814080619.2108-1-arne@...1227...>
In-Reply-To: <20200814080619.2108-1-arne@...1227...>
From: Rafael Gava <gava100@...277...>
Date: Sat, 29 Aug 2020 16:19:07 -0300
Message-ID: <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b98be505ae090bc3"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b98be505ae090bc3
Content-Type: text/plain; charset="UTF-8"

Hi Arne,

This thread has a could days but I'm testing the version 2.5-beta2 and I'm
getting the following error:

2020-08-29 16:02:53 us=643016 OPTIONS ERROR: failed to negotiate cipher
with server.  Add the server's cipher ('BF-CBC') to --data-ciphers
(currently 'BF-CBC') if you want to connect to this server.

I have added the data-ciphers and also the data-ciphers-fallback to the
client's config file and in all attempts I'm getting the same error message.

data-ciphers BF-CBC
data-ciphers-fallback BF-CBC

I know that you guys are trying to get rid of the BF-CBC but my question
is, should it still work if we set these parameters in the config file or
am I missing or doing something wrong? :-)

BR

Gava




On Fri, Aug 14, 2020 at 5:06 AM Arne Schwabe <arne@...1227...> wrote:

> OpenVPN 2.5 clients do not correctly do a fallback to the server server.
> This commit fixes that logic and also fixes --data-ciphers-fallback to
> be used in situations other than no OCC cipher.
>
> To reproduce the error use a client with only --data-ciphers set against
> a server without NCP.
>
>         OPTIONS ERROR: failed to negotiate cipher with server.
>         Add the server's cipher  ('AES-256-CBC') to --data-ciphers
>         (currently 'AES-256-CBC') if you want to connect to this server.
>
> Reported by: Richard Bonhomme <tincanteksup@...277...>
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl_ncp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index f522b8f0..c9ab85ce 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, const int
> found)
>      }
>      /* If the server did not push a --cipher, we will switch to the
>       * remote cipher if it is in our ncp-ciphers list */
> -    bool useremotecipher = tls_poor_mans_ncp(&c->options,
> -
>  c->c2.tls_multi->remote_ciphername);
> -
> +    if(tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
> +    {
> +        return true;
> +    }
>
>      /* We could not figure out the peer's cipher but we have fallback
>       * enabled */
> -    if (!useremotecipher && c->options.enable_ncp_fallback)
> +    if (!c->c2.tls_multi->remote_ciphername &&
> c->options.enable_ncp_fallback)
>      {
>          return true;
>      }
> --
> 2.26.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000b98be505ae090bc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>This thread has a could days b=
ut I&#39;m testing the version 2.5-beta2 and I&#39;m getting the following =
error:</div><div><br></div><div>2020-08-29 16:02:53 us=3D643016 OPTIONS ERR=
OR: failed to negotiate cipher with server.=C2=A0 Add the server&#39;s ciph=
er (&#39;BF-CBC&#39;) to --data-ciphers (currently &#39;BF-CBC&#39;) if you=
 want to connect to this server.<br></div><div><br></div><div>I have added =
the data-ciphers and also the data-ciphers-fallback to the client&#39;s con=
fig=C2=A0file and in all attempts I&#39;m getting the same error message.</=
div><div><br></div><div>data-ciphers BF-CBC<br>data-ciphers-fallback BF-CBC=
<br></div><div><br></div><div>I know that you guys are trying to get rid of=
 the BF-CBC but my question is, should it still work if we set these parame=
ters in the config file or am I missing or doing something wrong? :-)</div>=
<div><br></div><div>BR</div><div><br></div><div>Gava</div><div><br></div><d=
iv><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 5:06 AM Arne Schwabe =
&lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">OpenVPN 2.5 clients d=
o not correctly do a fallback to the server server.<br>
This commit fixes that logic and also fixes --data-ciphers-fallback to<br>
be used in situations other than no OCC cipher.<br>
<br>
To reproduce the error use a client with only --data-ciphers set against<br>
a server without NCP.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS ERROR: failed to negotiate cipher with =
server.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Add the server&#39;s cipher=C2=A0 (&#39;AES-256=
-CBC&#39;) to --data-ciphers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (currently &#39;AES-256-CBC&#39;) if you want t=
o connect to this server.<br>
<br>
Reported by: Richard Bonhomme &lt;<a href=3D"mailto:tincanteksup@...277..."=
 target=3D"_blank">tincanteksup@...277...</a>&gt;<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ssl_ncp.c | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c<br>
index f522b8f0..c9ab85ce 100644<br>
--- a/src/openvpn/ssl_ncp.c<br>
+++ b/src/openvpn/ssl_ncp.c<br>
@@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, const int fo=
und)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/* If the server did not push a --cipher, we will switc=
h to the<br>
=C2=A0 =C2=A0 =C2=A0 * remote cipher if it is in our ncp-ciphers list */<br>
-=C2=A0 =C2=A0 bool useremotecipher =3D tls_poor_mans_ncp(&amp;c-&gt;option=
s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0c-&gt;c2.tls_multi-&gt;remote_ciphername);<br>
-<br>
+=C2=A0 =C2=A0 if(tls_poor_mans_ncp(&amp;c-&gt;options, c-&gt;c2.tls_multi-=
&gt;remote_ciphername))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* We could not figure out the peer&#39;s cipher but we=
 have fallback<br>
=C2=A0 =C2=A0 =C2=A0 * enabled */<br>
-=C2=A0 =C2=A0 if (!useremotecipher &amp;&amp; c-&gt;options.enable_ncp_fal=
lback)<br>
+=C2=A0 =C2=A0 if (!c-&gt;c2.tls_multi-&gt;remote_ciphername &amp;&amp; c-&=
gt;options.enable_ncp_fallback)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.26.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000b98be505ae090bc3--

