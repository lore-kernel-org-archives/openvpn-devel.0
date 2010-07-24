Message-ID: <4C4B3F41.6090302@...1390...>
Date: Sat, 24 Jul 2010 12:30:09 -0700
From: Alex T <alex@...1390...>
MIME-Version: 1.0
Subject: [Openvpn-devel] features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I have 2 suggestions regarding openvpn (client mode):
- the use of SHA512 with the TLS ciphers
- some kind of route / firewall manipulation for the Windows client.
If the client is set up to route all Internet traffic via the VPN, sometimes
when the internet (especially the wireless connection) is lost, all the
internet traffic is using the local link, not the VPN ... this might become
a security issue. I saw a different VPN client (paid version, NCP secure
IPSEC client is called) that , on startup, if the current profile is set to
route all traffic via the VPN, manipulates the Windows routes ,
deleting the default gateway and routing only the VPN server ip
to the local gateway. If the VPN tunnel is not up, then the
Internet won't work.
On Linux this is easy to solve via the firewall or by routing,
but on Windows this seems more difficult, especially on older
versions like XP.
 I believe this features should be considered
in a future version. If this is already available, then i could not find
it ...

Thank You,
Alex


