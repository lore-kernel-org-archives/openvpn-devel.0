Message-ID: <1310a19a-d023-6357-2e2a-2ae65c5cf759@...2181...>
Date: Wed, 29 Jun 2022 15:19:35 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220531151746.101904-1-maximilian.fillinger@...2507...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220531151746.101904-1-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH v4] Don't "undo" ifconfig on exit if it
 wasn't done
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Hi,

On 31/05/2022 17:17, Max Fillinger wrote:
> When running with --ifconfig-noexec, OpenVPN does not execute ifconfig,
> but on exit, it still tries to "undo" the configuration it would have
> done. This patch fixes it by extracting an undo_ifconfig() function from
> close_tun(). The undo function is called before close_tun(), but only if
> --ifconfig-noexec isn't set. This is symmetric to how open_tun() and
> do_ifconfig() are used.
> 
> This change also allows us to drop the second argument from close_tun().
> 
> v2: Fix tabs-vs-spaces.
> v3: Fix another style mistake.
> v4: Move undo_ifconfig{4,6}() out of #ifdef TARGET_LINUX.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

Max, something that I feared (and that now became reality with DCO) is 
that we would still need the net-ctx object in open/close_tun().

The reason is that the DCO interface is created/destroyed by means of 
the networking APIs, therefore the net-ctx object is still required...

If you rebase this patch on top of latest master you will see what I mean.

Unfortunately this patch as is does not apply and does not compile 
easily anymore.

Max how do you feel about re-spinning this and see how to better handle 
this situation?

Thanks!


-- 
Antonio Quartulli

