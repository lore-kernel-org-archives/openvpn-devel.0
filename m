References: <20201203154951.29382-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <53a9d994-312d-4349-33d2-2a0d39f50882@...2181...>
Date: Thu, 3 Dec 2020 18:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <20201203154951.29382-1-steffan@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] tls-crypt-v2: fix server memory leak
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Hi Steffan,

On 03/12/2020 16:49, Steffan Karger wrote:
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 27a4170d..5cde8a4b 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3619,6 +3619,7 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
>       * always free the tls_auth/crypt key. If persist_key is true, the key will
>       * be reloaded from memory (pre-cached)
>       */
> +    free_key_ctx(&c->c1.ks.tls_crypt_v2_server_key);
>      free_key_ctx_bi(&c->c1.ks.tls_wrap_key);
>      CLEAR(c->c1.ks.tls_wrap_key);
>      buf_clear(&c->c1.ks.tls_crypt_v2_wkc);

A few lines below we call key_schedule_free() (under certain conditions)
which also performs:

free_key_ctx(&ks->tls_crypt_v2_server_key);


I believe it is safe to call free_key_ctx() twice on the same object,
but wouldn't it be better to have it called once only along the same
code path?

Regards,


-- 
Antonio Quartulli

