From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 12:07:50 +0000
In-Reply-To: <gerrit.1689088618000.Icc86334b26ba1fcc20f4cd03644018d1d16796e3@...2715...>
References: <gerrit.1689088618000.Icc86334b26ba1fcc20f4cd03644018d1d16796e3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1a308e59c809ce6dd8ccd40ef3026cc4a7047ba7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8e11IdCASjk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: generate_auth_token:
 simplify code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--8e11IdCASjk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/31=
0?usp=3Demail )

Change subject: generate_auth_token: simplify code
......................................................................

generate_auth_token: simplify code

The previous code went through some hoops
to avoid compiler warnings. But there is
a much easier way by just telling it
exactly what you want to do.

Also fix typo in variable name while I'm
here.

Change-Id: Icc86334b26ba1fcc20f4cd03644018d1d16796e3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240910170005.5586-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
178.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/auth_token.c
1 file changed, 5 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index c4b59b9..192c7c2 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -182,24 +182,18 @@
         char *initial_token_copy =3D string_alloc(multi->auth_token_initia=
l, &gc);

         char *old_sessid =3D initial_token_copy + strlen(SESSION_ID_PREFIX=
);
-        char *old_tsamp_initial =3D old_sessid + AUTH_TOKEN_SESSION_ID_LEN=
*8/6;
+        char *old_tstamp_initial =3D old_sessid + AUTH_TOKEN_SESSION_ID_LE=
N*8/6;

         /*
          * We null terminate the old token just after the session ID to let
          * our base64 decode function only decode the session ID
          */
-        old_tsamp_initial[12] =3D '\0';
-        ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode,=
 9) =3D=3D 9);
+        old_tstamp_initial[12] =3D '\0';
+        ASSERT(openvpn_base64_decode(old_tstamp_initial, old_tstamp_decode=
, 9) =3D=3D 9);

-        /*
-         * Avoid old gcc (4.8.x) complaining about strict aliasing
-         * by using a temporary variable instead of doing it in one
-         * line
-         */
-        uint64_t *tstamp_ptr =3D (uint64_t *) old_tstamp_decode;
-        initial_timestamp =3D *tstamp_ptr;
+        memcpy(&initial_timestamp, &old_tstamp_decode, sizeof(initial_time=
stamp));

-        old_tsamp_initial[0] =3D '\0';
+        old_tstamp_initial[0] =3D '\0';
         ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSIO=
N_ID_LEN) =3D=3D AUTH_TOKEN_SESSION_ID_LEN);
     }
     else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/310?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc86334b26ba1fcc20f4cd03644018d1d16796e3
Gerrit-Change-Number: 310
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--8e11IdCASjk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/310?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">generate_auth_token: simplify code<br><br>The =
previous code went through some hoops<br>to avoid compiler warnings. But th=
ere is<br>a much easier way by just telling it<br>exactly what you want to =
do.<br><br>Also fix typo in variable name while I&#39;m<br>here.<br><br>Cha=
nge-Id: Icc86334b26ba1fcc20f4cd03644018d1d16796e3<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Message-Id: &lt;20240910170005.5586-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg29178.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/auth_token.c<br>1 file changed, 5 insertions(+), 11 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c</span><=
br><span>index c4b59b9..192c7c2 100644</span><br><span>--- a/src/openvpn/au=
th_token.c</span><br><span>+++ b/src/openvpn/auth_token.c</span><br><span>@=
@ -182,24 +182,18 @@</span><br><span>         char *initial_token_copy =3D =
string_alloc(multi-&gt;auth_token_initial, &amp;gc);</span><br><span> </spa=
n><br><span>         char *old_sessid =3D initial_token_copy + strlen(SESSI=
ON_ID_PREFIX);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 char *old_tsamp_initial =3D old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *old_tsta=
mp_initial =3D old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;</span><br><span>=
 </span><br><span>         /*</span><br><span>          * We null terminate=
 the old token just after the session ID to let</span><br><span>          *=
 our base64 decode function only decode the session ID</span><br><span>    =
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        old_t=
samp_initial[12] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(openvpn_base64_decode(old_tsamp_initial, old_ts=
tamp_decode, 9) =3D=3D 9);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        old_tstamp_initial[12] =3D &#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_decode(ol=
d_tstamp_initial, old_tstamp_decode, 9) =3D=3D 9);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * Avoid old gcc (4.8.x) compla=
ining about strict aliasing</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * by using a temporary variable instead of doing it in one</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * line</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        uint64_t *tstamp_ptr =3D (uint6=
4_t *) old_tstamp_decode;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        initial_timestamp =3D *tstamp_ptr;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        memcpy(&amp;initial_timestamp, &amp;old_=
tstamp_decode, sizeof(initial_timestamp));</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        old_tsamp_initial[0] =3D &#3=
9;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ld_tstamp_initial[0] =3D &#39;\0&#39;;</span><br><span>         ASSERT(open=
vpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN) =3D=3D AUT=
H_TOKEN_SESSION_ID_LEN);</span><br><span>     }</span><br><span>     else i=
f (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/310?usp=3Demail">change 310</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/310?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc86334b26ba1fcc20f4cd03644=
018d1d16796e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 310 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--8e11IdCASjk=--

