Date: Fri, 12 Mar 2010 23:51:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100312225101.GU25238@...1296...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [bbird@...1325...: Re: [PATCH] IPv6 support for
	TUN/TAP driver on windows]
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

forwarded with permission from Ben back to the list - another data
point: a successful test of the IPv6-patched windows binaries and
windows tap driver, on Windows XP.

More testers with Vista and Win7 needed :-)

gert


----- Forwarded message from Ben Bird <bbird@...1325...> -----

X-Spam-Status: No, score=-2.6 required=7.0 tests=BAYES_00 autolearn=no
	version=3.2.5
From: Ben Bird <bbird@...1325...>
To: Gert Doering <gert@...1296...>
Subject: Re: [PATCH] IPv6 support for TUN/TAP driver on windows
Date: Thu, 11 Mar 2010 16:45:24 -0700
Reply-To: bbird@...1325...
In-Reply-To: <20100307201731.GT25238@...1296...>
X-Mailer: Forte Agent 5.00/32.1171
X-Greylist: Delayed for 00:23:20 by milter-greylist-4.2.3 (delta2.greenie.net [194.97.144.211]); Fri, 12 Mar 2010 01:15:59 +0100 (CET)
X-Virus-Scanned: clamav-milter 0.95.3 at deltaii.greenie.net

On Sun, 7 Mar 2010 21:17:31 +0100, in gmane.network.openvpn.devel you wrote:

...

> - if someone is willing to risk the stability of his system, you can
>   test my binaries:
>
>    http://www.greenie.net/ipv6/tap0901-ipv6-20100307.tar.gz
>    http://www.greenie.net/ipv6/openvpn-win-ipv6-20100307.tgz
>
>   (extract in ...\openvpn\driver and ...\openvpn\bin, respectively,
>   then run deltapall.bat / addtap.bat)
>

Hi Gert,

I'm not a subscriber.  So, I can't reply to the list.  I follow it on gmane.org's NNTP relay.   

Just wanted to say thanks for all your efforts here, and let you know I am glad to risk it. :) I'm running your tap driver with success on winxp.

Ethernet adapter Local Area Connection 4:

        Connection-specific DNS Suffix  . : home.dream2cook.com
        Description . . . . . . . . . . . : TAP-Win32 Adapter V9
        Physical Address. . . . . . . . . : 00-FF-1B-05-0E-17
        Dhcp Enabled. . . . . . . . . . . : Yes
        Autoconfiguration Enabled . . . . : Yes
        IP Address. . . . . . . . . . . . : 192.168.110.6
        Subnet Mask . . . . . . . . . . . : 255.255.255.252
        IP Address. . . . . . . . . . . . : 2001:470:80d5:1::7           <--- woot!
        IP Address. . . . . . . . . . . . : fe80::2ff:1bff:fe05:e17%8
        Default Gateway . . . . . . . . . : fe80::8%8
        DHCP Server . . . . . . . . . . . : 192.168.110.5
        DNS Servers . . . . . . . . . . . : 192.168.1.1
                                            208.67.220.220
                                            fec0:0:0:ffff::1%1
                                            fec0:0:0:ffff::2%1
                                            fec0:0:0:ffff::3%1
        Lease Obtained. . . . . . . . . . : Thursday, March 11, 2010 16:30:38
        Lease Expires . . . . . . . . . . : Friday, March 11, 2011 16:30:38


C:\Documents and Settings\benb>ping6 www.greenie.net

Pinging delta2.greenie.net [2001:608:0:1007:a00:20ff:fefe:4bd2]
from 2001:470:80d5:1::7 with 32 bytes of data:

Reply from 2001:608:0:1007:a00:20ff:fefe:4bd2: bytes=32 time=230ms
Reply from 2001:608:0:1007:a00:20ff:fefe:4bd2: bytes=32 time=226ms
Reply from 2001:608:0:1007:a00:20ff:fefe:4bd2: bytes=32 time=226ms
Reply from 2001:608:0:1007:a00:20ff:fefe:4bd2: bytes=32 time=228ms

Ping statistics for 2001:608:0:1007:a00:20ff:fefe:4bd2:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 226ms, Maximum = 230ms, Average = 227ms

C:\Documents and Settings\benb>

Regards,
Ben


----- End forwarded message -----

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

