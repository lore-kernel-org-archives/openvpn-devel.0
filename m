MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
From: Selva <selva.nair@...277...>
Date: Sun, 5 Nov 2017 22:34:16 -0500
Message-ID: <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
Content-Type: multipart/alternative; boundary="f403043ae4f43a530d055d48225c"
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403043ae4f43a530d055d48225c
Content-Type: text/plain; charset="UTF-8"

Hi,

I understand the intent here and its nice to get rid of compiler warnings,
when
it makes sense. But be careful while silencing by just a cast.

On Sun, Nov 5, 2017 at 5:06 PM, Simon Rozman <simon@...2293...> wrote:
>
> Hi,
>
> Let me explain all proposed modifications case-by-case below...
>
> > > diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c index
> > > d43cbcf..f88ba2c 100644
> > > --- a/src/openvpn/block_dns.c
> > > +++ b/src/openvpn/block_dns.c
> > > @@ -370,7 +370,7 @@ get_interface_metric(const NET_IFINDEX index,
> > const ADDRESS_FAMILY family)
> > >          }
> > >          return ipiface.Metric;
> > >      }
> > > -    return -err;
> > > +    return -(int)err;
> > >  }
> >
> > This, I can somewhat agree to, as "err" is an unsigned type so there
might be
> > a hidden integer overflow if it happens to be "large".  Which it won't
be, but
> > still.
>
> Adding the `(int)` resolves the warning C4146: unary minus operator
> applied to unsigned type, result still unsigned.
> https://msdn.microsoft.com/en-us/library/4kh09110.aspx
>
> It doesn't change much, but it shut-ups one compiler warning.

The original code could be argued to be logically wrong (though
perfectly legal C) if err becomes larger than a signed int. This change
does not fix that. So what's the point?

As an example, consider this

err = 2147483649 <(214)%20748-3649> (2 more than INT_MAX)
Original will return  2147483647 <(214)%20748-3647> (not a -ve int)
The new code will return the same 2147483647 <(214)%20748-3647>
That is, the return value is +ve int which the caller will wrongly
interpret as valid result.

This is hypothetical as Windows system err codes do not get that large.
But then the original is as good as the replacement except for a
C++-trained compiler being silenced.

While most of the MSVC compiler warnings are false-alarms, one out of many
> does represent a potential threat. But you don't know which one that is.
> Therefore it is best to address them all. :)
>

To repeat,  cast does not eliminate a potential for error, it just just
hides it.

Selva

--f403043ae4f43a530d055d48225c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I understand the intent here and its nice to ge=
t rid of compiler warnings, when<br>it makes sense. But be careful while si=
lencing by just a cast.<br><br>On Sun, Nov 5, 2017 at 5:06 PM, Simon Rozman=
 &lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...=
</a>&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt;<br>&gt; Let me explain all prop=
osed modifications case-by-case below...<br>&gt;<br>&gt; &gt; &gt; diff --g=
it a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c index<br>&gt; &gt; &=
gt; d43cbcf..f88ba2c 100644<br>&gt; &gt; &gt; --- a/src/openvpn/block_dns.c=
<br>&gt; &gt; &gt; +++ b/src/openvpn/block_dns.c<br>&gt; &gt; &gt; @@ -370,=
7 +370,7 @@ get_interface_metric(const NET_IFINDEX index,<br>&gt; &gt; cons=
t ADDRESS_FAMILY family)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ipiface.Met=
ric;<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; &gt; - =C2=A0 =C2=
=A0return -err;<br>&gt; &gt; &gt; + =C2=A0 =C2=A0return -(int)err;<br>&gt; =
&gt; &gt; =C2=A0}<br>&gt; &gt;<br>&gt; &gt; This, I can somewhat agree to, =
as &quot;err&quot; is an unsigned type so there might be<br>&gt; &gt; a hid=
den integer overflow if it happens to be &quot;large&quot;.=C2=A0 Which it =
won&#39;t be, but<br>&gt; &gt; still.<br>&gt;<br>&gt; Adding the `(int)` re=
solves the warning C4146: unary minus operator<div>&gt; applied to unsigned=
 type, result still unsigned.<br>&gt; <a href=3D"https://msdn.microsoft.com=
/en-us/library/4kh09110.aspx" target=3D"_blank">https://msdn.microsoft.com/=
en-<wbr>us/library/4kh09110.aspx</a><br>&gt;<br>&gt; It doesn&#39;t change =
much, but it shut-ups one compiler warning.<br><br>The original code could =
be argued to be logically wrong (though<br>perfectly legal C) if err become=
s larger than a signed int. This change</div><div>does not fix that. So wha=
t&#39;s the point?<br><br>As an example, consider this<br><br>err =3D <a hr=
ef=3D"tel:(214)%20748-3649" value=3D"+12147483649" target=3D"_blank">214748=
3649</a>=C2=A0(2 more than INT_MAX)<br>Original will return =C2=A0<a href=
=3D"tel:(214)%20748-3647" value=3D"+12147483647" target=3D"_blank">21474836=
47</a>=C2=A0(not a -ve int)<br>The new code will return the same <a href=3D=
"tel:(214)%20748-3647" value=3D"+12147483647" target=3D"_blank">2147483647<=
/a><br>That is, the return value is +ve int which the caller will wrongly<b=
r>interpret as valid result.<br><br>This is hypothetical as Windows system =
err codes do not get that large.<br>But then the original is as good as the=
 replacement except for a <br>C++-trained compiler being silenced.<div><br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">While most of the MSVC co=
mpiler warnings are false-alarms, one out of many does represent a potentia=
l threat. But you don&#39;t know which one that is. Therefore it is best to=
 address them all. :)=C2=A0<br></blockquote><div><br></div><div>To repeat, =
=C2=A0cast does not eliminate a potential for error, it just just hides it.=
</div><div><br></div>Selva<br></div></div></div>

--f403043ae4f43a530d055d48225c--

