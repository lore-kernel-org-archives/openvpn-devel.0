From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Oct 2015 16:39:39 +0300
Message-ID: <mvllur$bcn$1@...1062...>
References: <1444827956-2169-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
In-Reply-To: <1444827956-2169-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH V2] Fix commit
	c67acea173dc9ee37220f5b9ff14ede081181992
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK from me. Tested on ics-openvpn, problem with endtag now fixed.

A nitpick. git am says:

/home/stiple/Projects/ics-openvpn/.git/modules/main/openvpn/rebase-apply/patch:20: 
trailing whitespace.
       char *line_ptr = line;
warning: 1 line adds whitespace errors.


On 14.10.2015 16:05, Arne Schwabe wrote:
> Move things to the proper place, ensure that line_ptr is actually properly
> initialized for *every* line read, not just for the first one
>
> ---
>   src/openvpn/options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 086dcea..c2b956d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3672,13 +3672,13 @@ static char *
>   read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
>   {
>     char line[OPTION_LINE_SIZE];
> -  char *line_ptr = line;
>     struct buffer buf = alloc_buf (8*OPTION_LINE_SIZE);
>     char *ret;
>     bool endtagfound = false;
>
>     while (in_src_get (is, line, sizeof (line)))
>       {
> +      char *line_ptr = line;
>         /* Remove leading spaces */
>         while (isspace(*line_ptr)) line_ptr++;
>         if (!strncmp (line_ptr, close_tag, strlen (close_tag)))
>



