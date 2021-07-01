References: <zi-Vj2bRDxVU6FgVs0cJcBRxRwZ8B6q5EYNx4g1mHxOg0o5sQneGqWmwMQEwkZ_fcYxWkcTTYPZC7pXDJn6WZQBsS_RyBduPltGkRhsIX2M=@protonmail.com>
 <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5ef18d92-2ba7-f651-52cf-edfbfa9c682a@...2080...>
Date: Thu, 1 Jul 2021 14:41:27 +0200
MIME-Version: 1.0
In-Reply-To: <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hqodRO5i70wfjvchPoiIaEKXBwGm8lJL3"
Subject: Re: [Openvpn-devel] --tmp-dir and systemd PrivateTmp incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hqodRO5i70wfjvchPoiIaEKXBwGm8lJL3
Content-Type: multipart/mixed; boundary="XOiDVzvlCfCVh8US6fT5KNmzIPBbtdETU";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: tincantech <tincantech@...2282...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <5ef18d92-2ba7-f651-52cf-edfbfa9c682a@...2080...>
Subject: Re: [Openvpn-devel] --tmp-dir and systemd PrivateTmp incompatibility
References: <zi-Vj2bRDxVU6FgVs0cJcBRxRwZ8B6q5EYNx4g1mHxOg0o5sQneGqWmwMQEwkZ_fcYxWkcTTYPZC7pXDJn6WZQBsS_RyBduPltGkRhsIX2M=@protonmail.com>
 <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>
In-Reply-To: <P_ZqTHMMD5zv_kUeNix7rzuNV00OT9o2LqrU8BdYhMVaq6j5vdLe5YKK3AS13531enQBYdltUJp8Ks7eNCm3xBBfnWo7t9GGHw526akJXwU=@protonmail.com>

--XOiDVzvlCfCVh8US6fT5KNmzIPBbtdETU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01/07/2021 00:56, tincantech via Openvpn-devel wrote:
> Hi
[... copied from first mail ...]
>=20
> Thus the problem is two fold:
> 1.
> It is not possible to pre-determine a temporary directory within the syst=
emd
> PrivateTmp assigned folder within an openvpn config which needs to use --=
tmp-dir
> 2.
> Openvpn is forced to assign a non-standard temporary folder to --tmp-dir =
which
> lies outside of the systemd assigned private temporary folder.[... second=
 mail ...]
> the problem is three fold:
> 3.
> How would I then point scripts to the systemd assigned folder ?
> (Yet another env var: systemd_private_tmp)
>=20
> The most logical answer is "To take matters into my own hands"
> and specify my own temporary location but that does not sound
> like a "secure" approach generally .. which is the point of using
> systemd to "secure" things, in the first place.

First of all - what you are describing is what you are observing.  But=20
I'm missing the context of when you need a publicly available tmp-dir.

The PrivateTmp is a security hardening.  Using /tmp and /var/tmp to dump=20
various data has been a well-known security issue for years.  And not=20
just within OpenVPN, but all kind of running daemons have faced security=20
challenges with the use of a global tmp-dir.

First some background.

In 2010 we added some hardening to avoid some of the potential issues=20
with tmp-dir and temp-files needed for the script hooks (see commit=20
4e1cc5f6d for details).  Already back then we knew this was not covering=20
all issues, but it was still a good step forward to harden this issue.=20
For those not being satisfied with this change, can use --tmp-dir to=20
relocate this directory with stricter privileges.  That's probably as=20
strict as you can go.

The challenge at hand was that another process could manage to create a=20
tempfile with the same tempname as OpenVPN did earlier, which OpenVPN=20
would pick up and read despite it had not created it (it was the task of=20
the plug-in/script to do so earlier).  This was a perfect trap to inject=20
data from outside, even from a user not privileged to configure OpenVPN.=20
  So we changed the model so OpenVPN always creates the temp-file before=20
it runs the plug-in/script and ensures the privileges on that file is=20
correct.

And then came systemd with PrivateTmp which added further hardening.

That's the background ... now to PrivateTmp

When running scripts via OpenVPN's script hooks or plug-ins, they should=20
run under the same confinement as the OpenVPN process, so it should=20
share the same tmp-dir.  So PrivateTmp should not cause any issues in=20
regards to script hooks or plug-ins.  They should all share the same=20
tmp-dir.  I don't recall now if some $TMP or $TMPDIR variables would be=20
set as well.

Now if you want your scripts to leave data after it has run, a tmp-dir=20
is still the wrong location for such data - as then it isn't strictly a=20
temporary file.  In that case, these scripts should ideally use a=20
different path with is not confined inside a private tmp-dir.

Some reasonable locations:

* Most Linux packaging provides /var/lib/openvpn, which should be owned
   by openvpn:openvpn by default.  Creating a subdirectory here with the
   proper ACL would be considered appropriate.

* If the data you want to leave for another script/process to pick up
   (like a queue), the typical location for that would be /var/spool
   /openpvn (which needs to be created).

* If it is cached data, then /var/cache/openvpn would be appropriate.


* If it is runtime related data, which may be wiped when the OpenVPN
   process is stopped, using /run/openvpn/ would be fine - but these
   days, /run is mostly mounted as a tmpfs filesystem so be careful with
   the amount of data you put there.

My point is, don't use tmp-dir to save data which isn't really=20
temporary, where temporary means it should not live there for very long.=20
  And don't abuse the --tmp-dir option to relocate it to one of these=20
more persistent locations.  Just don't use tmp-dir as a "data exchange=20
point" outside of the communication between the OpenVPN process and the=20
scripts/plug-ins it runs.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--XOiDVzvlCfCVh8US6fT5KNmzIPBbtdETU--

--hqodRO5i70wfjvchPoiIaEKXBwGm8lJL3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmDdt/cACgkQhs+UTJZx
/fKRvA/4rFIi0Ww6tTYplRBoyW7A+rc+RPOeNyGTDFdVT3RvOibJm/fgFn2eND7a
6DOG/iwJJ8pVGzb31P8xIehVQmpXlrPWdkvyzibGs8bwVgbgjuZ/t5isatURFAfd
w073b6QOFXIAm6rQqjRkqYRw7bNxBmt15m2sMBy5ZjVjJ7M5uR4DO5NS2E+Tzysx
ugxSfo0Qt1r4Od2pHWIBiiAi2wyzFoIBvQm3kVYBNjyJAmUPpbkkQk5JhYaShPcB
LUk7djQB+nQSWE1vQIGDpEeEbVzK/G+i+jJIj0Ffdh+Nf/3SLTic/Xv4dG62Y4gL
9hsB0wKJVNmYnikRwz0dTQdWhl2Oh5W2tOT1A9tcpwlq02JKsDjhqim3Kd7uFths
1Bn1jIBIGQk+hOjnEfvVXgw3ZJ6wysOv0bqhQWc5EWpGDynzTWxqgU3ebaNEHtT6
0k2+m75+y7ysgnJ1NEbtoCzoCPC2rOhSAIPqd7/hLEpjANvABXyyiu0nHUYat65O
2kCwVvLdub3Wwc7tSsK3GJhF01Ltrmel8e/U59VjDt08OH/ooaOaeZHZS7Vi9DO/
34zHgvsvnSvCIBAuWZLItm8EilU96mGit7BRib2uyw3pmf4Q1I8JsGVsQvOY7FUN
hGabMzUswRkiIO49rOFJUwR65flhyIPEYfjyz6BIP+mDmrN2dA==
=D5K4
-----END PGP SIGNATURE-----

--hqodRO5i70wfjvchPoiIaEKXBwGm8lJL3--

