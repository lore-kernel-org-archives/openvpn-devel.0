MIME-Version: 1.0
In-Reply-To: <4FAD8A16.6020303@...1400...>
References: <CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<20120511185641.GZ1359@...1296...>
	<4FAD8A16.6020303@...1400...>
Date: Sat, 12 May 2012 00:56:04 +0300
Message-ID: <CAOazyz1dkfwNsAzSF4OXcoMyYezdiJAzH+RMUiqVrAYi7e-ftg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <schwabe@...1400...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sat, May 12, 2012 at 12:52 AM, Arne Schwabe <schwabe@...1400...> wrote:
> Am 11.05.12 20:56, schrieb Gert Doering:
>> Changing the build environment to build a shared library out of openvpn
>> is something I do not fully understand yet, though - and don't view
>> a particular useful goal right now.
> The shared library is not used as real shared library. I build
> libopenvpn as complete library and then build a miniature executable
> that calls the main method of the shared library and therefore exactly
> behaves like openvpn as executable.
>
> The reason for this is that libraries are managed by the android package
> system. For executables I have to carry them as data files and write
> them to a cache partition. By putting the main =C2=A0code into the librar=
y I
> can minimise the amount of data that is written twice to the /data
> parition on Android.
>
> The building as library and using android build system should seen as
> something that is useful for my particular Android application and not
> as a general thing or requirement.
>
> Arne
>

I would like you to try to do so using libtool...

Just replace:
---
sbin_PROGRAMS =3D openvpn
openvpn_SOURCES =3D ....
---
with:
---
lib_LTLIBRARIES =3D openvpn.la
openvpn_la_SOURCES =3D ...
openvpn_la_LDFLAGS =3D \
    -module -shared -avoid-version -no-undefined
---

And add -Dmain=3Dopenvpn_main to AM_CFLAGS.

Alon.

