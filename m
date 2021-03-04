References: <20200907161849.20508-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0a95b96c-1849-4b8a-fba8-a398d452e8c3@...2080...>
Date: Thu, 4 Mar 2021 22:55:21 +0100
MIME-Version: 1.0
In-Reply-To: <20200907161849.20508-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fL9l5QLSlJn5VLSh7Xr453wxUJiSgTqtd"
Subject: Re: [Openvpn-devel] [PATCH] Ignore --cipher for cipher negotiation
 in server client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fL9l5QLSlJn5VLSh7Xr453wxUJiSgTqtd
Content-Type: multipart/mixed; boundary="dEuA6erwEBW7MWvChXOebnnQfCLdXxbLH";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0a95b96c-1849-4b8a-fba8-a398d452e8c3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore --cipher for cipher negotiation in
 server client mode
References: <20200907161849.20508-1-arne@...1227...>
In-Reply-To: <20200907161849.20508-1-arne@...1227...>

--dEuA6erwEBW7MWvChXOebnnQfCLdXxbLH
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/09/2020 18:18, Arne Schwabe wrote:
> OpenVPN will ignore --cipher in lieu of the replacement data-ciphers
> for cipher negioation.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/protocol-options.rst |  6 ++++--
>   src/openvpn/options.c                 | 26 ++++----------------------
>   2 files changed, 8 insertions(+), 24 deletions(-)

I'm not at all convinced about this one.  Because this essentially=20
touches the same arguments we had a discussion about on --udp-mtu.=20
Removing an outdated alias was too much hassle for no gain, despite=20
being an alias not been seen in use for ages (it was deprecated before=20
the v1.5 release, and no configs or bug reports turns up in various=20
google/bing/yahoo/ddg searches using --udp-mtu).  Dropping this outdated=20
option would with high probability *not* break any configuration in the=20
wild.

However, one of the argument raised for keeping it as is was that it=20
*could* break a configuration in the wild.  The behaviour between
--udp-mtu and --link-mtu are identical.


This change on --ciphers adds this warning if --cipher is used in 2.6+:

> +=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7msg(M_WARN,=C2=B7"Note:=
=C2=B7--cipher=C2=B7set=C2=B7to=C2=B7'%s'=C2=B7but=C2=B7missing=C2=B7in"
> +=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=
"=C2=B7--data-ciphers=C2=B7(%s).=C2=B7OpenVPN=C2=B72.6+=C2=B7ignores=C2=B7-=
-cipher=C2=B7for=C2=B7"
> +=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=
"cipher=C2=B7negiotiation.",

Ignoring --cipher in a future release will have quite a higher=20
probability of breaking existing configurations.  Now, this is set in=20
context of --data-ciphers, which is very different code wise.  But the=20
code for --ciphers is essentially the same as --data-ciphers-fallback.=20
I am therefore of the opinion, based on the prior --udp-mtu discussion,=20
that --ciphers should be an alias to --data-ciphers-fallback.

In addition, since adding a warning about using the deprecated --udp-mtu=20
option and put up a plan for removing it was also considered too much, I=20
don't see why that argument would be much different with --ciphers.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--dEuA6erwEBW7MWvChXOebnnQfCLdXxbLH--

--fL9l5QLSlJn5VLSh7Xr453wxUJiSgTqtd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBBV0kACgkQhs+UTJZx
/fIetxAAtaazxpNBotKLAGSHWH7hu0db6/OVLlHycR0LBKRTg+S7XA43Rz2clpLB
xbo8bn5HERB2qffz2ugaEY0Rq9+0PEaiJzR8FyIzI4GtgBPPovZv67NRhrPDKKfb
XFsdvh3UNJe0LxCkbpis22FQvDoZWEUKwWEgOx62g80O0BBzh9/PrVxbiPRO4brc
EMSZE3V3mLt/0DaK68SStp0QCO9uZ0wG9VTNO4RxhRRUh2CFoqu8ebwelN1gWe8V
jBxsrI8ugaweXLf/B8idfS8hvOYEQJgC1IzvaK4ge0Y8vWRQ4ZGwpablkivrBEHw
B9ZnPDePuO8YdWITXwoEa3JRJ01OVnBVcJwqTw98bWLZMK11JiJy9PJkwmKcOfza
d/NqUo0EiLIYX5r8i3TnlUuVIIr3TAAfhwqdCmtb4giWL7GvR/Xr0ua4hykI9y1d
Bukt4YoImU6cpT+UF7sX2Aq09gLGiYH/IZixjs+8wtCnzHM0jhHMxfZ+ATkCq0Uo
QgrcXNVjqEEbZVO3ZH1/TGLxES9kc5uIbHMtFgY/oggS/pJnrbGdL0iVK1j2ysC+
Ml6uqRMYXBjUjtvr47mw7998MwCUJwb/a+YbWJctVxGrYBftF2fEvX5DC1J+Hvt1
becGJjgCf6RvMHciXmOKD5BD/lLUQDZU34pWeTiD626Dn/3jdms=
=epXT
-----END PGP SIGNATURE-----

--fL9l5QLSlJn5VLSh7Xr453wxUJiSgTqtd--

