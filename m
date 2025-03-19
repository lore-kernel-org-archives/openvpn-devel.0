From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Mar 2025 14:24:50 +0000
References: <gerrit.1733837528000.I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2fd29a10c1e64e066180a351fba6d9beeb424b71-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z4TGYeybDXA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z4TGYeybDXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/829?usp=3Demail

to review the following change.


Change subject: Disable clang-format for some code parts
......................................................................

Disable clang-format for some code parts

These do not come out better with clang-format,
so leave them be.

Change-Id: I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_common.h
M src/tapctl/main.c
2 files changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/829/3

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 4e54001..97c5041 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -75,6 +75,7 @@
  *
  * @{
  */
+/* clang-format off */
 #define S_ERROR         (-2)    /**< Error state.  */
 #define S_ERROR_PRE     (-1)    /**< Error state but try to send out alerts
                                  *  before killing the keystore and moving
@@ -102,7 +103,7 @@
 #define S_GENERATED_KEYS  7     /**< The data channel keys have been gener=
ated
                                  *  The TLS session is fully authenticated
                                  *  when reaching this state. */
-
+/* clang-format on */
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
  * >=3D S_ACTIVE to be fully operational */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 551a8e6..d27da6b 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -37,6 +37,7 @@
 #endif


+/* clang-format off */
 const WCHAR title_string[] =3D
     _L(PACKAGE_NAME) L" " _L(PACKAGE_VERSION)
 ;
@@ -111,6 +112,7 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Z4TGYeybDXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/829?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Disable clang-format for some code parts<br><br>These do not =
come out better with clang-format,<br>so leave them be.<br><br>Change-Id: I=
4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl_common.h<br>M src/ta=
pctl/main.c<br>2 files changed, 4 insertions(+), 1 deletion(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/829/3</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br=
><span>index 4e54001..97c5041 100644</span><br><span>--- a/src/openvpn/ssl_=
common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ =
-75,6 +75,7 @@</span><br><span>  *</span><br><span>  * @{</span><br><span> =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* clang-format =
off */</span><br><span> #define S_ERROR         (-2)    /**&lt; Error state=
.  */</span><br><span> #define S_ERROR_PRE     (-1)    /**&lt; Error state =
but try to send out alerts</span><br><span>                                =
  *  before killing the keystore and moving</span><br><span>@@ -102,7 +103,=
7 @@</span><br><span> #define S_GENERATED_KEYS  7     /**&lt; The data chan=
nel keys have been generated</span><br><span>                              =
    *  The TLS session is fully authenticated</span><br><span>             =
                     *  when reaching this state. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* clang-format on */</span><br><span> /* Note that earlier ve=
rsions also had a S_OP_NORMAL state that was</span><br><span>  * virtually =
identical with S_ACTIVE and the code still assumes everything</span><br><sp=
an>  * &gt;=3D S_ACTIVE to be fully operational */</span><br><span>diff --g=
it a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 551a8e6..d=
27da6b 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ b=
/src/tapctl/main.c</span><br><span>@@ -37,6 +37,7 @@</span><br><span> #endi=
f</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* clang-format off */</span><br><span> const WCHAR title=
_string[] =3D</span><br><span>     _L(PACKAGE_NAME) L&quot; &quot; _L(PACKA=
GE_VERSION)</span><br><span> ;</span><br><span>@@ -111,6 +112,7 @@</span><b=
r><span>     L&quot;\n&quot;</span><br><span>     L&quot;tapctl delete &lt;=
adapter GUID | adapter name&gt;\n&quot;</span><br><span> ;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* clang-format on */</span><br><spa=
n> </span><br><span> </span><br><span> /**</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/829?usp=
=3Demail">change 829</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/829?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4dd0c44982955f16ec4a3f167d4=
e6f3e9b4dbc11 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 829 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Z4TGYeybDXA=--

