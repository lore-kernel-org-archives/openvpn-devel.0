Content-Type: multipart/alternative;
 boundary="------------ux5VFnfICh8cYvOg0AotUPcQ"
Message-ID: <861530ad-04c7-ced4-a88b-f71bdc11db0c@...68...>
Date: Sat, 25 Mar 2023 00:02:49 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230323143140.76949-1-frank@...2641...>
 <d917e295-3c4b-2a72-8ce1-6619dce22879@...68...>
 <CAKuzo_iz+johM8uKuFCyRhX8YbtTZCTMNrrcKrC1-ajHNqPigA@...278...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <CAKuzo_iz+johM8uKuFCyRhX8YbtTZCTMNrrcKrC1-ajHNqPigA@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------ux5VFnfICh8cYvOg0AotUPcQ
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 24.03.23 um 22:12 schrieb Selva Nair:
> Hi,
>
> On Fri, Mar 24, 2023 at 4:18=E2=80=AFPM Matthias Andree
> <matthias.andree@...68...> wrote:
>
>     Am 23.03.23 um 15:31 schrieb Frank Lichtenheld:
>     > Currently this is not obvious since we never build the
>     > UTs with MSVC, but it doesn't like the initializers with
>     > "const" variables. They cause
>     > error C2099: initializer is not a constant
>
>     What MSVC version are you using? What options? I've tried with a
>     minimal
>     C program with static const char *const foo =3D "something"; and it
>     compiled with the latest 2017 or 2022 MSVC.
>
>
> That will work but the following wont:
>
> const char=C2=A0*const foo =3D "something";
> const char *const bar =3D foo;
>
> which is essentially the issue at hand. And more of the same with
> struct initialization. As bar has static storage duration, it has to
> be intialized by a "constant expression" which in C does not include
> "const variables". Though it works with gcc.=C2=A0 In C99, automatic
> variables can be intialized so, and the alternative I suggested uses
> that approach.


I must have missed that bar =3D foo part, which is indeed nonconforming
code in C.

With Microsoft tools, I always wonder if it's not easier in practice to
make sure the same source code is also valid C++ and grind it in the C++
mixer^Wcompiler instead.

--------------ux5VFnfICh8cYvOg0AotUPcQ
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">Am 24.03.23 um 22:12 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_iz+johM8uKuFCyRhX8YbtTZCTMNrrcKrC1-ajHNqPigA@...278...">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div dir=3D"ltr">
        <div>Hi,</div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 24, 2023 at
            4:18=E2=80=AFPM Matthias Andree &lt;<a
              href=3D"mailto:matthias.andree@...68..." target=3D"_blank"
              moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">matt=
hias.andree@...68...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 23.03.23 um 15:31
            schrieb Frank Lichtenheld:<br>
            &gt; Currently this is not obvious since we never build the<br>
            &gt; UTs with MSVC, but it doesn't like the initializers
            with<br>
            &gt; "const" variables. They cause<br>
            &gt; error C2099: initializer is not a constant<br>
            <br>
            What MSVC version are you using? What options? I've tried
            with a minimal<br>
            C program with static const char *const foo =3D "something";
            and it<br>
            compiled with the latest 2017 or 2022 MSVC.<br>
          </blockquote>
          <div><br>
          </div>
          <div>That will work but the following wont:</div>
          <div><br>
          </div>
          <div>const char=C2=A0*const foo =3D "something";</div>
          <div>const char *const bar =3D foo;</div>
          <div><br>
          </div>
          <div>which is essentially the issue at hand. And more of the
            same with struct initialization. As bar has static storage
            duration, it has to be intialized by a "constant expression"
            which in C does not include "const variables". Though it
            works with gcc.=C2=A0 In C99, automatic variables can be
            intialized so, and the alternative I suggested uses that
            approach.</div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I must have missed that bar =3D foo part, which is indeed
      nonconforming code in C.<br>
    </p>
    <p>With Microsoft tools, I always wonder if it's not easier in
      practice to make sure the same source code is also valid C++ and
      grind it in the C++ mixer^Wcompiler instead.<br>
    </p>
  </body>
</html>

--------------ux5VFnfICh8cYvOg0AotUPcQ--

