MIME-Version: 1.0
In-Reply-To: <CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
	<CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
Date: Mon, 26 Mar 2012 20:14:50 +0200
Message-ID: <CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:02 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On Mon, Mar 26, 2012 at 7:55 PM, Gert Doering <gert@...1296...> wrote:
>> Hi,
>>
>> On Mon, Mar 26, 2012 at 07:51:01PM +0200, Alon Bar-Lev wrote:
>>> The benefit is to divide the code into libraries and core which is
>>> easier to maintain and reuse.
>>
>> I'm not sure I understand what's so hard about "compile stuff, use
>> 'ar' to pack into libopenvpn.a" that stuff needs more convolutions.
>>
>> We're not building a shared library - which I agree is major pains unless
>> handled by libtool. =C2=A0But static libraries are easy on about everyth=
ing
>> (except Windows, can't speak about that).
>
> libtool has the advantage of making it very simple as far as build is
> maintenance is, in all platforms in exact same way.
> It also will enable us to build the plugins properly in future.
> Even if you do what you suggested (ar), the gcc command-line will be
> long as we need to add the additional CPPFLAGS, LDFLAGS.

The
---
".deps/status.Tpo" -c -o status.o status.c;  then mv -f
".deps/status.Tpo" ".deps/status.Po"; else rm -f ".deps/status.Tpo"
---

Are for dependency tracking, so that if you change a file dependencies
will be recompiled... This was the same in previous build.

So we had:
---
gcc -DHAVE_CONFIG_H -I.   -I. -I/usr/kerberos/include    -g -O2 -MT
status.o -MD -MP -MF .deps/status.Tpo -c -o status.o status.c
---

And now:
---
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include
-I../../src/compat      -I/usr/include -I/usr/include     -g -O2 -MT
status.o -MD -MP -MF ".deps/status.Tpo" -c -o status.o status.c;  then
mv -f ".deps/status.Tpo" ".deps/status.Po"; else rm -f
".deps/status.Tpo"; exit 1; fi
---

What this makes sure is that if compile fails the dependencies is removed..=
..
Delta:
---
if (.*);  then mv -f ".deps/status.Tpo" ".deps/status.Po"; else rm -f
".deps/status.Tpo"; exit 1; fi
---

Not worth dropping the comfort of libtool and manually code toolchain
commands just to remove this delta.

>>> Anyway, new automake does support silent rules, try the following[1]
>>> patch and see if it makes you happier.
>>
>> This is missing the point: I think what automake/autoconf is doing now
>> is much too complicated. =C2=A0I *like* to see what it's doing, and hidi=
ng
>> complexity by just not showing it is a step into the wrong direction.
>
> When you like, use "make V=3D1", or --disable-silent-rules to configure.
>
>>
>>> Again, this demonstrate how current merge procedure is inappropriate,
>>> as instead of single build system rewrite merge we have aftershocks.
>>> Branch should be tested and =C2=A0reviewed, and tested and reviewed unt=
il
>>> no known issues found, and all happy of its quality.
>>
>> We're doing that now: branch is called "master".
>
> Nope, this is not the rule of "master" branch.
> "master" =3D as much stable as possible, not playground.
>
> Alon.

