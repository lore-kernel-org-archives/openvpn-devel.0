MIME-Version: 1.0
In-Reply-To: <40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
	<40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 25 Feb 2017 18:45:36 +0500
Message-ID: <CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
Content-Type: multipart/alternative; boundary=f403045f1652ad159305495b0ff0
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

--f403045f1652ad159305495b0ff0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-02-25 16:49 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 25/02/17 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > there are two another unused functions in misc.c
> >
> > [src/openvpn/misc.c:661]: (style) The function 'env_set_print' is never
> > used.
>
> This one is useful for debugging purposes, so I let this one stay.  I
> did consider an #if 0 around it, to make it more explicit.  But I
> thought we have enough of those.  It could make some compiler warnings
> go away though disabling it.
>


it is good idea to put "#if 0" around debug items (that are not used
generally)

[src/openvpn/error.c:824]: (error) Null pointer dereference


>
> > [src/openvpn/misc.c:895]: (style) The function 'setenv_int_i' is never
> used.
>
> Ahh, that one I didn't check for.  I'll have a closer look if that is
> something we should let it survive or take that one out too.
>
> The most troubling issue with those two functions in the patch is that
> if they were to be used, it would actually make OpenVPN halt and exit
> due to the ASSERT() check not being fulfilled later on in the call
> chain.  setenv_str() calls setenv_str_ex() which checks if the pointer
> to a struct set_env is NULL or not.  If it is NULL, it stops.  And these
> two functions ends up calling setenv_str_ex() with
> struct env_set *es =3D NULL;
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
> > 2017-02-25 7:02 GMT+05:00 David Sommerseth <davids@...515...
> > <mailto:davids@...515...>>:
> >
> >     The env_set_add_to_environmenti() and env_set_remove_from_
> environment()
> >     functions where not used in the code at all and they would cause an
> >     ASSERT() in setenv_str_ex() later on, as it would not allow the
> >     struct env_set *es pointer to be NULL (misc.c:807).
> >
> >     Signed-off-by: David Sommerseth <davids@...515...
> >     <mailto:davids@...515...>>
> >     ---
> >      src/openvpn/misc.c | 51
> >     ---------------------------------------------------
> >      src/openvpn/misc.h |  4 ----
> >      2 files changed, 55 deletions(-)
> >
> >     diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> >     index a2f45b6..68d0687 100644
> >     --- a/src/openvpn/misc.c
> >     +++ b/src/openvpn/misc.c
> >     @@ -701,57 +701,6 @@ env_set_inherit(struct env_set *es, const
> >     struct env_set *src)
> >          }
> >      }
> >
> >     -void
> >     -env_set_add_to_environment(const struct env_set *es)
> >     -{
> >     -    if (es)
> >     -    {
> >     -        struct gc_arena gc =3D gc_new();
> >     -        const struct env_item *e;
> >     -
> >     -        e =3D es->list;
> >     -
> >     -        while (e)
> >     -        {
> >     -            const char *name;
> >     -            const char *value;
> >     -
> >     -            if (deconstruct_name_value(e->string, &name, &value,
> &gc))
> >     -            {
> >     -                setenv_str(NULL, name, value);
> >     -            }
> >     -
> >     -            e =3D e->next;
> >     -        }
> >     -        gc_free(&gc);
> >     -    }
> >     -}
> >     -
> >     -void
> >     -env_set_remove_from_environment(const struct env_set *es)
> >     -{
> >     -    if (es)
> >     -    {
> >     -        struct gc_arena gc =3D gc_new();
> >     -        const struct env_item *e;
> >     -
> >     -        e =3D es->list;
> >     -
> >     -        while (e)
> >     -        {
> >     -            const char *name;
> >     -            const char *value;
> >     -
> >     -            if (deconstruct_name_value(e->string, &name, &value,
> &gc))
> >     -            {
> >     -                setenv_del(NULL, name);
> >     -            }
> >     -
> >     -            e =3D e->next;
> >     -        }
> >     -        gc_free(&gc);
> >     -    }
> >     -}
> >
> >      /* add/modify/delete environmental strings */
> >
> >     diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> >     index 16be621..009767f 100644
> >     --- a/src/openvpn/misc.h
> >     +++ b/src/openvpn/misc.h
> >     @@ -161,10 +161,6 @@ void env_set_print(int msglevel, const struct
> >     env_set *es);
> >
> >      void env_set_inherit(struct env_set *es, const struct env_set *src=
);
> >
> >     -void env_set_add_to_environment(const struct env_set *es);
> >     -
> >     -void env_set_remove_from_environment(const struct env_set *es);
> >     -
> >      /* Make arrays of strings */
> >
> >      const char **make_env_array(const struct env_set *es,
> >     --
> >     2.11.0
> >
> >
> >     ------------------------------------------------------------
> ------------------
> >     Check out the vibrant tech community on one of the world's most
> >     engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> >     _______________________________________________
> >     Openvpn-devel mailing list
> >     Openvpn-devel@lists.sourceforge.net
> >     <mailto:Openvpn-devel@lists.sourceforge.net>
> >     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
> >
> >
> >
> >
> > ------------------------------------------------------------
> ------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>
>
>
>

--f403045f1652ad159305495b0ff0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-25 16:49 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a ta=
rget=3D"_blank" href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">On 25/02/17=
 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 wrote:<br>
&gt; there are two another unused functions in misc.c<br>
&gt;<br>
&gt; [src/openvpn/misc.c:661]: (style) The function &#39;env_set_print&#39;=
 is never<br>
&gt; used.<br>
<br>
This one is useful for debugging purposes, so I let this one stay.=C2=A0 I<=
br>
did consider an #if 0 around it, to make it more explicit.=C2=A0 But I<br>
thought we have enough of those.=C2=A0 It could make some compiler warnings=
<br>
go away though disabling it.<br></blockquote><div><br><br></div><div>it is =
good idea to put &quot;#if 0&quot; around debug items (that are not used ge=
nerally)<br><br>[src/openvpn/error.c:824]: (error) Null pointer dereference=
<br></div><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote=
">
<br>
&gt; [src/openvpn/misc.c:895]: (style) The function &#39;setenv_int_i&#39; =
is never used.<br>
<br>
Ahh, that one I didn&#39;t check for.=C2=A0 I&#39;ll have a closer look if =
that is<br>
something we should let it survive or take that one out too.<br>
<br>
The most troubling issue with those two functions in the patch is that<br>
if they were to be used, it would actually make OpenVPN halt and exit<br>
due to the ASSERT() check not being fulfilled later on in the call<br>
chain.=C2=A0 setenv_str() calls setenv_str_ex() which checks if the pointer=
<br>
to a struct set_env is NULL or not.=C2=A0 If it is NULL, it stops.=C2=A0 An=
d these<br>
two functions ends up calling setenv_str_ex() with<br>
struct env_set *es =3D NULL;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
&gt; 2017-02-25 7:02 GMT+05:00 David Sommerseth &lt;<a href=3D"mailto:david=
s@...515...">davids@...515...</a><br>
&gt; &lt;mailto:<a href=3D"mailto:davids@...515...">davids@...515...</a>&gt=
;&gt;:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The env_set_add_to_environmenti() and env_set_remov=
e_from_<wbr>environment()<br>
&gt;=C2=A0 =C2=A0 =C2=A0functions where not used in the code at all and the=
y would cause an<br>
&gt;=C2=A0 =C2=A0 =C2=A0ASSERT() in setenv_str_ex() later on, as it would n=
ot allow the<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct env_set *es pointer to be NULL (misc.c:807).=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: David Sommerseth &lt;<a href=3D"mail=
to:davids@...515...">davids@...515...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:davids@...515...">davi=
ds@...515...</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 src/openvpn/misc.c | 51<br>
&gt;=C2=A0 =C2=A0 =C2=A0------------------------------<wbr>----------------=
-----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 src/openvpn/misc.h |=C2=A0 4 ----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 2 files changed, 55 deletions(-)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/src/openvpn/misc.c b/src/openvpn/misc.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index a2f45b6..68d0687 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/src/openvpn/misc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/src/openvpn/misc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -701,57 +701,6 @@ env_set_inherit(struct env_set=
 *es, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct env_set *src)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void<br>
