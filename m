Date: Tue, 28 Jan 2025 08:05:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z5iBt3Tgq4YZCP6P@...1296...>
References: <20250127235014.355-1-smittals@...2857...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zbsFriU502vjuWoL"
Content-Disposition: inline
In-Reply-To: <20250127235014.355-1-smittals@...2857...>
Subject: Re: [Openvpn-devel] [PATCH] Add compatibility to build OpenVPN with
 AWS-LC.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shubham Mittal <smittals@...2857...>
Cc: openvpn-devel@lists.sourceforge.net

--zbsFriU502vjuWoL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 27, 2025 at 03:50:14PM -0800, Shubham Mittal via Openvpn-devel =
wrote:
> +    export LD_LIBRARY_PATH=3D"${AWS_LC_INSTALL_FOLDER}/lib"

This does not sound like a good way to get reliable operation - much
better is to use -Wl,-rpath at compile time.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zbsFriU502vjuWoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnmIG3AAoJEB2Cnv7KVigSuPsL/iTzi4pmW1cHsPeUZXx3lyM1
vs9GP6ai3MSi1bHOx4rrZYTpsZyHaZoWdCGPHepE98H5PoQ4cLPZSZaBSl5uE2Vq
Mr57D4mpRxo4TTQIYl13F7ETxRFXK2dUZktuTnaDb1V0wuLO6moQmtsRXMyo9q4A
m7weWRYSTK3tlDgWcLLLExOiMWNtWc/GgfbJwZbs6zjolEKcwbhITy07Kv8HhJX0
gff9yrWVi0n9vBNTe/OKddPuAj9NNViaQ/LSG0Fga4/1otFLEEmC66br7a2ZfeRy
SIiZHjB4j6RdjfLZtPKMILPeei5IGvvsyOgBzaCErXRdDVLskoNajG1H85aNZ6XQ
lz8EyfC9tA/ECpmEqmW6dTRuuLQe+x/y3wVUbD2w1a9Sc/vjG1ETR/xdYtNnJN7s
MGWTGBFEcnYJgroiJaoCWo3KaS3vQukFw46NXxoy6GgdsaiWX2q0ALEXgSJqQTcL
AyPea4rhkMc+Vg6UShzSLfUaG6evv0OHw9dHHkAI+Q==
=4Lal
-----END PGP SIGNATURE-----

--zbsFriU502vjuWoL--

