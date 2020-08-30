Date: Sun, 30 Aug 2020 22:37:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200830203720.GX75094@...1296...>
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
 <20200830120703.GV75094@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MxYQAzdbOWKZB282"
Content-Disposition: inline
In-Reply-To: <20200830120703.GV75094@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MxYQAzdbOWKZB282
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 30, 2020 at 02:07:03PM +0200, Gert Doering wrote:
> On Sat, Aug 29, 2020 at 09:42:46PM -0300, Rafael Gava wrote:
[..]
> If it still doesn't do that, you found a new bug :-)

So - patch has been merged, and I think I have set up an appropriate
testbed to verify this (2.5/master talking to 2.3.18 with OCC enabled).

With Arne's (v2) patch it is no longer failing.

Can you re-test your scenarios, please?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--MxYQAzdbOWKZB282
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfTA3/AAoJEB2Cnv7KVigSEhAL+wQ/SEJasmssHCFNQDQu657W
ND3Zo7m9kCSlixG4gvwPDkzISewBu7nc+ZK+yJrpWpGG8VlwjkbIcT5rd1w4PVbw
bcwfUwHmM6GJwnsMXZwpxKoHXNQiR8nWhWsNwV+SJOoOX/n9aqxxDm+CBi1CIgvH
+rVpnjBvoar9HuVhMdH+WIHnAGVag6mSI29QvXIJIIQmNX0Jmbll1rniozXhDwGa
OsqAgcOyQcrMbhgcxKssjFCPr9kVtomzDMmGdzADWsprxBQBWdhWhrVeFLpbNcZX
TVEYrfEar5kiK31iPJRJwZQjct7u+UUDec5ocjWAWzXQts5xVAU3cIA1Z9qEE/b6
F41/UfeJkUA308sxZ5TdDbR5qzyrKWPCVLM0abeqfSBPFTeEurR6Y6mFMcvu3rT5
YjjrRQOWDyJajEaAaUkBOv4my/gxxBwkH1SgdwwojS1/eT6VZ6FupufY+DTPSplF
DVifNiwohHQhP8Z5qWBZk080mzMnBdBY0N55ebUp2A==
=Smls
-----END PGP SIGNATURE-----

--MxYQAzdbOWKZB282--

