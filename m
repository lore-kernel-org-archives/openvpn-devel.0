References: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
 <1510416452-1201-1-git-send-email-arne@...1227...>
 <48bb26ee-9a28-24fa-ad5f-485aec1c4ee4@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bc3b0429-cbb8-19ed-562b-9be757dcff02@...1227...>
Date: Sun, 12 Nov 2017 11:01:31 +0100
MIME-Version: 1.0
In-Reply-To: <48bb26ee-9a28-24fa-ad5f-485aec1c4ee4@...2181...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2] Implement block-ipv6
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

Am 12.11.17 um 10:32 schrieb Antonio Quartulli:
> Hi,
> 
> On 12/11/17 00:07, Arne Schwabe wrote:
>> This can be used to redirect all IPv6 traffic to the tun interface, effectively black holing the IPv6 traffic. Without ICMPv6 error messages this will result in timeouts when the server does not send error codes.
>> block-ipv6 allows client side only blocking on all platforms that OpenVPN supports IPv6. On Android it is only way to do sensible IPv6 blocking on Android < 5.0 and broken devices (Samsung).
>> ---
>>  doc/openvpn.8         |  17 +++++
>>  src/openvpn/forward.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>  src/openvpn/forward.h |   3 +-
>>  src/openvpn/misc.c    |   4 +-
>>  src/openvpn/options.c |  17 +++++
>>  src/openvpn/options.h |   1 +
>>  src/openvpn/proto.h   |  19 ++++++
>>  7 files changed, 224 insertions(+), 7 deletions(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index a4189ac2..26b5f7de 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -1232,6 +1232,23 @@ Like \-\-redirect\-gateway, but omit actually changing the default
>>  gateway.  Useful when pushing private subnets.
>>  .\"*********************************************************
>>  .TP
>> +.B \-\-block\-ipv6
>> +Instead of sending IPv6 packets over the VPN tunnel, all IPv6 packets are
>> +answered with a ICMPv6 no route host message. This options is intended for
>> +cases when IPv6 should be blocked and other options are not available.
>> +
>> +Following config block would send all IPv6 traffic to OpenVPN and answer all
>> +requests with no route to host, effectively blocking IPv6.
>> +
>> +.B \-\-ifconfig-ipv6
>> +fd15:53b6:dead::2/64  fd15:53b6:dead::1
>> +.br
>> +.B \-\-redirect\-gateway
>> +ipv6
>> +.br
>> +.B \-\-block\-ipv6
>> +.\"*********************************************************
>> +.TP
>>  .B \-\-tun\-mtu n
>>  Take the TUN device MTU to be
>>  .B n
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 1b7455bb..21cce90b 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -1198,7 +1198,7 @@ process_incoming_tun(struct context *c)
>>           * The --passtos and --mssfix options require
>>           * us to examine the IP header (IPv4 or IPv6).
>>           */
>> -        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
>> +        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT|PIPV6_IMCP_NOHOST, &c->c2.buf);
>>  
>>  #ifdef PACKET_TRUNCATION_CHECK
>>          /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
>> @@ -1209,6 +1209,9 @@ process_incoming_tun(struct context *c)
>>                                  &c->c2.n_trunc_pre_encrypt);
>>  #endif
>>  
>> +    }
>> +    if (c->c2.buf.len > 0)
>> +    {
>>          encrypt_sign(c, true);
>>      }
> 
> I might not have a full understanding of this chunk: but could you
> explain how this is related to this patch?

It is similar to what check_ping_send_dowork does. Since you create a
new packet that goes out that is in the buf, it needs to be encryped and
signed.


>> +
>> +    /* IPv6 Header */
>> +    ASSERT(buf_write_prepend(&c->c2.to_tun, &pip6out, sizeof(struct openvpn_ipv6hdr)));
>> +
> 
> I see lots of asserts here and in other functions below.
> 
> Is it possible that a bridged/routed client could send a malformed IPv6
> packet to convert this ASSERTs into a DoS for the VPN client?

No, should not be, it is basically only to make sure the buf functions
return true.

> 
> Actually, any chance that this function is executed on the server? or is
> this impossible?
I will test, should be possible.

Arne




