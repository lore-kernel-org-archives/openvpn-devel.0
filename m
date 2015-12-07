MIME-Version: 1.0
In-Reply-To: <20151207071641.GR24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<20151207071641.GR24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Dec 2015 10:31:39 -0500
Message-ID: <CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
Content-Type: multipart/alternative; boundary=089e012298ecd889c70526508e19
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e012298ecd889c70526508e19
Content-Type: text/plain; charset=UTF-8

Hi,

If it was such a sucker, I wouldn't have posted it :)

The innards of an autoconf macro could be unnerving, but please try it.

On Mon, Dec 7, 2015 at 2:16 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Dec 06, 2015 at 07:01:46PM -0500, Selva Nair wrote:
> > This adds a macro file with a permissive license. Its small so I don't
> > mind inlining the macro into configure.ac if that is preferred.
> > -------8<--------
>
> This looks interesting, but I'm not convinced that this actually *works* -
> the reason why I had to add an explicit compile test is that the standard
> configure.ac test will claim "inet_pton is not there" because the way
> the test program is built conflicts with the definitions in wstcpip.h
>

I saw that commit in master after I wrote the macro. The commit works well,
but a macro makes it scalable. There is no reason to force define HAVE_POLL
in
windows when it doesn't really have poll etc.. Not that it matters in the
current code..

Why AC_CHECK_FUNC doesnt detect inet_ntop or many other winsock functions
is because
(i) the function name is redefined in the header (inet_ntop is actually
InetNtopA in the librray)
(ii) declared as stdcall.

AC_CHECK_FUNC essentially does
char symbol();
main() { (void) symbol(); return}

That "char  trick" has served us for years, but was never designed to
handle either of those two situations. Note AC_FUNC_CHECK, like most most
autoconf macros, provide only heuristics -- a symbol with that name exists
in the linked libraries, kind of..

AC_CHECK_DECL would detect inet_pton etc., because it only looks for the
declaration in a header. The macro I submitted works almost exactly like
AC_CHECK_DECL but defines HAVE_symbol instead of HAVE_DECL_symbol.


>
> Which environments did you test this on?  It needs to work on mingw as
>

I use debian jessie, but it should work elsewhere.


> shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 14.04
> (inet_pton, *and* the definition its using conflicts with our compat/
> libraries, so a false negative will fail later) and cygwin.
>
> It's not pretty, but it's the way it is for a reason :-)
>
> > +          [AC_TRY_COMPILE([#include <$2>], [(void) $1;],
>
> This is wrong on multiple levels, actually
>

Its the AC_CHECK_DECL way of testing for a symbol. One could replace the
COMPILE with a LINk and it will still work, though that doesn't test
anything more than the copile in this case.

Note that its not (void) $1(), its just (void) $1.

If you prefer I can rewrite the macro completely in terms of AC_CHECK_DECL

Selva

--089e012298ecd889c70526508e19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">If it was such a sucker, I wouldn=
&#39;t have posted it :)</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">The innards of an autoconf macro could be unnerving, but=
 please try it.=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mon, Dec 7, 2015 at 2:16 AM, Gert Doering <span dir=3D"ltr">&l=
t;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1wz" class=
=3D"a3s" style=3D"overflow:hidden">Hi,<br>
<span class=3D""><br>
On Sun, Dec 06, 2015 at 07:01:46PM -0500, Selva Nair wrote:<br>
&gt; This adds a macro file with a permissive license. Its small so I don&#=
39;t<br>
&gt; mind inlining the macro into <a href=3D"http://configure.ac" rel=3D"no=
referrer" target=3D"_blank">configure.ac</a> if that is preferred.<br>
&gt; -------8&lt;--------<br>
<br>
</span>This looks interesting, but I&#39;m not convinced that this actually=
 *works* -<br>
the reason why I had to add an explicit compile test is that the standard<b=
r>
<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">config=
ure.ac</a> test will claim &quot;inet_pton is not there&quot; because the w=
ay<br>
the test program is built conflicts with the definitions in wstcpip.h<br></=
div></blockquote><div><br></div><div>I saw that commit in master after I wr=
ote the macro. The commit works well,=C2=A0</div><div>but a macro makes it =
scalable. There is no reason to force define HAVE_POLL in=C2=A0</div><div>w=
indows when it doesn&#39;t really have poll etc.. Not that it matters in th=
e current code..</div><div><br></div><div>Why AC_CHECK_FUNC doesnt detect i=
net_ntop or many other winsock functions is because</div><div>(i) the funct=
ion name is redefined in the header (inet_ntop is actually InetNtopA in the=
 librray)</div><div>(ii) declared as stdcall.</div><div><br></div><div>AC_C=
HECK_FUNC essentially does</div><div>char symbol();</div><div>main() { (voi=
d) symbol(); return}</div><div><br></div><div>That &quot;char =C2=A0trick&q=
uot; has served us for years, but was never designed to handle either of th=
ose two situations. Note AC_FUNC_CHECK, like most most autoconf macros, pro=
vide only heuristics -- a symbol with that name exists in the linked librar=
ies, kind of..</div><div><br></div><div>AC_CHECK_DECL would detect inet_pto=
n etc., because it only looks for the declaration in a header. The macro I =
submitted works almost exactly like AC_CHECK_DECL but defines HAVE_symbol i=
nstead of HAVE_DECL_symbol.<br></div><div>=C2=A0=C2=A0<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><div id=3D":1wz" class=3D"a3s" style=3D"overflow:hidden=
">
<br>
Which environments did you test this on?=C2=A0 It needs to work on mingw as=
<br></div></blockquote><div><br></div><div>I use debian jessie, but it shou=
ld work elsewhere.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v id=3D":1wz" class=3D"a3s" style=3D"overflow:hidden">
shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 14.04<br>
(inet_pton, *and* the definition its using conflicts with our compat/<br>
libraries, so a false negative will fail later) and cygwin.<br>
<br>
It&#39;s not pretty, but it&#39;s the way it is for a reason :-)<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [AC_TRY_COMPILE([#include &lt;$2&g=
t;], [(void) $1;],<br>
<br>
</span>This is wrong on multiple levels, actually</div></blockquote><div><b=
r></div><div>Its the AC_CHECK_DECL way of testing for a symbol. One could r=
eplace the COMPILE with a LINk and it will still work, though that doesn&#3=
9;t test anything more than the copile in this case.</div><div><br></div><d=
iv>Note that its not (void) $1(), its just (void) $1.</div><div><br></div><=
div>If you prefer I can rewrite the macro completely in terms of AC_CHECK_D=
ECL=C2=A0</div><div><br></div><div>Selva</div><div>=C2=A0</div><div><br></d=
iv></div><br></div></div>

--089e012298ecd889c70526508e19--

