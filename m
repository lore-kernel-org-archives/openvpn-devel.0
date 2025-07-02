From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Jul 2025 15:09:19 +0000
In-Reply-To: <gerrit.1747748031000.Ia2b3eda18bd6dbce6c470037c7a01097e8147c29@...2715...>
References: <gerrit.1747748031000.Ia2b3eda18bd6dbce6c470037c7a01097e8147c29@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <8249d226f7f2fb61afb8e95e3371e8ee674d5019-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3oNdyjmbhYA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix new doxygen
 warnings about using @return in void functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3oNdyjmbhYA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


Change subject: Fix new doxygen warnings about using @return in void functi=
ons
......................................................................

Fix new doxygen warnings about using @return in void functions

These seem to have been added in a more recent doxygen version
than I previously tested with.

Change-Id: Ia2b3eda18bd6dbce6c470037c7a01097e8147c29
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Message-Id: <20250702150433.3871-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
027.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.h
M src/openvpn/fragment.h
M src/openvpn/push.c
3 files changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1029/3

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5bd1ad5..68ad901 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -467,12 +467,12 @@
  * If an error occurs during processing, then the \a buf %buffer is set to
  * empty.
  *
- * @param buf          - The %buffer containing the packet on which to
+ * @param[in,out] buf  - The %buffer containing the packet on which to
  *                       perform security operations.
  * @param work         - An initialized working %buffer.
  * @param opt          - The security parameter state for this VPN tunnel.
  *
- * @return This function returns void.\n On return, the \a buf argument
+ * @note On return, the \a buf argument
  *     will point to the resulting %buffer.  This %buffer will either
  *     contain the processed packet ready for sending, or be empty if an
  *     error occurred.
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 5003c96..cc96057 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -309,7 +309,7 @@
  *
  * @param f            - The \c fragment_master structure for this VPN
  *                       tunnel.
- * @param buf          - A pointer to the buffer structure containing the
+ * @param[in,out] buf  - A pointer to the buffer structure containing the
  *                       incoming packet.  This pointer will have been
  *                       modified on return either to point to a
  *                       completely reassembled packet, or to have length
@@ -317,7 +317,8 @@
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
  *
- * @return Void.\n On return, the \a buf argument will point to a buffer.
+ * @note On return the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     The buffer will have nonzero length if the incoming packet passed
  *     to this function was whole and unfragmented, or if it was the final
  *     part of a fragmented packet thereby completing reassembly.  On the
@@ -363,14 +364,15 @@
  *
  * @param f            - The \c fragment_master structure for this VPN
  *                       tunnel.
- * @param buf          - A pointer to the buffer structure containing the
+ * @param[in,out] buf  - A pointer to the buffer structure containing the
  *                       outgoing packet.  This pointer will be modified
  *                       to point to a whole unfragmented packet or to the
  *                       first part of a fragmented packet on return.
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
  *
- * @return Void.\n On return, the \a buf argument will point to a buffer.
+ * @note On return the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     This buffer contains either the whole original outgoing packet if
  *     fragmentation was not necessary, or the first part of the
  *     fragmented outgoing packet if fragmentation was necessary. In both
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index fe289f1..ad8fa3d7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -582,8 +582,6 @@
  * @param tls_multi     tls multi context of VPN tunnel
  * @param gc            gc arena for allocating push options
  * @param push_list     push list to where options are added
- *
- * @return true on success, false on failure.
  */
 void
 prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena=
 *gc,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2b3eda18bd6dbce6c470037c7a01097e8147c29
Gerrit-Change-Number: 1029
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--3oNdyjmbhYA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1029?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix new doxygen warnings about using @return in void=
 functions<br><br>These seem to have been added in a more recent doxygen ve=
rsion<br>than I previously tested with.<br><br>Change-Id: Ia2b3eda18bd6dbce=
6c470037c7a01097e8147c29<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Mes=
sage-Id: &lt;20250702150433.3871-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32027.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/cryp=
to.h<br>M src/openvpn/fragment.h<br>M src/openvpn/push.c<br>3 files changed=
, 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/29/1029/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto.h b/src/openvpn/crypto.h</span><br><span>index 5bd1ad5..68ad901 100644=
</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openv=
pn/crypto.h</span><br><span>@@ -467,12 +467,12 @@</span><br><span>  * If an=
 error occurs during processing, then the \a buf %buffer is set to</span><b=
