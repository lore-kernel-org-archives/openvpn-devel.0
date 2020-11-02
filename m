References: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
Date: Mon, 2 Nov 2020 15:00:58 +0100
MIME-Version: 1.0
In-Reply-To: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="M71CnLg7LYypol9LeIcC9CMwyer3Ctj2R"
Subject: Re: [Openvpn-devel] OpenVPN 3 Linux client - v11 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M71CnLg7LYypol9LeIcC9CMwyer3Ctj2R
Content-Type: multipart/mixed; boundary="r38qp7ZwH2WCeSSTEUPARrwLtzVogrDa4";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
Subject: Re: OpenVPN 3 Linux client - v11 beta released
References: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
In-Reply-To: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>

--r38qp7ZwH2WCeSSTEUPARrwLtzVogrDa4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/11/2020 14:30, David Sommerseth wrote:
>   With the kernel module installed, the configuration file must be
>   be imported:
>=20
>       $ openvpn3 config-import --config CONFIG_FILENAME \
>                      --name CFGNAME \
>                      --persistent
>=20
>   Then the imported configuration profile must get the DCO feature
>   enabled:
>=20
>       $ openvpn3 config-manage --show --name CFGNAME --dco true

So I managed to introduce a typo here, this config-manage operation
should use --config instead of --name:

        $ openvpn3 config-manage --show --name CFGNAME --dco true

Thanks to Lev for spotting this.  It is correct in the wiki page and
Fedora Copr repository page.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--r38qp7ZwH2WCeSSTEUPARrwLtzVogrDa4--

--M71CnLg7LYypol9LeIcC9CMwyer3Ctj2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfoBEaAAoJEIbPlEyWcf3yGIoQAIPz2z3+vLpdsuuMPWxUxjIG
wL0a19QvMbNxBhAyd5F2CpJ2XpnGW1TyhOokrXUmUwVo29FZ69k4JMXb3gh0XjNC
qNABkIpXWulp3iiP+vQLHdkLdlNVHkESWd9UlAMTBJV1iBlgY5bNWkiMbrLi//ZV
cgqx6dmHdJGSzyQ0BbLJCBIAcNwLiYyXWTppyg0TkV34oyfN4fQ/6flx8ZhTWpNF
/4SLLG2a8alTvY3UJbC9DT/3/+Ru+/TAe99pc/P/+koHI6f2vixwkQcAvI7xrqjY
ouMJ1f7eYZ47NcGKJ1zkpdYenmnxl0lOvAAcSFe1tlas0iOkxKoG84s+iMPnUiZA
8QszlxMFZAckiOKvaJkOHxOVi30wKnRbi8+wnsOamCGjt2pgnBxrfhQ3KXSeyMWJ
4pxFp9xnzz8RY0Fuuz0qydd33XYwSi8N59W2kCfsVmfFrUGXLQnfRZvJsGH+3Dia
EYV8QCFMFRUtytElpz4UkdILivJ2szoBDwgjbojifKO+o7fIdqsLrVWblbwLD3N0
g8KkvPLhmmI5NKGdbHVh4kp+UfTc0WHO5Zy2OXLLtdA4TgPyuK0ym/h+t78T/eTg
3sS6F9VFZUE8U0mgXwrcYJPYiyZ0agRl9FD8lQRdgNi6gSGEVPEF87aBPUZmSXGx
HZiDNgmlldgKd36kpggG
=uHiG
-----END PGP SIGNATURE-----

--M71CnLg7LYypol9LeIcC9CMwyer3Ctj2R--

