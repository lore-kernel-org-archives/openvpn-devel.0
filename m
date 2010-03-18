Date: Thu, 18 Mar 2010 17:34:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100318163440.GI25238@...1296...>
References: <20100317225325.GE25238@...1296...>
	<4BA2191E.1080601@...1147...>
	<20100318131716.GH25238@...1296...> <4BA2362B.1050604@...1294...>
Mime-Version: 1.0
In-Reply-To: <4BA2362B.1050604@...1294...>
Subject: Re: [Openvpn-devel] Windows, OpenVPN-GUI, disconnect
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
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Mar 18, 2010 at 03:18:19PM +0100, Eike Lohmann wrote:
> On win7 with baloontips disabled you can connect but can't disconnect 
> via the gui.
> Maybe that's your problem?

Now that's an interesting information.

I'm on WinXP, so it's not the same issue - but to see someone else
having problems with "disconnect" is interesting, so it might not be
related to my build at all.

Mmmh.  More testing.  All this on WXP with the latest updates installed.

 a) remove all OpenVPN stuff, reboot, reinstall unmodified 2.1.1
    -> connect/disconnect works fine

 b) from there, deltapall / addtap the IPv6 capable tap driver, but
    stil use all the unmodified .exe
    -> connect/disconnect works fine

 c) reboot, try again (unmodified .exe, IPv6-capable tap driver)
    -> connect/disconnect works fine

 d) replace openvpn.exe + SSL DLLs with compiled-on-mingw/linux 
    IPv6-capable binaries, connect to IPv4-only tunnel server
    -> connect fine/disconnect FAIL

 e) copy unmodified binaries + DLL back
    -> connect/disconnect works fine

 f) replace openvpn.exe with compiled-on-mingw/windows IPv6-capable
    binary, connect to IPv4-only tunnel server
    -> connect fine/disconnect FAIL

... so it's definitely something in the binaries that I have built that 
makes disconnect fail, but it doesn't matter whether I compile the binary
on Linux or on Windows.

It's *not* related to TAP-driver changes (which is an important bit).


When running openvpn.exe from the "cmd.exe" command line, it does not matter
which binary I am using - "ctrl-c" never does anything, and "F4" always
causes a clean shutdown.

Weird, this.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

