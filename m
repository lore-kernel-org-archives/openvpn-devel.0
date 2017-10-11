MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-5-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-5-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 09:21:12 -0400
Message-ID: <CAKuzo_iQtWLganoH3n39hASRThrqmpHYh8ec=STm9yxeeROGYg@...278...>
Content-Type: multipart/alternative; boundary="f403043ae6046b82fb055b454da4"
Subject: Re: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared
 as "typedef <return type> (<calling convention> *type_name)(<arguments>)"
 in MSVC.
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

--f403043ae6046b82fb055b454da4
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for these patches.

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> Note: NETIOAPI_API is defined as:
> #define NETIOAPI_API NETIO_STATUS NETIOAPI_API_
> #define NETIOAPI_API_ WINAPI
>
> I am not sure whether interactive.c will compile using mingw with this
> patch. If not:
> 1. We can introduce some
>    #ifdef _MSC_VER
>    #else
>    #endif
> 2. Since NTDDI_VERSION=NTDDI_VISTA, most of the dynamic API loading by
> GetProcAddress() could be simplified to statically linked API calls,
> avoiding function prototype declarations altogether. I suggest we do this
> anyway to clean-up the code in the future.


Yes, those declarations and run-time lookup were slated for removal but
somehow never happened. Its a good idea to get rid of those -- no point in
tweaking them to suit MSVC.

IIRC, at least the versions of mingw that I use (gcc 4.9.3 or later) will
build with those stripped but I can test again if you replace this patch
with one removing those declarations.

Selva

--f403043ae6046b82fb055b454da4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">Thanks for these patches.</div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Tue, Oct 10, 2017 at 7:11 PM,  <span dir=3D"=
ltr">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2311...=
3...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Simon Ro=
zman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2311...=
3...</a>&gt;<br>
<br>
Note: NETIOAPI_API is defined as:<br>
#define NETIOAPI_API NETIO_STATUS NETIOAPI_API_<br>
#define NETIOAPI_API_ WINAPI<br>
<br>
I am not sure whether interactive.c will compile using mingw with this patc=
h. If not:<br>
1. We can introduce some<br>
=C2=A0 =C2=A0#ifdef _MSC_VER<br>
=C2=A0 =C2=A0#else<br>
=C2=A0 =C2=A0#endif<br>
2. Since NTDDI_VERSION=3DNTDDI_VISTA, most of the dynamic API loading by Ge=
tProcAddress() could be simplified to statically linked API calls, avoiding=
 function prototype declarations altogether. I suggest we do this anyway to=
 clean-up the code in the future.</blockquote><div><br></div><div>Yes, thos=
e declarations and run-time lookup were slated for removal but somehow neve=
r happened. Its a good idea to get rid of those -- no point in tweaking the=
m to suit MSVC. =C2=A0</div><div><br></div><div>IIRC, at least the versions=
 of mingw that I use (gcc 4.9.3 or later) will build with those stripped bu=
t I can test again if you replace this patch with one removing those declar=
ations.</div><div><br></div><div>Selva</div></div></div></div></div>

--f403043ae6046b82fb055b454da4--

