MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <1515884446-27152-1-git-send-email-selva.nair@...277...>
References: <1515884446-27152-1-git-send-email-selva.nair@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Sun, 14 Jan 2018 03:52:35 +0100
Message-ID: <CAKh=nwGd+t56BkC9D=HsMNYiwuA0Oa_9GCsFR+SwXpSfQrjR-Q@...278...>
Content-Type: multipart/alternative; boundary="94eb2c08b5920961fd0562b39764"
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_meth_free instead of free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--94eb2c08b5920961fd0562b39764
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jan 14, 2018 at 12:00 AM, <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> - RSA_meth_new allocates memory for the name string
>   and must be released using RSA_meth_free
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/ssl_openssl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 34c31b9..d6d9acf 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1144,7 +1144,7 @@ err:
>      {
>          if (rsa_meth)
>          {
> -            free(rsa_meth);
> +            RSA_meth_free(rsa_meth);
>          }
>      }
>      crypto_msg(M_FATAL, "Cannot enable SSL external private key
> capability");
> --
> 2.1.4
>
>
=E2=80=8BGood catch.

For what it's worth:

Acked-by: Emmanuel Deloget <logout@...260...>=E2=80=8B

=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--94eb2c08b5920961fd0562b39764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello,=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Sun, Jan 14, 2018 at 12:00 AM,  <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Selva Nair &l=
t;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt;<br>
<br>
- RSA_meth_new allocates memory for the name string<br>
=C2=A0 and must be released using RSA_meth_free<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ssl_openssl.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 34c31b9..d6d9acf 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -1144,7 +1144,7 @@ err:<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsa_meth)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(rsa_meth);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSA_meth_free(rsa_meth);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0crypto_msg(M_FATAL, &quot;Cannot enable SSL external pr=
ivate key capability&quot;);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.4<br>
<br></font></span></blockquote><div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace">=E2=80=8BGood catch.=C2=A0</=
div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
<br></div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace">For what it&#39;s worth:=C2=A0</div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default=
" style=3D"font-family:monospace,monospace">Acked-by: Emmanuel Deloget &lt;=
<a href=3D"mailto:logout@...260...">logout@...260...</a>&gt;=E2=80=8B</div>=
</div></div><br></div><div class=3D"gmail_extra"><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace">=E2=80=8BBR,=C2=A0</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">-- E=
mmanuel Deloget=E2=80=8B</div><br></div></div>

--94eb2c08b5920961fd0562b39764--

