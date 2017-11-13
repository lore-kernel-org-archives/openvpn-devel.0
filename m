MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108588B957@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-12-simon@...2293...>
 <CAKuzo_jzkj2jNMODphaa6GSfyNtB7UiWhg5oEYHtBcCZ3rsBoQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108588B957@...2294...>
From: Selva <selva.nair@...277...>
Date: Mon, 13 Nov 2017 08:06:07 -0500
Message-ID: <CAKuzo_i407Njzz8OZiTK0xLTe2h+P6EdSzmRxP0mdeKyYRvxOw@...278...>
Content-Type: multipart/alternative; boundary="001a1147603c3a23b4055ddcf03b"
Subject: Re: [Openvpn-devel] [PATCH 12/13] Memory size arithmetic reviewed
 according to 64-bit MSVC complaints
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147603c3a23b4055ddcf03b
Content-Type: text/plain; charset="UTF-8"

Hi,


> >     const char *p = _tcsrchr(find->cFileName, TEXT('.'));
> >     return p && p != find->cFileName && !_tcsicmp(p+1, ext);
> >
> > No _tcslen() and no offending size variables.
> > And that convoluted original is then gone.
>
> The resulting code would look a lot nicer indeed. Stay tuned for v2 of
> this patch.
>
>
Yes that was the point -- not that we cant do arithmetic, but we need not
and in the end the code could be cleaner...


>
> > -    WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
> > +    WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
> >
> > Isn't this identical to the original automatic conversion from size_t to
> > DWORD?
> > An overly paranoid assert(_countof(buf) < MAXDWORD/2) may catch an
> > extremely
> > unlikely future coding error, but in what way a cast safer?
>
> I didn't say it is safer. The buf is WCHAR[33] on the stack. There is a
> safety zero termination a line before the WritePipeAsync(). Therefore,
> wcslen(buf) will always return between 0 and 32. Times two (if I was coding
> this, I'd use *sizeof(WCHAR) instead of 2, to make a clear statement, what
> is multiplication by 2 about), making it between 0 and 64. Unfortunately,
> result is size_t where Win32 API expects a DWORD.
>
> This will always produce a false compiler warning. I muted it by an
> explicit cast, so we can focus on more important warnings.


Agreed, reducing compiler warnings is a useful side effect and we know the
type coercion here is safe.

cheers,

Selva

--001a1147603c3a23b4055ddcf03b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt;=C2=A0 =C2=A0 =C2=A0const char *p =3D _tcsrchr(find-&gt;cFileName, TEXT=
(&#39;.&#39;));<br>
&gt;=C2=A0 =C2=A0 =C2=A0return p &amp;&amp; p !=3D find-&gt;cFileName &amp;=
&amp; !_tcsicmp(p+1, ext);<br>
&gt;<br>
&gt; No _tcslen() and no offending size variables.<br>
</span><span class=3D"">&gt; And that convoluted original is then gone.<br>
<br>
</span>The resulting code would look a lot nicer indeed. Stay tuned for v2 =
of this patch.<br>
<span class=3D""><br></span></blockquote><div><br></div><div>Yes that was t=
he point -- not that we cant do arithmetic, but we need not</div><div>and i=
n the end the code could be cleaner...</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><span class=3D"">
<br>
&gt; -=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, event=
s);<br>
&gt; +=C2=A0 =C2=A0 WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), cou=
nt, events);<br>
&gt;<br>
&gt; Isn&#39;t this identical to the original automatic conversion from siz=
e_t to<br>
&gt; DWORD?<br>
&gt; An overly paranoid assert(_countof(buf) &lt; MAXDWORD/2) may catch an<=
br>
&gt; extremely<br>
&gt; unlikely future coding error, but in what way a cast safer?<br>
<br>
</span>I didn&#39;t say it is safer. The buf is WCHAR[33] on the stack. The=
re is a safety zero termination a line before the WritePipeAsync(). Therefo=
re, wcslen(buf) will always return between 0 and 32. Times two (if I was co=
ding this, I&#39;d use *sizeof(WCHAR) instead of 2, to make a clear stateme=
nt, what is multiplication by 2 about), making it between 0 and 64. Unfortu=
nately, result is size_t where Win32 API expects a DWORD.<br>
<br>
This will always produce a false compiler warning. I muted it by an explici=
t cast, so we can focus on more important warnings.</blockquote><div><br></=
div><div>Agreed, reducing compiler warnings is a useful side effect and we =
know the</div><div>type coercion here is safe.</div><div><br></div><div>che=
ers,</div><div><br></div><div>Selva</div></div></div></div></div>

--001a1147603c3a23b4055ddcf03b--

