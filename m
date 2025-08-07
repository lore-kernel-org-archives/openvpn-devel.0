MIME-Version: 1.0
References: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q.ref@...278...>
 <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
 <aJQ9IkQIdH6sFNvt@...1296...>
In-Reply-To: <aJQ9IkQIdH6sFNvt@...1296...>
From: Jon Chiappetta <root@...2904...>
Date: Thu, 7 Aug 2025 10:29:43 -0400
Message-ID: <CAOh3LPPhraQGp+N2RPPkJ01D64JGpU8ZeT6-Rqkh8fo8M=83zQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a1989063bc74a5a"
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
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

--0000000000008a1989063bc74a5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh nice, thanks, I didn't know about that command as I have never ran it
myself before. I'll try to work through these errors and figure out how to
solve them:

root@...2048...:tmp/openvpn-fork-bulk# autoreconf -vif
autoreconf: export WARNINGS=3D
autoreconf: Entering directory '.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
autoreconf: configure.ac: tracing
autoreconf: configure.ac: not using Libtool
autoreconf: configure.ac: not using Intltool
autoreconf: configure.ac: not using Gtkdoc
autoreconf: running: /usr/bin/autoconf --force
configure.ac:470: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:471: error: possibly undefined macro: AC_LIBTOOL_RC
configure.ac:472: error: possibly undefined macro: AC_PROG_LIBTOOL
autoreconf: error: /usr/bin/autoconf failed with exit status: 1

I also updated my commit/branch/pull-request as I forgot during the
implementation to free the extra allocated buffers which is a bad mistake.
I had made a mental note of it initially but got distracted trying to
optimize and organize and find any edge cases I may have missed along the
way!

Thanks again :)
Jon C




On Thu, Aug 7, 2025 at 1:44=E2=80=AFAM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Aug 06, 2025 at 07:50:16PM -0400, Jon Chiappetta via Openvpn-devel
> wrote:
> > I was still working on looking into some potential limited access to
> > gerrit. I manually ported the diff from the 2.6 source code I was able =
to
> > compile and run with over to the generalized master branch which doesn't
> > contain any configure/makefile so I am not able to build/run that versi=
on
> > at the moment (untested).
>
> git clone $master_url $workdir
> cd $workdir
> autoreconf -vif
> ./configure
>
> gert
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--0000000000008a1989063bc74a5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh nice, thanks, I didn&#39;t know about that command as I=
 have never ran it myself before. I&#39;ll try to work through these errors=
 and figure out how=C2=A0to solve them:<div><br></div><div>root@...2048...:=
tmp/openvpn-fork-bulk# autoreconf -vif<br>autoreconf: export WARNINGS=3D<br=
>autoreconf: Entering directory &#39;.&#39;<br>autoreconf: <a href=3D"http:=
//configure.ac">configure.ac</a>: not using Gettext<br>autoreconf: running:=
 aclocal --force -I m4<br>autoreconf: <a href=3D"http://configure.ac">confi=
gure.ac</a>: tracing<br>autoreconf: <a href=3D"http://configure.ac">configu=
re.ac</a>: not using Libtool<br>autoreconf: <a href=3D"http://configure.ac"=
>configure.ac</a>: not using Intltool<br>autoreconf: <a href=3D"http://conf=
igure.ac">configure.ac</a>: not using Gtkdoc<br>autoreconf: running: /usr/b=
in/autoconf --force<br><a href=3D"http://configure.ac:470">configure.ac:470=
</a>: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL<br>=C2=A0 =C2=
=A0 =C2=A0 If this token and others are legitimate, please use m4_pattern_a=
llow.<br>=C2=A0 =C2=A0 =C2=A0 See the Autoconf documentation.<br><a href=3D=
"http://configure.ac:471">configure.ac:471</a>: error: possibly undefined m=
acro: AC_LIBTOOL_RC<br><a href=3D"http://configure.ac:472">configure.ac:472=
</a>: error: possibly undefined macro: AC_PROG_LIBTOOL<br>autoreconf: error=
: /usr/bin/autoconf failed with exit status: 1<br></div><div><br></div><div=
>I also updated my commit/branch/pull-request as I forgot during the implem=
entation to free the extra allocated buffers which is a bad mistake. I had =
made a mental note of it initially but got distracted trying to optimize an=
d organize and find any edge cases I may have missed along the way!</div><d=
iv><br></div><div>Thanks again :)</div><div>Jon C</div><div><br></div><div>=
<br></div><div><br></div></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 7, 2025 at 1:44=
=E2=80=AFAM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-=
left-color:rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Aug 06, 2025 at 07:50:16PM -0400, Jon Chiappetta via Openvpn-devel =
wrote:<br>
&gt; I was still working on looking into some potential limited access to<b=
r>
&gt; gerrit. I manually ported the diff from the 2.6 source code I was able=
 to<br>
&gt; compile and run with over to the generalized master branch which doesn=
&#39;t<br>
&gt; contain any configure/makefile so I am not able to build/run that vers=
ion<br>
&gt; at the moment (untested). <br>
<br>
git clone $master_url $workdir<br>
cd $workdir<br>
autoreconf -vif<br>
./configure<br>
<br>
gert<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--0000000000008a1989063bc74a5a--

