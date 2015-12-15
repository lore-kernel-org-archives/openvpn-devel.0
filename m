MIME-Version: 1.0
In-Reply-To: <1449766646-3519-1-git-send-email-wayne@...2099...>
References: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
	<1449766646-3519-1-git-send-email-wayne@...2099...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 15:51:39 -0500
Message-ID: <CAKuzo_jrxgCRMjYA3T_tJNmNsHXy+MqqVMo8NK3KEDgmseMMBg@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9ef2b1be0526f5f543
Subject: Re: [Openvpn-devel] [PATCH] Improve stdin prompting section,
 fixing CR prompting.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Wayne Davison <wayne@...2099...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443d9ef2b1be0526f5f543
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Dec 14, 2015 at 4:10 PM, Selva Nair <selva.nair@...277...> wrote:
>
>> I took a quick look and it seems a simplified patch that addresses the
>> most critical-sounding issue (challenge/reponse not prompted for
>> from stdin) may be more useful.
>>
>
>
> That's exactly what that patch is.
>

Ok, now looking at the newer, version:

On Thu, Dec 10, 2015 at 11:57 AM, Wayne Davison <wayne@...2099...> wrote:

> ---
>  src/openvpn/misc.c | 119
> +++++++++++++++++++++++++----------------------------
>  1 file changed, 57 insertions(+), 62 deletions(-)
>

A commit message that explains the "why" and "how" will be helpful.


