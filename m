Message-ID: <dfff728d-321e-f8b9-3ba4-17ec13efc78a@...1227...>
Date: Tue, 26 Apr 2022 18:59:46 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
References: <20220426162934.12938-1-kprovost@...2661...>
 <20220426162934.12938-2-kprovost@...2661...>
 <c1bfbb9c-6556-39cd-cafb-903d2fd4ca68@...1227...>
In-Reply-To: <c1bfbb9c-6556-39cd-cafb-903d2fd4ca68@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
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

Am 26.04.22 um 18:56 schrieb Arne Schwabe:
> Am 26.04.22 um 18:29 schrieb Kristof Provost via Openvpn-devel:
>> From: Kristof Provost <kp@...1376...>
>>
>> Handle the DCO driver telling us that the peer went away, even if we're
>> not running in multi-instance mode.
>>
>> Signed-off-by:    Kristof Provost <kprovost@...2661...>
>> ---
>>   src/openvpn/forward.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 9ddea439..25fa300f 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -1111,6 +1111,12 @@ process_incoming_dco(struct context *c)
>>       dco_do_read(dco);
>> +    if (dco->dco_message_type == OVPN_NOTIF_DEL_PEER)
>> +    {
>> +        register_signal(c, SIGTERM, "ping timeout");
>> +        return;
>> +    }
> 
> Have not really checked checked but I think it should be SIGUSR1 because 
> a ping timeout should not termminate the client.
> 

Okay, looked at the code. You probably want to call 
trigger_ping_timeout_signal which uses SIGTERM or SIGUSR1 depending on 
the configuration


Arne


