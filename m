Date: Thu, 20 Jan 2022 16:44:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YemDUlYaDHPKIk5b@...1296...>
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-18-selva.nair@...277...>
 <Yel23CnlcOirY904@...1296...>
 <CAKuzo_hvFFxArr2DOKRhCo=LOChZmutxDCUqakDfobT1dvmiGg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CIz9gsXMAFha1eAh"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hvFFxArr2DOKRhCo=LOChZmutxDCUqakDfobT1dvmiGg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 17/18] xkey-provider: Add a test for
 generic key load and signature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CIz9gsXMAFha1eAh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 20, 2022 at 10:21:19AM -0500, Selva Nair wrote:
> Yeah, a previous version had checking for OpenSSL version in configure.ac
> and the AM_CONDITIONAL made sense only in that case.  I can send a
> new 16/18 or please do squash 16 with 17.

If you could send a new "16+17 v4" that would make my life easier
in not having to think about joint commit messages :-)

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

--CIz9gsXMAFha1eAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6YNSAAoJEB2Cnv7KVigS2d4L/3DyxAnpBEGhwuLcbKlT7e6h
b4OJkg46Cdn7l81S9UXRvLQrwf/8sqUTU3PLZcyw+8/Tj5TbnhKXbPh2iPklFmjC
WkN+hSnSTqExAEAf71lwctJmfVXjvw1c98tW8bGL7J0Y2F6bo7VwgjL15quHNtjL
S4Y/Mad/V6CrR/a3sbW0Oaa7brWpLWOTMvSGIy8oSq/rBY7y3ZUxFUrytW15sara
BFUEwTfqEAoP6l/s2L1OdYbo4KL9gDsST7wrciPOdvx1mkpMqWkrYAeWWdPvghM5
2AXz4iyk2FZmJfY6wvNKJtszu91pR1uzsZSlZx+jOULnIhm5F1E9pcY4ii0HP/vJ
iiI4ZFY7xZitdvJoaYEWB8XecBgVNRI2eTGW5s24p8Rhg/sK8vhP/jBenSMTYzBg
fdcXw28kK72hpoMeC8Oy3g5azNOwV+kqrky9+w0EY6yHDWADbn2TjSD9jyCgAc0h
Bl43klk4yZ7o4rneJflXtx/P7BCJABIrlX/K1gPpqg==
=mLBr
-----END PGP SIGNATURE-----

--CIz9gsXMAFha1eAh--

