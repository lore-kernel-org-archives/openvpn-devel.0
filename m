Date: Tue, 15 Dec 2020 18:35:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201215173558.GN976@...1296...>
References: <20201215171600.25534-1-domagoj@...2540...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tILRO7B1j0X0kK2Z"
Content-Disposition: inline
In-Reply-To: <20201215171600.25534-1-domagoj@...2540...>
Subject: Re: [Openvpn-devel] [PATCH] Fix too early argv freeing when
 registering DNS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

--tILRO7B1j0X0kK2Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2020 at 06:16:00PM +0100, Domagoj Pensa wrote:
> When registering DNS on Windows, argv is freed after being used in first
> ipconfig command (/flushdns).
>=20
> Then same argv is used uninitialized in next ipconfig command (/registerd=
ns)
> causing heap exception and subprocess crash.
>=20
> As a consequence second command is never executed and locked netcmd
> semaphore is not cleanly released.
>=20
> Removing argv freeing between ipconfig calls solves the problem.

Oh!  Yes, now with your patch, this is very obvious - there is a trac
ticket (so when I merge this, I'll add the trac ticket number to the
commit message) but it sort of puzzled Selva and me, because the
code "looked sane".

Acked-by: gert@...1296...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tILRO7B1j0X0kK2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf2PP+AAoJEB2Cnv7KVigS9yUL/jbukAFRQ+4HfAcfd+wwecLj
7OJMEK2bu2INQmBQtQ6G2Df5BDC1XmUIgAa6y6OjwK5Ck2xq04u3xmYXVPmlsbWA
FH4D+4OIqVfDxv2vwsJkiOQFLIEYy1JSBi45ALL/K6+I9lebAod7YH13Afhnj5Fe
5A0SqG+R4Ed5G5FUdsFE9Qhdi6G6+dTWX2X8fYVVqu4AqL2zWiJUr+iNz7k91BsI
tM0qGjo1NvGxpaMC4BuHb6di5GwthsTKJ1NOeePqXVfqpEGUG1BaaXxGKuIhe+D7
+x/1pWUbKrCb3QyIzXQCxrPPuxlSghuemFC/rF2ytNSrrUeDVnRLv0et8j/VdTBn
ZopNRaAnkhraHLNcCnwI/y/psIxAFqXtpmvypPBTA7DxfKwKPIs7V1XYG010bjas
JrXCh/myYrr2y88UrT+m4P68KE3b046Fmzqxd0jZJy8rW8XnOxm52l4W0SdHBKOO
KKkJtDQ+7pWs213R1l0HcRjhtVGSxzuZbTkhG4m23A==
=kDDA
-----END PGP SIGNATURE-----

--tILRO7B1j0X0kK2Z--

