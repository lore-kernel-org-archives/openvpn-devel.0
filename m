References: <1445380656-20654-1-git-send-email-steffan@...1856...>
	<1445414886-11052-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <562748D4.6010405@...1227...>
Date: Wed, 21 Oct 2015 10:12:04 +0200
MIME-Version: 1.0
In-Reply-To: <1445414886-11052-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] hardening: add insurance to exit on a
 failed ASSERT()
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

ACK. Fine, whatever makes the analyzers happy.

Arne

Am 21.10.15 um 10:08 schrieb Steffan Karger:
> The code behind our ASSERT() macro is pretty complex.  Although it seems
> to be correct, make it trivially clear we will never return from a failed
> assert by adding an _exit(1) call.  As was suggested by Sebastian Krahmer
> of the SuSE security team.
>
> To make sure they that tools like clang static analyzer and coverity
> understand that assert_failed() will not return, add an
> __attribute__((__noreturn__)) annotation.
>
> v2: use __attribute__ instead of inline to convince static analysers.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/error.c | 1 +
>  src/openvpn/error.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 77b6cec..66f37f3 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -397,6 +397,7 @@ void
>  assert_failed (const char *filename, int line)
>  {
>    msg (M_FATAL, "Assertion failed at %s:%d", filename, line);
> +  _exit(1);
>  }
>  
>  /*
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index d5204f3..4d33843 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -210,7 +210,7 @@ FILE *msg_fp(const unsigned int flags);
>  /* Fatal logic errors */
>  #define ASSERT(x) do { if (!(x)) assert_failed(__FILE__, __LINE__); } while (false)
>  
> -void assert_failed (const char *filename, int line);
> +void assert_failed (const char *filename, int line) __attribute__((__noreturn__));
>  
>  #ifdef ENABLE_DEBUG
>  void crash (void); /* force a segfault (debugging only) */


