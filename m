MIME-Version: 1.0
In-Reply-To: <20180623191538.29317-1-gert@...1296...>
References: <CAKuzo_goDTf2pg0CwY6hiR0ehrmTygS+kqnGAGpPUiYp6UyTcg@...278...>
 <20180623191538.29317-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 23 Jun 2018 15:21:46 -0400
Message-ID: <CAKuzo_hO+jEgANaMSydn2xNr5=1jTbCzNDEKhk-Cy59jCzWr5Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000067e69d056f54103a"
Subject: Re: [Openvpn-devel] [PATCH v3] Add %d,
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

--00000000000067e69d056f54103a
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Jun 23, 2018 at 3:15 PM, Gert Doering <gert@...1296...> wrote:

> Some basic integer tests to verify signed, unsigned and
> long unsigned (1L) printing.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> --
> v2: test %lu with "1" as windows and linux/i386 do not have 64 bit long
> v3: fix 2^33 in commit message, use "1L" for proper data type (Selva)
> ---
>  tests/unit_tests/openvpn/test_argv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/unit_tests/openvpn/test_argv.c
> b/tests/unit_tests/openvpn/test_argv.c
> index 4a3ba559..0fdd3f0a 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c
> @@ -116,8 +116,12 @@ argv_str__multiple_argv__correct_output(void **state)
>      argv_printf(&a, "%s%sc", PATH1, PATH2);
>      argv_printf_cat(&a, "%s", PARAM1);
>      argv_printf_cat(&a, "%s", PARAM2);
> +    argv_printf_cat(&a, "%d", -1);
> +    argv_printf_cat(&a, "%u", -1);
> +    argv_printf_cat(&a, "%lu", 1L );
>      output = argv_str(&a, &gc, PA_BRACKET);
> -    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2
> "]");
> +    assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2
> "]"
> +                               " [-1] [4294967295] [1]");
>
>      argv_reset(&a);
>      gc_free(&gc);
>


Looks good now. An unconditional ACK this time.

Selva

--00000000000067e69d056f54103a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Sat, Jun 23, 2018 at 3:15 PM, Gert Doering <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Some ba=
sic integer tests to verify signed, unsigned and<br>
</span>long unsigned (1L) printing.<br>
<span class=3D""><br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
--<br>
v2: test %lu with &quot;1&quot; as windows and linux/i386 do not have 64 bi=
t long<br>
</span>v3: fix 2^33 in commit message, use &quot;1L&quot; for proper data t=
ype (Selva)<br>
<span class=3D"">---<br>
=C2=A0tests/unit_tests/openvpn/test_<wbr>argv.c | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/unit_tests/openvpn/<wbr>test_argv.c b/tests/unit_tests/o=
penvpn/<wbr>test_argv.c<br>
</span>index 4a3ba559..0fdd3f0a 100644<br>
<span class=3D"">--- a/tests/unit_tests/openvpn/<wbr>test_argv.c<br>
+++ b/tests/unit_tests/openvpn/<wbr>test_argv.c<br>
@@ -116,8 +116,12 @@ argv_str__multiple_argv__<wbr>correct_output(void **st=
ate)<br>
=C2=A0 =C2=A0 =C2=A0argv_printf(&amp;a, &quot;%s%sc&quot;, PATH1, PATH2);<b=
r>
=C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;a, &quot;%s&quot;, PARAM1);<br>
=C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;a, &quot;%s&quot;, PARAM2);<br>
+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%d&quot;, -1);<br>
+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%u&quot;, -1);<br>
</span>+=C2=A0 =C2=A0 argv_printf_cat(&amp;a, &quot;%lu&quot;, 1L );<br>
<span class=3D"im HOEnZb">=C2=A0 =C2=A0 =C2=A0output =3D argv_str(&amp;a, &=
amp;gc, PA_BRACKET);<br>
-=C2=A0 =C2=A0 assert_string_equal(output, &quot;[&quot; PATH1 PATH2 &quot;=
] [&quot; PARAM1 &quot;] [&quot; PARAM2 &quot;]&quot;);<br>
+=C2=A0 =C2=A0 assert_string_equal(output, &quot;[&quot; PATH1 PATH2 &quot;=
] [&quot; PARAM1 &quot;] [&quot; PARAM2 &quot;]&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; [-1] [4294967295] [1]&quot;);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0argv_reset(&amp;a);<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br></span></blockquote><div><br></div=
><div><br></div><div>Looks good now. An unconditional ACK this time.</div><=
div><br></div><div>Selva</div></div></div></div></div>

--00000000000067e69d056f54103a--

