MIME-Version: 1.0
In-Reply-To: <20170225020229.17287-1-davids@...515...>
References: <20170225020229.17287-1-davids@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 25 Feb 2017 14:42:13 +0500
Message-ID: <CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
Content-Type: multipart/alternative; boundary=001a114b14ca3c46bb054957a9d1
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
	functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b14ca3c46bb054957a9d1
Content-Type: text/plain; charset=UTF-8

there are two another unused functions in misc.c

[src/openvpn/misc.c:661]: (style) The function 'env_set_print' is never
used.
[src/openvpn/misc.c:895]: (style) The function 'setenv_int_i' is never used.

2017-02-25 7:02 GMT+05:00 David Sommerseth <davids@...515...>:

> The env_set_add_to_environmenti() and env_set_remove_from_environment()
> functions where not used in the code at all and they would cause an
> ASSERT() in setenv_str_ex() later on, as it would not allow the
> struct env_set *es pointer to be NULL (misc.c:807).
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/misc.c | 51 ------------------------------
> ---------------------
>  src/openvpn/misc.h |  4 ----
>  2 files changed, 55 deletions(-)
>
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index a2f45b6..68d0687 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -701,57 +701,6 @@ env_set_inherit(struct env_set *es, const struct
> env_set *src)
>      }
>  }
>
> -void
> -env_set_add_to_environment(const struct env_set *es)
> -{
> -    if (es)
> -    {
> -        struct gc_arena gc = gc_new();
> -        const struct env_item *e;
> -
> -        e = es->list;
> -
> -        while (e)
> -        {
> -            const char *name;
> -            const char *value;
> -
> -            if (deconstruct_name_value(e->string, &name, &value, &gc))
> -            {
> -                setenv_str(NULL, name, value);
> -            }
> -
> -            e = e->next;
> -        }
> -        gc_free(&gc);
> -    }
> -}
> -
> -void
> -env_set_remove_from_environment(const struct env_set *es)
> -{
> -    if (es)
> -    {
> -        struct gc_arena gc = gc_new();
> -        const struct env_item *e;
> -
> -        e = es->list;
> -
> -        while (e)
> -        {
> -            const char *name;
> -            const char *value;
> -
> -            if (deconstruct_name_value(e->string, &name, &value, &gc))
> -            {
> -                setenv_del(NULL, name);
> -            }
> -
> -            e = e->next;
> -        }
> -        gc_free(&gc);
> -    }
> -}
>
>  /* add/modify/delete environmental strings */
>
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 16be621..009767f 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -161,10 +161,6 @@ void env_set_print(int msglevel, const struct env_set
> *es);
>
>  void env_set_inherit(struct env_set *es, const struct env_set *src);
>
> -void env_set_add_to_environment(const struct env_set *es);
> -
> -void env_set_remove_from_environment(const struct env_set *es);
> -
>  /* Make arrays of strings */
>
>  const char **make_env_array(const struct env_set *es,
> --
> 2.11.0
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114b14ca3c46bb054957a9d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">there are two another unused functions in misc.c<br><br>[s=
rc/openvpn/misc.c:661]: (style) The function &#39;env_set_print&#39; is nev=
er used.<br>[src/openvpn/misc.c:895]: (style) The function &#39;setenv_int_=
i&#39; is never used.<br></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">2017-02-25 7:02 GMT+05:00 David Sommerseth <span dir=3D"ltr">=
&lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...<=
/a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">The env_set_add_to_enviro=
nmenti() and env_set_remove_from_<wbr>environment()<br>
functions where not used in the code at all and they would cause an<br>
ASSERT() in setenv_str_ex() later on, as it would not allow the<br>
struct env_set *es pointer to be NULL (misc.c:807).<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515...">dav=
ids@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/misc.c | 51 ------------------------------<wbr>----------=
-----------<br>
=C2=A0src/openvpn/misc.h |=C2=A0 4 ----<br>
=C2=A02 files changed, 55 deletions(-)<br>
<br>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br>
index a2f45b6..68d0687 100644<br>
--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -701,57 +701,6 @@ env_set_inherit(struct env_set *es, const struct env_s=
et *src)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void<br>
-env_set_add_to_environment(<wbr>const struct env_set *es)<br>
-{<br>
-=C2=A0 =C2=A0 if (es)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct env_item *e;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D es-&gt;list;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (e)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *value;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deconstruct_name_value(e-&gt=
;<wbr>string, &amp;name, &amp;value, &amp;gc))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setenv_str(NULL, n=
ame, value);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D e-&gt;next;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-void<br>
-env_set_remove_from_<wbr>environment(const struct env_set *es)<br>
-{<br>
-=C2=A0 =C2=A0 if (es)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct env_item *e;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D es-&gt;list;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (e)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *value;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deconstruct_name_value(e-&gt=
;<wbr>string, &amp;name, &amp;value, &amp;gc))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setenv_del(NULL, n=
ame);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D e-&gt;next;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
<br>
=C2=A0/* add/modify/delete environmental strings */<br>
<br>
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h<br>
index 16be621..009767f 100644<br>
--- a/src/openvpn/misc.h<br>
+++ b/src/openvpn/misc.h<br>
@@ -161,10 +161,6 @@ void env_set_print(int msglevel, const struct env_set =
*es);<br>
<br>
=C2=A0void env_set_inherit(struct env_set *es, const struct env_set *src);<=
br>
<br>
-void env_set_add_to_environment(<wbr>const struct env_set *es);<br>
-<br>
-void env_set_remove_from_<wbr>environment(const struct env_set *es);<br>
-<br>
=C2=A0/* Make arrays of strings */<br>
<br>
=C2=A0const char **make_env_array(const struct env_set *es,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.11.0<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div>

--001a114b14ca3c46bb054957a9d1--

