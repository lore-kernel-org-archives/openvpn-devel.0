MIME-Version: 1.0
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
In-Reply-To: <764146725.499610.1636544169460@...2642...>
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 11 Nov 2021 13:23:43 +0000
Message-ID: <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ec36205d08341aa"
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000000ec36205d08341aa
Content-Type: text/plain; charset="UTF-8"

Thank you, Frank.  Amended patch so it applies only to auth attempts.

Not sure how patchwork handles this.. my intent is this amended patch
overwrites the patch from the OP.
-- Pete

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

On Wed, Nov 10, 2021 at 11:36 AM Frank Lichtenheld <frank@...2641...>
wrote:

>
> Pete Nelson <petiepooo@...277...> hat am 09.11.2021 20:47 geschrieben:
>
>
> When evaluating authentication plugins, stop further evaluation
> once the first failure is detected.
>
> Since plugin_call is only a thin wrapper around plugin_call_ssl I think
> this would short-circuit ALL plugin calls. Doesn't sound like you intended
> that.
>
> Regards,
>   Frank
>
> --
>   Frank Lichtenheld
>
>

--0000000000000ec36205d08341aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank you, Frank.=C2=A0 Amended patch so =
it applies only to auth attempts.</div><div dir=3D"ltr"><br><div>Not sure h=
ow patchwork handles this.. my intent is this amended patch overwrites the =
patch from the OP.</div><div>-- Pete</div><div><br></div><div>---<br>=C2=A0=
src/openvpn/plugin.c | 28 +++++++++++++---------------<br>=C2=A01 file chan=
ged, 13 insertions(+), 15 deletions(-)<br><br>diff --git a/src/openvpn/plug=
in.c b/src/openvpn/plugin.c<br>index d5704e07..02b17378 100644<br>--- a/src=
/openvpn/plugin.c<br>+++ b/src/openvpn/plugin.c<br>@@ -818,26 +818,24 @@ pl=
ugin_call_ssl(const struct plugin_list *pl,<span class=3D"gmail-im"><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0certdepth,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_c=
ert<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0switch (status)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(pr)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OPENVPN_PLUGIN_FUNC_SUCCE=
SS:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>-<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
case OPENVPN_PLUGIN_FUNC_DEFERRED:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred =3D true;<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>-<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D true;<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr-&gt;n =3D i =
+ 1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED)<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deferred =3D true;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else i=
f (status !=3D OPENVPN_PLUGIN_FUNC_SUCCESS)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0error =3D true;<br></span>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<span class=3D"gmai=
l-im"><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pr)=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0pr-&gt;n =3D i;<br></span>- =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>-<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>=C2=A0<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (error)<font color=3D"#888888"><br>-- <br>2.17.1</f=
ont></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Nov 10, 2021 at 11:36 AM Frank Lichtenheld &lt;<a h=
ref=3D"mailto:frank@...2641...">frank@...2641...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

=20=20
=20=20=20
=20
 <div>
  <div>
   <br>
  </div>
  <blockquote type=3D"cite">
   <div>
    Pete Nelson &lt;<a href=3D"mailto:petiepooo@...277..." target=3D"_blank=
">petiepooo@...277...</a>&gt; hat am 09.11.2021 20:47 geschrieben:
   </div>
   <div>
    <br>
   </div>
   <div>
    <br>
   </div>
   <div dir=3D"ltr">
    When evaluating authentication plugins, stop further evaluation
    <br>once the first failure is detected.
    <br>
   </div>
  </blockquote>
  <div>
   <div>
    Since plugin_call is only a thin wrapper around plugin_call_ssl I think=
 this would short-circuit ALL plugin calls. Doesn&#39;t sound like you inte=
nded that.
    <br>
   </div>
   <div>
    <br>
   </div>
   <div>
    Regards,
    <br>
   </div>
   <div>
    =C2=A0 Frank
    <br>
   </div>
   <div>
    <br>
   </div>
   <div>
    --
   </div>
   <div>
    =C2=A0 Frank Lichtenheld
   </div>
   <div>
    <br>
   </div>
  </div>
 </div>
</blockquote></div>

--0000000000000ec36205d08341aa--

