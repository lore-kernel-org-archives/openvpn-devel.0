Date: Tue, 21 Feb 2017 22:12:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170221211205.GF93896@...1296...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tbBCmy51UvWhYeBI"
Content-Disposition: inline
In-Reply-To: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
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

--tbBCmy51UvWhYeBI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2017 at 08:42:57PM +0100, Steffan Karger wrote:
> ACK to the attached patch.

> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2001
> From: "Simon (simix)" <via-trac>

All previous commits (I'm aware of) carry a valid e-mail address, and
most of them have a full name for the author.

Do we have a policy how to handle patches with missing author info?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tbBCmy51UvWhYeBI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYrK0kAAoJEB2Cnv7KVigSD+QL/2yM7mihxv+BXOoRrFLDFEwf
s1MKvoWogX5KZYjxCGAwFIMFs0fU5edbXfGGtcthxHxBVQvQCajpzPAH+DZxm60z
vaj0KAeHnI5E14T1KjVIm4ppljRHV6tko8+EIaiX7UxItXAZVrf1mAAJ4cmq+96j
fylnAeTXF8UXq9p/YFO1QtQHKmcqjHO7S8vqUNgZ2BfQXXqw60Ym0ZNAJNgsQ62/
ryURZLxz6JZZkmoHZTQCdErP6MU5NJSdX07Bf8qG8iGIjZJ/cZXt1hn1S+/4gJoe
f0QC8ZLlan17ne43qfNZ2KB09sv0LpmGnd4Ccoro8EMTQ4/iUB1dDAts6Sk7FNeK
gT+JYcc0l6hCXepSWGM9wKmDaEtwg8Mz22xLoIsly31HNnVfxiIgOJY4B3VDD5ad
bXaY19OAjAiPF+WNrnzhpnBcZn/D2tQfZgO59G+RxWXNSAyqLj/OG4YMMa7NST3r
xIETOZxoIGr2TtSNYWqDe5HG21S7hsbOzlPcsHYAIA==
=yTqZ
-----END PGP SIGNATURE-----

--tbBCmy51UvWhYeBI--

