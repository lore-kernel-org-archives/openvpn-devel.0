MIME-Version: 1.0
In-Reply-To: <CAOazyz0=vkjyx93yyauJC=2Njss0wVmK2FTS6teLERHM80MYAg@...278...>
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
	<CABT9mj8P8H86THWzNTGtZZ=gNS4dvmWQYzJJ4EVKWShoNsND7g@...278...>
	<CAOazyz0=vkjyx93yyauJC=2Njss0wVmK2FTS6teLERHM80MYAg@...278...>
Date: Thu, 15 Mar 2012 01:37:21 +0200
Message-ID: <CABT9mj_8NZUYJ55WqNkSU1YqsJXH23LBMsUxuNjH6j_yj18cHg@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=0023542967b2f7365804bb3c7417
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

--0023542967b2f7365804bb3c7417
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 15, 2012 at 1:19 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:

> On Thu, Mar 15, 2012 at 1:05 AM, Athanasios Douitsis <aduitsis@...277...>
> wrote:
> > I was just thinking loudly, definitely not asking for someone to write it
> > and replace the existing build process(es). Having said that, I'd like to
> > clarify that what I meant is this would not be an additional dependency
> on
> > top of others, since neither cygwin nor msvc would be needed anymore.
> > Anyway, not important, just a thought.
>
> Visual studio build is for compatibility for people who insist of using it.
>
> The "generic" build system is pure cross compile / native build system
> for dependencies and openvpn. It compiles openvpn using a given
> toolchain to any environment.
>
> For example, you can use it to compile at Linux for Linux on power pc
> or to Linux on arm.
> As a side effect you can also compile openvpn on Linux to windows using
> mingw.
> This exact same script without any modification can be used on Windows
> in cygwin environment to cross compile to windows native.
>
> So at the larger picture the target is to maintain a single build
> system for all environment... same dependencies, same utilities.
>
> Alon
>

Thanks for taking the time to explain! I'll be happy to provide as much
feedback as possible on the windows native case with cygwin.

Best regards,
-- 
Athanasios Douitsis

--0023542967b2f7365804bb3c7417
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Mar 15, 2012 at 1:19 AM, Alon Ba=
r-Lev <span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277...">alon.b=
arlev@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Thu, Mar 15, 2012 at 1:05 AM, Athanasios Douitsis &lt;=
<a href=3D"mailto:aduitsis@...277...">aduitsis@...277...</a>&gt; wrote:<br>
&gt; I was just thinking loudly, definitely not asking for someone to write=
 it<br>
&gt; and replace the existing build process(es). Having said that, I&#39;d =
like to<br>
&gt; clarify that what I meant is this would not be an additional dependenc=
y on<br>
&gt; top of others, since neither cygwin nor msvc would be needed anymore.<=
br>
&gt; Anyway, not important, just a thought.<br>
<br>
</div>Visual studio build is for compatibility for people who insist of usi=
ng it.<br>
<br>
The &quot;generic&quot; build system is pure cross compile / native build s=
ystem<br>
for dependencies and openvpn. It compiles openvpn using a given<br>
toolchain to any environment.<br>
<br>
For example, you can use it to compile at Linux for Linux on power pc<br>
or to Linux on arm.<br>
As a side effect you can also compile openvpn on Linux to windows using min=
gw.<br>
This exact same script without any modification can be used on Windows<br>
in cygwin environment to cross compile to windows native.<br>
<br>
So at the larger picture the target is to maintain a single build<br>
system for all environment... same dependencies, same utilities.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Alon<br>
</font></span></blockquote></div><br>Thanks for taking the time to explain!=
 I&#39;ll be happy to provide as much feedback as possible on the windows n=
ative case with cygwin. <br><br>Best regards,<br>-- <br>Athanasios Douitsis=
<br>
<br><br><br>

--0023542967b2f7365804bb3c7417--

