References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
 <20210408155251.GX976@...1296...>
 <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9e817c78-17de-5b4b-2367-045b68d0f9fe@...2181...>
Date: Fri, 9 Apr 2021 11:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Jan Just,

On 09/04/2021 11:24, Jan Just Keijser wrote:
> Hi,
>=20
> On 08/04/21 17:52, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
>>> I don't have any evidence with 2.5 right now but this is just a matter =

>>> of use/principle to me: I can very well see that I would like to have a=
=20
>>> setup *without* NCP as I simply do not need it (e.g. my cipher is=20
>>> hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to ens=
ure=20
>>> my setup is 100% predictable.
>> By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
>> a 100% predictable outcome.  No other cipher will be offered or accepted.
> Ah a new 2.5 option - I assume the same thing is true for adding this on
> the server side?
>=20
> And I see that --data-ciphers works only in combination with NCP, that
> is, if you do
> =A0 --data-ciphers aes-256-gcm --ncp-disable
> then --data-ciphers is effectively ignored.=A0 Nice=A0 ;)

Yeah, so the NCP behaviour is now customizable enough to give you total
control over what should happen.

>=20
>>> Disabling this option means you give me less control over the setup and=
=20
>>> I don't like that, thus Feature-NAK.
>> Removing that option means "less confusing code variants that can lead
>> to 'it works with NCP but not with NCP disabled'".
>>
>> Since I test all these variants, and find the confusing corner cases, it
>> would be good to have less code paths throughout OpenVPN, especially=20
>> in the server option negotiation and key setup phases.
>>
>>
>>> I'd say that removing the ability to disable NCP=A0 can happen *only* w=
hen=20
>>> all negative side-effects of enabling it have been mitigated fully.=A0 =
On=20
>>> a slow link the NCP overhead can be quite disastrous and not just durin=
g=20
>>> connection setup, but during the *whole* session. To me, yet another=20
>>> reason for Feature-NAK
>> The overhead of NCP is roughly "some 100 bytes sent extra from client to
>> server in the TLS handshake phase" (to announce the acceptable ciphers)
>> and "cipher xxx" in the PUSH_REPLY.
>>
>> There is no overhead in the data phase.
>>
>> Please explain how this can be "quite disastrous"?
>>
>>
>> (Of course, if NCP negotiates a cipher with more overhead than you'd
>> like to use, that would be "more overhead" - but this is fully under=20
>> the client's control with --data-ciphers.  It even works with "none",
>> provided both client and server permit this)
> I was thinking about this email discussion we had in October 2018:
>=20
>> On 29/10/18 18:08, Gert Doering wrote:
>>> On Mon, Oct 29, 2018 at 05:40:04PM +0100, Jan Just Keijser wrote:
>>>> So, the '32' is easily explained. However, the rest of the MTU
>>>> calculation baffles me.
>>> Part of this is "peer-id" (+3 bytes) and "the theoretical maximum
>>> crypto + hmac overhead" which 2.3 calculates "for the cipher chosen"
>>> and 2.4 needs to calculale for the worst-case cipher+auth, since it does
>>> not know what the server will push.
>>>
>>> In other words, you do not want to know - and the whole "match
>>> configured client/server tun-mtu/link-mtu OCC thingie" is a real
>>> nuisance.
>>
>> so I now understand the client MTU:
>> =A0 openvpn 2.3.18 -> mtu =3D 1431
>> =A0 openvpn 2.4.6 -> mtu =3D 1428 which accounts for peer-id (+3)
>>
>> but the *server* mtu?!?!?!=A0 I would have expected that with
>> --ncp-disable added I would end up with more or less the same MTU as
>> with the 2.3 code. Instead I see
>> =A0 openvpn 2.3.18 -> mtu =3D 1431
>> =A0 openvpn 2.4.6 -> mtu =3D 1379
>> which is 62 bytes LESS , so even with peer-id subtracted (does it
>> apply to the server MTU?)=A0 I end up with 59 bytes unaccounted for *in
>> tun mode*.
>>
> and I was hoping that this would be resolved before removing something
> like --ncp-disable. Having said that, I now see that with openvpn 2.5,
> the server mtu is still 1379 in my setup, regardless of whether I use
> --ncp-disable or not=A0 - seems to me that is still too low.
>=20

If I understand your point correctly, you basically confirmed that this
"MTU issue" you are seeing is unrelated to having --ncp-disable or not.

Therefore I think this topic should not be an argument for *not*
removing --ncp-disable.

We have been busy discussing the "MTU mess" in the past weeks, so this
is also something that we are all committed to solve.
However, for the sake of this discussion, I'd keep this problem
separated (worth discussing in another thread, of course!).

> On the client side I now see even more confusing fun:
>=20
> Server has --ncp-disable set:
> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1376=A0 <--- huh?
>=20
> Server does not have --ncp-disable set:
> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1448
> (ok I understand the latter).
>=20
> What I'd really like to see is a way to get the server-side MTU to also
> be 1428/1448 using the right magic options - any idea if that's possible?
> The lower the MTU on either side, the lower the maximum bandwidth -
> which will hurt especially over low-bandwidth links.
>=20
> Also, when this option is dropped, does that mean that a 2.4/2.5 client
> with the option set can no longer connect to a 2.6 server?

No. *All* clients will still be able to connect.

The NCP logic has a case for "the client is not NCP-capable".

In this case the server checks OCC string to see what cipher the client
is going to use. If this cipher is part of the data-ciphers list on the
server, then that cipher will be used.
If there is no OCC string, I think the server will use the configured
fallback-cipher.

So compatibility is preserved.

As you can see NCP is much more comprehensive that what it was before,
hence the request to drop --ncp-disable.

>=20
> Conclusion: a further overhaul of the ncp/cipher/data-ciphers logic
> might be in order...

This is exactly what has been going on, I'd say, with the addition of
the new options and new logic to keep compatibility with non-NCP clients.

> Which is one of my gut reasons for saying : don't remove --ncp-disable
> until this mess is thoroughly sorted out.

I hope this patch makes more sense now.

Regards,



--=20
Antonio Quartulli

