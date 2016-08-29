References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
	<CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <22cfbc88-7a12-f039-ff12-4e1c971de4b0@...2080...>
Date: Tue, 30 Aug 2016 00:20:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
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

On 29/08/16 23:32, Steffan Karger wrote:
> HI,
>=20
> On 29 August 2016 at 23:03, David Sommerseth=20
> <openvpn@...2080...> wrote:
>> On 29/08/16 22:45, David Sommerseth wrote:
>>> On 28/08/16 21:42, Steffan Karger wrote:
>>>> Previously, we would use the compiler's default C version,
>>>> which defaults to gnu89 for GCC < 5, gnu11 for GCC > 5, and
>>>> c11 for clang, but might even differ per distro.
>>>=20
>>>> One of the reasons to accept the gnu89 default of GCC < 4.9,
>>>> was that MSVC didn't support c99.  But in MSVC 2015, MS
>>>> finanally fixed that.
>>>=20
>>>> Having to support c89 in the codebase occasionally forces us
>>>> to write less readable code, for example by forcing all
>>>> declaration to be at the starting of a block (which includes
>>>> 'for loop initial declarations').
>>>=20
>>>> Let's be clear about what standard we obey, and stop
>>>> punishing ourselves with c89/gnu89.  Let's switch the master
>>>> branch to c99.
>>>=20
>>>> Signed-off-by: Steffan Karger <steffan@...1856...> ---=20
>>>> configure.ac | 1 + 1 file changed, 1 insertion(+)
>>>=20
>>>> diff --git a/configure.ac b/configure.ac index
>>>> 9189c94..16cab19 100644 --- a/configure.ac +++ b/configure.ac
>>>> @@ -1125,6 +1125,7 @@ if test "${enable_pkcs11}" =3D "yes";
>>>> then ) fi
>>>=20
>>>> +CFLAGS=3D"${CFLAGS} -std=3Dc99" if test "${enable_pedantic}" =3D=20
>>>> "yes"; then enable_strict=3D"yes" CFLAGS=3D"${CFLAGS} -pedantic"
>>>=20
>>>=20
>>> I so much wants to give this an ACK.  But this breaks CentOS 5=20
>>> builds very badly.  The glibc-headers isn't prepared for C99
>>> on that distro.
>>>=20
>>> I took the latest git master where I could do a successful
>>> build. Then I applied just this patch, and here is the
>>> explosion: <http://paste.fedoraproject.org/417049/14725031/>
>>>=20
>>> To move towards C99, we need to add some tricks which makes
>>> this not requiring users to overwrite C99 with C89.  That
>>> should happen automatically.
>>>=20
>>> Some CentOS 5.11 details: glibc-2.5-123.el5_11.3=20
>>> glibc-headers-2.5-123.el5_11.3 gcc-4.1.2-55.el5=20
>>> openssl-0.9.8e-40.el5_11 lzo-2.02-2.el5.1
>>=20
>> Did a bit more testing.
>>=20
>> -std=3Dgnu89, -std=3Dgnu99 Works very fine (compiles without
>> errors).
>>=20
>> -std=3Dc99 Makes glibc-headers explode, as already described
>>=20
>> -std=3Dc89 Makes the LZ4 library we're shipping explode.
>=20
> Hm, that's too bad.  But I think we should still go for c99,
> rather than gnu99.  That should actually result in *more* portable
> code on our side.  The CentOS package maintainer can then easily
> patch configure.ac (or configure) to use gnu99 for arcane
> platforms.

For the stock CentOS 5 package, it probably won't matter.  That's
indirectly maintained by Red Hat doing all kind of backports whenever
needed.

For the Fedora EPEL releases (which keeps our release cycles fairly
tight), I'm adding Jon to this discussion directly as the main Fedora
package maintainer for OpenVPN.

Any thoughts on this, Jon?


- --=20
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxLU9AAoJEIbPlEyWcf3y+AQP/iuVPJOsfilHtPPa9UP/MHe3
gPf+LrWBQ5YhkvW06MC9dfWRaDSf2PILj6dKG5kj83hdfhv/CcyJZCLYZLlhiaqS
ONxcndskI3geIbAxsx/QCSQ1GghTsc/jwFKcYlrDBq8RA34s0KQBmquKtUyoMX7E
/YldciIuK5hCEr/6+Kx5ekyszceGV6i6RG4+Mevkf6CEHvOgS8NUFhcw2zY++Ook
E1FkSLcrw/yc8HnChIR8z4qvFpvKmQyTQ9mN7/noqSC4rc/ESrWx0sAj48g7be+l
PMfQ94O8au4QYysb9AWFPhX2b23hNJPavMGYbZW07d2ZFs6kRs7I5bPSSkp/Vnxf
3rq27Hmo6pKFxIR/52w9ysNU4vrUVshim9Al2UytgI6+T3ClxWJSGfjaYMd5tCL4
sPyNnQHhjXo2WIxeCIbTTkIUEtVVQit67ZvyU6+aL+S5gB56Nvw+/UORyQfr7hx/
5q7RUvNo65XLVXHXNhoXKSHsSEwiSCQ5oQI71Lvh8omKLcDlKF6LTBIt7p8CBTk1
vD4foQSF8ZW/0FEFIpY9eXEpbLcIZk8wiFHaXS9X6etocw0JXuG+0PHlHxz++0wg
SIX/ql3xAwdEmYo3gK0LzPVy7gjgd4mwSSvudKCQSz1XPVJt0XTn0OitxCA/9IJt
mL5G75qaB4WjsLT4Ot7T
=3DLInq
-----END PGP SIGNATURE-----

