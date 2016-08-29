References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
	<CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
	<22cfbc88-7a12-f039-ff12-4e1c971de4b0@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c99aa195-c433-4843-dde2-789a636572d4@...2080...>
Date: Tue, 30 Aug 2016 00:41:00 +0200
MIME-Version: 1.0
In-Reply-To: <22cfbc88-7a12-f039-ff12-4e1c971de4b0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Jon Ciesla <limburgher@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/08/16 00:20, David Sommerseth wrote:
> On 29/08/16 23:32, Steffan Karger wrote:
>> HI,
>=20
>> On 29 August 2016 at 23:03, David Sommerseth=20
>> <openvpn@...2080...> wrote:
>>> On 29/08/16 22:45, David Sommerseth wrote:
>>>> On 28/08/16 21:42, Steffan Karger wrote:
>>>>> Previously, we would use the compiler's default C version,=20
>>>>> which defaults to gnu89 for GCC < 5, gnu11 for GCC > 5,
>>>>> and c11 for clang, but might even differ per distro.
>>>>=20
>>>>> One of the reasons to accept the gnu89 default of GCC <
>>>>> 4.9, was that MSVC didn't support c99.  But in MSVC 2015,
>>>>> MS finanally fixed that.
>>>>=20
>>>>> Having to support c89 in the codebase occasionally forces
>>>>> us to write less readable code, for example by forcing all=20
>>>>> declaration to be at the starting of a block (which
>>>>> includes 'for loop initial declarations').
>>>>=20
>>>>> Let's be clear about what standard we obey, and stop=20
>>>>> punishing ourselves with c89/gnu89.  Let's switch the
>>>>> master branch to c99.
>>>>=20
>>>>> Signed-off-by: Steffan Karger <steffan@...1856...> ---=20
>>>>> configure.ac | 1 + 1 file changed, 1 insertion(+)
>>>>=20
>>>>> diff --git a/configure.ac b/configure.ac index=20
>>>>> 9189c94..16cab19 100644 --- a/configure.ac +++
>>>>> b/configure.ac @@ -1125,6 +1125,7 @@ if test
>>>>> "${enable_pkcs11}" =3D "yes"; then ) fi
>>>>=20
>>>>> +CFLAGS=3D"${CFLAGS} -std=3Dc99" if test "${enable_pedantic}" =3D
>>>>>  "yes"; then enable_strict=3D"yes" CFLAGS=3D"${CFLAGS}
>>>>> -pedantic"
>>>>=20
>>>>=20
>>>> I so much wants to give this an ACK.  But this breaks CentOS
>>>> 5 builds very badly.  The glibc-headers isn't prepared for
>>>> C99 on that distro.
>>>>=20
>>>> I took the latest git master where I could do a successful=20
>>>> build. Then I applied just this patch, and here is the=20
>>>> explosion: <http://paste.fedoraproject.org/417049/14725031/>
>>>>=20
>>>> To move towards C99, we need to add some tricks which makes=20
>>>> this not requiring users to overwrite C99 with C89.  That=20
>>>> should happen automatically.
>>>>=20
>>>> Some CentOS 5.11 details: glibc-2.5-123.el5_11.3=20
>>>> glibc-headers-2.5-123.el5_11.3 gcc-4.1.2-55.el5=20
>>>> openssl-0.9.8e-40.el5_11 lzo-2.02-2.el5.1
>>>=20
>>> Did a bit more testing.
>>>=20
>>> -std=3Dgnu89, -std=3Dgnu99 Works very fine (compiles without=20
>>> errors).
>>>=20
>>> -std=3Dc99 Makes glibc-headers explode, as already described
>>>=20
>>> -std=3Dc89 Makes the LZ4 library we're shipping explode.
>=20
>> Hm, that's too bad.  But I think we should still go for c99,=20
>> rather than gnu99.  That should actually result in *more*
>> portable code on our side.  The CentOS package maintainer can
>> then easily patch configure.ac (or configure) to use gnu99 for
>> arcane platforms.
>=20
> For the stock CentOS 5 package, it probably won't matter.  That's=20
> indirectly maintained by Red Hat doing all kind of backports
> whenever needed.
>=20
> For the Fedora EPEL releases (which keeps our release cycles
> fairly tight), I'm adding Jon to this discussion directly as the
> main Fedora package maintainer for OpenVPN.
>=20
> Any thoughts on this, Jon?

Just some more benchmarks.  I just compiled successfully with -std=3Dc99
on an old Scientific Linux 6.5 (RHEL 6.5 clone) I found.  Another
important detail, RHEL5 will reach the "End of Production" phase March
2017, OpenVPN have generally stopped supporting the oldest RHEL
releases once it hits EOL.  RHEL 5 subscribers may purchase an
extended life cycle, but we have not cared too much about that so far.


There is one detail though regarding the patch itself.  Your patch
adds -std=3Dc99 to the CFLAGS quite early.  The compile line gets quite
interesting if you try to swap this setting by using the recommended
approach:

   ./configure CFLAGS=3D"$CFLAGS -std=3Dgnu89"

Doing this results in the command line being run during compilation to
be be:  gcc -std=3Dgnu89 .... -std=3Dc99 ...

So the -std argument appears twice.  This should probably be avoided.


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxLn8AAoJEIbPlEyWcf3yX3MP/32L01BOFDWYh9xfi0veAoFY
6E+H8cn3HrtLDCfc+Um8k1osd/lCcJFhBQeaaolBD1RBlG9sEf0rjAqUXQnFCge2
m+26AyZ9IDDuT0b1QsMRo9z1fuAtigOKcrHrYRAtUZ/4Q7KiWp32wdzQ52S2NsMQ
er9yd1MwpZ11uevfyYE9i0uRUPIFyCQ3JCYo695MS/q1iHaWjsbS33Wwb6+3uy2p
QibLSJdgH1NmLwPIaHZwRYX1TTdRNSdqt/5IGjUk5QgixFQuKQlCILKJ9Ps5HVVL
gohF/cugP19/31FCmmWMtJ0l+i9D8QI04aNvEbxqYbi5LWth0thvr41jh4KPMF+i
TnUinfeYfJG1MqvXAc2cbOfQIWQV4HuXZaSqSOqkTNNYnq296cUkLOnV3wN5v/d+
dfQDeVjEex2Zy+w3SaWNA4fIs02PfwTKbK76M8zTIteyGYCOoe3JS1dMmDxg8wrx
5s2uAG9idjXFsG1rLaIn6XMiaZSPaPy1evsEet64FIodTREhqVaSD2x0zCQc1wyY
GdAgVmNp3bRnahXleVU6XbkfueHZYS/C1rPejP0iJAXM/P3r376Stcm9b/uFI/uV
o55SY2A+gsYDDGa+T/b0O82K4CVAJrSeA6VIWa5bRf9WoQXjdSUtkXQ0W0A2ZpAy
HOBruoR1qGfk9e3iMp1F
=3DCoFe
-----END PGP SIGNATURE-----

