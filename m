Message-ID: <510D3B74.3060007@...1114...>
Date: Sat, 02 Feb 2013 17:14:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1359815797-23262-1-git-send-email-arne@...1227...>
	<20130202154307.GK953@...1296...>
In-Reply-To: <20130202154307.GK953@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC203B60979A9B5BC240AEA3C"
Subject: Re: [Openvpn-devel] [PATCH] Fix assertion if environment es is null
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC203B60979A9B5BC240AEA3C
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/02/13 16:43, Gert Doering wrote:
> Hi,
>=20
> On Sat, Feb 02, 2013 at 03:36:37PM +0100, Arne Schwabe wrote:
>> The construct_name_value eventually call gc_malloc with NULL as gc which=
 will trigger an assertion
> [..]
>> -      char *str =3D construct_name_value (name_tmp, val_tmp, NULL);
>> +      char *str =3D construct_name_value (name_tmp, val_tmp, &gc);
>>        if (platform_putenv(str))
>>        {
>>          msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
>=20
> NAK!
>=20
> platform_putenv() calls putenv() on non-windows platforms, and that one
> will just add a pointer to the string passed to it to envp[] (at least
> that's how I read the manpage: "The string pointed to by string becomes=20
> part of the environment, so altering the string changes the environment").

Correct ... Please see this thread for more info (including
proof-of-concept code)

<http://thread.gmane.org/gmane.network.openvpn.devel/7090>

> So your environment now points to a garbage buffer, which is then=20
> destroyed again.
>=20
> I think there needs to be a strdup() here...

Yeah, but that would be prone to leak memory again ...

> (And I seem to remember that "some of the buffer functions" did exactly
> this when &gc was NULL, but maybe we threw this out last year... David?)

I think the commit you think about is this one:

commit bee92b479414d12035b0422f81ac5fcfe14fa645
Author: Adriaan de Jong <dejong@...1435...>
Date:   Sun Feb 5 12:51:25 2012 +0100

    Removed support for calling gc_malloc with a NULL gc_arena struct

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

That basically impacted all calls ending up in gc_malloc().  But this
was prone to leak memory when called with NULL as the gc_arena pointer.
 After a discussion, we ended up agreeing to solve issues this patch
would flush open - instead of trying to fix those leaking areas
instantly; then it would just have been a temporary fix until it would
be abused again.


--=20
kind regards,

David Sommerseth


--------------enigC203B60979A9B5BC240AEA3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlENO3QACgkQDC186MBRfroxAgCfZCwY7Xs8bCRLNqZVif/RqjqO
gq0An3Klf0I3hP0gN7chB2HGZcjCFO36
=XiY3
-----END PGP SIGNATURE-----

--------------enigC203B60979A9B5BC240AEA3C--

