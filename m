MIME-Version: 1.0
In-Reply-To: <20180623181530.19484-1-gert@...1296...>
References: <20180623173104.GT57262@...1296...>
 <20180623181530.19484-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 23 Jun 2018 15:11:04 -0400
Message-ID: <CAKuzo_goDTf2pg0CwY6hiR0ehrmTygS+kqnGAGpPUiYp6UyTcg@...278...>
Content-Type: multipart/alternative; boundary="0000000000002ca724056f53ea38"
Subject: Re: [Openvpn-devel] [PATCH v2] Add %d,
 %u and %lu tests to test_argv unit tests.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002ca724056f53ea38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is good enough, but (there is always a but :)

On Sat, Jun 23, 2018 at 2:15 PM, Gert Doering <gert@...1296...> wrote:

> Some basic integer tests to verify signed, unsigned and
> long unsigned (2^33) printing.
>

That 2^33 still lurking in the commit message could go..


>
> Signed-off-by: Gert Doering <gert@...1296...>
> --
> v2: test %lu with "1" as windows and linux/i386 do not have 64 bit long
> ---
>  tests/unit_tests/openvpn/test_argv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/unit_tests/openvpn/test_argv.c
> b/tests/unit_tests/openvpn/test_argv.c
> index 4a3ba559..202a8ff5 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c
> @@ -116,8 +116,12 @@ argv_str__multiple_argv__correct_output(void **state)
>      argv_printf(&a, "%s%sc", PATH1, PATH2);
>      argv_printf_cat(&a, "%s", PARAM1);
>      argv_printf_cat(&a, "%s", PARAM2);
> +    argv_printf_cat(&a, "%d", -1);
> +    argv_printf_cat(&a, "%u", -1);
> +    argv_printf_cat(&a, "%lu", 1 );
>

This triggers a -Wformat warning:

format =E2=80=98%lu=E2=80=99 expects argument of type =E2=80=98long unsigne=
d int=E2=80=99, but argument 3
has type =E2=80=98in=E2=80=99 [-Wformat=3D]

Suggest 1L instead of 1.


>      output =3D argv_str(&a, &gc, PA_BRACKET);
> -    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2
> "]");
> +    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2
> "]"
> +                               " [-1] [4294967295] [1]");


>      argv_reset(&a);
>      gc_free(&gc);
>

ACK otherwise.

Good luck with the game.

Selva

--0000000000002ca724056f53ea38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">This is good enough, but (there is always a but :)</div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Jun 23, 2018 at=
 2:15 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1726...=
..." target=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><span>Some basic integer tests to ve=
rify signed, unsigned and<br>
long unsigned (2^33) printing.<br></span></blockquote><div><br></div><div>T=
hat 2^33 still lurking in the commit message could go..</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span>
<br>
</span>Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." t=
arget=3D"_blank">gert@...1296...</a>&gt;<br>
--<br>
v2: test %lu with &quot;1&quot; as windows and linux/i386 do not have 64 bi=
t long<br>
<span>---<br>
=C2=A0tests/unit_tests/openvpn/<wbr>test_argv.c | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/unit_tests/openvpn/tes<wbr>t_argv.c b/tests/unit_tests/o=
penvpn/tes<wbr>t_argv.c<br>
</span>index 4a3ba559..202a8ff5 100644<br>
<span>--- a/tests/unit_tests/openvpn/tes<wbr>t_argv.c<br>
+++ b/tests/unit_tests/openvpn/tes<wbr>t_argv.c<br>
@@ -116,8 +116,12 @@ argv_str__multiple_argv__corre<wbr>ct_output(void **st=
ate)<br>
=C2=A0 =C2=A0 =C2=A0argv_printf(&amp;a, &quot;%s%sc&quot;, PATH1, PATH2);<b=
r>
=C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;a, &quot;%s&quot;, PARAM1);<br>
=C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;a, &quot;%s&quot;, PARAM2);<br>
+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%d&quot;, -1);<br>
+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%u&quot;, -1);<br>
</span>+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%lu&quot;, 1 );<br></bl=
ockquote><div><br></div><div>This triggers a -Wformat warning:</div><div>=
=C2=A0</div><div>format =E2=80=98%lu=E2=80=99 expects argument of type =E2=
=80=98long unsigned int=E2=80=99, but argument 3 has type =E2=80=98in=E2=80=
=99 [-Wformat=3D]<br></div><div><br></div><div>Suggest 1L instead of 1.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span>=C2=A0 =C2=A0 =C2=A0output =3D argv_str(&amp;a, &amp;gc, PA_BRACKET);=
<br>
-=C2=A0 =C2=A0 assert_string_equal(output, &quot;[&quot; PATH1 PATH2 &quot;=
] [&quot; PARAM1 &quot;] [&quot; PARAM2 &quot;]&quot;);<br>
+=C2=A0 =C2=A0 assert_string_equal(output, &quot;[&quot; PATH1 PATH2 &quot;=
] [&quot; PARAM1 &quot;] [&quot; PARAM2 &quot;]&quot;<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; [-1] [4294967295] [1]&q=
uot;);=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"gmail-m_3288186890819326676HOEnZb"><div class=3D"gmail-m_3288=
186890819326676h5">=C2=A0<br>
=C2=A0 =C2=A0 =C2=A0argv_reset(&amp;a);<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br></div></div></blockquote><div><br>=
</div><div>ACK otherwise.</div><div><br></div><div>Good luck with the game.=
</div><div><br></div><div>Selva</div></div></div></div>

--0000000000002ca724056f53ea38--

