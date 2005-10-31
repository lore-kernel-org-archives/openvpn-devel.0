Message-ID: <436645A3.2050808@...411...>
From: Giancarlo Razzolini <linux-fan@...411...>
Reply-To: linux-fan@...411...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [bug report] DOS: openvpn 2.0.2 segfaults on
 Solaris 9.
References: <8ECE85B9-4A29-11DA-9F53-000A959A666C@...487...>
In-Reply-To: <8ECE85B9-4A29-11DA-9F53-000A959A666C@...487...>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig28EEBBA5A3384CD3B3B2AE3D"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 31 08:27:10 2005
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28EEBBA5A3384CD3B3B2AE3D
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Marc Br=FCnink wrote:
> Hi list,
>=20
> I'm posting this there in case someone already fixed it or is disposed
> to fix it :-)
> First of all: OpenVPN is great! Thanks for your work!.
> Second of all: I've encounterd a reproducible bug :-(
> I'm running
> OpenVPN 2.0.2 sparc-sun-solaris2.9 [SSL] [LZO] built on Oct 17 2005
> on a
> SunOS sun 5.9 Generic_112233-12 sun4u sparc SUNW,Sun-Fire-V240
> machine. OpenVPN is running in tcp server mode. Everything works perfect
> unless I do a portscan on this machine. Then OpenVPN simply segfaults.
> I'm using
> nmap -T Aggressive <ipaddress> -p 1194
>=20
>=20
> Mon Oct 31 17:08:03 2005 us=3D485855 PO_WAIT[0,0] fd=3D3 rev=3D0x00000001
> rwflags=3D0x0001 arg=3D0x00000001 [scalable]
> Mon Oct 31 17:08:03 2005 us=3D485945 MULTI: REAP range 16 -> 32
> Mon Oct 31 17:08:03 2005 us=3D485973 MULTI: multi_create_instance called
> Mon Oct 31 17:08:03 2005 us=3D486033 PO_INIT maxevents=3D4 flags=3D0x0000=
0002
> Mon Oct 31 17:08:03 2005 us=3D486059 Re-using SSL/TLS context
> Mon Oct 31 17:08:03 2005 us=3D486091 MTU DYNAMIC mtu=3D0, flags=3D1, 0 ->=
 140
> Mon Oct 31 17:08:03 2005 us=3D486108 TLS: tls_session_init: entry
> Mon Oct 31 17:08:03 2005 us=3D486221 PID packet_id_init seq_backtrack=3D0
> time_backtrack=3D0
> Mon Oct 31 17:08:03 2005 us=3D486364 PID packet_id_init seq_backtrack=3D0
> time_backtrack=3D0
> Mon Oct 31 17:08:03 2005 us=3D486398 TLS: tls_session_init: new session
> object, sid=3Dd9b0a377 97bb2ba0
> Mon Oct 31 17:08:03 2005 us=3D486415 TLS: tls_session_init: entry
> Mon Oct 31 17:08:03 2005 us=3D486437 PID packet_id_init seq_backtrack=3D0
> time_backtrack=3D0
> Mon Oct 31 17:08:03 2005 us=3D486503 PID packet_id_init seq_backtrack=3D0
> time_backtrack=3D0
> Mon Oct 31 17:08:03 2005 us=3D486530 TLS: tls_session_init: new session
> object, sid=3De7b0b371 1f6a5f51
> Mon Oct 31 17:08:03 2005 us=3D486558 Control Channel MTU parms [ L:1543
> D:140 EF:40 EB:0 ET:0 EL:0 ]
> Mon Oct 31 17:08:03 2005 us=3D486583 MTU DYNAMIC mtu=3D1450, flags=3D2, 1=
543
> -> 1450
> Mon Oct 31 17:08:03 2005 us=3D486609 Data Channel MTU parms [ L:1543
> D:1450 EF:43 EB:4 ET:0 EL:0 ]
> Mon Oct 31 17:08:03 2005 us=3D486688 Local Options String: 'V4,dev-type
> tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_SERVER,cipher BF-CBC,auth
> SHA1,keysize 128,key-method 2,tls-server'
> Mon Oct 31 17:08:03 2005 us=3D486712 Expected Remote Options String:
> 'V4,dev-type tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_CLIENT,cipher
> BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
> Mon Oct 31 17:08:03 2005 us=3D486775 Local Options hash (VER=3DV4): '7e06=
8940'
> Mon Oct 31 17:08:03 2005 us=3D486809 Expected Remote Options hash
> (VER=3DV4): 'db02a8f8'
> Mon Oct 31 17:08:03 2005 us=3D486832 STREAM: RESET
> Mon Oct 31 17:08:03 2005 us=3D486848 STREAM: INIT maxlen=3D1543
> Mon Oct 31 17:08:03 2005 us=3D486932 TCP: accept(3) failed: Software
> caused connection abort (errno=3D130)
> Mon Oct 31 17:08:03 2005 us=3D486962 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487030 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487048 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487063 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487115 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487130 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487146 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487159 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487179 PID packet_id_free
> Mon Oct 31 17:08:03 2005 us=3D487206 MULTI: multi_close_instance called
>=20
>=20
> If you need further information or need someone to test code -> Drop me
> a line. I would love to see this bug fixed, because it's actually a
> pretty easy DOS and prohibits the use of OpenVPN on a production machine.
>=20
>=20
> Many thanks
> Marc
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
One question:

This happens if you are using the tls-auth directive?

As far as i know, if you use the tls auth, the packet that the nmap tool
generate, will be dropped, as it doesn't have the right hmac code. I
think that using tls-auth can be a temporary workaround until that bug
is fixed.

my regards,

--=20
Giancarlo Razzolini
Linux User 172199
Moleque Sem Conteudo Numero #002
Slackware Current
Snike Tecnologia em Inform=E1tica
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85


--------------enig28EEBBA5A3384CD3B3B2AE3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFDZkWver67q5wOa4URAx3BAKCUjdKqH5NQC0CWYke7ymFLmG3bMQCguJLh
ZcWiOMI0v8WdHIOWPUvD3Lw=
=SzR5
-----END PGP SIGNATURE-----

--------------enig28EEBBA5A3384CD3B3B2AE3D--

