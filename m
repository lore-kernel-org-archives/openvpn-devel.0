From: Mr E_T <troll@...236...>
MIME-Version: 1.0
Message-Id: <200406102333.28357.troll@...236...>
Subject: [Openvpn-devel] Routing problem with 2.0-beta4 (and beta2)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jun 10 08:41:04 2004
Content-Type: Text/Plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have two private networks with addresses 192.168.0.* and 192.168.1.*

192.168.0.* has a static ip on the internet.

192.168.1.* has a dynamic ip (road warrior)

I have set up 192.168.0.2 as the server and 192.168.1.1 as the client.

I can ping all the client machines from the server.

But I can only ping the server from any of the client machines - I cannot g=
et to the rest of the network.

At the moment the two machines are linux boxes. But I would like to migrate=
 the server to a winXP box when it is properly running.

the server config is -
# openvpn server config
mode             server
nice -20
#cd             /etc/openvpn
chroot          /etc/openvpn
#float
proto            udp
port             5000
dev              tap
tun-mtu          1500
tun-mtu-extra    32
ifconfig        10.0.0.1    255.255.255.255
route           10.0.0.2     255.255.255.255    10.0.0.1
route           192.168.1.0     255.255.255.0    10.0.0.2
ifconfig-pool   10.0.0.21 10.0.0.40
client-config-dir clients/
client-to-client
ping-timer-rem
ping 5
ping-restart 45
comp-lzo
tls-server
ca              keys/ca.crt
cert            keys/server.crt
key             keys/server.key
dh              keys/dh1024.pem
verb            3
log-append      /var/log/openvpn-server.log
# End config file

with the client/warrior file -
#special parameters for conon
ifconfig-push   10.0.0.2 255.255.255.255
push            "route 10.0.0.1 255.255.255.255 10.0.0.2"
push            "route 192.168.0.0 255.255.255.0 10.0.0.1"
#end client file

and the client config file -
# Linux opencpn client config
proto            udp
port             5000
dev              tap
tun-mtu          1500
tun-mtu-extra    32
ping 5
ping-restart 45
persist-tun
persist-key
#user          nobody
#group         nogroup
nice          -20
remote	x.x.x.x
pull
comp-lzo
tls-client
ca              keys/ca.crt
cert            keys/conon.crt
key             keys/conon.key
verb            3
log-append      /var/log/openvpn-hans.log
# End config file


Any help would be appreciated thanx.

- --=20
regs MR E_T
_______________________
\                      \
  \   OOHH I hate TYPOS  \
    \                      \
      ~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAyH8BPBbX35pvTSgRAtIQAJsFqZ8h4wjaJAHWA3CfUburm0E1rACfV5s2
peRnHTDl3/QGW9NmFYeur2A=3D
=3Dd9in
-----END PGP SIGNATURE-----

