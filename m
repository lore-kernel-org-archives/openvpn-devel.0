Subject: Re: [Openvpn-devel] 400 vpn clients 20% of them loosing the route
	frequently
From: Marcelo Toledo <marcelo@...461...>
In-Reply-To: <1e6368e80509300544h3d4f5541gc8b01ba40b5adaa5@...278...>
References: <1127848987.6861.117.camel@...399...>
	 <1e6368e80509271858682178b5@...278...>
	 <1128082114.7399.113.camel@...399...>
	 <1e6368e80509300544h3d4f5541gc8b01ba40b5adaa5@...278...>
Message-Id: <1128618189.7000.52.camel@...399...>
Mime-Version: 1.0
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
Date: Thu Oct  6 10:04:51 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Leonard Isham <leonard.isham@...277...>
Cc: openvpn-devel@lists.sourceforge.net

> What are the stats on the server?  Are there any resource issues? 
> CPU, TCP. etc.

Nope, everything ok.

> OpenVPN 1.X was one port per connection TUN or TAP.  OpenVPN 2.x
> supports the old setup, but was designed with a server mode for _both_
> TUN and TAP.  You can either dynamically hand out IP addresses or
> statically with either method.

Good to hear it, we already performed tests with one server and 3
clients, looked ok. Now we're going to install the major server and
installing upgrading the clients slowly to see how it goes.

> Are these site-to-site or road warriors?  Are the 20% always the same
> or random?  Do the 20% have anything in common.  Ant NAT devices or
> firewalls in between that may be having periodic resource issues?

it is site-to-site. And the 20% are not always the same, they vary a
lot. We have firewall but it's not causing the issue.

> Have you considered setting up cacti or other system to monitor
> resources and provide graphs?

Not yet... suggestions?

> Consider setting up a second server or OpenVPN instance and use TUN
> with UDP and migrate.

Did it.

> Do you have any packet captures of the traffic out the TAP interface
> on the server and client that experiences the failures?

Nope.

> I don't know your workload or any other details, but what about
> another person to take some of your workload so you can concentrate on
> this issue.  Or a second set of eyes to work on this issue with you (I
> would look for someone with at least as much networking experience as
> you have).

That would be great, actualy I am not looking too much into this, I am
just interacting with someone who is actualy doing this, but looks like
what you told me will work fine, I will let you know after we have more
clients connected.

once again, thanks a lot for your time,
-- 
Marcelo Toledo <marcelo@...461...>


