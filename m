MIME-Version: 1.0
In-Reply-To: <CAOazyz1NCOQOQQt0_JkppC-1ZDewzBKLKOOemXG1f4OGjFp3ww@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
	<CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
	<4F4E6104.2000900@...1114...>
	<CAOazyz3fg_qSWb92ftSeq3Z7qN1fhfEBnuURfxenOsBbxGWQ4g@...278...>
	<CAOazyz1=87RqYEo=ovMtGkc1n=yh5VOQcc_YdM4nMHbQ8oNTNA@...278...>
	<CAOazyz2Svm8sG3kZMiMzH2hppNpRkQn2a_8NK9sGM0o9qCJKzg@...278...>
	<4F5720D3.7060309@...515...>
	<CAOazyz0Qopk1b8VRSobuui8QBZ3GNr5zbu4moa4abJZWyzaQWQ@...278...>
	<4F606088.8030607@...1114...>
	<CAOazyz2ZrDL-kaFa+Nc-aDcyWgOVJd82scypg9vZsZghvsY7Wg@...278...>
	<4F60903E.9090506@...515...>
	<CAOazyz3hA9LPCq0sEOWbY30PwjwxPUyCkDFWWq9x4S3dxfYVXw@...278...>
	<CABT9mj-YbHc_5w_hPBo2DNQ_TA_0dP3Py9ue9JZ32UXg0A4YEg@...278...>
	<CABT9mj9U0ewSBH=WqJ=nWgkBFGycL4R1Pw27bkhRG6WFgnpf8w@...278...>
	<CABT9mj8mywqhyiwh_y6zTtxPN8EHeT-M=1er73OD9kdHm87kBQ@...278...>
	<CAOazyz15m6go2PxXgE3RR=mO5pnJCTS-ZACYTVh9vawevCxX-A@...278...>
	<CAOazyz1NCOQOQQt0_JkppC-1ZDewzBKLKOOemXG1f4OGjFp3ww@...278...>
Date: Thu, 15 Mar 2012 00:47:52 +0200
Message-ID: <CABT9mj_XRKAt7uyMv31TmW89izDmGWmCDoBpRpHODmAL7aMenQ@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=0023542967b20527dd04bb3bc46a
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--0023542967b20527dd04bb3bc46a
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

For starters, in generic/ you may want to add a -L in the CURLOPTS to make
it follow the 302's from github.

I'll continue in the following days and let you know how it goes.



BTW, to do the MSVC build I installed Strawberry Perl, which I think is the
best option when one wants Perl on windows. Now that I think of it, one
should theoretically be able to compile openvpn and its dependencies with
Strawberry Perl alone as the only necessary prerequisite, since tools such
as mingw and dmake are included in the strawberry package (they are used to
compile Perl XS modules, etc).


On Wed, Mar 14, 2012 at 7:22 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:

