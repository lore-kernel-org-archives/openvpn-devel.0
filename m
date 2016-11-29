MIME-Version: 1.0
In-Reply-To: <13ea5e26-9628-ef57-13b7-50b4041745ca@...2080...>
References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<13ea5e26-9628-ef57-13b7-50b4041745ca@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 00:27:03 -0500
Message-ID: <CAKuzo_hRLxYtu3Muj_eG2FMC6L2rBt=p6xSn1JyML2ju=LY-_Q@...278...>
Content-Type: multipart/alternative; boundary=001a114349c2da7806054269d74b
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114349c2da7806054269d74b
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 28, 2016 at 6:36 PM, David Sommerseth <
openvpn@...2080...> wrote:

> On 28/11/16 23:14, Steffan Karger wrote:
> > As described in trac #751, and shortly after reported by Zhaomo Yang, of
> > the University of California, San Diego, we use memset() (often through
> > the CLEAR() macro) to erase secrets after use.  In some cases however,
> the
> > compiler might optimize these calls away.
> >
> > This patch replaces these memset() calls on secrets by calls to a new
> > secure_memzero() function, that will not be optimized away.
> >
> > Since we use CLEAR() a LOT of times, I'm not changing that to use
> > secure_memzero() to prevent performance impact.  I did annotate the macro
> > to point people at secure_memzero().
> >
> > This patch also replaces some CLEAR() or memset() calls with a zero-
> > initialization using "= { 0 }" if that has the same effect, because that
> > better captures the intend of that code.
>
> First of all, wonderful that you've looked into an improved memset()
> approach.  We need that!  I am very happy to see these patches and this
> discussion.
>
> But I am very reluctant to this approach here, to be honest.  I do not
> like that we have a two semantics for a overlapping functions; one which
> always ensures memory is wiped (but might be slower) and the other one
> which might or might not wipe the memory (depending on the mood of the
> compiler, etc)
>
> If we "do not care" if a memory region is wiped or not (just that it's
> nice if it happens), then I'd say these are code paths which *do* *not*
> require CLEAR() at all.
>
> If we *know* a certain memory region *must* be cleared, then we do the
> proper call which does what it promises us.
>
> I  think we should not have "do not care" code paths, because that
> ambiguity gives us nothing but confusing complexity and such code paths
> bitrots faster than other type of code.
>
> So I'd say that either we move over to secure_memzero() and yank out
> CLEAR() all together.  Or we yank out CLEAR() calls where we "don't
> care" and let CLEAR() always do what it tries to promise through its name.


The logic is opposite to what you posit here.

The purpose of secure_memzero is to wipe memory even if its not necessary
for logically correct operation of the program. Especially when its not
necessary for correct logical operation. but is needed to protect privacy.

Whereas when a memory segment must be cleared for correct logic, use the
good old memset and let the compiler optimize it away if/when its smarter
than us. Unless we are discussing Bernsteins "Death of optimizing compilers"

SecureZeroMemory on Windows is not a replacement for ZeroMemory nor is
memset_s a replacement for memset. We need both.

Selva

--001a114349c2da7806054269d74b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Nov 28, 2016 at 6:36 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 28=
/11/16 23:14, Steffan Karger wrote:<br>
&gt; As described in trac #751, and shortly after reported by Zhaomo Yang, =
of<br>
&gt; the University of California, San Diego, we use memset() (often throug=
h<br>
&gt; the CLEAR() macro) to erase secrets after use.=C2=A0 In some cases how=
ever, the<br>
&gt; compiler might optimize these calls away.<br>
&gt;<br>
&gt; This patch replaces these memset() calls on secrets by calls to a new<=
br>
&gt; secure_memzero() function, that will not be optimized away.<br>
&gt;<br>
&gt; Since we use CLEAR() a LOT of times, I&#39;m not changing that to use<=
br>
&gt; secure_memzero() to prevent performance impact.=C2=A0 I did annotate t=
he macro<br>
&gt; to point people at secure_memzero().<br>
&gt;<br>
&gt; This patch also replaces some CLEAR() or memset() calls with a zero-<b=
r>
&gt; initialization using &quot;=3D { 0 }&quot; if that has the same effect=
, because that<br>
&gt; better captures the intend of that code.<br>
<br>
</span>First of all, wonderful that you&#39;ve looked into an improved mems=
et()<br>
approach.=C2=A0 We need that!=C2=A0 I am very happy to see these patches an=
d this<br>
discussion.<br>
<br>
But I am very reluctant to this approach here, to be honest.=C2=A0 I do not=
<br>
like that we have a two semantics for a overlapping functions; one which<br>
always ensures memory is wiped (but might be slower) and the other one<br>
which might or might not wipe the memory (depending on the mood of the<br>
compiler, etc)<br>
<br>
If we &quot;do not care&quot; if a memory region is wiped or not (just that=
 it&#39;s<br>
nice if it happens), then I&#39;d say these are code paths which *do* *not*=
<br>
require CLEAR() at all.<br>
<br>
If we *know* a certain memory region *must* be cleared, then we do the<br>
proper call which does what it promises us.<br>
<br>
I=C2=A0 think we should not have &quot;do not care&quot; code paths, becaus=
e that<br>
ambiguity gives us nothing but confusing complexity and such code paths<br>
bitrots faster than other type of code.<br>
<br>
So I&#39;d say that either we move over to secure_memzero() and yank out<br>
CLEAR() all together.=C2=A0 Or we yank out CLEAR() calls where we &quot;don=
&#39;t<br>
care&quot; and let CLEAR() always do what it tries to promise through its n=
ame.</blockquote></div>=C2=A0<br>The logic is opposite to what you posit he=
re. <br><br>The purpose of secure_memzero is to wipe memory even if its not=
 necessary for logically correct operation of the program. Especially when =
its not necessary for correct logical operation. but is needed to protect p=
rivacy. <br><br></div><div class=3D"gmail_extra">Whereas when a memory segm=
ent must be cleared for correct logic, use the good old memset and let the =
compiler optimize it away if/when its smarter than us. Unless we are discus=
sing Bernsteins &quot;Death of optimizing compilers&quot;<br><br></div><div=
 class=3D"gmail_extra">SecureZeroMemory on Windows is not a replacement for=
 ZeroMemory nor is memset_s a replacement for memset. We need both.<br></di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<br>=
</div></div>

--001a114349c2da7806054269d74b--

