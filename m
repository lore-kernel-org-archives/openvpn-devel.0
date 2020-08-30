MIME-Version: 1.0
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
 <20200830120703.GV75094@...1296...>
 <20200830203720.GX75094@...1296...>
In-Reply-To: <20200830203720.GX75094@...1296...>
From: Rafael Gava <gava100@...277...>
Date: Sun, 30 Aug 2020 18:58:52 -0300
Message-ID: <CAAWBBYOaN2yo-jUXmNL9c8_MvSSY_qzi1NKp-wpT9goYTHu8dg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e8c81a05ae1f644d"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e8c81a05ae1f644d
Content-Type: text/plain; charset="UTF-8"

Hi Gert,

thanks for the prompt fix.

Our server is an old appliance and I really don't know if it was compiled
with "enable-small". I'll try to figure that. :-)

Sure, I'll try the fix and let you know ASAP.

BR

Gava


On Sun, Aug 30, 2020 at 5:37 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Aug 30, 2020 at 02:07:03PM +0200, Gert Doering wrote:
> > On Sat, Aug 29, 2020 at 09:42:46PM -0300, Rafael Gava wrote:
> [..]
> > If it still doesn't do that, you found a new bug :-)
>
> So - patch has been merged, and I think I have set up an appropriate
> testbed to verify this (2.5/master talking to 2.3.18 with OCC enabled).
>
> With Arne's (v2) patch it is no longer failing.
>
> Can you re-test your scenarios, please?
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

--000000000000e8c81a05ae1f644d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gert,=C2=A0<div><br></div><div>thanks for the prompt fi=
x.</div><div><br></div><div>Our server is an old appliance=C2=A0and I reall=
y don&#39;t know if it was compiled with &quot;enable-small&quot;. I&#39;ll=
 try to figure that. :-)</div><div><br></div><div>Sure, I&#39;ll try the fi=
x and let you know ASAP.</div><div><br></div><div>BR</div><div><br></div><d=
iv>Gava</div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Aug 30, 2020 at 5:37 PM Gert Doering =
&lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Aug 30, 2020 at 02:07:03PM +0200, Gert Doering wrote:<br>
&gt; On Sat, Aug 29, 2020 at 09:42:46PM -0300, Rafael Gava wrote:<br>
[..]<br>
&gt; If it still doesn&#39;t do that, you found a new bug :-)<br>
<br>
So - patch has been merged, and I think I have set up an appropriate<br>
testbed to verify this (2.5/master talking to 2.3.18 with OCC enabled).<br>
<br>
With Arne&#39;s (v2) patch it is no longer failing.<br>
<br>
Can you re-test your scenarios, please?<br>
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

--000000000000e8c81a05ae1f644d--

