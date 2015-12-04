References: <565A3985.3030800@...1227...>
	<1448835033-24287-1-git-send-email-iam@...2070...>
	<CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
	<5660EA2A.1020903@...515...> <5661214C.8040905@...2070...>
	<CAKuzo_ja1WDLP3V=X_amn70t2Yj6zyNV7H4LU5vg+mAsqY6Nag@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5661686A.4090305@...2070...>
Date: Fri, 4 Dec 2015 13:18:18 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ja1WDLP3V=X_amn70t2Yj6zyNV7H4LU5vg+mAsqY6Nag@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9TBWGDJn0pJ04vLC0QBPALxKhQ0eXQ5n2"
Subject: Re: [Openvpn-devel] [PATCH v7-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9TBWGDJn0pJ04vLC0QBPALxKhQ0eXQ5n2
Content-Type: multipart/alternative;
	boundary="------------080103060901090608040807"

This is a multi-part message in MIME format.
--------------080103060901090608040807
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Indeed.
Pushed fixed version to github repo.
https://github.com/ValdikSS/openvpn-with-patches/commit/287ceb11abfa33ee331=
ba2651572908cbad008d1

If there is no other remarks, I'll send PATCH v8.

On 04.12.2015 08:50, Selva Nair wrote:
> Hi,
>
> On Fri, Dec 4, 2015 at 12:14 AM, ValdikSS <iam@...2070... <mailto:iam@...493...=
2070...>> wrote:
>
> I think you missed the NET_LUID one. I had thought this was fixed earlier=
, but v7 still has this issue
>
>
> The relevant code is
>
> + if (ConvertInterfaceIndexToLuid(index, &tapluid) =3D=3D NO_ERROR)
> +       dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
>
> which leaves tapluid undefined if there was an error.
>
> Selva
>


--------------080103060901090608040807
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Indeed.<br>
    Pushed fixed version to github repo.<br>
    <a
href=3D"https://github.com/ValdikSS/openvpn-with-patches/commit/287ceb11abf=
a33ee331ba2651572908cbad008d1"><a class=3D"moz-txt-link-freetext" href=3D"h=
ttps://github.com/ValdikSS/openvpn-with-patches/commit/287ceb11abfa33ee331b=
a2651572908cbad008d1">https://github.com/ValdikSS/openvpn-with-patches/comm=
it/287ceb11abfa33ee331ba2651572908cbad008d1</a></a><br>
    <br>
    If there is no other remarks, I'll send PATCH v8.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 04.12.2015 08:50, Selva Nair wrote:<b=
r>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_ja1WDLP3V=3DX_amn70t2Yj6zyNV7H4LU5vg+mAsqY6Nag@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">Hi,<br>
          <br>
        </div>
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Fri, Dec 4, 2015 at 12:14 AM,
            ValdikSS <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...2098...=
0...</a>&gt;</span>
            wrote:<br>
            <div><br>
              I think you missed the NET_LUID one. I had thought this
              was fixed earlier, but v7 still has this issue<br>
              <br>
            </div>
            <br>
          </div>
          <div class=3D"gmail_quote">The relevant code is<br>
            <br>
            + if (ConvertInterfaceIndexToLuid(index, &amp;tapluid) =3D=3D
            NO_ERROR)<br>
            + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, "Tap Luid: %I64d"=
, tapluid.Value);<br>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">which leaves tapluid undefined if there
          was an error.<br>
          <br>
        </div>
        <div class=3D"gmail_extra">Selva<br>
        </div>
        <div class=3D"gmail_extra"><br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------080103060901090608040807--

--9TBWGDJn0pJ04vLC0QBPALxKhQ0eXQ5n2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWYWhqAAoJEFzXIC7viPdygY8QALHTWaqX3UyAwuGSgxBwvgTv
X4oXYns/wlKTOUmJWUqFXxbFSiug3EoiK0gj61tyuAkPsBhL2+7lmGaQKVa7TOR/
jgnmMqRs9uxWuQj0EC/ajXu8/JizikEDkFfE37bFvNtsnUYuXr6mLg/YTXn5sF6W
i+YPDgq/+4F44XE/BMhxoGWlu/3XsartBBenacJ3u7bREs6fBmz9XjcAoI/T4Q7+
WpoUrZmSgocq2t+VsQW6n/7BibhymfU4BJUniouzvIEddNNvlU0AN8SLdeulfDUw
LbXe8nVhEJsDUJaMS0Nx8pqm1t6iSLAbaRWWJIF5FM8bBkrijNL9ULLIB1ZdTiTG
i79rtOeVWL+c6yizW5V/wNnC8sKerP+PbQLaFJnNsaW+ZrP79seBXmI8TWwLU8rz
xAxmXTga+X0ralVfWluQnjzn5W28LW7hJHgKYbUi5/2zRkmMB11aSPxH1/o8TwYR
GHB4XVhoVHDLtHKPsSpBcWwGzr2FlElGB5p/olZbct5uHm/Fx6KaViMxv/9VbNtZ
yWu1Olhf/wyOIXMq2bj1+7T7HuZ6sdGydj6uniLuhtk14VG6bWu627LaNBAkVDKi
S1WBfDFkaeMgES/0px0SHubpjvFcGq+/1sK3a3fC3vjWoP6eIAa9QkTtQ553rVVg
B+uyIu5mYnKIg0ymb74f
=+k8O
-----END PGP SIGNATURE-----

--9TBWGDJn0pJ04vLC0QBPALxKhQ0eXQ5n2--

