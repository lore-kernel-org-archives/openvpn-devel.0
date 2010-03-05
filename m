Date: Fri, 5 Mar 2010 19:07:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100305180708.GP25238@...1296...>
References: <20100305163926.GM25238@...1296...> <1267807973.14083.0@...1207...>
Mime-Version: 1.0
In-Reply-To: <1267807973.14083.0@...1207...>
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Mar 05, 2010 at 10:52:53AM -0600, Karl O. Pinc wrote:
> > open() first will exclusively lock it for you...
> 
> From OpenBSD's tun(4) man page:
> 
>      Each device has the exclusive open property; it cannot be 
>      opened if it is
>      already open and in use by another process.
>      ...
>      On the last close of the device, all queued packets are
>      discarded.  If the device was created by opening /dev/tunN, 
>      it will be
>      automatically destroyed.  Devices created via ifconfig(8) are 
>      only marked
>      as not running and traffic will be dropped returning EHOSTDOWN.
> 
> Which means to me that you want to omit the ifconfig destroy and
> create, thus:
> 
>    TUN/TAP device /dev/tun1 opened with open(2)
>    /* iterate increasing tunN number until you get other than
>     * EBUSY (the device was already opened), or suchlike searching */
>    /sbin/ifconfig tun1 10.1.1.18 10.1.1.17 mtu 1500 netmask \
>       255.255.255.255 up

This is what other platforms do, e.g. FreeBSD and Linux (on close,
auto-destroy - and if you want persistance, you need to do something
special).

Maybe this was changed between older OpenBSD versions and the current
versions?

Given this information, I will prepare a patch that will handle OpenBSD
the same way as FreeBSD is done - run open_tun() first, do_ifconfig()
second, and do away with the "ifconfig destroy" logic.  I'll send the
patch to the list for testing.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

