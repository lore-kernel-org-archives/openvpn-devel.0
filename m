From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 09:15:57 +0000
In-Reply-To: <gerrit.1733837528000.I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11@...2715...>
References: <gerrit.1733837528000.I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <803725a4a309dbf9553ed751899c9716113a504d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kpBJlJjBfac="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Disable
 clang-format for some code parts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kpBJlJjBfac=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/82=
9?usp=3Demail )

Change subject: Disable clang-format for some code parts
......................................................................

Disable clang-format for some code parts

These do not come out better with clang-format,
so leave them be.

Change-Id: I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250804091027.13509-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
492.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_common.h
M src/tapctl/main.c
2 files changed, 4 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 90c0086..1fdc187 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -74,6 +74,7 @@
  *
  * @{
  */
+/* clang-format off */
 #define S_ERROR         (-2)    /**< Error state.  */
 #define S_ERROR_PRE     (-1)    /**< Error state but try to send out alerts
                                  *  before killing the keystore and moving
@@ -104,7 +105,7 @@
 #define S_GENERATED_KEYS  8     /**< The data channel keys have been gener=
ated
                                  *  The TLS session is fully authenticated
                                  *  when reaching this state. */
-
+/* clang-format on */
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
  * >=3D S_ACTIVE to be fully operational */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 82caeaf..0dec303 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -36,6 +36,7 @@
 #endif


+/* clang-format off */
 const WCHAR title_string[] =3D
     _L(PACKAGE_NAME) L" " _L(PACKAGE_VERSION)
 ;
@@ -110,6 +111,7 @@
     L"\n"
     L"tapctl delete <adapter GUID | adapter name>\n"
 ;
+/* clang-format on */


 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/829?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11
Gerrit-Change-Number: 829
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--kpBJlJjBfac=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/829?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Disable clang-format for some code parts<br><b=
r>These do not come out better with clang-format,<br>so leave them be.<br><=
br>Change-Id: I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20250804091027.13509-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg32492.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/ssl_common.h<br>M src/tapctl/main.c<br>2 files changed,=
 4 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><=
br><span>index 90c0086..1fdc187 100644</span><br><span>--- a/src/openvpn/ss=
l_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@=
@ -74,6 +74,7 @@</span><br><span>  *</span><br><span>  * @{</span><br><span=
>  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* clang-forma=
t off */</span><br><span> #define S_ERROR         (-2)    /**&lt; Error sta=
te.  */</span><br><span> #define S_ERROR_PRE     (-1)    /**&lt; Error stat=
e but try to send out alerts</span><br><span>                              =
    *  before killing the keystore and moving</span><br><span>@@ -104,7 +10=
5,7 @@</span><br><span> #define S_GENERATED_KEYS  8     /**&lt; The data ch=
annel keys have been generated</span><br><span>                            =
      *  The TLS session is fully authenticated</span><br><span>           =
                       *  when reaching this state. */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* clang-format on */</span><br><span> /* Note that earlier v=
ersions also had a S_OP_NORMAL state that was</span><br><span>  * virtually=
 identical with S_ACTIVE and the code still assumes everything</span><br><s=
pan>  * &gt;=3D S_ACTIVE to be fully operational */</span><br><span>diff --=
git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 82caeaf..=
0dec303 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ =
b/src/tapctl/main.c</span><br><span>@@ -36,6 +36,7 @@</span><br><span> #end=
if</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* clang-format off */</span><br><span> const WCHAR titl=
e_string[] =3D</span><br><span>     _L(PACKAGE_NAME) L&quot; &quot; _L(PACK=
AGE_VERSION)</span><br><span> ;</span><br><span>@@ -110,6 +111,7 @@</span><=
br><span>     L&quot;\n&quot;</span><br><span>     L&quot;tapctl delete &lt=
;adapter GUID | adapter name&gt;\n&quot;</span><br><span> ;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* clang-format on */</span><br><sp=
an> </span><br><span> </span><br><span> /**</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/829?us=
p=3Demail">change 829</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/829?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4dd0c44982955f16ec4a3f167d4=
e6f3e9b4dbc11 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 829 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--kpBJlJjBfac=--

