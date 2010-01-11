From: Enrico Scholz <enrico.scholz@...1291...>
Date: Mon, 11 Jan 2010 11:16:43 +0100
Message-ID: <lyr5pxhrp0.fsf@...1290...>
References: <lypr5lvsu7.fsf@...1290...>
	<20100109180748.26114.qmail@...1287...>
Mime-Version: 1.0
Sender: news <news@...1062...>
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
To: openvpn-devel@lists.sourceforge.net

Peter Stuge <peter@...1287...> writes:

>> I am running a multihomed host where 'local <extip>' must be
>> specified for proper operation.
>
> Could you add a route and use nobind? Unless you have one openvpn on
> each IP that should work.

I would really like to avoid the NAT hackery.


>> On ungraceful reconnects, the new TCP connection will have same the
>> host/port pairs but unexpected sequence numbers. The new connection
>> will be assumed as invalid hence and be dropped.
>
> I would actually expect the firewall to notice that there is a new
> connection. Since it doesn't, maybe you can explicitly allow this
> traffic?

I do not have access to this firewall.


> OpenVPN can certainly be made to do what you describe, but it seems
> that there are more ways to solve the problem, and one of those might
> suit you better.

I think, supporting common TCP/UDP client functionality (which choses
random source ports) suits my needs best.  I do not see reasons why
'local' must be tied to 'lport'.


> I know I would prefer fixing the firewall rules.

I would prefer to fix openvpn ;)



Enrico


