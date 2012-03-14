MIME-Version: 1.0
In-Reply-To: <CAOazyz3K8sGCWQO4iRCBZSmhqY-Y84BTHAzmpWbTxNWqRnD-Ew@...278...>
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
	<CABT9mj_XRKAt7uyMv31TmW89izDmGWmCDoBpRpHODmAL7aMenQ@...278...>
	<CAOazyz3K8sGCWQO4iRCBZSmhqY-Y84BTHAzmpWbTxNWqRnD-Ew@...278...>
Date: Thu, 15 Mar 2012 01:05:36 +0200
Message-ID: <CABT9mj8P8H86THWzNTGtZZ=gNS4dvmWQYzJJ4EVKWShoNsND7g@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=bcaec52be6fd6bd92104bb3c0369
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

--bcaec52be6fd6bd92104bb3c0369
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 15, 2012 at 12:54 AM, Alon Bar-Lev <alon.barlev@...277...>wrote:

> On Thu, Mar 15, 2012 at 12:47 AM, Athanasios Douitsis
> <aduitsis@...277...> wrote:
> > For starters, in generic/ you may want to add a -L in the CURLOPTS to
> make
> > it follow the 302's from github.
> >
> > I'll continue in the following days and let you know how it goes.
> >
>
> Thanks.
> But please try to use wget... it may solve the issue.
>

After adding -L, curl worked flawlessly as well.  I'll be sure to try wget
next time.

>
> >
> >
> > BTW, to do the MSVC build I installed Strawberry Perl, which I think is
> the
> > best option when one wants Perl on windows. Now that I think of it, one
> > should theoretically be able to compile openvpn and its dependencies with
> > Strawberry Perl alone as the only necessary prerequisite, since tools
> such
> > as mingw and dmake are included in the strawberry package (they are used
> to
> > compile Perl XS modules, etc).
>
> mingw is properly maintained at cygwin, there is no need to create
> more dependency.
> The cygwin environment provides a complete cross compile environment
> similar to Linux.
>
> Alon.
>

I was just thinking loudly, definitely not asking for someone to write it
and replace the existing build process(es). Having said that, I'd like to
clarify that what I meant is this would not be an additional dependency on
top of others, since neither cygwin nor msvc would be needed anymore.
Anyway, not important, just a thought.



-- 
Athanasios Douitsis

--bcaec52be6fd6bd92104bb3c0369
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Mar 15, 2012 at 12:54 AM, Alon B=
ar-Lev <span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277...">alon.=
barlev@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Thu, Mar 15, 2012 at 12:47 AM, Athanasios Douitsis<br>
&lt;<a href=3D"mailto:aduitsis@...277...">aduitsis@...277...</a>&gt; wrote:=
<br>
&gt; For starters, in generic/ you may want to add a -L in the CURLOPTS to =
make<br>
&gt; it follow the 302&#39;s from github.<br>
&gt;<br>
&gt; I&#39;ll continue in the following days and let you know how it goes.<=
br>
&gt;<br>
<br>
</div>Thanks.<br>
But please try to use wget... it may solve the issue.<br></blockquote><div>=
<br>After adding -L, curl worked flawlessly as well.=A0 I&#39;ll be sure to=
 try wget next time. <br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">

<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; BTW, to do the MSVC build I installed Strawberry Perl, which I think i=
s the<br>
&gt; best option when one wants Perl on windows. Now that I think of it, on=
e<br>
&gt; should theoretically be able to compile openvpn and its dependencies w=
ith<br>
&gt; Strawberry Perl alone as the only necessary prerequisite, since tools =
such<br>
&gt; as mingw and dmake are included in the strawberry package (they are us=
ed to<br>
&gt; compile Perl XS modules, etc).<br>
<br>
</div>mingw is properly maintained at cygwin, there is no need to create<br>
more dependency.<br>
The cygwin environment provides a complete cross compile environment<br>
similar to Linux.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Alon.<br></font></span></blockquote><div><br>I was just thinking loudly, de=
finitely not asking for someone to write it and replace the existing build =
process(es). Having said that, I&#39;d like to clarify that what I meant is=
 this would not be an additional dependency on top of others, since neither=
 cygwin nor msvc would be needed anymore. Anyway, not important, just a tho=
ught.<br>
</div></div><br><br clear=3D"all"><br>-- <br>Athanasios Douitsis<br><br><br=
><br>

--bcaec52be6fd6bd92104bb3c0369--

