From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] ip/mac spoofing prevention
In-Reply-To: <d87dej$ujh$1@...165...>
Message-ID: <Pine.LNX.4.58.0506081845480.16160@...41...>
References: <d87dej$ujh$1@...165...>
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
Date: Wed Jun  8 17:51:03 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jason Lunz <lunz@...413...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 8 Jun 2005, Jason Lunz wrote:

> If many clients are connected to a server-mode openvpn instance running
> in bridge mode, any client can inject arbitrary ethernet frames onto the
> VPN. By arbitrary, I mean that clients can change source mac and source
> IP at will. This is a good thing; it's flexible.
> 
> However, this makes it useless to attempt user-based firewalling on the
> vpn server on the packets arriving on the tap device. By the time a
> given packet arrives at firewall rules on the tap device, there's no
> non-spoofable way to determine which user sent the packet.
> 
> How difficult would it be to add an option to enforce that packets
> arriving from a particular user be discarded by openvpn if they do not
> match a given mac address (and/or IP)?  That way, firewall rules could
> be written on the tap device with per-user granularity, and openvpn
> would prevent any possibility of spoofing.

This has been discussed before on openvpn-users.

See the "learn-address" script callback as described in the man 
page.  This can be used to set firewall rules by client in a bridging 
configuration.

James

