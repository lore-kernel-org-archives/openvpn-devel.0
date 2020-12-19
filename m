Date: Sat, 19 Dec 2020 14:22:33 +0100
From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20201219132233.GA175082@...2540...>
References: <20201215173004.26170-1-domagoj@...2540...>
 <CAGyAFMV8ztjmyRSMcT0=MPefkkcUQ9yMErT5xu7so3agCTB9HA@...278...>
MIME-Version: 1.0
In-Reply-To: <CAGyAFMV8ztjmyRSMcT0=MPefkkcUQ9yMErT5xu7so3agCTB9HA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Skip DHCP renew with Wintun adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi!

I've done some more investigation and I've found out that problem was 
introduced in commit:

09ae6280 tun.c: revise the IPv4 ifconfig flow on Windows

in the following change:

@@ -6420,10 +6419,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     struct gc_arena gc = gc_new(); /* used also for device_guid allocation */
     tun_open_device(tt, dev_node, &device_guid, &gc);
 
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
-    {
     tuntap_post_open(tt, device_guid);
-    }
 
     gc_free(&gc);

Due to that, DHCP setup section in tuntap_set_ip_addr() is executed when 
Wintun is used, but it shouldn't.

As dhcp_masq_post is false for Wintun, fork_dhcp_action() is executed and 
that outputs warning and does unnecessary fork.

With my patch applied, DHCP setup is done only when TAP-Windows6 is used.

In my case server pushes both dhcp-renew and dhcp-release.

When I pull-filter ignore them no forking occurs and thus no warning.

I hope this helps.

Regards,
Domagoj

On Fri, Dec 18, 2020 at 12:45:43PM +0200, Lev Stipakov wrote:
> Hi,
> 
> The patch looks fine, but I wonder how did you manage to trigger this case?
> 
> dhcp_release() or dhcp_renew() are called if dhcp_masq_post is set to true,
> which only happens for tap-windows6.
> 
> fork_dhcp_action() is no-op unless dhcp-renew/dhcp-pre-release
> are explicitly defined in the ovpn profile.
> 
> If latter is the case, I wonder if options postprocessing would be a
> better place
> to fix it.
> 
> -Lev

