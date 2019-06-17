Date: Mon, 17 Jun 2019 19:46:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190617174653.GM1097@...1296...>
References: <20190617124110.30907-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ix2jQZQ3wXOip0b1"
Content-Disposition: inline
In-Reply-To: <20190617124110.30907-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] t_net.sh: fixes for the networking
 test script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--Ix2jQZQ3wXOip0b1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 17, 2019 at 02:41:09PM +0200, Antonio Quartulli wrote:
> +UNIT_TEST=3D"LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH:../vendor/dist/lib/ ./un=
it_tests/openvpn/networking_testdriver"

While this *looks* promising, it fails the=20

if [ ! -x "$UNIT_TEST" ]; then
    echo "no test_networking driver available. SKIPPING TEST." >&2
    exit 77
fi

test later on.  Well, it quiets the buildbot failures, but a test that is
always skipped cannot be the goal - so, NAK on this, sorry.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ix2jQZQ3wXOip0b1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdB9INAAoJEB2Cnv7KVigS968L/2G19RF5h2rWqlEmFZmZiTwu
LGVYMutFF4KT65Lr4LZZ7d99fIeCFUmJHIqrWrke5N4vyWVtCILXoYdcafym4J43
Cgn/28hf/24P0A2WmO7RIqX7z1qOrlYLxW715X213Q+N0Mm7CQ4WN2srUB+jJl5Z
1FwvMwYhJuDtpcL7YBKif++OExjkyIZn3yJhNaUE9QkjK/55njUmVUveEHNw2H5E
f9DIjM9dHRjLHENNiyptZEVd0PfsMtoo3oe02USQTQI1UDE0C4euk+2hgKyutSG7
UJ1Nk81LTGXmtXQDVyh7rIsBmZ6bYMl4kG6FHm4jsTq+vlKJ+HQbrfn+eTsDE/h0
b3CPrc1J1PlslM4bnlFoM4eWAqUVuad93EK3gJHRuLk7Z7SrE3vWE5qp39P5OlfN
aoUxTs9AcRpFNGmSnihxZXw6GsuXzOP/0rt8kdTgtDS3689GChL8cmSedS9hHau7
I92WXHH2nRuTUs61/MD24QwZpWHUIlZbK0M0mWVS7w==
=g2Sc
-----END PGP SIGNATURE-----

--Ix2jQZQ3wXOip0b1--

