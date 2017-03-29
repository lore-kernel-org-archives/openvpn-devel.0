References: <20170329094925.25644-1-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <27013758-73eb-7bbd-5196-6d8020484dbd@...1435...>
Date: Wed, 29 Mar 2017 11:57:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170329094925.25644-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] docs: Fixed man-page warnings discoverd
 by rpmlint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 29-03-17 11:49, David Sommerseth wrote:
> Running rpmlint against Fedora RPM packages revealed these warnings:
> 
>   W: manual-page-warning /usr/share/man/man8/openvpn.8.gz 2738:
>      a special character is not allowed in a name
>   W: manual-page-warning /usr/share/man/man8/openvpn.8.gz 2740:
>      a special character is not allowed in a name
> 
> This is just a typo mistake in the .B formatting, missing a trailing
> space.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  doc/openvpn.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f29b72f..a9f5db7 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2735,9 +2735,9 @@ DEFAULT_DIR is replaced by the default plug-in directory,
>  which is configured at the build time of OpenVPN.  CWD is the
>  current directory where OpenVPN was started or the directory
>  OpenVPN have swithed into via the
> -.B\-\-cd
> +.B \-\-cd
>  option before the
> -.B\-\-plugin
> +.B \-\-plugin
>  option.
>  
>  For more information and examples on how to build OpenVPN
> 

This is easy enough: ACK.

-Steffan

