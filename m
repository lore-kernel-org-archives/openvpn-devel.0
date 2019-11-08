Date: Fri, 8 Nov 2019 10:02:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191108090233.GB40538@...1296...>
References: <CAFHpkQG4ZiJ0_cG6MRWGQdcajgsuByvu69Q7MfSJxM00FUe2iQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vDz90IqCUeSi4M1R"
Content-Disposition: inline
In-Reply-To: <CAFHpkQG4ZiJ0_cG6MRWGQdcajgsuByvu69Q7MfSJxM00FUe2iQ@...278...>
Subject: Re: [Openvpn-devel] using arm64 on travis ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vDz90IqCUeSi4M1R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 08, 2019 at 12:39:00PM +0500, ???????? ?????????????? wrote:
> https://docs.travis-ci.com/user/multi-cpu-architectures
>=20
> we can switch some builds to arm64. any suggestions ?

Sounds good.  Right now we only have i386 and amd64 builds (since my
SPARC machine is going away and my Pi3 slave is still not operational).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vDz90IqCUeSi4M1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdxS8oAAoJEB2Cnv7KVigS9mUL/ReXTHsme+Cl5FO3S2/dyg2d
P/cgu2XywOl1l22UJSNwQXF7EwSXr2AdDBFtDX3NxodhGU4JuovVWvUwSkbandEA
KjmIxkBQ/fphXEeg3QPTIitCswmgqR/sFANSgXdu7Rm33M8pWD13G8pQyzU3hhCi
rZfHPz52S6h1f2HIL7BIWHpMMLvOnxFhPrOhy3GD4CmtyrMadV2hwx65QqTFNBeP
aWVkM/mM/ww4qcnRXB5JxGL2SyzgWJ/ON/H7SdhP4tD5HLignFhcWq1EeHWwNQcY
ejlLsZ5+IlnnQvm1I+3IvHOalt14cpQdSw9lQ7ZqndtqGi3JLmnf8JkJPipEXN5z
jcTUz8GpXsAP3uWm+F6b5JTfLF6ayy1SRn7kHpDoKdtP6Jo6OXZ6kl7K1VvRAyZ6
wxNVI7rXG/oyWLlLVeFrc3yIeGE5soxqK13xOr/Trox0QJ5s2hW1w1RiQGuBEFLn
BvixMMyQ9604X5aTWz1BRAM4SumUyN8V4kKlfzsKZw==
=DaDP
-----END PGP SIGNATURE-----

--vDz90IqCUeSi4M1R--

