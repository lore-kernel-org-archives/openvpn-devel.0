MIME-Version: 1.0
References: <20230101215109.1521549-6-selva.nair@...277...>
 <20230102194322.1560285-1-selva.nair@...277...>
 <Y7sZHFdSFS8mY3mi@...1296...>
In-Reply-To: <Y7sZHFdSFS8mY3mi@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 20 Jan 2023 15:44:21 -0500
Message-ID: <CAKuzo_gBo6aSg0ram+-97Zo-es=Adh67K2xrzoYEGpaxXWYPwA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002ce75d05f2b81eaf"
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Improve signal handling using
 POSIX sigaction
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

--0000000000002ce75d05f2b81eaf
Content-Type: text/plain; charset="UTF-8"

On Sun, Jan 8, 2023 at 2:27 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jan 02, 2023 at 02:43:22PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Currently we use the old signal API which follows system-V or
> > BSD semantics depending on the platform and/or feature-set macros.
> > Further, signal has many weaknesses which makes proper masking
> > (blocking) of signals during update not possible.
>
> Just for the record - as discussed before, this is considered too
> intrusive ("needs more testing") for 2.6.0, and can go in early in
> the 2.7 phase.
>

if no one has started reviewing 5/5,  I would like to split this into two

1. signal -> sigaction affecting sig.c only
2. changes to the way signal reset is done

#2 involves some decisions, affects the rest of the code, and may elicit
more comments.

Otherwise, will wait and see.

Selva

--0000000000002ce75d05f2b81eaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 8, 2023 at 2:27 PM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Jan 02, 2023 at 02:43:22PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Currently we use the old signal API which follows system-V or<br>
&gt; BSD semantics depending on the platform and/or feature-set macros.<br>
&gt; Further, signal has many weaknesses which makes proper masking<br>
&gt; (blocking) of signals during update not possible.<br>
<br>
Just for the record - as discussed before, this is considered too<br>
intrusive (&quot;needs more testing&quot;) for 2.6.0, and can go in early i=
n<br>
the 2.7 phase.<br></blockquote><div><br></div><div>if no one has started re=
viewing 5/5,=C2=A0 I would like to split this into two</div><div><br></div>=
<div>1. signal -&gt; sigaction affecting sig.c only</div><div>2. changes to=
 the way signal reset is done</div><div><br></div><div>#2 involves some dec=
isions, affects the rest of the code, and may elicit more comments.</div><d=
iv><br></div><div>Otherwise, will wait and see.</div><div><br></div><div>Se=
lva</div></div></div>

--0000000000002ce75d05f2b81eaf--

