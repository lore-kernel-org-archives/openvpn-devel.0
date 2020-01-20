MIME-Version: 1.0
References: <E1itVts-0007ZG-MA@...2479...>
In-Reply-To: <E1itVts-0007ZG-MA@...2479...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 Jan 2020 14:42:24 +0200
Message-ID: <CAGyAFMWcXo-yzhkRgiiZdcZ6xgDS6Wc3AOwbx5QV_HrLcnTBEQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000031d64d059c91a0ef"
Subject: Re: [Openvpn-devel] [PATCH] Move keying material exporter check
 from syshead.h to configure.ac
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000031d64d059c91a0ef
Content-Type: text/plain; charset="UTF-8"

Hi,

+       have_export_keying_material="yes"
> +       AC_CHECK_FUNCS(
> +               [SSL_export_keying_material],
> +               ,
> +               [have_export_keying_material="no"; break]
> +       )
>

Just wondering why not AC_CHECK_FUNC? In this case we could get rid of
"break".

_FUNCS also defines HAVE_function macro, which we don't use in this
particular case.

Noticed that we have similar code above:

    have_crypto_aead_modes="yes"
    AC_CHECK_FUNCS(
        [EVP_aes_256_gcm],
        ,
        [have_crypto_aead_modes="no"; break]
    )

so maybe that's why.

-Lev

--00000000000031d64d059c91a0ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0have_export_keying_material=3D&quot;yes&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AC_CHECK_FUNCS(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[SSL_export_keying_=
material],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[have_export_keying=
_material=3D&quot;no&quot;; break]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br></blockquote><div><br></div><div>Just wond=
ering why not AC_CHECK_FUNC? In this case we could get rid of &quot;break&q=
uot;.</div><div><br></div><div>_FUNCS also defines=C2=A0HAVE_function macro=
, which we don&#39;t use in this particular case.</div><div><br></div><div>=
Noticed that we have similar code above:</div><div><br></div><div>=C2=A0 =
=C2=A0 have_crypto_aead_modes=3D&quot;yes&quot;<br>=C2=A0 =C2=A0 AC_CHECK_F=
UNCS(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 [EVP_aes_256_gcm],<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 [have_crypto_aead_modes=3D&q=
uot;no&quot;; break]<br>=C2=A0 =C2=A0 )<br></div><div><br></div><div>so may=
be that&#39;s why.</div><div><br></div><div>-Lev</div></div></div>

--00000000000031d64d059c91a0ef--

