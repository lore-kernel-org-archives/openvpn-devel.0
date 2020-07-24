References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
 <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
 <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
 <fb8b822c-4cc5-54b5-59bc-1f9ababc0171@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0b5dd7e1-b007-c613-03df-5096394c246f@...2080...>
Date: Fri, 24 Jul 2020 13:24:37 +0200
MIME-Version: 1.0
In-Reply-To: <fb8b822c-4cc5-54b5-59bc-1f9ababc0171@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lUUXqwrWxOF2YlQwEKYTpPRK7KNMnzXBX"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lUUXqwrWxOF2YlQwEKYTpPRK7KNMnzXBX
Content-Type: multipart/mixed; boundary="F37LotT8DSz9rifKT5OFlGsIaZYalqzbO";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0b5dd7e1-b007-c613-03df-5096394c246f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
 <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
 <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
 <fb8b822c-4cc5-54b5-59bc-1f9ababc0171@...1227...>
In-Reply-To: <fb8b822c-4cc5-54b5-59bc-1f9ababc0171@...1227...>

--F37LotT8DSz9rifKT5OFlGsIaZYalqzbO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/07/2020 12:45, Arne Schwabe wrote:
> First of all I did not want to reply to this since we had a lengthy
> discussion on IRC.
>=20
>> Lets take a few steps back try to see a broader picture.
>>
>> * --ncp-ciphers was introduced in OpenVPN 2.4 as a brand new option.
>>
>> * Steffan has suggested to add --data-ciphers alias into the next v2.4
>>   release; to which I agree(!).
>=20
> Yes, this sounds like a simple idea but also has the danger of creating
> more confusion.
>=20
> I feel it better to have ncp-cipher and data-ciphers coexist. Then you
> also have the understand that ncp-cipher is an older/less capable
> version of data-ciphers.
>=20
> OpenVPN 2.4 has a number of oddities in NCP support:
>=20
> - the client always announces AES-GCM support even if disabled in
> ncp-ciphers
> - the server will always push the first cipher of its ncp-ciphers list
> to the client.

These oddities, they sounds like bugs, or?  If I try to put on my
Never-used-NCP-before-hat, this would not be what I would expect.  Why have=
n't
we resolved this within the current 2.4 scope without changing options?



> From a user perspective data-ciphers is a true superset of ncp-ciphers.
> All existing ncp-ciphers setup will continue to work on 2.5 but the
> data-ciphers option from 2.5 is likely to break on 2.5 if you don't take
> into account the 2.4 oddities.
>=20
>> * I propose we add a warning whenever --ncp-ciphers used, recommending t=
he
>>   user to switch to --data-ciphers as soon as possible.
>=20
> As compromise maybe something like
>=20
> NOTE: Rewriting old-option x y z to new new-option x y z

As mentioned on IRC, yes.  I am willing to accept

