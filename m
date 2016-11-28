MIME-Version: 1.0
In-Reply-To: <1480335220-14810-1-git-send-email-steffan.karger@...1435...>
References: <1480335220-14810-1-git-send-email-steffan.karger@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Nov 2016 11:39:43 -0500
Message-ID: <CAKuzo_hDcoTm-teJ3UeKQ+B=RTpStb3KMjQKLc0x7A2-_TUvoA@...278...>
Content-Type: multipart/alternative; boundary=001a11376232a35a5205425f1ffc
Subject: Re: [Openvpn-devel] [PATCH] Introduce and use secure_memzero() to
 erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11376232a35a5205425f1ffc
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 28, 2016 at 7:13 AM, Steffan Karger <steffan.karger@...1435...>
wrote:

> As described in trac #751, and shortly after reported by Zhaomo Yang, of
> the University of California, San Diego, we use memset() (often through
> the CLEAR() macro) to erase secrets after use.  In some cases however, the
> compiler might optimize these calls away.
>
> This patch replaces these memset() calls on secrets by calls to a new
> secure_memzero() function, that will not be optimized away.
>
> Since we use CLEAR() a LOT of times, I'm not changing that to use
> secure_memzero() to prevent performance impact.  I did annotate the macro
> to point people at secure_memzero().
>
> This patch also replaces some CLEAR() or memset() calls with a zero-
> initialization using "= { 0 }" if that has the same effect, because that
> better captures the intend of that code.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>

All look good except that it might have missed some memset calls that could
benefit from a  SecureZeroMemory() or equivalent:

With no pretense of completeness, here is a list with some context: calls
marked with <-- SecureZero


--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -218,7 +218,7 @@ static bool get_console_input (const char *prompt,
const bool echo, char *input,
         if (gp)
         {
             strncpynt (input, gp, capacity);
-            memset (gp, 0, strlen (gp));
+            memset (gp, 0, strlen (gp)); <-- SecureZero
             ret = true;
         }
     }

--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -501,7 +501,7 @@ remove_env_item (const char *str, const bool do_free,
struct env_item **list)
            *list = current->next;
          if (do_free)
            {
-             memset (current->string, 0, strlen (current->string));
+             memset (current->string, 0, strlen (current->string)); <--
SecureZero
              free (current->string);
              free (current);
            }


--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1212,7 +1212,7 @@ tls_multi_free (struct tls_multi *multi, bool clear)

   if (multi->auth_token)
     {
-      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
+      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
       free (multi->auth_token);
     }


--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1176,7 +1176,7 @@ verify_user_pass(struct user_pass *up, struct
tls_multi *multi,
       if (memcmp_constant_time(multi->auth_token, up->password,
                  strlen(multi->auth_token)) != 0)
         {
-          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
+          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
           free (multi->auth_token);


Selva

--001a11376232a35a5205425f1ffc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote">On Mon, Nov 28, 2016 at 7:13 AM, Steffan Karger <span dir=3D"ltr=
">&lt;<a href=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffa=
n.karger@...1435...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex">As described =
in trac #751, and shortly after reported by Zhaomo Yang, of<br>
the University of California, San Diego, we use memset() (often through<br>
the CLEAR() macro) to erase secrets after use.=C2=A0 In some cases however,=
 the<br>
compiler might optimize these calls away.<br>
<br>
This patch replaces these memset() calls on secrets by calls to a new<br>
secure_memzero() function, that will not be optimized away.<br>
<br>
Since we use CLEAR() a LOT of times, I&#39;m not changing that to use<br>
secure_memzero() to prevent performance impact.=C2=A0 I did annotate the ma=
cro<br>
to point people at secure_memzero().<br>
<br>
This patch also replaces some CLEAR() or memset() calls with a zero-<br>
initialization using &quot;=3D { 0 }&quot; if that has the same effect, bec=
ause that<br>
better captures the intend of that code.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br></blockquote><div><br></div><div>A=
ll look good except that it might have missed some memset calls that could =
benefit from a =C2=A0SecureZeroMemory() or equivalent:</div><div><br></div>=
<div>With no pretense of completeness, here is a list with some context: ca=
lls marked with &lt;-- SecureZero</div><div><br></div><div><br></div><div><=
div>--- a/src/openvpn/console_builtin.c</div><div>+++ b/src/openvpn/console=
_builtin.c</div><div>@@ -218,7 +218,7 @@ static bool get_console_input (con=
st char *prompt, const bool echo, char *input,</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (gp)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpynt (input, gp,=
 capacity);</div><div>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset (gp=
, 0, strlen (gp));</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem=
set (gp, 0, strlen (gp)); &lt;-- SecureZero</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div><br></div><div>--- a/=
src/openvpn/misc.c</div><div>+++ b/src/openvpn/misc.c</div><div>@@ -501,7 +=
501,7 @@ remove_env_item (const char *str, const bool do_free, struct env_i=
tem **list)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *list =3D c=
urrent-&gt;next;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (do_free)<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {</div><div>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset (current-&gt;string, 0, strlen (c=
urrent-&gt;string));</div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
memset (current-&gt;string, 0, strlen (current-&gt;string)); &lt;-- SecureZ=
ero</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free (curren=
t-&gt;string);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
ree (current);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><=
div><br></div><div><br></div><div>--- a/src/openvpn/ssl.c</div><div>+++ b/s=
rc/openvpn/ssl.c</div><div>@@ -1212,7 +1212,7 @@ tls_multi_free (struct tls=
_multi *multi, bool clear)</div><div>=C2=A0</div><div>=C2=A0 =C2=A0if (mult=
i-&gt;auth_token)</div><div>=C2=A0 =C2=A0 =C2=A0{</div><div>- =C2=A0 =C2=A0=
 =C2=A0memset (multi-&gt;auth_token, 0, AUTH_TOKEN_SIZE);</div><div>+ =C2=
=A0 =C2=A0 =C2=A0memset (multi-&gt;auth_token, 0, AUTH_TOKEN_SIZE); &lt;-- =
SecureZero</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0free (multi-&gt;auth_token)=
;</div><div>=C2=A0 =C2=A0 =C2=A0}</div><div>=C2=A0</div><div><br></div><div=
>--- a/src/openvpn/ssl_verify.c</div><div>+++ b/src/openvpn/ssl_verify.c</d=
iv><div>@@ -1176,7 +1176,7 @@ verify_user_pass(struct user_pass *up, struct=
 tls_multi *multi,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (memcmp_constant=
_time(multi-&gt;auth_token, up-&gt;password,</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strlen(multi-&gt;auth_token)) !=
=3D 0)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{</div><div>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0memset (multi-&gt;auth_token, 0, AUTH_TOKEN_SIZE);<=
/div><div>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset (multi-&gt;auth_token,=
 0, AUTH_TOKEN_SIZE); &lt;-- SecureZero</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0free (multi-&gt;auth_token);</div></div><div><br></div><di=
v><br></div></div>Selva</div></div>

--001a11376232a35a5205425f1ffc--

