Message-ID: <483DA4E4.1030308@...1104...>
Date: Wed, 28 May 2008 14:31:00 -0400
From: Martin Gadbois <martin.gadbois@...1104...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Memory of server keeps increasing with key
	negotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Using OpenVPN 2.0.5 and 2.0.9, I notice that an somewhat idle connection
increases the RSS of the server process linearly with time.

valgrind says that there are no memory leaks. So where is this memory kept?

The way to reproduce this problem fast is to set reneg-sec to 15 using
RSA certificates.

Here's the server config, the one that increases:
=========
port 1194
proto udp
dev tun
ca ca/ca.crt
cert ca/server.crt
key ca/server.key  # This file should be kept secret
dh etc/dhparam1024.pem
server 169.254.0.0 255.255.255.0
ifconfig-pool-persist /tmp/ipp.txt 45
ifconfig-pool-linear
tun-mtu 1431
mtu-disc no
ping 5
ping-exit 60
cipher BF-CBC        # Blowfish (default)
max-clients 200
tls-auth etc/ta.key 0
user nobody
group nobody
persist-key
persist-tun
verb 4
reneg-sec 15
=============

Any hints on where to look for this memory would be great, as I would
like to clear this up.

Thanks!


- --
==============         +---------------------------------------------+
Martin Gadbois         |    You are            -- J. Steakley,       |
Sr. SW Designer        |    What you do             Armor, 1984      |
Colubris Networks Inc. |    When it counts.                          |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIPaTkMPkSU9icdA0RAk/QAJ94r3tJhqToMtkoRf/lj38FuefnyQCgrLgD
koTQZIWLrX6G+QU+1Gl2daA=
=uJ7l
-----END PGP SIGNATURE-----

