MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 00:11:17 -0400
Message-ID: <CAKuzo_hByb0e-3qVkV7zKScfxC3bAUO5MiXdBp3qJzy3uFLikw@...278...>
Content-Type: multipart/alternative; boundary=001a114798b227c6ab0539d8148b
Subject: [Openvpn-devel] [PATCH v4 2/4] Re-implement the systemd support
 using the new query user API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114798b227c6ab0539d8148b
Content-Type: text/plain; charset=UTF-8

(sending again with the list in CC:)

Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <davids@...515...> wrote:

> This provides exactly the same systemd functionality which existed
> before the query user infrastructure got implemented.
>
>   [v4 - change disapproved &= syntax ]
>
>   [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify
>         alternatives definition directly in console.h.  For
>         now only depend on ENABLE_SYSTEMD]
>
>   [v2 - Removed the QUERY_USER_FOREACH macro]
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>
>

-#ifdef QUERY_USER_EXEC_ALTERNATIVE
>

This was introduced in patch 1, and now removed in patch 2. Any particular
reason to split these patches into two? Much easier (and safer -- see below
for why) to review if squashed together.


>
> +++ b/src/openvpn/console_systemd.c
>
> +static bool
> +get_console_input_systemd (const char *prompt, const bool echo, char
> *input, const int capacity)
> +{
> +    int std_out;
> +    bool ret = false;
> +    struct argv argv;
> +
> +    argv_init (&argv);
> +    argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
> +    argv_printf_cat (&argv, "%s", prompt);
> +
> +    if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
> +       return false;
> +    }
> +    CLEAR (*input);
>

Oh, here is a bug that was fixed sometime ago, and its trying to sneak back
in, eh :)  Looks like a copy-paste from an old version. This function was
removed in patch 1 and now added in patch 2 which made it hard to spot
this. Anyway it should be:

memset (input, 0, capacity);


> +    if (read (std_out, input, capacity) != 0)
>

That leaves no room for the terminating NUL. Should be

read (std_out, input, capacity-1)

Not a fault of this patch, the bug was probably there in the original.

Selva

--001a114798b227c6ab0539d8148b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(sending again with the list in CC:)<br><div><span class=
=3D""><br>Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <span dir=3D"ltr">&=
lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</=
a>&gt;</span> wrote:</span><br><span class=3D""></span><div class=3D"gmail_=
quote"><div dir=3D"ltr"><div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><span class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This provides exact=
ly the same systemd functionality which existed<br>
before the query user infrastructure got implemented.<br>
<br>
=C2=A0 [v4 - change disapproved &amp;=3D syntax ]<br>
<br>
=C2=A0 [v3 - Remove QUERY_USER_EXEC_ALTERNATIVE macro, simplify<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 alternatives definition directly in console.h.=
=C2=A0 For<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 now only depend on ENABLE_SYSTEMD]<br>
<br>
=C2=A0 [v2 - Removed the QUERY_USER_FOREACH macro]<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." tar=
get=3D"_blank">davids@...515...</a>&gt;<br>
---<br>
<br></blockquote><div><br><br></div></span><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
-#ifdef QUERY_USER_EXEC_ALTERNATIVE<br></blockquote><div><br></div><div>Thi=
s was introduced in patch 1, and now removed in patch 2. Any particular rea=
son to split these patches into two? Much easier (and safer -- see below fo=
r why) to review if squashed together.<br>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
+++ b/src/openvpn/console_systemd.<wbr>c<span class=3D""><br>
<br>
+static bool<br>
+get_console_input_systemd (const char *prompt, const bool echo, char *inpu=
t, const int capacity)<br>
+{<br>
+=C2=A0 =C2=A0 int std_out;<br>
+=C2=A0 =C2=A0 bool ret =3D false;<br>
+=C2=A0 =C2=A0 struct argv argv;<br>
+<br>
+=C2=A0 =C2=A0 argv_init (&amp;argv);<br>
+=C2=A0 =C2=A0 argv_printf (&amp;argv, SYSTEMD_ASK_PASSWORD_PATH);<br>
+=C2=A0 =C2=A0 argv_printf_cat (&amp;argv, &quot;%s&quot;, prompt);<br>
+<br>
+=C2=A0 =C2=A0 if ((std_out =3D openvpn_popen (&amp;argv, NULL)) &lt; 0) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 CLEAR (*input);<br></span></blockquote><div><br></div><div>O=
h, here is a bug that was fixed sometime ago, and its trying to sneak back =
in, eh :)=C2=A0 Looks like a copy-paste from an old version. This function =
was removed in patch 1 and now added in patch 2 which made it hard to spot =
this. Anyway it should be:<br><br></div><div>memset (input, 0, capacity);<b=
r></div><span class=3D""><div>=C2=A0<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
+=C2=A0 =C2=A0 if (read (std_out, input, capacity) !=3D 0)<br></blockquote>=
<div><br></div></span><div>That leaves no room for the terminating NUL. Sho=
uld be<br><br></div><div>read (std_out, input, capacity-1) <br><br>Not a fa=
ult of this patch, the bug was probably there in the original.<span class=
=3D"HOEnZb"><font color=3D"#888888"><br></font></span></div><span class=3D"=
HOEnZb"><font color=3D"#888888"><div><br></div><div>Selva<br></div></font><=
/span></div></div></div></div>
</div><br></div></div>

--001a114798b227c6ab0539d8148b--

