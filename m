MIME-Version: 1.0
References: <20200310094822.588-1-simon@...2293...>
 <20200310094822.588-2-simon@...2293...>
In-Reply-To: <20200310094822.588-2-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 12 Mar 2020 17:00:09 +0200
Message-ID: <CAGyAFMX-vanP-DQbige7GjhV7oHdez_aX09i6W6BEbng57tQag@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] tun.c: revise the IPv4 ifconfig
 flow on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Looks good, tested with interactive service and without (netsh, ipapi).

A few questions:

>   This also fixes an issue with --windows-driver wintun overriding
>  --ip-win32 manual, the later being perfectly fine choice for Wintun too.

We do still have code which forces netsh for wintun:

    if (options->windows_driver == WINDOWS_DRIVER_WINTUN)
    {
        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
    }

Shouldn't we update options.c and ensure that only allowed ip_win32
for wintun are manual, netsh and ipapi?

> - open_tun() & tuntap_post_open(): unify Wintun and TAP-Windows6 workflow.

With that change, we flush ARP cache also for wintun. Is this needed?

> This allows allows --ip-win32 ipapi now.

See above - we need to get rid of forcing netsh with wintun for that to work.
To test ipapi case, I had to comment out netsh forcing.

Also, while testing this I found (and fixed) a bug
(https://patchwork.openvpn.net/patch/1039/),
I think that fix should go first - your patch exposes bug (prints
device_guid value) for wintun case.