> But I am more interested to see you succeed mingw configuration.
>
> Under cygwin:
>
> $ git clone https://github.com/alonbl/openvpn-build.git
> $ cd openvpn-build/generic
> $ ./build
>
> Refer to README for packages required.
>
> Alon.
>
> On Wed, Mar 14, 2012 at 7:10 PM, Alon Bar-Lev <alon.barlev@...277...>
> wrote:
> > I converted it using the VCExpress.
> >
> > On Wed, Mar 14, 2012 at 7:01 PM, Athanasios Douitsis <aduitsis@...1663...=
.>
> wrote:
> >> Right, works, at least for me. I managed to get an openvpn binary.
> >>
> >> May I ask, how did you convert the previous sln file with VC express
> 2010?
> >> Or it was already compatible with VC2010?
> >>
> >> On Wed, Mar 14, 2012 at 5:13 PM, Athanasios Douitsis <
> aduitsis@...277...>
> >> wrote:
> >>>
> >>> Alon,
> >>>
> >>> Thank you very much for the very quick response, sooner or later I'll
> let
> >>> you know how it goes.
> >>>
> >>> Kind Regards,
> >>> Athanasios
> >>>
> >>>
> >>> On Wed, Mar 14, 2012 at 5:09 PM, Athanasios Douitsis <
> aduitsis@...277...>
> >>> wrote:
> >>>>
> >>>> Oh crap....I've just uninstalled VC2010 from my builder :) :) :)
> >>>>
> >>>>
> >>>> 2012/3/14 Alon Bar-Lev <alon.barlev@...277...>
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>> In the mean time I upgraded the VC support for 2010 (and above?
> >>>>> hopefully).
> >>>>>
> >>>>> Athanasios, you may try again.
> >>>>>
> >>>>> Alon.
> >>>>>
> >>>>> 2012/3/14 Samuli Sepp=E4nen <samuli@...515...>
> >>>>> >
> >>>>> > Il 14.03.2012 11:13, Alon Bar-Lev ha scritto:
> >>>>> > > On Wed, Mar 14, 2012 at 11:10 AM, David Sommerseth
> >>>>> > > <openvpn.list@...1114...> wrote:
> >>>>> > >> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>> > >> Hash: SHA1
> >>>>> > >>
> >>>>> > >> On 14/03/12 09:33, Alon Bar-Lev wrote:
> >>>>> > >>> As the mingw build is the formal build, there is no reason to
> keep
> >>>>> > >>> supporting old visual studio configurations.
> >>>>> > >> That's debatable.  James Yonan is using MSVC for the OpenVPN AS
> >>>>> > >> client,
> >>>>> > >> and has indicated that he wanted that.  I don't know much more
> than
> >>>>> > >> this,
> >>>>> > >> but it might be related to his concerns about the old mingw32
> tool
> >>>>> > >> chain
> >>>>> > >> not being too well maintained.  I know that's not an issue with
> the
> >>>>> > >> mingw64 stuff.
> >>>>> > >>
> >>>>> > >> However, currently the official tool chain is MSVC for Windows
> >>>>> > >> builds.
> >>>>> > >> All other platforms uses the autotools toolchain.  We can sure=
ly
> >>>>> > >> discuss
> >>>>> > >> if this is the right discussion, but that's a discussion where
> >>>>> > >> James
> >>>>> > >> will
> >>>>> > >> have the final word.
> >>>>> > >>
> >>>>> > >> - From my perspective, the less toolchains we need to care
> about,
> >>>>> > >> the
> >>>>> > >> better.  But we are not in a position where we can overrule
> James'
> >>>>> > >> decisions, especially not without involving him in the
> discussion.
> >>>>> > > So please involve.
> >>>>> > > Again, I did not wrote to remove MSVC, just to support 2010 and
> >>>>> > > above.
> >>>>> > >
> >>>>> > > Alon.
> >>>>> > I'll try to involve him in this week's or next week's IRC meeting
> :).
> >>>>> >
> >>>>> > Personally, I got the feeling that the Python-based MSVC
> buildsystem
> >>>>> > he
> >>>>> > started writing (and which I finished) was a reaction to the
> general
> >>>>> > crappiness of OpenVPN Windows buildsystem(s). And that should not
> be
> >>>>> > an
> >>>>> > argument after the new "generic" buildsystem is merged.
> >>>>> >
> >>>>> > --
> >>>>> > Samuli Sepp=E4nen
> >>>>> > Community Manager
> >>>>> > OpenVPN Technologies, Inc
> >>>>> >
> >>>>> > irc freenode net: mattock
> >>>>> >
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Athanasios Douitsis
> >>>>
> >>>>
> >>>>
> >>>
> >>>
> >>>
> >>> --
> >>> Athanasios Douitsis
> >>>
> >>>
> >>>
> >>
> >>
> >>
> >> --
> >> Athanasios Douitsis
> >>
> >>
> >>
>



--=20
Athanasios Douitsis

--0023542967b20527dd04bb3bc46a
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

For starters, in generic/ you may want to add a -L in the CURLOPTS to make =
it follow the 302&#39;s from github. <br><br>I&#39;ll continue in the follo=
wing days and let you know how it goes. <br><br><br><br>BTW, to do the MSVC=
 build I installed Strawberry Perl, which I think is the best option when o=
