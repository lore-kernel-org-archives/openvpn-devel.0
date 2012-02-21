MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B90129343318D@...1436...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
	<CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
	<CAOazyz0MzDDGW=A9SnwW2z7HSXW7XMocAvtvr_qKvF65qjbZuA@...278...>
	<1CED409804E2164C8104F9E623B08B90129343318D@...1436...>
Date: Tue, 21 Feb 2012 12:53:14 +0200
Message-ID: <CAOazyz2CRrbmWMUS9we9v-0m_DYToTD9_6pfw4kK36Rc+5brgA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Frank de Brabander <debrabander@...277...>

Hello,

On Tue, Feb 21, 2012 at 12:30 PM, Adriaan de Jong <dejong@...1435...> wrote:
> Hi Alon,
>
> It's great to see a lot of work on the build system. Working with the old=
 system was often a pain, I hope the new system gives some more control and=
 especially flexibility to packagers. Still, I have a few comments/question=
s.

Great!

>
> As lzo support can be seen as one of the "basic features" of OpenVPN, dis=
abling it by default might not be the best approach.

Well, most cases a package management system builds the package.
It explicitly enables/disable features, so we are fine with package
management systems.
Now for manual compilation, there are two approaches:
1. The "detect" approach - even if enable disable if not detected.
2. The "explicit" approach - if enable fail if not found.

I am no fan of the "detect" approach as you never know what you get,
and package management system can build invalid packages.

The question of what to enable by default is opened one. I suggest to
enable the minimum for package to successfully build. But no problem
in adding other defaults.

> That beggars the questions:
>
> =C2=A0- Which other libraries/features are disabled by default in the new=
 build system?

I will fix the documentation at last stage.
Maybe I do this now.
For now you can determine if feature is --enable or --disable. If
--enable it is disabled :)

> =C2=A0- Could you please specify any other behavioural changes in the def=
ault OpenVPN build system? Things like the --with-xxx-headers options disap=
pearing?
>
> It would be nice to have some documentation for packagers as to what has =
changed where, and why. Further, as not everyone knows the "correct" autoto=
ols way of doing things, a little extra information goes a long way in educ=
ating us developers. Merely saying "because it was wrong" is not going to c=
ut it in any community.

Dependencies are detected using pkgconfig if possible.
Overriding can be done by using environment variables.
See ./configure --help for a list of variables.
For example setting LZO_CFLAGS/LZO_LIBS will override LZO specific settings.
If you don't have pkgconfig set PKG_CONFIG=3Dtrue and provide locations
of all libraries. Most libraries will be detected if you place
CFLAGS=3D"-I.../include" and LDFLAGS=3D"-L.../lib" without library
specific settings.

Within the autoconf itself the above has much impact. As instead of
previous proprietary openssl library/header detection there is a much
simpler implementation. So I won't get into details why previous was
wrong.

>
> Perhaps a split into refactoring and functional patches would help there =
too.

I have done this as much as I could.
I don't want to split it farther.

Alon.

