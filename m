From: Stefan Monnier <monnier@...1282...>
Message-ID: <jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
Date: Fri, 19 Feb 2010 12:50:10 -0500
In-Reply-To: <20100219145623.GU9556@...1296...> (Gert Doering's message of
	"Fri, 19 Feb 2010 15:56:23 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c
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
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

>> I'm fine with whichever path you choose.  But just bear in mind, some
>> systems might not have IPv6 support - which breaks portability ...
> On the unixish side, there is no system which has tun/tap today but
> does not have IPv6.

What about embedded systems using uclibc compiled "without ipv6 support"?
Or is that some different kind of "support" that wouldn't affect your code?


        Stefan

