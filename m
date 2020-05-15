References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6b1140c9-912f-bb98-506d-e0b061f016ba@...2080...>
Date: Fri, 15 May 2020 17:36:30 +0200
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Implement sending SSO challenge
 to clients
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
> This implements sending AUTH_PENDING and INFO_PRE messages to clients
> that indicate that the clients should be continue authentication with
> a second factor. This can currently be out of band (openurl) or a normal
> challenge/response 2FA like TOTP (CR_TEXT).

Can we settle on a single CR_TEXT vs CRTEXT terminology?  The 3/5 patch used
crtext in the documentation but cr_text in the commit message.

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 26 +++++++++++++++++++++++
>  src/openvpn/manage.c     | 46 ++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/manage.h     |  3 +++
>  src/openvpn/multi.c      | 19 +++++++++++++++++
>  src/openvpn/push.c       | 24 +++++++++++++++++++++
>  src/openvpn/push.h       |  2 ++
>  6 files changed, 120 insertions(+)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index e380ca2b..4b405a9b 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -592,6 +592,32 @@ interface to approve client connections.
>  CID,KID -- client ID and Key ID.  See documentation for ">CLIENT:"
>  notification for more info.
>  
> +COMMAND -- client-sso-auth  (OpenVPN 2.5 or higher)
> +----------------------------------------------------
> +
> +Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE signal
> +a single sign on url to the client.
> +
> +    client-sso-auth {CID} {EXTRA}

I think we should use a different naming for this than 'sso'.  This is not
tied to only SSO (Single Sign-On).  What about:

 - client-extended-auth
 - client-external-auth
 - client-ext-auth
 - client-additional-auth
 - client-xauth

As long as the name is quite generic, I'm fine with most alternatives.  But it
should be very generic.  We have so many alternative auth methods these days:
Yubico OTP [1], TOTP/HOTP, FIDO/U2F, SAML, OAuth, Kerberos/GSSAPI, etc ...

[1] <https://developers.yubico.com/OTP/OTPs_Explained.html>

