References: <20200914115706.11066-1-davids@...515...>
 <20200915205254.32605-1-davids@...515...>
 <20200916134803.GD976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cc1d7398-9d51-14d9-4503-00cf92975952@...2080...>
Date: Wed, 16 Sep 2020 16:24:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200916134803.GD976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KH0BVxHpQ84rYfgafARFloVKspHayBe5E"
Subject: Re: [Openvpn-devel] [PATCH v3] sample-plugins: Partially
 autotoolize the sample-plugins build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KH0BVxHpQ84rYfgafARFloVKspHayBe5E
Content-Type: multipart/mixed; boundary="T10RUA7p90JoN9Xushle2mBr6WHo3g8Cf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <cc1d7398-9d51-14d9-4503-00cf92975952@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] sample-plugins: Partially autotoolize
 the sample-plugins build
References: <20200914115706.11066-1-davids@...515...>
 <20200915205254.32605-1-davids@...515...>
 <20200916134803.GD976@...1296...>
In-Reply-To: <20200916134803.GD976@...1296...>

--T10RUA7p90JoN9Xushle2mBr6WHo3g8Cf
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

[resent from proper address]

On 16/09/2020 15:48, Gert Doering wrote:
> Hi,
>
> On Tue, Sep 15, 2020 at 10:52:54PM +0200, David Sommerseth wrote:
>> ---
>> v2 - Process README files with correct instructions and details
>> v3 - Add missing -I$(top_srcdir)/include and explicitly state GNU Make
>>      requirement
>
> Unfortunately, we need a v4... stupid me...

Nah, we share the blame here ... I forgot about the builddir variant.  Which
is very well documented in the automake documentation.

> For in-tree builds, it is working:
>
> cc -c -o simple/simple.o -Wall -Wno-unused-parameter -Wno-unused-function=
 -g
-O2 -std=3Dc99 -I../.. -I../../include -fPIC simple/simple.c
> cc  -shared -fPIC -o simple/simple.so simple/simple.o
> rm simple/simple.o
>
> For out of tree builds, it is still failing:
>
> cc -c -o simple/simple.o -Wall -Wno-unused-parameter -Wno-unused-function=
 -g
> -O2 -std=3Dc99 -I../../../openvpn -I../../../openvpn/include -fPIC ../../=
..
> /openvpn/sample/sample-plugins/simple/simple.c
> ../../../openvpn/sample/sample-plugins/simple/simple.c:37:10: fatal error:
>       'openvpn-plugin.h' file not found
> #include "openvpn-plugin.h"
>          ^~~~~~~~~~~~~~~~~~
>
> because "openvpn-plugin.h" is not actually to be found in the source
> tree, but it's generated at compile time - so "-I../../include" will
> find it.
>
> The other -I should maybe also be "-I../.."?  What is it looking for
> in the $(top_builddir)?  The only .h file in $(top_builddir) is
> "config-msvc.h" - config.h is in "../.."
>

This is actually covered in the AM_CPPFLAGS docs here:
<https://www.gnu.org/software/automake/manual/html_node/Program-Variables.h=
tml>

I'll submit a v4 fixing this.


--=20
kind regards,

David Sommerseth
OpenVPN Inc




--T10RUA7p90JoN9Xushle2mBr6WHo3g8Cf--

--KH0BVxHpQ84rYfgafARFloVKspHayBe5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfYiAhAAoJEIbPlEyWcf3yp5gQAJuLBgYsuKxEvEPZA5Qm7piu
nMh8qIEUoFDGWHXcEhT7RtgB0BC8GRvAIGS+ZHvS+bbJZorPOhXTOVhR3wewM5Ll
qHQtlHFS9/pCLgSwvowm0h8BgxbuVtms9mFXTUwlKnd4M/jV4hy0K9UedXmlsq63
LEHM3qV5rhrpqwsk7obtmhn7+SKiJdpatQlbEIUIqCbuKCKLb5b8ySXmKBqvIG/D
g1DDUDMycng5T0Q833TZlVzVS6p6WQUTuWh1F4tXOwnPb5kW8Z7N+kPBFPPxvKgc
1HAmCycc3lBRux5h0wrTRplC9eGSe8pzx3NVMIhXJVafxJiz0Pf80gcM6kE7PmbT
Jrbg4x/wvkDzMPwIrNl204R34R1OaIFylb9OxgDVaV8n6phi4yEzjqHMeyJPT+0M
usLdb+McKkOaVzUcPfX5PG8gUCt5ErBG3q7o5o9DN6CG20IkPGGV+tX+FVonhR5S
HR1TKpZ6U/j/SfASPq7Dgwhxy6FmBGRajJpXPiH4LODP0+VvIH+K1x3Vn5OxoH+7
nI27zTxnEF3eMjr10e6UIGmYDZjNVubOhGoEtgt5XUCucNtT57T9I8kOgrFxLVqp
KmDkZnO8yN5fm4ZlZSwj/ol1RCFuD1tsnrz2VYqNe4xMymw/TVvHuoig2Uo+f9M6
s8vfi7LFzOVsnOh+T6Wk
=vnn2
-----END PGP SIGNATURE-----

--KH0BVxHpQ84rYfgafARFloVKspHayBe5E--

