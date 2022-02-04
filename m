Date: Fri, 4 Feb 2022 18:28:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yf1iUkDpsV/wuk0X@...1296...>
References: <20220204154504.16830-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pX93ssu3AItBs3xz"
Content-Disposition: inline
In-Reply-To: <20220204154504.16830-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Get rid of README.IPv6 and revamp
 TODO.IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--pX93ssu3AItBs3xz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 04, 2022 at 04:45:04PM +0100, Antonio Quartulli wrote:
> README.IPv6 is quite useless because IPv6 is not a second
> class citizen anymore. Most of the content is "obvious" or explained in
> the manpage along with other details/options.
>=20
> TODO.IPv6 is old and many implemented things are still reported there
> for no clear reason. Prune all useless details and keep what seems to
> still be not implemented.
>=20
> Cc: Gert Doering <gert@...1296...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> I am personally in favour of killing TODO.IPv6 as well and rather
> document missing features in trac tickets. Thoughts?

Out it goes!

> +4.) safety check: if connecting over IPv6 (v6 transport) and the pushed
>       route-ipv6 network encompasses the server IPv6 address, make sure=20
>       we at least log a warning (until we can fiddle with external routing
>       to make this work correctly).

We fiddle with external routing to make it work :-) - since 2.4, I think.

>    o implement comparison for mapped addresses: server in dual stack
>      listening IPv6 must permit incoming streams from allowed IPv4 peer,
>      currently you need to pass eg:  --remote ffff::1.2.3.4

That seems to be obsolete as well, with the full DS rewrite Arne did for 2.=
4.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pX93ssu3AItBs3xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh/WJSAAoJEB2Cnv7KVigSBJsL/A8kgWYmMeawry4bxi0NsnmS
L+RYA4bgCecWailB0UJ0oyAtDq6+GYgMav1dxBznkoK2QaPASUfVJKMycMt5zXKu
2Y2Rj+S9ZPYoiNAawV9MxJSg9ncPvBTHhe21/L2D69w0jmVcNOo2fLLilBEhEGvc
3x2kOoKMHR/TIsHPvvAE7U6O3EbhUWrshEoMPCAfsuAaWR1rz95GLp7bt/8FoawR
/b1/8yLStJXNDXcQWVPDe2P3z5NKK8Gc8AQqBkputM6J44S31emKlrhRJeLPyO9I
qTyCfq3BELYQRHBhigS9kBUSrGRJ2zShr4OeLEArjPanlx+QTax6LVjjxx0nX69y
ZYpJKf5UFkewT94My7HLSigWi8230cBJV11pLbtQ71D+MHZMp0Y0HTqM4mq1T+RY
0p3wXYU61gEsII6lqCyu1B7Hv134Bbl9bZ0mRu3cSdvI0AeDSk+JA6UQSKmk+/3R
vAhSCJ58XP6EStAD1BXUItqweuIbXIFRdJost5SypQ==
=tjpT
-----END PGP SIGNATURE-----

--pX93ssu3AItBs3xz--

