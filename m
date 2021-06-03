MIME-Version: 1.0
References: <20210603123019.422644-1-matthias.andree@...68...>
In-Reply-To: <20210603123019.422644-1-matthias.andree@...68...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 3 Jun 2021 12:51:07 -0400
Message-ID: <CAKuzo_hhtAOFJKmpMfd3GqRfDFuJYu9hD5sRp9c7+HOYDcHi=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix SIGSEGV (NULL deref) receiving push
 "echo"
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, peo@...2618...

On Thu, Jun 3, 2021 at 8:32 AM Matthias Andree <matthias.andree@...68...> wrote:
>
> A server pushing "echo" without arguments can crash the client.
> In such a situation, the code in question receives p[1] == NULL
> (which was CLEAR(p)'ed above), hands it strncmp, which then
> dereferences the null pointer.
>
> Original report and analysis here:
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=256331
>
> Fixes: Trac #1409
> Reported-by: peo@...2618... (to FreeBSD)
> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8d417206..a54bc562 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5365,7 +5365,7 @@ add_option(struct options *options,
>          {
>              /* only message-related ECHO are logged, since other ECHOs
>               * can potentially include security-sensitive strings */
> -            if (strncmp(p[1], "msg", 3) == 0)
> +            if (p[1] && strncmp(p[1], "msg", 3) == 0)
>              {
>                  msg(M_INFO, "%s:%s",
>                      pull_mode ? "ECHO-PULL" : "ECHO",

Argh.. good to see already committed. I take all the blame for acking
the original..

This may take the award for the easiest bug to reproduce: just run
"openvpn --echo" no server, no config file required.



Selva

