Date: Fri, 26 Jun 2015 09:35:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626073544.GT382@...1296...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QHW5B18VhxdkQhx"
Content-Disposition: inline
In-Reply-To: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--5QHW5B18VhxdkQhx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 25, 2015 at 06:01:20PM +0200, Holger Kummert wrote:
> When a linux tun interface is closed (e.g. on disconnect)
> an optional ipv6 addr that was previously set is deleted now.
> Without this patch a later reconnect would fail with
> 'Linux ip -6 addr add failed: external program exited with error status: =
2'
> and openvpn would exit.

There is a trac ticket to that extent already (trac #141,
http://community.openvpn.net/openvpn/ticket/141) - so thanks for the
patch :-)

I'm not sure I fully understand that usage scenario - which is one of
the reasons why that ticket did not proceed.

If you use normal nonpersistant tun interfaces, openvpn will destroy the
tun interface at exit, removing the IPv6 address in the process.

If you use *persistant* tun interfaces, this is usually done for a reason,
like "bind (nameserver) cannot bind to new interface addresses because
it is running without privileges" - but in this case, we should not remove
the address (because then it's gone...) - and arguably not add it either,
because it should already be there - because if not, the argument with
"other software needs this address" is moot.


So - help me understand the scenario.  Why are you using persistant tun
interfaces but want dynamically added and removed addresses?

(I can see that OpenVPN misbehaves but I'm not sure I understand what=20
"the best" solution should be - maybe go for "if that address is already
there, do not touch it, otherwise, remove existing address and add
new one" instead?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5QHW5B18VhxdkQhx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY0A0KkuBuNlUUl1AQIx7gP+NQN7hRpVmRkTFS6f0O/sZtv5/vEjtmNS
Q3lMIJcy5pZ4jqDlz0sZNlGwUdRZKgHI1eIbyLaQ+f/lZE21J5AwLWfrEFEbstU7
BZlMOujrZ1PNbVvhTz5Cb6NQLXGphZlw4uAbq6TgWhPBzAv5p2NnwYPFzuVSXiJl
ji2qgrBY3NY=
=z7Lb
-----END PGP SIGNATURE-----

--5QHW5B18VhxdkQhx--

