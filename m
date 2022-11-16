Message-ID: <c74c85f1-dda0-c1e2-3a09-700241b9bd0b@...1227...>
Date: Wed, 16 Nov 2022 01:54:32 +0100
MIME-Version: 1.0
References: <20221115122940.1947284-1-arne@...1227...>
 <7e99c14a-0d3d-b539-f173-a00d79e52811@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <7e99c14a-0d3d-b539-f173-a00d79e52811@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Fix logic error in checking early
 negotiation support check
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


Am 15.11.2022 um 13:36 schrieb Antonio Quartulli:
> Hi,
>
> On 15/11/2022 13:29, Arne Schwabe wrote:
>> We want to check if EARLY_NEG_START is set and reserve the other bits
>> for future expansions. Right now we also check if all reserved bits are
>> zero. oops.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   src/openvpn/mudp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
>> index 7c6fc816e..bdf35a8ba 100644
>> --- a/src/openvpn/mudp.c
>> +++ b/src/openvpn/mudp.c
>> @@ -92,7 +92,7 @@ do_pre_decrypt_check(struct multi_context *m,
>>           ASSERT(packet_id_read(&pin, &tmp, true));
>>             /* The most significant byte is 0x0f if early negotiation 
>> is supported */
>> -        bool early_neg_support = (pin.id & EARLY_NEG_MASK) == 
>> EARLY_NEG_START;
>> +        bool early_neg_support = ((pin.id & EARLY_NEG_MASK) & 
>> EARLY_NEG_START) == EARLY_NEG_START;
>
> The "== EARLY_NEG_START" is not needed.


>
> On top of that, my brain parses the expression easier without that 
> part, because the question is "after filtering using the mask, is 
> EARLY_NEG_START set?".
> The "==" imho adds logic which is not needed (both at the code and at 
> the brain level).

Without the == it is enough if any of the bits EARLY_NEG_START is set 
(0xf00000), we want them all to be set. If EARLY_NEG_START were a 
flag/single bit, you would be right.

Arne


