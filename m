From: Steffen =?ISO-8859-15?Q?Sch=FCtz?= <st.sch@...95...>
Subject: Re: [Openvpn-devel] New feature: --ifconfig for tap devices
Message-Id: <20030907160205.46eb733d.st.sch@...95...>
In-Reply-To: <3F5B206F.5070402@...61...>
References: <twig.1062580090.46409@...41...>
	<3F5B206F.5070402@...61...>
Reply-To: st.sch@...95...
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Sep  7 10:06:02 2003
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hola Julien,

On Sun, 07 Sep 2003 14:11:27 +0200
julien Touche <julien.touche@...61...> wrote:

> 
> some googling drives me to this thread
> http://www.monkey.org/openbsd/archive/tech/0111/msg00098.html
> and
> find /sys -iname '*tap*' returns nothing
> 
> so i'm not sure openbsd stock-kernel has tap ...

Yep, OpenBSD has no tap-device support in the kernel.
Some days ago i was at the same point.

> if someone has more information (i will ask about it on misc@)

Someone has been porting the tap-device driver from FreeBSD
to OpenBSD. You can find more at http://diehard.n-r-g.com 
Well, the port and patch you can find on this side are not complete
for an out of the box start on OpenBSD 3.3-RELEASE.
The patch is dated at November 2001, so you can expect that this won't
work on 3.3-RELEASE. So, you've to modify the files by hand.
What the patch doesn't show, is that you've to modify /sys/conf/GENERIC
( and/or GENERIC_PART ) - it needs the following line:

pseudo-device   tap     2 # number of tap device

Further the file if_tap.c needs the function
tapkqfilter; it looks like the following :

int     
tapkqfilter(dev_t dev,struct knote *kn)
{
        return (1);
}


Without this function you'll get an error while compiling the new
kernel.
I had success on building a kernel with tap-device on OpenBSD/i386 and
on Openbsd/Sparc64 ( both 3.3 ).
So far so good. On an intel-box using it with openvpn i crashed the
kernel. Until yet no idea why and no time to get closer to the problem.
Well on the Sparc64 it's working. Means no kernel crash ;-)
Ok, i tried to get a tunnel working between a linux-intel-box and the
openbsd-sparc-box using openvpn 1.3.1. With a simple setup i only get
a "Peer Connection Initiated with ..." from openvpn on both after
pinging each side. That's all so far. Until yet i wasn't able to see
the icmp-packets via tcpdump on both tap devices. 
Maybe i don't see the trees in the wood.


Steffen
-- 
It's not the matter to break the wall with your head,
but to find the door with your eyes !

