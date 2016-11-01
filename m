References: <1477922488-26941-1-git-send-email-davids@...515...>
	<20161101112812.GJ28918@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>
Date: Tue, 1 Nov 2016 13:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <20161101112812.GJ28918@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="N1QHqRbWI0QT6AO2AhWWeof1Sw1NIlmeT"
Subject: Re: [Openvpn-devel] [PATCH] man: Improve the --keepalive section
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1QHqRbWI0QT6AO2AhWWeof1Sw1NIlmeT
Content-Type: multipart/mixed; boundary="AcDF2oQElCMo11WUH3pUAE65vG1sIqiv0";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ab1e4dae-c231-d48f-4347-a9e7b8c60339@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve the --keepalive section
References: <1477922488-26941-1-git-send-email-davids@...515...>
	<20161101112812.GJ28918@...1296...>
In-Reply-To: <20161101112812.GJ28918@...1296...>

--AcDF2oQElCMo11WUH3pUAE65vG1sIqiv0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/11/16 12:28, Gert Doering wrote:
> Hi,
>=20
> On Mon, Oct 31, 2016 at 03:01:28PM +0100, David Sommerseth wrote:
>> -.B \-\-keepalive n m
>> +.B \-\-keepalive ps pto
>=20
> What does "ps" stand for?  I find this not much clearer than "n"...

> "pto" sounds like "ping time out", which I find halfway understandable.
>=20
> Maybe make the first argument "t" for "time"?=20=20
>=20
> Or "i" and "to" for "interval" and "timeout"?
>=20
> Lots of options for bikeshedding here...

I have no strong opinions here.  I thought pi (ping interval), but
considered to close to 3.1415.... ps wasn't goo either, but that's meant
to be "ping seconds" (poor interval alternative, I agree).  I thought of
pt and pti as well, but thought that could be somewhat confusing with pto.

pto is as you decoded, Ping Time-Out.  I chose 'pto' as just 'to' could
be confusing in the text below ("... timeout is the to argument...").

I also though of 'pin', but that could also be confusing.  Even
considered a proper word, but then the man page needs to be rendered in
a way that these keywords are emphasized (like bold/white). Maybe change
ps to int - as in interval]?  Or pis (ping interval seconds).

The reasoning for changing n and m to something else was in a hope to it
easier to grasp what each of these arguments really meant - and easier
see them in a bigger context.

But I'm very open for other suggestions; I don't care about the bikeshed
colour as long as it is at least a slight improvement of what we have today.


--=20
kind regards,

David Sommerseth


--AcDF2oQElCMo11WUH3pUAE65vG1sIqiv0--

--N1QHqRbWI0QT6AO2AhWWeof1Sw1NIlmeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYGIhTAAoJEIbPlEyWcf3yQMMP/A6rOXKpWSzqnUIWJ7fq0e/R
ADkVyzAFqOAQyGFDXK4wk9r+VaUO+A/EfeA4Myru7PShwBPhREgLmnmJ7YBtJFk/
EibSUufqHzgVMSrOotoq0sw1bs3LHKbPlh3xpwj1dsxgLTejWzA+Tg6CimNHmAOt
frqED7pXJWx7AsyOG/WCQ/Dh6U4Vy/nXyHquRj/W6IYTXOQBtyR8iLGawg3TC4Uj
Jo8VVO0ZpR1NyI5pxbcdbCv6Drp29Xt1Z1BgI8wFLkj/irxPYpolLDs6a5jeCRVY
D1iC1MQM4nDbw3O2C1g1haq2jOq/XPAh8vwS5JzcNe1QdVlhSE0ASUydeSWAWi7K
qHdEZ5m6FAoWYE1+oyTYay1fr/2H8Whv5TPyQO2XrdS/FFz7NngMwLVbI+oxd7YK
8mrj8qcjPvDSXN2wrU0TZfWVTBH/A8kFKWxHVcSYAlcNRCenjqlREh0vLHwyIizD
N4qXlbOdf5OxZsyYKDMR1dui3rRipNdUlXw7iXD79hS3aIPQKDwz9WENuQ2JmRFd
0lvWxKM1FfMoJlvbqGa3dmU6DYRwd0YDyVcRe8m82lS5Xxlmt2qP4OiKgcsZrcrY
O8HPuk/Vd7/ieoINf29cpdU9uHtN1HyIVItpxMZSAa6klSmBMni7VTGEEx8CYl0t
aQyPweGCDZgMgwg1FI/w
=/LhI
-----END PGP SIGNATURE-----

--N1QHqRbWI0QT6AO2AhWWeof1Sw1NIlmeT--

