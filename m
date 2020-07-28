References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-9-arne@...1227...>
 <e0b8b673-3ec2-d728-2da0-cc0dfb5b68e1@...1856...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <f727d56b-39ef-d2b7-21fb-2e682f37346a@...277...>
Date: Tue, 28 Jul 2020 14:18:03 +0100
MIME-Version: 1.0
In-Reply-To: <e0b8b673-3ec2-d728-2da0-cc0dfb5b68e1@...1856...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 9/9] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

10x more wee pointers

On 28/07/2020 13:27, Steffan Karger wrote:
> Hi,
> 
> This is awesome in many ways. Better behaviour, better code and a nice
> way forward to really get rid of the BF-CBC default cipher.
> 
> It's also somewhat tricky, so here goes for a review purely based on
> stare-at-code:
> 
> On 17-07-2020 15:47, Arne Schwabe wrote:
>> This reworks the NCP logic to be more strict about what is
>> considered an acceptable result of an NCP negotiation. It also
>> us to finally drop BF-CBC support by default.
>>
>> All new behaviour is currently limited to server/client
>> mode with pull enabled. P2p mode without pull does not change.
>>
>> New Server behaviour:
>> - when a client announces its supported ciphers through either
>>    OCC or IV_CIPHER/IV_NCP we reject the client with a
>>    AUTH_FAILED message if we have no common cipher.
>>
>> - When a client does not announce any cipher in either
>>    OCC or NCP we by reject it unless fallback-cipher is
>>    specified in either ccd or config.
>>
>> New client behaviour:
>> - When no cipher is pushed (or a cipher we refused to support)
>>    and we also cannot support the server's server announced in
>>    OCC we fail the connection and log why
>>
>> - If fallback-cipher is specified we will in the case that
>>    cipher is missing from occ use the fallback cipher instead
>>    of failing the connection
>>
>> Both client and server behaviour:
>> - We only announce --cipher xyz in occ if we are willing
>>    to support that cipher.
>>
>>    It means that we only announce the fallback-cipher if
>>    it is also contained in --data-ciphers
>>
>> Compatiblity behaviour:

Compatiblity -> Compatibility



>>
>> In 2.5 both client and server will automatically set
>> fallback-cipher xyz if --cipher xyz is in the config and
>> also add append the cipher to the end of data-ciphers.
>>
>> We log a warn user about this and point to --data-ciphers and
>> --fallback-cipher. This also happens if the configuration
>> contains an explicit --cipher BF-CBC.
>>
>> If --cipher is not set, we only warn that previous versions
>> allowed BF-CBC and point how to reenable BF-CBC. This might

reenable -> re-enable
(technicality only)


>> break very few config where someone connects a very old
>> client to a 2.5 server but at some point we need to drop
>> the BF-CBC and those affected use will already have a the
>> scary SWEET32 warning in their logs.
>>
>> In short: If --cipher is explicitly set 2.6 will work the same as
>> 2.4 did. When --cipher is not set, BF-CBC support is dropped and
>> we warn about it.
>>
>> Examples how breaking the default BF-CBC will be logged:
>>
>> Client side:
>>   - Client connecting to server that does not push cipher but
>>     has --cipher in OCC
>>
>>      OPTIONS ERROR: failed to negotiate cipher with server.  Add the server's cipher ('BF-CBC') to --data-ciphers (currently 'AES-256-GCM:AES-128-CBC') if you want to connect to this server.
>>
>>   - Client connecting to a server that does not support OCC:
>>
>>     OPTIONS ERROR: failed to negotioate cipher with server. Configure --fallback-cipher if you want connect to this server.

negotioate !!!


