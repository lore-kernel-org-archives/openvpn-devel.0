References: <20170811090744.31750-1-a@...2181...>
 <20170811090744.31750-4-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b338acfb-acb9-b802-f8e6-03138a51b28d@...1856...>
Date: Sun, 13 Aug 2017 20:26:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170811090744.31750-4-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/5] add missing static attribute to
 functions
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


On 11-08-17 11:07, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> Functions used only in the file where they are
> defined and not exported in any header, should
> always defined as static in order to make the scope
> clear to the compiler and the developers.
> 
> Add the static attribute where missing.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/comp-lz4.c | 2 +-
>  src/openvpn/forward.c  | 2 +-
>  src/openvpn/manage.c   | 6 +++---
>  src/openvpn/mtcp.c     | 2 +-
>  src/openvpn/multi.c    | 4 ++--
>  src/openvpn/ntlm.c     | 2 +-
>  src/openvpn/options.c  | 8 ++++----
>  src/openvpn/proxy.c    | 2 +-
>  src/openvpn/route.c    | 4 ++--
>  src/openvpn/socket.c   | 2 +-
>  src/openvpn/ssl.c      | 2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index 6e40c325..e056caa8 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -185,7 +185,7 @@ lz4v2_compress(struct buffer *buf, struct buffer work,
>      }
>  }
>  
> -void
> +static void
>  do_lz4_decompress(size_t zlen_max,
>                    struct buffer *work,
>                    struct buffer *buf,
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index c45d1259..6cc59383 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1007,7 +1007,7 @@ process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, con
>      }
>  }
>  
> -void
> +static void
>  process_incoming_link(struct context *c)
>  {
>      perf_push(PERF_PROC_IN_LINK);
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 3bbe972e..88121a38 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -3515,7 +3515,7 @@ management_query_user_pass(struct management *man,
>  
>  #ifdef MANAGMENT_EXTERNAL_KEY
>  
> -int
> +static int
>  management_query_multiline(struct management *man,
>                             const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
>  {
> @@ -3591,7 +3591,7 @@ done:
>      return ret;
>  }
>  
> -char *
> +static char *
>  /* returns allocated base64 signature */
>  management_query_multiline_flatten_newline(struct management *man,
>                                             const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
> @@ -3620,7 +3620,7 @@ management_query_multiline_flatten_newline(struct management *man,
>      return result;
>  }
>  
> -char *
> +static char *
>  /* returns allocated base64 signature */
>  management_query_multiline_flatten(struct management *man,
>                                     const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index 851643a9..3cb52113 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -521,7 +521,7 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
>      return touched;
>  }
>  
> -int
> +static int
>  multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int action)
>  {
>      struct context *c = multi_tcp_context(m, mi);
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f5df58fa..fc20e0f9 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -485,7 +485,7 @@ multi_instance_string(const struct multi_instance *mi, bool null, struct gc_aren
>      }
>  }
>  
> -void
> +static void
>  generate_prefix(struct multi_instance *mi)
>  {
>      struct gc_arena gc = gc_new();
> @@ -2966,7 +2966,7 @@ gremlin_flood_clients(struct multi_context *m)
>  }
>  #endif /* ifdef ENABLE_DEBUG */
>  
> -bool
> +static bool
>  stale_route_check_trigger(struct multi_context *m)
>  {
>      struct timeval null;
> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
> index a251c11d..b43c0058 100644
> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -131,7 +131,7 @@ gen_nonce(unsigned char *nonce)
>      }
>  }
>  
> -void
> +static void
>  my_strupr(char *str)
>  {
>      /* converts string to uppercase in place */
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9f2ceea2..b1e04310 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -959,7 +959,7 @@ pull_filter_type_name(int type)
>  
>  #endif
>  
> -void
> +static void
>  setenv_connection_entry(struct env_set *es,
>                          const struct connection_entry *e,
>                          const int i)
> @@ -1378,7 +1378,7 @@ rol_check_alloc(struct options *options)
>      }
>  }
>  
> -void
> +static void
>  rol6_check_alloc(struct options *options)
>  {
>      if (!options->routes_ipv6)
> @@ -1808,7 +1808,7 @@ parse_http_proxy_override(const char *server,
>      }
>  }
>  
> -void
> +static void
>  options_postprocess_http_proxy_override(struct options *o)
>  {
>      const struct connection_list *l = o->connection_list;
> @@ -1925,7 +1925,7 @@ alloc_pull_filter(struct options *o, const int msglevel)
>      return f;
>  }
>  
> -void
> +static void
>  connection_entry_load_re(struct connection_entry *ce, const struct remote_entry *re)
>  {
>      if (re->remote)
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index 1ae93ad5..fdc73b4a 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -549,7 +549,7 @@ http_proxy_close(struct http_proxy_info *hp)
>      free(hp);
>  }
>  
> -bool
> +static bool
>  add_proxy_headers(struct http_proxy_info *p,
>                    socket_descriptor_t sd, /* already open to proxy */
>                    const char *host,       /* openvpn server remote */
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 5994cdca..762f489c 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -518,14 +518,14 @@ add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
>      l->routes_ipv6 = ro;
>  }
>  
> -void
> +static void
>  clear_route_list(struct route_list *rl)
>  {
>      gc_free(&rl->gc);
>      CLEAR(*rl);
>  }
>  
> -void
> +static void
>  clear_route_ipv6_list(struct route_ipv6_list *rl6)
>  {
>      gc_free(&rl6->gc);
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 09973d61..c8ab2f8d 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1533,7 +1533,7 @@ set_actual_address(struct link_socket_actual *actual, struct addrinfo *ai)
>  
>  }
>  
> -void
> +static void
>  socket_connect(socket_descriptor_t *sd,
>                 const struct sockaddr *dest,
>                 const int connect_timeout,
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index f5c59b77..45b20e56 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1607,7 +1607,7 @@ key_source2_print(const struct key_source2 *k)
>   * @param out           Output buffer
>   * @param olen          Length of the output buffer
>   */
> -void
> +static void
>  tls1_P_hash(const md_kt_t *md_kt,
>              const uint8_t *sec,
>              int sec_len,
> 
ACK

-Steffan

