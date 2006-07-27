From: Tony <kb2wjw@...277...>
Date: Thu, 27 Jul 2006 18:01:04 +0400
Message-ID: <op.tdco72dcioehzu@...603...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: [Openvpn-devel] A special IP address range for exclusive VPN usage?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Is it my missunderstanding or is it a real improvement - to ask IANA to  
allocate the range for exclusive allocation to VPN clients?

As far as I can see - the main obstacle of building the robust and  
allaround VPN is to guess the IP-range so that it *NEVER*  
collides|overlaps with *ANY* of the IPs used on real networks where a  
server and a client may happen to be.
(The most frequent gotcha is a client physically connected to, say,  
192.168.*.* on a LAN and tryes to use VPN which allocates him with  
192.168.*.* on his virtual adapter)

How to guess a range nobody uses on their LANs?!

I saw a VPN system, namely Hamachi (www.hamaci.cc), which cleverly uses  
the 5.*.*.* range.

Who's responsibility to ask IANA about that matters?
Is it already implemented? If so - which IP-range is safe to be used in  
VPN between a server and a client?

Please comment.

Tony.


