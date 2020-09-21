References: <20200920090929.8321-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d682d99e-1c9a-6832-cb04-6f3d5d45f13f@...2181...>
Date: Mon, 21 Sep 2020 09:22:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200920090929.8321-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix line number reporting on config
 file errors after <inline> segments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 20/09/2020 11:09, Gert Doering wrote:
> <inline> segments neglected to increment the "current line number
> in config file" variable (line_num), so after the first <inline>,
> errors reported have the wrong line number.
> 
> Fix by introducing an extra argument to the check_inline*() /
> read_inline_file() call chain: "so many lines in the inline block".
> 
> Trac: #1325
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f370a2bb..af517bab 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -4634,7 +4634,8 @@ in_src_get(const struct in_src *is, char *line, const int size)
>  }
>  
>  static char *
> -read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
> +read_inline_file(struct in_src *is, const char *close_tag,
> +                 int *num_lines, struct gc_arena *gc)
>  {
>      char line[OPTION_LINE_SIZE];
>      struct buffer buf = alloc_buf(8*OPTION_LINE_SIZE);
> @@ -4643,6 +4644,7 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
>  
>      while (in_src_get(is, line, sizeof(line)))
>      {
> +        (*num_lines)++;
>          char *line_ptr = line;
>          /* Remove leading spaces */
>          while (isspace(*line_ptr))
> @@ -4677,9 +4679,11 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
>  }
>  
>  static bool
> -check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
> +check_inline_file(struct in_src *is, char *p[],
> +                  int *num_lines, struct gc_arena *gc)

Sorry for not chiming in earlier, but honestly I believe your other
option would be "cleaner". The other option being "return int instead of
bool, where the returned value is the number of lines of the inline'd
material.

If 0, we know there was no inline'd material, thus we can treat that
result as "not inline'd".

Anyway, this is just my opinion. If you believe this is a better
approach, I am fine with it too.

>  {
>      bool is_inline = false;
> +    *num_lines = 0;
>  
>      if (p[0] && !p[1])
>      {
> @@ -4692,7 +4696,7 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
>              p[0] = string_alloc(arg + 1, gc);
>              close_tag = alloc_buf(strlen(p[0]) + 4);
>              buf_printf(&close_tag, "</%s>", p[0]);
> -            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
> +            p[1] = read_inline_file(is, BSTR(&close_tag), num_lines, gc);

am I wrong or here we should add 1 to num_lines to include the opening
tag that was parsed *before* entering read_inline_file()?

Regards,




-- 
Antonio Quartulli

