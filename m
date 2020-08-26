References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
 <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
 <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
 <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <6d416208-e6f6-a0d9-e7e8-ef757f8893ba@...1918...>
Date: Wed, 26 Aug 2020 11:12:32 +1000
MIME-Version: 1.0
In-Reply-To: <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> Management goes another code path and management_client_auth directly
> calls send_auth_failed.
I'm afraid in the case of renegotiation this is not relevant

> But I
> also haven't digged deep enough to actually understand if your is
> actually fixing the problem correctly.
May I request that we resolve this first to ensure the content of the=20
patch is correct, and then we can move onto finding a way to avoid this=20
extra state?

> You haven't described the bug/symptons you are seeing yet but I assume
> you get desynced keys etc?
If I haven't been detailed enough, I apologise. Here is an in-depth=20
explanation.

In the event of a renegotiation where there is some form of user/pass in=20
place, and auth-tokens are not being used, if the verification of the=20
user/pass fails, for example, they enter an incorrect password and are=20
not using auth-nocache or are using some form of static-challenge=20
attached to the password which has expired, or the server has a hiccup=20
and rejects auth for some reason (the list goes on), the client will=20
receive no indication that authentication has failed as AUTH_FAILED is=20
only sent in response to a push_request. The client will appear=20
connected but traffic will cease until a ping-restart occurs due to a=20
key desync. This occurs regardless of auth method used, whether it be=20
plugin, script or management.

In the event an auth-token is used, if the auth-token fails, whether it=20
be because the auth-token is incorrect or expired, the user will also=20
receive no indication that it has failed, and again, the client will=20
appear as if it is in a connected state even though it is not until a=20
ping-restart occurs.

This is very easy to test, simply setup a basic server using the=20
included PAM plugin module, set reneg-sec to something short like 10=20
seconds, set auth-nocache on the client, connect, then on the reneg=20
enter an incorrect password.

Originally we treated various scenarios as a misconfiguration, however=20
there are server administrators out there that genuinely don't want to=20
use auth tokens, and others that genuinely want their users to reauth=20
manually each period via a renegotiation, so we feel this should be=20
fixed. We've had this patch available as-is now for over a year and have=20
had no reports of issues with it for those using it.

Regards,
Eric

---
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 25/08/2020 4:24 pm, Arne Schwabe wrote:
> Am 25.08.20 um 01:51 schrieb Eric Thorpe:
>> Hi Selva,
>>
>>> In multi_connection_estableished, we have
>>>
>>> #ifdef MANAGEMENT_DEF_AUTH
>>>  =C2=A0 =C2=A0 if (management)
>>>  =C2=A0 =C2=A0 {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 management_connection_established(manageme=
nt,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &mi->context.c2.mda_context,
>>> mi->context.c2.es <http://context.c2.es>);
>>>  =C2=A0 =C2=A0 }
>>> #endif
>>> I do not see why this requires --management-client-auth or any
>>> management related options to be in use.
>> management is set to NULL unless a management address is defined
>> (--management), so the above is not called for a plugin or script
>>
>> bool
>> open_management(struct context *c)
>> {
>>  =C2=A0=C2=A0=C2=A0 /* initialize management layer */
>>  =C2=A0=C2=A0=C2=A0 if (management)
>>  =C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->options.management_ad=
dr) <----
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clos=
e_management(); <----
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> I'm not trying to be resistant in finding another way here to avoid this
>> extra state you guys don't want, this is a real bug in re-auth/reneg
>> that we have seen occur multiple times in various setups that we want to
>> see fixed, and it effects management,
> Management goes another code path and management_client_auth directly
> calls send_auth_failed.
>
>> script and plugin authentication,
>> however I have had a good walk through the code and I can't see another =
way.
>>
>> The other alternative here is to refactor up the call chain so the
>> context_2 is passed to each of these functions instead of just multi &
>> session, however this is about a 500 line refactor that I really don't
>> want to do.
> Well the tls session should basically only care about its own session
> and the outer logic that ties the tls session together should handle
> this. The current code is not as clean as it could be/should be. But I
> also haven't digged deep enough to actually understand if your is
> actually fixing the problem correctly. We have a working scenario (I
> assume) with management and client-auth
>
> - Do we send the AUTH_FAILED over the new or the old tls session?
> - Do we establish the data channel (key_method_2_write) before writing
> the key?
>
> (and the same for the new approach)
>
> You haven't described the bug/symptons you are seeing yet but I assume
> you get desynced keys etc?
>
> I understand that is frustrating from your end since you have a quite
> simple fix and fixes your problem but I am here maintaining OpenVPN and
> it took me 1-2 weeks to get rid of 2-3 similar variables to the one you
> want to introduce.
>
> Arne
>

