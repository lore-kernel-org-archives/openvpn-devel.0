Date: Thu, 27 Oct 2022 20:37:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1rQAa1hqWoFW8WG@...1296...>
References: <20221023195105.31714-1-selva.nair@...277...>
 <202210270607.29R67xBm021921@...2054...>
 <CAKuzo_ivcgZ=t=aUmhPddRNRSwV7DbtD9WncrmbPvKkM9xkqcA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JR0k/NIBeZovBAXY"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ivcgZ=t=aUmhPddRNRSwV7DbtD9WncrmbPvKkM9xkqcA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ensure --auth-nocache is
 handled during renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--JR0k/NIBeZovBAXY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 27, 2022 at 11:18:07AM -0400, Selva Nair wrote:
> On Thu, Oct 27, 2022 at 2:08 AM Gert Doering <gert@...1296...> wrote:
>=20
> > Looking at the code, I'd say your commit description makes a lot of
> > sense, and explains the observed "funnies" quite well (which I could
> > reproduce).  The code change looks reasonable, Arne ACKed this, and
> > I could not find a way to break it.  Good :-)
> Thanks for the laborious testing!

We've been bitten *so* often already by --auth-nocache + --auth-token
combinations on the path here that I've become very careful ;-)

> 2.4 is also affected  as commit dfd624b52 was cherrypicked into it as wel=
l:
> (commit 607dfa9)
> But this patch won't apply due to some context changes.
>=20
> Would you like a resolved patch or is 2.4 out of "support" now?

It's in "semisupport", so I'd merge a patch for that - but it's not
clear if we ever do a formal 2.4.13 release, and even if we do, we are
*not* going to a full windows installer release (so, just tag + tarball,
if needed).

2.3, no :-)  (I do have 2.2 and 2.3 test clients for the "master" test,
but actually getting these to build on modern systems with recent OpenSSL is
painful...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JR0k/NIBeZovBAXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjWtAAAAoJEB2Cnv7KVigSDh0L/RzTCQMuvOooX24obGErl/FU
KNex6gcgYMTax+nKFAkdjGUS4G5LsCpnyVeGcJ3CYqTluJsQE3xKh1VsSyCefEY6
mTmqJ5kKBaShrAAoMtduT1w4sMSnggDi8iIx2VuXjwrvARcVgKfRYghTeOwcwu0p
ZhZBEWSZemoYole1r0UeVJ5aCBh1Ft8KgNexR6y7mvx3Ql9nQi9o+XGM++o1Nblc
8oPSYTgWJkia4CBXtkdwL0K6y9Ep6f9TMdk7IY/pcM9ZnLwr5sWypp47aw4cOzg5
2S5aqNxV9bs2mAD7cOh7oewPVkiSqYa9AnNzFGU8DOfqPtV1by/TFqkLNvKElfsg
crwKWSuGx2GDkLdrpCBzDfKOvH23NtalYqb+bOsg4pql0zA/yFCKBgfbNABfo4ru
qBi0hDeIAPrbP2jGthZ+0WVdJip3CU4BlR+BhZuBU1qGK/n1nXjeOuY2CDmRiBna
nkOoyQCA036QKjVkXyQCx/Cfh6NzgQo42UH3D7kdng==
=odsn
-----END PGP SIGNATURE-----

--JR0k/NIBeZovBAXY--

