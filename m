MIME-Version: 1.0
In-Reply-To: <576DA4D1.1040909@...2080...>
References: <20160624140526.GV79504@...1296...>
	<CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
	<20160624152932.GW79504@...1296...>
	<576D59FE.90507@...2080...>
	<20160624173327.GX79504@...1296...>
	<576DA4D1.1040909@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 25 Jun 2016 00:50:32 -0400
Message-ID: <CAKuzo_hOs9sLgNXr3R0yTP6bf9RJhR+xy58dKfZ5Miy9r9r-+Q@...278...>
Content-Type: multipart/alternative; boundary=001a1149d7ca227d360536130891
Subject: Re: [Openvpn-devel] brainstorming: t_client system test equivalent
 for windows?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149d7ca227d360536130891
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 24, 2016 at 5:23 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 24/06/16 19:33, Gert Doering wrote:
> >> > We might also consider if there are possibilities for us to integrate
> >> > such tests with Travis or similar stuff for platforms where that is
> >> > possible.  Often these solutions have Python or Ruby modules
> available too.
> >
> > While totally interesting, how is this going to help with *Windows*
> > testing (which is what this thread is about)?
>
> Having a standardised testing framework makes it possible to run a
> similar set of tests (comparable to what t_client.sh does today) in an
> automated way across multiple platforms, and can report these results to
> a shared hub.  This way we can run automated tests and catch regressions
> which is not caught by our current buildbots ... such as the Windows
> platform.


Python may be better than perl and a cross-platform choice like that may
reduce duplication, but lets not forget the primary objective here, viz.,
 system level testing to catch bugs during development. For windows that
means we should run tests through the management interface (as that's what
the GUI uses), test use of  keystrokes for signals, interactive service
 etc., unlike unix for which all current tests are run through command line
control running with sudo, I suppose. Some bugs show up only when the
management is active (or the other way) and is important to catch those as
the GUI uses the management.

The way I test patches for windows is by manually running a number of
clients with hand-edited configs against a few servers - - one tcp, one udp,
one with user-auth, challenge-response enabled etc. This is indeed painful,
error-prone and never comprehensive enough. Obviously, automated tests
would be of great help, but I do not think a port of the current t_client
scripts  to windows is that useful.

At least in the short-term, a windows-specific perl or python or powershell
or whatever script using the management interface looks like the way to go.
A single cross-platform scripting framework could be a longer-term goal.

Selva

--001a1149d7ca227d360536130891
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 24, 2016 at 5:23 PM, David <span class=3D"" id=3D":1oy.1" tabin=
dex=3D"-1">Sommerseth</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:openvp=
n@...2080..." target=3D"_blank"><span class=3D"" id=3D":1oy.2" tabindex=3D"=
-1">openvpn</span>@sf.lists.<span class=3D"" id=3D":1oy.3" tabindex=3D"-1">=
topphemmelig</span>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><span class=3D"">On 24/06/16 19:33, Gert Doering wrote:<br>
&gt;&gt; &gt; We might also consider if there are possibilities for us to i=
ntegrate<br>
&gt;&gt; &gt; such tests with Travis or similar stuff for platforms where t=
hat is<br>
&gt;&gt; &gt; possible.=C2=A0 Often these solutions have Python or Ruby mod=
ules available too.<br>
&gt;<br>
&gt; While totally interesting, how is this going to help with *Windows*<br>
&gt; testing (which is what this thread is about)?<br>
<br>
</span>Having a standardised testing framework makes it possible to run a<b=
r>
similar set of tests (comparable to what t_client.sh does today) in an<br>
automated way across multiple platforms, and can report these results to<br>
a shared hub.=C2=A0 This way we can run automated tests and catch regressio=
ns<br>
which is not caught by our current buildbots ... such as the Windows<br>
platform.</blockquote><div>=C2=A0</div></div>Python may be better than <spa=
n class=3D"" id=3D":1oy.4" tabindex=3D"-1">perl</span> and a cross-platform=
 choice like that may reduce duplication, but lets not forget the primary o=
bjective here, viz., =C2=A0system level testing to catch bugs during develo=
pment. For windows that means we should run tests through the management in=
terface (as that&#39;s what the GUI uses), test use of =C2=A0keystrokes for=
 signals, interactive service =C2=A0etc., unlike <span class=3D"" id=3D":1o=
y.6" tabindex=3D"-1">unix</span> for which all current tests are run throug=
h command line control running with <span class=3D"" id=3D":1oy.7" tabindex=
=3D"-1">sudo</span>, I suppose. Some bugs show up only when the management =
is active (or the other way) and is important to catch those as the GUI use=
s the management.</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">The way I test patches for windows is by manually running a num=
ber of clients with hand-edited <span class=3D"" id=3D":1oy.8" tabindex=3D"=
-1">configs</span> against a few servers - - one <span class=3D"" id=3D":1o=
y.9" tabindex=3D"-1">tcp</span>, one <span class=3D"" id=3D":1oy.10" tabind=
ex=3D"-1">udp</span>, one with user-<span class=3D"" id=3D":1oy.11" tabinde=
x=3D"-1">auth</span>, challenge-response enabled etc. This is indeed painfu=
l, error-prone and never comprehensive enough. Obviously, automated tests w=
ould be of great help, but I do not think a port of the current t_client sc=
ripts =C2=A0to windows is that useful. =C2=A0</div><div class=3D"gmail_extr=
a"><br></div><div class=3D"gmail_extra">At least in the short-term, a windo=
ws-specific <span class=3D"" id=3D":1oy.12" tabindex=3D"-1">perl</span> or =
python or <span class=3D"" id=3D":1oy.13" tabindex=3D"-1">powershell</span>=
 or whatever script using the management interface looks like the way to go=
. A single cross-platform scripting framework could be a longer-term goal.<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span =
class=3D"" id=3D":1oy.14" tabindex=3D"-1">Selva</span></div></div>

--001a1149d7ca227d360536130891--

