From: Jan Just Keijser <janjust@...1147...>
Date: Tue,  7 Feb 2012 16:26:28 +0100
Message-Id: <1328628389-4859-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] Made some options connection-entry specific
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


Made some options connection-entry specific:
 fragment
 mssfix
 tun-mtu
 tun-mtu-extra
 link-mtu
 mtu_discover_type
 explicit-exit-notification
in order to support stuff like 
<connection>
  remote host
  proto udp
  fragment
  explicit-exit-notification 3
</connection>
<connection>
  remote host
  proto tcp
</connection>


