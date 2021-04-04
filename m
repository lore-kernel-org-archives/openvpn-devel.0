Date: Sun, 4 Apr 2021 09:32:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210404073218.GI976@...1296...>
References: <20210401131337.3684-1-arne@...1227...>
 <20210401131337.3684-12-arne@...1227...>
 <644fbcbe-a8a8-29c8-4627-52a4b68a60ab@...1227...>
 <BI0R_bP9wGzNAWvqqzbjdzF-Ib-_KyxZqdko1ywRWVRLf5n-RoVLZTIgxrdC3qahIFAgGZG5v_zF9IYhIA8jlhvejRiQ_n1QttyycH3o5YI=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3orQRFBAZkuu3dQb"
Content-Disposition: inline
In-Reply-To: <BI0R_bP9wGzNAWvqqzbjdzF-Ib-_KyxZqdko1ywRWVRLf5n-RoVLZTIgxrdC3qahIFAgGZG5v_zF9IYhIA8jlhvejRiQ_n1QttyycH3o5YI=@protonmail.com>
Subject: Re: [Openvpn-devel] [PATCH 11/14] Remove P2MP mode and check for
 gettimeofday
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3orQRFBAZkuu3dQb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 03, 2021 at 09:16:17PM +0000, tincantech via Openvpn-devel wrot=
e:
> -----BEGIN PGP SIGNED MESSAGE-----
> Before this goes any further, I doubt very much that Openvpn intends to "=
Remove P2MP mode".

This is about removing the P2MP *define*, which means "there is no more
way to compile openvpn without P2MP".

But indeed, the commit subject could be made clearer.  I'll fix this on
the fly.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3orQRFBAZkuu3dQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaWuBAAoJEB2Cnv7KVigSN0oMAIyJd6Dqi/Q5DT3kI71PrcxQ
WfOhP7+QS3W0oxoUSpTTQWe7K3XwNjpsj1R35uxh68UJPOsOmqSAzhSOvjzZciYo
vHQo289OhEO/2QKJ1Y+sebrGLAHCjjCcQsSJmDchDx+8256xyybrn7bCtFvfvBh2
48N/XkX29K8KYP+JhFMVSkWBIrdwTDd7V29DHoKTTPnLFviPyAL2HugXAZq7t6hU
JSmf1yaHT1pTE03ColgSF9G2V5D7A5Mun6Qs9lC3sZV25DqRALT+mZSiT1ZLPw+t
kZtZIXKQP4WAxUOcvZsaCS2Pv49kZnFjikg1yVwaRn9VWZ59y8sjyMa0IWtzCz9l
VVhLRKTe/KvMFOTZZg6qrccer5u+n+pPdzsD7AFt7YNau17pjNk2bLfLx3Uh9vLa
WxF98Eox/rMbsAk3e+8UE/pyPjAtQ5Jw4bX88pH2nFrPio3Hg6CNKtf5v2YGWN/x
AhHQFbALjdHUpr1YrvtTVzaYnKVYOu/mib8qlw3/sA==
=qCNV
-----END PGP SIGNATURE-----

--3orQRFBAZkuu3dQb--

