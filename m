References: <20170823053054.29982-1-a@...2181...>
 <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ccf26af7-4ce7-7f45-349b-2f6945fa643e@...2181...>
Date: Thu, 7 Sep 2017 21:01:01 +0800
MIME-Version: 1.0
In-Reply-To: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UbjTtms9gr1x14a2T7Vmbq4mRtcGkcdGX"
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UbjTtms9gr1x14a2T7Vmbq4mRtcGkcdGX
Content-Type: multipart/mixed; boundary="6TXCwv6uhPKCBR06VA9uoG7rBPC140xh3";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>
Message-ID: <ccf26af7-4ce7-7f45-349b-2f6945fa643e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
References: <20170823053054.29982-1-a@...2181...>
 <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
In-Reply-To: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>

--6TXCwv6uhPKCBR06VA9uoG7rBPC140xh3
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/09/17 04:45, David Sommerseth wrote:
> On 23/08/17 07:30, Antonio Quartulli wrote:
>> This patch does not introduce any functional change.
>>
>> The code in route.c seems to have been written in different
>> periods by different people, without sticking to a clear
>> codestyle. For this reason the code in this file in not
>> consistent at all.
>>
>> Clean it up by:
>> - removing spaces from function invocations
>> - cutting line longer than 80 chars (where possible)
>> - moving function arguments on the same line when there is enough space
>> - adding empty line between var declarations and code
>> - adding empty line between code and final return
>> - adding empty line to make the code less sticky and easier to parse
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> Yes, this is a quite big patch. However, since we are planning  a big
>> restructuring of the route.c file, it is better to take care of the
>> style in a separate patch (this) so that later we don't need to mixup cl=
eanups
>> and refactoring.
>>
>> Note that this patch is based on master plus the following patches:
>>
>> - ensure function declarations are compiled with their definitions
>> - fix a couple of typ0s in comments and strings
>> - route: avoid definition of unused variables in certain configurations
>> - convert *_inline attributes to bool
>> - reformatting: fix style in crypto*.{c, h}
>> - Allow learning iroutes with network made up of all 0s (only if netbits=
 < 8)
>> - ifconfig-ipv6(-push): allow using hostnames
>>
>>
>> Applying this patch without the above, might lead to screams,
>> natural disasters and endless nightmares.
>=20
> I got it applying quite nicely (working my way through more patches
> now).  And yes, I like that we clean up the coding style further in this
> file.  But unfortunately, I'll have to say NAK in this round.
>=20

I am not sure that what you get by applying this patch without the rest
is 100% correct. But I can rebase this patch on top of master if you are
willing to work on this one before the others mentioned in the patch
message.

> - Many places you replace spaces with tabs.

I must have messed up my vim style file recently. will recheck. Thanks!

> - There are several scenarios where our uncrustify config actually
>   improves your patch further (see the attachment).

Oh ok. I never thought about re-running uncrustify. Thanks for the
suggestion.

> - And the contradictions like the ones below
>=20
>> -static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,=
 unsigned int flags, const struct route_gateway_info *rgi, const struct env=
_set *es);
>> +static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,
>> +			 unsigned int flags,
>> +			 const struct route_gateway_info *rgi,
>> +			 const struct env_set *es);
>=20
> vs
>=20
>>  static void
>> -delete_route(struct route_ipv4 *r,
>> -             const struct tuntap *tt,
>> -             unsigned int flags,
>> -             const struct route_gateway_info *rgi,
>> -             const struct env_set *es)
>> +delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned in=
t flags,
>> +             const struct route_gateway_info *rgi, const struct env_set=
 *es)
>=20
> I think the change you do in the former one is also more readable than
> squeezing everything into as few lines as possible, especially when
> there's lots of arguments.

Honestly I only applied the formal rule "a line should not be longer
than 80 chars". This is what I grasped from our codestyle. Is this not
correct?

In the first case less arguments fit on the first line because of the
return type. In the second case there is more space available.

This is a contradiction given by the codingstyle itself.

Should we use another rule to decide how function declarations and
definitions should look like? I think in the rest of the code we tried
to apply the line length rule too.

Let me know how this should be arranged otherwise (and let's write it in
the codingstyle page) :)

>=20
> Our uncrustify config doesn't touch these details of function
> declarations, as tun.c and route.c is fairly extreme in variations here.
>  So we let that pass on the reformatting patch before the v2.4 release,
> to take care of them manually, as we didn't spend much extra time
> looking at more tweaks for uncrustify to make the result readable.  But
> I'm not sure we documented our preferences on function declarations, I
> don't recall that now.

I couldn't find anything about it in [1]

>=20
> Even though we are not united in the use of uncrustify after the
> reformatting patches we did in December, I think it makes sense to at
> least double check what uncrustify would change and consider those.  The
> lesser the gap is to that result, the easier it will be to have a
> consistent coding style over the complete code base.

Do you think it might be reasonable to document all the rules in the
CodingStyle wikipage?

Running uncrustify does not immediately "teach" what are the rules we
want contributors to follow.

>=20
> For reference, the uncrustify command line I used was:
>=20
>    $ uncrustify -c dev-tools/uncrustify.conf \
>                  --no-backup -l C -p debug.uncr \
>                  src/openvpn/route.c
>=20

Thanks!

--=20
Antonio Quartulli


--6TXCwv6uhPKCBR06VA9uoG7rBPC140xh3--

--UbjTtms9gr1x14a2T7Vmbq4mRtcGkcdGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmxQxEACgkQ0+HICM1s
oFCsCw//RbgGN7wEdcAX22D4hQYDZ21TM3XtzoJYwFsgJdNXUzrZcWrN+zBzzw9G
XYDK6CE8WgtXAZ4kR9HZSr19cR7ugSvSTW5z+HgqmYDkwD5ccscVzRkbQJP72j+y
0+FzMoqY272h+Z8Ue58gG68vRp8sDb0TxRxScx4GdzhYXfKwgaxxV6BnD4TZECkV
az8iBDozSOcauk4uf4vF//1fclAOjfIMNWYrH9Yz/v6ACPQypAjb3eWluHkCZnb/
lF/DwqMtWXjHN8jzPGygh1IwPjtVIASys+yf2IeYXo0nDKFnRVEtGtZTqUUgIbps
dxXxub7EUJS+dkEjitVMM9CpBwhJCZGhgsFI1TaebpSAF9FtHVJ5QuK4OjnXd3MI
HSNt08PszZKCnTjfumYi9jgGejV3KbodVr3zChAlu701BGY1I5wMHC6jMl791iG8
f1Qo7C5Oek3SjAeK5tPCqu1kPuSzoN8LusUMt9McrlOrqPiLTg/5hNTuRErrmzBD
ZIGlEU2fGK4lE9UH7qKM6i0xCHAKrazDq+UwWPOeSLDQNlJLOB8szxwFaWR9rkWG
rGbfYrS3aUUKF3769cpvZsKlmD5RHgyJyEoeL/YR7hr8mzjhL610Kl0dg04SGFBr
B3YpPdgGU3pCjTHwd0trkgGBqXjbaljFUB/cAHUGjFh4Mq2z/9U=
=AQ78
-----END PGP SIGNATURE-----

--UbjTtms9gr1x14a2T7Vmbq4mRtcGkcdGX--

