Message-ID: <4BCF1530.3060100@...1347...>
Date: Wed, 21 Apr 2010 11:09:36 -0400
From: Richard Monk <rmonk@...1347...>
MIME-Version: 1.0
References: <4BCF0259.8070902@...1347...>	<CA8D46C6-BAA6-4BEA-901B-34E1B5B20D97@...1348...>
	<1271861373.1490.4@...1207...>
In-Reply-To: <1271861373.1490.4@...1207...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enig22EB403856B34C794E92C54C"
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
 script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Karl O. Pinc" <kop@...1206...>
Cc: Toby Thain <toby@...1348...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig22EB403856B34C794E92C54C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 04/21/2010 10:49 AM, Karl O. Pinc wrote:
>> Have you considered a local caching DNS with forwarding?
>=20
> I don't see how this will solve the problem.
> What if the closest _is_ a local caching DNS with forwarding
> to the next farthest out?  You still want all the DNS servers
> available in case one is down for some reason.

Correct, and since NetworkManager adds them in the order the server
gives them, having the two methods (native vs NM) operate differently is
confusing and troublesome.  I decided that the server order should be
followed by all clients.

--=20
Richard Monk (rmonk@...1347...) - Security Analyst
Red Hat - Centennial Office: Raleigh, NC USA
+1 (919) 890 8501
GPG Key ID: 0x1EBEF129


--------------enig22EB403856B34C794E92C54C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEAREKAAYFAkvPFTgACgkQb7MZRB6+8SkYfQCbBBL4kW//0e1hmh5NQQNz/CB6
u3EAn0zfr29BevkL19mJI1tzLyJ2Pktk
=5CrT
-----END PGP SIGNATURE-----

--------------enig22EB403856B34C794E92C54C--

