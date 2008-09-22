Message-ID: <48D7E861.4040507@...1129...>
Date: Mon, 22 Sep 2008 20:48:01 +0200
From: Sebastian Hyrwall <zibbe@...1129...>
MIME-Version: 1.0
Subject: [Openvpn-devel] "Random" change of local address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

This might come as an odd request but as I'm not good with C and there's 
nice people out there I'll give it a shot.


I'm looking at doing per-packet load-balancing based on the 
source-address. That is, for every packet that goes out the source 
address should be new.


First I tried doing this with iproute2 or netfilter but there's really 
no good way to do this in Linux. Atleast not that me and my friends found.

So then I thought that I could do the per-packet balancing in the 
application instead when using UDP in OpenVPN:

Basically what I want, and this can be statically written in the code, 
is a list of IPs that OpenVPN chooses from for every packet.

I think this should be fairly easy to do and there shouldn't be many 
lines of code. If I understood correctly it can be done under the 
resolve_bind_local function in socket.c.


Is there anyone who can help me with this task? It would be very 
appriciated!

Sincerely,
Sebastian H



