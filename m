Message-ID: <432af4cc-081c-f20c-ec3c-72d9589786b6@...2080...>
Date: Wed, 14 Sep 2022 09:33:46 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <202208301957.27UJv74w093000@...2054...>
 <20220912074149.31160-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220912074149.31160-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation for --dev and
 --dev-node.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/09/2022 09:41, Gert Doering wrote:
> During the research for commit a5cf4cfb77f745 it turned out that
> OpenVPN's behaviour regarding "--dev arbitrary-name" is very
> platform-specific and not very well documented.
> 
> The referenced commit fixed DCO behaviour to be in line with non-DCO
> linux behaviour, this commit catches up on the documentation.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   doc/man-sections/vpn-network-options.rst | 38 +++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
> index 5b2f8470..559b2464 100644
> --- a/doc/man-sections/vpn-network-options.rst
> +++ b/doc/man-sections/vpn-network-options.rst
> @@ -69,15 +69,34 @@ routing.
>        dev tap4
>        dev ovpn
>   
> -  When the device name starts with :code:`tun` or :code:`tap`, the device
> -  type is extracted automatically.  Otherwise the ``--dev-type`` option
> -  needs to be added as well.
> +  What happens if the device name is not :code:`tun` or :code:`tap` is
> +  platform dependent.
> +
> +  On most platforms, :code:`tunN` (e.g. tun2, tun30) and :code:`tapN`
> +  (e.g. tap3) will create a numbered tun/tap interface with the number
> +  specified - this is useful if multiple OpenVPN instances are active,
> +  and the instance-to-device mapping needs to be known.  Some platforms
> +  do not support "numbered tap", so trying ``--dev tap3`` will fail.
> +
> +  Arbitrary names (e.g. ``--dev home``) will not work on most platforms,
> +  with the exception of Linux and FreeBSD with the DCO kernel driver.
> +
> +  There, arbitrary names are allowed, and will create a tun or DCO
> +  device named as requested.
> +

This is confusing and not quite right.  I've used "--dev home" for a 
long time on Linux with tun devices.  But it requires "--dev-type tun". 
There are no dependencies on DCO in this use case.

[...snip...]

> @@ -93,6 +112,11 @@ routing.
>     both the network connections control panel name and the GUID for each
>     TAP-Win32 adapter.
>   
> +  On other platforms, ``--dev-node node`` will influence the naming of the
> +  created tun/tap device, if supported on that platform.  If OpenVPN cannot
> +  figure out whether ``node`` is a TUN or TAP device based on the name,
> +  you should also specify ``--dev-type tun`` or ``--dev-type tap``.

IIRC correctly on Windows (too many years since last time with a more 
advanced setup there), --dev-node does not influence the naming of the 
tap-windows6 interface, but is a reference to the pre-created interface. 
  Windows didn't use to create interfaces on-the-fly like on 
Linux/BSD/macOS.  Not sure if that has changed with tap-windows6 and 
neither how this is with wintun or ovpn-dco-win.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


