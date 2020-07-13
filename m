Date: Mon, 13 Jul 2020 16:06:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713140605.GB1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-7-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dJmudTgG+Ox8yHMb"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-7-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 07/14] client-connect: Change
 cas_context from int to enum
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--dJmudTgG+Ox8yHMb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:48AM +0200, Arne Schwabe wrote:
> This deviates from Fabian's original patch that relied on the now
> removed connection_established bool as pointer being NULL or non NULL as
> implicit third state and makeing connection_established as a substate of
> (cas_context =3D=3D CAS_PENDING)
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
>=20
> Patch V5: extend cas_context with two new states instead adding an
>           extra mini state machine.

23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: 2a.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.


For the changes in this patch, this is a reasonably conclusive test.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dJmudTgG+Ox8yHMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDGpMAAoJEB2Cnv7KVigS2/ML/18muOZHQduBrbowQg5rJ6v8
rbxmJ7D4I01ffiipmoFl1C3boX942cIQ0gXleY9niATzmSnV+H5upAqqAG/Gdp+B
6fDncmDvG7spkLYhvgwht9X2kwXnML9bJXK3brVF4bovpXctkyvGvvSa9auUFLl+
PwQAtx4NPP765FK8IuAg+cuIQ2+1emmXxeOf51cIIqlxE5Y5Prp/GTqSwY0mxYlg
eYmcObP7Snivd0EX8uVUMIqEUY7zzYfOmBHZxDWyF9CZqTkkS8mJeK9m/3PRSPl8
AsXK2H7Uq1OanjoqkMHZQ7q5OAgpKufhkAc+nGE/viLkTn3IIKS+d7YOFYU4wNPw
n+cVw9XNl1B6bLQSs7M17MkAPno74U3cYARIALFGqQN1TbAzA5nxZ5HYBNBljudN
AzBea6PfD5skUYtEFbg5nJ4JgwFLbkGFLS7Ntau15wmjrDUrFw7AsKXjFmoogjRZ
zA3eK84bSwixJla5uA8fr4XjxbC+KvP7g/R2ypH11g==
=Cl+9
-----END PGP SIGNATURE-----

--dJmudTgG+Ox8yHMb--

