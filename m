From: Kristof Provost <kprovost@...2661...>
Date: Tue, 17 May 2022 18:28:00 +0200
Message-ID: <25008C79-249A-42A5-B700-03B4D34D293F@...2661...>
In-Reply-To: <05faa4ef-4d3a-986a-3c2a-647d27b6e2b5@...2181...>
References: <20220516185621.6182-1-kprovost@...2661...>
 <20220516185621.6182-5-kprovost@...2661...>
 <05faa4ef-4d3a-986a-3c2a-647d27b6e2b5@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/4] Set (DCO) timeouts as well for p2p
 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 17 May 2022, at 15:25, Antonio Quartulli wrote:
> Hi,
>
> On 16/05/2022 20:56, Kristof Provost via Openvpn-devel wrote:
>> From: Kristof Provost <kp@...1376...>
>>
>> Signed-off-by: Kristof Provost <kprovost@...2661...>
>> ---
>>   src/openvpn/init.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 0d991ba4..701749cd 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -2232,6 +2232,21 @@ do_deferred_p2p_ncp(struct context *c)
>>           msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
>>           return false;
>>       }
>> +
>> +    if (dco_enabled(&c->options) && (c->options.ping_send_timeout || c-=
>c2.frame.mss_fix))
>> +    {
>> +        int ret =3D dco_set_peer(&c->c1.tuntap->dco,
>> +                c->c2.tls_multi->peer_id,
>> +                c->options.ping_send_timeout,
>> +                c->options.ping_rec_timeout,
>> +                c->c2.frame.mss_fix);
>> +        if (ret < 0)
>> +        {
>> +            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
>> +            return false;
>> +        }
>> +    }
>> +
>
> unless I am missing something, I don't think we need another dco_set_peer=
 call.
>
> It should be enough to move the invocation of dco_set_peer in finish_opti=
ons at the very top, before any attempt of bailing out.
>
Good point. I=E2=80=99ll update my patchset and include this in the next up=
date.

Br,
Kristof