>>
>> Server Side:
>>
>> - Server has a client only supporting BF-CBC connecting:> diff --git a/doc/man-sections/protocol-options.rst
> b/doc/man-sections/protocol-options.rst
> 
> [ Used the output of "git diff -w" to review, so pasting that here is
> "original" too. ]
> 
>> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
>> index 051f1d32..ab22b415 100644
>> --- a/doc/man-sections/protocol-options.rst
>> +++ b/doc/man-sections/protocol-options.rst
>> @@ -57,6 +57,9 @@ configured in a compatible way between both the local and remote side.
>>     http://www.cs.ucsd.edu/users/mihir/papers/hmac.html
>>   
>>   --cipher alg
>> +  This option is deprecated for server-client mode and ``--data-ciphers``
>> +  or rarely `--data-ciphers-fallback`` should be used instead.
>> +
>>     Encrypt data channel packets with cipher algorithm ``alg``.
>>   
>>     The default is :code:`BF-CBC`, an abbreviation for Blowfish in Cipher
>> @@ -183,8 +186,9 @@ configured in a compatible way between both the local and remote side.
>>     ``--server`` ), or if ``--pull`` is specified (client-side, implied by
>>     setting --client).
>>   
>> -  If both peers support and do not disable NCP, the negotiated cipher will
>> -  override the cipher specified by ``--cipher``.
>> +  If no common cipher is found is found during cipher negotiation, the
> 
> Duplicate "is found".
> 
>> +  connection is terminated. To support old clients/server that do not
>> +  provide any cipher support see ``data-ciphers-fallback``.
>>   
>>     Additionally, to allow for more smooth transition, if NCP is enabled,
>>     OpenVPN will inherit the cipher of the peer if that cipher is different
>> @@ -201,8 +205,18 @@ configured in a compatible way between both the local and remote side.
>>     This list is restricted to be 127 chars long after conversion to OpenVPN
>>     ciphers.
>>   
>> -  This option was called ``ncp-ciphers`` in OpenVPN 2.4 but has been renamed
>> -  to ``data-ciphers`` in OpenVPN 2.5 to more accurately reflect its meaning.
>> +  This option was called ``--ncp-ciphers`` in OpenVPN 2.4 but has been renamed
>> +  to ``--data-ciphers`` in OpenVPN 2.5 to more accurately reflect its meaning.
>> +
>> +--data-ciphers-fallback alg
>> +
>> +    Configure a cipher that is used to fall back to if the peer does announce
>> +    the cipher in OCC.
> 
> Isn't OCC to much detail here? I'd suggest something like "if we could
> not determine which cipher the peer is willing to use".
> 
>> +    This option should normally not be needed.  It only exists to allow
>> +    connecting to old servers or if supporting old clients as server.
>> +    The are only OpenVPN 2.3 and older version that have configured with
>> +    `--enable-small`.
> 
> I find this somewhat hard to read and understand, probably because it
> /is/ not so easy to understand but... A sugestion (native speakers,
> please help improve!):

sugestion ;-)
(i know, this is not in the code)

> 
> This option should only be needed when connecting to peers which run
> OpenVPN 2.3 or earlier, and are compiled with the --enable-small flag
> (typically used on routers or other embedded devices).

LGTM
(The comma is technically incorrect, commas should not be followed by 
'and' or 'but' but it is not important, if you prefer to use them here).

> 
>>   --ncp-disable
>>     Disable "Negotiable Crypto Parameters". This completely disables cipher
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index e92a0dc1..accab850 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -727,7 +727,8 @@ warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
>>       {
>>           msg(M_WARN, "WARNING: INSECURE cipher (%s) with block size less than 128"
>>               " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
>> -            "using a --cipher with a larger block size (e.g. AES-256-CBC).",
>> +            "using a --cipher with a larger block size (e.g. AES-256-CBC). "
>> +            "Support for these insecure cipher will be removed in OpenVPN 2.6.",
> 
> These insecure cipher*s*.
> 
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -2374,7 +2374,30 @@ do_deferred_options(struct context *c, const unsigned int found)
>>           {
>>               /* If the server did not push a --cipher, we will switch to the
>>                * remote cipher if it is in our ncp-ciphers list */
>> -            tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername);
>> +            bool useremotecipher = tls_poor_mans_ncp(&c->options,
>> +                                                     c->c2.tls_multi->remote_ciphername);
>> +
>> +            if (!useremotecipher && !c->options.enable_ncp_fallback)
>> +            {
>> +                /* Give appropiate error message */
>> +                if (c->c2.tls_multi->remote_ciphername)
>> +                {
>> +                    msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to negotiate "
>> +                        "cipher with server.  Add the server's "
>> +                        "cipher ('%s') to --data-ciphers (currently '%s') if "
>> +                        "you want to connect to this server.",
>> +                        c->c2.tls_multi->remote_ciphername,
>> +                        c->options.ncp_ciphers);
>> +                }
>> +                else
>> +                {
>> +                    msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to negotioate "
> 
> Typo: negotiate.
> 
>> +                        "cipher with server. Configure "
>> +                        "--data-ciphers-fallback if you want connect "
> 
> Typo: if you want *to* connect.
> 
>> +                        "to this server.");
>> +                }
>> +                return false;
>> +            }
> 
> This block seems to use more indentation levels than needed. Consider
> something like:
> 
>    else if (ncp_enabled) {
>      if (!remote_ciphername) {
>        msg("Failed to negotiate, configure --data-ciphers-fallback");
>        return false;
>      }
>      if (!tls_poor_mans_ncp) {
>        msg("Failed to negotiate, add cipher xxx to --data-ciphers");
>        return false;
>      }
>    }
> 
>>           }
>>           struct frame *frame_fragment = NULL;
>>   #ifdef ENABLE_FRAGMENT
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 9bda38b0..a1f65127 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -1777,7 +1777,7 @@ multi_client_connect_setenv(struct multi_context *m,
>>    * - choosen cipher
>>    * - peer id
>>    */
>> -static void
>> +static bool
>>   multi_client_set_protocol_options(struct context *c)
>>   {
>>   
>> @@ -1807,8 +1807,11 @@ multi_client_set_protocol_options(struct context *c)
>>       }
>>   
>>       /* Select cipher if client supports Negotiable Crypto Parameters */
>> -    if (o->ncp_enabled)
>> +    if (!o->ncp_enabled)
>>       {
>> +        return true;
>> +    }
>> +
> 
> Hm, in this case I don't think this improves things. This turns
> 
>    if (foo) {
>      do_foo_stuff;
>    }
>    if (bar) {
>      do_bar_stuff;
>    }
> 
> into
> 
>    if (foo) {
>      do_foo_stuff;
>    }
>    if (!bar) {
>      return;
>    }
>    do_bar_stuff;
> 
> I think the orignal code flow is easier to understand. If there's too
> much indentation for you liking, you can split part of it into a
> separate function.
> 
> (This is just about this first if, I totally agree about the flow change
> below.)
> 
>>       /* if we have already created our key, we cannot *change* our own
>>        * cipher -> so log the fact and push the "what we have now" cipher
>>        * (so the client is always told what we expect it to use)
>> @@ -1820,43 +1823,69 @@ multi_client_set_protocol_options(struct context *c)
>>                "server has already generated data channel keys, "
>>                "re-sending previously negotiated cipher '%s'",
>>                o->ciphername );
>> +        return true;
>>       }
>> -        else
>> -        {
>> +
>>       /*
>>        * Push the first cipher from --data-ciphers to the client that
>>        * the client announces to be supporting.
>>        */
>> -            char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
>> -                                                    peer_info,
>> +    char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, peer_info,
>>                                               tls_multi->remote_ciphername,
>>                                               &o->gc);
>>   
>>       if (push_cipher)
>>       {
>>           o->ciphername = push_cipher;
>> +        return true;
>>       }
>> -            else
>> -            {
>> +
>> +    /* NCP cipher negotiation failed. Try to figure out why exactly it
>> +     * failed and give good error messages and potentially do a fallback
>> +     * for non NCP clients */
>>       struct gc_arena gc = gc_new();
>> +    bool ret = false;
>> +
>>       const char *peer_ciphers = tls_peer_ncp_list(peer_info, &gc);
>> +    /* If we are in a situation where we know the client ciphers, there is no
>> +     * reason to fall back to a cipher that will not be accepted by the other
>> +     * side, in this situation we fail the auth*/
>>       if (strlen(peer_ciphers) > 0)
>>       {
>> -                    msg(M_INFO, "PUSH: No common cipher between server and "
>> -                        "client. Expect this connection not to work. Server "
>> -                        "data-ciphers: '%s', client supported ciphers '%s'",
>> +        msg(M_INFO, "PUSH: No common cipher between server and client. "
>> +            "Server data-ciphers: '%s', client supported ciphers '%s'",
>>               o->ncp_ciphers, peer_ciphers);
>>       }
>> +    else if (tls_multi->remote_ciphername)
>> +    {
>> +        msg(M_INFO, "PUSH: No common cipher between server and client. "
>> +            "Server data-ciphers: '%s', client supports cipher '%s'",
>> +            o->ncp_ciphers, tls_multi->remote_ciphername);
>> +    }
>>       else
>>       {
>> -                    msg(M_INFO, "No NCP data received from peer, falling back "
>> -                        "to --cipher '%s'. Peer reports in OCC --cipher '%s'",
>> -                        o->ciphername, np(tls_multi->remote_ciphername));
>> +        msg(M_INFO, "PUSH: No NCP or OCC cipher data received from peer.");
>> +
>> +        if (o->enable_ncp_fallback && !tls_multi->remote_ciphername)
>> +        {
>> +            msg(M_INFO, "Using data channel cipher '%s' since "
>> +                "--data-ciphers-fallback is set.", o->ciphername);
>> +            ret = true;
>>           }
>> -                gc_free(&gc);
>> +        else
>> +        {
>> +            msg(M_INFO, "Use --data-ciphers-fallback with the cipher the "
>> +                "client is using if you want to allow the client to connect");
>>           }
>>       }
>> +    if (!ret)
>> +    {
>> +        auth_set_client_reason(tls_multi, "Data channel cipher negotiation "
>> +                                          "failed (no shared cipher)");
>>       }
>> +
>> +    gc_free(&gc);
>> +    return ret;
>>   }
>>   
>>   /**
>> @@ -2394,13 +2423,17 @@ multi_client_connect_late_setup(struct multi_context *m,
>>       mi->context.c2.context_auth = CAS_SUCCEEDED;
>>   
>>       /* authentication complete, calculate dynamic client specific options */
>> -    multi_client_set_protocol_options(&mi->context);
>> -
>> -    /* Generate data channel keys */
>> -    if (!multi_client_generate_tls_keys(&mi->context))
>> +    if (!multi_client_set_protocol_options(&mi->context))
>>       {
>>           mi->context.c2.context_auth = CAS_FAILED;
>>       }
>> +    /* Generate data channel keys only if setting protocol options
>> +     * has not failed */
>> +    else if (!multi_client_generate_tls_keys(&mi->context))
>> +    {
>> +
>> +        mi->context.c2.context_auth = CAS_FAILED;
>> +    }
>>   
>>       /* send push reply if ready */
>>       if (mi->context.c2.push_request_received)
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 6d7dbf9f..5beaba0f 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -855,7 +855,6 @@ init_options(struct options *o, const bool init_gc)
>>   #if P2MP
>>       o->scheduled_exit_interval = 5;
>>   #endif
>> -    o->ciphername = "BF-CBC";
>>       o->ncp_enabled = true;
>>       o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
>>       o->authname = "SHA1";
>> @@ -3041,6 +3040,69 @@ options_postprocess_verify(const struct options *o)
>>       }
>>   }
>>   
>> +static void
>> +options_postprocess_cipher(struct options *o)
>> +{
>> +    if (!o->pull && !(o->mode == MODE_SERVER))
>> +    {
>> +        /* we are in the classic P2P mode */
>> +        /* cipher negotiation (NCP) currently assumes --pull or --mode server */
>> +        o->ncp_enabled = false;
>> +        msg( M_WARN, "Dynamic cipher negioation is disabled since neither "
> 
> Typo: negoatiation. Also "dynamic" seems redundant, "negotiation"
> already implies that.
> 
> As a side note: this warning message should be good enough for devs too,
> so we probably don't need the comments above that say the same.
> 
>> +             "P2MP client nor server mode is enabled" );
> 
> Was already in the orignal code, but: no space needed after msg(.
> 
>> +        /* If the cipher is not set default to BF-CBC, we will warn that this
>> +         * is deprecated on cipher initialisation, no need to warn here as
>> +         * well */
> 
> I had to read this twice to understand meaning. Maybe something like "if
> the cipher is not set, we set it to the old default value 'BF-CBC'." or so?
> 
>> +        if (!o->ciphername)
>> +        {
>> +            o->ciphername = "BF-CBC";
>> +        }
>> +        return;
>> +    }
>> +
>> +    /* M2P mode */
> 
> I think this is "P2MP mode"?
> 
>> +    if (!o->ciphername)
>> +    {
>> +        msg(M_WARN, "--cipher is not set. Previous OpenVPN version defaulted to "
>> +            "BF-CBC as fallback when dynamic cipher negotiation failed "

unnecessary use of dynamic again.

>> +            " in this case. If you need this fallback please "
>> +            "add '--data-ciphers-fallback BF-CBC' to your configuration "
>> +            "and/or add BF-CBC to --data-ciphers");
>> +
>> +        /* We still need to set the ciphername to BF-CBC since various other

*cipher name*

>> +         * parts of OpenVPN assert that the ciphername is set */

*cipher name*
(just a suggestion)

>> +        o->ciphername = "BF-CBC";
>> +
>> +        if (!o->ncp_enabled)
>> +        {
>> +            msg(M_USAGE, "--ncp-disable needs an explicit --cipher or "
>> +                "--data-ciphers-fallback config option");
>> +        }
>> +    }
>> +    else if (!o->enable_ncp_fallback
>> +             && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
>> +    {
>> +        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in"
>> +            " --ncp-ciphers (%s). Future OpenVPN version will "
>> +            "ignore --cipher for dynamic cipher negotiations. "

unnecessary use of dynamic again.


>> +            "Add '%s' to --data-ciphers or change --cipher '%s' to "
>> +            "--data-ciphers-fallback '%s' to silence this warning.",
>> +            o->ciphername, o->ncp_ciphers, o->ciphername,
>> +            o->ciphername, o->ciphername);
>> +        o->enable_ncp_fallback = true;
>> +
>> +        /* Append the --cipher to ncp_ciphers to allow it in NCP */
>> +        char *ncp_ciphers = gc_malloc(strlen(o->ncp_ciphers)
>> +                                      +strlen(o->ciphername) + 1, false, &o->gc);
>> +
>> +        strcpy(ncp_ciphers, o->ncp_ciphers);
>> +        strcat(ncp_ciphers, ":");
>> +        strcat(ncp_ciphers, o->ciphername);
> 
> Can we please avoid using strcpy and strcat? Using openvpn_snprintf()
> should result in simpler code, and makes it easier to ensure that we
> won't overflow.
> 
> Actually, looks like this already overflows, since there is no space for
> the null-byte in ncp_ciphers.
> 
>> +        o->ncp_ciphers = ncp_ciphers;
>> +    }
>> +}
>> +
>>   static void
>>   options_postprocess_mutate(struct options *o)
>>   {
>> @@ -3053,6 +3115,7 @@ options_postprocess_mutate(struct options *o)
>>       helper_keepalive(o);
>>       helper_tcp_nodelay(o);
>>   
>> +    options_postprocess_cipher(o);
>>       options_postprocess_mutate_invariant(o);
>>   
>>       if (o->ncp_enabled)
>> @@ -3113,16 +3176,6 @@ options_postprocess_mutate(struct options *o)
>>               "include this in your server configuration");
>>           o->dh_file = NULL;
>>       }
>> -
>> -    /* cipher negotiation (NCP) currently assumes --pull or --mode server */
>> -    if (o->ncp_enabled
>> -        && !(o->pull || o->mode == MODE_SERVER) )
>> -    {
>> -        msg( M_WARN, "disabling NCP mode (--ncp-disable) because not "
>> -             "in P2MP client or server mode" );
>> -        o->ncp_enabled = false;
>> -    }
>> -
>>   #if ENABLE_MANAGEMENT
>>       if (o->http_proxy_override)
>>       {
>> @@ -3658,14 +3711,22 @@ options_string(const struct options *o,
>>        */
>>   
>>       buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
>> -    buf_printf(&out, ",link-mtu %u", (unsigned int) calc_options_string_link_mtu(o, frame));
>> +    if (o->ciphername)
>> +    {
>> +        /* the link-mtu that we send has only a meaning if have a fixed

*only has meaning if we have*

>> +         * cipher (p2p) or have a fallback cipher for older non ncp
>> +         * clients. If we do have a fallback cipher, do not send it */
> 
> This confuses me. The code reads like it's dependent on --cipher, rather
> than --fallbck-cipher. Also shouldn't this be "If we *don't* have a
> fallback cipher"?

I guess a rewrite then ..

> 
>> +        buf_printf(&out, ",link-mtu %u",
>> +                   (unsigned int) calc_options_string_link_mtu(o, frame));
>> +    }
>>       buf_printf(&out, ",tun-mtu %d", PAYLOAD_SIZE(frame));
>>       buf_printf(&out, ",proto %s",  proto_remote(o->ce.proto, remote));
>>   
>> +    bool p2p_nopull = o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o);
>>       /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
>>        * is usually pushed by the server, triggering a non-helpful warning
>>        */
>> -    if (o->ifconfig_ipv6_local && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
>> +    if (o->ifconfig_ipv6_local && p2p_nopull)
>>       {
>>           buf_printf(&out, ",tun-ipv6");
>>       }
>> @@ -3695,7 +3756,7 @@ options_string(const struct options *o,
>>           }
>>       }
>>   
>> -    if (tt && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
>> +    if (tt && p2p_nopull)
>>       {
>>           const char *ios = ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
>>           if (ios && strlen(ios))
>> @@ -3751,8 +3812,15 @@ options_string(const struct options *o,
>>   
>>           init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
>>                         false);
>> -
>> -        buf_printf(&out, ",cipher %s", cipher_kt_name(kt.cipher));
>> +        /* Only announce the cipher to our peer if we are willing to
>> +         * support it */
>> +        const char *ciphername = cipher_kt_name(kt.cipher);
>> +        if (p2p_nopull || !o->ncp_enabled
>> +            || (o->ncp_enabled
>> +                && tls_item_in_cipher_list(ciphername, o->ncp_ciphers)))
> 
> This second check for o->ncp_enabled is not needed. You already ensured
> it's true before. (Saves you a line wrap.)
> 
> I wonder though, isn't it too soon to stop sending cipher? Looks like
> both 2.3 and 2.4 clients will currently print options warnings if cipher
> is missing from OCC. The earlier NCP versions carefully tries to send
> what the peer expected here to prevent bogus warnings.
> 
>> +        {
>> +            buf_printf(&out, ",cipher %s", ciphername);
>> +        }
>>           buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
>>           buf_printf(&out, ",keysize %d", kt.cipher_length * 8);
>>           if (o->shared_secret_file)
>> @@ -3870,7 +3938,8 @@ options_warning_safe_scan2(const int msglevel,
>>           || strprefix(p1, "keydir ")
>>           || strprefix(p1, "proto ")
>>           || strprefix(p1, "tls-auth ")
>> -        || strprefix(p1, "tun-ipv6"))
>> +        || strprefix(p1, "tun-ipv6")
>> +        || strprefix(p1, "cipher "))
>>       {
>>           return;
>>       }
>> @@ -7860,6 +7929,12 @@ add_option(struct options *options,
>>           VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>>           options->ciphername = p[1];
>>       }
>> +    else if (streq(p[0], "data-ciphers-fallback") && p[1] && !p[2])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_INSTANCE);
>> +        options->ciphername = p[1];
>> +        options->enable_ncp_fallback = true;
>> +    }
>>       else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
>>               && p[1] && !p[2])
>>       {
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> index c5df2d18..877e9396 100644
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -503,6 +503,8 @@ struct options
>>       bool shared_secret_file_inline;
>>       int key_direction;
>>       const char *ciphername;
>> +    bool enable_ncp_fallback;      /**< If defined fall back to
>> +                                    * ciphername if NCP fails */
>>       bool ncp_enabled;
>>       const char *ncp_ciphers;
>>       const char *authname;
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 91ab3bf6..06dc9f8f 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -1932,13 +1932,14 @@ tls_session_update_crypto_params(struct tls_session *session,
>>           return true;
>>       }
>>   
>> -    if (!session->opt->server
>> -        && 0 != strcmp(options->ciphername, session->opt->config_ciphername)
>> +    bool cipher_allowed_as_fallback = options->enable_ncp_fallback
>> +                                      && streq(options->ciphername, session->opt->config_ciphername);
>> +
>> +    if (!session->opt->server && !cipher_allowed_as_fallback
>>           && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
>>       {
>> -        msg(D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
>> -            options->ciphername, session->opt->config_ciphername,
>> -            options->ncp_ciphers);
>> +        msg(D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s",
>> +            options->ciphername, options->ncp_ciphers);
>>           /* undo cipher push, abort connection setup */
>>           options->ciphername = session->opt->config_ciphername;
>>           return false;
>> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
>> index 8e432fb7..528b31ea 100644
>> --- a/src/openvpn/ssl_ncp.c
>> +++ b/src/openvpn/ssl_ncp.c
>> @@ -211,9 +211,8 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
>>   }
>>   
>>   char *
>> -ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>> -                    const char *peer_info,  const char *remote_cipher,
>> -                    struct gc_arena *gc)
>> +ncp_get_best_cipher(const char *server_list, const char *peer_info,
>> +                    const char *remote_cipher, struct gc_arena *gc)
>>   {
>>       /*
>>        * The gc of the parameter is tied to the VPN session, create a
>> @@ -242,15 +241,6 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>>               break;
>>           }
>>       }
>> -    /* We have not found a common cipher, as a last resort check if the
>> -     * server cipher can be used
>> -     */
>> -    if (token == NULL
>> -        && (tls_item_in_cipher_list(server_cipher, peer_ncp_list)
>> -            || streq(server_cipher, remote_cipher)))
>> -    {
>> -        token = server_cipher;
>> -    }
>>   
>>       char *ret = NULL;
>>       if (token != NULL)
>> @@ -262,16 +252,18 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>>       return ret;
>>   }
>>   
>> -void
>> +bool
>>   tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
>>   {
>> -    if (o->ncp_enabled && remote_ciphername
>> +    if (remote_ciphername
>>           && 0 != strcmp(o->ciphername, remote_ciphername))
>>       {
>>           if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
>>           {
>>               o->ciphername = string_alloc(remote_ciphername, &o->gc);
>>               msg(D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
>> +            return true;
>>           }
>>       }
>> +    return false;
>>   }
>> diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
>> index d00c222d..98f80286 100644
>> --- a/src/openvpn/ssl_ncp.h
>> +++ b/src/openvpn/ssl_ncp.h
>> @@ -44,10 +44,13 @@ tls_peer_supports_ncp(const char *peer_info);
>>    * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
>>    * Allows non-NCP peers to upgrade their cipher individually.
>>    *
>> + * Returns true if we switched to the peer's cipher
>> + *
>>    * Make sure to call tls_session_update_crypto_params() after calling this
>>    * function.
>>    */
>> -void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
>> +bool
>> +tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
> 
> I think we almost always put the return type on the same line in header
> files. (Don't know why, but it seems quite consistent.)
> -Steffan
> 
> 


HTH
Richard

