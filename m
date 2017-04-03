MIME-Version: 1.0
In-Reply-To: <b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
	<b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 3 Apr 2017 17:14:58 -0400
Message-ID: <CAKuzo_j1hHgnDuFjTt4jYZg5q1QL5U15=iiLsYT-Uao++sYACQ@...278...>
Content-Type: multipart/alternative; boundary=001a1149d300041bec054c49a80a
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149d300041bec054c49a80a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 3, 2017 at 4:43 PM, David Sommerseth <
openvpn@...2080...> wrote:

> On 03/04/17 16:12, Jan Just Keijser wrote:
> > Hi Samuli,
> >
> > On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
> >> On 02/04/2017 10:57, Steffan Karger wrote:
>

snip..


> >>> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too we=
ak
> >>> nowadays, and the 'larger' DSA variants are not even close to the wide
> >>> support that RSA has.
> >>>
> >>> -Steffan
> >>>
> >> Hi,
> >>
> >> I've issue a pull request here and review would be appreciated:
> >>
> >> <https://github.com/OpenVPN/easy-rsa-old/pull/1>
> >>
> >> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size w=
as
> >> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
> >>
> >> The only real issue was DH parameter generation: it took ~25 minutes on
> >> my Intel i5 laptop. Is that acceptable default behavior?
> >>
> > what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give
> the full CPUID string (from /proc/cpuinfo) ?  then I can
> > guestimate whether the 25 minutes is realistic for slower hardware.
>
> I've run a a couple of "quick" tests ... on a two different laptops
>
> --- test 1 ----------------------------------------------------------
> $ time openssl gendh -out test 4096
> [...snip...]
>
> real    35m40.098s
> user    35m38.922s
> sys     0m0.367s
> $ cat /proc/cpuinfo  | grep model\ name | uniq -c
>       4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>

4096 bit "strong" prime is indeed an intensive computation.. Is using
-dsaparam  option not secure enough?

openssl dhparam -dsaparam -out test 4096

is 15 seconds vs forever without it on my ancient desktop.

Selva

--001a1149d300041bec054c49a80a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Apr 3, 2017 at 4:43 PM, David Sommerseth <span dir=3D"ltr">&lt;=
<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">On 03/04/17 16:12, Jan Just Keijs=
er wrote:<br>
&gt; Hi Samuli,<br>
&gt;<br>
&gt; On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:<br>
&gt;&gt; On 02/04/2017 10:57, Steffan Karger wrote:<br></blockquote><div><b=
r></div><div>snip..</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex">
&gt;&gt;&gt; DSA is _not_ a preferred choice.=C2=A0 The original 1024-bit D=
SA is too weak<br>
&gt;&gt;&gt; nowadays, and the &#39;larger&#39; DSA variants are not even c=
lose to the wide<br>
&gt;&gt;&gt; support that RSA has.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -Steffan<br>
&gt;&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve issue a pull request here and review would be appreciated=
:<br>
&gt;&gt;<br>
&gt;&gt; &lt;<a href=3D"https://github.com/OpenVPN/easy-rsa-old/pull/1" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/<wbr>easy-rsa-=
old/pull/1</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key si=
ze was<br>
&gt;&gt; set to 4096-bits and signature algorithm to SHA256WithRSAEncryptio=
n.<br>
&gt;&gt;<br>
&gt;&gt; The only real issue was DH parameter generation: it took ~25 minut=
es on<br>
&gt;&gt; my Intel i5 laptop. Is that acceptable default behavior?<br>
&gt;&gt;<br>
&gt; what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give=
 the full CPUID string (from /proc/cpuinfo) ?=C2=A0 then I can<br>
&gt; guestimate whether the 25 minutes is realistic for slower hardware.<br>
<br>
I&#39;ve run a a couple of &quot;quick&quot; tests ... on a two different l=
aptops<br>
<br>
--- test 1 ------------------------------<wbr>----------------------------<=
br>
$ time openssl gendh -out test 4096<br>
[...snip...]<br>
<br>
real=C2=A0 =C2=A0 35m40.098s<br>
user=C2=A0 =C2=A0 35m38.922s<br>
sys=C2=A0 =C2=A0 =C2=A00m0.367s<br>
$ cat /proc/cpuinfo=C2=A0 | grep model\ name | uniq -c<br>
=C2=A0 =C2=A0 =C2=A0 4 model name=C2=A0 =C2=A0 =C2=A0 : Intel(R) Core(TM) i=
5-6200U CPU @ 2.30GHz<br></blockquote><div><br></div><div>4096 bit &quot;st=
rong&quot; prime is indeed an intensive computation.. Is using -dsaparam =
=C2=A0option not secure enough?</div><div><br></div><div>openssl dhparam -d=
saparam -out test 4096</div><div><br></div><div>is 15 seconds vs forever wi=
thout it on my ancient desktop.</div><div><br></div><div>Selva</div></div><=
/div></div>

--001a1149d300041bec054c49a80a--

