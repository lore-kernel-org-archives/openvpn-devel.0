MIME-Version: 1.0
In-Reply-To: <3511ca4d-1d4a-a674-9be8-0cfe9859264c@...2080...>
References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
	<3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
	<CAKuzo_iNNRCqfn=+9nv_n25mUF7akOW_6cec_JhU6dMuaV4nqQ@...278...>
	<3511ca4d-1d4a-a674-9be8-0cfe9859264c@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Sep 2016 00:33:51 -0400
Message-ID: <CAKuzo_jqjYAHC3FH9dcu4+6ZfmaBOB18D135fYGxfpp0h=FNyA@...278...>
Content-Type: multipart/alternative; boundary=001a11417d74b68ee8053b6ab93b
Subject: Re: [Openvpn-devel] Modernising the management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11417d74b68ee8053b6ab93b
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 31, 2016 at 7:19 PM, David Sommerseth <
openvpn@...2080...> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 31/08/16 23:25, Selva Nair wrote:
> > Hi,
> >
> > On Wed, Aug 31, 2016 at 4:11 PM, David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>> wrote:
> >
> >     > It is not being planned to remove the management interface.  If
> >     > D-Bus works well for everyone on all platforms, then we can disc
> uss
> >     > what to do next.  But as of now, I have no plans to remove this
> >     > part of the code.
> >
> >
> > That's all what I wanted to hear -- as long as the management interfac
> e
> > (MI) is not going anywhere, no need to panic, right? I like the simple
> > design of the current MI that makes it so easy to debug over command
> > line, support on virtually any platform without external libraries etc
> .
> > Even with D-Bus one has to still send messages specific to the
> > application and the UI developer has to learn a few new keywords. Not
> > very different from the current state of affairs unless we have a use
> > case that is not easy to support over the current MI. I have never use
> d
> > D-Bus so no idea of the status of Windows support -- I believe the
> > reference implementation as a windows port, not sure how well maintain
> ed
> > it is.
>
> I noticed that the upstream D-Bus community have embraced the Windows
> port and included all fixes for Windows there.  So it is probably
> somewhat better maintained nowadays.  But I have not looked where to
> download things.
>
> If I've understood some of the D-Bus docs correctly, it should also be
> possible to use D-Bus without a "master daemon" running too, but that
> needs to be investigated further.
>
> No, no need to panic :)  But I think that GUI's may also have some
> advantages of using D-Bus too, such as getting a more instant
> notifications when something goes wrong, or if a user needs to
> re-authenticate.  But I am completely open to explore these areas and
> not set things to stone now.
>

My advice, just leave the management-interface alone, at least until a real
need for a different framework arises . It "ain't broke", so why fix it?

The amount of communication we need/have between OpenVPN and UI's is so
minimal that it shouldn't take more than an hour for a developer to "learn"
the current management "protocol". Replacing or even augmenting it with
D-Bus bringing in new dependency and a lot of bloat doesn't make much
sense; nor does it look worth the time and effort to me..

Selva

--001a11417d74b68ee8053b6ab93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Aug 31, 2016 at 7:19 PM, David Sommerseth <span dir=3D"ltr">&lt=
;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...=
<wbr>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">-----BEG=
IN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
On 31/08/16 23:25, Selva Nair wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, Aug 31, 2016 at 4:11 PM, David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...1186...=
.2156...<wbr>.net</a><br>
&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">ope=
nvpn@...2157...<wbr>emmelig.net</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; It is not being planned to remove the manageme=
nt interface.=C2=A0 If<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; D-Bus works well for everyone on all platforms=
, then we can disc<br>
uss<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; what to do next.=C2=A0 But as of now, I have n=
o plans to remove this<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; part of the code.<br>
&gt;<br>
&gt;<br>
&gt; That&#39;s all what I wanted to hear -- as long as the management inte=
rfac<br>
e<br>
&gt; (MI) is not going anywhere, no need to panic, right? I like the simple=
<br>
&gt; design of the current MI that makes it so easy to debug over command<b=
r>
&gt; line, support on virtually any platform without external libraries etc=
<br>
.<br>
&gt; Even with D-Bus one has to still send messages specific to the<br>
&gt; application and the UI developer has to learn a few new keywords. Not<=
br>
&gt; very different from the current state of affairs unless we have a use<=
br>
&gt; case that is not easy to support over the current MI. I have never use=
<br>
d<br>
&gt; D-Bus so no idea of the status of Windows support -- I believe the<br>
&gt; reference implementation as a windows port, not sure how well maintain=
<br>
ed<br>
&gt; it is.<br>
<br>
I noticed that the upstream D-Bus community have embraced the Windows<br>
port and included all fixes for Windows there.=C2=A0 So it is probably<br>
somewhat better maintained nowadays.=C2=A0 But I have not looked where to<b=
r>
download things.<br>
<br>
If I&#39;ve understood some of the D-Bus docs correctly, it should also be<=
br>
possible to use D-Bus without a &quot;master daemon&quot; running too, but =
that<br>
needs to be investigated further.<br>
<br>
No, no need to panic :)=C2=A0 But I think that GUI&#39;s may also have some=
<br>
advantages of using D-Bus too, such as getting a more instant<br>
notifications when something goes wrong, or if a user needs to<br>
re-authenticate.=C2=A0 But I am completely open to explore these areas and<=
br>
not set things to stone now.<br></blockquote><div><br></div><div>My advice,=
 just leave the management-interface alone, at least until a real need for =
a different framework arises . It &quot;ain&#39;t broke&quot;, so why fix i=
t?<br><br></div><div>The amount of communication we need/have between OpenV=
PN and UI&#39;s is so minimal that it shouldn&#39;t take more than an hour =
for a developer to &quot;learn&quot; the current management &quot;protocol&=
quot;. Replacing or even augmenting it with D-Bus bringing in new dependenc=
y and a lot of bloat doesn&#39;t make much sense; nor does it look worth th=
e time and effort to me..<br></div><div><br></div><div>Selva<br></div></div=
></div></div>

--001a11417d74b68ee8053b6ab93b--

