References: <20200729113835.2415-1-arne@...1227...>
 <25639937-df97-2535-bbda-2dea00751fa7@...1856...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <af38fa8a-311d-71fe-0931-f4fc3a623aee@...277...>
Date: Wed, 5 Aug 2020 21:59:20 +0100
MIME-Version: 1.0
In-Reply-To: <25639937-df97-2535-bbda-2dea00751fa7@...1856...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
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



On 05/08/2020 21:25, Steffan Karger wrote:
> Hi,
> 
> No full review yet, but this version does seem to address my previous
> comments. Some minor nits I noticed on my first run through v2:
> 
> On 29-07-2020 13:38, Arne Schwabe wrote:
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

negotioate -> *-)



>>
>> Server Side:
>>
>> - Server has a client only supporting BF-CBC connecting:
>>
>>    styx/IP PUSH: No common cipher between server and client. Server data-ciphers: 'CHACHA20-POLY1305:AES-128-GCM:AES-256-GCM:AES-256-CBC:AES-128-CBC', client supports cipher 'BF-CBC'.
>>
>>   - Client without OCC:
>>
>>     styx/IP PUSH:No NCP or OCC cipher data received from peer.
>>     styx/IP Use --fallback-cipher with the cipher the client is using if you want to allow the client to connect
>>
>> In all reject cases on the client:
>>
>>     AUTH: Received control message: AUTH_FAILED,Data channel cipher negotiation failed (no shared cipher)
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>
>> Patch V2: rename fallback-cipher to data-ciphers-fallback
>>            add all corrections from Steffan
>>            Ignore occ cipher for clients sending IV_CIPHERS
>>            move client side ncp in its own function
>>            do not print INSECURE cipher warning if BF-CBC is not allowed
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   doc/man-sections/protocol-options.rst |  22 ++++-
>>   src/openvpn/crypto.c                  |   4 +-
>>   src/openvpn/init.c                    |  18 ++--
>>   src/openvpn/multi.c                   | 135 ++++++++++++++++----------
>>   src/openvpn/options.c                 | 117 +++++++++++++++++-----
>>   src/openvpn/options.h                 |   2 +
>>   src/openvpn/ssl.c                     |  17 ++--
>>   src/openvpn/ssl_ncp.c                 |  82 +++++++++++++---
>>   src/openvpn/ssl_ncp.h                 |  18 ++--
>>   tests/unit_tests/openvpn/test_ncp.c   |  26 +++--
>>   10 files changed, 311 insertions(+), 130 deletions(-)


No other spelling or grammar to worry about.













