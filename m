MIME-Version: 1.0
References: <20220216135716.6541-1-maximilian.fillinger@...2507...>
In-Reply-To: <20220216135716.6541-1-maximilian.fillinger@...2507...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 16 Feb 2022 19:45:20 +0500
Message-ID: <CAFHpkQGufswDBn=sNS-PTJ3K3_2kUcntwpkUmeRR7eC7eYOqsg@...278...>
Content-Type: multipart/alternative; boundary="0000000000009ce57905d823b328"
Subject: Re: [Openvpn-devel] [PATCH] Add warning about mbed TLS licensing
 problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009ce57905d823b328
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Support for mbed TLS is likely to be removed in OpenVPN 2.17.

2.7 ?

=D1=81=D1=80, 16 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 19:13, Max F=
illinger <
maximilian.fillinger@...2507...>:

> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> ---
>  README.mbedtls | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/README.mbedtls b/README.mbedtls
> index 4875822d..b5604bb8 100644
> --- a/README.mbedtls
> +++ b/README.mbedtls
> @@ -11,6 +11,23 @@ This version depends on mbed TLS 2.0 (and requires at
> least 2.0.0).
>
>  *************************************************************************
>
> +Warning:
> +
> +As of version 2.17, mbed TLS can be licensed *only* under the Apache v2.0
> +license. That license is incompatible with OpenVPN's GPLv2.
> +
> +If you wish to distribute OpenVPN linked with mbed TLS, there are two
> options:
> +
> + * Ensure that your case falls under the system library exception in
> GPLv2, or
> +
> + * Use an earlier version of mbed TLS. Version 2.16.12 is the last relea=
se
> +   that may be licensed under GPLv2. Unfortunately, this version is
> +   unsupported and won't receive any more updates.
> +
> +Support for mbed TLS is likely to be removed in OpenVPN 2.17.
> +
> +*************************************************************************
> +
>  Due to limitations in the mbed TLS library, the following features are
> missing
>  in the mbed TLS version of OpenVPN:
>
> --
> 2.20.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000009ce57905d823b328
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">+Support for mbed TLS is likely to be rem=
oved in OpenVPN 2.17.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
2.7 ?</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">=D1=81=D1=80, 16 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 1=
9:13, Max Fillinger &lt;<a href=3D"mailto:maximilian.fillinger@...2507...">=
maximilian.fillinger@...2507...</a>&gt;:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Signed-off-by: Max Fillinger &lt;<a href=3D"mailto=
:maximilian.fillinger@...2507..." target=3D"_blank">maximilian.fillinger@...1186...=
.2507...</a>&gt;<br>
---<br>
=C2=A0README.mbedtls | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br>
<br>
diff --git a/README.mbedtls b/README.mbedtls<br>
index 4875822d..b5604bb8 100644<br>
--- a/README.mbedtls<br>
+++ b/README.mbedtls<br>
@@ -11,6 +11,23 @@ This version depends on mbed TLS 2.0 (and requires at le=
ast 2.0.0).<br>
<br>
=C2=A0*********************************************************************=
****<br>
<br>
+Warning:<br>
+<br>
+As of version 2.17, mbed TLS can be licensed *only* under the Apache v2.0<=
br>
+license. That license is incompatible with OpenVPN&#39;s GPLv2.<br>
+<br>
+If you wish to distribute OpenVPN linked with mbed TLS, there are two opti=
ons:<br>
+<br>
+ * Ensure that your case falls under the system library exception in GPLv2=
, or<br>
+<br>
+ * Use an earlier version of mbed TLS. Version 2.16.12 is the last release=
<br>
+=C2=A0 =C2=A0that may be licensed under GPLv2. Unfortunately, this version=
 is<br>
+=C2=A0 =C2=A0unsupported and won&#39;t receive any more updates.<br>
+<br>
+Support for mbed TLS is likely to be removed in OpenVPN 2.17.<br>
+<br>
+*************************************************************************<=
br>
+<br>
=C2=A0Due to limitations in the mbed TLS library, the following features ar=
e missing<br>
=C2=A0in the mbed TLS version of OpenVPN:<br>
<br>
-- <br>
2.20.1<br>
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

--0000000000009ce57905d823b328--

