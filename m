Message-ID: <4B951F0E.20005@...41...>
Date: Mon, 08 Mar 2010 09:00:14 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>	<20100221193132.GO9556@...1296...>	<20100221200311.11614.qmail@...1287...>	<20100221201416.GQ9556@...1296...>	<20100228222326.GU9556@...1296...>
	<20100307201731.GT25238@...1296...>
In-Reply-To: <20100307201731.GT25238@...1296...>
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

>>  - how does one debug Windows drivers?  Is there a printf() as in Linux
>>    that goes to console / syslog?
> 
> I have not yet figured out that part.  I did my debugging with Wireshark
> ("see what packets move back and forth and stare at the packet details").

While Windows doesn't support "printf" in device drivers, the TAP driver 
defines the DEBUGP macro that tries to do the same thing.

First, build a debug version of the driver.  This can be done by editing 
install-win32/settings.in (the domake-win configuration file) and 
uncommenting out this line:

   ;!define PRODUCT_TAP_DEBUG

If you look at the source code to the driver, you will see lots of 
DEBUGP macro references.  This is how you want to code your debugging 
printfs.

Next, there are two possible ways to view the debugging output:

Get the WinDBG tool from MS.  All of the DEBUGP calls will output log 
info in a form that can be received by WinDBG.

Use a special feature of OpenVPN on Windows that allows it to get the 
DEBUGP messages directly from the TAP driver and output them along with 
the normal OpenVPN log output.  This feature is enabled at --verb level 
6 and is internally referred to as D_TAP_WIN32_DEBUG in errlevel.h.

The disadvantage of the D_TAP_WIN32_DEBUG method is that it's only 
available after OpenVPN has successfully bound to a TAP adapter.  For 
example, if there's an error on initial driver loading that precludes 
OpenVPN from opening the TAP device, then only WinDBG would be able to 
show the DEBUGP output from such a condition.

James

