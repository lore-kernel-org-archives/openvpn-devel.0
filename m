Message-ID: <0cb90930-1491-41bd-b577-dbf3a44b57a4@...2108...>
Date: Wed, 8 Jan 2025 15:59:42 +0100
MIME-Version: 1.0
References: <20241231204629.1210040-1-ben.boeckel@...2851...>
 <20241231204629.1210040-2-ben.boeckel@...2851...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
In-Reply-To: <20241231204629.1210040-2-ben.boeckel@...2851...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] console_systemd: remove the timeout
 when using `systemd-ask-password`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Ben Boeckel <ben.boeckel@...2851...>
Cc: openvpn-devel@lists.sourceforge.net

On 31/12/2024 21:46, Ben Boeckel via Openvpn-devel wrote:
> Without this, the password request will expire after 90 seconds leaving
> no way to provide the password without OpenVPN asking for it again.
> Given that interactive use will wait for input without a timeout, it
> makes sense to have non-interactive usage also wait until the user is
> ready instead of forcing users to race against the timeout.
> ---
>   src/openvpn/console_systemd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
> index cc91cd10..b208a614 100644
> --- a/src/openvpn/console_systemd.c
> +++ b/src/openvpn/console_systemd.c
> @@ -71,6 +71,7 @@ get_console_input_systemd(const char *prompt, const bool echo, char *input, cons
>       }
>   #endif
>       argv_printf_cat(&argv, "--icon network-vpn");
> +    argv_printf_cat(&argv, "--timeout=0");
>       argv_printf_cat(&argv, "%s", prompt);
>   
>       if ((std_out = openvpn_popen(&argv, NULL)) < 0)

Thanks a lot!  Since I wrote this integration years ago ... I'd like to 
chime in here.

Generally, change looks conceptually good and I agree to the reasoning 
for this change.  What I'd like to ensure is that we're not hitting some 
systemd version regression situations.

The oldest Linux distributions OpenVPN 2.x care about today are, to my 
knowledge, RHEL/Alma Linux/Rocky Linux 8 on the RPM side.  On the .deb 
side of things, I believe Debian 12 is the oldest supported stable release.

 From what I see, RHEL-8 ships with systemd v239, which has this 
argument.  I don't have a Debian 12 (or 11, if OpenVPN 2.x is still 
supported there) handy now to check.

Given that the oldest Linux distro with systemd which supports the
--timeout argument in systemd-ask-password, this can get my ACK.



-- 
kind regards,

David Sommerseth
OpenVPN Inc


