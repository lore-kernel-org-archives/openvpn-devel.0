MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
 <20171105192019.GM958@...1296...>
 <99D61A626FDA8A4B90A270669121BE108587DA0D@...2294...>
 <CAKuzo_hTnJVcEuCqCQ-ZR3swbkio7CWZgy3z5C0fWVJ-E0PCvQ@...278...>
 <99D61A626FDA8A4B90A270669121BE108587DF29@...2294...>
From: Selva <selva.nair@...277...>
Date: Mon, 6 Nov 2017 16:27:54 -0500
Message-ID: <CAKuzo_jFp86anFk6mgavBoYhmCCHUeJ_EQpb6Z05PTNJxBYWWw@...278...>
Content-Type: multipart/alternative; boundary="001a114e6508e0cb91055d5721cc"
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

--001a114e6508e0cb91055d5721cc
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Nov 6, 2017 at 3:35 AM, Simon Rozman <simon@...2293...> wrote:
>
> Hi,
>
> > > > > diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
> > > > > index d43cbcf..f88ba2c 100644
> > > > > --- a/src/openvpn/block_dns.c
> > > > > +++ b/src/openvpn/block_dns.c
> > > > > @@ -370,7 +370,7 @@ get_interface_metric(const NET_IFINDEX index,
> > > > const ADDRESS_FAMILY family)
> > > > >          }
> > > > >          return ipiface.Metric;
> > > > >      }
> > > > > -    return -err;
> > > > > +    return -(int)err;
> > > > >  }
> > > >
> > > > This, I can somewhat agree to, as "err" is an unsigned type so there
> > > > might be a hidden integer overflow if it happens to be "large".
> > > > Which it won't be, but still.
> > >
> > > Adding the `(int)` resolves the warning C4146: unary minus operator
> > > applied to unsigned type, result still unsigned.
> > > https://msdn.microsoft.com/en-us/library/4kh09110.aspx
> > >
> > > It doesn't change much, but it shut-ups one compiler warning.
> >
> > The original code could be argued to be logically wrong (though
perfectly
> > legal C) if err becomes larger than a signed int. This change does not
fix that.
> > So what's the point?
> >
> > As an example, consider this
> >
> > err = 2147483649 <(214)%20748-3649> (2 more than INT_MAX)
> > Original will return  2147483647 <(214)%20748-3647> (not a -ve int) The
new code will return the
> > same 2147483647 <(214)%20748-3647> That is, the return value is +ve int
which the caller will
> > wrongly interpret as valid result.
> >
> > This is hypothetical as Windows system err codes do not get that large.
> > But then the original is as good as the replacement except for a
> > C++-trained compiler being silenced.
>
> I totally agree with your point, the original code might be logically
wrong. If the interface metric is > INT_MAX (which ULONG theoretically
could be), it'll get returned as a negative number => false-positive error
condition.
>
> The get_interface_metric()also return error codes > INT_MAX as a positive
numbers => invalid interface metric instead of error condition. As you
described this case yourself.
>
> > To repeat,  cast does not eliminate a potential for error, it just just
hides it.
>
> True and I totally agree with you. I just didn't dare to rewrite the
function more thoroughly. Can I, please?
>
>
> Option 1: Add an `if` to limit metric to INT_MAX, and an `if` to return
all errors greater than INT_MAX simply as -1.
>
> Option 2: redefine function prototype to return error code unmodified,
and metrics using an extra parameter passed by reference.
>
>
> I'd prefer option 1 after reviewing all get_interface_metrics() calls.
None of them cares about the exact error code. They just test for negative
value and set the metrics to -1. As a matter of fact, the
get_interface_metrics() itself could be rewritten to return -1 as the
metric for any error in the first place, thus making the error checks after
each function call redundant, thus simplifying code.

The best time to re-factor a function would be when a  a new use case
needs to change its semantics. Apart from the ill-chosen -err as a return
value, currently it returns 0 if automatic metric is in use, making it
impossible
to use it as a generic function to find the current metric of an interface.

In fact I've a pending patch where such a change would help.

So, if you re-write this, consider some improvements: I think it belongs to
win32.c (declaration in win32.h). Second, return the current metric
even if Automatic metric is on (could indicate automatic metric needed in
current use case by a boolean parameter, probably). In case of error,
logging it and returning -1 should be good enough.

Based on my tests, Windows does not permit setting a metric
larger than INT_MAX, so a return value of signed int is fine and
convenient for indicating error.

Selva

