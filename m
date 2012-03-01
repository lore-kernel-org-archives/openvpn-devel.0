Message-ID: <4F4F6675.1090306@...1114...>
Date: Thu, 01 Mar 2012 13:07:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
	<4F4E7BEE.50700@...1114...>
	<1656594721.20120229203737@...449...>
In-Reply-To: <1656594721.20120229203737@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/02/12 20:37, Carsten Kr=FCger wrote:
> Hello,
>=20
>> How will you handle that some users use OpenVPN from Windows, Linux
>> and maybe even a mobile phone (like N900)? ... where paths are
>> different, depending on OS and/or distribution.  And some paths on
>> Linux (probably *BSD too?) are different if it is a 32bit
>> architecture or 64bit.
>=20
> Do have an example for an script? I've no idea what's the exact
> purpose is, I've never used scripts in openvpn.

I use scripts in a couple of setups.

a) Mounting and un-mounting networked filesystems after the tunnel is up.
Here I even implemented the --route-pre-down script hook, to unmount the
filesystem before the tunnel is taken down.  Here's the config extract:

  script-security 2
  route-up mount.sh
  route-pre-down umount.sh

The mount.sh and umount.sh scripts takes care mounting the right
filesystems.  The umount.sh also waits until it's the filesystem is
really unmounted.


b) Setting up tunnel specific iproute2 rules

   route-up /etc/openvpn/route-up.sh
   plugin /usr/share/openvpn/plugin/lib/openvpn-down-root.so
/etc/openvpn/route-down.sh

This client has a web server behind it which is available on the public
internet via the openvpn server which got the public IP address.  To make
sure the incoming public traffic is returned via the VPN tunnel and not
the default gateway on the openvpn client, simple ip rules like the ones
below are used in the route-up.sh

  /sbin/ip rule add from ${ifconfig_local} table 132
  /sbin/ip route add default via 10.8.0.1 table 132

And the route-down.sh takes care of deleting the rule.  This is to avoid
errors and duplications if openvpn is restarted.  (And there are probably
other ways to solve this as well, but this is one way)

c) Setting up /etc/resolv.conf based on pushed DNS settings
Using the --up script hook, you can extract the DNS server and domain
parameters pushed by the server to update /etc/resolv.conf.

>> And you would also need to go even further, to also make --plugin
>> only pushable too.  Which makes the /usr/lib vs /usr/lib64 scenario
>> a real pain for sure.
>=20
> Why do u want to secure openvpn if there is an option for a user to=20
> inject plugins? The plugin code do anything.
>=20
> Are plugins used only on server side or on clientside, too?

Plugins can be used on both server side and client side.  They can be
used to extend the logging, or do other more advanced things which is
easier and cleaner solved in a C program than using plenty of scripts.

The most common client-side usage of the plug-in is openvpn-down-root.so,
commonly used in the *nix world.  This forks out a process with root
privileges to restore some settings when the tunnel is taken down.
However, this is only needed if --user, --group and/or --chroot options
are used.  See the example b) above.

But I'm not saying that this is the best way to do this.  I'm just saying
this is how such issues are easily solved with today's implementation.

The whole DNS/resolv.conf issue is not present in Windows, because
Windows have no concept of TUN devices.  The TUN/TAP driver in Windows is
a TAP driver which fakes the TUN feature.  So when the TAP device gets
into "initialising mode", Windows makes the device send DHCP requests.
The TAP driver and OpenVPN client then fakes a DHCP server which sends
the IP address together with the DNS resolver info as DHCP packets back
to Windows via the TAP device.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PZnIACgkQDC186MBRfrrynwCdFuOc4cXf+VsA2ySoM21Bikwr
FSkAn0EH+sRlBLBIjeD11SG0nIqxHn78
=3DgmKz
-----END PGP SIGNATURE-----

