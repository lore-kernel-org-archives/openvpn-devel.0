Reply-To: openvpn-devel@lists.sourceforge.net
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
Date: Mon, 13 Nov 2017 13:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IhReX3uuaIA4L8lkBqb89jjXlaa6VHaDO"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhReX3uuaIA4L8lkBqb89jjXlaa6VHaDO
Content-Type: multipart/mixed; boundary="AoSnD7tvtqJp6i7dKeeFrmg8vJX1UpBWo";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
In-Reply-To: <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>

--AoSnD7tvtqJp6i7dKeeFrmg8vJX1UpBWo
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/11/17 11:15, Steffan Karger wrote:
[...snip...]
>>> You know, the funny thing is that my main reason for implementing JSON
>>> support for status was to have it easily _machine_ readable, for higher
>>> level programming languages where JSON is "first class citizen", and not
>>> primarily human readability. Besides you could easily do this to make
>>> JSON human readable:
>>>
>>> $ cat /path/to/status.json | python -mjson.tool
>>>
>>> Thinking some more about it now, it doesn't really make sense to
>>> implement JSON at all, because CSV _is_ actually meant to be machine
>>> readable and a lot more efficient in the amount of data it uses (much
>>> less duplication). So it seems my reasons for implementing JSON support
>>> seems to completely miss the point. For machine readable output it would
>>> make more sense to use a binary format instead of JSON.
>>>
>>> What do you guys think? Are there any other reasons to implement JSON
>>> support?
>=20
> This was my original question: why should we *add* JSON?  I agree that
> if we would have to pick something now, I'd prefer JSON over CSV.  But
> we already have CSV, and as far as I understand it suffices just fine.

The tooling libraries around JSON vs CSV are more commonly more mature
these days for JSON; plus it is so widely used the interwebs are filled
with examples.  And this does not only go for scripted languages; even
there are also nice libraries for C and C++ too, giving you a machine
parseable object with better predictability on the result.

If I had a project parsing a CSV and had been given a chance to use JSON
instead; I'd migrate over ASAP as long as the risks of breaking
something badly was not very high (It would depend on where in the call
chain such changes happens, and how much happens after that point).

So I'm fine with adding --status 4 which dumps JSON.

>> Although JSON is a bloated language (meaning that there is lots of
>> overhead next to the data itself), I think that it allows you to easily
>> extend the objects being sent back and forth with a fairly high chance
>> to keep backwards compatibility.
>>
>> This is barely true for csv.
>=20
> The biggest difference is that CSV is 'flat' while JSON is
> "hierarchical".  But since we already support CSV (and want to keep
> supporting it, I guess?), I think we're kind of bound to a flat
> structure anyway.

Yeah, we cannot rip out CSV now.  We could probably propose that further
into the future once JSON is widely used.  And we could provide some
tooling which converts JSON to CSV outside of OpenVPN at that time.

>> A binary presentation per se is not bad, but then you need to make sure
>> that the format is properly encoded/decoded (especially if the data is
>> transferred across the network from/to different platforms) and this can
>> be error prone.
>=20
> Slightly offtopic: I recently came across CBOR, which seems a good
> attempt to merge the benefits of JSON with a binary representation:
> https://tools.ietf.org/html/rfc7049
>=20
> Haven't really used it yet though, so no practical experiences
> unfortunately.

I think that if we want to have a binary approach, that should be a
variant of --status 4; like --status 4_binary.

>> Honestly I did not read the rest of the thread, but if this data is
>> supposed to be exposed through an API (i.e. REST API or any other
>> interface) and it is meant to travel across the network, I wouldn't mind
>> seeing the JSON format being used.
>>
>> JSON consumers nowadays are extremely easy to implement compared to othe=
rs.
>=20
> Even compared to CSV?  I can't really come up with a situation where I
> can consume JSON easily, but can't consume CSV.

The library tooling is in my experience far easier and predictable.  And
the JSON libraries have generally been far better at "object-ifying"
JSON to objects you use in your code than what CSV parses have been.
But I'll admit, I've mostly avoided CSV for the last decade or so if I
could use JSON or even XML.

CSV just looks structured - until the layout is changed.  While JSON
(and even XML for that matter, _not_ saying we should have XML support!)
is not strictly bound to the order of fields, so adding new fields is a
no-brainer with JSON compared to CSV.  And before you say "We only
append fields to CSV", some of those changes we have done in the past to
--status 3 have even broken some users setup - because the CSV parser
was stupid.  The risk of that happening to JSON is far less.

>> Regarding the JSON "prettiness", I think that printing it in a nice
>> readable format makes it just extremely easy to debug and possibly spot
>> errors on the fly (even when not searching for them). For this reason
>> I'd rather add a couple of tabs and \n to make it easier to read.
>=20
> +1, one of the strong sides of JSON is that is easy to make it both user
> and machine readable.

+1 from me too.


Just a few words to the management interface vs --status file.  We
should support JSON via both channels.  And implementing that shouldn't
be rocket science as it should be the same function producing that result.

But we should consider if we want to make use of a JSON library
producing the JSON streams.  The reason is to ensure the output is
according to the specification and that escaping if contents is
consistent and proper.  Imagine if someone puts a double-quote into the
CN field of a certificate?

 CN=3D"} Lets explode things, O=3DHacktivist0

Or other characters which needs escaping.

I also see the proposed patch adds "END" at the very end.  To me that
makes more sense in text/plain representations to indicate that this is
the end of a list of unknown length.  JSON have that implicitly with the
last '}'.


Just my few cents for this round :)


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--AoSnD7tvtqJp6i7dKeeFrmg8vJX1UpBWo--

--IhReX3uuaIA4L8lkBqb89jjXlaa6VHaDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCY0uAAoJEIbPlEyWcf3ydlYP/0RXMu8TMTZQNbOzgpwTkiiC
uMmBATwr5G+vzq4IPq7H1YQ5rSQiTP1X1U7U3HZAaK3tlh1bDHXfeJ4VWjpf/QWY
6PP+GN2bTbtt7s+s+4tlbRtz3WMZEiQLsE83jZsTSjvGpTJ5FLu4SfhwD9/+rQc2
weoWfYDOJfRASAP+O/V0F4r+U5vJKiI+E2hXjjN17PfYv9R3/WZuG6WdQm3Y2HTb
GSHW86r/5TRdIqGqymPOlaWpe/KzYIEgWMop+NwcZXVyQSwmH8oVH4PNcQcZ8xtq
Q8mXRfpfSRe6zdvLH9MdHEOiZdbhxfJ0Re6kJ8UgdLSIClqQ6bsJOqgWgwRfzYhJ
/eeqE9iUeHxowRo1jfadPeZceX7/d8iEC9tMlNKg+HE+MpCu4YfuRUbFerpmY9Bt
qckkcJ61fn8oHPbi9QSWYXPU0MUBvFT6KTePdtmIFwaKKgiesSVFXuRZd1dYf+zD
sS5e4TZ8/5micnCYqeusGdmDlF+g04NwBJUjZlGmn3+jZ9CrfMDGgDVzR3Er+op8
S6zbCq1QHzSBFEVJsJZtiRarvoHy07TMw/xkbA+fFmNMq7bjz3mND3nXJ+muPmH2
L0u2fqNonMjTelOYP25dy7NU/hI4zzJRf7Bvb8t8jMdUlFyXK5vTgNjOhw8QiCaI
aMhYvnMLggUsFjRtge3q
=OHQk
-----END PGP SIGNATURE-----

--IhReX3uuaIA4L8lkBqb89jjXlaa6VHaDO--

