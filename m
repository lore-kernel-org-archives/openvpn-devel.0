Message-ID: <20100308202613.22343.qmail@...1287...>
Date: Mon, 8 Mar 2010 21:26:13 +0100
From: Peter Stuge <peter@...1287...>
References: <20100308165048.19002.qmail@...1287...> <1268075941.2962.0@...1207...>
MIME-Version: 1.0
In-Reply-To: <1268075941.2962.0@...1207...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> > I know of at least four DHCP clients and I avoid dhclient as much as
> > possible. It would be a tremendous mistake to tie OpenVPN to any one
> > DHCP client IMO.
> 
> Only D is tied to dhclient.  A, B, and C, work fine with any dhcp
> client daemon.  (Or A does anyway, B and C require configuration file
> support for the interface.  I assume this is a common property of
> dhcp clients.)

Actually no, neither dhcpcd nor pump nor udhcpc uses one.


> It would be nice not to force use of a particular client.

I think it's neccessary.


> Given that.  Why not just use -up and --down to do what's
> needed?  Avoid changing the code and write documentation.

Agree completely. This is how I've been using OpenVPN for years
already.


//Peter

