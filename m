MIME-Version: 1.0
In-Reply-To: <7f143a45-75fd-cf84-7391-e5eea117655c@...1856...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
 <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
 <023dbb4e-47b6-bceb-8913-40d5bf4ae76e@...515...>
 <99D61A626FDA8A4B90A270669121BE1085877307@...2294...>
 <031e4c73-3317-585d-38af-30ac9fede8ff@...515...>
 <CAFHpkQHvAg7y=UeSPL4tvn17r0_NT6ySYx5Cb3YObBxz2aNvAw@...278...>
 <7f143a45-75fd-cf84-7391-e5eea117655c@...1856...>
From: Selva <selva.nair@...277...>
Date: Thu, 2 Nov 2017 09:51:44 -0400
Message-ID: <CAKuzo_iuEBjCKtdgz_iS-P4fJTAom_55eWrE49Rvk2Y5uy_JVw@...278...>
Content-Type: multipart/alternative; boundary="001a1134fb14143eee055d004b7c"
Subject: Re: [Openvpn-devel] Windows builds (was: OpenVPN Interactive
 Service Branding)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1134fb14143eee055d004b7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 2, 2017 at 5:52 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 02-11-17 10:35, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Simon has achieved a great progress in building on Windows. WIX
> > perfectly integrates into visual studio SLN, and than perfectly builds
> > on app veyor)) no more cross builds:)
>
> That's great for Windows users, but to me cross compiling is a crucial
> feature.  I don't care about building natively on Windows at all.  It is
> just so much more convenient to cross-compile from Linux than to
> automate anything on Windows.
>

Same here. Cross compiling has to remain our main method of building and all
patches should correctly build with mingw-w64.

Trying to achieve MSVC compatibility is a nice after thought. Actually the
code
used to build with MSVC until a year or so ago but new patches unknowingly
tend to break it as Windows is not our primary build platform. The need for
occasional patching to get MSVC  build working again is going to continue.

At least that's my view.

Selva

--001a1134fb14143eee055d004b7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Nov 2, 2017 at 5:52 AM, <span id=3D"m_-5494582498522987796:8=
te.1">Steffan</span> <span id=3D"m_-5494582498522987796:8te.2">Karger</span=
> <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_bl=
ank"><span id=3D"m_-5494582498522987796:8te.3">steffan</span>@<span id=3D"m=
_-5494582498522987796:8te.4">karger</span>.me</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Hi,<br>
<br>
On 02-11-17 10:35, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; Simon has achieved a great progress in building on Windows. WIX<br>
&gt; perfectly integrates into visual studio SLN, and than perfectly builds=
<br>
&gt; on app veyor)) no more cross builds:)<br>
<br>
That&#39;s great for Windows users, but to me cross compiling is a crucial<=
br>
feature.=C2=A0 I don&#39;t care about building natively on Windows at all.=
=C2=A0 It is<br>
just so much more convenient to cross-compile from Linux than to<br>
automate anything on Windows.<br></blockquote><div><br></div><div>Same here=
. Cross compiling has to remain our main method of building and all</div><d=
iv>patches should correctly build with <span id=3D"m_-5494582498522987796:8=
te.6">mingw</span>-w64.</div><div><br></div><div>Trying to achieve <span id=
=3D"m_-5494582498522987796:8te.7">MSVC</span> compatibility is a nice after=
 thought. Actually the code</div><div>used to build with <span id=3D"m_-549=
4582498522987796:8te.8">MSVC</span> until a year or so ago but new patches =
unknowingly</div><div>tend to break it as Windows is not our primary build =
platform. The need for</div><div>occasional patching to get <span id=3D"m_-=
5494582498522987796:8te.9">MSVC</span> =C2=A0build working again is going t=
o continue.</div><div><br></div><div>At least that&#39;s my view.</div><div=
><br></div><div><span id=3D"m_-5494582498522987796:8te.10">Selva</span></di=
v></div></div></div>

--001a1134fb14143eee055d004b7c--

