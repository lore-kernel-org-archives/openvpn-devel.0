MIME-Version: 1.0
References: <20191117181243.28919-1-arne@...1227...>
 <20191117181243.28919-4-arne@...1227...>
In-Reply-To: <20191117181243.28919-4-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Feb 2020 14:34:58 +0200
Message-ID: <CAGyAFMWAkAFSYcoG=WTs6atyQAbx=v71rU6ZO1y=bV-2rt0n_w@...278...>
Content-Type: multipart/alternative; boundary="000000000000d308b3059e7451e1"
Subject: Re: [Openvpn-devel] [PATCH 4/4] Normalise ncp-ciphers option and
 restrict it to 127 bytes
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

--000000000000d308b3059e7451e1
Content-Type: text/plain; charset="UTF-8"

Hi,

su 17. marrask. 2019 klo 20.13 Arne Schwabe (arne@...1227...) kirjoitti:
>
> -        if (!cipher_kt_get(translate_cipher_name_from_openvpn(token)))
> +        /* translate_cipher_name_from_openvpn also normalises the cipher
name,
> +         * e.g. replacing AeS-128-gCm with AES-128-GCM
> +         */

I think this comment is a bit misleading -
 translate_cipher_name_from_openvpn()
translates openvpn cipher name (value in --ncp-ciphers) to crypto library
cipher name,
for example from "aES-256-GCM" to "idaes_256_GCM" which contradicts the
comment.

Maybe we could factor this code out into separate normalize_cipher_name()
function, which

 - translates (possibly non-normalized) openvpn cipher name into cryptolib
cipher name
 - translates crypto cipher name back to openvpn cipher name, this time
normalized

> +        if (!ktc)
>          {
>              msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s",
token);
> -            unsupported_cipher_found = true;
> +            error_found = true;

It seems that mutate_ncp_cipher_list() returns NULL if error_found is true.
Maybe we could goto
out of the loop? The label could be added before free() calls.

> +            if (buf_len(&new_list)> 0)
> +            {
> +                /* The next if condition ensure there is always space for
> +                 * a :
> +                 */
> +                buf_puts(&new_list, ":");
> +            }
> +
> +            /* Ensure buffer has capacity for cipher name + : + \0 */
> +            if (!(buf_forward_capacity(&new_list) >
> +                  strlen(ovpn_cipher_name) + 2))

This doesn't handle the case when buffer capacity is just enough
to fit the last cipher - for that it is enough to fit cipher name and \0.
Could we move

  >          token = strtok(NULL, ":");

here and do something like

  /* for the last cipher, token is NULL, enough to fit cipher and \0 */
  strlen(ovpn_cipher_name) + (token ? 2 : 1);

> +            {
> +                msg(M_WARN, "Length of --ncp-ciphers is over the"
> +                    "limit of 127 chars");
> +                error_found = true;

Same as above, cannot we "goto out"?

We could put out: right before next line.

>      free(tmp_ciphers);
> +    free_buf(&new_list);
>
> -    return 0 < strlen(list) && !unsupported_cipher_found;
> +    return ret;
>  }

-Lev

--000000000000d308b3059e7451e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>su 17. marrask. 2019 klo 20.13 Arne Schwabe (<a=
 href=3D"mailto:arne@...1227...">arne@...1227...</a>) kirjoitti:<br>&gt;<br=
>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cipher_kt_get(translate_cipher_name=
_from_openvpn(token)))<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* translate_ci=
pher_name_from_openvpn also normalises the cipher name,<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * e.g. replacing AeS-128-gCm with AES-128-GCM<br>&gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br><br>I think this comment is a bit misle=
ading - =C2=A0translate_cipher_name_from_openvpn()<br>translates openvpn ci=
pher name (value in --ncp-ciphers) to crypto library cipher name,<br>for ex=
ample from &quot;aES-256-GCM&quot; to &quot;idaes_256_GCM&quot; which contr=
adicts the comment.<br><br>Maybe we could factor this code out into separat=
e normalize_cipher_name() function, which<br><br>=C2=A0- translates (possib=
ly non-normalized) openvpn cipher name into cryptolib cipher name<br>=C2=A0=
- translates crypto cipher name back to openvpn cipher name, this time norm=
alized<br><br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ktc)<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg(M_WARN, &quot;Unsupported cipher in --ncp-ciphers: %s&quot;, =
token);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_ciph=
er_found =3D true;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error=
_found =3D true;<br><br>It seems that mutate_ncp_cipher_list() returns NULL=
 if error_found is true. Maybe we could goto<br>out of the loop? The label =
could be added before free() calls.<br><br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (buf_len(&amp;new_list)&gt; 0)<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* The next if condition ensure there is always space f=
or<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * a :<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_puts(&amp;ne=
w_list, &quot;:&quot;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ensure bu=
ffer has capacity for cipher name + : + \0 */<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!(buf_forward_capacity(&amp;new_list) &gt;<br>&=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strlen(=
ovpn_cipher_name) + 2))<br><br>This doesn&#39;t handle the case when buffer=
 capacity is just enough<br>to fit the last cipher - for that it is enough =
to fit cipher name and \0.<div>Could we move</div><div><br>=C2=A0 &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0token =3D strtok(NULL, &quot;:&quot;); <br><=
br>here and do something like<br><br>=C2=A0 /* for the last cipher, token i=
s NULL, enough to fit cipher and \0 */<br>=C2=A0 strlen(ovpn_cipher_name) +=
 (token ? 2 : 1);<br><br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN=
, &quot;Length of --ncp-ciphers is over the&quot;<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;limit of 127 c=
hars&quot;);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0error_found =3D true;<br><br>Same as above, cannot we &quot;goto out&quo=
t;?<br><br>We could put out: right before next line.<br><br>&gt; =C2=A0 =C2=
=A0 =C2=A0free(tmp_ciphers);<br>&gt; + =C2=A0 =C2=A0free_buf(&amp;new_list)=
;<br>&gt;<br>&gt; - =C2=A0 =C2=A0return 0 &lt; strlen(list) &amp;&amp; !uns=
upported_cipher_found;<br>&gt; + =C2=A0 =C2=A0return ret;<br>&gt; =C2=A0}</=
div><div><br></div><div>-Lev</div></div>

--000000000000d308b3059e7451e1--

