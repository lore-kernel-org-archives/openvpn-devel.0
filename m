MIME-Version: 1.0
In-Reply-To: <50F743AF.5020500@...68...>
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...> <50F743AF.5020500@...68...>
Date: Thu, 17 Jan 2013 15:21:43 +0200
Message-ID: <CABT9mj8heROYbMwirfFM6SCiDCQd+Uc5VJ_3rUtzoE74qKw7+w@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=047d7b6774d03cea7e04d37be0ab
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7b6774d03cea7e04d37be0ab
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 17, 2013 at 2:19 AM, Matthias Andree <matthias.andree@...68...>wrote:

> Am 16.01.2013 11:11, schrieb Gert Doering:
> > Hi,
> >
> > On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:
> >> Trying to compile 2.3 with visual studio 2010. I am getting the
> following
> >> error:
> >>
> >> init.c(186): error C2143: syntax error : missing ';' before 'type'
> >>
> [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\openvpn\openvpn.vcxproj]
> >>
> >> (after that there are many many more errors, but you get the idea)
> >
> > Oh well, we've done it again...
>
> User reply follows, Developer reply after next quote:
>
> Arguably, Visual Studio is broken if it does not accept the then-current
> version of ISO 9899, which would have been C99 for anything except
> VS2012 that should support C11, but reality differs, and
> <
> http://stackoverflow.com/questions/146381/visual-studio-support-for-new-c-c-standards
> >
> contains a few links to official info.
>
> If something has really failed to catch on with many commercial
> compilers, then I fear C99 is to carry this red light. :-(
>
> If the code is really type-safe and -clean in C++ terms, you may have
> some success with convincing VS to compile in C++ mode - but this needs
> typecasts for virtually everything that deals with void * - but there
> are some things in C99 that are incompatible with (at least the most
> widely implemented pre-C++11 variants of) C++, such as variable-length C
> arrays.
>
> >   if (management)
> >     {
> >       gc = gc_new ();
> >       struct buffer out = alloc_buf_gc (256, &gc);
> >
> > ... this is not allowed in visual studio (having a variable declaration
> > after "non-declaration" code), but gcc doesn't complain, so we usually
> > don't notice.
>
>
>
> You can make gcc complain, -pedantic -std=c89 should do it, or if you
> are not enabling additional compiler warnings, -pedantic-errors.
>   And it possibly causes tons of other warnings because it nukes system
> extensions from the compilation environment.
>
> What I personally usually do is to test with various different compilers
> and configurations:
>
> 1. do not configure the source directory (or call "make distclean")
>
> 2. mkdir _build _build-c89 _build-clang _build-icc
>
> 3. for each $DIR of these new directories, do:
>
>     3a. cd $DIR
>
>     3b. ../configure CC="gcc"
> (or CC="gcc -std=c89 -pedantic" or "clang" or "icc" or... you name it) -
> you can also add CFLAGS, LDFLAGS, CPPFLAGS as you see fit, stuff -m32 to
> compile 32-bit code on 64-bit systems that support it (some Linux
> distributions would work - if they offer you i686 packages to install on
> your x86_64, they are usually ready; such as: Debian if you stay away
> from aptitude, and Fedora, for instance).
>
>     3c. make -sj4 check (use higher numbers for machines with more than
> 4 CPU cores)
>
> where
>  - icc is Intel's compiler package that keeps changing names more often
> than I chase new versions
>  - clang is Apple's LLVM-based free-and-open-source compiler which gives
> decent and useful hints, but defaults to C99 mode
>
> Best regards,
> Matthias
>
>
> ------------------------------------------------------------------------------
> Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
> MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
> with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
> MVPs and experts. ON SALE this month only -- learn more at:
> http://p.sf.net/sfu/learnmore_122712
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

For anyone interested, the offending lines are init.c:186 and
socket.c:1264. I've been able to successfully compile the project with VS10
after trivial changes to these two spots.

Also, please anyone interested take a look at my reply yesterday about the
problems with the build instructions.
--
Athanasios Douitsis

--047d7b6774d03cea7e04d37be0ab
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Jan 17, 2013 at 2:19 AM, Matthia=
s Andree <span dir=3D"ltr">&lt;<a href=3D"mailto:matthias.andree@...68..." =
target=3D"_blank">matthias.andree@...68...</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
Am 16.01.2013 11:11, schrieb Gert Doering:<br>
<div class=3D"im">&gt; Hi,<br>
&gt;<br>
&gt; On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:<b=
r>
&gt;&gt; Trying to compile 2.3 with visual studio 2010. I am getting the fo=
llowing<br>
&gt;&gt; error:<br>
&gt;&gt;<br>
&gt;&gt; init.c(186): error C2143: syntax error : missing &#39;;&#39; befor=
e &#39;type&#39;<br>
&gt;&gt; [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\o=
penvpn\openvpn.vcxproj]<br>
&gt;&gt;<br>
&gt;&gt; (after that there are many many more errors, but you get the idea)=
<br>
&gt;<br>
&gt; Oh well, we&#39;ve done it again...<br>
<br>
</div>User reply follows, Developer reply after next quote:<br>
<br>
Arguably, Visual Studio is broken if it does not accept the then-current<br>
version of ISO 9899, which would have been C99 for anything except<br>
VS2012 that should support C11, but reality differs, and<br>
&lt;<a href=3D"http://stackoverflow.com/questions/146381/visual-studio-supp=
ort-for-new-c-c-standards" target=3D"_blank">http://stackoverflow.com/quest=
ions/146381/visual-studio-support-for-new-c-c-standards</a>&gt;<br>
contains a few links to official info.<br>
<br>
If something has really failed to catch on with many commercial<br>
compilers, then I fear C99 is to carry this red light. :-(<br>
<br>
If the code is really type-safe and -clean in C++ terms, you may have<br>
some success with convincing VS to compile in C++ mode - but this needs<br>
typecasts for virtually everything that deals with void * - but there<br>
are some things in C99 that are incompatible with (at least the most<br>
widely implemented pre-C++11 variants of) C++, such as variable-length C<br>
arrays.<br>
<div class=3D"im"><br>
&gt; =A0 if (management)<br>
&gt; =A0 =A0 {<br>
&gt; =A0 =A0 =A0 gc =3D gc_new ();<br>
&gt; =A0 =A0 =A0 struct buffer out =3D alloc_buf_gc (256, &amp;gc);<br>
&gt;<br>
&gt; ... this is not allowed in visual studio (having a variable declaratio=
n<br>
&gt; after &quot;non-declaration&quot; code), but gcc doesn&#39;t complain,=
 so we usually<br>
&gt; don&#39;t notice.<br>
<br>
<br>
<br>
</div>You can make gcc complain, -pedantic -std=3Dc89 should do it, or if y=
ou<br>
are not enabling additional compiler warnings, -pedantic-errors.<br>
=A0 And it possibly causes tons of other warnings because it nukes system<b=
r>
extensions from the compilation environment.<br>
<br>
What I personally usually do is to test with various different compilers<br>
and configurations:<br>
<br>
1. do not configure the source directory (or call &quot;make distclean&quot=
;)<br>
<br>
2. mkdir _build _build-c89 _build-clang _build-icc<br>
<br>
3. for each $DIR of these new directories, do:<br>
<br>
=A0 =A0 3a. cd $DIR<br>
<br>
=A0 =A0 3b. ../configure CC=3D&quot;gcc&quot;<br>
(or CC=3D&quot;gcc -std=3Dc89 -pedantic&quot; or &quot;clang&quot; or &quot=
;icc&quot; or... you name it) -<br>
you can also add CFLAGS, LDFLAGS, CPPFLAGS as you see fit, stuff -m32 to<br>
compile 32-bit code on 64-bit systems that support it (some Linux<br>
distributions would work - if they offer you i686 packages to install on<br>
your x86_64, they are usually ready; such as: Debian if you stay away<br>
from aptitude, and Fedora, for instance).<br>
<br>
=A0 =A0 3c. make -sj4 check (use higher numbers for machines with more than=
<br>
4 CPU cores)<br>
<br>
where<br>
=A0- icc is Intel&#39;s compiler package that keeps changing names more oft=
en<br>
than I chase new versions<br>
=A0- clang is Apple&#39;s LLVM-based free-and-open-source compiler which gi=
ves<br>
decent and useful hints, but defaults to C99 mode<br>
<br>
Best regards,<br>
Matthias<br>
<br>
---------------------------------------------------------------------------=
---<br>
Master Visual Studio, SharePoint, SQL, <a href=3D"http://ASP.NET" target=3D=
"_blank">ASP.NET</a>, C# 2012, HTML5, CSS,<br>
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current<br>
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft<br>
MVPs and experts. ON SALE this month only -- learn more at:<br>
<a href=3D"http://p.sf.net/sfu/learnmore_122712" target=3D"_blank">http://p=
.sf.net/sfu/learnmore_122712</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br>For anyone interested, the offending lines are init.=
c:186 and=20
socket.c:1264. I&#39;ve been able to successfully compile the project with =
VS10 after trivial changes to these two spots. <br><br>Also, please anyone =
interested take a look at my reply yesterday about the problems with the bu=
ild instructions. <br>
--<br>Athanasios Douitsis<br><br><br>

--047d7b6774d03cea7e04d37be0ab--

