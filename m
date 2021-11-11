MIME-Version: 1.0
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
 <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
 <YY0bykbHVuGLY3DI@...1296...>
In-Reply-To: <YY0bykbHVuGLY3DI@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 11 Nov 2021 14:04:04 +0000
Message-ID: <CAAYFXLkWQtYiVuQqxJZFZNkFJSynyGhUfmo_nFfaHXU47KFUBQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000005c669b05d083d1d3"
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

--0000000000005c669b05d083d1d3
Content-Type: text/plain; charset="UTF-8"

When evaluating authentication plugins, stop further evaluation
once the first failure is detected.

implementation note: refactoring from a switch-case to an
if-else block allows the break statement to break out of the
outer for loop without additional control variables.

v2: add check for auth plugin before breaking out of loop

Signed-off-by: Peter Nelson <petiepooo@...277...>
---
 src/openvpn/plugin.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d5704e07..02b17378 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -818,26 +818,24 @@ plugin_call_ssl(const struct plugin_list *pl,
                                                 certdepth,
                                                 current_cert
                                                 );
-            switch (status)
+            if (pr)
             {
-                case OPENVPN_PLUGIN_FUNC_SUCCESS:
-                    break;
-
-                case OPENVPN_PLUGIN_FUNC_DEFERRED:
-                    deferred = true;
-                    break;
-
-                default:
-                    error = true;
+                pr->n = i + 1;
+            }
+            if (status == OPENVPN_PLUGIN_FUNC_DEFERRED)
+            {
+                deferred = true;
+            }
+            else if (status != OPENVPN_PLUGIN_FUNC_SUCCESS)
+            {
+                error = true;
+                if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+                {
                     break;
+                }
             }
         }

-        if (pr)
-        {
-            pr->n = i;
-        }
-
         gc_free(&gc);

         if (error)
-- 
2.17.1

On Thu, Nov 11, 2021 at 1:34 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Nov 11, 2021 at 01:23:43PM +0000, Pete Nelson wrote:
> > Thank you, Frank.  Amended patch so it applies only to auth attempts.
> >
> > Not sure how patchwork handles this.. my intent is this amended patch
> > overwrites the patch from the OP.
> > -- Pete
>
> The best way to do that is to send the patch with "git send-email" and
> add a "-v2" switch to that - it won't overwrite the patch in PW, but
> we can see "ah, it's a v2".
>
> Please add a note to the commit message as well what is new on v2,
> like
>
>  v2: only apply shortcut logic to authentication plugin calls
>
> (if that's what is new)
>
> Please do also do "git commit -s", so we get the signed-off-by:
> line.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--0000000000005c669b05d083d1d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When evaluating authentication plugins, stop further evalu=
ation<br>once the first failure is detected.<br><br>implementation note: re=
factoring from a switch-case to an<br>if-else block allows the break statem=
ent to break out of the<br>outer for loop without additional control variab=
les.<br><br>v2: add check for auth plugin before breaking out of loop<br><b=
r>Signed-off-by: Peter Nelson &lt;<a href=3D"mailto:petiepooo@...277...">pe=
tiepooo@...277...</a>&gt;<br>---<br>=C2=A0src/openvpn/plugin.c | 28 +++++++=
++++++---------------<br>=C2=A01 file changed, 13 insertions(+), 15 deletio=
ns(-)<br><br>diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c<br>in=
dex d5704e07..02b17378 100644<br>--- a/src/openvpn/plugin.c<br>+++ b/src/op=
envpn/plugin.c<br>@@ -818,26 +818,24 @@ plugin_call_ssl(const struct plugin=
_list *pl,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0certdepth,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0current_cert<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0switch (status)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (pr)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OPENVPN_PLU=
GIN_FUNC_SUCCESS:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>-<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0case OPENVPN_PLUGIN_FUNC_DEFERRED:<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred =3D true;<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>-<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erro=
r =3D true;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr-=
&gt;n =3D i + 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D OPENVPN_PLUGIN_FUNC=
_DEFERRED)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred =3D true;<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else if (status !=3D OPENVPN_PLUGIN_FUNC_SUCCESS)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0error =3D true;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pr)<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr-&gt;n =3D i=
;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0gc_free(&amp;gc);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err=
or)<br>-- <br>2.17.1</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, Nov 11, 2021 at 1:34 PM Gert Doering &lt;<a hre=
f=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Thu, Nov 11, 2021 at 01:23:43PM +0000, Pete Nelson wrote:<br>
&gt; Thank you, Frank.=C2=A0 Amended patch so it applies only to auth attem=
pts.<br>
&gt; <br>
&gt; Not sure how patchwork handles this.. my intent is this amended patch<=
br>
&gt; overwrites the patch from the OP.<br>
&gt; -- Pete<br>
<br>
The best way to do that is to send the patch with &quot;git send-email&quot=
; and<br>
add a &quot;-v2&quot; switch to that - it won&#39;t overwrite the patch in =
PW, but<br>
we can see &quot;ah, it&#39;s a v2&quot;.<br>
<br>
Please add a note to the commit message as well what is new on v2,<br>
like<br>
<br>
=C2=A0v2: only apply shortcut logic to authentication plugin calls<br>
<br>
(if that&#39;s what is new)<br>
<br>
Please do also do &quot;git commit -s&quot;, so we get the signed-off-by:<b=
r>
line.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div>

--0000000000005c669b05d083d1d3--

