Message-ID: <f4c40b20-6a0a-0fb2-a4ac-ad0055dbca33@...2181...>
Date: Wed, 27 Apr 2022 10:04:58 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
 <Ymj380c+Pl7JLFik@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Ymj380c+Pl7JLFik@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
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
To: Gert Doering <gert@...1296...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

On 27/04/2022 09:59, Gert Doering wrote:
> Hi,
> 
> On Wed, Apr 27, 2022 at 09:55:24AM +0200, Antonio Quartulli wrote:
>>> --- a/src/openvpn/forward.c
>>> +++ b/src/openvpn/forward.c
>>> @@ -1111,6 +1111,12 @@ process_incoming_dco(struct context *c)
>>>    
>>>        dco_do_read(dco);
>>>    
>>> +    if (dco->dco_message_type == OVPN_NOTIF_DEL_PEER)
>>
>> Not sure where this constant is coming from, but on ovpn_dco_linux.h we
>> have OVPN_CMD_DEL_PEER (similar format as the following OVPN_CMD_PACKET).
> 
> For "notifications coming from kernel", _NOTIF_ feels more logical
> than _CMD_ ("commands going into kernel").  No?

It's just the same message that can go both directions.

This is the same that the WiFi stack in the Linux kernel does with 
messages such as NEW_STA and DEL_STA.

So we're just re-using the same accepted pattern.

Regards,

-- 
Antonio Quartulli