msg(M_INFO, "Rewriting deprecated option X to the replacement Y" ...



[...]
>> * 12 months *after* the v2.6 release is out, we can remove --ncp-ciphers=
.  But
>>   since we will not do option changes mid-release easily, it might be na=
tural
>>   to remove this in OpenVPN 2.7 at earliest.
>>
>> This means --ncp-ciphers will be supported in 2.4 for the life time of t=
hat
>> release.  And v2.4 is supported for *at least* 18 months after v2.5 is
>> released.  It also guarantees --ncp-ciphers will first be removed when we
>> release OpenVPN 2.7.
>>
>> What would be a problem with such a schedule?  Because I don't understan=
d the
>> real objection you have to remove options which ends up duplicating othe=
r options.
>=20
>=20
> My general problem is that I don't see a real advantage in removing
> ncp-cipher but see a lot of downsides removing it.

I hear about you seeing downsides ... but I have not seen any argument here
convincing me otherwise.  This overall process should take care of supporti=
ng
all reasonable OpenVPN 2.x versions.



>> At the same time ... it is also important for me that we try to see this=
 at
>> from an even bigger perspective than just --ncp-ciphers/--data-ciphers o=
r even
>> --udp-mtu alone.  Now I'm shifting the discussion to a more generic prod=
uct
>> life cycle perspective.
>>
>> If we skimp through this and just allow whatever option duplications we =
head
>> into, just because we're too concerned about various breakages with old
>> configurations or setups - it will not be the last time we might end up =
in
>> such discussions UNLESS we can find a proper and reasonable process for
>> deprecation (which we in fact already defined for feature deprecation 10=
 years
>> ago! [1]).
>>
>> If we cannot remove options during the whole life time of OpenVPN, we ca=
nnot
>> touch compression options or possibly even deprecate any compression at =
all -
>> because we need to support both compression and decompression for the wh=
ole
>> lifetime of OpenVPN.  This also extends into how to ensure proper OpenVP=
N 3
>> compatibility as well.
>=20
> The amount of time we spend on testing/developing etc on compression and
> the complexity it introduces is vastly different from ncp-cipher

That is true.  But at the same time, if we do not have a proper deprecation
process where we draw the line in which OpenVPN versions we are willing to
support (from a functional perspective), we cannot touch compression.

Which is why I'm trying to raise the points of a bigger picture.  We need to
find a reasonable solution to which OpenVPN versions we are willing to
support, and when those versions enters the unsupported side we should be f=
ree
to cleanup code and options related to the behavior and functionality only
these now not supported releases provided.



>> And if we cannot remove any options during the eternal life time of Open=
VPN, I
>> will see no other alternative to being even more critical and rejective =
to add
>> new options.  We already have pretty close to 300 options in OpenVPN.  T=
hat is
>> an insane amount - where a typical common OpenVPN setup might need up to=
 20 of
>> these options, the rest are for all kinds of special cases.  And we have
>> several competing solutions which are far simpler in many aspects which =
new
>> users might just as well prefer.
>>
>> Even though I highlight the number of options we have, I do NOT say that=
 we
>> should swipe them all out and reduce the amount to 50 or so; for some us=
ers
>> they have a _real_ value and provides really useful features.  But I wan=
t us
>> to save the options which do have a REAL value, not because unsupported
>> OpenVPN versions might break or "10 bytes extra source code" is too heav=
y to
>> carry around for an alias option.  I'm arguing for keeping options cover=
ing
>> _REAL_ USE CASE for users.  And no, breaking unsupported OpenVPN release=
s is
>> NOT a real use case from my point of view.
>=20
> This is the point where we disagree. I still think that we should weigh
> the pros and cons if we still want have compatibility. And also to
> consider if there are alternatives/workaround for the setups/users
> affected.

This is again the same issue, to be able to draw the line somewhere to what=
 we
are willing to support.  What kind of life cycles do we want for OpenVPN?



>> But back to the deprecated options  ... If we cannot remove options, we =
also
>> need to consider bringing back the --tls-remote option, and --compat-nam=
es -
>> both with the capability to break client configs (in fact, it already di=
d for
>> several Fedora EPEL users [2]).=20=20
>=20
> Well if weighing the pros of bringing it back outwights the cons, then
> the decision to compeletly remove it might have been wrong.

So the question is ... do we care about broken OpenVPN 2.3 (or older)
configurations today?  Which is technically supported by us another 12 mont=
hs
after the v2.5 release.



>> The proposal to remove --remote-nopull needs
>> to be reconsidered, as well as --secret, --max-routes, and possibly even
>> --ncp-disable.  Maybe even more of these deprecated options needs to be
>> reconsidered [3].
>=20
> For ncp-disable I did the weighing of pros and cons and answer that
> question. ncp-disable add complexity to the code paths and is in
> conflict which the direction we want to go. And for users that currently
> use the option the workable workaround is to just remove that options as
> it should not be necessary in 2.5 anymore.

But it still will break users configs without any prior warning in 2.4.  It
was added to our git master only in 15 days ago.  Including potential client
configurations.

Again, this exemplifies that we are lacking a proper product life cycle
process and even adhering to a feature deprecation process.



>> We really need a proper and sane processes to allow the development of O=
penVPN
>> to have a chance to move on and leave things behind when appropriate, to=
 be
>> able to evolve and grow with the future - without being strangled by what
>> existed in the far past (meaning: no longer community supported releases=
).
>> Otherwise I do fear for the future of OpenVPN 2.x.
>=20
> There is more a to software than the development. There is also how it
> is used/etc. And we should not make it harder than it needs to be. And
> even for our own company internal use case of Access server the reality
> is that we even though we do not like supporting the old clients (back
> to 2.2 in some cases), we still have to do it because there is demand
> for it.

Why Access Server supports such old OpenVPN releases is a completely differ=
ent
discussion not belong here in the community.  There might be valid use cases
for these customers, but in such situations additional (and often fairly
expensive) support contracts are required by the vast majority of vendor
agreements I've seen.  And these corporate special needs should not end up =
in
the community.

The community needs to be decoupled to be fully functional.  I say this as a
OpenVPN Inc hire - and has also said this internally to the management over
the years I've been there.  From what I experience, there is a general
understanding for the need of this separation.



>> By having a clear strategy and adhering to a process of feature/option
>> management in OpenVPN, we give clearly defined time-window for stability=
 and
>> functionality for our users.  This predictability is, in my experience, =
much
>> more important to users than if a specifically named option is supported=
 or not.
>=20
> Yes. If we decide to remove an option we should have this predictable
> removal process. But if we remove an option/drop support for something
> something that should still be a weighing of pros and cons.
>=20
> For this specific option of ncp-ciphers/data-ciphers. This not just a
> fringe option. This is an option that affects one of the core things of
> OpenVPN, the chosen chipher. I want to make the transition to NCP as
> painless as possible and  keeping ncp-cipher as alias to data-cipher is
> just the better choice in my opinion.

I agree that --data-cipher is a better name for it; I have not rejected tha=
t.

But that doesn't mean we should have two thoughts active at the same time: =
a)
NCP improvements, and b) product life cycle, what we support and how we
support OpenVPN in the long run ... in this case they do impact each other.

