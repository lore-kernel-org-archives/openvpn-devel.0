From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 10:42:41 +0000
References: <gerrit.1689088618000.Icc86334b26ba1fcc20f4cd03644018d1d16796e3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d1802dba96adfc0ad809a12a921885cb32a9d7dc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PzPauuGTVKc="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--PzPauuGTVKc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/310?usp=3Demail )


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
---
M src/openvpn/auth_token.c
1 file changed, 5 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/310/2

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7..28b58b0 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--PzPauuGTVKc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/310?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">generate_auth_token: simplify code<br><br>The previous code went th=
rough some hoops<br>to avoid compiler warnings. But there is<br>a much easi=
er way by just telling it<br>exactly what you want to do.<br><br>Also fix t=
ypo in variable name while I&#39;m<br>here.<br><br>Change-Id: Icc86334b26ba=
1fcc20f4cd03644018d1d16796e3<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M src/openvpn/auth_token.c<br>1 file changed, 5 in=
sertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/10/310/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_tok=
en.c b/src/openvpn/auth_token.c</span><br><span>index 6787ea7..28b58b0 1006=
44</span><br><span>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src=
/openvpn/auth_token.c</span><br><span>@@ -182,24 +182,18 @@</span><br><span=
>         char *initial_token_copy =3D string_alloc(multi-&gt;auth_token_in=
itial, &amp;gc);</span><br><span> </span><br><span>         char *old_sessi=
d =3D initial_token_copy + strlen(SESSION_ID_PREFIX);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        char *old_tsamp_initial =3D old_ses=
sid + AUTH_TOKEN_SESSION_ID_LEN*8/6;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *old_tstamp_initial =3D old_sessid + AUTH_TOK=
EN_SESSION_ID_LEN*8/6;</span><br><span> </span><br><span>         /*</span>=
<br><span>          * We null terminate the old token just after the sessio=
n ID to let</span><br><span>          * our base64 decode function only dec=
ode the session ID</span><br><span>          */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        old_tsamp_initial[12] =3D &#39;\0&#39;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(openvpn_=
base64_decode(old_tsamp_initial, old_tstamp_decode, 9) =3D=3D 9);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        old_tstamp_initial[12=
] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ASSERT(openvpn_base64_decode(old_tstamp_initial, old_tstamp_decode,=
 9) =3D=3D 9);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         * Avoid old gcc (4.8.x) complaining about strict aliasing</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         * by using a temporar=
y variable instead of doing it in one</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * line</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uint64_t *tstamp_ptr =3D (uint64_t *) old_tstamp_decode;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        initial_timestamp =3D *t=
stamp_ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
emcpy(&amp;initial_timestamp, &amp;old_tstamp_decode, sizeof(initial_timest=
amp));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        old_tsamp_initial[0] =3D &#39;\0&#39;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        old_tstamp_initial[0] =3D &#39;\0&#39=
;;</span><br><span>         ASSERT(openvpn_base64_decode(old_sessid, sessid=
, AUTH_TOKEN_SESSION_ID_LEN) =3D=3D AUTH_TOKEN_SESSION_ID_LEN);</span><br><=
span>     }</span><br><span>     else if (!rand_bytes(sessid, AUTH_TOKEN_SE=
SSION_ID_LEN))</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/310?usp=3Demail">change 310</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/310?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc86334b26ba1fcc20f4cd03644=
018d1d16796e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 310 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--PzPauuGTVKc=--

