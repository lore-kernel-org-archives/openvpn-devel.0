Date: Thu, 1 Nov 2007 11:14:08 +0100
From: Michele Baldessari <michele-lists@...1016...>
Message-ID: <20071101101408.GA3572@...1017...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
Subject: [Openvpn-devel] DHCP Renew failing on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi James et al.,

I'm running OpenVPN quite successfully on 20 Windows XP roadwarrios, in
order to access different networks. All the clients access a single VPN
concentrator (2.0.9 on Debian Etch) using x.509 authentication and
depending on a few server-side scripts they receive personalized routes
and iptables rules. (Nb: the INPUT chain is empty and defaults to
ACCEPT, only FORWARD rules are defined by the scripts).

So far so good, the setup works flawlessly pretty much all the time.
Almost two or three times a month though, one or two roadwarriors
(I've not been able to extrapolate a pattern, it happens to random people),
loses all the OpenVPN-pushed routes.=20
The VPN connection is still up and running: if you add the routes manually=
=20
it keeps on working without an itch. A reboot restores normal behaviour.

The client in the logs receives the following two warnings in the System
Event log:

1) Your computer was not able to renew its address from the network (from
   the DHCP Server) for the Network Card with network address 00FF97B41B3C.
   The following error occurred:
   The semaphore timeout period has expired. . Your computer will continue
   to try and obtain an address on its own from the network address (DHCP)
   server.

2) Your computer has automatically configured the IP address for the
   Network Card with network address 00FF97B41B3C.  The IP address being
   used is 169.254.236.158.

So it basically wasn't able to renew the DHCP lease, hence the dropping
of the routes. (Note that the initiale DHCP works fine, the client
receives its routes correctly. It's just that afterwards, I believe on
the subsequent renew but I'm not 100% sure, it fails and it loses all the=20
VPN-pushd routes).

I've tried the tap-sleep option and raised the waiting time to no avail.
I'll now try the --dhcp-renew and --dhcp-release options, but I suspect
they won't help much.

I hope I can get a packet trace of this problem, but so far I've never
been able to reproduce under wireshark.

Any tips/hints on how to nail down and debug this beast?

thanks,
Michele

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHKabwofbulCQLTD0RAtjsAJ9Vrsd15sZ3+ap+IgMhhD1BFfqYGACePEp2
/5nmzUZQkvAa8H5Lwce0wAs=
=EuAK
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

