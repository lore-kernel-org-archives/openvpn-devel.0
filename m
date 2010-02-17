From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwv1vgj4rnq.fsf-monnier+inbox@...1269...>
References: <4B7AE8D6.3020304@...1114...>
	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
	<4B7BF17F.4080109@...1114...>
Date: Wed, 17 Feb 2010 14:27:08 -0500
In-Reply-To: <4B7BF17F.4080109@...1114...> (David Sommerseth's message
	of "Wed, 17 Feb 2010 14:39:11 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

> Thanks a lot for you patch!  In general, it very looks good.  Can you
> elaborate a little bit on how you have tested this patch?

I've been using it on my client machines for the last few months.
This is not a very extensive test, obviously: they're all configured
identically and so they all lookup the same FQDNs received from the same
VPN server.

> Have you checked it for memory leaks?  (e.g. using valgrind)

No, my patch does not use dynamic memory allocation, so memory leaks
seem unlikely (tho I don't know enough of the functions I call to be
100% sure).

> What happens if no FQDNs are found?

I have not touched this part of the code, AFAIK, so the behavior should
be the same as before (not sure what it is).


        Stefan

