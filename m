MIME-Version: 1.0
In-Reply-To: <20161119201238.GA49297@...1296...>
References: <1479569756-23302-1-git-send-email-arne@...1227...>
	<20161119201238.GA49297@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Nov 2016 00:08:26 +0100
Message-ID: <CAA1AbxJyV3ygWAAqQDfL+Hr6B9_=MxBF_XKHaZ7m6LEXEaqmxQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0448f40c8fcc0541af807c
Subject: Re: [Openvpn-devel] [PATCH] Remove compat-stdbool.h.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c0448f40c8fcc0541af807c
Content-Type: text/plain; charset=UTF-8

On 19 Nov 2016 9:13 p.m., "Gert Doering" <gert@...1296...> wrote:
> On Sat, Nov 19, 2016 at 04:35:56PM +0100, Arne Schwabe wrote:
> > Since we use C99, we are guaranteed to have stdbool.h available
> > ---
> >  src/compat/compat-stdbool.h | 12 ------------
> >  src/openvpn/syshead.h       |  2 +-
> >  2 files changed, 1 insertion(+), 13 deletions(-)
> >  delete mode 100644 src/compat/compat-stdbool.h
>
> Meh!  When deleting a whole file, please take into account that this
> might be referenced in "make dist"...
>
> make[3]: *** No rule to make target `compat-stdbool.h', needed by
`distdir'.

Also, I think this means we can remove the check for stdbool.h in
configure.ac.

-Steffan

--94eb2c0448f40c8fcc0541af807c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 19 Nov 2016 9:13 p.m., &quot;Gert Doering&quot; &lt;<a href=3D"mailto:ge=
rt@...1296...">gert@...1296...</a>&gt; wrote:<br>
&gt; On Sat, Nov 19, 2016 at 04:35:56PM +0100, Arne Schwabe wrote:<br>
&gt; &gt; Since we use C99, we are guaranteed to have stdbool.h available<b=
r>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 src/compat/compat-stdbool.h | 12 ------------<br>
&gt; &gt;=C2=A0 src/openvpn/syshead.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +=
-<br>
&gt; &gt;=C2=A0 2 files changed, 1 insertion(+), 13 deletions(-)<br>
&gt; &gt;=C2=A0 delete mode 100644 src/compat/compat-stdbool.h<br>
&gt;<br>
&gt; Meh!=C2=A0 When deleting a whole file, please take into account that t=
his<br>
&gt; might be referenced in &quot;make dist&quot;...<br>
&gt;<br>
&gt; make[3]: *** No rule to make target `compat-stdbool.h&#39;, needed by =
`distdir&#39;.</p>
<p dir=3D"ltr">Also, I think this means we can remove the check for stdbool=
.h in <a href=3D"http://configure.ac">configure.ac</a>.</p>
<p dir=3D"ltr">-Steffan</p>

--94eb2c0448f40c8fcc0541af807c--

