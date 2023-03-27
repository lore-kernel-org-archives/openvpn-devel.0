Content-Type: multipart/alternative;
 boundary="------------MxvKkLFUJRj0PTE0dGIiilbb"
Message-ID: <bf4dac04-2258-ad3d-4929-fe17f0c2cfe3@...68...>
Date: Mon, 27 Mar 2023 21:45:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230327114937.28246-1-selva.nair@...277...>
 <139d5059-25b8-e968-2996-5b3bc225ba3b@...68...>
 <CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make cert_data.h and
 test_cryptoapi/pkcs11.c MSVC compliant
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
--------------MxvKkLFUJRj0PTE0dGIiilbb
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 27.03.23 um 16:45 schrieb Selva Nair:
> Hi,
>
> On Mon, Mar 27, 2023 at 9:59=E2=80=AFAM Matthias Andree
> <matthias.andree@...68...> wrote:
>
>     Am 27.03.23 um 13:49 schrieb selva.nair@...277...:
>     > From: Selva Nair <selva.nair@...277...>
>     >
>     > - Do not use non-literal initializers for static objects
>     > - Replace empty initializer {} by {0}
>
>     Should we go to a revision, I would suggest to not make something
>     compliant to a compiler because that is assigning it way too much
>     power
>     and control. A terms such as "ready to be compiled with MSVC" or so
>     would be in order, or making this code compliant with some wisely
>     chosen
>     version of the ISO 9899 standard, aka. standard C.
>
>
> In this case "MSVC compliant" was arguably a poor choice of words as
> what the change=C2=A0does is to avoid non-C99 constructs. However it made
> sense to refer to MSVC in the context of what prompted this patch.
>
> That said, in a cross-platform code base one often has to make changes
> to please compilers just to get things to build.

I don't mind what we're doing here... just that I want to avoid the
impression as though MSVC were setting the standards. There's always
MinGW-GCC...

That being said, here's a proposal:

-----

Subject: Make cert_data.h and test_cryptoapi/pkcs11.c C99 compliant

...to fix compilation on MSVC 2143 <insert actual version and relevant C
language settings here>:

- Do not use non-literal initializers for static objects
- Replace empty initializer {} by {0}

>     > Signed-off-by: Selva Nair <selva.nair@...277...>
>
-----


> I was not getting rid of any defines -- just trying to avoid defines
> if it can be done without jumping through too many hoops. Right,
> (key1) would be better.
>
> Instead of making key2 local, we can write it out fully without
> referring to the fact that key1 =3D key2. The latter was anyway a lazy
> man's choice, not relevant for the working of the tests.
>
> If anyone feels strongly I can submit a v2 with key2, key4, and cname4
> fully written out like:

That is not what I am proposing, redundance in source code is not a
valid "fix" or approach... -> [1]

It's just... I have been writing too much C++14 or C++17 code lately (on
MSVC 2015, 2017, 2022 and with MS Build Tools 2019 because that was the
customer's newest-limit) to want to mess with C limitations that serve
their purpose on paper, but are getting in the way in practice. Of
course then you have discussions about C++ linkage (the only reasonable
solution is "avoid"), exceptions (serious discussion what and where) and
about contributors. I am aware C++ is abhorred by some but I usually
find they set their minds in the first decade of the millennium,
literally before C++11, but that would also be the side door to sneak it
in because people who believe their strange OS doesn't have a C++
compiler can still compile OpenVPN proper, just not unit tests.


> That may also make maintaining this data easier -- ie., any cert/key
> pair could be replaced without affecting others.
[1] So I would go the pragmatic way here and just change once there is
really a need to replace certificates. It's only a test after all.

--------------MxvKkLFUJRj0PTE0dGIiilbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">Am 27.03.23 um 16:45 schrieb Selva
      Nair:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div dir=3D"ltr">
        <div>Hi,</div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 27, 2023 at
            9:59=E2=80=AFAM Matthias Andree &lt;<a
              href=3D"mailto:matthias.andree@...68..." target=3D"_blank"
              moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">matt=
