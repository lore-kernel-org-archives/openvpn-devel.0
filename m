References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
 <CAFHpkQEgjmdRgMaOC-1-6vRqjYTUoC6fODtcx2yZt0DJUPGcsw@...278...>
 <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
 <CAFHpkQHQC0eacftzVAnzt4068C0_9VzBZ6CH7Cxksa-Sus-pBQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <aa37ff4b-7809-d7d9-3f6e-25bd09b1ebb1@...515...>
Date: Tue, 17 Oct 2017 16:43:47 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHQC0eacftzVAnzt4068C0_9VzBZ6CH7Cxksa-Sus-pBQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva <selva.nair@...277...>
Cc: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 16/10/2017 20:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-10-16 20:33 GMT+05:00 Selva <selva.nair@...277...
> <mailto:selva.nair@...277...>>:
>=20
>=20
>     Hi=C2=A0
>=20
>     On Mon, Oct 16, 2017 at 4:22 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
>     <mailto:chipitsine@...277...>> wrote:
>=20
>=20
>=20
>         2017-10-16 13:05 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>         <mailto:samuli@...515...>>:
>=20
>             On 13/10/2017 20:48, Selva wrote:
>=20
>             > @samuli: Which versions of mingw-w64 should we test against=
 to ensure
>             > release and snapshot builds would succeed?
>=20
>             Right now _we_ use Ubuntu 16.04 for building:
>=20
>             =C2=A0 mingw-w64 4.0.4
>             =C2=A0 gcc-mingw-w64 5.3.1
>             =C2=A0 g++-mingw-w64 5.3.1
>=20
>             That said, I'm pretty sure many people still build with
>             Ubuntu 14.04. So
>             keeping support for it would make sense if it is not
>             horribly painful.
>             This is what Ubuntu 14.04 comes with:
>=20
>             =C2=A0 mingw-w64 3.1.0
>             =C2=A0 gcc-mingw-w64 4.8.2
>             =C2=A0 g++-mingw-w64 4.8.2
>=20
>=20
>         I'm afraid, it's not possible to build openvpn with
>         mingw-gcc-4.8.X due to lack of firewall manipulation api
>         (that's why we use xenial repo during travis-ci build)
>=20
>=20
>     Good to know mingw-w64 from xenial is used in the travis-ci script.
>     =C2=A0
>     I did a quick test on ubuntu=C2=A0trusty (14.04.05 LTS), =C2=A0and as=
 you
>     pointed out, it fails while
>     compiling block_dns.c because of some errors in the headers for the
>     windows filtering platform API. All the bits are there so its
>     possible to build
>     after tweaking the installed headers (only a couple of lines) but
>     not something
>     one would normally want to do.
>=20
>     It does look like targeting 14.04 is no more relevant.
>=20
>=20
> it used to work on 14.04 ... with patched debs (header issue is
> relatively easy to fix)
>=20
> however, it does not work now because of not supporting Vista things
>=20
>=20
> yes, 16.04 is just fine
> =C2=A0

I'm fine with dropping support for the Ubuntu 14.04 version of
mingw-w64, as the unpatched version does not work anyways. Better keep
code at the OpenVPN end as simple as possible.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