--001a114e6508e0cb91055d5721cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On Mon, Nov 6, 2017 at 3:35 AM, Simon Rozman &l=
t;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a=
>&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt;<br>&gt; &gt; &gt; &gt; &gt; diff -=
-git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c<br>&gt; &gt; &gt; =
&gt; &gt; index d43cbcf..f88ba2c 100644<br>&gt; &gt; &gt; &gt; &gt; --- a/s=
rc/openvpn/block_dns.c<br>&gt; &gt; &gt; &gt; &gt; +++ b/src/openvpn/block_=
dns.c<br>&gt; &gt; &gt; &gt; &gt; @@ -370,7 +370,7 @@ get_interface_metric(=
const NET_IFINDEX index,<br>&gt; &gt; &gt; &gt; const ADDRESS_FAMILY family=
)<br>&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &=
gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ipiface.Metric;=
<br>&gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; &gt; &gt; &=
gt; - =C2=A0 =C2=A0return -err;<br>&gt; &gt; &gt; &gt; &gt; + =C2=A0 =C2=A0=
return -(int)err;<br>&gt; &gt; &gt; &gt; &gt; =C2=A0}<br>&gt; &gt; &gt; &gt=
;<br>&gt; &gt; &gt; &gt; This, I can somewhat agree to, as &quot;err&quot; =
is an unsigned type so there<br>&gt; &gt; &gt; &gt; might be a hidden integ=
er overflow if it happens to be &quot;large&quot;.<br>&gt; &gt; &gt; &gt; W=
hich it won&#39;t be, but still.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Adding=
 the `(int)` resolves the warning C4146: unary minus operator<br>&gt; &gt; =
&gt; applied to unsigned type, result still unsigned.<br>&gt; &gt; &gt; <a =
href=3D"https://msdn.microsoft.com/en-us/library/4kh09110.aspx" target=3D"_=
blank">https://msdn.microsoft.com/en-<wbr>us/library/4kh09110.aspx</a><br>&=
gt; &gt; &gt;<br>&gt; &gt; &gt; It doesn&#39;t change much, but it shut-ups=
 one compiler warning.<br>&gt; &gt;<br>&gt; &gt; The original code could be=
 argued to be logically wrong (though perfectly<br>&gt; &gt; legal C) if er=
r becomes larger than a signed int. This change does not fix that.<br>&gt; =
&gt; So what&#39;s the point?<br>&gt; &gt;<br>&gt; &gt; As an example, cons=
ider this<br>&gt; &gt;<br>&gt; &gt; err =3D <a href=3D"tel:(214)%20748-3649=
" value=3D"+12147483649" target=3D"_blank">2147483649</a> (2 more than INT_=
MAX)<br>&gt; &gt; Original will return =C2=A0<a href=3D"tel:(214)%20748-364=
7" value=3D"+12147483647" target=3D"_blank">2147483647</a> (not a -ve int) =
The new code will return the<br>&gt; &gt; same <a href=3D"tel:(214)%20748-3=
647" value=3D"+12147483647" target=3D"_blank">2147483647</a> That is, the r=
eturn value is +ve int which the caller will<br>&gt; &gt; wrongly interpret=
 as valid result.<br>&gt; &gt;<br>&gt; &gt; This is hypothetical as Windows=
 system err codes do not get that large.<br>&gt; &gt; But then the original=
 is as good as the replacement except for a<br>&gt; &gt; C++-trained compil=
er being silenced.<br>&gt;<br>&gt; I totally agree with your point, the ori=
ginal code might be logically wrong. If the interface metric is &gt; INT_MA=
X (which ULONG theoretically could be), it&#39;ll get returned as a negativ=
e number =3D&gt; false-positive error condition.<br>&gt;<br>&gt; The get_in=
terface_metric()also return error codes &gt; INT_MAX as a positive numbers =
=3D&gt; invalid interface metric instead of error condition. As you describ=
ed this case yourself.<br>&gt;<br>&gt; &gt; To repeat, =C2=A0cast does not =
eliminate a potential for error, it just just hides it.<br>&gt;<br>&gt; Tru=
e and I totally agree with you. I just didn&#39;t dare to rewrite the funct=
ion more thoroughly. Can I, please?<br>&gt;<br>&gt;<br>&gt; Option 1: Add a=
n `if` to limit metric to INT_MAX, and an `if` to return all errors greater=
 than INT_MAX simply as -1.<br>&gt;<br>&gt; Option 2: redefine function pro=
totype to return error code unmodified, and metrics using an extra paramete=
r passed by reference.<br>&gt;<br>&gt;<br>&gt; I&#39;d prefer option 1 afte=
r reviewing all get_interface_metrics() calls. None of them cares about the=
 exact error code. They just test for negative value and set the metrics to=
 -1. As a matter of fact, the get_interface_metrics() itself could be rewri=
tten to return -1 as the metric for any error in the first place, thus maki=
ng the error checks after each function call redundant, thus simplifying co=
de.<br><br>The best time to re-factor a function would be when a =C2=A0a ne=
w use case<div>needs to change its semantics. Apart from the ill-chosen -er=
r as a return</div><div>value, currently it returns 0 if automatic metric i=
s in use, making it impossible</div><div>to use it as a generic function to=
 find the current metric of an interface.<div><div><br></div><div>In fact I=
&#39;ve a pending patch where such a change would help.</div><div><br></div=
><div>So, if you re-write this, consider some improvements: I think it belo=
ngs to</div><div>win32.c (declaration in win32.h). Second, return the curre=
nt metric=C2=A0</div><div>even if Automatic metric is on (could indicate au=
tomatic metric needed in</div><div>current use case by a boolean parameter,=
 probably). In case of error,</div><div>logging it and returning -1 should =
be good enough.</div><div><br></div><div>Based on my tests, Windows does no=
t permit setting a metric</div><div>larger than INT_MAX, so a return value =
of signed int is fine and</div><div>convenient for indicating error.</div><=
div><br>Selva<br></div></div></div></div>

--001a114e6508e0cb91055d5721cc--

