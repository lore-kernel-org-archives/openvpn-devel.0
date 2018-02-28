Date: Wed, 28 Feb 2018 18:23:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180228172338.GA85855@...1296...>
References: <20171101220342.14648-4-steffan@...1856...>
 <201711241242.vAOCgeWx037308@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <201711241242.vAOCgeWx037308@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Don't throw fatal errors
 from create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Steffan asked me to pull this into 2.4, which makes sense - it's
somewhere between "code cleanup" and "bugfix", basically avoiding an
ASSERT() when we could more gracefully handle a failure on an incoming
client (... in a somewhat unlikely chain of events, but still, ASSERT()
on the server side for recoverable things is bad).

commit 77a0bdb77d4c5573fcb78f1e36c45d882a9923ba (HEAD -> release/2.4)
Author: Steffan Karger <steffan.karger@...1435...>
Date:   Wed Nov 1 23:03:41 2017 +0100

    Don't throw fatal errors from create_temp_file()

    Signed-off-by: Steffan Karger <steffan.karger@...1435...>
    Acked-by: Antonio Quartulli <antonio@...515...>
    Message-Id: <20171101220342.14648-4-steffan@...1856...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg15701.html
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit 3e0fd2b0471cf4e53959902ca10d88db7a1ef916)

gert


On Fri, Nov 24, 2017 at 01:42:40PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 3e0fd2b0471cf4e53959902ca10d88db7a1ef916
> Author: Steffan Karger
> Date:   Wed Nov 1 23:03:41 2017 +0100
>=20
>      Don't throw fatal errors from create_temp_file()
>=20
>      Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>      Acked-by: Antonio Quartulli <antonio@...515...>
>      Message-Id: <20171101220342.14648-4-steffan@...1856...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg15701.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaluWZAAoJEB2Cnv7KVigS5akL/35d2mqvu5RpChDYHunSyNnQ
+TsHtBELggZU6kbJ1I5zUkW6V5Cst9JR2RzFO2fkkQPqpaqGo9/BqP+BPpJTfYzm
5SUHbZVOvXIeItO9+6BJijaoMLT8v0P1h7tkSVVxvwnAyWW/8pdWknk1n88F7YFc
Yx0tBAILfD55mfBuFsdJLB0EboqjrSttayQwFhPp7I9saz3AZqV5EAIkhWI15Hwa
AS8YOcrYUDuMubgN02s++lw5uuFGLxE0df3C+xPCa2lpoEFyB3r1iDBD9qzkSyb/
KjNy8jg0f7em6rrQSgQ/6360EtJwjQwqTCO6Gtzhc4NRwCnSPHKgUWIs8TxLDPeu
gbqxilBtEs8ZRMRNfFFxLObHOah86wK9jw850NCNtYdqdBAKO7rQ3HOyeuVvyBcz
GtQUPJ/jd8Ul2CZ4WzJlqMCpoW0bdWiFdhQ5roLaTZ5l1tpO37KVhz3OqslL31Nw
LILRx776Q7PCFQLSd/xGfLFqs018fdauhrLV5V5skw==
=4eGC
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

