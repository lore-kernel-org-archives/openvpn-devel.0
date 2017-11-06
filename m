Date: Mon, 6 Nov 2017 22:10:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171106211039.GA958@...1296...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yAnL4aV/QzGiAmsL"
Content-Disposition: inline
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
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
Cc: Selva <selva.nair@...277...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yAnL4aV/QzGiAmsL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 06, 2017 at 08:35:48AM +0000, Simon Rozman wrote:
> > To repeat, =A0cast does not eliminate a potential for error, it just ju=
st hides it.
>=20
> True and I totally agree with you. I just didn't dare to rewrite the func=
tion more thoroughly. Can I, please?

Refactoring is definitely welcome for master, and can be argued into 2.4 if=
=20
it fixes things that need fixing...

(And thanks for taking your time to explain the background for all these
changes - I haven't had time today to do more than just read all the mails,
but they were helpful - thanks to Selva, too)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yAnL4aV/QzGiAmsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaAM/PAAoJEB2Cnv7KVigS9vwMAK4p26V9r5Nqe2OJFtjJtX+7
EXs9u0ub/COLXsTbYP0I7gDjdFYU80aNqm7jBcNL+xAe6WSRHU5GG+NE6EbsXGlo
wIUQyj/EeixijEIrE8dQMDENP67HAsrU3FPVGAUGjZ301Ae7JiqWQCklGaptTLHB
StzVh7DZE7ixDXPXvxM1UHr4ZX5VOWXQ0bXuG7xoWPaOA70b+v4to/D1YrgJ3PPP
IFIFDQ6ALPyHXYnK2PSXQ95tGTdMMsRm8U6COa7hyiV0kdJfnyvSmvkrcc4B773M
Flder9B7Wqr91wBmruMLVUL3/R3HbeL7it6Wbrk8ZBNXN8eOeRb3gDbctoSY5Z/7
v8o39yilqt381b06lxk0x/ENSYnnBTxcTAwZxabFG/vUTOs1DQxFv9+TelZZtAsj
4Sfc2KnGVE4cMoa5okx9Y4mMjItRTWQyLOxEBiacdGefVYc33i4aj4zzMJMdaXRQ
Yty4e6i1BQdyREPygXVIgq0yIHKKZxEHzt40ekLVBg==
=FYkF
-----END PGP SIGNATURE-----

--yAnL4aV/QzGiAmsL--

