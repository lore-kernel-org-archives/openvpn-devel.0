MIME-Version: 1.0
In-Reply-To: <20171203185407.GK69387@...1296...>
References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_h9kcCyDFqdyS50yeCt10n7jdjXm1Qmae+cVjWqYGrhUA@...278...>
 <20171203185407.GK69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 3 Dec 2017 14:19:19 -0500
Message-ID: <CAKuzo_gksuz3JF7fVY=S+0K+1Se_0zjBSxQNsP3zCjcbEP+TCg@...278...>
Content-Type: multipart/alternative; boundary="001a114ff326ba807e055f747b5b"
Subject: Re: [Openvpn-devel] [PATCH v2] ifconfig-ipv6(-push): allow using
 hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114ff326ba807e055f747b5b
Content-Type: text/plain; charset="UTF-8"

On Sun, Dec 3, 2017 at 1:54 PM, Gert Doering <gert@...1296...> wrote:

> Hi,,
>
> On Sat, Dec 02, 2017 at 11:38:28PM -0500, Selva Nair wrote:
> > Responding to this old version just to be on record.
> >
> > I realized patch this was assigned to Gert on patchwork too late after
> > started responding on my own. Sorry for jumping the gun. Have to make
> > keeping an eye on patchwork a habit..
> >
> > I'll leave the latest v4 alone.

If that is the consequence of assigning patches to people on patchwork,
> we should stop doing so (Antonio, are you listening? :-) ).


I didn't want to step on anyone's toes... But based on Antonio's
explanation,
I take that remark back. Will look into v4 as soon as I get some time to
test it.


> Obviously
> the patch was in dire need of a good review, and if you have time while
> I am busy with family things, this is more than welcome.
>
> Voluntarily *taking* a patch for review is useful as a flag "I'm going to
> handle this", but third-party-tagging "this is for Gert!" seems to have
> potential for backfiring, so maybe we shouldn't do that, then.


Agreed. I just didn't realize Antonio delegated it to you and assumed
all "delegation" are indications that the person has volunteered to look
into it. As for me, I totally welcome others reviewing something I delegated
to myself, or commenting/criticizing/extoling (or tipping :) my reviews
(multiple reviews are indeed great).

But I wouldn't particularly want others delegating work to me :)
So let's continue the practice of delegating to self, not to others.
We can always use the list (or IRC for those who frequent the channel)
for requesting reviews etc.

Best,

Selva

--001a114ff326ba807e055f747b5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Dec 3, 2017 at 1:54 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,,<br>
<span class=3D""><br>
On Sat, Dec 02, 2017 at 11:38:28PM -0500, Selva Nair wrote:<br>
&gt; Responding to this old version just to be on record.<br>
&gt;<br>
&gt; I realized patch this was assigned to Gert on patchwork too late after=
<br>
&gt; started responding on my own. Sorry for jumping the gun. Have to make<=
br>
&gt; keeping an eye on patchwork a habit..<br>
&gt;<br>
&gt; I&#39;ll leave the latest v4 alone.</span>=C2=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">If that is the consequence of assigning patches to pe=
ople on patchwork,<br>
we should stop doing so (Antonio, are you listening? :-) ).=C2=A0 </blockqu=
ote><div><br></div><div>I didn&#39;t want to step on anyone&#39;s toes... B=
ut based on Antonio&#39;s explanation,</div><div>I take that remark back. W=
ill look into v4 as soon as I get some time to test it.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Obviously<br>
the patch was in dire need of a good review, and if you have time while<br>
I am busy with family things, this is more than welcome.<br>
<br>
Voluntarily *taking* a patch for review is useful as a flag &quot;I&#39;m g=
oing to<br>
handle this&quot;, but third-party-tagging &quot;this is for Gert!&quot; se=
ems to have<br>
potential for backfiring, so maybe we shouldn&#39;t do that, then.</blockqu=
ote><div><br></div><div>Agreed. I just didn&#39;t realize Antonio delegated=
 it to you and assumed</div><div>all &quot;delegation&quot; are indications=
 that the person has volunteered to look</div><div>into it. As for me, I to=
tally welcome others reviewing something I delegated</div><div>to myself, o=
r commenting/criticizing/extoling (or tipping :) my reviews=C2=A0</div><div=
>(multiple reviews are indeed great).</div><div><br></div><div>But I wouldn=
&#39;t particularly want others delegating work to me :)=C2=A0</div><div>So=
 let&#39;s continue the practice of delegating to self, not to others.</div=
><div>We can always use the list (or IRC for those who frequent the channel=
)</div><div>for requesting reviews etc.</div><div><br></div><div>Best,</div=
><div><br></div><div>Selva</div></div></div></div>

--001a114ff326ba807e055f747b5b--

