Date: Thu, 16 Jul 2020 22:42:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716204243.GI1431@...1296...>
References: <20200716134315.17742-1-arne@...1227...>
 <20200716134315.17742-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bGmPrD/DuIqV6f11"
Content-Disposition: inline
In-Reply-To: <20200716134315.17742-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7 5/6] client-connect: Implement
 deferred connect support for plugin API v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--bGmPrD/DuIqV6f11
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2020 at 03:43:14PM +0200, Arne Schwabe wrote:
> The V2 API is simpler than the V1 API since there is no passing of
> data via files. This also means that with the current API the V2 API
> cannot support async notify via files. Adding a file just for async
> notify seems very hacky and when needed we should implement a better
> option when async is needed for the plugin V2 API.

Test reports... not actually *using* the API yet, just confirming
that nothing else broke.

22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
23.small...
Test sets succeeded: 1 2 3 4.
Test sets failed: none.
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5x 6 7 7x 8 8a=
 9 2f 4b.
Test sets failed: none.

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bGmPrD/DuIqV6f11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfELvDAAoJEB2Cnv7KVigSjwcL/RByOmnVoFzRISe83k9EXHgL
4/X2mo0yb39/KCanhkLWdNT1iW55QCeYiAR02wrUfrgl2PH3/YIH382MYvYP/p62
DFrHDerxE1SfpL8pUPCh8xUz5E9xMxRllTW5XoRcHgryc2Hb+957h6QHOSD7Qbl6
PDytnKBMisymhVbkW7oshKV7/hFvUF2bQBesge2UAS52SsS4Oenk+kNnCUrIHoRR
dr1CFYtCjqTUZiPZdif/RvVQwdYKn9RVLTqePxaNNYR+27+Rgc5/SyaONg/zDFKG
RFKvtLu6W1bIUjg2PVnlbdxD7vD705QakkyGKHp/XfYJTemMaRb82z7v+rJqTUmL
5xkeVNMlRJpOKuqTFavBWB0v7NIp4O6CjfC9/+oq82YGm1sWlonr+c0K6lyBTIm/
vAq8Zu4QD6y1GK8WiIDfdTID6Fbn8sksHMqlRQ9JyWyBLbrXEMW1lmWuyIhviuKP
vv/kDxoWpGUWAZzvkox1jfKE74kfZ0tr5r1AqaDskQ==
=1EHw
-----END PGP SIGNATURE-----

--bGmPrD/DuIqV6f11--

