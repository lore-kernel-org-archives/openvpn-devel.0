MIME-Version: 1.0
References: <20210403155937.32330-1-a@...2181...>
In-Reply-To: <20210403155937.32330-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 3 Apr 2021 12:27:50 -0400
Message-ID: <CAKuzo_iAqY9W3OZtj7b9QvrXZpKf2dRoK9zz2Na3Hg+uMvDPsw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun.c: remove unused variable
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <antonio@...515...>

Hi

On Sat, Apr 3, 2021 at 12:01 PM Antonio Quartulli <a@...2181...> wrote:
>
> From: Antonio Quartulli <antonio@...515...>
>
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/tun.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 6b7c8ef1..60a3a179 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -281,7 +281,6 @@ out:
>  static bool
>  do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
>  {
> -    DWORD len;
>      bool ret = false;
>      ack_message_t ack;
>      struct gc_arena gc = gc_new();

This has been lurking around in the build logs for too long. Good riddance.
And, glad to see more eyes on the pariah windows-only code paths :)

Acked-by: selva.nair@...277...

