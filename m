From: Reid Wilson <reid@...537...>
Message-Id: <1138574193.5026.36.camel@...399...>
Mime-Version: 1.0
Subject: [Openvpn-devel] looking for paid support for an OpenVPN setup
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
Date: Sun Jan 29 14:36:05 2006
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I hope it's OK that I'm sending this request to this list. Please
forgive me if it's not...

I'm needing to set up what I'm guessing is a fairly typical OpenVPN
solution. OpenVPN is already installed on the server (Red Hat
Enterprise 3, on a dedicated server at a major ISP) so I most likely
just need help with the config files for both the server and client
sides. (Famous last words. :) I'm fairly savvy with Linux and basic
networking but am in no way a networking expert. (My knowledge stops
right before being able to determine if we need "bridging" or
"routing"...)

At this point I have way too many pots on the stove and am quite willing
to pay someone to set this up for me, assuming it wouldn't cost an arm
and a leg. Might one of you be interested in that? Ideally the work
would be completed over the next couple of days. Once the work is done I
would pay immediately via PayPal, check, or Visa, whichever you'd want.

Here is what I need:

-- We're basically going to use this server as an internet
   router/gateway and Samba share for many clients (initially
   20 or so -- "client in the sense of "server/client", not 
   "customer"). The goal is to tunnel all internet (both
   TCP and UDP) traffic through the VPN server, encrypted.
   Users travel with laptops and use internet cafes and the
   like and need a way to securely do all their internet use
   (web, email, IM, etc.) through a secure tunnel.

   Two sets of users for the SAMBA-shared files, so two 
   separate private subnets: 

      10.82.93.0/24
      10.72.83.0/24 

   (or something along those lines, just not 192.168.1.0/24
   or something that might be used on a client's internet 
   cafe's LAN)

-- OpenVPN 2.0 on port 443 of server
   (Port 443 won't get any other traffic -- no https sites on
   the server in other words. This was chosen to eliminate
   firewall issues in internet cafes and the like)

If you're interested, please contact me and let me know how much it
would cost. Assuming it's an amount I can afford, I'd like to just give
you a temporary root password to the server and let you have at it, as
well as sending me the config file we should use for Win XP on the
client side.

Thanks much.

Reid

-- 
Reid Wilson <reid@...537...>


