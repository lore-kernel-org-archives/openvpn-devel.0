References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
Date: Mon, 16 Oct 2017 11:05:22 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
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
To: Selva <selva.nair@...277...>, Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 13/10/2017 20:48, Selva wrote:
> Hi,
>=20
> On Fri, Oct 13, 2017 at 12:55 AM, Simon Rozman <simon@...2293...
> <mailto:simon@...2293...>> wrote:
> ...
>=20
>=20
>     > As said above, I would have replaced all _snwprintf and snwprintf by
>     > swprintf
>     > and avoided the #define. That has the added advantage that mingw bu=
ilds
>     > also will no longer depend on the non-standard snwprintf.
>=20
>     Are you sure MinGW supports swprintf() in an ISO C conformant way?
>     People all
>     over the web complain about MinGW's non-ISO C conformant swprintf()
>     declaration being a legacy of VC 6.0 runtime library used:
>     https://stackoverflow.com/questions/35072373/swprintf-declaration-mis=
match
>     <https://stackoverflow.com/questions/35072373/swprintf-declaration-mi=
smatch>
>     As said before, I am not familiar with MinGW. I read OpenVPN has a
>     patched
>     version of it. Perhaps you moved to a more recent VC runtime library
>     meanwhile.=C2=A0
>=20
>=20
>     If we change _snwprintf/snwprintf() to swprintf() as you suggested, I=
 am
>     afraid OpenVPN would not compile on MinGW anymore without #define
>     tweaks. But,
>     this time MinGW will need them, not MSVC*2017*.
>=20
>=20
> There are two issues here: sprintf signature in Windows runtime and
> mingw-w64's =C2=A0support for the standard conforming variant.
>=20
> @samuli: Which versions of mingw-w64 should we test against to ensure
> release and snapshot builds would succeed?

Right now _we_ use Ubuntu 16.04 for building:

  mingw-w64 4.0.4
  gcc-mingw-w64 5.3.1
  g++-mingw-w64 5.3.1

That said, I'm pretty sure many people still build with Ubuntu 14.04. So
keeping support for it would make sense if it is not horribly painful.
This is what Ubuntu 14.04 comes with:

  mingw-w64 3.1.0
  gcc-mingw-w64 4.8.2
  g++-mingw-w64 4.8.2

Samuli

>=20
> Windows runtime used to have an swprintf that does not take the buffer=C2=
=A0
> size. But to get that non-conformant behaviour you will need some
> preprocessor define like ....NON_CONFORMING_SWPRINTF... so hopefully
> modern VS installations does pick the right function.=C2=A0
>=20
> As for mingw, note that I use mingw-w64, not the older one
> from=C2=A0mingw.org <http://mingw.org>.
> In the former, my understanding is that an implementation based on=C2=A0
> _vsnwprintf is used unless the above NON_CONFORMING.. define is active.
>=20
> Probably there are some old mingw releases where this was broken ---=C2=A0
> I'll test your latest patch. That said, I would not depend on any of these
> for nul-termination, we should continue to append an explicit L'\0'.
>=20
> Selva

