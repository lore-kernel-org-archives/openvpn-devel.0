From: Rasmus Rohde <rohde@...1084...>
Date: Thu, 27 Mar 2008 16:20:42 +0100
Message-Id: <1206631242.2154.7.camel@...399...>
Mime-Version: 1.0
Sender: Rasmus Rohde <rohde@...1083...>
Subject: [Openvpn-devel] Tap-win32 and multicast
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

In the tap-win32 driver a check in AdapterTransmit(..) prevents
multicast packets from ever reaching user space.

More specifically it is the following check:

// Only accept directed packets,
// not broadcasts.
if (memcmp (e, &l_Adapter->m_TapToUser, ETHERNET_HEADER_SIZE))
      goto no_queue;

Judging from the comment the check is put in to discard broadcast
traffic, but it will also trigger on multicast traffic.

Would it be reasonable to change this to do a more direct check for
broadcast traffic or add an exception when multicast traffic is
detected?



