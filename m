Message-ID: <b14e6399-1735-041f-4d91-3285fe6ea5c5@...1227...>
Date: Fri, 1 Jul 2022 00:42:55 +0200
MIME-Version: 1.0
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-2-arne@...1227...>
 <e39f7b53-b24d-0ce9-8685-767d2eb71d40@...2080...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <e39f7b53-b24d-0ce9-8685-767d2eb71d40@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/4] Implement exit notification via
 control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net


Am 30.06.2022 um 22:25 schrieb David Sommerseth:
> On 20/05/2022 23:32, Arne Schwabe wrote:
>> Current exit notification relies on data channel messages with specific
>> prefix. Adding these to new data channel modules (DCO) adds unncessary
>> complexity for the data for messages that from their idea belong to the
>> control channel anyway.
>>
>> This patch adds announcing support for control channel and 
>> sending/receving
>> it. We use the simple EXIT message for this.
>>
>> Patch V2: add comment about protocol-flags to be not a user visible 
>> option,
>>            fix various grammar mistakes, remove unused argument to
>>            receive_exit_message
>> ---
>>   doc/man-sections/client-options.rst |  7 ++++++-
>>   src/openvpn/crypto.h                |  5 +++++
>>   src/openvpn/forward.c               |  4 ++++
>>   src/openvpn/multi.c                 |  5 +++++
>>   src/openvpn/options.c               | 20 ++++++++++++++++++++
>>   src/openvpn/push.c                  | 19 +++++++++++++++++++
>>   src/openvpn/push.h                  |  2 ++
>>   src/openvpn/sig.c                   | 27 +++++++++++++++++++++++++--
>>   src/openvpn/ssl.c                   |  3 +++
>>   src/openvpn/ssl.h                   |  3 +++
>>   src/openvpn/ssl_ncp.c               |  5 +++++
>>   11 files changed, 97 insertions(+), 3 deletions(-)
>>
>
> [...snip...]
>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 9ff384d09..427d58392 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -8326,6 +8326,8 @@ add_option(struct options *options,
>>       }
>>       else if (streq(p[0], "key-derivation") && p[1])
>>       {
>> +        /* NCP only option that is pushed by the server to enable EKM,
>> +         * should not be used by normal users in config files*/
>
> This part seems unrelated.


Yes. But basically adding that documentation for the other push only 
protocol felt related and small enough to not warrant an extra patch.

>
>>           VERIFY_PERMISSION(OPT_P_NCP)
>>   #ifdef HAVE_EXPORT_KEYING_MATERIAL
>>           if (streq(p[1], "tls-ekm"))
>> @@ -8338,6 +8340,24 @@ add_option(struct options *options,
>>               msg(msglevel, "Unknown key-derivation method %s", p[1]);
>>           }
>>       }
>> +    else if (streq(p[0], "protocol-flags") && p[1])
>> +    {
>> +        /* NCP only option that is pushed by the server to enable 
>> protocol
>> +         * features that are negotiated, should not be used by 
>> normal users
>> +         * in config files */
>> +        VERIFY_PERMISSION(OPT_P_NCP)
>> +        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL; j++)
>> +        {
>> +            if (streq(p[j], "cc-exit"))
>> +            {
>> +                options->data_channel_crypto_flags |= 
>> CO_USE_CC_EXIT_NOTIFY;
>> +            }
>> +            else
>> +            {
>> +                msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
>> +            }
>> +        }
>> +    }
>
> Isn't it possible to do this by pushing IV_PROTO from the server to 
> the client?  That could be more compact than adding 22 more bytes to 
> the PUSH_REPLY while IV_PROTO takes less "space" on the wire to 
> indicate a feature.  Plus the client already sends the IV_PROTO with 
> the CC_EXIT_NOTIFY feature flag to the server with this patch.

The whole peer info field is empty and happens at a very different time 
before even looking at ccd/connect-script/deferred password aut etc that 
might influence what is pushed to a client. So pushing configuration at 
a completely different time that is extremely early is just adding a lot 
of extra complexity. We do it this way in p2p mode by comparing IV_PROTO 
values from two clients but that p2p mode has nothing after the initial 
handshake and will consider a session established after the initial 
handshake.

Space in push reply is not really a big concern as push replies don't 
have the tight limit that the packet the IV_PROTO contains has. If we 
wanted to have something that is more space efficient, we could change  
protocol-flags cc-exit feat2 feat3 to proto-flgs 82734 like IV_PROTO. 
Basically if I had been a bit more forwarding looking we would now have 
protocol-flags ekm cc-exit instead of key-derivation ekm and 
protocol-flags cc-exit

>
> The rest of the code otherwise looks reasonable with the current 
> "option approach".  The client also sends the IV_PROTO_CC_EXIT_NOTIFY 
> flag to the server, as expected.
>
>

