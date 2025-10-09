Date: Thu, 9 Oct 2025 16:52:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aOfMSG1vCAcERw8D@...1296...>
References: <20251008170202.10333-1-gert@...1296...>
 <202510091450.599EoMbS040917@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FpyzF+Ivy88D+YZ5"
Content-Disposition: inline
In-Reply-To: <202510091450.599EoMbS040917@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: options_util: Fix
 conversion warning in atoi_constrained
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--FpyzF+Ivy88D+YZ5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 09, 2025 at 04:50:22PM +0200, Gert Doering wrote:
> Trivial and definitely save :-) not tested beyond "BB all green".
>=20
> Your patch has been applied to the master branch.
>=20
> commit 5ec23295f03bec3e241f65363bcd0f5b0b2afde6
> Author: Frank Lichtenheld
> Date:   Wed Oct 8 19:01:57 2025 +0200

Or not...  wrong mail archive URL, corrected, did not adjust the mail.

This is what I will push now:

commit 8fd8c4fa5d6c113925ebf42d47d9e8d3f292309f (HEAD -> master)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Wed Oct 8 19:01:57 2025 +0200

    options_util: Fix conversion warning in atoi_constrained
=20=20=20=20
    The whole purpose of the function is to make sure
    that cast is safe.
=20=20=20=20
    Change-Id: Id08524661aa5bcc5cd42f27a1aacc636e2b2b004
    Signed-off-by: Frank Lichtenheld <frank@...2641...>
    Acked-by: Gert Doering <gert@...1296...>
    Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1261
    Message-Id: <20251008170202.10333-1-gert@...1296...>
    URL: https://sourceforge.net/p/openvpn/mailman/message/59244107/
    Signed-off-by: Gert Doering <gert@...1296...>

(same commit, different URL: in the message -> different ID)

sorry,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FpyzF+Ivy88D+YZ5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo58xIAAoJEB2Cnv7KVigSk1MMAKxilkVe0ze9FS56N7DPKjdR
+iXugVfx8Ar3wUpfc95U0XZsHepd6HvvPtFACjD2XyZ5ZZqsTlfWhBKOVtwxdeVE
JLbUdLB4roCR2v/O8z2LzdTHbdsJzbxpkNaZDkJZTlqLDD4blNPlODMoP4ovPKyg
z9BaP3jvzrlQHtbka4OTrBNMG9fHVhxa1yKgBo0ATheojqQSd+/dySIk7rE6zJnq
vUhr4UHB/+qbM9BzgYNuHkCD+wUxJjd89QOPZ/8HhWAkDdhaZGpmYYKrYGCTzKkO
bj5KpyBECEqx58+ZxNXSeq+aVsVAMKIkPopa4M3odwMEeKujU3uK3KrXzF8tW3IW
SEvS1AtQtyQ49S0HIXb5yGyunhOy/1GzuceWk05pqfaJTDmauHRtJcvXiaq0Hz6b
xOKV3aExgZIRxFnN9sygw9P5sTZ0omFIstnZF8qHLRi6P6m3BudARzU4DqgIqpF7
SnCjlxUfHxFFWx7u1l7PrZqhdJ0zJ2jl5JiD14ORmQ==
=ifoq
-----END PGP SIGNATURE-----

--FpyzF+Ivy88D+YZ5--

