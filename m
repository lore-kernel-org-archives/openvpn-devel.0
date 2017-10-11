MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E33EE@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <67ed8854-4290-468e-9773-2bdde5cd8909@...2080...>
 <99D61A626FDA8A4B90A270669121BE10857E33EE@...2294...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 09:19:57 -0400
Message-ID: <CAKuzo_i2gtJ9YS09mhmf4Y1T0SDiJ=0HHpyW72XFowbOfNJ3CA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c061d3ce7aee1055b4548f7"
Subject: Re: [Openvpn-devel] [PATCH 01/13] snwprintf() => _snwprintf()
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

--94eb2c061d3ce7aee1055b4548f7
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 11, 2017 at 6:06 AM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
> > From a technical point of view, it looks like a fine patch.  But it is
> hard
> > for me
> > (as a non-Windows dev) to understand *why* this is needed.
> > It would be good to explain the rationale for a change so others can
> > understand it as quickly as possible.
>
> snwprintf() is not defined in Windows SDK. _snwprintf() is.
> [https://docs.microsoft.com/en-us/cpp/c-runtime-library/
> reference/snprintf-snprintf-snprintf-l-snwprintf-snwprintf-l]
>
> Mingw probably accepts both. That's why nobody noticed. Looking around
> OpenVPN
> code, I have found some code using _snwprintf(), some snwprintf().
> Probably,
> since MSVC was neglected for so long, nobody paid attention to such a
> subtle
> difference.
>
> For the code to compile on MSVC all snwprintf() should be replaced with
> _snwprintf(). Or, since the prefix underscore imposed by Windows SDK is not
> mostly aesthetical, the following #define could be introduced:
> #ifdef _MSVC_VER
> #define snwprintf _snwprintf
> #endif
>
> Nevertheless, I suggest consistent use of snwprintf/_snwprintf.
>


While its true that mingw accepts both and Windows has only the latter, I
think the best option here is swprintf. Its ISO-C, does the same thing as
_snwprintf with added advantage that nul-termination is guaranteed by the
standard (though we need not bank on that and better continue the practice
of explicit nul termination).  Note that swprintf is like snprintf in that
it takes the buffer size as an argument.

Selva

--94eb2c061d3ce7aee1055b4548f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Oct 11, 2017 at 6:06 AM, Simon Rozman <span dir=3D"ltr">&lt;<a href=
=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
&gt; From a technical point of view, it looks like a fine patch.=C2=A0 But =
it is hard<br>
&gt; for me<br>
&gt; (as a non-Windows dev) to understand *why* this is needed.<br>
&gt; It would be good to explain the rationale for a change so others can<b=
r>
&gt; understand it as quickly as possible.<br>
<br>
</span>snwprintf() is not defined in Windows SDK. _snwprintf() is.<br>
[<a href=3D"https://docs.microsoft.com/en-us/cpp/c-runtime-library/referenc=
e/snprintf-snprintf-snprintf-l-snwprintf-snwprintf-l" rel=3D"noreferrer" ta=
rget=3D"_blank">https://docs.microsoft.com/<wbr>en-us/cpp/c-runtime-library=
/<wbr>reference/snprintf-snprintf-<wbr>snprintf-l-snwprintf-<wbr>snwprintf-=
l</a>]<br>
<br>
Mingw probably accepts both. That&#39;s why nobody noticed. Looking around =
OpenVPN<br>
code, I have found some code using _snwprintf(), some snwprintf(). Probably=
,<br>
since MSVC was neglected for so long, nobody paid attention to such a subtl=
e<br>
difference.<br>
<br>
For the code to compile on MSVC all snwprintf() should be replaced with<br>
_snwprintf(). Or, since the prefix underscore imposed by Windows SDK is not=
<br>
mostly aesthetical, the following #define could be introduced:<br>
#ifdef _MSVC_VER<br>
#define snwprintf _snwprintf<br>
#endif<br>
<br>
Nevertheless, I suggest consistent use of snwprintf/_snwprintf.<br></blockq=
uote><div><br></div><div>=C2=A0</div><div>While its true that mingw accepts=
 both and Windows has only the latter, I think the best option here is swpr=
intf. Its ISO-C, does the same thing as _snwprintf with added advantage tha=
t nul-termination is guaranteed by the standard (though we need not bank on=
 that and better continue the practice of explicit nul termination).=C2=A0 =
Note that swprintf is like snprintf in that it takes the buffer size as an =
argument.</div><div><br></div><div>Selva</div><div><br></div><div>=C2=A0<br=
></div></div></div></div>

--94eb2c061d3ce7aee1055b4548f7--

