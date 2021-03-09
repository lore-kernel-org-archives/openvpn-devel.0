Date: Tue, 9 Mar 2021 22:43:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210309214303.GY976@...1296...>
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
 <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wfc5qiGDE5Y03o3k"
Content-Disposition: inline
In-Reply-To: <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Wfc5qiGDE5Y03o3k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 08, 2021 at 09:06:10AM +0100, Arne Schwabe wrote:
> That being said I am against your patch, I am just wondering if that is
> a feature we need to keep at all.

Just for clarification: is there a "not" missing in that sentence?

(Code-wise, mlock / *rlimit is just ~40-50 lines of code, isolated to
init time, so it really doesn't cost/save us much either way)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Wfc5qiGDE5Y03o3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgR+vnAAoJEB2Cnv7KVigStDMMAKyLbKZBWptdXHl8nCaxl1HU
TGeJmHuGBD3EM0firZlOqaRRRjjfJiZKzvj1+LmWyom7tFjwJZJxN03Fp+AT//0d
whJpSmJv1Y2jmKBrTRcMp032N9ahvp8rO09mgQkYJnmZhaWT3MasGHjZR5kHPamd
lAY22WlqowAcQ2LoqP/gBGJaIlTcwISLQ6y5+krhaOkHfMtFiTBhHs9ZlJAswr/1
yWmE8MZSJRe4HcIo8k/FKjyDRsXhnIDaYAZY+CJbxEnmL7McbAQQFX0AG/ClB4nB
Db6M2po6wqylkIc+m/b5E5avjZuiGMBCf5FRRnnAeNq+YRlFN3xwyAQ3OMSSBxPY
/Kouab/ckFK7w4lKsKFID/f7jfvOSff7m91RQ/vjYAhQKmYNwtB6uDjpnk+AnUtn
IABXWl/ofHVQV59ukkk6Y0uGl5GFGZv480zRq464tGO1cJN25ozPp3NqaQmF7i5q
EDPeio32kYKE2L0SF2YBZZey6azr0FMlv1XEyxIsqg==
=3Lxg
-----END PGP SIGNATURE-----

--Wfc5qiGDE5Y03o3k--

