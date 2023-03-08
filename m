Message-ID: <7e5fc5f4-a17a-0266-f465-faa683cdcf31@...1227...>
Date: Wed, 8 Mar 2023 11:10:59 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230307235737.3595130-1-arne@...1227...>
 <a6e1a837-8366-0027-c5af-d8d557a4c2c9@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <a6e1a837-8366-0027-c5af-d8d557a4c2c9@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid warning about missing braces when
 initialising key struct
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

Am 08.03.23 um 11:03 schrieb Antonio Quartulli:
> Hi,
> 
> On 08/03/2023 00:57, Arne Schwabe wrote:
>> This avoids the warning from gcc about initialising the key2 struct
>>
>> Change-Id: Ia73d24923b1efd99263f33ce13d90e04b59bd980
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   src/openvpn/tls_crypt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
>> index 81098355e..e84d979e9 100644
>> --- a/src/openvpn/tls_crypt.c
>> +++ b/src/openvpn/tls_crypt.c
>> @@ -348,7 +348,8 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi 
>> *key, struct key2 *original_key,
>>           msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
>>       }
>> -    struct key2 key2 = { .n = 2, .keys = { 0 } };
>> +    struct key2 key2 = { .n = 2, .keys = {{{ 0 }}} };
> 
> why not just struct key2 key2 = { .n = 2 } ?

That will initialise the whole struct to 2 including the key material, 
which I would like to avoid.

Arne


