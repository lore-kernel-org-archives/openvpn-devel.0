References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
 <20210408155251.GX976@...1296...>
 <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
 <7f1d31b2-917b-81b0-702a-f974aeb2f882@...1227...>
 <05cb657b-e8e2-e7e1-1b30-866272df79c3@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <dc437b83-c7a2-24cc-e044-6b50fa1e2d60@...1227...>
Date: Fri, 9 Apr 2021 12:54:13 +0200
MIME-Version: 1.0
In-Reply-To: <05cb657b-e8e2-e7e1-1b30-866272df79c3@...1147...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

>>> and I was hoping that this would be resolved before removing something
>>> like --ncp-disable. Having said that, I now see that with openvpn 2.5,
>>> the server mtu is still 1379 in my setup, regardless of whether I use
>>> --ncp-disable or not=A0 - seems to me that is still too low.
>>>
>>
>> Yes DATA_V2 adds 3 bytes compared to DATA_V1.
> I understand the 3 bytes (--peerid and such) but is there any way to NOT
> have such a low server-side MTU?
> Also note that having a different server-side MTU versus client-side MTU
> makes it even harder to tune the performance


Basically no. The Data V1 vs Data V2 discussion is basically done and V2
is here to stay. If 3 bytes really are too much (and we have a very
strong use case to save those bytes), having optionally reduce the auth
tag in AES-GCM/CachaPoly to something like 128 bit (16 bytes) or 160 bit
instead the current 256 bit (32 bytes) makes probably more sense. E.g.
Wireguard only uses 16 bytes auth tag and IPSec allows 16/12/8 bytes
according to RFC4106.

I don't think there is any real different client vs server mtu here
apart from potential bugs in the MTU code but not any fundamental

> thanks for all the clarifications - esp the cipher-negotiation.rst was
> very helpful.
> And I understand the argument about "polluting the discussion" but to me
> the *order* in which things are done is important. That is, for the 2.6
> release all MTU issues should be resolved , so that noone will ever have
> a need to debug MTU issues by dis- or enabling NCP.
> So I guess if things were done in the order
> =A0 1) fix the MTU issues on both client and server side
> =A0 2) drop --ncp-disable
> then you would not have heard any complaints from me.

That is an easy thing to say if you don't do the development.

But no, it doesn't work this way this time. I am simply not abanding my
30-40 outstanding patches now (that include also DCO), stop working on
them when they are nearly finished, spend all my time on MTU and then
later come back to the NCP/DCO/TLS session refactoring.

And I also don't want to invest time fixing MTU issues related to
disabled MTU if I remove that feature later. That is just wasted time.

And as Antonio said, we are committed to fixing these issues. We do not
plan to release a 2.6 version with broken MTU.

Arne


