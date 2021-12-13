Message-ID: <4e050aa9-bc75-87b1-9402-b2778ed5a929@...1227...>
Date: Mon, 13 Dec 2021 17:31:23 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-9-arne@...1227...>
 <660636853.1203153.1639398941899@...2642...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <660636853.1203153.1639398941899@...2642...>
Subject: Re: [Openvpn-devel] [PATCH 08/21] Decouple MSS fix calculation from
 frame calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 13.12.21 um 13:35 schrieb Frank Lichtenheld:
> 
>> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
> [...]
>> diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
>> index aa5b68ce9..56dea0292 100644
>> --- a/src/openvpn/mss.c
>> +++ b/src/openvpn/mss.c
> [...]
>> @@ -204,3 +206,41 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
>>           }
>>       }
>>   }
>> +
>> +void
>> +frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
>> +                       const struct options *options)
>> +{
>> +    if (options->ce.mssfix == 0)
>> +    {
>> +        return;
>> +    }
> 
> Wouldn't an ASSERT be better here? This essentially should never happen because ce.mssfix is initialized
> to MSSFIX_DEFAULT, anyway. If you handle this without an error here it looks like this will just explode
> later in mss_fixup_dowork. An ASSERT might be easier and cleaner.

--mssfix 0 can be used to disable MSSFIX but I broke that in this patch. 
So basically that test is testing if mssfix is enabled.

Arne

