MIME-Version: 1.0
In-Reply-To: <CAA1AbxLe+Gj3JDz=yhO-L63sqhojOtXd6ZMEiP+61E7=7rnVwA@...278...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<CAA1AbxLe+Gj3JDz=yhO-L63sqhojOtXd6ZMEiP+61E7=7rnVwA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 29 Aug 2016 15:29:19 -0400
Message-ID: <CAKuzo_g_RUmJJWqhALAzGc3x=2qrf=DLMNMOgdvxZ9r_zkXFyA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438f8a7688e053b3ae27d
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
 switch to c99
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c0438f8a7688e053b3ae27d
Content-Type: text/plain; charset=UTF-8

On Sun, Aug 28, 2016 at 3:46 PM, Steffan Karger <steffan@...1856...> wrote:

> On 28 August 2016 at 21:42, Steffan Karger <steffan@...1856...> wrote:
> > Previously, we would use the compiler's default C version, which defaults
> > to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might
> even
> > differ per distro.
> >
> > One of the reasons to accept the gnu89 default of GCC < 4.9, was that
> MSVC
> > didn't support c99.  But in MSVC 2015, MS finanally fixed that.
> >
> > Having to support c89 in the codebase occasionally forces us to write
> less
> > readable code, for example by forcing all declaration to be at the
> starting
> > of a block (which includes 'for loop initial declarations').
> >
> > Let's be clear about what standard we obey, and stop punishing ourselves
> > with c89/gnu89.  Let's switch the master branch to c99.
>
> To be clear:  I'm aware we never really decided to switch to c99, so
> this patch is partly meant to start discussion.  Anyone who cares for
> gnu89 support, please speak up :)


I have been all along wishing for this switch to C99 and the demise of
dated MSVC support. But we also have to keep in mind that mingw-w64 (and
mingw)  targets a least common denominator of Windows runtime (runtime
version 6.0 ?). That is not going to change as the very spirit of mingw is
to make executables that run with stock windows libraries. That means
features of C99 requiring run-time support (stdio is an example) cannot be
supported by mingw by default as it requires statically linking in
additional code.

For example,  __USE_MINGW_ANSI_STDIO has to be defined to support some of
the printf format specs and that adds about 50K to the binary. That also
invalidates windows-specific format specifiers such as %I64u which is used
in a couple places in the code. Last time I suggested this Gert was opposed
to it on grounds of the extra define, need for code changes, increased
binary size etc..

My personal preference: go for -std=c99, add the above define for mingw and
get rid of %I64.. (a only a couple of instances). That said, I do not know
how complete is the C99 support in mingw-w64, and whether there are other
issues that need work around. I suppose we can handle them, if any, as they
come..

Selva

--94eb2c0438f8a7688e053b3ae27d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Aug 28, 2016 at 3:46 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex"><span>On 28 August 2016 at 21:42, Stef=
fan Karger &lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">stef=
fan@...1856...</a>&gt; wrote:<br>
&gt; Previously, we would use the compiler&#39;s default C version, which d=
efaults<br>
&gt; to gnu89 for GCC &lt; 5, gnu11 for GCC &gt; 5, and c11 for clang, but =
might even<br>
&gt; differ per distro.<br>
&gt;<br>
&gt; One of the reasons to accept the gnu89 default of GCC &lt; 4.9, was th=
at MSVC<br>
&gt; didn&#39;t support c99.=C2=A0 But in MSVC 2015, MS finanally fixed tha=
t.<br>
&gt;<br>
&gt; Having to support c89 in the codebase occasionally forces us to write =
less<br>
&gt; readable code, for example by forcing all declaration to be at the sta=
rting<br>
&gt; of a block (which includes &#39;for loop initial declarations&#39;).<b=
r>
&gt;<br>
&gt; Let&#39;s be clear about what standard we obey, and stop punishing our=
selves<br>
&gt; with c89/gnu89.=C2=A0 Let&#39;s switch the master branch to c99.<br>
<br>
</span>To be clear:=C2=A0 I&#39;m aware we never really decided to switch t=
o c99, so<br>
this patch is partly meant to start discussion.=C2=A0 Anyone who cares for<=
br>
gnu89 support, please speak up :)</blockquote></div><br>I have been all alo=
ng wishing for this switch to C99 and the demise of dated MSVC support. But=
 we also have to keep in mind that mingw-w64 (and mingw) =C2=A0targets a le=
ast common denominator of Windows runtime (runtime version 6.0 ?). That is =
not going to change as the very spirit of mingw is to make executables that=
 run with stock windows libraries. That means features of C99 requiring run=
-time support (stdio is an example) cannot be supported by mingw by default=
 as it requires statically linking in additional code.</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">For example, =C2=A0__USE_M=
INGW_ANSI_STDIO has to be defined to support some of the printf format spec=
s and that adds about 50K to the binary. That also invalidates windows-spec=
ific format specifiers such as %I64u which is used in a couple places in th=
e code. Last time I suggested this Gert was opposed to it on grounds of the=
 extra define, need for code changes, increased binary size etc..</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">My personal pre=
ference: go for -std=3Dc99, add the above define for mingw and get rid of %=
I64.. (a only a couple of instances). That said, I do not know how complete=
 is the C99 support in mingw-w64, and whether there are other issues that n=
eed work around. I suppose we can handle them, if any, as they come..</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div>=
</div>

--94eb2c0438f8a7688e053b3ae27d--

