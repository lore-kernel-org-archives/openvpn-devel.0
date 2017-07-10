References: <20170221192737.24166-1-davids@...515...>
	<20170221192737.24166-4-davids@...515...>
	<24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
	<20170710063017.GE97029@...1296...>
	<d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
	<20170710070707.GG97029@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e0ff2dc2-e006-162b-f560-de6e82a2ea4f@...2181...>
Date: Mon, 10 Jul 2017 15:12:59 +0800
MIME-Version: 1.0
In-Reply-To: <20170710070707.GG97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cf5QF73GtuaxvisspdvAbuH2vbkPmPhDt"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cf5QF73GtuaxvisspdvAbuH2vbkPmPhDt
Content-Type: multipart/mixed; boundary="4gM9c79ks2WxcScarc1TwlheKTth4jKFn";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>,
 openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <e0ff2dc2-e006-162b-f560-de6e82a2ea4f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
References: <20170221192737.24166-1-davids@...515...>
 <20170221192737.24166-4-davids@...515...>
 <24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
 <20170710063017.GE97029@...1296...>
 <d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
 <20170710070707.GG97029@...1296...>
In-Reply-To: <20170710070707.GG97029@...1296...>

--4gM9c79ks2WxcScarc1TwlheKTth4jKFn
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 10/07/17 15:07, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jul 10, 2017 at 02:33:43PM +0800, Antonio Quartulli wrote:
>> On 10/07/17 14:30, Gert Doering wrote:
>>> On Mon, Jul 10, 2017 at 12:31:31PM +0800, Antonio Quartulli wrote:
>>>> Instead of cluttering the code with these ifdefs directly in the main
>>>> codebase, how about doing it in compat.h, like this (it's a copy/paste=
 -
>>>> code might be wrapper by the mail client):
>>>
>>> Better, but I wonder if we shouldn't fix this in configure.ac - "if the
>>> system lz4 is older than what we bundle(*), use our compat-lz4.c instea=
d"
>>>
>>> (*) ... or older than what we need, functionality-wise
>>
>> If we do this, then we jump into the can of worms that David S.
>> mentioned earlier, I think.
>=20
> Uh, what can of worms specifically?  (David mentions lots of worms)
>=20
> #ifdef in the code, or having funny wrapper functions hidden in .h files
> are worms as well - and these two are the ones that make the code hard
> to follow, so there's good reason to judge the trade-offs.
>=20

I was referring to something he said in response to a comment to his v1:

if we use the bundled lz4, we might have a user stuck on our version
even though at some point he decided to update his system-wide lz4
library to a more recent release (maybe because of some security bugs).

The user at that point won't notice that openvpn is still running with
an older release.

>=20
>> Generally speaking, why not just depending on "libX >=3D a.b.c." and err=
or
>> out (at config time) if such lib is not available ?
>>
>> I think many other programs do exactly the same.
>=20
> We are not "many other programs" :-) - and we decided, when we introduced
> lz4, that we want to bundle it as it's not a library installed commonly
> (yet).   And the whole point of "compat-*" stuff is "use it if the system=
 is
> not adequate", without having to be turned-on explicitly.
>=20
> We can change this, and remove the bundled compat-lz4* stuff, but that's =
a=20
> different discussion.

Thanks for the explanation! I wasn't aware how we got to this
configuration :)


anyway, you are right. Deciding the faith of the bundled lib is probably
worth another thread/discussion.


Cheers,


--=20
Antonio Quartulli


--4gM9c79ks2WxcScarc1TwlheKTth4jKFn--

--Cf5QF73GtuaxvisspdvAbuH2vbkPmPhDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlljKPsACgkQ0+HICM1s
oFA1uQ/+KY9V2HVd08MCWjDSFHX+fYlHEKvY00Um9CkVNs3/zj+dKDdAnxdlo7DU
dMEdhA5XpfyFE1Y4Yyj7nhgD/PQXtXsvjNxuuDFwBHgg2jX5ujt+eR3OFy61IIro
qJoLXkCeWEmONvvn2OlBfmN2u8g/WmP9n/R+tRPi4O8szso7ZOtfSUm7QwnwRlDK
JJSWYkIZ+dHBUx/OcjNnyNDWdEU5YWsVL+BbUCWGbRLEkkO+kil6Hp87bVw5Swre
nbbQZEHgB1Z9pO0WDokGcEssSl/GC71Hss9B1z8d4KZIQL+sXFIdsu3oLQvAmT8I
OeewcaWe/gSv0edkLh9whhXvYbVhCJnO8iLSOtbsp8cB2dbzwmZ40zsqp1eJMNwp
m56tziH8BxSn4b6vcmnmjvnMxxSy0mcgYRKme/BGqCzHUqM71PRvX6s4ILmyp9Pt
bDegH/IKr3nhT64RXg6oYBGk7fQlnAwSBMiXn0aQQClm2sM5MSiYyv7T6WORcaPA
D4BrL9oPQjmFwQVZQO8R/ip1p/e975DCz/HAjs9FBrb6MxAzltDLVPN//dHT/vxR
JQjAhzn261ZJmmc0Gjq75ZY45592vwfB0YJbTgishbhQuzi2v0dqeeTRXZkC4tUS
0fWsTwGJi0JcYrX8kln5XOfDEec9/dwRXb2fH6iJ28JVcw62G/4=
=DGtA
-----END PGP SIGNATURE-----

--Cf5QF73GtuaxvisspdvAbuH2vbkPmPhDt--

