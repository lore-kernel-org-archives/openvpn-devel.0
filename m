From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16646.65351.296384.210704@...253...>
Subject: Re: [Openvpn-devel] Re: [PATCH - 3 of 4]  separate "net-type" from "interface-type"
In-Reply-To: message from James Yonan on Tuesday July 27
References: <16645.48660.718636.245182@...253...>
	<twig.1090917867.31515@...41...>
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
Date: Tue Jul 27 18:21:04 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday July 27, jim@...41... wrote:
> I agree with you that tunnel device type and subnet vs. point-to-point mode
> are mutually exclusive properties.
> 
> My main concern is preventing an explosion in the size of the parameter
> permutation space, where the code has to handle 4 cases of dev/net
> permutations instead of only two.
> 
> $ grep DEV_TYPE *.[ch] | wc
>      59     328    2855
> 
> There are a lot of places where DEV_TYPE_x is referenced, and many of these
> places will now need to handle 4 cases instead of only 2.

I don't think so.  These places need to handle either DEV_TYPE or
NET_TYPE.  In no case is a 4-way test needed.  Some bits of code are
interesting in the dev type.  Some in the net type.  There is no
overlap.  See that patch....

NeilBrown

