References: <b6450eb9-93db-63b9-7e13-4cacbcad39c9@...1227...>
 <20200415073017.22839-1-lstipakov@...277...>
 <1ed2462d-36bc-1393-a59f-133ba5788063@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <744f7da6-263a-957b-1e38-a40addc9bc9b@...2181...>
Date: Wed, 15 Apr 2020 18:45:00 +0200
MIME-Version: 1.0
In-Reply-To: <1ed2462d-36bc-1393-a59f-133ba5788063@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Fix illegal client float
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
To: Arne Schwabe <arne@...1227...>, Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 15/04/2020 11:32, Arne Schwabe wrote:
> Am 15.04.20 um 09:30 schrieb Lev Stipakov:
>> From: Lev Stipakov <lev@...515...>
>>
>> There is a time frame between allocating peer-id and initializing data
>> channel key, which is performed on receiving push request.
>>
>> If a "rogue" data channel packet arrives during that time frame from
>> another address and  with same peer-id, this would cause client to float
>> to that new address. This is because:
>>
>>  - tls_pre_decrypt() sets packet length to zero if
>>    data channel key has not been initialized, which leads to
>>
>>  - openvpn_decrypt() returns true if packet length is zero,
>> which leads to
>>
>>  - process_incoming_link_part1() returns true, which
>> calls multi_process_float(), which commits float
>>
>> Note that problem doesn't happen when data channel key
>> is initialized, since in this case openvpn_decrypt() returns false.
>>
>> Fix illegal float by adding buffer length check before calling
>> multi_process_float().
>>
>> This should fix Trac #1272.
>>
>> Signed-off-by: Lev Stipakov <lev@...515...>
>> ---
>>  v2: add comment explaning why nonzero check needed
>>
>>  src/openvpn/multi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index da0aeeba..37d2a6f2 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -2555,7 +2555,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>>              orig_buf = c->c2.buf.data;
>>              if (process_incoming_link_part1(c, lsi, floated))
>>              {
>> -                if (floated)
>> +                /* nonzero length means that we have a valid, decrypted packed */
>> +                if (floated && c->c2.buf.len > 0)
>>                  {
>>                      multi_process_float(m, m->pending);
>>                  }
>>
> Thanks!
> 
> Acked-By: Arne Schwabe <arne@...1227...>

just went through the entire flow with Lev and David and this all makes
a lot of sense now. Couldn't come up with a better fix for this issue.


Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

