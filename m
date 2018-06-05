Date: Tue, 5 Jun 2018 20:43:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605184325.GP57262@...1296...>
References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...>
 <20180605145139.GN57262@...1296...>
 <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Content-Disposition: inline
In-Reply-To: <3909b854-7b38-a8f8-945d-f30bc60a0a6f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net

--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 06, 2018 at 12:11:40AM +0800, Antonio Quartulli wrote:
> > Without having done much review here, just one initial caveat: did you=
=20
> > test this with --ifconfig-pool-persist?  What happens?
>=20
> It should just be ignored.
> At the moment pool-persist works only for IPv4 and there is no support
> for IPv6. This has not been changed by this patchset.

Well, it does save the (calculated) v6 address into the save file...

So, what happens if you run a server with --ifconfig-pool-persist and
no IPv4?  Will it crash, not write anything to the file, write garbage?

> I added a check about it in ifconfig_pool_read():
>=20
> 521     /* IPv6 logic not implemented yet, therefore bail out if no IPv4
> pool was
> 522      * configured
> 523      */
> 524     if (pool && !pool->ipv4.enabled)
> 525     {
> 526         return;
> 527     }

We should aim to make this work as well (but it could be patch 6 of the
series :-)).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFtnNAAoJEB2Cnv7KVigSUl4L/3oNxPHDv4uBEuJaeY1EcM1i
bER836bPB5l4ymD630WrAEa1TicpoC6j4whp1/SxOlzdaNy/Knv7M23QALeGQJuH
K5GJZBgcdW7Dm5n0YY6hhgq4Kd1/EdbXF200Dt0SXtWpsdOO9ioRKzA7Mffg91lB
63SYv5lL6r2BSwvlUdoa6zxXgObroOWBDdH5Iuo5qcLiWJU9snHt5AwFJpR8wjvt
ALIslsrZ4bqVtmgRO8Icqm5AvnA5apKD/Tfp2A8CIIBOTy5PGQcWngP0GskxeS5L
n8hHp+9mbkp7Ud5+IvpGn65kUBK3CdQrM2le92rv3+N6tjfTis5aWd7DPRDGjRNH
c5DvY0RY62kax8eYKMOSzsr8f89dyn1gIMR40FTOSElziCTSuOLXp6RE3i/v3a9P
DCwm2n/KfGC9dnTadKoEBv8nn0D4XKTW9vl09wSqRvK5Xmp7ixJqZ3T4scGI6joi
CRXNgcqovAm6Ktp8yWO5hWn/igDf48wwLVX/6RNnMQ==
=6WJ9
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--

