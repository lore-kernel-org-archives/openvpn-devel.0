Message-ID: <20100109180748.26114.qmail@...1287...>
Date: Sat, 9 Jan 2010 19:07:48 +0100
From: Peter Stuge <peter@...1287...>
References: <lypr5lvsu7.fsf@...1290...>
MIME-Version: 1.0
In-Reply-To: <lypr5lvsu7.fsf@...1290...>
Subject: Re: [Openvpn-devel] RFE: allow 'lport 0' setup for random
	port	binding
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

Enrico Scholz wrote:
> I am running a multihomed host where 'local <extip>' must be
> specified for proper operation.

Could you add a route and use nobind? Unless you have one openvpn on
each IP that should work.

(I usually take multihomed to mean multi network rather than several
IP addresses on one and the same network.)


> On ungraceful reconnects, the new TCP connection will have same the
> host/port pairs but unexpected sequence numbers. The new connection
> will be assumed as invalid hence and be dropped.

I would actually expect the firewall to notice that there is a new
connection. Since it doesn't, maybe you can explicitly allow this
traffic?

OpenVPN can certainly be made to do what you describe, but it seems
that there are more ways to solve the problem, and one of those might
suit you better. I know I would prefer fixing the firewall rules.


//Peter

