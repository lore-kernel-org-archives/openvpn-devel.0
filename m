Message-ID: <24624.65.118.50.246.1244149998.squirrel@...1166...>
In-Reply-To: <16130.65.118.50.246.1232730850.squirrel@...1166...>
References: <16130.65.118.50.246.1232730850.squirrel@...1166...>
Date: Thu, 4 Jun 2009 16:13:18 -0500 (CDT)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Loss of routes causes routing loop
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

I've seen no replies to this yet, and I'm concerned that v2.1 will
be released without any resolution.  If one of the experienced
developers could point me in the direction of the code files that
handle route detection/creation/deletion, and that handle reconnection
I think I can figure it out.  My attempts to understand the overall
structure have not made much progress.

On a related note, I'm looking at adding a second interface on the two
main (and now only) VPN servers, so that they'll be 'local' on the
guest/wireless network.  Does OpenVPN do anything special with DNS
results to prefer local addresses?  If not, can that be added easily?

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFKKDfZ6vGcUBY+ge8RAjmUAJ9LyVDhyNyFyEtVJlNMcmsJmoP/KACfbkIQ
2uMaMWScKbUfBB0ATC+HRHI=
=Vmnt
-----END PGP SIGNATURE-----


