Message-ID: <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
In-Reply-To: <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
Date: Thu, 22 May 2025 14:24:19 -0000
From: "Walter Doekes" <walter.openvpn@...2889...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> The thing is that I do not really understand your scenario and how it
> exactly breaks for you to the extend that I cannot reproduce the issue.

I thought I explained things sufficiently in:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31502.html

Apparently not. Please let me know what is unclear about that explanation.


> You are saying that the client switches the IP address after connect. But
> that is just a regular float from the perspective of the VPN server. I
> still do not understand where the other connection that is already on that
> IP/port is coming from. It is also not an older connection as it is not a
> fully established connection either.

Well, as far as I can tell, it _is_ just a regular float... that stopped
working after the mentioned commit.

It is indeed that recent connection. From what I gather from the earlier
workings, we should not end up in that piece of code (where I added the
fix), but for some reason we _do_ now.


> In summary I am not able to either reproduce or understand what is
> happning in your scenario. And I do not want to apply a patch that I don't
> understand.

Totally fair that you don't want to apply a patch that you don't
understand. I on the other hand do not see why you're unable to reproduce.

The scenario is not at all complicated:

- Two vpn servers;
- first vpn server pushes a default gateway;
- second vpn server pushes its external IP as net_gateway (*);
- second vpn server immediately sees the client float from one IP to another.

If you're unable to reproduce that, then:

- Either you're using a vastly different version and it has been fixed
since then (but not something that landed in debian/bookworm or
ubuntu/noble, and I _think_ I did try latest 2.6 as well);
- or you're using different settings (udp; auth/tls-auth; dev-tun;
subnet-topology);
- or there is some unknown factor involved that neither of us can think or
right now.

I will create a reproducer config so you can see the exact settings (apart
from the IP addresses).

In the mean time, can you confirm that you understand the scenario or ask
for additional clarification?

Thank you!

Walter


(*) Why? Because if it didn't, traffic from the client to VPN-two goes
through VPN-one as well. And that incurs overhead: additional latency and
cpu load, possible MTU issues.

