MIME-Version: 1.0
In-Reply-To: <1476214507-4055-1-git-send-email-steffan@...1856...>
References: <1476214507-4055-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 11 Oct 2016 16:11:31 -0400
Message-ID: <CAKuzo_jcPpCDeaL281O2j55m5m_X8TrMbY2nPgixm7O5KhQ3Fg@...278...>
Content-Type: multipart/alternative; boundary=001a1141b320c09969053e9c7cc3
Subject: Re: [Openvpn-devel] [PATCH] Check --ncp-ciphers list on startup
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

--001a1141b320c09969053e9c7cc3
Content-Type: text/plain; charset=UTF-8

Hi,

To nit-pick,

On Tue, Oct 11, 2016 at 3:35 PM, Steffan Karger <steffan@...1856...> wrote:

> +bool
> +tls_check_ncp_cipher_list(const char *list) {
> +  char *tmp_ciphers = string_alloc (list, NULL);
> +  char *tmp_ciphers_orig = tmp_ciphers;
> +  bool unsupported_cipher_found = false;
> +
> +  const char *token = strtok (tmp_ciphers, ":");
> +  while (token)
> +    {
> +      if (!cipher_kt_get (translate_cipher_name_from_openvpn (token)))
> +       {
> +         msg (M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
> +         unsupported_cipher_found = true;
> +       }
> +      token = strtok (NULL, ":");
> +    }
> +  free (tmp_ciphers_orig);
>

the extra "tmp_ciphers_orig" is redundant. Just "free (tmp_ciphers)" will
do.



> +
> +  return list && 0 < strlen(list) && !unsupported_cipher_found;
>

Checking for list == NULL here looks too late. If list is null, so is
tmp_ciphers and then the first call to strtok will not reset the internal
state of strtok(). The behaviour of strtok then depends on whether any
previous use of it was was iterated to the end or not.

If list could be NULL, better check it and do an early return from the top.

+}
> +
>

Selva

--001a1141b320c09969053e9c7cc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">To nit-pick,</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
>On Tue, Oct 11, 2016 at 3:35 PM, Steffan Karger <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1vn" class=
=3D"a3s aXjCH m157b53fdb2d75231">+bool<br>
+tls_check_ncp_cipher_list(<wbr>const char *list) {<br>
+=C2=A0 char *tmp_ciphers =3D string_alloc (list, NULL);<br>
+=C2=A0 char *tmp_ciphers_orig =3D tmp_ciphers;<br>
+=C2=A0 bool unsupported_cipher_found =3D false;<br>
+<br>
+=C2=A0 const char *token =3D strtok (tmp_ciphers, &quot;:&quot;);<br>
+=C2=A0 while (token)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 if (!cipher_kt_get (translate_cipher_name_from_<wbr>o=
penvpn (token)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_WARN, &quot;Unsupported cipher in=
 --ncp-ciphers: %s&quot;, token);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_cipher_found =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 token =3D strtok (NULL, &quot;:&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 free (tmp_ciphers_orig);<br></div></blockquote><div><br></div><div>=
the extra &quot;tmp_ciphers_orig&quot; is redundant. Just &quot;free (tmp_c=
iphers)&quot; will do.</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div id=3D":1vn" class=3D"a3s aXjCH m157b53fdb2d75231">
+<br>
+=C2=A0 return list &amp;&amp; 0 &lt; strlen(list) &amp;&amp; !unsupported_=
cipher_found;<br></div></blockquote><div><br></div><div>Checking for list =
=3D=3D NULL here looks too late. If list is null, so is tmp_ciphers and the=
n the first call to strtok will not reset the internal state of strtok(). T=
he behaviour of strtok then depends on whether any previous use of it was w=
as iterated to the end or not.</div><div>=C2=A0</div><div>If list could be =
NULL, better check it and do an early return from the top.</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div id=3D":1vn" class=3D"a3s aXjCH m157=
b53fdb2d75231">
+}<br>
+</div></blockquote></div><br></div><div class=3D"gmail_extra">Selva</div><=
/div>

--001a1141b320c09969053e9c7cc3--

