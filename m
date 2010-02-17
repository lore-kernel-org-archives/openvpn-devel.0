From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvwryb3cqw.fsf-monnier+inbox@...1269...>
References: <4B7BF370.8070807@...1114...>
Date: Wed, 17 Feb 2010 14:06:27 -0500
In-Reply-To: <4B7BF370.8070807@...1114...> (David Sommerseth's message
	of "Wed, 17 Feb 2010 14:47:28 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [IPv6 support] - usage of gethostbyname() in
	getaddr()
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
Cc: Openvpn-devel@lists.sourceforge.net

> When reviewing the patch "FQDN for routes should expand to all IPs"
> today, I spotted that there is a function called getaddr() (renamed to
> getaddr_all() in the mentioned patch).  This function again makes use of
> the old gethostbyname() function.  This is not compatible with IPv6
> addresses.

I'm glad other people replied in this thread: I know next to nothing
about those functions (which is why my patch just uses as much as
possible the pre-existing code and didn't move from gethostbyname to
something else).


        Stefan "Not a network programmer by a long shot, just a user who
                needed a specific feature"

