Date: Fri, 11 Mar 2011 12:23:09 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110311122309.1292c1dd@...1451...>
In-Reply-To: <20110309085656.18e0e796@...1451...>
References: <20110308185252.301d0a1d@...1451...>
	<20110309084745.GN9835@...1296...>
	<20110309085656.18e0e796@...1451...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/m.l_ZvcJpwZ0CP/9sPl+xZS";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Sig_/m.l_ZvcJpwZ0CP/9sPl+xZS
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I'm sorry, folks, I'd like to ask for some clarification.

My patch was NAK'd on implementation issues. I offered alternatives
to them. I got no answer to them.

Should I bother implementing one of the alternatives, or will the
patch be disregarded nonetheless? If the patch does stand a chance to
be accepted with a better implemantation, should I go with
getiffadrs() or the current approach to get the interface's IP
address?

	Fede

--Sig_/m.l_ZvcJpwZ0CP/9sPl+xZS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFNej5dbPULDL0CxuARAtzsAJ0Ur7n+lxxF8V2pb2nz9x7qP5xvKgCgvrmI
5TA/qdQGK6yExfum3lumfBg=
=ikoG
-----END PGP SIGNATURE-----

--Sig_/m.l_ZvcJpwZ0CP/9sPl+xZS--

