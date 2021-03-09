Date: Tue, 9 Mar 2021 14:28:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210309132846.GM976@...1296...>
References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
 <20210309124712.GJ976@...1296...>
 <CAFHpkQFqD4HqThaURqi1dCXhjsthDwWg81LdNP4BVWGfGgk_Lg@...278...>
 <20210309125602.GK976@...1296...>
 <CAFHpkQHVGuwiGfAwUsnbPXH47Cj5BHO0V9ep6Dt1EvV9M19mFQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ntH5XsTuuHOwjy0y"
Content-Disposition: inline
In-Reply-To: <CAFHpkQHVGuwiGfAwUsnbPXH47Cj5BHO0V9ep6Dt1EvV9M19mFQ@...278...>
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ntH5XsTuuHOwjy0y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 09, 2021 at 06:26:08PM +0500, ???????? ?????????????? wrote:
> we may keep combo.
> both #ifdef EVP_PKEY_TLS1_PRF and comment related to supported openssl
> versions (to drop support if we decide)

We could, but we won't.

(I can see the benefits, but I'm not the one maintaining these code=20
bits - Arne is, and he has stated a clear preference on doing it the
way it is currently done)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ntH5XsTuuHOwjy0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgR3gNAAoJEB2Cnv7KVigSb28L/2xCzosw3hjSHGMsThzvOgZo
MnaLyJ9oATXp8e7Z5Fw4rh4HE0z40zBwk3aJZFIc6ucEZ1lLT4tdNKMLq8i/x6ca
pUkG3wmQyORbTrtarEkFubkr8GqgHBxE4Yerxw4hKkvCFfq/MBPmPTi50zUQOYAz
bz11SCd5qPjfmov+eTTlerB1hbzKPEyO5lwzvCwPoIhqpdY9d1qzWhsg6Yj8UBlp
LwHbH4nmwMsAwcwZfFOHNZ9r4wOA3uolrRa/tgjPLPt3ci3zYbDAun6UtZtz75MJ
hwUh/MGIQYhhLrgYuxX+qLe+e/gnWJUtBwEXHuZND3yefeDusskjYkJsifLk8JQ1
iasCJPM8eoGc8WIg0d4stxGydFn17+VuZM3Ozozy3uV3+v7G45N8imdkAIUceZ1J
4m7Gp5xTXLm+6zeL/Gvy0QKyHKOf73nhnwfKSGbvqi3UcQIK2e7LYAb3LQgqaQ3a
U4DROyvt+Qs33OfOuQ9wngvHMaoJ+o+0+jWvujGjFg==
=qsoL
-----END PGP SIGNATURE-----

--ntH5XsTuuHOwjy0y--

