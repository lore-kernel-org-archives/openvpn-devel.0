Date: Wed, 22 Jul 2009 12:05:41 -0400
From: Ricky Zhou <ricky@...1239...>
Message-ID: <20090722160541.GB14322@...1240...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
Subject: [Openvpn-devel] Signal Handling Races
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, we recently noticed a race condition in signal handling in OpenVPN,
which we were able to reproduce pretty reliably using:

PID=3D$(cat /var/run/openvpn/openvpn.pid); kill -USR2 $PID & (kill $PID)

I took a look at the code, and it look like the signal_received variable
currently holds only a single signal at a time, so I am guessing that
the SIGUSR2 signal is overwrites the SIGTERM from the kill before it
gets handled.=20=20

I'm not too familiar with the openvpn code and the portability
requirements around it, but perhaps this issue could be fixed by
converting signal_received into a signal mask instead.  I did a grep
through the code, and it looks like most uses of the variable could be
replaced with the appropriate bit operators along with sigmask() calls
to prevent one signal from overriding another.  I'm not familiar with
what other race conditions/other expected behavior this could lead to
though.

Do any more experienced developers have any thoughts on how this issue
could be handled?

Thanks a lot (OpenVPN has been really great for us),
Ricky

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpnONUACgkQrH1ufGsbJY1a8QCg1SffMQ3mAgzIqRXF2R/dV1uP
0HgAoM0esi2yp7MLPNkLlYRU8pPC1NZm
=nlxp
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

