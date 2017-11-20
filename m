MIME-Version: 1.0
In-Reply-To: <d25449a1-25ea-f451-b192-ca60d7c2ed48@...2080...>
References: <20170505214624.11675-1-davids@...515...>
 <CAKuzo_gaQexyhX9RJTZkoqpTsPFL=cjqX+p90KEdMBiU7jckjg@...278...>
 <d25449a1-25ea-f451-b192-ca60d7c2ed48@...2080...>
From: Selva <selva.nair@...277...>
Date: Mon, 20 Nov 2017 17:37:26 -0500
Message-ID: <CAKuzo_h5dRvEporJeQAncXzp+5YeuTgsHsKnXAUUJKNVLnS5hg@...278...>
Content-Type: multipart/alternative; boundary="001a11490138459611055e71bc81"
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11490138459611055e71bc81
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Mon, Nov 20, 2017 at 3:10 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 19/11/17 22:21, Selva wrote:
> > Hi David,
> >
> > On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...
> > <mailto:davids@...515...>> wrote:
> >
> >     This patch builds on the "Export secure_memzero() to plug-ins" patch
> and
> >     adds export of openvpn_base64_encode() and openvpn_base64_decode()
> >
> >     This also ships with a very simple plug-in which demonstrates how to
> use
> >     the new exported functions.
> >
> >
> > This has remained in a limbo mainly because of me pushing for a
> correction
> > to the plugin_v3 API. Obviously that hasn't got any traction.
> >
> > If you separate this into two patches: (i) export base64 (ii) usage
> sample
> > we can get (i) merged right away and move on to patches that would
> benefit
> > from it.
>
> Hi Selva,
>
> This has gone in-and-out of my TODO list for quite some time, and I've
> even had some help from Antonio double checking the plugin_v3 API
> corrections.  I've just been side-tracked on more urgent matters.
>
> We actually ended up concluding that we can fix the API without making
> things worse.  Which is the most important detail here.
>
> I'll try to get some time fixing this and respond a bit quicker.


Good to know its still on your radar. I'll resubmit the API patch so that
it gets
on to patchwork.

Selva

--001a11490138459611055e71bc81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<br><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Mon, Nov 20, 2017 at 3:10 PM, David Sommerseth <span dir=3D=
"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...220...=
..2142...<wbr>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span>On 19/11/17 22:21, Selva wrote:<br>
&gt; Hi David,<br>
&gt;<br>
&gt; On Fri, May 5, 2017 at 5:46 PM, David Sommerseth=C2=A0&lt;<a href=3D"m=
ailto:davids@...515..." target=3D"_blank">davids@...515...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:davids@...515..." target=3D"_blank=
">davids@...515...</a>&gt;&gt;=C2=A0w<wbr>rote:<br>
<span>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch builds on the &quot;Export secure_memzer=
o() to plug-ins&quot; patch and<br>
&gt;=C2=A0 =C2=A0 =C2=A0adds export of openvpn_base64_encode() and openvpn_=
base64_decode()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This also ships with a very simple plug-in which de=
monstrates how to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0the new exported functions.<br>
&gt;<br>
&gt; =C2=A0<br>
&gt; This has remained in a limbo mainly because of me pushing for a correc=
tion<br>
&gt; to the plugin_v3 API. Obviously that hasn&#39;t got any traction.<br>
&gt;<br>
&gt; If you separate this into two patches: (i) export base64 (ii) usage sa=
mple<br>
&gt; we can get (i) merged right away and move on to patches that would ben=
efit<br>
&gt; from it.<br>
<br>
</span>Hi Selva,<br>
<br>
This has gone in-and-out of my TODO list for quite some time, and I&#39;ve<=
br>
even had some help from Antonio double checking the plugin_v3 API<br>
corrections.=C2=A0 I&#39;ve just been side-tracked on more urgent matters.<=
br>
<br>
We actually ended up concluding that we can fix the API without making<br>
things worse.=C2=A0 Which is the most important detail here.<br>
<br>
I&#39;ll try to get some time fixing this and respond a bit quicker.</block=
quote><div><br></div><div>Good to know its still on your radar. I&#39;ll re=
submit the API patch so that it gets</div><div>on to patchwork.</div><div><=
br></div><div>Selva</div></div></div></div>

--001a11490138459611055e71bc81--

