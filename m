Message-ID: <fdc7fccb-5ffe-6d24-2406-db9f56b0dc98@...1227...>
Date: Tue, 14 Dec 2021 23:38:41 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211207170211.3275837-1-arne@...1227...>
 <20211214150901.4118886-1-arne@...1227...>
 <132451012.1249764.1639501826730@...2642...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <132451012.1249764.1639501826730@...2642...>
Subject: Re: [Openvpn-devel] [PATCH v2 08/21] Decouple MSS fix calculation
 from frame calculation
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

Am 14.12.21 um 18:10 schrieb Frank Lichtenheld:
> 
> 
>> Arne Schwabe <arne@...1227...> hat am 14.12.2021 16:09 geschrieben:
>>
>>   
>> This consolidates the MSS fix calculation into a single function
>> instead having it distributed all over the code. It also calculates
>> the real wire overhead without extra sizes for buffer etc.
>>
>> Patch v2: improve comment
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   src/openvpn/forward.c |  5 ++---
>>   src/openvpn/init.c    |  3 ++-
>>   src/openvpn/mss.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>>   src/openvpn/mss.h     |  6 ++++++
>>   src/openvpn/mtu.c     |  9 ---------
>>   src/openvpn/mtu.h     | 10 ++++++----
>>   src/openvpn/proto.h   | 11 -----------
>>   src/openvpn/ssl.c     |  3 ++-
>>   8 files changed, 58 insertions(+), 29 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 29efcd3b9..f82386a1d 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -1493,7 +1493,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
>>                   /* possibly alter the TCP MSS */
>>                   if (flags & PIP_MSSFIX)
>>                   {
>> -                    mss_fixup_ipv4(&ipbuf, MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC(&c->c2.frame)));
>> +                    mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
> 
> I still think this will badly explode in the ce.mssfix == 0 code path. In that case frame.mss_fix == 0 AFAICT
> and I see no handling of that possibility in mss_fixup_ipv4/6.

I won't. This is part of the older parts of OpenVPN that are more 
obscure. You overlooking the implicit assumption that PIP_MSSFIX is only 
set if also c->c2.frame.mssfix is != 0

See the top of the function. If ce.mssfix is 0 then you never have the 
PIP_MSSFIX flag in the flags:

void
process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
{
     if (!c->options.ce.mssfix)
     {
         flags &= ~PIP_MSSFIX;
     }


Arne

