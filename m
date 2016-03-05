References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <56DAF2A8.3030701@...2070...>
Date: Sat, 5 Mar 2016 17:52:24 +0300
MIME-Version: 1.0
In-Reply-To: <56DA04EE.8000200@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rWnx3kVB9UgEosX3fRoG46uilKH4TMoec"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWnx3kVB9UgEosX3fRoG46uilKH4TMoec
Content-Type: multipart/mixed; boundary="lRB8rUAej9vpgTBpCuQdki2DiKA4USuKa"
From: ValdikSS <iam@...2070...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <56DAF2A8.3030701@...2070...>
Subject: Re: Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...>
In-Reply-To: <56DA04EE.8000200@...2070...>

--lRB8rUAej9vpgTBpCuQdki2DiKA4USuKa
Content-Type: multipart/alternative;
	boundary="------------000302000507070800020903"

This is a multi-part message in MIME format.
--------------000302000507070800020903
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/05/2016 12:58 AM, ValdikSS wrote:
> I have good news and bad news:
>
> Good news:
>
>   * OpenVPN sends all certificates from the server supplied for --server =
directive (although with a small bug that a certificate which you have priv=
ate key
>     for must be supplied on the top)
>   * OpenVPN Connect for Android can successfully connect to my server wit=
h a chain
>
>
> Bad news:
>
>   * OpenVPN 2.3 and master can't connect to this server, with both OpenSS=
L and PolarSSL backends. Maybe if I supply certificates in correct order, c=
lient
>     would work.
>

Sorry for misinformation, OpenVPN 2.3 and master with PolarSSL backend actu=
ally work. The problem is in OpenSSL backend.

>
>
> On 03/04/2016 12:04 AM, ValdikSS wrote:
>


--------------000302000507070800020903
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    On 03/05/2016 12:58 AM, ValdikSS wrote:<br>
    <blockquote cite=3D"mid:56DA04EE.8000200@...2070..." type=3D"cite">
      <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
      I have good news and bad news:<br>
      <br>
      Good news:<br>
      <ul>
        <li>OpenVPN sends all certificates from the server supplied for
          --server directive (although with a small bug that a
          certificate which you have private key for must be supplied on
          the top)</li>
        <li>OpenVPN Connect for Android can successfully connect to my
          server with a chain</li>
      </ul>
      <br>
      Bad news:<br>
      <ul>
        <li>OpenVPN 2.3 and master can't connect to this server, with
          both OpenSSL and PolarSSL backends. Maybe if I supply
          certificates in correct order, client would work. </li>
      </ul>
    </blockquote>
    <br>
    Sorry for misinformation, OpenVPN 2.3 and master with PolarSSL
    backend actually work. The problem is in OpenSSL backend.<br>
    <br>
    <blockquote cite=3D"mid:56DA04EE.8000200@...2070..." type=3D"cite">
      <ul>
      </ul>
      <br>
      <br>
      <div class=3D"moz-cite-prefix">On 03/04/2016 12:04 AM, ValdikSS
        wrote:<br>
      </div>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------000302000507070800020903--

--lRB8rUAej9vpgTBpCuQdki2DiKA4USuKa--

--rWnx3kVB9UgEosX3fRoG46uilKH4TMoec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2vKoAAoJEFzXIC7viPdy1zwQAKr+4UD8TNyYJ6CSTh4zH0Hy
y/ftqD143OhSUAcFvb4NArvoTG5mr9GGl+VEzy9NSCGtq2bf7fAJlOqVbgiyGfzs
/iGDc6j6lkdn2NimEe8NwFKLecmJaUSiABTqMm+Kt8N4nW4jI5Z28hga5yzbVXj1
3a68iUmciZJ37qeLTO1isd3HDcXBU9KV4TX9bSKOacIycqBOEY6WSowCJp18m3K2
+n0qan5QMjV3IU53eAavyw5K35nP3bDHXjPjd9vYcJv4k3sOIpMyi3ktrJTsWgdP
gGzEB6yW4wS1+Ps0it7gxmQENIZCevKity/iq4/Hzbrgm2YuQhVfhW85JYGeLefO
j+HJdS9wAyA2UJAu+H97s3/TmUkWn+kAmUfO0bSRYXL+DLUIZoYZr7mVh4Kg/CBd
hnLZruItx9kVTp2GxPpnhe0av80DjlSOtoZCTtkCttqndWJ3xG6I9M/6hoLk0N4u
sU3+H+N2gmfvdpducAxGtbCbJ1Af77Gb9Rp4EjLtii4jeGVaFaLsHaxe6J2KJ2wC
sOlPWZKrlJsTbqDiZhis6pWFt1IEBhaMcEDYEkhLixhQPxI7Po+QvcP5kMiUka7m
E2eD9sMYMnE45DBSLAm3a89V3Xigrn5lVY2BN8dNFUabc27POvr73e/2Apppw6VY
mJySRpZMxFJZfeu2AAEk
=G3Ae
-----END PGP SIGNATURE-----

--rWnx3kVB9UgEosX3fRoG46uilKH4TMoec--

