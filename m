References: <d7604f16-8385-f0de-9d87-77d954a3c0cc@...1856...>
 <1517392380-21597-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <46b2e433-8587-b639-a338-a6f5dd8b9587@...1856...>
Date: Thu, 8 Feb 2018 20:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <1517392380-21597-1-git-send-email-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] show the right string for
 key-direction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 31-01-18 10:53, Arne Schwabe wrote:
> V2: print also a nice string if direction is not set
> V3: really include V2 changes
> ---
>  src/openvpn/crypto.c  | 11 +++++++++--
>  src/openvpn/crypto.h  |  2 +-
>  src/openvpn/options.c |  4 ++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 3096f3b0..b3021d4f 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1545,11 +1545,18 @@ ascii2keydirection(int msglevel, const char *str)
>  }
>  
>  const char *
> -keydirection2ascii(int kd, bool remote)
> +keydirection2ascii(int kd, bool remote, bool humanreadable)
>  {
>      if (kd == KEY_DIRECTION_BIDIRECTIONAL)
>      {
> -        return NULL;
> +        if (humanreadable)
> +        {
> +            return "not set";
> +        }
> +        else
> +        {
> +            return NULL;
> +        }
>      }
>      else if (kd == KEY_DIRECTION_NORMAL)
>      {
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 8e8ee8f5..e1e318eb 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -470,7 +470,7 @@ void must_have_n_keys(const char *filename, const char *option, const struct key
>  
>  int ascii2keydirection(int msglevel, const char *str);
>  
> -const char *keydirection2ascii(int kd, bool remote);
> +const char *keydirection2ascii(int kd, bool remote, bool humanreadable);
>  
>  /* print keys */
>  void key2_print(const struct key2 *k,
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 66e1f9d1..9f5cd6ed 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1706,7 +1706,7 @@ show_settings(const struct options *o)
>  #endif
>  
>      SHOW_STR(shared_secret_file);
> -    SHOW_INT(key_direction);
> +    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true), "%s");
>      SHOW_STR(ciphername);
>      SHOW_BOOL(ncp_enabled);
>      SHOW_STR(ncp_ciphers);
> @@ -3583,7 +3583,7 @@ options_string(const struct options *o,
>       * Key direction
>       */
>      {
> -        const char *kd = keydirection2ascii(o->key_direction, remote);
> +        const char *kd = keydirection2ascii(o->key_direction, remote, false);
>          if (kd)
>          {
>              buf_printf(&out, ",keydir %s", kd);
> 

'The right' here means 'what was in the config' instead of 'what we use
internally'.  But I agree that's better UX, so:

Acked-by: Steffan Karger <steffan@...1856...>
Tested-by: Steffan Karger <steffan@...1856...>

-Steffan

