Date: Wed, 14 Sep 2022 08:15:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyFxbhLzeb36494C@...1296...>
References: <20220808152344.17539-1-gert@...1296...>
 <9a825c98-7066-9beb-20cf-28ee9fc0c4b4@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CCe4a29WwJYZ1YrM"
Content-Disposition: inline
In-Reply-To: <9a825c98-7066-9beb-20cf-28ee9fc0c4b4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup open_tun() for TARGET_NETBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--CCe4a29WwJYZ1YrM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 13, 2022 at 11:33:20PM +0200, Antonio Quartulli wrote:
> in open_tun_generic() there is a check *before* reaching the code above:
>=20
> "if (dev_node)"
>=20
> After your patch this check becomes secondary and won't be reached if=20
> $dev =3D=3D "tap".
>=20
> Is this wanted? It sounds like dev_node is now ignored if $dev is tap.

--dev-node on "not windows, not macos, not linux" is very ill-specified,
in other words, it usually doesn't do anything useful at all.

Basically,

 --dev-node tun3

would do exactly the same as "--dev tun3", for "tunN" devices
(where /dev/tunN exists and can be open()ed).

For tap, NetBSD does not support "tap3", so --dev-node tap<anything>
will just produce an "cannot open /dev/tap<anythign>" error message
(and even if there were a "new and improved tap driver", so you'd
want "--dev-node newtap" it would still not work as the code wouldn't
do the right "give me a dynamic device dance").

So yes, with the new code, --dev-node would be ignored for tap - which
was not actively intentional, but since there is really no way --dev-node
can be useful on NetBSD and --dev-type tap, I can live with that.


> Other than that the patch looks good and the new comment for open_tun is=
=20
> easy to digest, also for non bsders like me.

Would that be an ACK? :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CCe4a29WwJYZ1YrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjIXFuAAoJEB2Cnv7KVigS2SML/iCWUYuo/w+gRKKtD+V4HP+a
dz3wz4smQAi95CpYE60F+ym9VDBEc4YLYPgCu6cIcJX9xJxk625nduGnhQKZXDbf
L0BaNdHvAsWpG9OIqT7AOsp3xThAJ1N4bls5sATfrgKYWTvhSoQZ1Mnwqir+tYQT
GEh9S5oQ/SZ1LB10k5Q+1PgG7DFvvwbbrKoKnvEBu1/kueCzG6oXAMqQJ/6qHajH
7P9woimkKygmRLcwtMStHk7s/jCpZnr/Qc7e18hYHHSLTc06QguS1xU1mvdW/pWu
TiEHORQtNg4qWpML9JY6xTWd6TEWbcXDfqpq9J6qr8pkfgq3h15Qxtz3SIDTbc+6
ALlKZQuEEr3A2shc0LIjDoMgF78V1++lsKawExyOpz0cus34MYj+yeLcGSMak5+V
HavUYVUIp1HJc7FzWZCD4C1M1iPjkS3KOuu4FTRhqsNn7ueCD2T3DP6mvLQwn7yC
syBhVXY4IGavNGZwAKyHbDtpJls054GVwloQqoSpVw==
=iidE
-----END PGP SIGNATURE-----

--CCe4a29WwJYZ1YrM--