> +The server will send AUTH_PENDING and INFO_PRE,{EXTRA} to the client.
> +The client is expected to inform the user that authentication is pending and
> +display the extra information. For the SSO/SAML EXTRA would be OPEN_URL:url
> +and client should ask to the user to open the URL to continue.
> +
> +For the OpenVPN server this is stateless operation and needs to be
> +followed by a client-deny/client-auth[-nt] command (that is the result of the
> +out of band authentication).
> +
> +Before issuing a client-sso-auth to a client instead of a
> +client-auth/client-deny, the server should check the IV_SSO
> +environment variable if the method is support. The currently
> +defined method are crtext for challenge/response using text
> +(e.g. TOTP) and openurl for opening an URL in the client to
> +continue authentication. A client support both methods would set
> +
> +   setenv IV_SSO openurl,crtext
> +
>  COMMAND -- client-deny  (OpenVPN 2.1 or higher)
>  -----------------------------------------------
>  
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 8dada6f2..c055f2ce 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -105,6 +105,8 @@ man_help(void)
>      msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
>      msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
>      msg(M_CLIENT, "                             text R and optional client reason text CR");
> +    msg(M_CLIENT, "client-sso-auth CID MSG : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg"
> +                  "                          to the client and wait for a final client-auth/client-deny");
>      msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
>      msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
>  #ifdef MANAGEMENT_PF
> @@ -1001,6 +1003,43 @@ parse_kid(const char *str, unsigned int *kid)
>      }
>  }
>  
> +/**
> + * Will send a notification to the client that succesful authentication
> + * will require an additional step (web based SSO/2-factor auth/etc)
> + *
> + * @param man           The management interface struct
> + * @param cid_str       The CID in string form
> + * @param extra         The string to be send to the client containing
> + *                      the information of the additional steps
> + */
> +static void
> +man_client_sso_auth(struct management *man, const char *cid_str, const char *extra)
> +{
> +    unsigned long cid = 0;
> +    if (parse_cid(cid_str, &cid))
> +    {
> +        if (man->persist.callback.client_sso)
> +        {
> +            bool ret = (*man->persist.callback.client_sso)
> +                           (man->persist.callback.arg, cid, extra);
> +
> +            if (ret)
> +            {
> +                msg(M_CLIENT, "SUCCESS: client-sso-auth command succeeded");
> +            }
> +            else
> +            {
> +                msg(M_CLIENT, "SUCCESS: client-sso-auth command failed."
> +                              " Extra paramter might be too long");
> +            }
> +        }
> +        else
> +        {
> +            msg(M_CLIENT, "ERROR: The client-sso-auth command is not supported by the current daemon mode");
> +        }
> +    }
> +}
> +
>  static void
>  man_client_auth(struct management *man, const char *cid_str, const char *kid_str, const bool extra)
>  {
> @@ -1541,6 +1580,13 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
>              man_client_auth(man, p[1], p[2], true);
>          }
>      }
> +    else if (streq(p[0], "client-sso-auth"))
> +    {
> +        if (man_need(man, p, 2, 0))
> +        {
> +            man_client_sso_auth(man, p[1], p[2]);
> +        }
> +    }
>  #ifdef MANAGEMENT_PF
>      else if (streq(p[0], "client-pf"))
>      {
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index 8acc18bf..f570afc6 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -174,6 +174,9 @@ struct management_callback
>                           const char *reason,
>                           const char *client_reason,
>                           struct buffer_list *cc_config); /* ownership transferred */
> +    bool (*client_sso) (void *arg,
> +                        const unsigned long cid,
> +                        const char *url);
>      char *(*get_peer_info) (void *arg, const unsigned long cid);
>  #endif
>  #ifdef MANAGEMENT_PF
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index d594dd25..692fb62a 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -3288,6 +3288,24 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
>      }
>  }
>  
> +static bool
> +management_client_sso(void *arg,> +        const unsigned long cid,
> +        const char *extra)
> +{
> +    struct multi_context *m = (struct multi_context *) arg;
> +    struct multi_instance *mi = lookup_by_cid(m, cid);
> +    if (mi)
> +    {
> +        /* sends INFO_PRE and AUTH_PENDING messages to client */
> +        bool ret = send_sso_messages(&mi->context, extra);
> +        multi_schedule_context_wakeup(m, mi);
> +        return ret;
> +    }
> +    return false;
> +}
> +
> +
>  static bool
>  management_client_auth(void *arg,
>                         const unsigned long cid,
> @@ -3395,6 +3413,7 @@ init_management_callback_multi(struct multi_context *m)
>  #ifdef MANAGEMENT_DEF_AUTH
>          cb.kill_by_cid = management_kill_by_cid;
>          cb.client_auth = management_client_auth;
> +        cb.client_sso = management_client_sso;
>          cb.get_peer_info = management_get_peer_info;
>  #endif
>  #ifdef MANAGEMENT_PF
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index ee1cb980..4b375ae3 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -268,6 +268,30 @@ send_auth_failed(struct context *c, const char *client_reason)
>      gc_free(&gc);
>  }
>  
> +bool
> +send_sso_messages(struct context *c, const char* extra)
> +{
> +    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
> +
> +    static const char info_pre[] = "INFO_PRE,";
> +
> +
> +    size_t len = strlen(extra)+1 + sizeof(info_pre);
> +    if (len > PUSH_BUNDLE_SIZE)
> +    {
> +        return false;
> +    }
> +    struct gc_arena gc = gc_new();
> +
> +    struct buffer buf = alloc_buf_gc(len, &gc);
> +    buf_printf(&buf, info_pre);
> +    buf_printf(&buf, "%s", extra);
> +    send_control_channel_string(c, BSTR(&buf), D_PUSH);
> +
> +    gc_free(&gc);
> +    return true;
> +}
> +
>  /*
>   * Send restart message from server to client.
>   */
> diff --git a/src/openvpn/push.h b/src/openvpn/push.h
> index 9cf8fb34..f814f572 100644
> --- a/src/openvpn/push.h
> +++ b/src/openvpn/push.h
> @@ -70,6 +70,8 @@ void remove_iroutes_from_push_route_list(struct options *o);
>  
>  void send_auth_failed(struct context *c, const char *client_reason);
>  
> +bool send_sso_messages(struct context *c, const char *url);
> +
>  void send_restart(struct context *c, const char *kill_msg);


Several of the function names also uses 'sso', which should be aligned to a
non-sso specific function name.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


