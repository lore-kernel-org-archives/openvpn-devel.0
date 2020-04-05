Date: Sun, 5 Apr 2020 10:25:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200405082556.GN1431@...1296...>
References: <1585591527-23734-1-git-send-email-selva.nair@...277...>
 <1585963064-10311-1-git-send-email-selva.nair@...277...>
 <1585963064-10311-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DPQvABvJ16HvCXZu"
Content-Disposition: inline
In-Reply-To: <1585963064-10311-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password query the management interface (if available).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--DPQvABvJ16HvCXZu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Fri, Apr 03, 2020 at 09:17:44PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> When only username is found in the file, redirect the auth-user-pass
> query to the management interface if management-query-passwords is
> enabled.  Otherwise the user is prompted on console, if available,
> as before.
[..]
> ---
> This may be cherry-picked from 57578310992d1fbe8eff97049087c5308089acb5
> in master without conflicts.

And this is what I've done.  So we have:

Acked-by: Gert Doering <gert@...1296...>

commit 2fe84732d19243df6c7713c185998507419155cd (HEAD -> release/2.4)
Author: Selva Nair <selva.nair@...277...>
Date:   Mon Mar 30 14:05:27 2020 -0400

    When auth-user-pass file has no password query the management interface
    (if available).

    Signed-off-by: Selva Nair <selva.nair@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1585591527-23734-2-git-send-email-selva.nair@...277...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg19655.html
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit 57578310992d1fbe8eff97049087c5308089acb5)


quick test build on MinGW and Linux just to ensure I didn't break
anything unexpected due to "different context in 2.4, some variables
not available" etc, but no :-)

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DPQvABvJ16HvCXZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeiZYUAAoJEB2Cnv7KVigSMZwMAJgmsSjdwf9h3lNF2CVetulm
fUn/F9Rlwpdj1cUQSwl56vUzeVadiH2Q94nOm2X097wKFTGR2wKufmlck9OV2CIv
Xes/S3mmgOOMYjRU2qiPeC3M/gRHGg4iOaewFCvYnRTMmq/MZh+plgt/+OP6hjRi
//9Vn/XekV31tM6a6FRjYWW61Tp2C99iNnEAXj0eOYh8majngu8Q0DJc6XKOQ/vg
yswij+9iP/2KbkKmPTJgFwuhNtDKlLvPa+FFO87RqY7kSuljXDCHiktpgPPwD16V
jYhy0sAvKKeOTKaIvFoXLZovEQcnGg7hoAJKcHl8CgAALqyso4nrDnnbT9d1ooCB
DmkqZMIbZj6RuVKeptD9nV9+b5zUfcTg20fQQ1PnSL5oqwr7SYYNHOW2mb96i8HP
qhb0EWJCuLdd4GeguDztWQreeWD26YbnVxFHYb5mqJ8QeP9vKuloLYdbobG43+sE
a9M8ddXZJUiyRCD8c8w4lGrndAqdNKHl7bl0jgLZRg==
=qv3z
-----END PGP SIGNATURE-----

--DPQvABvJ16HvCXZu--

