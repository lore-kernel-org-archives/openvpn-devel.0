Sender: Kor Korrd <kor.korrd@...277...>
From: Kor Korrd <kor.korrd+openvpn@...277...>
Message-ID: <1527b3e1-ac4f-14c8-d804-846949c57a31@...277...>
Date: Thu, 6 Apr 2017 16:39:42 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Listen on multiple interfaces but not all
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

is it possible for the Server part to listen on more than one specific
interface but not on all interfaces?

e.g.
One Debian Server with several IPv4 and IPv6 addresses. Run the OpenVPN
Server on one specific v4 and v6 address (local <IPv4> + local <IPv6>),
so that I can use the remaining addresses for other VPN instances.

As yet on Debian 8 + OpenVPN 2.3.4 it is not possible, but maybe the
development since then has made it possible?
The Changelog diddn't reveal that in particular.

Best regards,
Kor

