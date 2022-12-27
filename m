MIME-Version: 1.0
References: <20210907223126.8440-1-selva.nair@...277...>
 <202212270831.2BR8VUQ3085016@...2054...>
 <CAKuzo_jAq3Roq_HfR_WOmVW1OWcPKa-h0JGSYF8=4xC1VW1ukA@...278...>
 <Y6s4pog4C22Sb+uY@...1296...>
In-Reply-To: <Y6s4pog4C22Sb+uY@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 27 Dec 2022 13:49:53 -0500
Message-ID: <CAKuzo_gKJUjbyUV0BZV=FzFb-nsTO_AhAKj2t8qQJ1s=PR923g@...278...>
Content-Type: multipart/alternative; boundary="0000000000009334cb05f0d3b888"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add remote-count and
 remote-entry query via management
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

--0000000000009334cb05f0d3b888
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 27, 2022 at 1:25 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Dec 27, 2022 at 01:18:02PM -0500, Selva Nair wrote:
> > My test implementation in the GUI constructs the list when first >REMOTE
> > query is received. If there is no >REMOTE from the daemon, the feature is
> > not used. That works.
>
> So what's the magic --option to make openvpn query for >REMOTE?
>

--management-query-remote


> (My understanding of the management interface details is limited... I just
> happen to stumble across things here and there :-) )
>
> > That said, making these commands work from management-hold would have
> been
> > nice, but looked harder to implement -- we need a callback to get the
> > context in management.c, but callbacks are initialized late.
>
> Yes, definitely looked like it.  But if OpenVPN queries for >REMOTE
> voluntarily ("if more than one option exists"), that sounds good enough.
>

Yet undecided whether we should include this option from the GUI, or
require the user to add this to the config. Unlike
management-query-passwords adding this option always has the side effect of
querying for remote. That may annoy/burden some users who want to leave it
to the daemon via remote-random or use the first that works or whatever.

Or, we could always add this option, and just accept the first prompt if
the user does not want this feature.

Selva

--0000000000009334cb05f0d3b888
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 27, 2022 at 1:25 PM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Dec 27, 2022 at 01:18:02PM -0500, Selva Nair wrote:<br>
&gt; My test implementation in the GUI constructs the list when first &gt;R=
EMOTE<br>
&gt; query is received. If there is no &gt;REMOTE from the daemon, the feat=
ure is<br>
&gt; not used. That works.<br>
<br>
So what&#39;s the magic --option to make openvpn query for &gt;REMOTE?<br><=
/blockquote><div><br></div><div>--management-query-remote</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
(My understanding of the management interface details is limited... I just<=
br>
happen to stumble across things here and there :-) )<br>
<br>
&gt; That said, making these commands work from management-hold would have =
been<br>
&gt; nice, but looked harder to implement -- we need a callback to get the<=
br>
&gt; context in management.c, but callbacks are initialized late.<br>
<br>
Yes, definitely looked like it.=C2=A0 But if OpenVPN queries for &gt;REMOTE=
 <br>
voluntarily (&quot;if more than one option exists&quot;), that sounds good =
enough.<br></blockquote><div><br></div><div>Yet undecided whether we should=
 include this option from the GUI, or require the user to add this to the c=
onfig. Unlike management-query-passwords adding this option always has the =
side effect of querying for remote. That may annoy/burden some users who wa=
nt=C2=A0to leave it to the daemon via remote-random or use the first that w=
orks or whatever.</div><div><br></div><div>Or, we could always add this opt=
ion, and just accept the=C2=A0first prompt if the user does not=C2=A0want t=
his feature.</div><div><br></div><div>Selva</div></div></div>

--0000000000009334cb05f0d3b888--