r><span>  * empty.</span><br><span>  *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param buf          - The %buffer containing the packet=
 on which to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am[in,out] buf  - The %buffer containing the packet on which to</span><br><=
span>  *                       perform security operations.</span><br><span=
>  * @param work         - An initialized working %buffer.</span><br><span>=
  * @param opt          - The security parameter state for this VPN tunnel.=
</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @return This function returns void.\n On return, the \a buf argument</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @note On return, the =
\a buf argument</span><br><span>  *     will point to the resulting %buffer=
.  This %buffer will either</span><br><span>  *     contain the processed p=
acket ready for sending, or be empty if an</span><br><span>  *     error oc=
curred.</span><br><span>diff --git a/src/openvpn/fragment.h b/src/openvpn/f=
ragment.h</span><br><span>index 5003c96..cc96057 100644</span><br><span>---=
 a/src/openvpn/fragment.h</span><br><span>+++ b/src/openvpn/fragment.h</spa=
n><br><span>@@ -309,7 +309,7 @@</span><br><span>  *</span><br><span>  * @pa=
ram f            - The \c fragment_master structure for this VPN</span><br>=
<span>  *                       tunnel.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param buf          - A pointer to the buffer structur=
e containing the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param[in,out] buf  - A pointer to the buffer structure containing the</spa=
n><br><span>  *                       incoming packet.  This pointer will h=
ave been</span><br><span>  *                       modified on return eithe=
r to point to a</span><br><span>  *                       completely reasse=
mbled packet, or to have length</span><br><span>@@ -317,7 +317,8 @@</span><=
br><span>  * @param frame        - The packet geometry parameters for this =
VPN</span><br><span>  *                       tunnel.</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return Void.\n On r=
eturn, the \a buf argument will point to a buffer.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @note On return the \a buf argument buffe=
r will be modified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*     to communicate the result of the function.</span><br><span>  *     Th=
e buffer will have nonzero length if the incoming packet passed</span><br><=
span>  *     to this function was whole and unfragmented, or if it was the =
final</span><br><span>  *     part of a fragmented packet thereby completin=
g reassembly.  On the</span><br><span>@@ -363,14 +364,15 @@</span><br><span=
>  *</span><br><span>  * @param f            - The \c fragment_master struc=
ture for this VPN</span><br><span>  *                       tunnel.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param buf          - A po=
inter to the buffer structure containing the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param[in,out] buf  - A pointer to the buffer s=
tructure containing the</span><br><span>  *                       outgoing =
packet.  This pointer will be modified</span><br><span>  *                 =
      to point to a whole unfragmented packet or to the</span><br><span>  *=
                       first part of a fragmented packet on return.</span><=
br><span>  * @param frame        - The packet geometry parameters for this =
VPN</span><br><span>  *                       tunnel.</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return Void.\n On r=
eturn, the \a buf argument will point to a buffer.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @note On return the \a buf argument buffe=
r will be modified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*     to communicate the result of the function.</span><br><span>  *     Th=
is buffer contains either the whole original outgoing packet if</span><br><=
span>  *     fragmentation was not necessary, or the first part of the</spa=
n><br><span>  *     fragmented outgoing packet if fragmentation was necessa=
ry. In both</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/p=
ush.c</span><br><span>index fe289f1..ad8fa3d7 100644</span><br><span>--- a/=
src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span=
>@@ -582,8 +582,6 @@</span><br><span>  * @param tls_multi     tls multi con=
text of VPN tunnel</span><br><span>  * @param gc            gc arena for al=
locating push options</span><br><span>  * @param push_list     push list to=
 where options are added</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return true =
on success, false on failure.</span><br><span>  */</span><br><span> void</s=
pan><br><span> prepare_auth_token_push_reply(struct tls_multi *tls_multi, s=
truct gc_arena *gc,</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail">change 1029<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2b3eda18bd6dbce6c470037c7a=
01097e8147c29 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1029 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3oNdyjmbhYA=--

