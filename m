Message-ID: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
Date: Mon, 18 Oct 2010 13:19:53 -0500
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Intelligent OpenVPN service?
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

I want to set up company laptops and remote desktops to use OpenVPN
as a service, but it should *only* connect if the computer does not
already have a connection (such as locally wired or internal
wireless).  Is this possible with the current service?  If not, what
can I/my company do to encourage development of this feature?

As a bonus, I'd like the service to fail over to TCP if it cannot
establish a UDP connection.  However, multiple simultaneous VPN
connections would very likely be bad so I can't just have the
service try both.

If it matters: The goal is to make the VPN totally hands-free,
and to facilitate software deployments via Group Policy Objects
(GPO, which I understand only happens at the logon prompt before
the user logs in).

In our current setup people use the OpenVPN GUI to pick "normal"
(UDP) or "alternate" (TCP), each of which points to a pair of
servers.

Any and all help appreciated!

Daniel Johnson
Progman2000@...1085...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky8j64ACgkQ6vGcUBY+ge9v6wCgj64iwXxIRvEjWkdA5B88FD06
2pIAoLBXDUIvsHsrLyQqEE9qZm9RmqNz
=5fwH
-----END PGP SIGNATURE-----


