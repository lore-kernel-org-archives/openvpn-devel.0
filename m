From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Connect several subnets with OpenVPN2.0
In-Reply-To: <20040907225456.GA2638@...152...>
Message-ID: <Pine.LNX.4.58.0409080903040.28179@...269...>
References: <20040907225456.GA2638@...152...>
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
Date: Wed Sep  8 08:17:00 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Robin G. Wenninger" <grw@...152...>
Cc: openvpn-devel@lists.sourceforge.net


On Wed, 8 Sep 2004, Robin G. Wenninger wrote:

> Hi list,
> 
> I have a kind of "problem" here.
> 
> I thought about connecting several subnets with 2.0 and for this purpose
> use the PUSH/PULL-Options.
> 
> So I used options like
> 	push "route 10.0.0.0 255.255.255.0"
> 	push "route 192.168.1.0 255.255.255.0"
> 
> To push all known subnets to the Clients. But the problem is, if I push
> route 10.0.0.0 255.255.255.0 to the Client which "owns" this subnet it
> overwrites the old routing entry and kicks its Subnet.
> 
> My recommendation would be a kind of exception list.
> Something like
> 	push "route 10.0.0.0 255.255.255.0" except common-name
> 
> What do you think about this, is there any other (good to administrate)
> solution?

Interestingly enough, I think that this exception mechanism is already 
built into the way that IP routing works.

For example, suppose I push my all-inclusive /16 subnet:

  push "route 10.11.0.0 255.255.0.0"

Now suppose a client has taken a /24 subset of this range such as 
10.11.45.0/255.255.255.0.

The all-inclusive /16 route will match at a lower priority in the client's 
routing table than the client's private /24 subnet, so both subnets can 
coexist on the client.  The 10.11.45.0/255.255.255.0 subnet will match on 
any of the client's local traffic, while packets directed to 10.11.x.y 
will get routed back to the server when x is not equal to 45.

James

