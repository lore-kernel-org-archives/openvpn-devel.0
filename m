From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] after script
In-Reply-To: <a6589cd60410230734408a9bf5@...278...>
Message-ID: <Pine.LNX.4.61.0410231926280.12811@...210...>
References: <a6589cd60410230734408a9bf5@...278...>
MIME-Version: 1.0
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
Date: Sat Oct 23 10:46:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Hans Fugal <fugalh@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 23 Oct 2004, Hans Fugal wrote:

> I spent a couple of hours last night trying to figure out a way to do
> everything I wanted to on my wireless LAN, and was having difficulty
> doing so. Before I go into details of what I was trying to do, doing
> it would be immensely easy if there was an --after, similar to --up
> but run after everything is set up. I thought that was what up was, at
> first, but apparently not.

It's probably --route-up you want to use, if you want it executed AFTER 
the connection is established.

> It all boils down to wanting to use DHCP. There are a couple of
> reasons for this, not the least of which it's a testbed for a larger
> setup at work. What's more, I would like to use the option
> "redirect-gateway" on my wlan because A) I set up my firewall to not
> forward traffic that doesn't come over the vpn, so that eventually I
> can turn off WEP if I feel like it and nobody can mooch my internet
> connection, and B) so nobody can sniff any of my activity. If I have
> the up script background the dhcp client, I get a dhcp address. But
> the routing fails. I could use route-delay, but it doesn't seem very
> robust as sometimes dhcp just might take too long. I did figure out a
> way to write an up script to do this (see below) but it doesn't feel
> right. (but at least it works)

I didn't understand exactly what you want todo...

When you say DHCP, do you mean that you want a DHCP server on the server 
side to hand out IP addresses to the clients?

Is using --ifconfig-pool to hand out IP addresses to the client out of the 
question?

It would surly be easiest to use --ifconfig-pool, as then openvpn is 
responsible both for setting the pushed IP address, as well as routes that 
can also be pushed to the client.

Are the clients using a specific O/S or do you want to support all O/S 
supported by OpenVPN?

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


