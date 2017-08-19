References: <20170809123256.25694-1-davids@...515...>
 <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
 <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <22e70527-c0a4-8346-032e-4d2142a45823@...1856...>
Date: Sat, 19 Aug 2017 10:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mdvo2f5HVK817aK3WxaS0dIkxsrO0XMVm"
Subject: Re: [Openvpn-devel] [PATCH] tests: Add a simple build sanity check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mdvo2f5HVK817aK3WxaS0dIkxsrO0XMVm
Content-Type: multipart/mixed; boundary="2JpsdNMaajDSNjjrpQNO4JNrda1fujLNN";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <22e70527-c0a4-8346-032e-4d2142a45823@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] tests: Add a simple build sanity check
References: <20170809123256.25694-1-davids@...515...>
 <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
 <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>
In-Reply-To: <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>

--2JpsdNMaajDSNjjrpQNO4JNrda1fujLNN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12-08-17 23:12, David Sommerseth wrote:
> On 12/08/17 12:33, Steffan Karger wrote:
>=20
> [...]
>=20
>>> +check_option_count()
>>> +{
>>> +    num_min=3D"$1"
>>> +    num_max=3D"$2"
>>> +
>>> +    echo -n "Checking if number of options are between $num_min and $n=
um_max ... "
>>> +    optcount=3D"$(cat sanity_check_options.$$ | wc -l )"
>>> +    if [ $optcount -le $num_min ]; then
>>> +        echo "FAIL  (too few, found $optcount options)"
>>> +        count_failure
>>> +        return
>>> +    fi
>>> +    if [ $optcount -gt $num_max ]; then
>>> +        echo "FAIL  (too many, found $optcount options)"
>>> +        count_failure
>>> +        return
>>> +    fi
>>> +    echo "PASS (found $optcount options)"
>>> +}
>>
>> This is quite fragile.  For example, this breaks 'make check' for
>> --disable-crypto builds.  It will also fail easily after adding or
>> removing some options, and we probably have more configure flags that
>> will cause this check to fail.  That's we I don't like it very much.
>=20
> Eeek, so the threshold values are not good enough.  Well, that said, I
> never expected this proposal to get acceptance on the first review :)
> This is just to have a starting point for these checks.
>=20
> Based on how the current option parser is designed, it is hard to get
> this 100% correct.  So I think we need to consider a threshold.  For
> example, my system:
>=20
> $ openvpn --help | grep -E -- '^--'  | wc -l
> 237
> $ grep -E 'if \(streq\(p\[0\], ".*"\) && ' options.c  | wc -l
> 277
>=20
> We might be able to get closer to a realistic number by sending
> options.c via the preprocessor with the right set of "define" arguments.
>=20
> Or to rework the complete option parser to be based on a struct-like
> model where it is easy to write a tool which extracts the number of
> options and which options to expect which can be compared against the
> --help output.  This way we could get a close to 100% perfect match.
> But I don't think doing such a code refactoring shoul be based purely on
> the testing requirements in our case.  The code paths involved are quite
> solid and re-used in almost every possible way by OpenVPN (config files,
> PUSH_REPLY, CCD, CCD via management/plug-ins/script hooks, etc).
>=20
> Or we could get started on moving the man page over to a more parseable
> file format so we could extract options from the man page and compare it
> to --help.  This way we enforce that the man page is up-to-date too.
> And it could make the man-page be generated according to which features
> OpenVPN is built with.
>=20
> Another approach is to make the threshold values (min/max) be based on
> which configure options/defines are enabled - which directly impacts the
> add_option() function in options.c.  So have a baseline of arguments, if
> ENABLE_CRYPTO - add X to the baseline, and so on.
>=20
> I do think this test makes sense, as it can ensure 'make check' fails if
> we do something wonky with options.c.  But I agree it is hard to get it
> right.  So just pondering the alternatives and which ones makes most sens=
e.

All this sounds quite complex.  How about splitting this patch in 2
parts: 1) the return value check and 'must always be present' check, and
2) a more elaborate options check.  This way we can have the simple
checks in soon, and can do the more complex checking later.

As for the solution directions for 2), I think the truly elegant way
would be to redo the options parser and add unit tests.  That's a lot
cleaner than a wrapper script.  But also a lot of work...

> That said, I don't buy the argument that testing options can make 'make
> check' fail if adding/removing options.  To me that is similar to say
> unit tests are bad because they will fail when you change the behaviour
> or API of a function which already have a unit test.  So tests will need
> to be adopted according to the changes done on code it is expected to
> test.  But we can ensure doing those changes in the test-case can be
> done in an easily and understandable way.

Fair point.  Though the check should fail as fast as possible, which in
this case means the counts should be strict.  Otherwise, if I add an
option, and 'make check' doesn't fail on my system, it might fail on
other systems.  This is what I mean when I say I think this approach is
fragile.  I'm afraid we will too often find failures only after
commit-and-push.  And that is annoying to maintain.

-Steffan


--2JpsdNMaajDSNjjrpQNO4JNrda1fujLNN--

--Mdvo2f5HVK817aK3WxaS0dIkxsrO0XMVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZl/vRAAoJEJgCyj0AftKII6cH/jJ5ExxJUcE0JAngfEk3rG3E
Knv4M5IVKhjROliXPmElC5YgeHvfjp9TWs8BdYp6Pgv/PfP+rWxYQ4ik1pu0WW9s
UBnhNofaKqOT8yZPASogFhgwdKAkGiiKxnZpAxRTMIW6NCv/Tk+K0HrjXTGjNn9o
JzvkaXQSmYJMG5URViQiuc7WqtnARDMDE72vCDznop8ASZ9UBv8LdHxtn8X+TmfQ
Y63UbxX21Hg6OSQ2BY4IPQmOGr1Zv1SREk7/YfJ0tRrwSwr9lzFajR5G3Gog0E5i
j67Y0t0qIDapIVGIkt/mSgxMcpL1yls6TjVjLST1nU7H7nVEHxqPYceHD9AWtmE=
=Cd3K
-----END PGP SIGNATURE-----

--Mdvo2f5HVK817aK3WxaS0dIkxsrO0XMVm--

