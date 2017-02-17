References: <1482585739-14441-1-git-send-email-steffan@...1856...>
	<b535a74e-ebe5-7235-329a-371738d90c9e@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <83d299a2-0ae8-2f38-ee73-f81b8cdd1181@...1856...>
Date: Fri, 17 Feb 2017 15:36:27 +0100
MIME-Version: 1.0
In-Reply-To: <b535a74e-ebe5-7235-329a-371738d90c9e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Feedback wanted: proof-of-concept
 recvmmsg() support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi David,

Thanks for the comments.

On 25-01-17 18:25, David Sommerseth wrote:
> First of all, not all kernels carry these system calls, I believe they
> were added in some of the 3.x kernels - but, IIRC, it has been
> backported to at least the RHEL6 2.6.32 kernels.  My memory is scarce
> about the 2.6.18 kernel base on RHEL5, but I believe only recvmmsg() is
> supported there.
>
> But kernel support isn't enough.  It needs to be supported in glibc as
> well, where recvmmsg() arrived in glibc-2.12 and sendmmsg() arrived in
> glibc-2.14.  And if glibc support is missing ... there's needed to so
> some tweaks here, having a wrapper which does the proper syscall() with
> SYS_recvmmsg and/or SYS_sendmmsg as the syscall number reference. (see
> /usr/include/bits/syscall.h and man syscall(2) for more info) ... but
> step carefully with such wrappers - as we need to consider
> cross-platforms (not saying we should support this feature on all
> platforms).
>
> So all this considered, configure.ac will need to do some probing if
> recvmmsg() and sendmmsg() are supported.

configure.ac has:

-AC_CHECK_FUNCS([sendmsg recvmsg])
+AC_CHECK_FUNCS([sendmsg recvmsg sendmmsg recvmmsg])

and the calls are inside

+#ifdef HAVE_RECVMMSG

Shouldn't that be enough?

> I know this patch covers recvmmsg() only.  But I think you can gain even
> more performance if looking into sendmmsg() as well.

Yes, but that's a little trickier, because it also need changing the
tun/tap side (we need to read multiple messages there to have some gain
from sendmmsg()).  I decided to do this one thing at a time :)

> I'll try to play a bit with this patch and see how things go on my side
> though.

Great, I am curious about your results.

-Steffan

