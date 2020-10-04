References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
 <20201002175736.82609-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2df84a05-9234-b0e6-2d96-abc8800d0494@...2181...>
Date: Sun, 4 Oct 2020 17:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <20201002175736.82609-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix redirecting of IPv4 default gateway
 if connecting over IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02/10/2020 19:57, Gert Doering wrote:
> Commit aa34684972eb0 fixed a long-standing bug in setting the
> "route-list" flag RTSA_REMOTE_HOST for IPv4 ("we have a well-defined
> remote_host == VPN server IP address") even if connecting over IPv6.
> 
> Unfortunately the logic in redirect_default_route_to_vpn() was also
> wrong, and refused cooperation if that flag is not set, triggering
> the message
>     "NOTE: unable to redirect IPv4 default gateway -- Cannot
>      obtain current remote host address"
> 
> Correct operation: if RTSA_REMOTE_HOST is not set, or remote_host
> is IPV4_INVALID_ADDR (= 255.255.255.255), do not try to install a
> host route for continued connectivity to the VPN server - which is
> not needed when connecting over IPv6.  But the actual *routes*
> (/0 or 2 x /1) can be installed just fine.
> 
> There is a second bug here, which hits if there is no IPv4 gateway
> at all.  In that case, the same function triggers the message
>     "NOTE: unable to redirect IPv4 default gateway -- Cannot
>      read current default gateway from system"
> 
> This is caused by using "IPV4_INVALID_ADDR" as a flag for "do we
> know the remote_host?" - which worked before, but after the commit
> said above, the "remote_host" field is not well-defined unless
> RTSA_REMOTE_HOST is set.  So, change the condition to check that.
> 
> Reported-By: François Kooman <fkooman@...2318...>
> Reported-By: Thomas Schäfer <tschaefer@...75...>
> Trac: #1332
> 
> Signed-off-by: Gert Doering <gert@...1296...>

The bug becomes obvious after reading commit aa34684972eb0
This fix is basically cleaning up some conditions which did not adapt to
the new logic.

Stared at the code and tested on my system with and without an IPv4
default route.

Signed-off-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