hias.andree@...68...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 27.03.23 um 13:49
            schrieb <a href=3D"mailto:selva.nair@...277..."
              target=3D"_blank" moz-do-not-send=3D"true"
              class=3D"moz-txt-link-freetext">selva.nair@...277...</a>:<br>
            &gt; From: Selva Nair &lt;<a
              href=3D"mailto:selva.nair@...277..." target=3D"_blank"
              moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">selv=
a.nair@...277...</a>&gt;<br>
            &gt;<br>
            &gt; - Do not use non-literal initializers for static
            objects<br>
            &gt; - Replace empty initializer {} by {0}<br>
            <br>
            Should we go to a revision, I would suggest to not make
            something<br>
            compliant to a compiler because that is assigning it way too
            much power<br>
            and control. A terms such as "ready to be compiled with
            MSVC" or so<br>
            would be in order, or making this code compliant with some
            wisely chosen<br>
            version of the ISO 9899 standard, aka. standard C.<br>
          </blockquote>
          <div><br>
          </div>
          <div>In this case "MSVC compliant" was arguably a poor choice
            of words as what the change=C2=A0does is to avoid non-C99
            constructs. However it made sense to refer to MSVC in the
            context of what prompted this patch.<br>
          </div>
          <div><br>
          </div>
          <div>That said, in a cross-platform code base one often has to
            make changes to please compilers just to get things to
            build.</div>
        </div>
      </div>
    </blockquote>
    <p>I don't mind what we're doing here... just that I want to avoid
      the impression as though MSVC were setting the standards. There's
      always MinGW-GCC...<br>
    </p>
    <p>That being said, here's a proposal:<br>
    </p>
    <p>-----</p>
    <p>Subject: Make cert_data.h and test_cryptoapi/pkcs11.c C99
      compliant</p>
    <p>...to fix compilation on MSVC 2143 &lt;insert actual version and
      relevant C language settings here&gt;:<br>
      <br>
      - Do not use non-literal initializers for static objects<br>
      - Replace empty initializer {} by {0}</p>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            &gt; Signed-off-by: Selva Nair &lt;<a
              href=3D"mailto:selva.nair@...277..." target=3D"_blank"
              moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">selv=
a.nair@...277...</a>&gt;<br>
            <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>-----<br>
    </p>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>I was not getting rid of any defines -- just trying to
            avoid defines if it can be done without jumping through too
            many hoops. Right, (key1) would be better.<br>
          </div>
          <div><br>
          </div>
          <div>Instead of making key2 local, we can write it out fully
            without referring to the fact that key1 =3D key2. The latter
            was anyway a lazy man's choice, not relevant for the working
            of the tests.</div>
          <div><br>
          </div>
          <div>If anyone feels strongly I can submit a v2 with key2,
            key4, and cname4 fully written out like:</div>
        </div>
      </div>
    </blockquote>
    <p>That is not what I am proposing, redundance in source code is not
      a valid "fix" or approach... -&gt; [1]<br>
    </p>
    <p>It's just... I have been writing too much C++14 or C++17 code
      lately (on MSVC 2015, 2017, 2022 and with MS Build Tools 2019
      because that was the customer's newest-limit) to want to mess with
      C limitations that serve their purpose on paper, but are getting
      in the way in practice. Of course then you have discussions about
      C++ linkage (the only reasonable solution is "avoid"), exceptions
      (serious discussion what and where) and about contributors. I am
      aware C++ is abhorred by some but I usually find they set their
      minds in the first decade of the millennium, literally before
      C++11, but that would also be the side door to sneak it in because
      people who believe their strange OS doesn't have a C++ compiler
      can still compile OpenVPN proper, just not unit tests.<br>
    </p>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:CAKuzo_iMkMXqvHTSX5ZmcurBhx3GT8rd_dbowmtnjaZORyyH1Q@...278...">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">That may also make maintaining this
          data easier -- ie., any cert/key pair could be replaced
          without affecting others.<br>
        </div>
      </div>
    </blockquote>
    [1] So I would go the pragmatic way here and just change once there
    is really a need to replace certificates. It's only a test after
    all.<br>
  </body>
</html>

--------------MxvKkLFUJRj0PTE0dGIiilbb--

