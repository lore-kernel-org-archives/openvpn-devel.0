References: <20210520151148.2565578-1-arne@...1227...>
 <20210520151148.2565578-9-arne@...1227...>
 <d5ffc8f5-7d8a-eb45-b271-9634bb1f19a1@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <92b9316e-df81-06cc-4366-e829e540a97d@...1227...>
Date: Wed, 28 Jul 2021 14:25:54 +0200
MIME-Version: 1.0
In-Reply-To: <d5ffc8f5-7d8a-eb45-b271-9634bb1f19a1@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 9/9] Support NCP in pure P2P VPN
 setups
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


> 
> nice idea! :)

Thanks!

>> +
>> +void
>> +p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
>> +{
>> +    /* Set the common options */
>> +    p2p_ncp_set_options(multi, session);
>> +
>> +    struct gc_arena gc = gc_new();
>> +
>> +    /* Query the common cipher here to log it as part of our message.
>> +     * We postpone switching the cipher to do_up */
>> +    const char* common_cipher = get_p2p_ncp_cipher(session, multi->peer_info, &gc);
> 
> why re-extracting the cipher again instead of reading it (somehow) from
> c->options.ciphername ?
> 
> Maybe reading it from that field is not correct, but isn't there a way
> to avoid doing the string parsing twice? (it was performed in
> do_deferred_p2p_ncp() already)

It will be performed in do_deferred_p2p_ncp as part of do_up much later.
The call here to get_p2p_ncp_cipher is basically "only" for creating the
P2P mode NCP negotiation result message. The problem here is that
setting cipher from the context that p2p_mode_NCP has (multi and
session) not possible, so we would need to move options->cipher into
multi or session struct and that would be quite disruptive. So I opted
here to do get_p2p_ncp_cipher just to be able to print a nice message.



Arne

