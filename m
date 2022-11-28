Date: Mon, 28 Nov 2022 12:55:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4Shyldcb82P6An8@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pyMcMJDe5VU+6763"
Content-Disposition: inline
Subject: [Openvpn-devel] new P2P NCP wart...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pyMcMJDe5VU+6763
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

if I provoke an error by having one side of p2p tls OpenVPN "with default
options" (=3D AES-GCM) and call the client side with

   --data-ciphers BF-CBC --auth SHA256

then - as it is expected - the negotiation fails

2022-11-28 12:50:09 P2P mode NCP negotiation result: TLS_export=3D1, DATA_v=
2=3D1, peer-id 8195149, cipher=3D(not negotiated, fallback-cipher: BF-CBC)
2022-11-28 12:50:09 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GC=
M_SHA384, peer certificate: 2048 bit RSA, signature: RSA-SHA1
2022-11-28 12:50:09 [server] Peer Connection Initiated with [AF_INET6]2001:=
608:1:995a:250:56ff:febb:2084:51201
2022-11-28 12:50:10 ERROR: failed to negotiate cipher with peer and --data-=
ciphers-fallback not enabled. No usable data channel cipher
2022-11-28 12:50:10 ERROR: Failed to apply P2P negotiated protocol options

... but the interesting thing is, OpenVPN still thinks "this has succeeded",
or so - it's sitting there, happily consuming packets on the tun interface,
and never sending anything out the socket interface...

(This is "master of a few weeks ago", without DCO involved)

--verb 7 shows...

2022-11-28 12:55:25 us=3D199080 ERROR: failed to negotiate cipher with peer=
 and --data-ciphers-fallback not enabled. No usable data channel cipher
2022-11-28 12:55:25 us=3D199092 ERROR: Failed to apply P2P negotiated proto=
col options
2022-11-28 12:55:26 us=3D226535 TUN READ [84]
2022-11-28 12:55:26 us=3D851927 TUN READ [96]
2022-11-28 12:55:27 us=3D62746 TUN READ [96]
2022-11-28 12:55:27 us=3D299083 TUN READ [84]
2022-11-28 12:55:28 us=3D326477 TUN READ [84]

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pyMcMJDe5VU+6763
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhKHKAAoJEB2Cnv7KVigSCRUL/iGo5dJTyvDXy8kamOh+hVnc
lFBRSLPhBIf0LxgEMf6p/aJ2MC2QSePpqW8CDwVy/eqAmcYeCDq9A5VT33EPpMtr
QI6ZdbLU7KT1uAphjudeh+oDqEDaFUici4QtV45EmKonXb/iBbUehqamKphQEoZW
gEbYLF4HgaZHPWgnohpcXHWfYVZDn9oXFL6LMe/zk+SU+gY0oA/HylJmxN9+EIBL
tsvkXVC7HQesb0avC6G1jN0FOSFH1jQNMx3DxFAWNQkW7ctjn7pId333qgsA/OZC
I2Y8WQO2spSuNK6MSjSj0DJLmdntpLb5vqbZ5rJ2PEsE8AubpFTGOCjynkh6US65
U0SRXo3v+zOkAMl3GlDYaX19XQKbLqwbpVJYvQXRn6cswOQRJmHYY0JE2ShaOzJr
t4twCoeczDXJCRsVvJZAW84QB+Ck1+O/9IJFuCrDTQp8XjekxlWI7yXVpTO8qagQ
KIMvtu5MwcRCWNMDoubcVF+aACyBjM9ee2+OBeEwnw==
=msiC
-----END PGP SIGNATURE-----

--pyMcMJDe5VU+6763--

