Date: Fri, 27 Sep 2013 10:34:43 +0200 (CEST)
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
In-Reply-To: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] Does openvpn 2.3.2 has memory
	leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

----- Original Message ----- 
> From: "Brad Zhang" <hebei5000@...277...>
> To: openvpn-users@lists.sourceforge.net
> Sent: Friday, 27 September, 2013 8:11:56 AM
> Subject: [Openvpn-users] Does openvpn 2.3.2 has memory leak?
>
> Hi all,
>
> I tested openvpn 2.3.2 (openssl) with 200 connections. Set the renegotiation
> value to 600 seconds.
>
> initiate: 136M
> renegotiate 1 259M

This gap from initial to the first renegotiation isn't unexpected.  It's not
necessarily a leak itself, but most likely memory allocated for each client.
We've estimated earlier that it's roughly 1MB per client.  Your growth here
is around 600KB per client, so I'd say that's within the expected limits.

> renegotiate 2 262M
> renegotiate 3 264M
> renegotiate 4 266M
> renegotiate 5 267M

Here you have incremental steps of 2MB per renegotiation, which means with
200 clients roughly 10KB per client.  This does however sound like a smaller
memory leak.

For wow long time did you run this test?  Did you let the clients
disconnect at then end to see if the memory impact was reduced after OpenVPN
releases the sessions?  (OpenVPN may keep session data for some time after a
disconnect in case it was connection drop-out, esp. with UDP.  Look at 
--explicit-exit-notify in the man page for some more information)

Also, how did you measure OpenVPN's memory usage?

> I have tried the openvpn 2.1 rc4, there is no this issue. I do not know why
> the memory usage will increase after one time renegotiation. Could someone
> help me?

To compare against 2.1_rc4 is a bit too big gap.  I'd appreciate if you
could run your test against 2.2.2.  And if that's still leaking, you would
need to check against 2.1.4 (the last 2.1 community version)

Could we also see your server config?  Just to see if you use some kind of
plugins, script hooks or other possible candidates for triggering this issue.

I'm running OpenVPN 2.3 servers a couple of places, but not with 200 clients.
But I've not noticed any particular issues there.  However, if the leak is 
~10KB per client, it would most likely have had scheduled maintenance
reboots happening before noticing a leak.


--
kind regards,

David Sommerseth

