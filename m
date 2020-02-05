MIME-Version: 1.0
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-3-domagoj@...2540...>
 <20200205130511.GM1431@...1296...> <20200205131828.GA16251@...2540...>
 <CAKuzo_h2XNEm+UnGEvcoF5g2rwDdsTMTjtA-p0uHdsMu7HGP2w@...278...>
 <CAKuzo_i3-3xXYP+f+GAJKtDVOajD5iE+vg9fa2XrHUbg1PFzSg@...278...>
 <20200205154013.GA9536@...2540...>
In-Reply-To: <20200205154013.GA9536@...2540...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Feb 2020 19:16:05 +0200
Message-ID: <CAGyAFMWBM8v+MFoF_afSFasjvmGqqAn8BCdZgTbr0_NwNpqNGA@...278...>
Content-Type: multipart/alternative; boundary="000000000000877044059dd75074"
Subject: Re: [Openvpn-devel] Fwd: [PATCH 2/2] Fix linking issues on MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000877044059dd75074
Content-Type: text/plain; charset="UTF-8"

Hi,

Good catch. "Inline" generates inline definition and if we don't do
inlining
(by not specifying O2), linker doesn't see it and prints an error.
Apparently MSVC
is lax on that.

Checking source code, most (if all?) or inline methods are static.

Obviously we want our code to compile without O2, so ACK from me.

Acked-by: Lev Stipakov <lstipakov@...277...>

ke 5. helmik. 2020 klo 17.41 Domagoj Pensa (domagoj@...2540...) kirjoitti:

> Hi,
>
> On Wed, Feb 05, 2020 at 10:28:38AM -0500, Selva Nair wrote:
> > Are you building without optimization? Please try using the latest
> > openvpn-build (or just add -O2 to complier options).
>
> Yes, that was it!
>
> When Lev said that he doesn't have problems with build, I've noticed that
> he
> is using script build-complete from windows-nsis.
>
> I didn't want installer build, just binaries, so I followed  instructions
> from README and generic/README and thus I used generic/build.
>
> But that doesn't include -O2 and I get mentioned error when linking.
>
> In windows-nsis/build-complete there are additional flags "-O2 -flto" and
> that's why Lev doesn't have issues and we are using same tools and OS
> versions.
>
> Those additional flags where added by Lev in commit 3eb61bb in
> openvpn-build.
>
> Problem solved, now I know for the future.
>
> But still it would be nice to somehow "fix" this for others, by either
> updating READMEs, adding -O2 to generic/build script or apply patch I've
> sent that helped me and links with optimization off.
>
> Maybe doing all that won't be bad.
>
> Thank you all!
>
> Domagoj
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000877044059dd75074
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Good catch. &quot;Inline&quot; gene=
rates inline definition and if we don&#39;t do inlining=C2=A0</div><div>(by=
 not specifying O2), linker doesn&#39;t see it and prints an error. Apparen=
tly MSVC=C2=A0</div><div>is lax on that.</div><div><br></div><div>Checking =
source code, most (if all?) or inline methods are static.</div><div><br></d=
iv><div>Obviously we want our code to compile=C2=A0without O2, so ACK from =
me.</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:l=
stipakov@...277...">lstipakov@...277...</a>&gt;</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ke 5. helmik. 2020 k=
lo 17.41 Domagoj Pensa (<a href=3D"mailto:domagoj@...2540...">domagoj@...2541...=
40...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi,<br>
<br>
On Wed, Feb 05, 2020 at 10:28:38AM -0500, Selva Nair wrote:<br>
&gt; Are you building without optimization? Please try using the latest<br>
&gt; openvpn-build (or just add -O2 to complier options).<br>
<br>
Yes, that was it!<br>
<br>
When Lev said that he doesn&#39;t have problems with build, I&#39;ve notice=
d that he <br>
is using script build-complete from windows-nsis.<br>
<br>
I didn&#39;t want installer build, just binaries, so I followed=C2=A0 instr=
uctions <br>
from README and generic/README and thus I used generic/build.<br>
<br>
But that doesn&#39;t include -O2 and I get mentioned error when linking.<br>
<br>
In windows-nsis/build-complete there are additional flags &quot;-O2 -flto&q=
uot; and <br>
that&#39;s why Lev doesn&#39;t have issues and we are using same tools and =
OS <br>
versions.<br>
<br>
Those additional flags where added by Lev in commit 3eb61bb in <br>
openvpn-build.<br>
<br>
Problem solved, now I know for the future.<br>
<br>
But still it would be nice to somehow &quot;fix&quot; this for others, by e=
ither <br>
updating READMEs, adding -O2 to generic/build script or apply patch I&#39;v=
e <br>
sent that helped me and links with optimization off.<br>
<br>
Maybe doing all that won&#39;t be bad.<br>
<br>
Thank you all!<br>
<br>
Domagoj<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000877044059dd75074--

