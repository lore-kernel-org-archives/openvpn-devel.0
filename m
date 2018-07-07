From: Kristian McColm <kristianmccolm@...160...>
Date: Sat, 7 Jul 2018 19:54:56 +0000
Message-ID: <BN6PR04MB09325A4C31E65B09C8AB415CDD460@...2439...>
References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
 <06da91cb-ef1e-69db-e131-5d27fcfeee5f@...1227...>
 <BN6PR04MB09324E370F6540239CDD610FDD460@...2439...>
 <20180707192528.GQ989@...1296...>
In-Reply-To: <20180707192528.GQ989@...1296...>
Content-Language: en-US
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> mssfix 1300
>=20
> (won't do anything for large UDP packets inside the tunnel, but will
> fix TCP.  If you really need large UDP, try --fragment 1400 - but this
> needs to be turned on on both sides, OpenVPN server and client, and will
> cause some overhead)
>=20

Setting link-mtu 1440 fixes it for all protocols, but  I am looking for a s=
olution that is more graceful, such as PMTUD support. I don't see why it co=
uldn't work, since the ICMP unreachable is sent to the VPN server with the =
appropriate MTU for the outer IP packet.=20

Since I am approaching this from the mobile network carrier perspective, an=
d since we don't have control over VPN provider configs, I am looking for w=
ays to mitigate the problem for our customers whose VPN's suddenly stopped =
working after they were migrated to IPv6-only.

> The "I have no IPv4 default route so my local 464 component messes up
> IPv4 connections through the tunnel" is annoying, but not truly surprisin=
g.
>=20
> (And the real culprit here is "Apps using IPv4 literals" - those are
> the ones to blaim that apple had to add that local "DNS64-like" component
> for IPv4 literals - which is now breaking the same apps in a VPN context)
>=20
> But if "push default route" works as a workaround, this can be documented
> and things will be fine...

I'm not sure why it works, but it does. I assume the Apple hostname resolve=
r APIs that do the IPv4 literal NAT64 synth have some logic to only do it w=
hen there is no IPv4 available. Maybe worth asking the question to Apple on=
 exactly how this works before documenting anything.