But when we only focus on a) without properly considering b), that is the
point where I object.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--F37LotT8DSz9rifKT5OFlGsIaZYalqzbO--

--lUUXqwrWxOF2YlQwEKYTpPRK7KNMnzXBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfGsT1AAoJEIbPlEyWcf3yqxgP/0cSS7RSI7+Q50zZv/Nld4kB
/ZTRfvXZJJZP1YW9zxMcdJoe5xCWe5q1ysWJWi+KdCaa4Um5GrnJLqUFj/jJVnPR
lXMGW8msoOEY0YbM0kvD2zcY7HMopoFfeSzTZPK5Lb0d169LBi5js33ImzkTgIfg
qtxh1nD7u12owDQTJUUn2YpX0RFvEzcACIOiQw0n6R1kYUzQ5gFnrMUL4AE34ejt
d6sTFpuokpRFwAAT9HSG7zRF5+IMh+N4U9lrfSrZJo7Q6zU2CqxTQxc5w9lUSbVD
hCYEmdBEJrx/swYpNXsnMWvxieyxRpxzXrqu8lv1071Vvnj/PR3Axzzxy8Vvx9O/
pq3Ms+Bn8P9s7bMhVYZ3TUKbfRq3Bv8qeFZOi0zj1L0hewBHVVQUZeLvC9s516ds
JeZEv0uTQiT+TJqZhhAqQ1VN/Ne/Frr23o4o/NFtuc62/Q4gemWv1/2sJts4yq9M
CIWnSFp3Wl1xcDR6q5ceNnMjriEbCHxqP4zOLpVgiHllH61isUJkgbUuF6zV6jOu
+yOOIPv6IIRTkouRigMtSK7jWqGO4ZZXPvEL1hiM1hSxg0s+wWj3agSjcVY7oGV6
e2uccjtthPXkHTHjIaazIVhOt71Ar9nVeW7QyUd0iKATr8qA6pSGU98PEzdKKATt
FbluR0YH6NJGIJy9P8qn
=qp65
-----END PGP SIGNATURE-----

--lUUXqwrWxOF2YlQwEKYTpPRK7KNMnzXBX--

