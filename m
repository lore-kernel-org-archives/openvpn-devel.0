From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 17:49:11 +0000
References: <gerrit.1775324949000.I4d6501ddfb321f57a76841f29ff92c5a412908bb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5f6b8d066e289ea53a338533df5ddebf62ab017b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x5CIKzN7/tE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnmsica: Fix
 setting of iTicks in schedule_adapter_delete
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

--x5CIKzN7/tE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail

to review the following change.


Change subject: openvpnmsica: Fix setting of iTicks in schedule_adapter_del=
ete
......................................................................

openvpnmsica: Fix setting of iTicks in schedule_adapter_delete

Increase the integer, not the pointer.

Found by cppcheck.

Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnmsica/openvpnmsica.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1608/1

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index a145b64..fdb610c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -613,7 +613,7 @@
                 msica_arg_seq_add_tail(seq, szArgument);
             }

-            iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
+            *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
             break; /* Adapter names are unique. There should be no other a=
dapter with this name. */
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb
Gerrit-Change-Number: 1608
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--x5CIKzN7/tE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnmsica: Fix setting of iTicks in sche=
dule_adapter_delete<br><br>Increase the integer, not the pointer.<br><br>Fo=
und by cppcheck.<br><br>Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908b=
b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
src/openvpnmsica/openvpnmsica.c<br>1 file changed, 1 insertion(+), 1 deleti=
on(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/08/1608/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/openvpnm=
sica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index a145b64..fdb=
610c 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br=
><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -613,7 +613=
,7 @@</span><br><span>                 msica_arg_seq_add_tail(seq, szArgume=
nt);</span><br><span>             }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            iTicks +=3D MSICA_ADAPTER_TICK_=
SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *i=
Ticks +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span>             break; /* =
Adapter names are unique. There should be no other adapter with this name. =
*/</span><br><span>         }</span><br><span>     }</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1608?usp=3Demail">change 1608</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1608?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d6501ddfb321f57a76841f29ff=
92c5a412908bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1608 </div>
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

--x5CIKzN7/tE=--

