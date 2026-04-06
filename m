From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Apr 2026 10:30:50 +0000
In-Reply-To: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
References: <gerrit.1775421558000.Ied966413948cf3c935a8a1eb91172ef7a6948bdd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad1696529639d20a09058f890bec1bf0daf67d02-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p+IQpe9/iLs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p+IQpe9/iLs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/1616/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd
Gerrit-Change-Number: 1616
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p+IQpe9/iLs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1616?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">push: Make prepare_push_reply retur=
n void<br><br>It returned a constant value so it didn&#39;t actually<br>mea=
n anything.<br><br>While here also make it static.<br><br>Identified by cpp=
check.<br><br>Change-Id: Ied966413948cf3c935a8a1eb91172ef7a6948bdd<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1616<br>Message-Id: &lt;20260406072617.27790-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
36514.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/push.c<br>1 file changed, 3 insertions(+), 6 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/16/1616/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn/=
push.c</span><br><span>index 835c433..564ce86 100644</span><br><span>--- a/=
src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span=
>@@ -631,10 +631,8 @@</span><br><span>  * @param c             context stru=
cture storing data for VPN tunnel</span><br><span>  * @param gc            =
gc arena for allocating push options</span><br><span>  * @param push_list  =
   push list to where options are added</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @return true on success, false on failure.</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span> prepare_push_repl=
y(struct context *c, struct gc_arena *gc, struct push_list *push_list)</spa=
n><br><span> {</span><br><span>     struct tls_multi *tls_multi =3D c-&gt;c=
2.tls_multi;</span><br><span>@@ -734,8 +732,6 @@</span><br><span>          =
       client_max_mtu, o-&gt;ce.tun_mtu, o-&gt;ce.tun_mtu);</span><br><span=
>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn true;</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span>@@ -1011,7 +1007,8 @@</span><br><span>             struct p=
ush_list push_list =3D { 0 };</span><br><span>             struct gc_arena =
gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (prepare_push_reply(c, &amp;gc, &amp;push_list)=
 &amp;&amp; send_push_reply(c, &amp;push_list))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            prepare_push_reply(c, &amp;gc, &amp=
;push_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (send_push_reply(c, &amp;push_list))</span><br><span>             {=
</span><br><span>                 ret =3D PUSH_MSG_REQUEST;</span><br><span=
>                 c-&gt;c2.sent_push_reply_expiry =3D now + 30;</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1616?usp=3Demail">change 1616</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1616?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--p+IQpe9/iLs=--

