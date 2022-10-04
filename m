Message-ID: <3563c3f9-d54c-e91e-c76c-3ca201da784c@...2181...>
Date: Tue, 4 Oct 2022 17:37:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221004145318.98467-1-gert@...1296...>
 <20221004153127.527-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221004153127.527-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] un-break
 undo_ifconfig_ipv4()/_ipv6() on all non-linux/non-win32 platforms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 04/10/2022 17:31, Gert Doering wrote:
> This commit needs a somewhat longer background story to explain the
> problem...
> 
> undo_ifconfig_ipv4()/_ipv6() started their life as part of the
> TARGET_LINUX (only) close_tun() function.
> 
> In commit 611fcbc48, these functions were created, to decouple IPv4/IPv6
> dependency, still TARGET_LINUX only, with an #ifdef ENABLE_IPROUTE
> inside, to differenciate iproute2 vs. old-style ifconfig.
> 
> Commit dc7fcd714 changed this to "the new linux API" (sitnl), calling
> net_addr_ptp_v4_del() etc. - in the first branch of the #ifdef,
> changing from ENABLE_IPROUTE to TARGET_LINUX, inside a TARGET_LINUX,
> so the #else branch was never looked at for any platform.  The code
> in that #else branch was still "the old linux ifconfig" style to
> undo IPv4/IPv6 address config on the tun interface.
> 
> Now, commit 0c4d40cb8 comes along and makes undo_ifconfig_ipvX() a
> global function, during the bugfix to "don't undo ifconfig if
> --ifconfig-noexec is in effect".  Due to "it makes the code a lot
> cleaner" undo_ifconfig*() is now called from do_close_tun_simple()
> and no longer from (Linux-) close_tun().
> 
> *This* now enables the old "linux ifconfig" code to be run on
> "all non-windows platforms" - running commands like
> 
>     ifconfig tun0 0.0.0.0
> 
> to remove the IPv4 address - which plain doesn't work on the BSDs
> (and has not been tested anywhere else).
> 
> This all said, it's debatable whether any platforms actually NEED
> this - all unixoid platforms remove IPv4/IPv6 addresses on interface
> destroy time, so for non-persistant tun/tap interfaces, there is no
> hard requirement to remove IP addresses on program exit.  For
> persistent tun/tap (pre-create with "ifconfig tun7 create") this is
> indeed useful to restore the pre-openvpn state by removing anything
> OpenVPN configured.
> 
> OpenVPN up to 2.5 did not do this IP address removal on any non-Linux
> platform, which is better than exec'ing an ifconfig command that does
> nothing but print an error message (very annoying in t_client.sh V=1 runs).
> 
> This all said: this patch brings an implementation of undo_ifconfig_*()
> for TARGET_FREEBSD ("ifconfig tunX $ip -alias"), and brings back the
> old "do nothing" behaviour for all other unixoid platforms.  Tested
> on FreeBSD 7.4, 12.3, 14.0.
> 
> v2: use #elif defined(TARGET_FREEBSD), otherwise it breaks other platforms
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-by: Antonio Quartulli <a@...2181...>


Cheers,

-- 
Antonio Quartulli

