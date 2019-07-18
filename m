References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f5a58db3-8469-1577-155f-db2255e1d78c@...2181...>
Date: Thu, 18 Jul 2019 13:55:14 +0200
MIME-Version: 1.0
In-Reply-To: <1563442503-11119-1-git-send-email-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 18/07/2019 11:35, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Commit fb4e8ab added variable-length array which
> is C99 feature and is not supported by Visual Studio.
> 
> This removes VLA and writes data directly into passed buffer.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/crypto.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 69877d1..8bf33e7 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1895,14 +1895,18 @@ cleanup:
>  bool
>  generate_ephemeral_key(struct buffer *key, const char *key_name)
>  {
> +    const int len = BCAP(key);
> +
>      msg(M_INFO, "Using random %s.", key_name);
> -    uint8_t rand[BCAP(key)];
> -    if (!rand_bytes(rand, BCAP(key)))
> +
> +    if (!rand_bytes(BEND(key), len))

Are we sure we can't call this function with 'len' longer than the
available space in 'key' ?


Cheers,

>      {
>          msg(M_WARN, "ERROR: could not generate random key");
>          return false;
>      }
> -    buf_write(key, rand, BCAP(key));
> +
> +    buf_inc_len(key, len);
> +
>      return true;
>  }
>  
> 

-- 
Antonio Quartulli

