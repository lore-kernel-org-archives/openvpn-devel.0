Message-ID: <018001c1f529$36323990$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <p05111701b8fbef2f355b@[192.168.22.100]>
Subject: Re: [Openvpn-devel] Mac OS X support
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon May  6 11:09:07 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, Christoph Pfisterer <cp@...16...>

Hello Christoph,

Hey, that's great news.  It looks like you were able to make it work with a
very small patch.

A couple comments:

(1) The TYPE_SOCKLEN_T macro is cool, but we can't rely on people having
autoconf 2.5 or newer (unless we start distributing configure in addition to
configure.in).  Is there a way the macro could be coded to eliminate this
dependency?  What is it in the macro that requires 2.5?

(2) You might want to take a look at 1.1.1.9 which is on the CVS now.  In
particular, tun.c has seen a lot of work over the weekend to add support for
solaris, freebsd, and openbsd.  You will want to add an #ifdef TARGET_DARWIN
to the mix.  You might also want to add a TARGET_DARWIN case to
do_ifconfig(), so OpenVPN's --ifconfig option works correctly on Mac OS X.

Can you edit INSTALL with the appropriate Mac OS X info, including a URL
where they can get your tun driver, and initial steps to create and
configure the tun device?

I will merge everything in your patch now except the TYPE_SOCKLEN_T macro
pending more thought.

Great Work!

James

----- Original Message -----
From: "Christoph Pfisterer" <cp@...16...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Monday, May 06, 2002 7:08 AM
Subject: [Openvpn-devel] Mac OS X support


> Hi all!
>
> With some tweaking, I was able to get OpenVPN running on Mac OS X and
> use it happily with a Linux peer. Discussion and patches follow.
>
> First of all, current versions of Mac OS X don't include a tun
> driver, although it is present in the source tree (publicly available
> via CVS). An independent port of the FreeBSD driver as a loadable
> module exists, but OpenVPN uncovered some bugs in it. I was able to
> fix those bugs and effectively took over maintenance of the driver.
> It is available from <http://chrisp.de/en/projects/tunnel.html>;
> OpenVPN requires at least version 1.1.0.
>
> OpenVPN itself also needed some small patches, mostly due to Mac OS
> X's customized GCC and its outdated BSD headers. There are three main
> problems:
>
> 1. There is no in_addr_t and uint32_t is not automatically defined.
> Some research revealed that uint32_t is defined in <stdint.h>, which
> is not included explicitly. On Linux, it is included implicitly by
> <netinet/in.h>, but not so on Mac OS X. This is easily fixed in
> syshead.h.
>
> 2. Apple's precompiling version of cpp doesn't know about macros with
> variable arguments. Passing the "--no-cpp-precomp" command line
> option gets rid of this. I added a small check to configure to add it
> automatically.
>
> 3. There is no socklen_t. Coming up with a quick workaround was easy,
> but fixing it properly wasn't. I found a quite complete configure
> test for this in OpenSSH, it actually originated from curl.
> Unfortunately it only works with autoconf 2.50 or newer.
>
> The attached patch is against the current CVS version (which
> identifies itself as 1.1.1.6). It compiles and runs fine on my Mac OS
> X box, although I haven't tested the new features yet.
>
> Please let me know what you think.
>
> Greetings,
> chrisp
>
> --
> chrisp a.k.a. Christoph Pfisterer   "Any sufficiently advanced
> cp@...16... - http://chrisp.de      bug is indistinguishable
> PGP key & geek code available        from a feature."


