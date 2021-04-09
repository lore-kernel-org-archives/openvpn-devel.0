References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
 <20210408155251.GX976@...1296...>
 <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
 <7f1d31b2-917b-81b0-702a-f974aeb2f882@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <05cb657b-e8e2-e7e1-1b30-866272df79c3@...1147...>
Date: Fri, 9 Apr 2021 12:19:26 +0200
MIME-Version: 1.0
In-Reply-To: <7f1d31b2-917b-81b0-702a-f974aeb2f882@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne, Antonio,

On 09/04/21 11:53, Arne Schwabe wrote:
> Am 09.04.21 um 11:24 schrieb Jan Just Keijser:
>> On 08/04/21 17:52, Gert Doering wrote:
>>> On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
>>>> I don't have any evidence with 2.5 right now but this is just a matter
>>>> of use/principle to me: I can very well see that I would like to have a
>>>> setup *without* NCP as I simply do not need it (e.g. my cipher is
>>>> hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to en=
sure
>>>> my setup is 100% predictable.
>>> By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
>>> a 100% predictable outcome.  No other cipher will be offered or accepte=
d.
>> Ah a new 2.5 option - I assume the same thing is true for adding this on
>> the server side?
>>
>> And I see that --data-ciphers works only in combination with NCP, that
>> is, if you do
>>  =A0 --data-ciphers aes-256-gcm --ncp-disable
>> then --data-ciphers is effectively ignored.=A0 Nice=A0 ;)
> Yes data-ciphers (and data-ciphers-fallback) are meant to replace all
> other cipher related options eventually.
>
>
>
>> and I was hoping that this would be resolved before removing something
>> like --ncp-disable. Having said that, I now see that with openvpn 2.5,
>> the server mtu is still 1379 in my setup, regardless of whether I use
>> --ncp-disable or not=A0 - seems to me that is still too low.
>>
>
> Yes DATA_V2 adds 3 bytes compared to DATA_V1.
I understand the 3 bytes (--peerid and such) but is there any way to NOT=20
have such a low server-side MTU?
Also note that having a different server-side MTU versus client-side MTU=20
makes it even harder to tune the performance
>> On the client side I now see even more confusing fun:
>>
>> Server has --ncp-disable set:
>> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
>> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1376=A0 <--- hu=
h?
>>
>> Server does not have --ncp-disable set:
>> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
>> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1448
>> (ok I understand the latter).
>>
>> What I'd really like to see is a way to get the server-side MTU to also
>> be 1428/1448 using the right magic options - any idea if that's possible?
>> The lower the MTU on either side, the lower the maximum bandwidth -
>> which will hurt especially over low-bandwidth links.
>>
>> Also, when this option is dropped, does that mean that a 2.4/2.5 client
>> with the option set can no longer connect to a 2.6 server?
> I am not sure how you came to that conclusion. I have written a fairly
> comprehensible documentation how NCP in 2.5 works for our manpage:
> https://github.com/OpenVPN/openvpn/blob/master/doc/man-sections/cipher-ne=
gotiation.rst
>
> That should also answer your question.
>
>> Conclusion: a further overhaul of the ncp/cipher/data-ciphers logic
>> might be in order...
>> Which is one of my gut reasons for saying : don't remove --ncp-disable
>> until this mess is thoroughly sorted out.
> Please don't mix two things here. Yes the MTU calculation and MTU in
> general is broken but shouldn't pollute this discussion here.
>
> And yes we will look into MTU related issues before 2.6 is released but
> having a non NCP and a NCP code path for MTU is not helping to reduce
> the complexity.
>
>
thanks for all the clarifications - esp the cipher-negotiation.rst was=20
very helpful.
And I understand the argument about "polluting the discussion" but to me=20
the *order* in which things are done is important. That is, for the 2.6=20
release all MTU issues should be resolved , so that noone will ever have=20
a need to debug MTU issues by dis- or enabling NCP.
So I guess if things were done in the order
 =A0 1) fix the MTU issues on both client and server side
 =A0 2) drop --ncp-disable
then you would not have heard any complaints from me.

cheers,

JJK


