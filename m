Message-ID: <9e2d127f-b15d-de8a-abdb-6cf7879268b4@...2080...>
Date: Tue, 9 Nov 2021 13:54:11 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211107183805.8357-1-frank@...2641...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20211107183805.8357-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] README.down-root: Fix plugin module name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@...124...>

On 07/11/2021 19:38, Frank Lichtenheld wrote:
> From: Ville Skyttä <ville.skytta@...124...>
> 
> The module name is openvpn-plugin-down-root.so, not openvpn-down-root.so.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   src/plugins/down-root/README.down-root | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> As part of an initative to clean up the Github PR submissions, submitting
> this patch to the mailing list for inclusion. Looks obviously correct to
> me.
> PR: https://github.com/OpenVPN/openvpn/pull/98
> 
> diff --git a/src/plugins/down-root/README.down-root b/src/plugins/down-root/README.down-root
> index d337ffe9..98a3ee63 100644
> --- a/src/plugins/down-root/README.down-root
> +++ b/src/plugins/down-root/README.down-root
> @@ -16,13 +16,13 @@ run in the same execution environment as the up script.
>   BUILD
>   
>   Build this module with the "make" command.  The plugin
> -module will be named openvpn-down-root.so
> +module will be named openvpn-plugin-down-root.so
>   
>   USAGE
>   
>   To use this module, add to your OpenVPN config file:
>   
> -  plugin openvpn-down-root.so "command ..."
> +  plugin openvpn-plugin-down-root.so "command ..."
>   
>   CAVEATS

This change is correct.  And even according to
src/plugins/down-root/Makefile.am:

      plugin_LTLIBRARIES = openvpn-plugin-down-root.la

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