>
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index bc411bf..83e10f7 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1132,74 +1132,69 @@ get_user_pass_cr (struct user_pass *up,
>            password_from_stdin = true;
>          }
>
> -      /*
> -       * Get username/password from standard input?
> -       */
> -      if (username_from_stdin || password_from_stdin)
> -       {
>  #ifdef ENABLE_CLIENT_CR
> -         if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
> -           {
> -             struct auth_challenge_info *ac = get_auth_challenge
> (auth_challenge, &gc);
> -             if (ac)
> -               {
> -                 char *response = (char *) gc_malloc (USER_PASS_LEN,
> false, &gc);
> -                 struct buffer packed_resp;
> -
> -                 buf_set_write (&packed_resp, (uint8_t*)up->password,
> USER_PASS_LEN);
> -                 msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s",
> ac->challenge_text);
> -                 if (!get_console_input ("Response:",
> BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
> -                   msg (M_FATAL, "ERROR: could not read challenge
> response from stdin");
> -                 strncpynt (up->username, ac->user, USER_PASS_LEN);
> -                 buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id,
> response);
> -               }
> -             else
> -               {
> -                 msg (M_FATAL, "ERROR: received malformed challenge
> request from server");
> -               }
> -           }
> -         else
> +      if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
> +        {
> +          struct auth_challenge_info *ac = get_auth_challenge
> (auth_challenge, &gc);
> +          if (ac)
> +            {
> +              char *response = (char *) gc_malloc (USER_PASS_LEN, false,
> &gc);
> +              struct buffer packed_resp;
> +
> +              buf_set_write (&packed_resp, (uint8_t*)up->password,
> USER_PASS_LEN);
> +              msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s",
> ac->challenge_text);
> +              if (!get_console_input ("Response:",
> BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
> +                msg (M_FATAL, "ERROR: could not read challenge response
> from stdin");
> +              strncpynt (up->username, ac->user, USER_PASS_LEN);
> +              buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id,
> response);
> +            }
> +          else
> +            {
> +              msg (M_FATAL, "ERROR: received malformed challenge request
> from server");
> +            }
> +        }
> +      else
>

I would either avoid excessive indentation changes or leave it for a
white-space-only patch (which will likely get ignored :). Same goes
for rest of the patch, which only moves around variable declarations,
or change whitespace.

This could be a small ~2 line patch -- easier to review and test.

Selva

--001a11443d9ef2b1be0526f5f543
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br><blockquote style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail=
_quote"><span>On Mon, Dec 14, 2015 at 4:10 PM, Selva Nair <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...220...=
..277...</a>&gt;</span> wrote:</span><br><span><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><div><div class=3D"gmail_extra"><div=
 class=3D"gmail_quote"><div>I
 took a quick look and it seems a simplified patch that addresses the=20
most critical-sounding issue (challenge/reponse not prompted for</div><div>=
from stdin) may be more useful.</div></div></div></div></div></blockquote><=
/span><br><span></span><br><span></span><div>That&#39;s exactly what that p=
atch is.</div></blockquote><br></div>Ok, now looking at the newer, version:=
<br><div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Thu, Dec 10, 2015 at 11:57 AM, Wayne Davison <span dir=3D"ltr">&lt;<a =
href=3D"mailto:wayne@...2099..." target=3D"_blank">wayne@...2099...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0src/openvpn/misc.c | 119 +++++++++++++++++++++++++-------------------=
---------<br>
=C2=A01 file changed, 57 insertions(+), 62 deletions(-)<br></blockquote><di=
v><br></div><div>A commit message that explains the &quot;why&quot; and &qu=
ot;how&quot; will be helpful.<br>=C2=A0<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br>
index bc411bf..83e10f7 100644<br>
--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -1132,74 +1132,69 @@ get_user_pass_cr (struct user_pass *up,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0password_from_stdin =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0* Get username/password from standard input?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 if (username_from_stdin || password_from_stdin)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0#ifdef ENABLE_CLIENT_CR<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (auth_challenge &amp;&amp; (flags &am=
p; GET_USER_PASS_DYNAMIC_CHALLENGE))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct auth_challenge_info=
 *ac =3D get_auth_challenge (auth_challenge, &amp;gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ac)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *respon=
se =3D (char *) gc_malloc (USER_PASS_LEN, false, &amp;gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct buffe=
r packed_resp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_set_writ=
e (&amp;packed_resp, (uint8_t*)up-&gt;password, USER_PASS_LEN);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO|=
M_NOPREFIX, &quot;CHALLENGE: %s&quot;, ac-&gt;challenge_text);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!get_con=
sole_input (&quot;Response:&quot;, BOOL_CAST(ac-&gt;flags&amp;CR_ECHO), res=
ponse, USER_PASS_LEN))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (=
M_FATAL, &quot;ERROR: could not read challenge response from stdin&quot;);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpynt (u=
p-&gt;username, ac-&gt;user, USER_PASS_LEN);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf (=
&amp;packed_resp, &quot;CRV1::%s::%s&quot;, ac-&gt;state_id, response);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_FATAL=
, &quot;ERROR: received malformed challenge request from server&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 if (auth_challenge &amp;&amp; (flags &amp; GET_USER_P=
ASS_DYNAMIC_CHALLENGE))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct auth_challenge_info *ac =3D get_=
auth_challenge (auth_challenge, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *response =3D (char =
*) gc_malloc (USER_PASS_LEN, false, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct buffer packed_resp=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_set_write (&amp;packe=
d_resp, (uint8_t*)up-&gt;password, USER_PASS_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO|M_NOPREFIX, &=
quot;CHALLENGE: %s&quot;, ac-&gt;challenge_text);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!get_console_input (&=
quot;Response:&quot;, BOOL_CAST(ac-&gt;flags&amp;CR_ECHO), response, USER_P=
ASS_LEN))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_FATAL, &quo=
t;ERROR: could not read challenge response from stdin&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpynt (up-&gt;usernam=
e, ac-&gt;user, USER_PASS_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_printf (&amp;packed_r=
esp, &quot;CRV1::%s::%s&quot;, ac-&gt;state_id, response);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_FATAL, &quot;ERROR=
: received malformed challenge request from server&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else<br></blockquote><div><br></div>I would either av=
oid excessive indentation changes or leave it for a <br>white-space-only pa=
tch (which will likely get ignored :). Same goes <br>for rest of the patch,=
 which only moves around variable declarations,<br>or change whitespace. <b=
r><br>This could be a small ~2 line patch -- easier to review and test.<br>=
</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Selva=
<br></div></div></div></div></div></div>

--001a11443d9ef2b1be0526f5f543--

