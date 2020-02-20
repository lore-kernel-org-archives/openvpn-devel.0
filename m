MIME-Version: 1.0
References: <1582163803-3342-1-git-send-email-selva.nair@...277...>
 <CAGyAFMVXUUStWv6MKt-JWkDrMU2GEM-v2Wn3hv+GFEGZxRRZrQ@...278...>
In-Reply-To: <CAGyAFMVXUUStWv6MKt-JWkDrMU2GEM-v2Wn3hv+GFEGZxRRZrQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 Feb 2020 09:27:19 -0500
Message-ID: <CAKuzo_jnq1h8b47+5MsG66LovYpV6=b-evtDs3O=dVttRAZeRA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix possible access of uninitialized
 pipe handles
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Thu, Feb 20, 2020 at 4:24 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Strangely, I do not see this warning (unlike another one about error
> in common.c)
> with GCC 7.3 despite adding -O1 and -Wmaybe-uninitialized.

I saw it on the travis build. With gcc 7.3, for some reason, -O1
doesn't show it but -O2 or higher does. Some older versions of gcc
seem to show it only with require -O3 or higher!

But the potential for attempting to close wrong handles looks real.

Thanks,

Selva

