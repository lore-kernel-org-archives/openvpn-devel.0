From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:35 +0000
References: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <acc8cc1baa11ddaea8a07a94294edc06b51fe89a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j4jAg2m5Kps="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: push: Make
 prepare_push_reply return void
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

--j4jAg2m5Kps=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demail

to review the following change.


Change subject: push: Make prepare_push_reply return void
......................................................................

push: Make prepare_push_reply return void

It returned a constant value so it didn't actually
mean anything.

While here also make it static.

Identified by cppcheck.

Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/push.c
1 file changed, 3 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1616/1

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 835c433..564ce86 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -631,10 +631,8 @@
  * @param c             context structure storing data for VPN tunnel
  * @param gc            gc arena for allocating push options
  * @param push_list     push list to where options are added
- *
- * @return true on success, false on failure.
  */
-bool
+static void
 prepare_push_reply(struct context *c, struct gc_arena *gc, struct push_lis=
t *push_list)
 {
     struct tls_multi *tls_multi =3D c->c2.tls_multi;
@@ -734,8 +732,6 @@
                 client_max_mtu, o->ce.tun_mtu, o->ce.tun_mtu);
         }
     }
-
-    return true;
 }

 static bool
@@ -1011,7 +1007,8 @@
             struct push_list push_list =3D { 0 };
             struct gc_arena gc =3D gc_new();

-            if (prepare_push_reply(c, &gc, &push_list) && send_push_reply(=
c, &push_list))
+            prepare_push_reply(c, &gc, &push_list);
+            if (send_push_reply(c, &push_list))
             {
                 ret =3D PUSH_MSG_REQUEST;
                 c->c2.sent_push_reply_expiry =3D now + 30;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Gerrit-Change-Number: 1616
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--j4jAg2m5Kps=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push: Make prepare_push_reply return void<b=
r><br>It returned a constant value so it didn&#39;t actually<br>mean anythi=
ng.<br><br>While here also make it static.<br><br>Identified by cppcheck.<b=
r><br>Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/push.c=
<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1616/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><spa=
n>index 835c433..564ce86 100644</span><br><span>--- a/src/openvpn/push.c</s=
pan><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -631,10 +631,8 @@=
</span><br><span>  * @param c             context structure storing data fo=
r VPN tunnel</span><br><span>  * @param gc            gc arena for allocati=
ng push options</span><br><span>  * @param push_list     push list to where=
 options are added</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return true on suc=
cess, false on failure.</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span> prepare_push_reply(struct context *c, =
struct gc_arena *gc, struct push_list *push_list)</span><br><span> {</span>=
<br><span>     struct tls_multi *tls_multi =3D c-&gt;c2.tls_multi;</span><b=
r><span>@@ -734,8 +732,6 @@</span><br><span>                 client_max_mtu=
, o-&gt;ce.tun_mtu, o-&gt;ce.tun_mtu);</span><br><span>         }</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span>@@ -1=
011,7 +1007,8 @@</span><br><span>             struct push_list push_list =
=3D { 0 };</span><br><span>             struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (prepare_push_reply(c, &amp;gc, &amp;push_list) &amp;&amp; send_pu=
sh_reply(c, &amp;push_list))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            prepare_push_reply(c, &amp;gc, &amp;push_list);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (send_push_=
reply(c, &amp;push_list))</span><br><span>             {</span><br><span>  =
               ret =3D PUSH_MSG_REQUEST;</span><br><span>                 c=
-&gt;c2.sent_push_reply_expiry =3D now + 30;</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?=
usp=3Demail">change 1616</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ied966413948cf3c935a8a1eb911=
72ef7a6948bdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1616 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--j4jAg2m5Kps=--

