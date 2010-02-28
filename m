Date: Sun, 28 Feb 2010 23:23:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100228222326.GU9556@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
	<20100221200311.11614.qmail@...1287...>
	<20100221201416.GQ9556@...1296...>
Mime-Version: 1.0
In-Reply-To: <20100221201416.GQ9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] make ipv6_payload compile
	under	windowze ( feat_ipv6_payload branch )
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

to follow up on this...

On Sun, Feb 21, 2010 at 09:14:16PM +0100, Gert Doering wrote:
> On Sun, Feb 21, 2010 at 09:03:11PM +0100, Peter Stuge wrote:
> > Gert Doering wrote:
> > > I'll try to figure out how to setup a cross-compile environment 
> > > during next week,
> > 
> > Some Linux distributions have premade mingw packages.
> > 
> > In Gentoo building a toolchain for mingw is as simple as:
> > 
> > emerge crossdev && crossdev -t i686-mingw32
[..]
>
> Thanks for that.  I was googling in parallel, and that's exactly
> what is going on in the background here right now (crossdev building 
> the mingw environment) :-)
> 
> I saw a note here on the list a few weeks ago pointing to the opensc
> "build" tool, and I'll try that, as soon as the cross-tools are done.

I have been able to successfully build OpenVPN.exe from Linux, using
the crossdev-provided "i586-mingw32msvc" environment.  The resulting
binary is compatible with the openvpn-gui from the "official" installer,
as long as I install my cross-compiled .DLLs as well as openvpn.exe - 
the "shipped" DLLs don't work, but that's not really a problem right
now.


My largest problem right now is that the tun/tap driver does not support
IPv6 if in "tun" mode - the code is quite explicit about it...

tap-win32/tapdrvr.c, line 1568:

    //===============================================
    // In Point-To-Point mode, check to see whether
    // packet is ARP or IPv4 (if neither, then drop).
    //===============================================

(there's good reasons for what it does)


Now... is there someone who has worked on this before, and can help
me a bit with it?  

Initial questions:

 - can it be cross-compiled?  If yes, how?  If no, what needs to be
   done on Windows to compile it?  (I have *no* experience with Windows,
   but I can follow instructions and read documentation).

 - what needs to be done to install the driver / replace the existing
   driver?

 - how does one debug Windows drivers?  Is there a printf() as in Linux
   that goes to console / syslog?

gert

PS: ifconfig + route work fine, and receiving packets also works (verified
with wireshark).  Just sending win->tun->openvpn doesn't
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