>>
>> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
>> index 051f1d32..69d3bc67 100644
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
>> +  If no common cipher is found during cipher negotiation, the  connection
>> +  is terminated. To support old clients/server that do not provide any cipher
>> +  negotiation support see ``data-ciphers-fallback``.
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
>> +    Configure a cipher that is used to fall back to if we could not determine
>> +    which cipher the peer is willing to use.
>> +
>> +    This option should only be needed to
>> +    connect to peers that are running OpenVPN 2.3 and older version, and
>> +    have been configured with `--enable-small`
>> +    (typically used on routers or other embedded devices).
>>   
>>   --ncp-disable
>>     Disable "Negotiable Crypto Parameters". This completely disables cipher
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index e92a0dc1..3a0bfbec 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -727,7 +727,9 @@ warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
>>       {
>>           msg(M_WARN, "WARNING: INSECURE cipher (%s) with block size less than 128"
>>               " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
>> -            "using a --cipher with a larger block size (e.g. AES-256-CBC).",
>> +            "using a --cipher with a larger block size (e.g. AES-256-CBC). "
>> +            "Support for these insecure ciphers will be removed in "
>> +            "OpenVPN 2.6.",
>>               ciphername, cipher_kt_block_size(cipher)*8);
>>       }
>>   }
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 1ea4735d..402d2652 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -2365,16 +2365,9 @@ do_deferred_options(struct context *c, const unsigned int found)
>>       /* process (potentially pushed) crypto options */
>>       if (c->options.pull)
>>       {
>> -        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
>> -        if (found & OPT_P_NCP)
>> -        {
>> -            msg(D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
>> -        }
>> -        else if (c->options.ncp_enabled)
>> +        if (!check_pull_client_ncp(c, found))
>>           {
>> -            /* If the server did not push a --cipher, we will switch to the
>> -             * remote cipher if it is in our ncp-ciphers list */
>> -            tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername);
>> +            return false;
>>           }
>>           struct frame *frame_fragment = NULL;
>>   #ifdef ENABLE_FRAGMENT
>> @@ -2384,6 +2377,7 @@ do_deferred_options(struct context *c, const unsigned int found)
>>           }
>>   #endif
>>   
>> +        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
>>           if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
>>                                                 frame_fragment))
>>           {
>> @@ -2757,9 +2751,13 @@ do_init_crypto_tls_c1(struct context *c)
>>   #endif /* if P2MP */
>>           }
>>   
>> +        /* Do not warn if only have BF-CBC in options->ciphername
>> +         * because it is still the default cipher */
>> +        bool warn = !streq(options->ciphername, "BF-CBC")
>> +             || options->enable_ncp_fallback;
>>           /* Get cipher & hash algorithms */
>>           init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
>> -                      options->keysize, true, true);
>> +                      options->keysize, true, warn);
>>   
>>           /* Initialize PRNG with config-specified digest */
>>           prng_init(options->prng_hash, options->prng_nonce_secret_len);
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 0f9c586b..79b5c0c3 100644
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
>> @@ -1807,56 +1807,85 @@ multi_client_set_protocol_options(struct context *c)
>>       }
>>   
>>       /* Select cipher if client supports Negotiable Crypto Parameters */
>> -    if (o->ncp_enabled)
>> +    if (!o->ncp_enabled)
>>       {
>> -        /* if we have already created our key, we cannot *change* our own
>> -         * cipher -> so log the fact and push the "what we have now" cipher
>> -         * (so the client is always told what we expect it to use)
>> -         */
>> -        const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
>> -        if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
>> +        return true;
>> +    }
>> +
>> +    /* if we have already created our key, we cannot *change* our own
>> +     * cipher -> so log the fact and push the "what we have now" cipher
>> +     * (so the client is always told what we expect it to use)
>> +     */
>> +    const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
>> +    if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
>> +    {
>> +        msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
> 
> No space after ( .
> 
>> +             "server has already generated data channel keys, "
>> +             "re-sending previously negotiated cipher '%s'",
>> +             o->ciphername );
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * Push the first cipher from --data-ciphers to the client that
>> +     * the client announces to be supporting.
>> +     */
>> +    char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, peer_info,
>> +                                            tls_multi->remote_ciphername,
>> +                                            &o->gc);
>> +
>> +    if (push_cipher)
>> +    {
>> +        o->ciphername = push_cipher;
>> +        return true;
>> +    }
>> +
>> +    /* NCP cipher negotiation failed. Try to figure out why exactly it
>> +     * failed and give good error messages and potentially do a fallback
>> +     * for non NCP clients */
>> +    struct gc_arena gc = gc_new();
>> +    bool ret = false;
>> +
>> +    const char *peer_ciphers = tls_peer_ncp_list(peer_info, &gc);
>> +    /* If we are in a situation where we know the client ciphers, there is no
>> +     * reason to fall back to a cipher that will not be accepted by the other
>> +     * side, in this situation we fail the auth*/
>> +    if (strlen(peer_ciphers) > 0)
>> +    {
>> +        msg(M_INFO, "PUSH: No common cipher between server and client. "
>> +            "Server data-ciphers: '%s', client supported ciphers '%s'",
>> +            o->ncp_ciphers, peer_ciphers);
>> +    }
>> +    else if (tls_multi->remote_ciphername)
>> +    {
>> +        msg(M_INFO, "PUSH: No common cipher between server and client. "
>> +            "Server data-ciphers: '%s', client supports cipher '%s'",
>> +            o->ncp_ciphers, tls_multi->remote_ciphername);
>> +    }
>> +    else
>> +    {
>> +        msg(M_INFO, "PUSH: No NCP or OCC cipher data received from peer.");
>> +
>> +        if (o->enable_ncp_fallback && !tls_multi->remote_ciphername)
>>           {
>> -            msg( M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
>> -                 "server has already generated data channel keys, "
>> -                 "re-sending previously negotiated cipher '%s'",
>> -                 o->ciphername );
>> +            msg(M_INFO, "Using data channel cipher '%s' since "
>> +                "--data-ciphers-fallback is set.", o->ciphername);
>> +            ret = true;
>>           }
>>           else
>>           {
>> -            /*
>> -             * Push the first cipher from --data-ciphers to the client that
>> -             * the client announces to be supporting.
>> -             */
>> -            char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
>> -                                                    peer_info,
>> -                                                    tls_multi->remote_ciphername,
>> -                                                    &o->gc);
>> -
>> -            if (push_cipher)
>> -            {
>> -                o->ciphername = push_cipher;
>> -            }
>> -            else
>> -            {
>> -                struct gc_arena gc = gc_new();
>> -                const char *peer_ciphers = tls_peer_ncp_list(peer_info, &gc);
>> -                if (strlen(peer_ciphers) > 0)
>> -                {
>> -                    msg(M_INFO, "PUSH: No common cipher between server and "
>> -                        "client. Expect this connection not to work. Server "
>> -                        "data-ciphers: '%s', client supported ciphers '%s'",
>> -                        o->ncp_ciphers, peer_ciphers);
>> -                }
>> -                else
>> -                {
>> -                    msg(M_INFO, "No NCP data received from peer, falling back "
>> -                        "to --cipher '%s'. Peer reports in OCC --cipher '%s'",
>> -                        o->ciphername, np(tls_multi->remote_ciphername));
>> -                }
>> -                gc_free(&gc);
>> -            }
>> +            msg(M_INFO, "Use --data-ciphers-fallback with the cipher the "
>> +                "client is using if you want to allow the client to connect");
>>           }
>>       }
>> +    if (!ret)
>> +    {
>> +        auth_set_client_reason(tls_multi, "Data channel cipher negotiation "
>> +                                          "failed (no shared cipher)");
>> +    }
>> +
>> +    gc_free(&gc);
>> +    return ret;
>>   }
>>   
>>   /**
>> @@ -2322,7 +2351,7 @@ multi_client_connect_late_setup(struct multi_context *m,
>>       if (!mi->context.c2.push_ifconfig_defined)
>>       {
>>           msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote"
>> -            "--ifconfig address is available for %s",
>> +                            "--ifconfig address is available for %s",
>>               multi_instance_string(mi, false, &gc));
>>       }
>>   
>> @@ -2338,7 +2367,7 @@ multi_client_connect_late_setup(struct multi_context *m,
>>   
>>           /* JYFIXME -- this should cause the connection to fail */
>>           msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s)"
>> -            "violates tunnel network/netmask constraint (%s/%s)",
>> +                            "violates tunnel network/netmask constraint (%s/%s)",
>>               multi_instance_string(mi, false, &gc),
>>               print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
>>               ifconfig_constraint_network, ifconfig_constraint_netmask);
>> @@ -2387,7 +2416,7 @@ multi_client_connect_late_setup(struct multi_context *m,
>>       else if (mi->context.options.iroutes)
>>       {
>>           msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute"
>> -            "only works with tun-style tunnels",
>> +                            "only works with tun-style tunnels",
>>               multi_instance_string(mi, false, &gc));
>>       }
>>   
>> @@ -2399,11 +2428,15 @@ multi_client_connect_late_setup(struct multi_context *m,
>>       mi->context.c2.context_auth = CAS_SUCCEEDED;
>>   
>>       /* authentication complete, calculate dynamic client specific options */
>> -    multi_client_set_protocol_options(&mi->context);
>> -
>> -    /* Generate data channel keys */
>> -    if (!multi_client_generate_tls_keys(&mi->context))
>> +    if (!multi_client_set_protocol_options(&mi->context))
>> +    {
>> +        mi->context.c2.context_auth = CAS_FAILED;
>> +    }
>> +    /* Generate data channel keys only if setting protocol options
>> +     * has not failed */
>> +    else if (!multi_client_generate_tls_keys(&mi->context))
>>       {
>> +
>>           mi->context.c2.context_auth = CAS_FAILED;
>>       }
>>   
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index bc256b18..c53ef7f9 100644
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
>> @@ -2053,7 +2052,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>>       if (options->inetd)
>>       {
>>           msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
>> -                    "and will be removed in OpenVPN 2.6");
>> +            "and will be removed in OpenVPN 2.6");
>>       }
>>   
>>       if (options->lladdr && dev != DEV_TYPE_TAP)
>> @@ -3046,6 +3045,67 @@ options_postprocess_verify(const struct options *o)
>>       }
>>   }
>>   
>> +static void
>> +options_postprocess_cipher(struct options *o)
>> +{
>> +    if (!o->pull && !(o->mode == MODE_SERVER))
>> +    {
>> +        /* we are in the classic P2P mode */
>> +        o->ncp_enabled = false;
>> +        msg( M_WARN, "Cipher negotiation is disabled since neither "
>> +             "P2MP client nor server mode is enabled");
>> +
>> +        /* If the cipher is not set, use the old default ofo BF-CBC. We will
>> +         * warn that this is deprecated on cipher initialisation, no need
>> +         * to warn here as well */
>> +        if (!o->ciphername)
>> +        {
>> +            o->ciphername = "BF-CBC";
>> +        }
>> +        return;
>> +    }
>> +
>> +    /* pull or P2MP mode */
>> +    if (!o->ciphername)
>> +    {
>> +        if (!o->ncp_enabled)
>> +        {
>> +            msg(M_USAGE, "--ncp-disable needs an explicit --cipher or "
>> +                         "--data-ciphers-fallback config option");
>> +        }
>> +
>> +        msg(M_WARN, "--cipher is not set. Previous OpenVPN version defaulted to "
>> +            "BF-CBC as fallback when cipher negotiation failed in this case. "
>> +            "If you need this fallback please add '--data-ciphers-fallback "
>> +            "BF-CBC' to your configuration and/or add BF-CBC to "
>> +            "--data-ciphers.");
>> +
>> +        /* We still need to set the ciphername to BF-CBC since various other
>> +         * parts of OpenVPN assert that the ciphername is set */
>> +        o->ciphername = "BF-CBC";
>> +    }
>> +    else if (!o->enable_ncp_fallback
>> +             && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
>> +    {
>> +        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in"
>> +            " --data-ciphers (%s). Future OpenVPN version will "
>> +            "ignore --cipher for cipher negotiations. "
>> +            "Add '%s' to --data-ciphers or change --cipher '%s' to "
>> +            "--data-ciphers-fallback '%s' to silence this warning.",
>> +            o->ciphername, o->ncp_ciphers, o->ciphername,
>> +            o->ciphername, o->ciphername);
>> +        o->enable_ncp_fallback = true;
>> +
>> +        /* Append the --cipher to ncp_ciphers to allow it in NCP */
>> +        size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(o->ciphername) +1;
> 
> Missing space after the last + .
> 
>> +        char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
>> +
>> +        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
>> +                                o->ciphername));
>> +        o->ncp_ciphers = ncp_ciphers;
>> +    }
>> +}
>> +
>>   static void
>>   options_postprocess_mutate(struct options *o)
>>   {
>> @@ -3058,6 +3118,7 @@ options_postprocess_mutate(struct options *o)
>>       helper_keepalive(o);
>>       helper_tcp_nodelay(o);
>>   
>> +    options_postprocess_cipher(o);
>>       options_postprocess_mutate_invariant(o);
>>   
>>       if (o->ncp_enabled)
>> @@ -3118,16 +3179,6 @@ options_postprocess_mutate(struct options *o)
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
>> @@ -3663,14 +3714,21 @@ options_string(const struct options *o,
>>        */
>>   
>>       buf_printf(&out, ",dev-type %s", dev_type_string(o->dev, o->dev_type));
>> -    buf_printf(&out, ",link-mtu %u", (unsigned int) calc_options_string_link_mtu(o, frame));
>> +    /* the link-mtu that we send has only a meaning if have a fixed
>> +     * cipher (p2p) or have a fallback cipher configured for older non
>> +     * ncp clients. But not sending it, will make even 2.4 complain
>> +     * about it missing. So still send it. */
>> +    buf_printf(&out, ",link-mtu %u",
>> +               (unsigned int) calc_options_string_link_mtu(o, frame));
>> +
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
>> @@ -3700,7 +3758,7 @@ options_string(const struct options *o,
>>           }
>>       }
>>   
>> -    if (tt && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
>> +    if (tt && p2p_nopull)
>>       {
>>           const char *ios = ifconfig_options_string(tt, remote, o->ifconfig_nowarn, gc);
>>           if (ios && strlen(ios))
>> @@ -3756,8 +3814,14 @@ options_string(const struct options *o,
>>   
>>           init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
>>                         false);
>> -
>> -        buf_printf(&out, ",cipher %s", cipher_kt_name(kt.cipher));
>> +        /* Only announce the cipher to our peer if we are willing to
>> +         * support it */
>> +        const char *ciphername = cipher_kt_name(kt.cipher);
>> +        if (p2p_nopull || !o->ncp_enabled
>> +            || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
>> +        {
>> +            buf_printf(&out, ",cipher %s", ciphername);
>> +        }
>>           buf_printf(&out, ",auth %s", md_kt_name(kt.digest));
>>           buf_printf(&out, ",keysize %d", kt.cipher_length * 8);
>>           if (o->shared_secret_file)
>> @@ -3875,7 +3939,8 @@ options_warning_safe_scan2(const int msglevel,
>>           || strprefix(p1, "keydir ")
>>           || strprefix(p1, "proto ")
>>           || strprefix(p1, "tls-auth ")
>> -        || strprefix(p1, "tun-ipv6"))
>> +        || strprefix(p1, "tun-ipv6")
>> +        || strprefix(p1, "cipher "))
>>       {
>>           return;
>>       }
>> @@ -7863,14 +7928,20 @@ add_option(struct options *options,
>>           VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>>           options->ciphername = p[1];
>>       }
>> +    else if (streq(p[0], "data-ciphers-fallback") && p[1] && !p[2])
>> +    {
>> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>> +        options->ciphername = p[1];
>> +        options->enable_ncp_fallback = true;
>> +    }
>>       else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
>> -            && p[1] && !p[2])
>> +             && p[1] && !p[2])
>>       {
>>           VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>>           if (streq(p[0], "ncp-ciphers"))
>>           {
>>               msg(M_INFO, "Note: Treating option '--ncp-ciphers' as "
>> -                        " '--data-ciphers' (renamed in OpenVPN 2.5).");
>> +                " '--data-ciphers' (renamed in OpenVPN 2.5).");
>>           }
>>           options->ncp_ciphers = p[1];
>>       }
>> @@ -7878,9 +7949,9 @@ add_option(struct options *options,
>>       {
>>           VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
>>           options->ncp_enabled = false;
>> -        msg(M_WARN, "DEPRECATED OPTION: ncp-disable. Disabling dynamic "
>> -                    "cipher negotiation is a deprecated debug feature that "
>> -                    "will be removed in OpenVPN 2.6");
>> +        msg(M_WARN, "DEPRECATED OPTION: ncp-disable. Disabling "
>> +            "cipher negotiation is a deprecated debug feature that "
>> +            "will be removed in OpenVPN 2.6");
>>       }
>>       else if (streq(p[0], "prng") && p[1] && !p[3])
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
>> @@ -1956,9 +1957,9 @@ tls_session_update_crypto_params(struct tls_session *session,
>>       }
>>       else
>>       {
>> -      /* Very hacky workaround and quick fix for frame calculation
>> -       * different when adjusting frame size when the original and new cipher
>> -       * are identical to avoid a regression with client without NCP */
>> +        /* Very hacky workaround and quick fix for frame calculation
>> +         * different when adjusting frame size when the original and new cipher
>> +         * are identical to avoid a regression with client without NCP */
>>           return tls_session_generate_data_channel_keys(session);
>>       }
>>   
>> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
>> index 8e432fb7..2d3983c2 100644
>> --- a/src/openvpn/ssl_ncp.c
>> +++ b/src/openvpn/ssl_ncp.c
>> @@ -48,6 +48,7 @@
>>   #include "common.h"
>>   
>>   #include "ssl_ncp.h"
>> +#include "openvpn.h"
>>   
>>   /**
>>    * Return the Negotiable Crypto Parameters version advertised in the peer info
>> @@ -211,9 +212,8 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
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
>> @@ -226,7 +226,9 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>>       const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
>>   
>>       /* non-NCP client without OCC?  "assume nothing" */
>> -    if (remote_cipher == NULL)
>> +    /* For client doing the newer version of NCP (that send IV_CIPHER)
>> +     * we cannot assume that they will accept remote_cipher */
>> +    if (remote_cipher == NULL || strstr(peer_info, "IV_CIPHERS="))
> 
> Just noting the missing NULL check that Gert found with testing. Can you
> add a regression test while at it?
> 
>>       {
>>           remote_cipher = "";
>>       }
>> @@ -242,15 +244,6 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
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
>> @@ -262,16 +255,75 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>>       return ret;
>>   }
>>   
>> -void
>> +/**
>> + * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
>> + * Allows non-NCP peers to upgrade their cipher individually.
>> + *
>> + * Returns true if we switched to the peer's cipher
>> + *
>> + * Make sure to call tls_session_update_crypto_params() after calling this
>> + * function.
>> + */
>> +static bool
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
>> +
>> +bool
>> +check_pull_client_ncp(struct context *c, const int found)
>> +{
>> +    if (found & OPT_P_NCP)
>> +    {
>> +        msg(D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
>> +        return true;
>> +    }
>> +
>> +    if (!c->options.ncp_enabled)
>> +    {
>> +        return true;
>> +    }
>> +    /* If the server did not push a --cipher, we will switch to the
>> +     * remote cipher if it is in our ncp-ciphers list */
>> +    bool useremotecipher = tls_poor_mans_ncp(&c->options,
>> +                                             c->c2.tls_multi->remote_ciphername);
>> +
>> +
>> +    /* We could not figure out the peer's cipher but we have fallback
>> +     * enable */
> 
> enableD.
> 
>> +    if (!useremotecipher && c->options.enable_ncp_fallback)
>> +    {
>> +        return true;
>> +    }
>> +
>> +    /* We failed negotiation, give appropiate error message */
>> +    if (c->c2.tls_multi->remote_ciphername)
>> +    {
>> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to negotiate "
>> +            "cipher with server.  Add the server's "
>> +            "cipher ('%s') to --data-ciphers (currently '%s') if "
>> +            "you want to connect to this server.",
>> +            c->c2.tls_multi->remote_ciphername,
>> +            c->options.ncp_ciphers);
>> +        return false;
>> +
>> +    }
>> +    else
>> +    {
>> +        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to negotiate "
>> +            "cipher with server. Configure "
>> +            "--data-ciphers-fallback if you want to connect "
>> +            "to this server.");
>> +        return false;
>> +    }
>> +}
>> \ No newline at end of file
>> diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
>> index d00c222d..39158a56 100644
>> --- a/src/openvpn/ssl_ncp.h
>> +++ b/src/openvpn/ssl_ncp.h
>> @@ -40,14 +40,17 @@
>>   bool
>>   tls_peer_supports_ncp(const char *peer_info);
>>   
>> +/* forward declaration to break include dependency loop */
>> +struct context;
>> +
>>   /**
>> - * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
>> - * Allows non-NCP peers to upgrade their cipher individually.
>> + * Checks whether the cipher negotiation is in an acceptable state
>> + * and we continue to connect or should abort.
>>    *
>> - * Make sure to call tls_session_update_crypto_params() after calling this
>> - * function.
>> + * @return  Wether the client NCP process suceeded or failed
>>    */
>> -void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
>> +bool
>> +check_pull_client_ncp(struct context *c, int found);
>>   
>>   /**
>>    * Iterates through the ciphers in server_list and return the first
>> @@ -67,9 +70,8 @@ void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
>>    * cipher
>>    */
>>   char *
>> -ncp_get_best_cipher(const char *server_list, const char *server_cipher,
>> -                    const char *peer_info, const char *remote_cipher,
>> -                    struct gc_arena *gc);
>> +ncp_get_best_cipher(const char *server_list, const char *peer_info,
>> +                    const char *remote_cipher, struct gc_arena *gc);
>>   
>>   
>>   /**
>> diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
>> index 19432410..ea950030 100644
>> --- a/tests/unit_tests/openvpn/test_ncp.c
>> +++ b/tests/unit_tests/openvpn/test_ncp.c
>> @@ -139,21 +139,29 @@ test_poor_man(void **state)
>>       char *best_cipher;
>>   
>>       const char *serverlist = "CHACHA20_POLY1305:AES-128-GCM";
>> +    const char *serverlistbfcbc = "CHACHA20_POLY1305:AES-128-GCM:BF-CBC";
>>   
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> +    best_cipher = ncp_get_best_cipher(serverlist,
>> +                                      "IV_YOLO=NO\nIV_BAR=7",
>> +                                      "BF-CBC", &gc);
>> +
>> +    assert_ptr_equal(best_cipher, NULL);
>> +
>> +
>> +    best_cipher = ncp_get_best_cipher(serverlistbfcbc,
>>                                         "IV_YOLO=NO\nIV_BAR=7",
>>                                         "BF-CBC", &gc);
>>   
>>       assert_string_equal(best_cipher, "BF-CBC");
>>   
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> +
>> +    best_cipher = ncp_get_best_cipher(serverlist,
>>                                         "IV_NCP=1\nIV_BAR=7",
>>                                         "AES-128-GCM", &gc);
>>   
>>       assert_string_equal(best_cipher, "AES-128-GCM");
>>   
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> -                                      NULL,
>> +    best_cipher = ncp_get_best_cipher(serverlist, NULL,
>>                                         "AES-128-GCM", &gc);
>>   
>>       assert_string_equal(best_cipher, "AES-128-GCM");
>> @@ -170,29 +178,27 @@ test_ncp_best(void **state)
>>   
>>       const char *serverlist = "CHACHA20_POLY1305:AES-128-GCM:AES-256-GCM";
>>   
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> +    best_cipher = ncp_get_best_cipher(serverlist,
>>                                         "IV_YOLO=NO\nIV_NCP=2\nIV_BAR=7",
>>                                         "BF-CBC", &gc);
>>   
>>       assert_string_equal(best_cipher, "AES-128-GCM");
>>   
>>       /* Best cipher is in --cipher of client */
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> -                                      "IV_NCP=2\nIV_BAR=7",
>> +    best_cipher = ncp_get_best_cipher(serverlist, "IV_NCP=2\nIV_BAR=7",
>>                                         "CHACHA20_POLY1305", &gc);
>>   
>>       assert_string_equal(best_cipher, "CHACHA20_POLY1305");
>>   
>>       /* Best cipher is in --cipher of client */
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> -                                      "IV_CIPHERS=AES-128-GCM",
>> +    best_cipher = ncp_get_best_cipher(serverlist, "IV_CIPHERS=AES-128-GCM",
>>                                         "AES-256-CBC", &gc);
>>   
>>   
>>       assert_string_equal(best_cipher, "AES-128-GCM");
>>   
>>       /* IV_NCP=2 should be ignored if IV_CIPHERS is sent */
>> -    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
>> +    best_cipher = ncp_get_best_cipher(serverlist,
>>                                         "IV_FOO=7\nIV_CIPHERS=AES-256-GCM\nIV_NCP=2",
>>                                         "AES-256-CBC", &gc);
>>   
>>
> 
> I still try to find time to do more review and testing, but don't wait
> for me if someone else has taken a good look and/or given this patch a
> good beating.
> 
> -Steffan
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

