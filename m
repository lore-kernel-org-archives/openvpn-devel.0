References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
Date: Mon, 13 Nov 2017 17:54:21 +0800
MIME-Version: 1.0
In-Reply-To: <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OnFqKdDWQegLa5ph7H1bOHowIFIBDUro2"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>, Gert Doering <gert@...1296...>, Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OnFqKdDWQegLa5ph7H1bOHowIFIBDUro2
Content-Type: multipart/mixed; boundary="H6A4sWC1S9WvsGq7tmD87dqX9Gd5FHSSn";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>,
 Gert Doering <gert@...1296...>, Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
In-Reply-To: <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>

--H6A4sWC1S9WvsGq7tmD87dqX9Gd5FHSSn
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/11/17 17:44, Fran=E7ois Kooman wrote:
> On 11/12/2017 10:42 PM, Gert Doering wrote:
>> On Sun, Nov 12, 2017 at 12:21:06PM -0500, Selva wrote:
>>> One of the niceties of JSON is its readability which is greatly reduced
>>> if formatted without line breaks.=20
>>
>> +1
>>
>> the difference in efficienty is not large, but "human readability for
>> manual proofreading" is good.
>=20
> Selva, Gert,
>=20
> You know, the funny thing is that my main reason for implementing JSON
> support for status was to have it easily _machine_ readable, for higher
> level programming languages where JSON is "first class citizen", and not
> primarily human readability. Besides you could easily do this to make
> JSON human readable:
>=20
> $ cat /path/to/status.json | python -mjson.tool
>=20
> Thinking some more about it now, it doesn't really make sense to
> implement JSON at all, because CSV _is_ actually meant to be machine
> readable and a lot more efficient in the amount of data it uses (much
> less duplication). So it seems my reasons for implementing JSON support
> seems to completely miss the point. For machine readable output it would
> make more sense to use a binary format instead of JSON.
>=20
> What do you guys think? Are there any other reasons to implement JSON
> support?

Although JSON is a bloated language (meaning that there is lots of
overhead next to the data itself), I think that it allows you to easily
extend the objects being sent back and forth with a fairly high chance
to keep backwards compatibility.

This is barely true for csv.

A binary presentation per se is not bad, but then you need to make sure
that the format is properly encoded/decoded (especially if the data is
transferred across the network from/to different platforms) and this can
be error prone.


Honestly I did not read the rest of the thread, but if this data is
supposed to be exposed through an API (i.e. REST API or any other
interface) and it is meant to travel across the network, I wouldn't mind
seeing the JSON format being used.


JSON consumers nowadays are extremely easy to implement compared to others.


Regarding the JSON "prettiness", I think that printing it in a nice
readable format makes it just extremely easy to debug and possibly spot
errors on the fly (even when not searching for them). For this reason
I'd rather add a couple of tabs and \n to make it easier to read.

my2cents


Cheers,




--=20
Antonio Quartulli


--H6A4sWC1S9WvsGq7tmD87dqX9Gd5FHSSn--

--OnFqKdDWQegLa5ph7H1bOHowIFIBDUro2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloJa80ACgkQB6U8WA7y
zXRy1g/+Kyx1kUl+nIjTSh6/9KmUe+KK3PWOGG4LgEIozRv9HwDLBhrHYJOG06I7
EDo7RGt96IUP2hrCiDXDZazAS2rU2Jzl7J5KzpY6en640uow9z7wy7fyQpGVQ4xl
2n4pICE8mLbyBg2YDGGDoay1A7ytJpmSijATXulQnT+aFlKQOWZY2q7vRIwR5YrD
2bWQRXddtC3l3NySNj+o17oKiC6aXDJFJvSYWMsuGyhnffQpPhcYIADIvBuwm04U
fSvFuPukI3oDI2RHXD5tpYOPdBaWZrAF+3J8FCZQHsKnR4QU5C4J2M6qoX255WVS
MRMYSGq9SF1vcpMjO0w/7wP89YDwxZJMOW6gyGVzLhPkad6GqpWSvo1fzXoO0fjj
MKSe6BgFU/9n5eoCMOxnWadwB9gcpKidt7IX3dZgNDXZluFD58ldcThVNZ5qvWi0
CJlRGOKI6Pe6dKNk9ozkb+IfICQTVQ5y1aTN9fQFregtMH8BBobNYm1rOlw8sqgr
jYe4PhkrOM7jCvsw4OzQMef4KNcyC8IN70+KKjmD7BoIAkh8/B+7uPhMDcHGGDgM
ir+f/V15fZCe58x8L1IN0+k6BFjMpPGISFpMVGkFTTIQMyzjpkXvx/4klfr+fXb1
ZV6qNTlETDAB/yIXWtBcd0zaQggpIi1dkuhXzssqGR12IQW65KM=
=YkN/
-----END PGP SIGNATURE-----

--OnFqKdDWQegLa5ph7H1bOHowIFIBDUro2--

