Message-ID: <e47de223b3653117c4b63d5d9c23cbc8.squirrel@...1166...>
In-Reply-To: <201010190214.06504.lists@...646...>
References: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
	<201010190214.06504.lists@...646...>
Date: Mon, 25 Oct 2010 08:28:02 -0500
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Intelligent OpenVPN service?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the replies!  I should have specified that the servers are
Linux and the clients are Windows.  I have no experience with routing
protocols on Windows systems, but I've seen plenty of issues in our
Windows applications when someone changes their connection while
working.  I think we'll try blocking our internal IP ranges at the
servers first, it sounds like the easiest (and least complex)
solution at this time.

Great to see the ability to have both UDP and TCP connections in
a single config file now!

Daniel Johnson
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzFhI4ACgkQ6vGcUBY+ge9U7wCfTISfn69MqJnd5VtHDoOAzJuH
S/UAoIrK5Ean0qUUHYGRZHewThhZDgGQ
=cbGJ
-----END PGP SIGNATURE-----


