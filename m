Message-ID: <3FD3F557.6030209@...140...>
From: gridrun <gridrun@...140...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN MTU Problem/Solution
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
Date: Sun Dec  7 19:53:01 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: jim@...41...

Hi there,

I recently set up a OpenVPN connection between two windows servers - a 
web frontend located in a DMZ, accessing an SQL database over the VPN 
network. As far as I can tell (the project is far from complete), that 
works just fine (100mbps ethernet connection between the two boxen). I 
also used OpenVPN to setup a "maintenance network", so I could log in 
from home and administer the web server box via RDP, without having to 
open port 3389 to the world.

I experienced the some difficulty with the "maintenance network" VPN 
connection:

After I set things up both local and remote, OpenVPN connected, and I 
was able to ping mentioned web server from my home box, thru the VPN. 
However, only pings with -l arguments smaller than 1459. I.e., a <ping 
10.0.0.1 -l 1458> worked (remote host replied), but a <ping 10.0.0.1 -l 
1459> would just give timeout. So I read the manual and tried fixmss 
1300.. no go, still would not work. I might add that Im using a tcp 
connection, and dev tap for this.
Anyways, the solution was: I had to set the MTU on the virtual tap 
network interface to 1300, and magically, it werkz!  (I suspect I could 
raise that to 1458 for better performance, but have not yet tried, as 
for now im perfectly happy *that* it works, no matter how fast it works 
:). I also suspect I could use tun-mtu option to do this from the config 
file, right? I'll find out shortly...

Other issues I had with OpenVPN:

- Restarting the OpenVPN service sometimes (not definately sure under 
what circumstances) gives an error message "cannot create a file that is 
already there", with the OpenVPN service failing to re-start. The fix 
for this is to simply start the service again. I wonder tho what might 
cause this? Does it have something to do with my two VPN tunnels using 
the same key file (Im gonna change that later)? Might be of interest for 
developers...

- OpenVPN would not work with an IP defined on the TAP adapter - neither 
on the client nor on the server. A bit weird is, even tho it would not 
connect, the TAP adapter (I have it to "application controled") came 
alive on the client, so I was a bit confused as to why the client would 
connect, but the server doesnt see it. After I retought, I conclude 
thats "behaviour by design" - maybe add something to the documentation 
for newbies (like me :p), so they are not mislead by the TAP icon 
(connected/not connected), but check logs instead... :)


Tought I'd let you know, so u can fix, cuz ur little VPN program rocks! :))

--grid


