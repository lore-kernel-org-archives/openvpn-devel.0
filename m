References: <e0ce41fa-d0b7-a5af-d021-133239911898@...277...>
	<20170319184135.23548-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6f73cd46-c9fc-10fa-2538-f820998c610e@...1856...>
Date: Mon, 20 Mar 2017 19:20:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170319184135.23548-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make ENABLE_OCC no longer depend on
 !ENABLE_SMALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 19-03-17 19:41, Gert Doering wrote:
> OCC is useful functionality which (according to LEDE devs) adds only
> about 3k to the binary size - and if the embedded router folks can
> afford this trade-off, everyone else can :-)
> 
> Inspired by https://git.lede-project.org/?p=source.git;a=commit;h=b613c96d94bcdcda7abb3be68ea1c281ce5fbb47
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/syshead.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index a1b6047..f445864 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -589,9 +589,7 @@ socket_defined(const socket_descriptor_t sd)
>  /*
>   * Should we include OCC (options consistency check) code?
>   */
> -#ifndef ENABLE_SMALL
>  #define ENABLE_OCC
> -#endif
>  
>  /*
>   * Should we include NTLM proxy functionality
> 

If we unconditionally enable OCC, should we not just rip out #ifdef
ENABLE_OCC everywhere?

-Steffan

