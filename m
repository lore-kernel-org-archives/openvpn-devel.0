MIME-Version: 1.0
References: <20230323143140.76949-1-frank@...2641...>
 <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
In-Reply-To: <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 24 Mar 2023 17:12:02 -0400
Message-ID: <CAKuzo_iz+johM8uKuFCyRhX8YbtTZCTMNrrcKrC1-ajHNqPigA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002706a805f7abd9f4"
Subject: Re: [Openvpn-devel] [PATCH] unit_tests: make cert_data.h compile
 with MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000002706a805f7abd9f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 24, 2023 at 4:18=E2=80=AFPM Matthias Andree <matthias.andree@...1186...=
.68...>
wrote:

> Am 23.03.23 um 15:31 schrieb Frank Lichtenheld:
> > Currently this is not obvious since we never build the
> > UTs with MSVC, but it doesn't like the initializers with
> > "const" variables. They cause
> > error C2099: initializer is not a constant
>
> What MSVC version are you using? What options? I've tried with a minimal
> C program with static const char *const foo =3D "something"; and it
> compiled with the latest 2017 or 2022 MSVC.
>

That will work but the following wont:

const char *const foo =3D "something";
const char *const bar =3D foo;

which is essentially the issue at hand. And more of the same with struct
initialization. As bar has static storage duration, it has to be intialized
by a "constant expression" which in C does not include "const variables".
Though it works with gcc.  In C99, automatic variables can be intialized
so, and the alternative I suggested uses that approach.

Selva

--0000000000002706a805f7abd9f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Mar 24, 2023 at 4:18=E2=80=AFPM Matthias A=
ndree &lt;<a href=3D"mailto:matthias.andree@...68..." target=3D"_blank">mat=
thias.andree@...68...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Am 23.03.23 um 15:31 schrieb Frank Lichtenheld:<br>
&gt; Currently this is not obvious since we never build the<br>
&gt; UTs with MSVC, but it doesn&#39;t like the initializers with<br>
&gt; &quot;const&quot; variables. They cause<br>
&gt; error C2099: initializer is not a constant<br>
<br>
What MSVC version are you using? What options? I&#39;ve tried with a minima=
l<br>
C program with static const char *const foo =3D &quot;something&quot;; and =
it<br>
compiled with the latest 2017 or 2022 MSVC.<br></blockquote><div><br></div>=
<div>That will work but the following wont:</div><div><br></div><div>const =
char=C2=A0*const foo =3D &quot;something&quot;;</div><div>const char *const=
 bar =3D foo;</div><div><br></div><div>which is essentially the issue at ha=
nd. And more of the same with struct initialization. As bar has static stor=
age duration, it has to be intialized by a &quot;constant expression&quot; =
which in C does not include &quot;const variables&quot;. Though it works wi=
th gcc.=C2=A0 In C99, automatic variables can be intialized so, and the alt=
ernative I suggested uses that approach.</div><div><br></div><div>Selva</di=
v></div></div>

--0000000000002706a805f7abd9f4--

