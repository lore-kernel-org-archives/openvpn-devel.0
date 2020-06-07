Date: Sun, 7 Jun 2020 13:25:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200607112501.GG1431@...1296...>
References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-7-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2vzBza942yILgeht"
Content-Disposition: inline
In-Reply-To: <20200530000600.1680-7-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 6/7] options: enable IPv4 redirection
 logic only if really required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--2vzBza942yILgeht
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 30, 2020 at 02:05:59AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> If no IPv4 redirection flag is set, do not enable the IPv4
> redirection logic at all so that it won't bother adding any
> useless IPv4 route.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

I can see why we want this - I tried to connect to a "v6-only-in-tunnel"
server over v4, specifying "redirect-gateway !ipv4 ipv6", and it tried
to install a v4 /32 redirect route...

Sun Jun  7 13:20:43 2020 net_route_v4_add: 199.102.77.82/32 via 193.149.48.=
190 dev [NULL] table 0 metric -1

... which is harmless, but "unnecesary fumbling" is not desirable.


The reason why I'm a bit unhappy about applying it is that it will
change behaviour for the "redirect-private" case, and that might break
people's setups.  For "redirect-gateway" or "redirect-gateway def1" (etc),
it will not change anything.

Can we make this conditional in a way that does not break "redirect-private=
"?

(I used to use "redirect-private" to handle overlapping IPv4 routes without
actually redirecting the whole gateway - think "VPN server is on 192.0.2.1
and you want to push 'route 192.0.2.0/24'".  IPv6 handles this automaticall=
y,
but v4 needs "redirect-private" for that to work)

thanks :)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2vzBza942yILgeht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe3M6MAAoJEB2Cnv7KVigSUtoL/3TgSQNN7Uar03NnB8S58Fpq
1/tY8rv1If0+z/HbQ9j+L13wU3QD9l/FfTTOZ7KuO4D+HbHrwaHMtdlmrbQcwrrx
xPcnv6/AauTW4r48EHa/49VoRPAjjpxw4BuM2yVVazG0wgcanZ+QlKPAsahSKhvU
xBKI/unIhx+F4//oAqsPuO2+bax4o0OekA44ktF0qVM5FDHdLIpu62St/1ZauTAs
D5jNdr+4VZCl0db1QELB2tBgaJjTcmnnRILgJOdQItpx5vZWnCyhbe/wOoMUmU4h
e8wCCn7Jgd5MOSwSHD5lCtC0wt1yuhSWE+nYfo5gC6LXTHZP2L7YYqiYRvGmKNsH
EY7Z2GMTgGuhSgX60CASL8oggle4LLkRWwRMl392nZD+R1BKHptkJnTrPmFtz3j/
Lg3LB+sSKTEmwYPePLAF8VsIWM3efaEtmsHtmLNU3Egmroqdr1E3OfPdCpYLLKX2
e5jZaJ65y4NZZuS656BHxk6DYiDsb7xJqSbjXYDR2w==
=RFEZ
-----END PGP SIGNATURE-----

--2vzBza942yILgeht--

