Subject: Re: [Openvpn-devel] OpenVPN 2.0 (test23) and logging
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1082568474.81615@...41...>
In-Reply-To: <40856D7E.7090907@...199...>
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
Date: Wed Apr 21 10:28:05 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mike Auty <m.auty@...199...>, openvpn-devel@lists.sourceforge.net

Mike Auty <m.auty@...199...> said:

> Hi James,
>      First off, great program, it's really amazing what you and the 
> other developers have achieved.
>      Secondly the new 2.0 seems to be working out quite well, but I ran 
> into a little difficulty.  The problem I was having turned out to be a 
> firewall misconfiguration (read something I should have checked at the 
> beginning, hehe), but whilst I was trying to debug a connection that 
> just wouldn't work I found it very difficult in the server logs to 
> differentiate messages from one connected client and another.
>      I'm guessing this is just a hangover from openvpn 1 having been 
> single connection only, but it would be really helpful to have some kind 
> of identifier that ties all the log messages relating to a particular 
> connection (and I guess one for messages that haven't been associated 
> with a particular connection yet).

Yes, that's a good point.  I did add the client common name to the connection
initiated and connection restarted/exited messages, but ideally one would want
all messages to have some kind of client prefix, that would probably consist
of the SSL/TLS common name + IP address.

>      Anyway, thanks again for a fantastic piece of software, I look 
> forward to trying out the future versions as soon as they get released!
>      Mike  5:)

Excellent... take care.

James


