References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
 <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
 <3ba00502-4919-b866-451f-0ae215e6a170@...2181...>
 <5a4c873d-5bc0-2852-0e9f-612031796919@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <24f1514f-c203-aebe-9e88-131cb7a6f594@...2181...>
Date: Mon, 14 Jun 2021 03:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <5a4c873d-5bc0-2852-0e9f-612031796919@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 14/06/2021 03:07, Arne Schwabe wrote:
> Am 14.06.21 um 03:01 schrieb Antonio Quartulli:
>> Hi,
>>
>> On 14/06/2021 02:56, Arne Schwabe wrote:
>>> Am 14.06.21 um 02:24 schrieb Antonio Quartulli:
>>>> @Arne, ideas?
>>>>
>>>
>>> Yes. When reneg-sec is below 60 or 120 (would need to double check), you
>>> need that value on both server and client since otherwise the timeouts
>>> for changing active keys mismatch as the value is 60s normally but
>>> changes if reneg-sec goes below that value.
>>
>> Isn't it relevant that the server is able to fix itself in around 5/6
>> seconds? It does not need to wait for the full 60s to get back in sync.
>>
>> From the log it also seems like the key with the new ID has been
>> installed, but the state has not been switched.
>>
> 
> From the logs it looks like the key is still in deferred auth
> (uth=KS_AUTH_DEFERRED), as you can see from the state, so the server
> cannot use it for decryption yet.
> 
> reneg-sec 20 on client means that the client will switch to the new key
> after 10s. With deferred auth in the mix on the server side that is a
> bit tight.  If the server has not authenticated that key yet, you will
> see the out of sync messages.

Ok, after clarifying in chat, I understood that the time needed by a
peer to elect a key as "usable" is defined by auth_deferred_expire_window().

If reneg-sec is smaller than hand-window (which is 60s by default) then
we can have this particular situation.

Now, we are assuming that hand-window is always the same on both peers
(client and server), but actually this value may also be customized and
mess everything up.

Changing hand-window on one peer only is not a good idea in any case.

At this point I'd ask, why not re-moving/ignoring --hand-window entirely
and live with the 60s default?


Regards,



-- 
Antonio Quartulli

