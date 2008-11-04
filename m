Message-ID: <49109373.5010309@...41...>
Date: Tue, 04 Nov 2008 11:24:51 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <48EDBFC7.9040301@...41...>
	<20081017114951.GA24872@...1139...>
In-Reply-To: <20081017114951.GA24872@...1139...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc13 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Felix Kronlage <kronlage@...1144...>, Openvpn-devel@lists.sourceforge.net

Felix Kronlage wrote:
> On Thu, Oct 09, 2008 at 02:24:39AM -0600, James Yonan wrote:
> 
> Hi Yonan,
> 
>> Changelog:
>> 2008.10.07 -- Version 2.1_rc13
>> * Bundled OpenSSL 0.9.8i with Windows installer.
>> * Management interface can now listen on a unix
>>    domain socket, for example:
>>
>>      management /tmp/openvpn unix
>>
>>    Also added management-client-user and management-client-group
>>    directives to control which processes are allowed to connect
>>    to the socket.
> 
> what I dont quite understand is, why you add stuff like this to
> the release candidate instead of finally getting 2.1 out of the
> door and then make small subsequent releases. OpenVPN has been
> stuck (imho) for way too long in the RC phase now entering the
> infamous game of not just adding new stuff to RC's but instead
> introducing bugs in the RCs instead of just closing them...

It's a good question that deserves a full answer.

I'll agree with anyone that it's taken longer than expected to get 2.1 
final out the door.  But I would encourage you to take a look at the 
commit log for 2008, and you will see that the changes predominantly 
address fixes.

With regard to the unix domain socket fix above, I would argue that 
supporting unix domain sockets in the management interface is an 
important security feature.  This is because passwords and other 
sensitive data may be passed across the management interface connection, 
and only unix domain sockets give each side of the connection the 
ability to see which UID and GID is connected to the other side.

There are other reasons as well for a long 2.1 beta cycle.  One of them 
is that quite a large number of people are using OpenVPN now, and it 
increases the frequency of obscure bug reports, some of which are 
difficult or impossible to reproduce by the development team.  When we 
fix one of these bugs, sometimes it takes days or weeks to know for sure 
whether the bug was really fixed (for example see r3330 from 
mid-September, "fixed a bug that can cause SSL/TLS negotiations in UDP 
mode to fail if UDP packets are dropped").

Another reason for the delay is our goal to stabilize the Management 
Interface API before 2.1 final.  The management interface is a major 
connection point between OpenVPN and other software packages (such as 
client or server GUIs) and as such we need to ensure its completeness 
before we mark the 2.1 milestone, so that we can avoid the 
community-wide support headaches associated with a moving-target API.

I think there's a precedent as well for long-term beta cycles.  In the 
old days of pre-open-source computing, beta cycles were short, internal 
testing affairs that might only last a few months.  Companies needed to 
get stuff out the door, even if it wasn't ready, because they had to get 
to the revenue.  Then open source came onto the scene and I think it's 
redefined, to a certain extent, the beta cycle.  Now the beta cycle is 
ended only at that point where widespread testing and usage by the 
community proves the stability of the product and the readiness to end 
the beta cycle.  Today, even commercial companies such as Google have 
embraced that standard.

So yes, getting 2.1 final out the door is a top priority for us.  But it 
won't happen until it's ready.

James

