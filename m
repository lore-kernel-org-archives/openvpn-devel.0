References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <764c4f1a-d60c-813b-7ef3-d7db2785e067@...2181...>
Date: Thu, 13 May 2021 22:22:04 +0200
MIME-Version: 1.0
In-Reply-To: <20210512131511.1309914-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/9] Add missing free_key_ctx for
 auth_token
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 12/05/2021 15:15, Arne Schwabe wrote:
> This is is a small memory leak as this key is only leaked once
> per server start.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

The leak can indeed be seen with valgrind when running the server with
--auth-gen-token:

==23481== HEAP SUMMARY:
==23481==     in use at exit: 536 bytes in 7 blocks
==23481==   total heap usage: 7,460 allocs, 7,453 frees, 1,364,174 bytes
allocated
==23481==
==23481== 536 (32 direct, 504 indirect) bytes in 1 blocks are definitely
lost in loss record 7 of 7
==23481==    at 0x48397EF: malloc (vg_replace_malloc.c:307)
==23481==    by 0x4AEB269: CRYPTO_zalloc (in /usr/lib64/libcrypto.so.1.1)
==23481==    by 0x4AE4D67: HMAC_CTX_new (in /usr/lib64/libcrypto.so.1.1)
==23481==    by 0x11F3A8: hmac_ctx_new (crypto_openssl.c:996)
==23481==    by 0x119B84: init_key_ctx (crypto.c:847)
==23481==    by 0x1135F6: auth_token_init_secret (auth_token.c:168)
==23481==    by 0x12B117: do_init_auth_token_key (init.c:2685)
==23481==    by 0x12B117: do_init_crypto_tls_c1 (init.c:2764)
==23481==    by 0x12B117: do_init_crypto_tls (init.c:2802)
==23481==    by 0x12FF07: do_init_crypto (init.c:3065)
==23481==    by 0x12FF07: init_instance (init.c:4179)
==23481==    by 0x130990: init_instance_handle_signals (init.c:3991)
==23481==    by 0x140109: tunnel_server_udp (mudp.c:278)
==23481==    by 0x14BD28: openvpn_main (openvpn.c:287)
==23481==    by 0x4C69E39: (below main) (in /lib64/libc-2.32.so)
==23481==
==23481== LEAK SUMMARY:
==23481==    definitely lost: 32 bytes in 1 blocks
==23481==    indirectly lost: 504 bytes in 6 blocks
==23481==      possibly lost: 0 bytes in 0 blocks
==23481==    still reachable: 0 bytes in 0 blocks
==23481==         suppressed: 0 bytes in 0 blocks

And after applying the patch the leak is gone:

==27117== HEAP SUMMARY:
==27117==     in use at exit: 0 bytes in 0 blocks
==27117==   total heap usage: 7,447 allocs, 7,447 frees, 1,295,605 bytes
allocated
==27117==
==27117== All heap blocks were freed -- no leaks are possible


Acked-by: Antonio Quartulli <antonio@...2612...>

Should this go to 2.5 too?

Regards,


-- 
Antonio Quartulli

