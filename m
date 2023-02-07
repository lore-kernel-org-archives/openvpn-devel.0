MIME-Version: 1.0
References: <20230203191440.136050-1-frank@...2641...>
 <20230203191440.136050-5-frank@...2641...>
In-Reply-To: <20230203191440.136050-5-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 7 Feb 2023 15:30:21 +0200
Message-ID: <CAGyAFMXzV3n-fw0PJ0-Aac3FZAchmfZG_V98aB=Gmc69xESZWw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Windows: fix unused variable in
 win32_get_arch
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Clear enough.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 3. helmik. 2023 klo 21.15 Frank Lichtenheld (frank@...2641...)
kirjoitti:
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  src/openvpn/win32.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 44176936..ad3d9bf6 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1358,7 +1358,6 @@ win32_get_arch(arch_t *process_arch, arch_t *host_arch)
>
>      USHORT process_machine = 0;
>      USHORT native_machine = 0;
> -    BOOL is_wow64 = FALSE;
>
>  #ifdef _ARM64_
>      *process_arch = ARCH_ARM64;
> @@ -1380,8 +1379,8 @@ win32_get_arch(arch_t *process_arch, arch_t *host_arch)
>      if (is_wow64_process2)
>      {
>          /* check if we're running on arm64 or amd64 machine */
> -        is_wow64 = is_wow64_process2(GetCurrentProcess(),
> -                                     &process_machine, &native_machine);
> +        BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(),
> +                                          &process_machine, &native_machine);
>          if (is_wow64)
>          {
>              switch (native_machine)
> @@ -1403,7 +1402,7 @@ win32_get_arch(arch_t *process_arch, arch_t *host_arch)
>      else
>      {
>          BOOL w64 = FALSE;
> -        is_wow64 = IsWow64Process(GetCurrentProcess(), &w64) && w64;
> +        BOOL is_wow64 = IsWow64Process(GetCurrentProcess(), &w64) && w64;
>          if (is_wow64)
>          {
>              /* we are unable to differentiate between arm64 and amd64
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

