From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:40:10 +0000
References: <gerrit.1762954807000.Ided1ac7c804487055b175d8766535bead257b7d5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <d14f571f0eeea73a1a278cb18618e44a2f8a66b7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jRtR7qkKYwU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix construction of
 invalid pointer in tls_pre_decrypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jRtR7qkKYwU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1373?usp=3Demail )


Change subject: Fix construction of invalid pointer in tls_pre_decrypt
......................................................................

Fix construction of invalid pointer in tls_pre_decrypt

In tls_pre_decrypt we construct a pointer ks with an invalid i if i is TM_S=
IZE
doing a out-of-bounds access in multi->session.

This is a something that exists at least since 2.3.0 (I didn't go further
back but probalby exists in earlier version as well as the commits date
back to SVN beta21 branch).

So we construct the pointer but do not do anything with it if it is inval
id as we check i *after* we construct the pointer `ks`.

I suspect that the compiler optimises the bug away in any higher optimisati=
on
level.

Assuming there is no optimisation, let's check what is possible.
Since we never use the value `ks` if it is invalid, we do not have
worry if it ends up invalid or not. The only thing that we have to
worry about is whether
`session + offsetof(struct tls_session, key[KS_PRIMARY])` is pointing
to memory that is valid to read to construct the `ks` pointer.
This is outside the tls_multi struct, so this is not guaranteed to be
allocated memory but at the same time it is also only few bytes (or few
tens/houndred) after the struct, so it will with an extremely high
probably be in a memory region that will not cause a segfault.

Every time this condition is hit and we construct the invalid pointer,
the log message "TLS Error: Unroutable control packet received" is
printed at `verb 1` or higher. And this is a quite common log message,
which serves as indication as well that a crash is not something that
typically happens but either the optimisation fixes or the memory
region of the invalid access is valid to read from.

Change-Id: Ided1ac7c804487055b175d8766535bead257b7d5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1373/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 398c9ae..e21ac78 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3729,9 +3729,6 @@
     }
     else
     {
-        struct tls_session *session =3D &multi->session[i];
-        struct key_state *ks =3D &session->key[KS_PRIMARY];
-
         /*
          * Packet must belong to an existing session.
          */
@@ -3742,6 +3739,8 @@
             goto error;
         }

+        struct tls_session *session =3D &multi->session[i];
+        struct key_state *ks =3D &session->key[KS_PRIMARY];
         /*
          * Verify remote IP address
          */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1373?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ided1ac7c804487055b175d8766535bead257b7d5
Gerrit-Change-Number: 1373
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jRtR7qkKYwU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1373?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix construction of invalid pointer in tls_pre_decrypt<br><br>In tls_pr=
e_decrypt we construct a pointer ks with an invalid i if i is TM_SIZE<br>do=
ing a out-of-bounds access in multi-&gt;session.<br><br>This is a something=
 that exists at least since 2.3.0 (I didn&#39;t go further<br>back but prob=
alby exists in earlier version as well as the commits date<br>back to SVN b=
eta21 branch).<br><br>So we construct the pointer but do not do anything wi=
th it if it is inval<br>id as we check i *after* we construct the pointer `=
ks`.<br><br>I suspect that the compiler optimises the bug away in any highe=
r optimisation<br>level.<br><br>Assuming there is no optimisation, let&#39;=
s check what is possible.<br>Since we never use the value `ks` if it is inv=
alid, we do not have<br>worry if it ends up invalid or not. The only thing =
that we have to<br>worry about is whether<br>`session + offsetof(struct tls=
_session, key[KS_PRIMARY])` is pointing<br>to memory that is valid to read =
to construct the `ks` pointer.<br>This is outside the tls_multi struct, so =
this is not guaranteed to be<br>allocated memory but at the same time it is=
 also only few bytes (or few<br>tens/houndred) after the struct, so it will=
 with an extremely high<br>probably be in a memory region that will not cau=
se a segfault.<br><br>Every time this condition is hit and we construct the=
 invalid pointer,<br>the log message &quot;TLS Error: Unroutable control pa=
cket received&quot; is<br>printed at `verb 1` or higher. And this is a quit=
e common log message,<br>which serves as indication as well that a crash is=
 not something that<br>typically happens but either the optimisation fixes =
or the memory<br>region of the invalid access is valid to read from.<br><br=
>Change-Id: Ided1ac7c804487055b175d8766535bead257b7d5<br>Signed-off-by: Arn=
e Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file c=
hanged, 2 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1373/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 398c9a=
e..e21ac78 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+=
++ b/src/openvpn/ssl.c</span><br><span>@@ -3729,9 +3729,6 @@</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct tls_session *session =3D=
 &amp;multi-&gt;session[i];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>       =
  /*</span><br><span>          * Packet must belong to an existing session.=
</span><br><span>          */</span><br><span>@@ -3742,6 +3739,8 @@</span><=
br><span>             goto error;</span><br><span>         }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_session *session =3D &amp;multi-&gt;session[i];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct key_state *ks =3D &amp;sessio=
n-&gt;key[KS_PRIMARY];</span><br><span>         /*</span><br><span>        =
  * Verify remote IP address</span><br><span>          */</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1373?usp=3Demail">change 1373</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1373?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ided1ac7c804487055b175d87665=
35bead257b7d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1373 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--jRtR7qkKYwU=--

