From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Xz+9MBsb55d1K1V7j/Nr"
Message-Id: <1017757881.1525.58.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OBSD more tests done and failed.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr  2 06:45:13 2002
To: openvpn-devel@lists.sourceforge.net

--=-Xz+9MBsb55d1K1V7j/Nr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Either I failed before, or something happened during my tests.

My success-mail might have been a bit premature, since I can't
get it to work now at all. One of the machines is the def-gw of
the other usually, so I might have mis-configured it to not use
the tunnel somehow. 8-(

I was about to test ssl, and didn't get it to work. Then I thought
I'd go back to unencrypted tests and they didn't work either.

Side 1 (OBSD 1.2.3.4) goes like this:

./openvpn --dev tun1 --remote 1.2.3.5 --local 1.2.3.4 --verb 8=20

51: TUN/TAP device /dev/tun1 opened
52: ******* WARNING *******: all encryption and authentication features
disabled -- all data will be tunnelled as cleartext
53: Data Channel MTU parms: mtu=3D1450 extra_frame=3D0 extra_buffer=3D0
54: INTERVAL TRIGGER
55: select returned 1
56: read from tun returned 88
57: ENCRYPT FROM: 00000002 45000054 c85a0000 ff01df4b 0a000002 0a000001
080011cf da07000[more...]
58: ENCRYPT TO: 00000002 45000054 c85a0000 ff01df4b 0a000002 0a000001
080011cf da07000[more...]
59: select returned 1
60: write to udp returned 88
61: UDP WRITE to 1.2.3.5:5000:  DATA 00000002 45000054 c85a0000 ff01df4b
0a000002 0a000001 080011cf da07000[more...]

and side 2 (Linux 1.2.3.5) was set up like this:

./openvpn --dev tun0 --remote 1.2.3.4  --local 1.2.3.5 --verb 8

53: TUN/TAP device tun0 opened
54: ******* WARNING *******: all encryption and authentication features
disabled -- all data will be tunnelled as cleartext
55: Data Channel MTU parms: mtu=3D1450 extra_frame=3D0 extra_buffer=3D0
56: INTERVAL TRIGGER
57: select returned 1
58: read from udp returned 88
59: UDP READ from 1.2.3.4:5000:  DATA 00000002 45000054 c85a0000
ff01df4b 0a000002 0a000001 080011cf da07000[more...]
60: IP Address OK from 1.2.3.4:5000
61: Peer Connection Initiated with 1.2.3.4:5000
62: select returned 1
63: write to tun returned 88
64: select returned 1
65: read from udp returned 88
66: UDP READ from 1.2.3.4:5000:  DATA 00000002 45000054 f27a0000
ff01b52b 0a000002 0a000001 0800fba0 da07000[more...]
67: IP Address OK from 1.2.3.4:5000
68: select returned 1
69: write to tun returned 88
70: select returned 1
71: read from udp returned 88



--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-Xz+9MBsb55d1K1V7j/Nr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qcC4NJYxu+mj1OkRAsOZAJsERGCaWfiH1x4svISowt4/LIxrawCgrktX
JwF13YzwJxg+EsnRcB6bSOs=
=5sum
-----END PGP SIGNATURE-----

--=-Xz+9MBsb55d1K1V7j/Nr--


