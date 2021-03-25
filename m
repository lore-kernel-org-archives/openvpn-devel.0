References: <20181206171033.61310-1-gert@...1296...>
 <06dfe01b-95dd-ae08-4b30-96f85ac2bd9d@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <80e6882a-dd00-eeff-151b-1b67d6e61103@...2181...>
Date: Fri, 26 Mar 2021 00:30:18 +0100
MIME-Version: 1.0
In-Reply-To: <06dfe01b-95dd-ae08-4b30-96f85ac2bd9d@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Rate-limit incoming
 P_CONTROL_HARD_RESET_* packets.
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

Hi,

On 14/07/2019 11:45, Steffan Karger wrote:
> Hi,
> 
> On 06-12-18 18:10, Gert Doering wrote:
>> Creation of new instances (= new incoming reset packets with different
>> source IP addresses / source ports) can be rate-limited in the current
>> code by use of the "--connect-freq" option.
>>
>> For packets sent with the same source port, OpenVPN would dilligently

Did you mean "source IP"? or you really meant same port?
Same IP/port should allow the server to match the request to an existing
session, so I presume the packet would be ignored?

(Maybe I am wrong)

>> reply to every single packet, causing route reflection issues (plus
>> using somewhat more server cycles).  This patch introduces a timestamp
>> in the tls_multi context which records when the last "reset" packet
>> was seen, and ignores all further "reset" packets coming in in the
>> next 10 second interval.
> 

Is this patch something you are considering on top of "Stop
state-exhaustion attacks from a single source address." ?


Regards,


> This makes sense, but why 10s? Our default connect-retry value is 5
> seconds. Wouldn't 5 (or 4?) be a better value in that regard?
> 
>> Signed-off-by: Gert Doering <gert@...1296...>
>> ---
>>  src/openvpn/ssl.c        | 14 ++++++++++++++
>>  src/openvpn/ssl_common.h |  1 +
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 74b88ce6..3078d76c 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -3468,6 +3468,20 @@ tls_pre_decrypt(struct tls_multi *multi,
>>                          print_link_socket_actual(from, &gc));
>>                      goto error;
>>                  }
>> +
>> +                /* only permit one is_hard_reset() packet per 10 seconds,
>> +                 * ignore more frequent packets
>> +                 */
>> +                time_t now = time(NULL);
>> +                if ( now - multi->last_hard_reset_seen < 10 )
> 
> I think we use the "if (now - multi->last_hard_reset_seen < 10)" style
> in the vast majority of the code base.
> 
>> +                {
>> +                    msg(D_MULTI_ERRORS, "TLS: tls_pre_decrypt: ignore incoming"
>> +                                        " '%s' (only %ds since last RESET)",
>> +                        packet_opcode_name(op),
>> +                        (int)(now - multi->last_hard_reset_seen) );
> 
> Here too, no space before ).
> 
>> +                    goto error;
>> +                }
>> +                multi->last_hard_reset_seen = now;
>>              }
>>  
>>              /*
>> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
>> index 7bf82b3a..e71696b5 100644
>> --- a/src/openvpn/ssl_common.h
>> +++ b/src/openvpn/ssl_common.h
>> @@ -515,6 +515,7 @@ struct tls_multi
>>       */
>>      int n_hard_errors; /* errors due to TLS negotiation failure */
>>      int n_soft_errors; /* errors due to unrecognized or failed-to-authenticate incoming packets */
>> +    time_t last_hard_reset_seen;	/* rate-limit incoming hard reset */
>>  
>>      /*
>>       * Our locked common name, username, and cert hashes (cannot change during the life of this tls_multi object)
>>
> 
> Otherwise this looks good to me. I'll ACK once I understand your pick
> for the timeout value.
> 
> -Steffan
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

