Date: Thu, 7 Dec 2017 08:55:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171207075514.GF69387@...1296...>
References: <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
 <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
 <99D61A626FDA8A4B90A270669121BE10858830C4@...2294...>
 <20171204192515.GA69387@...1296...>
 <99D61A626FDA8A4B90A270669121BE1085B4AC9A@...2294...>
 <CAKuzo_hJdNEMMmUqa4d=n4k9vZXoYtkC9CFcvAkW9cDgzT2wCA@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4CA4D@...2294...>
 <CAKuzo_iAJxP9AmGvApNXno7yw5q_rn5jQko+bUePmdXqUXgmgQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085B4D703@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lpUp1egui7PDlNtH"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085B4D703@...2294...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lpUp1egui7PDlNtH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 07, 2017 at 06:41:03AM +0000, Simon Rozman wrote:
> > > Should your patch be merged, I shall rebase the "[PATCH 09/13]
> > Signed/unsigned warnings of MSVC resolved" to the new master and deliver
> > the next version.
> >
> > Yes, if you can review and ack/nak it :)
>=20
> You mean Gert to ack/nak it? I don't believe I have earned enough reputat=
ion to do it yet.

Formally we have no really clear line on "who can do ACK/NAK" (and this
has caused a bit of friction in the past, my fault, apologies).

I tend to see ACKs as "I have stared at the code, ran some tests, can't
see anything bad in the code and the change is useful" - but usually,=20
David or I do our own review and tests before actually merging.=20=20

Depending on the "track record" of the one sending that ACK, it might be=20
a very loose review, or very thorough :-)  (like, when Steffan ACKs a crypto
patch, all I do is "does it compile and pass t_client test?", but I do not
try to understand crypto library API nuances...).

Sometimes I find things in post-ACK-review that reopen the discussion,
though :-)


NAKs are maybe even more important - "watch out, this code might break
under circumstances x, y, z!" - while the reviewer only considered cases
a, b and c...

So - feel free to comment on patches you feel qualified to review!


> However, I did stare-review your code:
> - It does not introduce any new Windows API calls it has not used before.
> - It compiles fine.

Good enough for a start :-)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--lpUp1egui7PDlNtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaKPPhAAoJEB2Cnv7KVigSOooMALHeX05+TiN9IJ4pAnpHt7q/
uN//lb9Vyp3oQrXMUIKeuCCFPEs+swGptAbmF3oeCqkCMlrEgdHlJcIRMlKwTXX1
OWE/7IS6S2876ssCWLyO/3ducJXxiZpK4/bN5XIsTDF6ldgsmSMEGytfNjii+W89
mdaLZe9d6DnSU4nJDpReu92BPyFYsh6pqy7y5LQpWwSRh3MU1rlHbAHjr3lyq1KR
VjOjnAFfk+tX05K1XSw6SDqO2uB3Q8axDfbTSO6nAjHYAUlSjDhvGOKyEbtYvIjG
uTg/8RWamW8bjshNFZWSlbtBf3wTl54CBnKUfrwIRBj29yAlkILKoeIjyqPmfwFe
AhKqYMtar7Qeij9Yi5gsFF9LahfKOgeBey3kLD1zP7d0idnXpX/fPDoLoNX10TRS
9rBtRYL/VGxG7eFPHja8sd9mMfXn+zG5+r2j1+pW3Fwc3I4hJ4LlK6tqPV6QLHzQ
f82kt03pofpKYUEQe/5zBxkgL4T/smPkYCXgVvkj6g==
=ZsYT
-----END PGP SIGNATURE-----

--lpUp1egui7PDlNtH--

