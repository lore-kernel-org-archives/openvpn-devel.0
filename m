Message-ID: <a6589cd60410230734408a9bf5@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] after script
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
Date: Sat Oct 23 07:35:04 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I spent a couple of hours last night trying to figure out a way to do
everything I wanted to on my wireless LAN, and was having difficulty
doing so. Before I go into details of what I was trying to do, doing
it would be immensely easy if there was an --after, similar to --up
but run after everything is set up. I thought that was what up was, at
first, but apparently not.

It all boils down to wanting to use DHCP. There are a couple of
reasons for this, not the least of which it's a testbed for a larger
setup at work. What's more, I would like to use the option
"redirect-gateway" on my wlan because A) I set up my firewall to not
forward traffic that doesn't come over the vpn, so that eventually I
can turn off WEP if I feel like it and nobody can mooch my internet
connection, and B) so nobody can sniff any of my activity. If I have
the up script background the dhcp client, I get a dhcp address. But
the routing fails. I could use route-delay, but it doesn't seem very
robust as sometimes dhcp just might take too long. I did figure out a
way to write an up script to do this (see below) but it doesn't feel
right. (but at least it works)

#!/bin/sh
# up script for falcon-wlan
(
  ifup $1 # starts DHCP
  ip route change default via 172.17.0.3 # 172.17.0.0/24 is the vpn
subnet (bridging)
) & # if I don't background, dhcp requests don't go over the vpn
# end script

For one thing, the ip route stuff isn't nearly as robust as the
"redirect-gateway" option, although I could duplicate its intelligence
if needed. (In practice this will probably do)

I mostly am looking for a more elegant solution because others
occasionally use this wlan, like my brother, and I don't want
configuration to be too complicated. Am I missing something from my
manpage reading, or can you suggest a more elegant way to do this? Or
might an after option be possible?

-- 
De gustibus non disputandum est.

