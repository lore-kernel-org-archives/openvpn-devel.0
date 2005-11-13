From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1-beta7 released
In-Reply-To: <43770701.4030106@...481...>
Message-ID: <Pine.LNX.4.58.0511131458120.1972@...41...>
References: <Pine.LNX.4.58.0511121919160.1972@...41...> <43770701.4030106@...481...>
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
Date: Sun Nov 13 14:27:44 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Meno Abels <meno.abels@...481...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 13 Nov 2005, Meno Abels wrote:

> Hello,
> 
> why do you not included my ipv6 tcp mss fix patch?

Meno,

Sorry -- I missed it.

I took a look at the patch, and it looks good, though I would like to make 
one request:

Can you bracket the code with

  #ifdef ENABLE_IPv6

People who use OpenVPN in embedded applications are very sensitive to code 
size, and I'd like to make IPv6 support something that can be easily 
disabled.

For now we can put #define ENABLE_IPv6 in syshead.h.  In the future, I 
plan to have it controlled via ./configure option.

Thanks,
James


