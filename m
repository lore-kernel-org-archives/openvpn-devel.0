From: Enrico Scholz <enrico.scholz@...1291...>
Date: Mon, 11 Jan 2010 15:31:01 +0100
Message-ID: <lyfx6ciuhm.fsf@...1290...>
References: <lypr5lvsu7.fsf@...1290...>
	<20100109180748.26114.qmail@...1287...>
	<lyr5pxhrp0.fsf@...1290...>
	<20100111133111.2974.qmail@...1287...>
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

>> >> I am running a multihomed host where 'local <extip>' must be
>> >> specified for proper operation.
>> >
>> > Could you add a route and use nobind? Unless you have one openvpn
>> > on each IP that should work.
>> 
>> I would really like to avoid the NAT hackery.
>
> I didn't mean to suggest any NAT. 

NAT would be required on a multihomed host with a routable external and
an unroutable internal IP where the internal one is the primary address
of the outgoing interface.


>> > I would actually expect the firewall to notice that there is a new
>> > connection. Since it doesn't, maybe you can explicitly allow this
>> > traffic?
>> 
>> I do not have access to this firewall.
>
> Can you reach someone who does? I guess the VPN working right is in
> their interest too, and..

The firewall is completely ok.  A TCP connection is identified by a
src<ip:port> + dst<ip:port> pair.  When the firewall has recorded an
active TCP connection and a TCP packet arrives with a corresponding pair
but unexpected flags (e.g. SYN) or sequence numbers, this packet is
detected as invalid and be dropped.


>> > I know I would prefer fixing the firewall rules.
>> 
>> I would prefer to fix openvpn ;)
>
> ..I maintain that the problem is actually with the firewall that
> doesn't notice the new connection. (I guess because of too simplistic
> packet inspection?)

no; it is because the OpenVPN client creates the same src + dst pair
for every connection.  I suggest to read some papers about stateful
firewalls before continuing this discussion.



Enrico