ne wants Perl on windows. Now that I think of it, one should theoretically =
be able to compile openvpn and its dependencies with Strawberry Perl alone =
as the only necessary prerequisite, since tools such as mingw and dmake are=
 included in the strawberry package (they are used to compile Perl XS modul=
es, etc).=A0 <br>
<br><br><div class=3D"gmail_quote">On Wed, Mar 14, 2012 at 7:22 PM, Alon Ba=
r-Lev <span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277..." target=
=3D"_blank">alon.barlev@...277...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">But I am more interested to see you succeed =
mingw configuration.<br>
<br>
Under cygwin:<br>
<br>
$ git clone <a href=3D"https://github.com/alonbl/openvpn-build.git" target=
=3D"_blank">https://github.com/alonbl/openvpn-build.git</a><br>
$ cd openvpn-build/generic<br>
$ ./build<br>
<br>
Refer to README for packages required.<br>
<span><font color=3D"#888888"><br>
Alon.<br>
</font></span><div><div><br>
On Wed, Mar 14, 2012 at 7:10 PM, Alon Bar-Lev &lt;<a href=3D"mailto:alon.ba=
rlev@...277..." target=3D"_blank">alon.barlev@...277...</a>&gt; wrote:<br>
&gt; I converted it using the VCExpress.<br>
&gt;<br>
&gt; On Wed, Mar 14, 2012 at 7:01 PM, Athanasios Douitsis &lt;<a href=3D"ma=
ilto:aduitsis@...277..." target=3D"_blank">aduitsis@...277...</a>&gt; wrote=
:<br>
&gt;&gt; Right, works, at least for me. I managed to get an openvpn binary.=
<br>
&gt;&gt;<br>
&gt;&gt; May I ask, how did you convert the previous sln file with VC expre=
ss 2010?<br>
&gt;&gt; Or it was already compatible with VC2010?<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 14, 2012 at 5:13 PM, Athanasios Douitsis &lt;<a href=
=3D"mailto:aduitsis@...277..." target=3D"_blank">aduitsis@...277...</a>&gt;=
<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Alon,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thank you very much for the very quick response, sooner or lat=
er I&#39;ll let<br>
&gt;&gt;&gt; you know how it goes.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Kind Regards,<br>
&gt;&gt;&gt; Athanasios<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Wed, Mar 14, 2012 at 5:09 PM, Athanasios Douitsis &lt;<a hr=
ef=3D"mailto:aduitsis@...277..." target=3D"_blank">aduitsis@...277...</a>&g=
t;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Oh crap....I&#39;ve just uninstalled VC2010 from my builde=
r :) :) :)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 2012/3/14 Alon Bar-Lev &lt;<a href=3D"mailto:alon.barlev@...220...=
..277..." target=3D"_blank">alon.barlev@...277...</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thanks.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In the mean time I upgraded the VC support for 2010 (a=
nd above?<br>
&gt;&gt;&gt;&gt;&gt; hopefully).<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Athanasios, you may try again.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Alon.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 2012/3/14 Samuli Sepp=E4nen &lt;<a href=3D"mailto:samu=
li@...515..." target=3D"_blank">samuli@...515...</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; Il 14.03.2012 11:13, Alon Bar-Lev ha scritto:<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; On Wed, Mar 14, 2012 at 11:10 AM, David Somm=
erseth<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; &lt;<a href=3D"mailto:openvpn.list@...1332...=
." target=3D"_blank">openvpn.list@...1114...</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; Hash: SHA1<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; On 14/03/12 09:33, Alon Bar-Lev wrote:<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt;&gt; As the mingw build is the formal bui=
ld, there is no reason to keep<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt;&gt; supporting old visual studio configu=
rations.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; That&#39;s debatable. =A0James Yonan is =
using MSVC for the OpenVPN AS<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; client,<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; and has indicated that he wanted that. =
=A0I don&#39;t know much more than<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; this,<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; but it might be related to his concerns =
about the old mingw32 tool<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; chain<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; not being too well maintained. =A0I know=
 that&#39;s not an issue with the<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; mingw64 stuff.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; However, currently the official tool cha=
in is MSVC for Windows<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; builds.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; All other platforms uses the autotools t=
oolchain. =A0We can surely<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; discuss<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; if this is the right discussion, but tha=
t&#39;s a discussion where<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; James<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; will<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; have the final word.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; - From my perspective, the less toolchai=
ns we need to care about,<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; better. =A0But we are not in a position =
where we can overrule James&#39;<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;&gt; decisions, especially not without involv=
ing him in the discussion.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; So please involve.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; Again, I did not wrote to remove MSVC, just =
to support 2010 and<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; above.<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; &gt; Alon.<br>
&gt;&gt;&gt;&gt;&gt; &gt; I&#39;ll try to involve him in this week&#39;s or=
 next week&#39;s IRC meeting :).<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; Personally, I got the feeling that the Python-bas=
ed MSVC buildsystem<br>
&gt;&gt;&gt;&gt;&gt; &gt; he<br>
&gt;&gt;&gt;&gt;&gt; &gt; started writing (and which I finished) was a reac=
tion to the general<br>
&gt;&gt;&gt;&gt;&gt; &gt; crappiness of OpenVPN Windows buildsystem(s). And=
 that should not be<br>
&gt;&gt;&gt;&gt;&gt; &gt; an<br>
&gt;&gt;&gt;&gt;&gt; &gt; argument after the new &quot;generic&quot; builds=
ystem is merged.<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; --<br>
&gt;&gt;&gt;&gt;&gt; &gt; Samuli Sepp=E4nen<br>
&gt;&gt;&gt;&gt;&gt; &gt; Community Manager<br>
&gt;&gt;&gt;&gt;&gt; &gt; OpenVPN Technologies, Inc<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; irc freenode net: mattock<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Athanasios Douitsis<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Athanasios Douitsis<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Athanasios Douitsis<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasios =
Douitsis<br><br><br><br>

--0023542967b20527dd04bb3bc46a--

