Message-ID: <3F8BD572.7080207@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] comments on beta12
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct 14 03:53:04 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

test between debian linux  2.4.21 <-> openbsd 3.4, beta12 on the 2 sides
works well

one comment for openbsd, "dev tun" doesn't work:

Tue Oct 14 12:14:14 2003 6: /sbin/ifconfig tun delete
ifconfig: SIOCGIFFLAGS: Device not configured
Tue Oct 14 12:14:14 2003 7: NOTE: Tried to delete pre-existing tun/tap 
instance -- No Problem if failure
Tue Oct 14 12:14:14 2003 8: /sbin/ifconfig tun 10.0.3.3 10.0.3.4 mtu 
1255 netmask 255.255.255.255 up
ifconfig: SIOCGIFFLAGS: Device not configured
=> must precise tunX

test openbsd 3.4 <-> win2k, with dev tun (always beta12)
works well too

one mistery: on openbsd side, i can't ping itself in the vpn, all other 
ping work.


Regards

		Julien

note: always host2host conn.
note2: test are only ping ...


