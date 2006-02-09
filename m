From: Carsten Sierks <c.sierks@...68...>
Message-ID: <loom.20060209T120629-846@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Problem setting up a bridged ethernet
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
Date: Thu Feb  9 13:41:05 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

after posting a question in gmane.network.openvpn.user without getting an
answer, I ask here again. If that is a breech in your customs, I beg your
pardon, but I do not see any other way.

On trying to set up Ethernet-Bridging with OpenVPN 2.0.5 I obtain the following
error:

hwgate:/etc/openvpn # openvpn --mktun --dev tap0
Mon Feb  6 04:33:39 2006 Note: Cannot ioctl TUNSETIFF tap0: Invalid argument (er
rno=22)
Mon Feb  6 04:33:39 2006 Note: Attempting fallback to kernel 2.2 TUN/TAP interfa
ce
Mon Feb  6 04:33:39 2006 TUN/TAP device /dev/tap0 opened
Mon Feb  6 04:33:39 2006 Cannot ioctl TUNSETPERSIST(1) tap0: Invalid argument (e
rrno=22)
Mon Feb  6 04:33:39 2006 Exiting

I am using SuSE Linux Enterprise Server 9.1 (Kernel 2.6.5-7.139-default).

Any idea, how ot make bridging work?

Cheers
Carsten


