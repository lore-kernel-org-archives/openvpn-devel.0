Message-ID: <1109580659.4222db737a0b4@...358...>
From: Bram <openvpn@...357...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Prefixed bytes
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
Date: Mon Feb 28 00:54:04 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,


According to this message:
http://sourceforge.net/mailarchive/message.php?msg_id=10639223 OpenVPN adds a
cleartext uint16_t length word before every packet, now my question is this: is
it always the same word? where is it defined/calculated etc?


I tried figuring it out by looking at logs of tcpdump but I was unluky, also
taking a look at the source code turned up some results but not quite what I
was looking for...


I want/need to know this to be able to use l7-filter (an extension to iptables
to be able to filter on the data of a package)...


Thanks,

Bram