&gt;=C2=A0 =C2=A0 =C2=A0-env_set_add_to_environment(<wbr>const struct env_s=
et *es)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (es)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_arena gc =3D=
 gc_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct env_item =
*e;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D es-&gt;list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (e)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const ch=
ar *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const ch=
ar *value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deco=
nstruct_name_value(e-&gt;<wbr>string, &amp;name, &amp;value, &amp;gc))<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 setenv_str(NULL, name, value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D e-=
&gt;next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-}<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void<br>
&gt;=C2=A0 =C2=A0 =C2=A0-env_set_remove_from_<wbr>environment(const struct =
env_set *es)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (es)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_arena gc =3D=
 gc_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct env_item =
*e;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D es-&gt;list;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (e)<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const ch=
ar *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const ch=
ar *value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deco=
nstruct_name_value(e-&gt;<wbr>string, &amp;name, &amp;value, &amp;gc))<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 setenv_del(NULL, name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D e-=
&gt;next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gc_free(&amp;gc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0-}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* add/modify/delete environmental strings */<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/src/openvpn/misc.h b/src/openvpn/misc.=
h<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 16be621..009767f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/src/openvpn/misc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/src/openvpn/misc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -161,10 +161,6 @@ void env_set_print(int msgleve=
l, const struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0env_set *es);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 void env_set_inherit(struct env_set *es, const str=
uct env_set *src);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void env_set_add_to_environment(<wbr>const struct =
env_set *es);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void env_set_remove_from_<wbr>environment(const st=
ruct env_set *es);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Make arrays of strings */<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const char **make_env_array(const struct env_set *=
es,<br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A02.11.0<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0------------------------------<wbr>----------------=
--------------<wbr>------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0Check out the vibrant tech community on one of the =
world&#39;s most<br>
&gt;=C2=A0 =C2=A0 =C2=A0engaging tech sites, SlashDot.org! <a target=3D"_bl=
ank" rel=3D"noreferrer" href=3D"http://sdm.link/slashdot">http://sdm.link/s=
lashdot</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0______________________________<wbr>________________=
_<br>
&gt;=C2=A0 =C2=A0 =C2=A0Openvpn-devel mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Openvpn-devel@...1223...=
et">Openvpn-devel@...1199...<wbr>sourceforge.net</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@...1199...<wbr>sourceforge.net</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a target=3D"_blank" rel=3D"noreferrer" href=3D"htt=
ps://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sour=
ceforge.net/<wbr>lists/listinfo/openvpn-devel</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D=
"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.=
sourceforge.<wbr>net/lists/listinfo/openvpn-<wbr>devel</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
------------------<br>
&gt; Check out the vibrant tech community on one of the world&#39;s most<br>
&gt; engaging tech sites, SlashDot.org! <a target=3D"_blank" rel=3D"norefer=
rer" href=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...220...=
..1199...<wbr>sourceforge.net</a><br>
&gt; <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourcefo=
rge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>li=
sts/listinfo/openvpn-devel</a><br>
&gt;<br>
<br>
<br>
<br>
<br>
</blockquote></div><br></div></div>

--f403045f1652ad159305495b0ff0--

