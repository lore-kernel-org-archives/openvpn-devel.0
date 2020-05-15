References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6609920b-5fb5-ce31-14fd-ef4743921d42@...2080...>
Date: Fri, 15 May 2020 19:38:50 +0200
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Implement forwarding client
 CR_RESPONSE messages to management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 09/11/2019 16:13, Arne Schwabe wrote:
> When signalling the client that it should do Challenge response
> without reconnecting (IV_SSO=crtext/INFOPRE=CR_TEXT), the server
> needs forward the response via the management console.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 26 +++++++++++++++++++++++++-
>  src/openvpn/forward.c    |  4 ++++
>  src/openvpn/manage.c     | 28 +++++++++++++++++++++++++++-
>  src/openvpn/manage.h     |  4 ++++
>  src/openvpn/push.c       | 21 +++++++++++++++++++++
>  src/openvpn/push.h       |  2 ++
>  6 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 4b405a9b..6d29b0d6 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -971,7 +971,7 @@ The ">CLIENT:" notification is enabled by the --management-client-auth
>  OpenVPN configuration directive that gives the management interface client
>  the responsibility to authenticate OpenVPN clients after their client
>  certificate has been verified.  CLIENT notifications may be multi-line, and
> -the sequentiality of a given CLIENT notification, its associated environmental
> +the sequentially of a given CLIENT notification, its associated environmental
>  variables, and the terminating ">CLIENT:ENV,END" line are guaranteed to be
>  atomic.
>  
> @@ -1013,6 +1013,30 @@ CLIENT notification types:
>  
>      >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
>  
> +(5) Single Sign On Based Challenge/Response

Perhaps something like "Management interface based Challenge/Response protocol"?

> +   >CLIENT:CR_RESPONSE,{CID},{KID},{response_base64}
> +   >CLIENT:ENV,name1=val1
> +   >CLIENT:ENV,name2=val2
> +   >CLIENT:ENV,...
> +   >CLIENT:ENV,END
> +
> +   CR_RESPONSE notification. The >CR_RESPONSE fulfils the same purpose as the
> +   CRV1 response in the traditional challenge/response. See that section below for more
> +   details. Since this still uses the same cid as the original response, we do
> +   not use the username and opaque session data in this response.

It would be good to clarify that this response happens when the client uses
'cr-response' via the client management interface.  And perhaps mention how it
looks like on the control channel wire protocol as well.  This can be seen in
context of the "lacking documentation" comment in patch 3/5.

[...snip...]

>  Variables:
>  
>  CID --  Client ID, numerical ID for each connecting client, sequence = 0,1,2,...
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 0f735384..48c316c9 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -403,6 +403,10 @@ check_incoming_control_channel_dowork(struct context *c)
>              {
>                  server_pushed_info(c, &buf, 4);
>              }
> +            else if (buf_string_match_head_str(&buf, "CR_RESPONSE"))
> +            {
> +                receive_cr_response(c, &buf);
> +            }
>              else
>              {
>                  msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(&buf));
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index c055f2ce..b3a4d5c8 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2908,7 +2908,7 @@ management_notify_generic(struct management *man, const char *str)
>  #ifdef MANAGEMENT_DEF_AUTH
>  
>  static void
> -man_output_peer_info_env(struct management *man, struct man_def_auth_context *mdac)
> +man_output_peer_info_env(struct management *man, const struct man_def_auth_context *mdac)

Is this change strictly related to the CR_RESPONSE forwarding?  If not, it
should be separated into its own commit.

>  {
>      char line[256];
>      if (man->persist.callback.get_peer_info)
> @@ -2958,6 +2958,32 @@ management_notify_client_needing_auth(struct management *management,
>      }
>  }
>  
> +void
> +management_notify_client_cr_response(unsigned mda_key_id,
> +        const struct man_def_auth_context *mdac,
> +        const struct env_set *es,
> +        const char* response)
> +{
> +    struct gc_arena gc;
> +    if (management)
> +    {
> +        gc = gc_new();
> +
> +        struct buffer out = alloc_buf_gc(256, &gc);
> +        msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s",
> +                mdac->cid, mda_key_id, response);
> +        man_output_extra_env(management, "CLIENT");
> +        if (management->connection.env_filter_level>0)
> +        {
> +            man_output_peer_info_env(management, mdac);
> +        }
> +        man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
> +        management_notify_generic(management, BSTR(&out));
> +
> +        gc_free(&gc);
> +    }
> +}
> +
>  void
>  management_connection_established(struct management *management,
>                                    struct man_def_auth_context *mdac,
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index f570afc6..ff6b6737 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -432,6 +432,10 @@ void management_learn_addr(struct management *management,
>                             const struct mroute_addr *addr,
>                             const bool primary);
>  
> +void management_notify_client_cr_response(unsigned mda_key_id,
> +                                          const struct man_def_auth_context *mdac,
> +                                          const struct env_set *es,
> +                                          const char* response);
>  #endif
>  
>  char *management_query_pk_sig(struct management *man, const char *b64_data);
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 4b375ae3..c94076cb 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -210,6 +210,27 @@ server_pushed_info(struct context *c, const struct buffer *buffer,
>      msg(D_PUSH, "Info command was pushed by server ('%s')", m);
>  }
>  
> +void
> +receive_cr_response(struct context *c, const struct buffer *buffer)
> +{
> +    struct buffer buf = *buffer;
> +    const char *m = "";
> +
> +    if (buf_advance(&buf, 11) && buf_read_u8(&buf) == ',' && BLEN(&buf))
> +    {
> +        m = BSTR(&buf);
> +    }

This will accept an empty CR_RESPONSE from the client.  Could that be an
acceptable reply from the client?  My initial thought is: When the server
sends a challenge to the client, it should have a "meaningful" response.  I
struggle to see where an empty response would be meaningful.

And by "meaningful" I mean in the broadest interpretation.  Invalid
authentication response, invalid data (not base64 encoded, etc) is meaningful.

I'm also wondering if it would make sense to validate the base64 response as well.


To summarize all patches:

- They all look reasonable and fine, but there are a few things to improve.

- We should avoid the SSO terminology in the implementation; it can be used
  for a much broader authentication scope than just SSO.  Patch 2/5 also needs
  to be revisited, despite the ACK I've already given.

- Documentation could be a bit better.

- It would be nice to have a really simple test "module" for the server side,
  which would just give challenges like "How much is X + Y?" where X and Y are
  random numbers (1-10) and doesn't really need to account for multiple
  clients at the same time.  But I do realize the management interface can be
  annoying to work with from simple scripting tools.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


