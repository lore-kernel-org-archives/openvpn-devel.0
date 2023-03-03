Message-ID: <4c2a77ee-b2d6-1675-fdd7-60e501333cc5@...2181...>
Date: Fri, 3 Mar 2023 12:48:42 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
References: <20230303110511.9569-1-kprovost@...2661...>
 <aedd91b7-74f7-7916-f5b5-3b2686e4e311@...2181...>
In-Reply-To: <aedd91b7-74f7-7916-f5b5-3b2686e4e311@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: define
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 03/03/2023 12:27, Antonio Quartulli wrote:
> Hi,
> 
> On 03/03/2023 12:05, Kristof Provost via Openvpn-devel wrote:
>> From: Kristof Provost <kp@...1376...>
>>
>> FreeBSD's if_ovpn will never emit this as a peer deletion reason
>> (because it doesn't support TCP), but this allows us to align the
>> defines between Linux and FreeBSD, and remove a Linux-specific case from
>> process_incoming_del_peer().
> 
> SoB missing

Sorry for being very condensed, however the patch looks good and gets my 
ACK:

Acked-by: Antonio Quartulli <a@...2181...>

I normally put my ACK under the SoB, so when I couldn't find it, my 
brain just threw that exception :-P

Cheers,

> 
>> ---
>>   src/openvpn/dco_freebsd.h | 1 +
>>   src/openvpn/multi.c       | 3 ---
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
>> index 2e35f3ac..970beca0 100644
>> --- a/src/openvpn/dco_freebsd.h
>> +++ b/src/openvpn/dco_freebsd.h
>> @@ -41,6 +41,7 @@ enum ovpn_del_reason_t {
>>       OVPN_DEL_PEER_REASON_EXPIRED,
>>       OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
>>       OVPN_DEL_PEER_REASON_USERSPACE,
>> +    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
>>   };
>>   typedef struct dco_context {
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index f2559016..99123c39 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -3244,12 +3244,9 @@ process_incoming_del_peer(struct multi_context 
>> *m, struct multi_instance *mi,
>>               reason = "ovpn-dco: transport error";
>>               break;
>> -#ifdef TARGET_LINUX
>> -        /* FIXME: this is linux-only today and breaks FreeBSD 
>> compilation */
>>           case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
>>               reason = "ovpn-dco: transport disconnected";
>>               break;
>> -#endif
>>           case OVPN_DEL_PEER_REASON_USERSPACE:
>>               /* We assume that is ourselves. Unfortunately, sometimes 
>> these
> 

-- 
Antonio Quartulli

