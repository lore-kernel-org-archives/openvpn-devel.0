MIME-Version: 1.0
References: <20210825040122.14244-1-selva.nair@...277...>
 <20210825040122.14244-2-selva.nair@...277...>
 <YSY5a/eqVste+ZB4@...1296...>
In-Reply-To: <YSY5a/eqVste+ZB4@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Aug 2021 12:05:14 -0400
Message-ID: <CAKuzo_jsO3wep-vZc9t=ywPfW0W9UGog0YV604YBOetcEOH-ZQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000771c4505ca647350"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit unlimited connection entries
 and remotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000771c4505ca647350
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Aug 25, 2021 at 8:37 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Aug 25, 2021 at 12:01:22AM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Currently we allow a max of 64 connection entries and remotes.
> > A larger number would allow users with 100's of independent
> > config files for different end points of same provider to
> > consolidate them to connection entries.
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>
> The combination of this with the previous patch sounds quite useful
> (= no longer distribute multiple different .ovpn for tcp/udp/... but
> have them all in the same file).
>
> I assume support in the UI is also already brewing :-)
>

Yes, that's the plan..


> There is one catch: I assume that this conflicts heavily with the
> SRV patch (due to that one also changing connection entry handling),
> and the SRV patch is overdue for final review and merging - thus, when
> coming back to *this* patch, it might need a rebase.


I think, either way it would be a simple rebase. This one against the SRV
patch or the other way.

Any idea why "options_preprocess_verify_ce()", which is called for each
connection-entry, contains many checks that apply to common,
non-ce-specific options? This causes some warnings like "using management
without password is strongly discouraged.." printed once for every
connection entry  -- 100 times if you have 100 entries.

Selva

--000000000000771c4505ca647350
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 25, 2021 at 8:37 AM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Aug 25, 2021 at 12:01:22AM -0400, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Currently we allow a max of 64 connection entries and remotes.<br>
&gt; A larger number would allow users with 100&#39;s of independent<br>
&gt; config files for different end points of same provider to<br>
&gt; consolidate them to connection entries.<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
The combination of this with the previous patch sounds quite useful<br>
(=3D no longer distribute multiple different .ovpn for tcp/udp/... but<br>
have them all in the same file).=C2=A0 <br>
<br>
I assume support in the UI is also already brewing :-)<br></blockquote><div=
><br></div><div>Yes, that&#39;s the plan..</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
There is one catch: I assume that this conflicts heavily with the <br>
SRV patch (due to that one also changing connection entry handling),<br>
and the SRV patch is overdue for final review and merging - thus, when<br>
coming back to *this* patch, it might need a rebase.</blockquote><div>=C2=
=A0</div><div>I think, either way it would be a simple rebase. This one aga=
inst the SRV patch or the other way.</div><div><br></div><div>Any idea why =
&quot;options_preprocess_verify_ce()&quot;,=C2=A0which is called for each c=
onnection-entry, contains many checks that=C2=A0apply to common, non-ce-spe=
cific options? This causes some warnings like &quot;using management withou=
t password is strongly discouraged..&quot; printed once for every connectio=
n entry=C2=A0 -- 100 times if you have 100 entries.</div><div><br></div><di=
v>Selva</div></div></div>

--000000000000771c4505ca647350--

