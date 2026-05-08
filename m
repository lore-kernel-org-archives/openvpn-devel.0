From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:31 +0000
References: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d29e58a3a87aa68822ae0982eca1f8ac1e920bac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ntu5T0pIrcE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pool: Fix a
 potential NULL pointer de-reference in test code
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

--ntu5T0pIrcE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1676?usp=3Demail

to review the following change.


Change subject: pool: Fix a potential NULL pointer de-reference in test code
......................................................................

pool: Fix a potential NULL pointer de-reference in test code

Identified by cppcheck. Probably has been a long time
since that code has been compiled, though.

Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/pool.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1676/1

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 15004c0..ff74e7c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -757,7 +757,7 @@
             break;
         }
         msg(M_INFO | M_NOPREFIX, "IFCONFIG_POOL TEST pass 1: l=3D%s r=3D%s=
 cn=3D%s",
-            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc=
), cn);
+            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc=
), cn ? cn : "[NULL]");
         array[i] =3D h;
     }

@@ -793,7 +793,7 @@
             break;
         }
         msg(M_INFO | M_NOPREFIX, "IFCONFIG_POOL TEST pass 3: l=3D%s r=3D%s=
 cn=3D%s",
-            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc=
), cn);
+            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc=
), cn ? cn : "[NULL]");
         array[i] =3D h;
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1676?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Gerrit-Change-Number: 1676
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ntu5T0pIrcE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1676?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pool: Fix a potential NULL pointer de-refer=
ence in test code<br><br>Identified by cppcheck. Probably has been a long t=
ime<br>since that code has been compiled, though.<br><br>Change-Id: I09ebbf=
6f3555dd68ce8d75bfa844ecac518a0cf2<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M src/openvpn/pool.c<br>1 file changed, 2 in=
sertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/76/1676/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index 15004c0..ff74e7c=
 100644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/=
openvpn/pool.c</span><br><span>@@ -757,7 +757,7 @@</span><br><span>        =
     break;</span><br><span>         }</span><br><span>         msg(M_INFO =
| M_NOPREFIX, &quot;IFCONFIG_POOL TEST pass 1: l=3D%s r=3D%s cn=3D%s&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_in_=
addr_t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            print_in_addr_=
t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn ? cn : &quot;=
[NULL]&quot;);</span><br><span>         array[i] =3D h;</span><br><span>   =
  }</span><br><span> </span><br><span>@@ -793,7 +793,7 @@</span><br><span> =
            break;</span><br><span>         }</span><br><span>         msg(=
M_INFO | M_NOPREFIX, &quot;IFCONFIG_POOL TEST pass 3: l=3D%s r=3D%s cn=3D%s=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pr=
int_in_addr_t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            print_i=
n_addr_t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn ? cn :=
 &quot;[NULL]&quot;);</span><br><span>         array[i] =3D h;</span><br><s=
pan>     }</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1676?usp=3Demail">cha=
nge 1676</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1676?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa84=
4ecac518a0cf2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1676 </div>
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

--ntu5T0pIrcE=--

