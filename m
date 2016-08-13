MIME-Version: 1.0
In-Reply-To: <1470684488-21307-2-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-2-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 23:48:24 -0400
Message-ID: <CAKuzo_ggo2A5hFwe3u=+fwAWBoRQxhRvf_LDTCsSTrSLU+AZCA@...278...>
Content-Type: multipart/alternative; boundary=001a1137b98e2c28b60539ebe0a6
Subject: Re: [Openvpn-devel] [PATCH v4 1/4] Rework the user input interface
 to make it more modular
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1137b98e2c28b60539ebe0a6
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <davids@...515...> wrote:

> This is will provide an interface for other mechanisms to be used to
> query the user for information, such as usernames, passwords, etc.
>
> It has also been a goal to make it possible to query for all the
> information in one call and not do it sequencially as before.
>
>  [v4 - add a simple wrapper combining query_user_{init,add,exec}()
>      - change disapproved &= syntax ]
>
>  [v3 - Avoid the dynamic list, use a static list of QUERY_USER_NUMSLOTS
>      - The list of query_user data is now a global variable
>      - Replaced query_user_init() with query_user_clear()
>      - Make query_user_add() a void function
>      - Rebased against master/600dd9a16fc61 ]
>
>  [v2 - Removed the QUERY_USER_FOREACH macro
>
> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 268f3fe..44d49ef 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -6,6 +6,8 @@
>   *             packet compression.
>   *
>   *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...
> >
> + *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
> + *  Copyright (C) 2016      David Sommerseth <davids@...515...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> @@ -27,7 +29,90 @@
>
>  #include "basic.h"
>
> -bool
> -get_console_input (const char *prompt, const bool echo, char *input,
> const int capacity);
> +/**
> + *  Configuration setup for declaring what kind of information to ask a
> user for
> + */
> +struct _query_user {

+    char *prompt;             /**< Prompt to present to the user */
> +    size_t prompt_len;        /**< Lenght of the prompt string */
> +    char *response;           /**< The user's response */
> +    size_t response_len;      /**< Lenght the of the user reposone */
> +    bool echo;                /**< True: The user should see what is
> being typed, otherwise mask it */
> +};
> +
> +#define QUERY_USER_NUMSLOTS 10
> +extern struct _query_user query_user[];  /**< Global variable, declared
> in console.c */
>

Hmm... this is wading into style territory, so I'll move on by just
mumbling that leading underscore in struct names serves no useful purpose.

In misc.c:


>                 }
> @@ -1184,32 +1192,46 @@ get_user_pass_cr (struct user_pass *up,
>               struct buffer user_prompt = alloc_buf_gc (128, &gc);
>               struct buffer pass_prompt = alloc_buf_gc (128, &gc);
>
> +             query_user_clear ();
>               buf_printf (&user_prompt, "Enter %s Username:", prefix);
>               buf_printf (&pass_prompt, "Enter %s Password:", prefix);
>

>               if (username_from_stdin && !(flags &
> GET_USER_PASS_PASSWORD_ONLY))
>                 {
> -                 if (!get_console_input (BSTR (&user_prompt), true,
> up->username, USER_PASS_LEN))
> -                   msg (M_FATAL, "ERROR: could not read %s username from
> stdin", prefix);
> +                 query_user_add (BSTR(&user_prompt), BLEN(&user_prompt),
> +                                  up->username, USER_PASS_LEN, true);
> +               }
> +
> +             query_user_add (BSTR(&pass_prompt), BLEN(&pass_prompt),
> +                              up->password, USER_PASS_LEN, false);
>

The above call should be conditional on "if (password_from_stdin)". Else it
will get called even after reading password from a file. Unfortunately
get_user_pass_cr() has become so fragile after repeated hacks, its so easy
to break it...

The following may sound harsh, but that's not the intention. I've spent
hours on these patches now, so just trying to get the best out of it:
In the end, I'm not sure what is achieved by this new framework. I see
multiple queries can be combined into one exec call, but the way its used
in get_user_pass_cr() does not make full use of it. Sure, username and
password are prompted in one call, but static challenge is still handled by
an additional call. FWIW, to be true to the spirit of the implementation, a
request for username/password/static-challenge-response should result in
only one call to query_user_exec, not two. Only then one can even remotely
hope to have a way prompting the user for all that info in one dialog by
some future ask-password agent.  Unless you set a clear style and guidance
here, over time  this will degenerate into something logically identical to
the original code except for different function names and twice the
function calls.

Even with one exec call, finally systemd-ask-password has to be called
multiple times and it seems currently there are no agents that could take
multiple queries and prompt the user in one dialog, for example.

Its more like a solution looking for a problem. Which is not a bad thing
per se..

Regards,

Selva

--001a1137b98e2c28b60539ebe0a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <span dir=3D"ltr">&=
lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This is will provide=
 an interface for other mechanisms to be used to<br>
query the user for information, such as usernames, passwords, etc.<br>
<br>
It has also been a goal to make it possible to query for all the<br>
information in one call and not do it sequencially as before.<br>
<br>
=C2=A0[v4 - add a simple wrapper combining query_user_{init,add,exec}()<br>
=C2=A0 =C2=A0 =C2=A0- change disapproved &amp;=3D syntax ]<br>
<br>
=C2=A0[v3 - Avoid the dynamic list, use a static list of QUERY_USER_NUMSLOT=
S<br>
=C2=A0 =C2=A0 =C2=A0- The list of query_user data is now a global variable<=
br>
=C2=A0 =C2=A0 =C2=A0- Replaced query_user_init() with query_user_clear()<br>
=C2=A0 =C2=A0 =C2=A0- Make query_user_add() a void function<br>
=C2=A0 =C2=A0 =C2=A0- Rebased against master/600dd9a16fc61 ]<br>
<br>
=C2=A0[v2 - Removed the QUERY_USER_FOREACH macro<br><br>
diff --git a/src/openvpn/console.h b/src/openvpn/console.h<br>
index 268f3fe..44d49ef 100644<br>
--- a/src/openvpn/console.h<br>
+++ b/src/openvpn/console.h<br>
@@ -6,6 +6,8 @@<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet compression.=
<br>
=C2=A0 *<br>
=C2=A0 *=C2=A0 Copyright (C) 2002-2010 OpenVPN Technologies, Inc. &lt;<a hr=
ef=3D"mailto:sales@...515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2014-2015 David Sommerseth &lt;<a href=3D"mailto:da=
vids@...1347..." target=3D"_blank">davids@...1347...</a>&gt;<br>
+ *=C2=A0 Copyright (C) 2016=C2=A0 =C2=A0 =C2=A0 David Sommerseth &lt;<a hr=
ef=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;<b=
r>
=C2=A0 *<br>
=C2=A0 *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
=C2=A0 *=C2=A0 it under the terms of the GNU General Public License version=
 2<br>
@@ -27,7 +29,90 @@<br>
<br>
=C2=A0#include &quot;basic.h&quot;<br>
<br>
-bool<br>
-get_console_input (const char *prompt, const bool echo, char *input, const=
 int capacity);<br>
+/**<br>
+ *=C2=A0 Configuration setup for declaring what kind of information to ask=
 a user for<br>
+ */<br>
+struct _query_user {=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 char *prompt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/**&lt; Prompt to present to the user */<br>
+=C2=A0 =C2=A0 size_t prompt_len;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Lenght=
 of the prompt string */<br>
+=C2=A0 =C2=A0 char *response;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**&=
lt; The user&#39;s response */<br>
+=C2=A0 =C2=A0 size_t response_len;=C2=A0 =C2=A0 =C2=A0 /**&lt; Lenght the =
of the user reposone */<br>
+=C2=A0 =C2=A0 bool echo;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /**&lt; True: The user should see what is being typed, otherwise mas=
k it */<br>
+};<br>
+<br>
+#define QUERY_USER_NUMSLOTS 10<br>
+extern struct _query_user query_user[];=C2=A0 /**&lt; Global variable, dec=
lared in console.c */<br></blockquote><div><br></div><div>Hmm... this is wa=
ding into style territory, so I&#39;ll move on by just mumbling that leadin=
g underscore in struct names serves no useful purpose.<br></div><div><br></=
div><div>In misc.c:<br></div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -1184,32 +1192,46 @@ get_user_pass_cr (struct user_pass *up,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer user_prompt =
=3D alloc_buf_gc (128, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer pass_prompt =
=3D alloc_buf_gc (128, &amp;gc);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_user_clear ();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf (&amp;user_prom=
pt, &quot;Enter %s Username:&quot;, prefix);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf (&amp;pass_prom=
pt, &quot;Enter %s Password:&quot;, prefix);=C2=A0 <br></blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (username_from_stdin &a=
mp;&amp; !(flags &amp; GET_USER_PASS_PASSWORD_ONLY))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!get_con=
sole_input (BSTR (&amp;user_prompt), true, up-&gt;username, USER_PASS_LEN))=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (=
M_FATAL, &quot;ERROR: could not read %s username from stdin&quot;, prefix);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_user_a=
dd (BSTR(&amp;user_prompt), BLEN(&amp;user_prompt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up-&gt;username, USER_PASS_LE=
N, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_user_add (BSTR(&amp;=
pass_prompt), BLEN(&amp;pass_prompt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up-&gt;password, USER_PASS_LEN, false);<br>=
</blockquote><div><br></div><div>The above call should be conditional on &q=
uot;if (password_from_stdin)&quot;. Else it will get called even after read=
ing password from a file. Unfortunately get_user_pass_cr() has become so fr=
agile after repeated hacks, its so easy to break it...=C2=A0</div><div><br>=
</div><div>The following may sound harsh, but that&#39;s not the intention.=
 I&#39;ve spent hours on these patches now, so just trying to get the best =
out of it:</div><div>In the end, I&#39;m not sure what is achieved by this =
new framework. I see multiple queries can be combined into one exec call, b=
ut the way its used in get_user_pass_cr() does not make full use of it. Sur=
e, username and password are prompted in one call, but static challenge is =
still handled by an additional call. FWIW, to be true to the spirit of the =
implementation, a request for username/password/static-chall<wbr>enge-respo=
nse should result in only one call to query_user_exec, not two. Only then o=
ne can even remotely hope to have a way prompting the user for all that inf=
o in one dialog by some future ask-password agent.=C2=A0 Unless you set a c=
lear style and guidance here, over time=C2=A0 this will degenerate into som=
ething logically identical to the original code except for different functi=
on names and twice the function calls. <br></div><div><br></div><div>Even w=
ith one exec call, finally systemd-ask-password has to be called multiple t=
imes and it seems currently there are no agents that could take multiple qu=
eries and prompt the user in one dialog, for example.<br><br></div><div>Its=
 more like a solution looking for a problem. Which is not a bad thing per s=
e..<br></div><div><br></div><div>Regards,<br><br></div><div>Selva</div></di=
v></div></div>

--001a1137b98e2c28b60539ebe0a6--

