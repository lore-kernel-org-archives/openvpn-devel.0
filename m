MIME-Version: 1.0
References: <20201224115910.10129-1-domagoj@...2540...>
In-Reply-To: <20201224115910.10129-1-domagoj@...2540...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 Dec 2020 15:47:42 +0200
Message-ID: <CAGyAFMWSKZkZrfdUvzvcpghm+7WdGqUXyS1KyQ+9nb0X5R_J6Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Remove 1 second delay before running
 netsh
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Compiled with msvc.

Acked-by: Lev Stipakov <lstipakov@...277...>

to 24. jouluk. 2020 klo 14.00 Domagoj Pensa (domagoj@...2540...) kirjoitti:
>
> When running various netsh commands before each 1 second sleep is added.
> As more netsh commands are run, especially for Wintun adapters, that can
> add to a noticable delayed connecting time.
>
> This should be safe. No problems were found in tests and all netsh
> commands executed properly with delay removed. Also, no delays are used
> in a similar code in interactive service and netsh command executions
> are guarded with a semaphore.
>
> Instead of removing management_sleep(1), management_sleep(0) is used as
> a replacement to allow processing any pending actions on the management
> interface without any wait.
>
> Signed-off-by: Domagoj Pensa <domagoj@...2540...>
> ---
>  src/openvpn/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 400a50ca..0751ae46 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5207,7 +5207,7 @@ netsh_command(const struct argv *a, int n, int msglevel)
>      for (i = 0; i < n; ++i)
>      {
>          bool status;
> -        management_sleep(1);
> +        management_sleep(0);
>          netcmd_semaphore_lock();
>          argv_msg_prefix(M_INFO, a, "NETSH");
>          status = openvpn_execve_check(a, NULL, 0, "ERROR: netsh command failed");
> --
> 2.29.2
>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

