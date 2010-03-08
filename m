Date: Mon, 8 Mar 2010 17:04:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100308160448.GY25238@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
	<20100221200311.11614.qmail@...1287...>
	<20100221201416.GQ9556@...1296...>
	<20100228222326.GU9556@...1296...>
	<20100307201731.GT25238@...1296...> <4B951F0E.20005@...41...>
Mime-Version: 1.0
In-Reply-To: <4B951F0E.20005@...41...>
Subject: Re: [Openvpn-devel] [PATCH] IPv6 support for TUN/TAP driver
	on	windows
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
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Mar 08, 2010 at 09:00:14AM -0700, James Yonan wrote:
> >I have not yet figured out that part.  I did my debugging with Wireshark
> >("see what packets move back and forth and stare at the packet details").
> 
> While Windows doesn't support "printf" in device drivers, the TAP driver 
> defines the DEBUGP macro that tries to do the same thing.

I've seen these, but was missing the next steps - "how do I get to read
these messages".

[..]
> Next, there are two possible ways to view the debugging output:
> 
> Get the WinDBG tool from MS.  All of the DEBUGP calls will output log 
> info in a form that can be received by WinDBG.

Will check that.  There are "some debuggers" as part of the WDK, but I
have not yet looked into these in more detail.

> Use a special feature of OpenVPN on Windows that allows it to get the 
> DEBUGP messages directly from the TAP driver and output them along with 
> the normal OpenVPN log output.  This feature is enabled at --verb level 
> 6 and is internally referred to as D_TAP_WIN32_DEBUG in errlevel.h.

Now THAT is seriously cool :-)

I have seen that the code writes the debug messages "to a buffer", but
couldn't find out (yet) how to access the debug messages.

Thanks a lot for this.  I will use this information to improve the debug
printing of IPv6 packets (which is non-existant yet) and also add a bit
of debug printing to the code that does neighbor discovery / neighbor
advertisement spoofing, so it's visible in the logs what happens and
why.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

