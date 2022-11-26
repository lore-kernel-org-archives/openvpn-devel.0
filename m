Date: Sat, 26 Nov 2022 17:07:06 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4I5qjrFjHJLPTwH@...2685...>
References: <20221126141041.5098-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221126141041.5098-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Update PORTS
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Nov 26, 2022 at 03:10:41PM +0100, Gert Doering wrote:
> Instead of fully removing PORTS, keep "this is what you want to do for
> porting OpenVPN to a new platform" section, and update the PLATFORMS
> part to better reflect current status.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  PORTS | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/PORTS b/PORTS
> index ff76850d..b257c5d2 100644
> --- a/PORTS
> +++ b/PORTS
> @@ -11,20 +11,31 @@ Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
>  
>  PLATFORM STATUS:
>  
> -  * Linux 2.2+ (supported)
> -  * Solaris (supported)
> -  * OpenBSD 3.0 (supported but pthreads are broken)
> -  * Max OS X Darwin
> +Tier 1 platforms - actively tested for every source commit, across
> +multiple operating system versions
> +
> +  * Windows 7 and newer
> +  * Windows Server 2012 and newer
> +  * Linux 2.2+

Let's just use Linux. 2.2 is meaninglessly old at this point.

>    * FreeBSD
> +  * MacOS X

macOS

> +
> +Tier 2 platforms - it worked at some point, but is not actively tested
> +on "latest OS, latest OS libraries" so might break if larger changes
> +are done on the platform side
> +
> +  * OpenBSD
>    * NetBSD
> -  * Windows
> -  * 64 bit platforms -- I have heard reports that
> -    OpenVPN runs on Alpha Linux and FreeBSD.
> -  * ARM -- I have heard of at least one case
> -    where OpenVPN was successfully built and
> -    run on the ARM architecture.
> +  * DragonFly BSD
> +  * Solaris
> +  * AIX
> +
> +For underlying CPU architecture, everything 32 bit or 64 bit (Intel, AMD,
> +ARM, PowerPC, SPARC*) should work fine.  16 bit Architectures are unlikely
> +to work.
> +
>  
> -PORTING NOTES:
> +PORTING GUIDELINE TO A NEW PLATFORM:
>  
>    * Make sure that OpenSSL will build on your
>      platform.


Regards,
-- 
  Frank Lichtenheld

