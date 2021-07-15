Date: Thu, 15 Jul 2021 11:10:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210715091009.GA976@...1296...>
References: <20210714162533.10098-1-david@...2627...>
 <7b1e2246-8375-0369-1d27-6100cc03b872@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4JtcDDr0VxtSus1T"
Content-Disposition: inline
In-Reply-To: <7b1e2246-8375-0369-1d27-6100cc03b872@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Fix leaks in route.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: David Korczynski <david@...2627...>, openvpn-devel@lists.sourceforge.net

--4JtcDDr0VxtSus1T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 15, 2021 at 08:47:13AM +0200, Antonio Quartulli wrote:
> On 14/07/2021 18:25, David Korczynski wrote:
> > Signed-off-by: David Korczynski <david@...2627...>
>=20
> Some commit message is always good - just to give context to the reader
> without the need to look at the rest of the code.
>=20
> But if Gert is fine without it, I am fine too.

I am fine, in this case, as there is not really much to say here - maybe
add the explanation "we assume that RT_DEFINED is always set, but still,
if it is not, we must not leak memory".

I'll merge later today :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4JtcDDr0VxtSus1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg7/twAAoJEB2Cnv7KVigSkFAL/2jUPhoUmizvoJf5jbR5mD5z
A5VwCN8iFSQRyCzvuAQIRUfKSX+iWYzVjpoXGlDqoOdu9rdralCMxS07BQ2RR0Wu
XAeUxzTw6t0K1/gvLoicYoLsL6JbWwVB5yoXu1saUrIb02gIbUcOIIBdzMtvUhkj
hs/Li0cUqybwAe+uFIZZuU1xrUUJDuCwe33BhCL+GBKARAzpFs+oA52Nu0gd/Kku
q5MeiTqHXVMaVK8G+0CrRUwp6xHkA+DKEo7Y0K1tgcq4reCxbf6+UynjlHW8OMzo
TWdokZU6i5/NvnxxHdAS0bBjzBLyW5Zq2KG1baqaYm9WysNcUlIJDohN0eNI07L6
wVYbyBrXXwNhQmwddRA8KZMxiP1dRUBSBUVUCq0Udno16TXAGvRSJ4+BE25VJgPO
viEUfdfrnTV2jYyU2r6g/hh0kQdxzYnJWnoBSfg+9/Tcljm6tOP/wHL2/WWH7YxR
3wc2lqfG5qPd5nCKMllwofxbalZUzYv0pUipDnyxfg==
=1t56
-----END PGP SIGNATURE-----

--4JtcDDr0VxtSus1T--

