MIME-Version: 1.0
In-Reply-To: <4f6776e3-3b9b-fae4-339c-6f28b6a24b1e@...2080...>
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
	<4f6776e3-3b9b-fae4-339c-6f28b6a24b1e@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 6 Apr 2017 09:08:03 +0500
Message-ID: <CAFHpkQFhSAMWDduU2VuRkLDrWiXh0jhVQyTBZrNG8i59BK6EPA@...278...>
Content-Type: multipart/alternative; boundary=001a114b3c2ada1e2e054c77a7b0
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b3c2ada1e2e054c77a7b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-04-06 3:26 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 05/04/17 23:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > hello!
> >
> > just curious how renegotiation is handled in "https" ?
> > is it "an abbrevated ssl handshake" (RFC 2246) or ... ?
>
> The HTTPS and OpenVPN protocol is not comparable in this regard at all.
> AFAIR, OpenVPN does not make use of the TLS renegotiation possibility at
> all.  So a renegotiation in OpenVPN actually results in a completely new
> and fresh TLS session, not related to previous TLS sessions at all.
>

both HTTPS and OpenVPN are

1) client-->server
2) long running
3) SSL based


they are similar from many point of view

as, renegotiation does occur for https, and we do not observe "hourly" CPU
peaks, I think it worth not reinventing the wheel here



>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>
> > 2017-04-06 2:39 GMT+05:00 David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>>:
> >
> >     On 05/04/17 23:13, debbie10t wrote:
> >     > I don't believe there is any need to specify "max" because that
> would be
> >     > --reneg-sec as is. Otherwise specify a smaller or larger
> --reneg-sec
> >
> >     I think you, probably without being aware of it, are agreeing to wh=
at
> >     the current proposal is:
> >
> >       --reneg-sec max
> >         A renegotiation happens within 'max' seconds, but with a 10%-ish
> >         randomness
> >
> >       --reneg-sec min max
> >         A renegotiation happens within 'min' and 'max' seconds, fully
> >         controllable
> >
> >     So using --reneg-sec 3600 3600, effectively removes the randomness.
> >
> >
> >     --
> >     kind regards,
> >
> >     David Sommerseth
> >     OpenVPN Technologies, Inc
>
>

--001a114b3c2ada1e2e054c77a7b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-06 3:26 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 05/04/17 23=
:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wr=
ote:<br>
&gt; hello!<br>
&gt;<br>
&gt; just curious how renegotiation is handled in &quot;https&quot; ?<br>
&gt; is it &quot;an abbrevated ssl handshake&quot; (RFC 2246) or ... ?<br>
<br>
</span>The HTTPS and OpenVPN protocol is not comparable in this regard at a=
ll.<br>
AFAIR, OpenVPN does not make use of the TLS renegotiation possibility at<br>
all.=C2=A0 So a renegotiation in OpenVPN actually results in a completely n=
ew<br>
and fresh TLS session, not related to previous TLS sessions at all.<br></bl=
ockquote><div><br></div><div>both HTTPS and OpenVPN are<br><br></div><div>1=
) client--&gt;server<br></div><div>2) long running<br></div><div>3) SSL bas=
ed<br><br><br></div><div>they are similar from many point of view<br><br></=
div><div>as, renegotiation does occur for https, and we do not observe &quo=
t;hourly&quot; CPU peaks, I think it worth not reinventing the wheel here<b=
r></div><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
<br>
</span><span class=3D"">&gt; 2017-04-06 2:39 GMT+05:00 David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2142...<wbr>topph=
emmelig.net</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080...">openvpn@...2261...=
2...<wbr>topphemmelig.net</a>&gt;&gt;:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 05/04/17 23:13, debbie10t wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I don&#39;t believe there is any need to speci=
fy &quot;max&quot; because that would be<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --reneg-sec as is. Otherwise specify a smaller=
 or larger --reneg-sec<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I think you, probably without being aware of it, ar=
e agreeing to what<br>
&gt;=C2=A0 =C2=A0 =C2=A0the current proposal is:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--reneg-sec max<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A renegotiation happens within &#39;m=
ax&#39; seconds, but with a 10%-ish<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0randomness<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--reneg-sec min max<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A renegotiation happens within &#39;m=
in&#39; and &#39;max&#39; seconds, fully<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0controllable<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0So using --reneg-sec 3600 3600, effectively removes=
 the randomness.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0kind regards,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0David Sommerseth<br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenVPN Technologies, Inc<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a114b3c2ada1e2e054c77a7b0--

