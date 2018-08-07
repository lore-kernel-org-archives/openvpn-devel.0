Date: Tue, 7 Aug 2018 21:07:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180807190716.GI55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="plEkktn9NN5SnyCD"
Content-Disposition: inline
In-Reply-To: <20180807185937.GH55859@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--plEkktn9NN5SnyCD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 07, 2018 at 08:59:37PM +0200, Gert Doering wrote:
> > v2: Depends on the base64 export patch
> > v3: match password string with "SCRV1:" instead of "SCRV1"
> > (pointed out by Joe Bell <joeaintexas@...277...>)
>=20
> Nicely works and does what it says on the lid.  So...

Talking to myself a lot, lately...

Found an interesting caveat which should be addressed, I think.

Our system (LinOTP) knows "PIN+OTP" or "PIN" as valid input, the
latter leading to "send me a token by SMS/e-mail/...".

If I press return at the challenge prompt, it seems the SCRV1: string
is not formed the way the plugin wants it, and I end up with

  pass=3DSCRV1%3AMTE5NQ%3D%3D

in the LinOTP URL - so, it didn't decode it, because the second ':'
was missing (if I put a blank in there, I get pass=3Dmypin%20).

Is this intentional?  Should it be that way?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--plEkktn9NN5SnyCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbae3jAAoJEB2Cnv7KVigSt7EL/1TEkLJiuRz+KWRZ/BmKOrom
8nuBqlYvzq0BUAtz6slQ8eJ8fjfIVYyiHP+NkVc7iw1j7Zg3yaTCFk6rbJ9hhO6P
wtdIuHUZt2OnZwlPUZCuRjlCsVO3OnryzKgnd2PdqgeOZdejpcD30tbS4sTZ0ief
k5wDt0rizXtplx11WIIZBgs/VZfixNgmR6zl9yVsA2sVuMRQ8i3ZuDPPQURzwPir
eA4pvpUYuUvsDoK1k9RTeZ29cbw/9d1abFGWO+FlFQnk9XsgDpSdDqbqtsxr5KnH
COJYrHYuaYJdjSuHBPsBPglwyKB94qlNNHTRG7HAnLwa0yoiQkhI0eB4IMsYoTh5
ZIinsXSEtv6pXE/SRuI5Dn4nU+5GAxoVQ5X3NexQXWwefTfnPSb2X4lq16pZFoWG
pSkJKOomx+77X2g4IIfFSPLIQ+c9xjzWRrHjKwaByXmp1bh4Z7zwUkj1oZPW7mvJ
ULIVl5prEfxnvamjOOvFyKPjuzp2eoLEYCx5H8VmEg==
=I+Oo
-----END PGP SIGNATURE-----

--plEkktn9NN5SnyCD--

