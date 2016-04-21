MIME-Version: 1.0
In-Reply-To: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
	<A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 21 Apr 2016 10:11:17 +0200
Message-ID: <CAA1AbxKk4wz46dJzr4QSUWePF-egVwkQfpRpv5HdxhRtvQFO=A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
 supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

On Thu, Apr 21, 2016 at 8:51 AM, Jens <openvpn-devel@...2127...> wrote:
> Passing very long usernames/passwords for pam authentication could possibly lead to a stack based buffer overrun in the auth-pam plugin.
>
> Adds a dependency to C99 (includes stdbool.h)
>
> Signed-off-by: Jens Neuhalfen <jens@...2127...>
> ---
>  src/plugins/auth-pam/auth-pam.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 95692ab..159fd07 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -39,6 +39,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <ctype.h>
> +#include <stdbool.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <sys/types.h>
> @@ -119,17 +120,37 @@ static void pam_server (int fd, const char *service, int verb, const struct name
>   *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
>   *  infinite loop with clever 'searchfor' and 'replacewith' strings.
>   *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
> + *
> + *  Retuns NULL when
> + *   - any parameter is NULL
> + *   - the worst-case result is to large ( >= SIZE_MAX)
>   */
>  static char *
>  searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith)
>  {
> +  if (!tosearch || !searchfor || !replacewith) return NULL;
> +
> +  size_t tosearchlen = strlen(tosearch);
> +  size_t replacewithlen = strlen(replacewith);
> +  size_t templen = tosearchlen * replacewithlen;
> +
> +  if (tosearchlen == 0 || strlen(searchfor) == 0 || replacewithlen == 0) {
> +    return NULL;
> +  }
> +
> +  bool is_potential_integer_overflow =  (templen == SIZE_MAX) || (templen / tosearchlen != replacewithlen);
> +
> +  if (is_potential_integer_overflow) {
> +       return NULL;
> +  }
> +
> +  // state: all parameters are valid
> +
>    const char *searching=tosearch;
>    char *scratch;
> -  char temp[strlen(tosearch)*10];
> -  temp[0]=0;
>
> -  if (!tosearch || !searchfor || !replacewith) return 0;
> -  if (!strlen(tosearch) || !strlen(searchfor) || !strlen(replacewith)) return 0;
> +  char temp[templen+1];
> +  temp[0]=0;
>
>    scratch = strstr(searching,searchfor);
>    if (!scratch) return strdup(tosearch);

Thanks for following up.

ACK

-Steffan

