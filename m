Message-ID: <52a70435-b108-939d-aa75-bc85c2fd85d4@...1227...>
Date: Thu, 13 Oct 2022 10:23:02 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20221012133457.1927871-1-arne@...1227...>
 <20221012133457.1927871-2-arne@...1227...> <Y0cm5SIpQH0g2UjA@...1296...>
 <a589d4f7-656d-6129-7cf2-dbe22ae77035@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <a589d4f7-656d-6129-7cf2-dbe22ae77035@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Use dedicated multi->dco_peer_id
 for DCO instead of multi->peer_id
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
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 12.10.22 um 22:54 schrieb Antonio Quartulli:
> Hi,
> 
> On 12/10/2022 22:43, Gert Doering wrote:
>> Hi,
>>
>> On Wed, Oct 12, 2022 at 03:34:55PM +0200, Arne Schwabe wrote:
>>> The lifetime and state machine of multi->peer_id does not exactly the
>>> lifetime/state of DCO. This is especially for p2p NCP where a 
>>> reconnection
>>> can change the peer id. Also use this new field with value -1 to mean
>>> not installed, replacing the dco_peer_added field.
>>
>> The code seems to disagree with itself whether it's -1 or 0, if I
>> read this correctly...
>>
>>> @@ -461,10 +461,10 @@ dco_remove_peer(struct context *c)
>>>           return;
>>>       }
>>> -    if (c->c1.tuntap && c->c2.tls_multi && 
>>> c->c2.tls_multi->dco_peer_added)
>>> +    if (c->c1.tuntap && c->c2.tls_multi && 
>>> c->c2.tls_multi->dco_peer_id)
>>>       {
>>
>> This checks for "not 0"...
>>
>>> -        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
>>> -        c->c2.tls_multi->dco_peer_added = false;
>>> +        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->dco_peer_id);
>>> +        c->c2.tls_multi->dco_peer_id = -1;
>>
>> ... but sets -1 here, which would evaluate to "true"...?
>>
>> (All the rest sets "-1", AFAICS, just the if() here is weird)
> 
> Using -1 makes sense, because 0 is a valid peer ID. I presume just that 
> if () is wrong.

Yes. Will update the patch with a correct if.

Arne


