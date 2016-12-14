References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
	<8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
	<83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <62fe3714-44f3-73a8-4868-5c72d986d480@...2080...>
Date: Wed, 14 Dec 2016 18:55:53 +0100
MIME-Version: 1.0
In-Reply-To: <83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SpbHb3fVi4mklR7ftV8Wogcs5hGrIn4G1"
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
 disabled
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SpbHb3fVi4mklR7ftV8Wogcs5hGrIn4G1
Content-Type: multipart/mixed; boundary="jLoe8BF1Pdj6lf5xagW3Bmf3VDIkUuOQu";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <62fe3714-44f3-73a8-4868-5c72d986d480@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
	disabled
References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
	<8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
	<83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>
In-Reply-To: <83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>

--jLoe8BF1Pdj6lf5xagW3Bmf3VDIkUuOQu
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/12/16 17:23, Steffan Karger wrote:
> On 14-12-16 16:39, David Sommerseth wrote:
>> On 14/12/16 10:09, Gert Doering wrote:
>>> Hi,
>>
>>> On Wed, Dec 14, 2016 at 10:51:18AM +0200, Lev Stipakov wrote:
>>>> +/* + * Disable async-push if plugins are disabled + */ +#if
>>>> !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH) +#undef
>>>> ENABLE_ASYNC_PUSH +#endif +
>>
>>> That one gets a NAK from me, for the reasons given.
>>
>>> As long as we *have* --enable/--disable options in configure, they
>>> should be validated *there* and not silently ignored.
>>
>>> David's argument about "configure is for finding system dependent
>>> things and compiler settings" has some merits, but then we should
>>> get rid of all compile-time --enable/--disable settings.
>>
>> By this logic should we enforce users to add --disable-def-auth if
>> --disable-plugin is set?  If so, then we should probably also do
>> something with --disable-plugin-auth-pam and
>> --disable-plugin-down-root.  And with --disable-plugin-auth-pam, we
>> need to look at --enable-pam-dlopen as well.
>=20
> No, unless the user specified --enable-def-auth.  And yes, I think it
> would be nice if we would throw an error if the user did.  "Fail-fast"
> is a really good habit.

Well, there is still --enable-pam-dlopen --disable-plugin-auth-pam ...
and what else can we stubmble accross if we try --disable-server?  Or
you don't want to bother about that kind of consistency?

>> And to put things in context of the async-push stuff.  In the C code
>> we already check if --disable-def-auth is enabled or not.
>>
>> If we truly start to look into this for the other options, we will
>> have quite a good job ahead of us.  Otherwise we end up with even more
>> mess where we are not even consistent.
>=20
> Sure, but "The other stuff is broken" is no argument to not add
> something that is not broken.

But it is broken.  The v1 patch compiles just fine with
--enable-async-push --disable-def-auth

$ grep DEF_AUTH ./config.h
/* #undef ENABLE_DEF_AUTH */

And then have a look at multi.c:2214.  This is a key code path for this
feature.  This is behaving exactly how you do not want.  If so, the
current v1 patch need a NAK.

And if you have --enable-async-push --disable-server, that should also
fail.  I want to have some consistency.

Which is why I am saying we do not do such sanity checking in
configure.ac today.

>> I say it again, configure.ac is *NOT* the place to do sanity checks on
>> which openvpn features depends on each-other.  We have not done that
>> before, and we should not do it now.  It just provides far more
>> non-production code to maintain, and more places to look for issues
>> when code we expect to to be compiled in isn't being compiled in.
>> This way leads is a rats nest and will cause much more maintenance
>> burden in the future, which I will not accept lightly.
>=20
> Yes we do.  Just check the mbed TLS pkcs11 checking.  That check has
> saved me some hours of re-running builds at the least.  I wish we had
> more such checks.

And *that* is a correct check, not comparable to --enable-async-push at all.

This check detects that your mbedtls library does not support PKCS#11,
thus it fails to build as it needs that support by default.  The mbedtls
library isn't something you normally build yourself, as that is most
commonly shipped by the distro - so fixing that either requires
disabling PKCS#11 support in OpenVPN or building mbedtls yourself.
Failing to do so will _not_ result in a complete build.


But fair enough, I can fully understand the argument that it shouldn't
turn off things behind your back, and I can understand the "fail fast"
argument too (even though I don't care too much about it in such a small
project as OpenVPN).  But then lets fix it *properly* in a more
consistent way.  And we have #error and #warning which may be used in
such scenarios.

If the general attitude is that we should do all sanity checking via
configure.ac so that ./configure fails on inconsistency, then we need to
do something far better than just fixing --enable-async-push
--disable-{plugins,def-auth,server} variants.  Otherwise we will end up
needing to clean-up configure.ac once again [1].

Perhaps it then is better to have some C code which ./configure builds
at the very end - where we do all kind of #if defined(...) checks based
on ENABLE_* macros defined and bails out with #error or something
similar when something is bad.  Just so we do this sanity check *one
single place* and in a simple manner.  Currently we have some 20
ENABLE_* macros handled by config.h alone.


[1] Last massive clean-up:
    $ git log --stat 8a4eaf5aa6debaca434..0e4b6c455e0236a4eb4 \
          --follow -- configure.ac

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--jLoe8BF1Pdj6lf5xagW3Bmf3VDIkUuOQu--

--SpbHb3fVi4mklR7ftV8Wogcs5hGrIn4G1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUYepAAoJEIbPlEyWcf3yuloQAJcr+yHSI/r4Q2h8TuIlyu72
Kp+rV0/DtBE7nuka33xIetCBtOuFiw4zY5S4zLAMnexvyXsuvF3/zfCD63u/fBS0
OV0AEMNcJbSnxho1y3b5Ol8J7Jn9VbPNkcTugmAvPmS0rlSpn73fKxE93fUhtbgL
92++57uYRZ0wYA9lEbAMUrDiDZDMbrb3Dar80EtCpvE4pAbndSR+4rlwDAIfVH4V
Qgf0gpPNso+KYErwbMV2Gns9US5YBZ2tCvdrVxV7VIHtvwQkWgkSkEAplE9bnacI
FfFBzVL7/Zv1gTTgn8QpIE36qqkvU7BYCAA1rqZwHNz9KJHTFAg1aLKJYquLVtlD
+vxZkaBI5Zl8MQxw3vY39nLYPx0nXXPLqpOri0vaAiwmmcGUwgwaefGBOB65fU2q
tUh//aovr9bNjYd8NEthV3xR7L7ijlmOa66K9u9SJ2AvxzN0nmVS2Am/d+4gay8w
Ln7/qg/jfKjTFL4fhPRUuZ5UB+9qfqEBP1ayQuC+3OnhXTAdKE3g1rYyJAvuJxK4
4XALg4oAW9U/hj9Mr913/9LLp/U50D1/2+nrS7E+l4LHAYWUS/KvNTbAh19qCRPP
f5FT7vegabXOvtKdNzioRbW61qFSkQiJ7/gKV5bVup8bLZODvrwZHaR7YuIjHzzr
bzE+eEfEQjbi9h78g3Ke
=kg6o
-----END PGP SIGNATURE-----

--SpbHb3fVi4mklR7ftV8Wogcs5hGrIn4G1--

