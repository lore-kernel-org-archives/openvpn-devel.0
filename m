From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 13:33:53 +0000
References: <gerrit.1747748031000.Ia2b3eda18bd6dbce6c470037c7a01097e8147c29@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <233cf874415adff20d3d91e0ea66eaf38a3baa8e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+RWVsn32nZM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+RWVsn32nZM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail

to review the following change.


Change subject: Fix new doxygen warnings about using @return in void functi=
ons
......................................................................

Fix new doxygen warnings about using @return in void functions

These seem to have been added in a more recent doxygen version
than I previously tested with.

Change-Id: Ia2b3eda18bd6dbce6c470037c7a01097e8147c29
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.h
M src/openvpn/fragment.h
M src/openvpn/push.c
3 files changed, 10 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1029/1

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 94f1f7f..9c4ee77 100644
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
+ * @note This function returns void.\n On return, the \a buf argument
  *     will point to the resulting %buffer.  This %buffer will either
  *     contain the processed packet ready for sending, or be empty if an
  *     error occurred.
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 91f4a26..d426dfd 100644
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
@@ -317,7 +317,9 @@
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
  *
- * @return Void.\n On return, the \a buf argument will point to a buffer.
+ * @note Does not have a return value.\n
+ *     However, on return, the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     The buffer will have nonzero length if the incoming packet passed
  *     to this function was whole and unfragmented, or if it was the final
  *     part of a fragmented packet thereby completing reassembly.  On the
@@ -363,14 +365,16 @@
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
+ * @note Does not have a return value.\n
+ *     However, on return, the \a buf argument buffer will be modified
+ *     to communicate the result of the function.
  *     This buffer contains either the whole original outgoing packet if
  *     fragmentation was not necessary, or the first part of the
  *     fragmented outgoing packet if fragmentation was necessary. In both
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index c97ce28..24490bb 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--+RWVsn32nZM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1029?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix new doxygen warnings about using @return in void functio=
ns<br><br>These seem to have been added in a more recent doxygen version<br=
>than I previously tested with.<br><br>Change-Id: Ia2b3eda18bd6dbce6c470037=
c7a01097e8147c29<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/crypto.h<br>M src/openvpn/fragment.h<br>M src/op=
envpn/push.c<br>3 files changed, 10 insertions(+), 8 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1029/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><sp=
an>index 94f1f7f..9c4ee77 100644</span><br><span>--- a/src/openvpn/crypto.h=
</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -467,12 +467=
,12 @@</span><br><span>  * If an error occurs during processing, then the \=
a buf %buffer is set to</span><br><span>  * empty.</span><br><span>  *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param buf          - T=
he %buffer containing the packet on which to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param[in,out] buf  - The %buffer containing th=
e packet on which to</span><br><span>  *                       perform secu=
rity operations.</span><br><span>  * @param work         - An initialized w=
orking %buffer.</span><br><span>  * @param opt          - The security para=
meter state for this VPN tunnel.</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @return This function returns void.\n On=
 return, the \a buf argument</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @note This function returns void.\n On return, the \a buf argum=
ent</span><br><span>  *     will point to the resulting %buffer.  This %buf=
fer will either</span><br><span>  *     contain the processed packet ready =
for sending, or be empty if an</span><br><span>  *     error occurred.</spa=
n><br><span>diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h</s=
pan><br><span>index 91f4a26..d426dfd 100644</span><br><span>--- a/src/openv=
pn/fragment.h</span><br><span>+++ b/src/openvpn/fragment.h</span><br><span>=
@@ -309,7 +309,7 @@</span><br><span>  *</span><br><span>  * @param f       =
     - The \c fragment_master structure for this VPN</span><br><span>  *   =
                    tunnel.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param buf          - A pointer to the buffer structure containing=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in,ou=
t] buf  - A pointer to the buffer structure containing the</span><br><span>=
  *                       incoming packet.  This pointer will have been</sp=
an><br><span>  *                       modified on return either to point t=
o a</span><br><span>  *                       completely reassembled packet=
, or to have length</span><br><span>@@ -317,7 +317,9 @@</span><br><span>  *=
 @param frame        - The packet geometry parameters for this VPN</span><b=
r><span>  *                       tunnel.</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @return Void.\n On return, the \=
a buf argument will point to a buffer.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @note Does not have a return value.\n</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *     However, on return, the \a b=
uf argument buffer will be modified</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *     to communicate the result of the function.</span><br=
><span>  *     The buffer will have nonzero length if the incoming packet p=
assed</span><br><span>  *     to this function was whole and unfragmented, =
or if it was the final</span><br><span>  *     part of a fragmented packet =
thereby completing reassembly.  On the</span><br><span>@@ -363,14 +365,16 @=
@</span><br><span>  *</span><br><span>  * @param f            - The \c frag=
ment_master structure for this VPN</span><br><span>  *                     =
  tunnel.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param bu=
f          - A pointer to the buffer structure containing the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param[in,out] buf  - A pointe=
r to the buffer structure containing the</span><br><span>  *               =
        outgoing packet.  This pointer will be modified</span><br><span>  *=
                       to point to a whole unfragmented packet or to the</s=
pan><br><span>  *                       first part of a fragmented packet o=
n return.</span><br><span>  * @param frame        - The packet geometry par=
ameters for this VPN</span><br><span>  *                       tunnel.</spa=
n><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @re=
turn Void.\n On return, the \a buf argument will point to a buffer.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @note Does not have a re=
turn value.\n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
 However, on return, the \a buf argument buffer will be modified</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *     to communicate the resu=
lt of the function.</span><br><span>  *     This buffer contains either the=
 whole original outgoing packet if</span><br><span>  *     fragmentation wa=
s not necessary, or the first part of the</span><br><span>  *     fragmente=
d outgoing packet if fragmentation was necessary. In both</span><br><span>d=
iff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index c=
97ce28..24490bb 100644</span><br><span>--- a/src/openvpn/push.c</span><br><=
span>+++ b/src/openvpn/push.c</span><br><span>@@ -582,8 +582,6 @@</span><br=
><span>  * @param tls_multi     tls multi context of VPN tunnel</span><br><=
span>  * @param gc            gc arena for allocating push options</span><b=
r><span>  * @param push_list     push list to where options are added</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return true on success, false on failure.<=
/span><br><span>  */</span><br><span> void</span><br><span> prepare_auth_to=
ken_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1029?usp=3Demail">change 1029</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2b3eda18bd6dbce6c470037c7a=
01097e8147c29 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1029 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--+RWVsn32nZM=--

