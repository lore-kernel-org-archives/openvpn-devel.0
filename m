Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170809123256.25694-1-davids@...515...>
 <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>
Date: Sat, 12 Aug 2017 23:12:08 +0200
MIME-Version: 1.0
In-Reply-To: <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7pf2cFodd4FOQqcKxKNi1imGOApLfB7ND"
Subject: Re: [Openvpn-devel] [PATCH] tests: Add a simple build sanity check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7pf2cFodd4FOQqcKxKNi1imGOApLfB7ND
Content-Type: multipart/mixed; boundary="ShonbjQUo4R2Vl6Rm0qWLHtQCP8CW00nH";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <466551cd-ab70-72b4-00a6-0d4ef12bfa3f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] tests: Add a simple build sanity check
References: <20170809123256.25694-1-davids@...515...>
 <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>
In-Reply-To: <7a76d766-5349-ec0d-2a08-e15f9fd3f01f@...1856...>

--ShonbjQUo4R2Vl6Rm0qWLHtQCP8CW00nH
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/08/17 12:33, Steffan Karger wrote:
[...]
>> ---
>>  tests/Makefile.am       |   2 +-
>>  tests/t_sanity_check.sh | 118 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>=20
> t_sanity_check is less descriptive than the t_usage proposed by Ilya.
> (Sanity check could be anything, while we specifically test the usage
> output.)


Fair point.  I tried to avoid t_usage, as it also checks for a segfault
(which is where this all started).  But when thinking of it, it does
strictly tests usage*() for segfault.  I can switch back to t_usage.

[...]

>> +check_option_count()
>> +{
>> +    num_min=3D"$1"
>> +    num_max=3D"$2"
>> +
>> +    echo -n "Checking if number of options are between $num_min and $nu=
m_max ... "
>> +    optcount=3D"$(cat sanity_check_options.$$ | wc -l )"
>> +    if [ $optcount -le $num_min ]; then
>> +        echo "FAIL  (too few, found $optcount options)"
>> +        count_failure
>> +        return
>> +    fi
>> +    if [ $optcount -gt $num_max ]; then
>> +        echo "FAIL  (too many, found $optcount options)"
>> +        count_failure
>> +        return
>> +    fi
>> +    echo "PASS (found $optcount options)"
>> +}
>=20
> This is quite fragile.  For example, this breaks 'make check' for
> --disable-crypto builds.  It will also fail easily after adding or
> removing some options, and we probably have more configure flags that
> will cause this check to fail.  That's we I don't like it very much.

Eeek, so the threshold values are not good enough.  Well, that said, I
never expected this proposal to get acceptance on the first review :)
This is just to have a starting point for these checks.

Based on how the current option parser is designed, it is hard to get
this 100% correct.  So I think we need to consider a threshold.  For
example, my system:

$ openvpn --help | grep -E -- '^--'  | wc -l
237
$ grep -E 'if \(streq\(p\[0\], ".*"\) && ' options.c  | wc -l
277

We might be able to get closer to a realistic number by sending
options.c via the preprocessor with the right set of "define" arguments.

Or to rework the complete option parser to be based on a struct-like
model where it is easy to write a tool which extracts the number of
options and which options to expect which can be compared against the
--help output.  This way we could get a close to 100% perfect match.
But I don't think doing such a code refactoring shoul be based purely on
the testing requirements in our case.  The code paths involved are quite
solid and re-used in almost every possible way by OpenVPN (config files,
PUSH_REPLY, CCD, CCD via management/plug-ins/script hooks, etc).

Or we could get started on moving the man page over to a more parseable
file format so we could extract options from the man page and compare it
to --help.  This way we enforce that the man page is up-to-date too.
And it could make the man-page be generated according to which features
OpenVPN is built with.

Another approach is to make the threshold values (min/max) be based on
which configure options/defines are enabled - which directly impacts the
add_option() function in options.c.  So have a baseline of arguments, if
ENABLE_CRYPTO - add X to the baseline, and so on.

I do think this test makes sense, as it can ensure 'make check' fails if
we do something wonky with options.c.  But I agree it is hard to get it
right.  So just pondering the alternatives and which ones makes most sense.

That said, I don't buy the argument that testing options can make 'make
check' fail if adding/removing options.  To me that is similar to say
unit tests are bad because they will fail when you change the behaviour
or API of a function which already have a unit test.  So tests will need
to be adopted according to the changes done on code it is expected to
test.  But we can ensure doing those changes in the test-case can be
done in an easily and understandable way.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--ShonbjQUo4R2Vl6Rm0qWLHtQCP8CW00nH--

--7pf2cFodd4FOQqcKxKNi1imGOApLfB7ND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZj28oAAoJEIbPlEyWcf3yztsP/RHkcaG7xiy1Z0LfFSJYJfKk
ZKtz29RnTZLARZvZIHMPXDzpU2oSQGG+dClPVYdPkQj4JizfGUNmBtdcu3wNY61a
gpldcr1PFZAdF9dhlwhYo+2RPP1t20JT99Itnm9ZQt6gUMx4on/rhTVsHNBuP+3+
uSNRYzW/AjGjEWFeRHwKTPtFn2JFFT0npjje3fHAKjNCmuLpnRtIMIwQzs+17bVi
LgEEJ4xp2cAaZ8dVmDA8aZFUk7xnCKsKgySL3MJv8eWbR2Zj0rNLvpZTEDZISbMW
KLWlYW6Y7/vVauv3etVtkQVP3+h5Ful1uGK1GVXDGj9xOjMV6OVWlnj8tKePF26V
2rZdSB3iqxKJ5f+USGBy6d/2A1j7qREqMcb84qhP6S835yux97MAzh/Z+5SXg42E
7bceFO8pwk95Dfi/WQqDiemqqf7PXCe4DpinSzba3hw+qgXVbiVt2e+Dl6VXFORV
PWbrNXW05Lk9LztQNgIfyNu7l509ZuAOnCUpVk8cBCVU358k/wXcM1biJjZWuj8X
hKxk1sRng1MMc6wb5Bbjo7fP212CWNjuAk9UBjA1aEmtK4WcPn47PiuWuJFP50b0
pAr7rK9LmM4/6LleXqkVlcUeNeR4mtjtLm7sjzlY/DcVafS056drZMZ89P8a9+P/
ILFQI2WZhzhzJNQsm0Gv
=B1pB
-----END PGP SIGNATURE-----

--7pf2cFodd4FOQqcKxKNi1imGOApLfB7ND--

