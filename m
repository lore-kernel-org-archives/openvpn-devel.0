MIME-Version: 1.0
In-Reply-To: <1465477232-25826-1-git-send-email-gert@...1296...>
References: <1465477232-25826-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 9 Jun 2016 15:04:22 +0200
Message-ID: <CAA1Abx+aMJk4oNvtXFNuowQHCLYg2kYZRv4V3bQoeh9TZxhAFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Change --enable-pedantic to use
 -std=c99 and not -ansi (C90).
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Jun 9, 2016 at 3:00 PM, Gert Doering <gert@...1296...> wrote:
> There's quite a bit of our code that fails compilation with
> "gcc -pedantic -ansi" and should not be changed - like, LZ4 using
> "long long" variables which C90 does not have.  Be pragmatic.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index d733023..4f14ebd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1128,7 +1128,7 @@ fi
>  if test "${enable_pedantic}" = "yes"; then
>         enable_strict="yes"
>         CFLAGS="${CFLAGS} -pedantic"
> -       test "${WIN32}" != "yes" && CFLAGS="${CFLAGS} -ansi"
> +       test "${WIN32}" != "yes" && CFLAGS="${CFLAGS} -std=c99"
>  fi
>  if test "${enable_strict}" = "yes"; then
>         CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
> --
> 2.7.3

Yes please!  ACK.

-Steffan

