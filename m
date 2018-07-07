Resent-Message-ID: <20180707200328.GS989@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Sat, 7 Jul 2018 22:02:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180707200253.GR989@...1296...>
References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
 <06da91cb-ef1e-69db-e131-5d27fcfeee5f@...1227...>
 <BN6PR04MB09324E370F6540239CDD610FDD460@...2439...>
 <20180707192528.GQ989@...1296...>
 <BN6PR04MB093270EB512FBBF18B7497A3DD460@...2439...>
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB093270EB512FBBF18B7497A3DD460@...2439...>
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Kristian McColm <kristianmccolm@...160...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On Sat, Jul 07, 2018 at 07:47:36PM +0000, Kristian McColm wrote:
> > mssfix 1300
> > 
> > (won't do anything for large UDP packets inside the tunnel, but will
> > fix TCP.  If you really need large UDP, try --fragment 1400 - but this
> > needs to be turned on on both sides, OpenVPN server and client, and will
> > cause some overhead)
> 
> Setting link-mtu 1440 fixes it for all protocols, 

This might also work, but is not without other caveats either.

> but  I am looking for a solution that is more graceful, such as
> PMTUD support. I don't see why it couldn't work, since the ICMP
> unreachable is sent to the VPN server with the appropriate MTU for
> the outer IP packet.

link-mtu will (if I'm not mistaken) cause "smaller outside fragments" 
on the tunnel UDP packets.

PMTUD might work, *if* you set "--mtu-disc maybe" or "--mtu-disc yes"
on the server side.  It's not a code path that has seen any love in the
last 6 years or so, so it might be just fully broken - but I'm 
interested to hear about it.

> Since I am approaching this from the mobile network carrier
> perspective, and since we don't have control over VPN provider
> configs, I am looking for ways to mitigate the problem for our
> customers whose VPN's suddenly stopped working after they were
> migrated to IPv6-only.

Provide a larger MTU than 1500 on the IPv6 side of things?

> > The "I have no IPv4 default route so my local 464 component messes up
> > IPv4 connections through the tunnel" is annoying, but not truly surprising.
> > 
> > (And the real culprit here is "Apps using IPv4 literals" - those are
> > the ones to blaim that apple had to add that local "DNS64-like" component
> > for IPv4 literals - which is now breaking the same apps in a VPN context)
> > 
> > But if "push default route" works as a workaround, this can be documented
> > and things will be fine...
> 
> I'm not sure why it works, but it does. I assume the Apple hostname
> resolver APIs that do the IPv4 literal NAT64 synth have some logic
> to only do it when there is no IPv4 available. Maybe worth asking
> the question to Apple on exactly how this works before documenting
> anything.

Yes.

gert

-- 
"If was one thing all people took for granted, was conviction that if you 
 feed honest figures into a computer, honest figures come out. Never doubted 
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistress

Gert Doering - Munich, Germany                             gert@...1296...


