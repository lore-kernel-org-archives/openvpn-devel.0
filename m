From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Apr 2026 10:30:56 +0000
In-Reply-To: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
References: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad1696529639d20a09058f890bec1bf0daf67d02-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JtnqDtHm4G4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JtnqDtHm4G4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
16?usp=3Demail )

Change subject: push: Make prepare_push_reply return void
......................................................................

push: Make prepare_push_reply return void

It returned a constant value so it didn't actually
mean anything.

While here also make it static.

Identified by cppcheck.

Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1616
Message-Id: <20260406072617.27790-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
514.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push.c
1 file changed, 3 insertions(+), 6 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Gerrit-Change-Number: 1616
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JtnqDtHm4G4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1616?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">push: Make prepare_push_reply return void<br><br=
>It returned a constant value so it didn&#39;t actually<br>mean anything.<b=
r><br>While here also make it static.<br><br>Identified by cppcheck.<br><br=
>Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1616<b=
r>Message-Id: &lt;20260406072617.27790-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36514.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/push.c<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>ind=
ex 835c433..564ce86 100644</span><br><span>--- a/src/openvpn/push.c</span><=
br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -631,10 +631,8 @@</spa=
n><br><span>  * @param c             context structure storing data for VPN=
 tunnel</span><br><span>  * @param gc            gc arena for allocating pu=
sh options</span><br><span>  * @param push_list     push list to where opti=
ons are added</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return true on success,=
 false on failure.</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span> prepare_push_reply(struct context *c, struc=
t gc_arena *gc, struct push_list *push_list)</span><br><span> {</span><br><=
span>     struct tls_multi *tls_multi =3D c-&gt;c2.tls_multi;</span><br><sp=
an>@@ -734,8 +732,6 @@</span><br><span>                 client_max_mtu, o-&=
gt;ce.tun_mtu, o-&gt;ce.tun_mtu);</span><br><span>         }</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span> =
}</span><br><span> </span><br><span> static bool</span><br><span>@@ -1011,7=
 +1007,8 @@</span><br><span>             struct push_list push_list =3D { 0=
 };</span><br><span>             struct gc_arena gc =3D gc_new();</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (prepare_push_reply(c, &amp;gc, &amp;push_list) &amp;&amp; send_push_repl=
y(c, &amp;push_list))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            prepare_push_reply(c, &amp;gc, &amp;push_list);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (send_push_reply(c=
, &amp;push_list))</span><br><span>             {</span><br><span>         =
        ret =3D PUSH_MSG_REQUEST;</span><br><span>                 c-&gt;c2=
.sent_push_reply_expiry =3D now + 30;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3De=
mail">change 1616</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ied966413948cf3c935a8a1eb911=
72ef7a6948bdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1616 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--JtnqDtHm4G4=--

