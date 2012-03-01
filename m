Message-ID: <4F4F6C84.3070503@...1114...>
Date: Thu, 01 Mar 2012 13:33:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
	<4F4E7BEE.50700@...1114...>
	<1656594721.20120229203737@...449...>
	<4F4F6675.1090306@...1114...>
	<38614505.20120301131554@...449...>
In-Reply-To: <38614505.20120301131554@...449...>
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

On 01/03/12 13:15, Carsten Kr=FCger wrote:
> Hello David,
>=20
>> a) Mounting and un-mounting networked filesystems after the tunnel
>> is up. Here I even implemented the --route-pre-down script hook, to
>> unmount the filesystem before the tunnel is taken down.  Here's the
>> config extract:
>=20
> This need root rights?

Not necessarily, if /etc/fstab is configured with 'user' you don't need
root priv.  Or if you use FUSE stuff, that often don't need root access
either.  Of course, it all depends on what kind of file system you mount.

>> This client has a web server behind it which is available on the
>> public internet via the openvpn server which got the public IP
>> address.  To make sure the incoming public traffic is returned via
>> the VPN tunnel and not the default gateway on the openvpn client,
>> simple ip rules like the ones below are used in the route-up.sh
>=20
>> /sbin/ip rule add from ${ifconfig_local} table 132 /sbin/ip route
>> add default via 10.8.0.1 table 132
>=20
>> And the route-down.sh takes care of deleting the rule.  This is to
>> avoid errors and duplications if openvpn is restarted.  (And there
>> are probably other ways to solve this as well, but this is one way)
>=20
> Need root rights, too?

This case needs root access, correct.  But this can be tweaked around
using sudo trikcs or similar stuff.  And using SELinux, you can also lock
down things even more.

> Maybe it's a good idea to have two type of scripts. One that is
> controlled from the administrator and is executed with admin/root
> privileges and the other that runs as the user.
>=20
>> Plugins can be used on both server side and client side.  They can
>> be used to extend the logging, or do other more advanced things
>> which is easier and cleaner solved in a C program than using plenty
>> of scripts.
>=20
> In an enterprise setup I would think a plugin should be not modifable
> by the user (i.e. the user should have no chance to load own
> modules).

Well, I can agree to that.  But this is all open source.  No matter how
much restrictions you put into the openvpn product, the user can download
the source, add the features missing, and reconnect with a modified
OpenVPN version.

Even introducing signatures and hashes which the server evaluates will
not solve this, as the openvpn client can be modified to return exactly
the data the server would expect.

To avoid this, you would need to run some code from the server - which
evaluates the system and reports back to the server.  Then the server can
decide to open up the firewall on the server side or not.  Otherwise, you
have no way to trust the client side at all.  And all this would have to
be code which is not easily available, so the client can't fake this
operation as well.

Bottom line is, you can't fully control the client environment.  All
enforcements needs to happen on the server side.

What you can do on the client side, is to avoid a third party (think
virus/malware) to figure out that openvpn is installed, and tweak the
config to run code which was not supposed to be run with higher
privileges.  So the client should try to lock down things locally, to
reduce the impact from local exploits.  The server side should restrict
the server side, and what is being passed via the tunnel.  There's no
real way you can make the server enforce restrictions on the client.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PbIIACgkQDC186MBRfrp7GgCdE9FyhidxVP+xYDzZhvbBw6w1
ps0AmwRBWDSHk2MILKfUlrYr5OcuAkbY
=3D2DnA
-----END PGP SIGNATURE-----

