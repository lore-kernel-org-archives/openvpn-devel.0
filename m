Resent-Message-ID: <20210307162218.GO976@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Sun, 7 Mar 2021 16:45:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210307154531.GN977@...1296...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0232995696115418921=="
Errors-To: openvpn-users-bounces@lists.sourceforge.net
Subject: [Openvpn-devel] [Openvpn-users] --mlock and RLIMIT_MEMLOCK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--===============0232995696115418921==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mq86sqTUaq3JAW7H"
Content-Disposition: inline

--mq86sqTUaq3JAW7H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm considering adding a check for "is there sufficient memory available"
to the --mlock switch, to avoid hard and graceless out-of-memory crashes
later on (trac #1390).

OpenVPN would refuse to start if "less than <this> amount" is available
(ulimit -l / getrlimit(RLIMIT_MEMLOCK)).

Now I wonder what a good minimum amount might be?  My various=20
long-running openvpn processes seem to consume somewhere between 6 Mbyte=20
(only 3 clients) and 31 Mbyte (up to 150 concurrent users)... so=20
requiring something like "50 Mbyte" would be plenty.

If you use --mlock - what do you set your "ulimit -l" (or systemd
LimitMEMLOCK=3D... value) to?  And why?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mq86sqTUaq3JAW7H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRPUbAAoJEB2Cnv7KVigSSnsMAK2DjP/kwl1715X6YDhoHvse
e96ApkdMc1O3Hs2bNJSX1CmRM3Q6Rm1EXB7ZoTRE1GuYlrf0xcPYZNPpnvjx7382
zLcOnUL+t+GtOQ62HKbuzXwiFUPzwej2sWFZqNZqb0T5M4qi+5+RiLMSjsFPga3N
AOfHyX9GPOnGKoigPuETNgxMvmIohGdPuUMCONzG02FzREco/95/g2vvyAFiYjPJ
j222PJIvNIjl1Hgrrf8sAzmJUY4UwH92VwAQ+mt568M2zbgn04ym4kRKU5yw+ZVj
kB2kXy10zjuoztFLz8Q07sxycDR7lHNGssIdJoNED9pSzk7KrLl8Uw76mI6pjVcq
fJY2EsAjJlp2lCHEOpYuTX+GkcRIxKNdSZwlAhpdOIE3HC4U2Aq8TuhPCKqcrcPR
DMz5FGi2JCXdl4yGs7hTo2r0hjnzLHR3Pi54mZ7gf+3vqR15cdfUWEMrEOdKsP46
SObSAcHC7sq3/PWW0HlihrRkKjbUX6UrwTXIGDttug==
=7rJ1
-----END PGP SIGNATURE-----

--mq86sqTUaq3JAW7H--


--===============0232995696115418921==
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0232995696115418921==
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-users mailing list
Openvpn-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-users

--===============0232995696115418921==--


