Date: Mon, 8 Sep 2025 12:39:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aL6yZcbddCf7FgxN@...1296...>
References: <20250906135413.166789-1-matthias.andree@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5gZnUYLMcdr77gvq"
Content-Disposition: inline
In-Reply-To: <20250906135413.166789-1-matthias.andree@...68...>
Subject: Re: [Openvpn-devel] [PATCH] dco_freebsd: replace assert() by
 if...return
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--5gZnUYLMcdr77gvq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 06, 2025 at 03:54:13PM +0200, Matthias Andree via Openvpn-devel=
 wrote:
> The assert() check might be optimized away in Release builds,
> and killing the process through abort() when input formats are
> bad when we already have an error message in place does not seem right.
>=20
> Suggested by: Ralf Lici <ralf@...2726...>
>=20
> Signed-off-by: Matthias Andree <matthias.andree@...68...>

Thanks for the patch.  There has been lots of parallel work going on
this weekend, and in the end it was decided to go for OpenVPN ASSERT()
instead.

(Committed in master and release/2.6 as of "just now")

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5gZnUYLMcdr77gvq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJovrJlAAoJEB2Cnv7KVigSv80MAKRxdVE+/c3i0Uuy/7Mxd3MT
Javccz5mYzPH0f6C+5lhLoP1km3pzmfc2IgqX9S+9x4n//lFbWbRn5j+dS2UXyV+
deX3NeUllRnFCot/rpxbrTJsi0G2xqB9+gpvmITsWM650A767Zu5QiIyNPCKyoey
dlXfC+CeVzwxG4MUG/y1ax0B8qLMswMud05BatHpjhiG989T/cKh5o3hcJCzPe3O
f75wyHu9N9KMq3Eb3NxuvTcwtfEzhV/MpNG/oUPysahfUxQBkcFr8WT3SpavgneX
aNACcReG8Qv7RkbrRSJDhX8bzOPDPNyERPzgbusrwEsXVg56gsQ5OBilJfKkd4nc
uRN+mZT5mNAVRMmyT46kl8dPqMnwsCs+yWe0IKam8TJB7Q9OdbEP9zn79HH/Su7C
IoQI999Wy+RDr3L5Na7NUL3za2GIoH8LWOiDbXZgtMlTmOdZpjmjBNtwlqYLv8G9
EDDFF2rc6NDMIibLIuzpHo0jtRIZsIiAzU13IUcUww==
=/9gx
-----END PGP SIGNATURE-----

--5gZnUYLMcdr77gvq--

