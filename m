MIME-Version: 1.0
In-Reply-To: <20160607144127.GY53051@...1296...>
References: <CAFHpkQFkm-6FUUs8DN63UKKHCPHZBmLDK1fk60xaycUk3K5GSQ@...278...>
	<CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
	<CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
	<45ec7635-8bb5-f811-9b8b-4713091d79ee@...515...>
	<20160607144127.GY53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Jun 2016 11:39:49 -0400
Message-ID: <CAKuzo_ip973aaydzrOR=4xUvwyO05HqYbQTNjRxDgkFV=fD_mg@...278...>
Content-Type: multipart/alternative; boundary=001a114dd8deffd4940534b200ff
Subject: Re: [Openvpn-devel] Valgring findings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114dd8deffd4940534b200ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 7, 2016 at 10:41 AM, Gert Doering <gert@...1296...> wrote:

> On Tue, Jun 07, 2016 at 05:33:07PM +0300, Samuli Sepp=C3=A4nen wrote:
> > > I played with valgrind a bit
> > >
> > > https://travis-ci.org/chipitsine/openvpn/jobs/135869065
> > >
> > > Looks like there are leaks in openssl code, should we suppress it?
> >
> > I can't comment on the leaks themselves, but I wonder if it would make
> > sense to run OpenVPN under Valgrind in "make check". For example, when
> > using the Vagrant test VMs the loss of performance would not be a big
> > deal - the tests would just run quite a bit longer.
>
> Unless you can whitelist certain findings, valgrind output will be LONG
> (as can be seen in the URL above), and we can't do anything about memory
> lost by OpenSSL etc. - so it's just long output of random numbers, which
> nobody will bother to look at.


Not everything that valgrind reports is really a leak. Not to say valgrind
is not useful -- quite the contrary, and we find it very useful to catch
leaks in our number-crunching codes all the time.

Running valgrind with --leak-check=3Dfull --show-reachable=3Dyes as in the =
link
above would generate too much of not so useful output. In fact the output
was longer than the 10K limit of travis. Use --leak-check=3Dsummary, leave
out --show-reachable=3Dyes, and keep show-leak-kinds at its default (i.e
definite and possible leaks only). Then, if there are errors that look real
one could locally check with --leak-check=3Dfull. In any case, suppress
still-reachable warnings.

All those  "errors" seen in openssl are "still reachable" blocks which is
not a leak.

Selva

--001a114dd8deffd4940534b200ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 7, 2016 at 10:41 AM, Gert <span class=3D"" id=3D":7wu.1" tabind=
ex=3D"-1">Doering</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1711...=
96..." target=3D"_blank"><span class=3D"" id=3D":7wu.2" tabindex=3D"-1">ger=
t</span>@<span class=3D"" id=3D":7wu.3" tabindex=3D"-1">greenie</span>.<spa=
n class=3D"" id=3D":7wu.4" tabindex=3D"-1">muc</span>.<span class=3D"" id=
=3D":7wu.5" tabindex=3D"-1">de</span></a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><span class=3D"">On Tue, Jun 07, 2016 at 05:33:07PM +0300, Samuli Sepp=
=C3=A4nen wrote:<br>
&gt; &gt; I played with valgrind a bit<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/13586906=
5" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org/chipitsine/op=
envpn/jobs/135869065</a><br>
&gt; &gt;<br>
&gt; &gt; Looks like there are leaks in openssl code, should we suppress it=
?<br>
&gt;<br>
&gt; I can&#39;t comment on the leaks themselves, but I wonder if it would =
make<br>
&gt; sense to run OpenVPN under Valgrind in &quot;make check&quot;. For exa=
mple, when<br>
&gt; using the Vagrant test VMs the loss of performance would not be a big<=
br>
&gt; deal - the tests would just run quite a bit longer.<br>
<br>
</span>Unless you can whitelist certain findings, valgrind output will be L=
ONG<br>
(as can be seen in the URL above), and we can&#39;t do anything about memor=
y<br>
lost by OpenSSL etc. - so it&#39;s just long output of random numbers, whic=
h<br>
nobody will bother to look at.</blockquote></div><br>Not everything that <s=
pan class=3D"" id=3D":7wu.6" tabindex=3D"-1">valgrind</span> reports is rea=
lly a leak. Not to say <span class=3D"" id=3D":7wu.7" tabindex=3D"-1">valgr=
ind</span> is not useful -- quite the contrary, and we find it very useful =
to catch leaks in our number-crunching codes all the time.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Running <span class=
=3D"" id=3D":7wu.8" tabindex=3D"-1">valgrind</span> with --leak-check=3Dful=
l --show-reachable=3Dyes as in the link above would generate too much of no=
t so useful output. In fact the output was longer than the 10K limit of <sp=
an style=3D"background-color:rgb(255,255,0)">travis</span>. Use --leak-chec=
k=3Dsummary, leave out --show-reachable=3Dyes, and keep show-leak-kinds at =
its default (i.e definite and possible leaks only). Then, if there are erro=
rs that look real one could locally check with --leak-check=3Dfull. In any =
case, suppress still-reachable warnings.=C2=A0</div><div class=3D"gmail_ext=
ra"><br></div><div class=3D"gmail_extra">All those =C2=A0&quot;errors&quot;=
 seen in <span class=3D"" id=3D":7wu.12" tabindex=3D"-1">openssl</span> are=
 &quot;still reachable&quot; blocks which is not a leak.=C2=A0</div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span class=3D"" i=
d=3D":7wu.13" tabindex=3D"-1">Selva</span></div><div class=3D"gmail_extra">=
<br></div></div>

--001a114dd8deffd4940534b200ff--

