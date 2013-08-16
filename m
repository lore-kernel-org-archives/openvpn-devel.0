Date: Fri, 16 Aug 2013 23:11:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130816211121.GV16543@...1296...>
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
	<51FA79C6.1020405@...1147...> <51FEA1BF.9000905@...515...>
	<A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KS5V1uDxmEcBh2BA"
Content-Disposition: inline
In-Reply-To: <A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
	settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: dan farmer <zenfish@...277...>
Cc: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--KS5V1uDxmEcBh2BA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm a bit late to that, but had always planned to respond to this...

On Mon, Aug 05, 2013 at 10:52:54AM -0700, dan farmer wrote:
> But from a user's perspective - anything that can make the horror known a=
s=20
> openvpn configuration easier would improve openvpn's adoption considerabl=
y.

The issue here is that VPN is a highly complex matter, *and* that OpenVPN
is way too flexible :-)

Let me explain.

When you do commercial SSL-VPN products, usually you have a server that is=
=20
closed, has a web interface, and you only get to select a few possible
options, like "authenticate against a radius server" or - if you're lucky -
what IP range to use.  Then the commercial VPN product will create a=20
config file that you can then import into the client, and voila, zero-conf
VPN.

Now, if you want that with OpenVPN, you can use the OpenVPN Advanced Server
- commercial product, nice web interface (which actually *can* configure
most of the stuff, but the defaults work), maintenance contract, support,
and on the click of a button, it will produce a ready-made .ovpn profile
that you import into the client, with (voila!) zero-config :-)


OTOH, using the community OpenVPN, you have all the tools that you can
imagine to twiddle

  - how you want to connect your networks - network-to-network, client-to-
    network, bridged client-to-network, fake bridging with proxy-ARP over
    tun, you-name-it -> whatever networking problem you have, the chance
    is high that you can solve it with OpenVPN.

  - how you want to authenticate your clients - certificates, user+password,
    both, external sources (radius, PAM, ...)

  - and potentially even modify the server config for each client on-the-fly
    with one of the umpteen script hooks

this is cool, but makes server configuration quite difficult indeed, as
you need to decide what you *want* to achieve - and as David and others have
mentioned before, most of the time the problems are not "the VPN side" but
"the IP routing side of things" (I do that for a living, but I know it from
my colleagues' faces that some of the tricks can be a *bit* hard to grok...=
).


If the server is done, and you know how you want the client side to look
like, the client config is actually fairly simple in most cases - tell
it where to look ("remote 1.2.3.4"), what protocol to use ("mode udp")
and how to authenticate ("ca", "cert", "key").  Most of the rest can be
pushed by the server...


Of course then you're back into crypto lala land - crypto is hard, CAs
are even harder, and *understanding* how the bits and pieces fit together
can be a challenge (especially with the lovely openssl command line tools).


Now, I'm not sure what the conclusion of that is - maybe "use raw=20
OpenVPN if you're willing to dig into IP routing and crypto CA stuff,=20
and want the full control - and use a product with a hide-the-details=20
GUI like OpenVPN AS otherwise, and accept the choices that the GUI=20
writer made for you"?


OTOH, we *do* ship quite a stack of config files in our tree...

openvpn/sample/sample-config-files$ ls -l
total 92
-rw-r--r--  1 gert  users    131 Feb  2  2013 README
-rw-r--r--  1 gert  users   3426 Feb  2  2013 client.conf
-rwxr-xr-x  1 gert  users   3562 Feb  2  2013 firewall.sh
-rwxr-xr-x  1 gert  users     62 Feb  2  2013 home.up
-rw-r--r--  1 gert  users    639 Feb  2  2013 loopback-client
-rw-r--r--  1 gert  users    665 Feb  2  2013 loopback-server
-rwxr-xr-x  1 gert  users     62 Feb  2  2013 office.up
-rwxr-xr-x  1 gert  users     63 Feb  2  2013 openvpn-shutdown.sh
-rwxr-xr-x  1 gert  users    776 Feb  2  2013 openvpn-startup.sh
-rw-r--r--  1 gert  users  10288 Feb  2  2013 server.conf
-rw-r--r--  1 gert  users   1742 Feb  2  2013 static-home.conf
-rw-r--r--  1 gert  users   1688 Feb  2  2013 static-office.conf
-rw-r--r--  1 gert  users   1937 Feb  2  2013 tls-home.conf
-rw-r--r--  1 gert  users   1948 Feb  2  2013 tls-office.conf
-rw-r--r--  1 gert  users    199 Feb  2  2013 xinetd-client-config
-rw-r--r--  1 gert  users    989 Feb  2  2013 xinetd-server-config

... maybe we should do more advertising for these?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KS5V1uDxmEcBh2BA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg6VeakuBuNlUUl1AQIJwAQAxa++GTV3h58VhPQrnfHk/Fp6YGMHq5Bw
pbD8FwJQ2Zei50jsetMWBK7LrXze/RN+tyCnA7UhE7RQjJsFynD2rYyS2EKR6I+7
3oGO5bWV86zVLfSEXqZMrboNZSZuDYn+xWQQHZq63p09gKEN37Rh+hDwC4zw3/Zx
SRejOeEcPik=
=ED+C
-----END PGP SIGNATURE-----

--KS5V1uDxmEcBh2BA--

