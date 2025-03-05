From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Mar 2025 06:57:39 +0000
In-Reply-To: <gerrit.1736860439000.I925accd8267f94ecfd9ccea85bae965dc2a10208@...2715...>
References: <gerrit.1736860439000.I925accd8267f94ecfd9ccea85bae965dc2a10208@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3b9af10c4efa1b58ae4734829e22250420070362-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C79oXL/Y9yw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add more
 'intentional fallthrough' comments
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

--C79oXL/Y9yw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
4?usp=3Demail )

Change subject: Add more 'intentional fallthrough' comments
......................................................................

Add more 'intentional fallthrough' comments

To make it easier to exclude them from compiler
warnings.

Based on the existing comment in init.c

Change-Id: I925accd8267f94ecfd9ccea85bae965dc2a10208
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250228170232.322186-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
990.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/list.c
M src/openvpn/push.c
2 files changed, 11 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 69f1510..6987def 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -437,34 +437,44 @@
     {
         case 11:
             c +=3D ((uint32_t) k[10] << 24);
+        /* Intentional [[fallthrough]]; */

         case 10:
             c +=3D ((uint32_t) k[9] << 16);
+        /* Intentional [[fallthrough]]; */

         case 9:
             c +=3D ((uint32_t) k[8] << 8);
+        /* Intentional [[fallthrough]]; */

         /* the first byte of c is reserved for the length */
         case 8:
             b +=3D ((uint32_t) k[7] << 24);
+        /* Intentional [[fallthrough]]; */

         case 7:
             b +=3D ((uint32_t) k[6] << 16);
+        /* Intentional [[fallthrough]]; */

         case 6:
             b +=3D ((uint32_t) k[5] << 8);
+        /* Intentional [[fallthrough]]; */

         case 5:
             b +=3D k[4];
+        /* Intentional [[fallthrough]]; */

         case 4:
             a +=3D ((uint32_t) k[3] << 24);
+        /* Intentional [[fallthrough]]; */

         case 3:
             a +=3D ((uint32_t) k[2] << 16);
+        /* Intentional [[fallthrough]]; */

         case 2:
             a +=3D ((uint32_t) k[1] << 8);
+        /* Intentional [[fallthrough]]; */

         case 1:
             a +=3D k[0];
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a7cd3bf..80f9065 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -98,6 +98,7 @@

             case AR_INTERACT:
                 ssl_purge_auth(false);
+            /* Intentional [[fallthrough]]; */
=20
             case AR_NOINTERACT:
                 /* SOFT-SIGTUSR1 -- Auth failure error */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/864?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I925accd8267f94ecfd9ccea85bae965dc2a10208
Gerrit-Change-Number: 864
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--C79oXL/Y9yw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/864?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add more &#39;intentional fallthrough&#39; com=
ments<br><br>To make it easier to exclude them from compiler<br>warnings.<b=
r><br>Based on the existing comment in init.c<br><br>Change-Id: I925accd826=
7f94ecfd9ccea85bae965dc2a10208<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<=
br>Message-Id: &lt;20250228170232.322186-1-frank@...2641...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30990.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/list.c<br>M src/openvpn/push.c<br>2 files changed, 11 insertions(+), 0=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>ind=
ex 69f1510..6987def 100644</span><br><span>--- a/src/openvpn/list.c</span><=
br><span>+++ b/src/openvpn/list.c</span><br><span>@@ -437,34 +437,44 @@</sp=
an><br><span>     {</span><br><span>         case 11:</span><br><span>     =
        c +=3D ((uint32_t) k[10] &lt;&lt; 24);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* Intentional [[fallthrough]]; */</span=
><br><span> </span><br><span>         case 10:</span><br><span>            =
 c +=3D ((uint32_t) k[9] &lt;&lt; 16);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* Intentional [[fallthrough]]; */</span><br><sp=
an> </span><br><span>         case 9:</span><br><span>             c +=3D (=
(uint32_t) k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Intentional [[fallthrough]]; */</span><br><span> </span=
><br><span>         /* the first byte of c is reserved for the length */</s=
pan><br><span>         case 8:</span><br><span>             b +=3D ((uint32=
_t) k[7] &lt;&lt; 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Intentional [[fallthrough]]; */</span><br><span> </span><br><=
span>         case 7:</span><br><span>             b +=3D ((uint32_t) k[6] =
&lt;&lt; 16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Intentional [[fallthrough]]; */</span><br><span> </span><br><span>    =
     case 6:</span><br><span>             b +=3D ((uint32_t) k[5] &lt;&lt; =
8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Inten=
tional [[fallthrough]]; */</span><br><span> </span><br><span>         case =
5:</span><br><span>             b +=3D k[4];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* Intentional [[fallthrough]]; */</span><=
br><span> </span><br><span>         case 4:</span><br><span>             a =
+=3D ((uint32_t) k[3] &lt;&lt; 24);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Intentional [[fallthrough]]; */</span><br><span>=
 </span><br><span>         case 3:</span><br><span>             a +=3D ((ui=
nt32_t) k[2] &lt;&lt; 16);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Intentional [[fallthrough]]; */</span><br><span> </span><=
br><span>         case 2:</span><br><span>             a +=3D ((uint32_t) k=
[1] &lt;&lt; 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Intentional [[fallthrough]]; */</span><br><span> </span><br><span> =
        case 1:</span><br><span>             a +=3D k[0];</span><br><span>d=
iff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index a=
7cd3bf..80f9065 100644</span><br><span>--- a/src/openvpn/push.c</span><br><=
span>+++ b/src/openvpn/push.c</span><br><span>@@ -98,6 +98,7 @@</span><br><=
span> </span><br><span>             case AR_INTERACT:</span><br><span>     =
            ssl_purge_auth(false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* Intentional [[fallthrough]]; */</span><br><sp=
an> </span><br><span>             case AR_NOINTERACT:</span><br><span>     =
            /* SOFT-SIGTUSR1 -- Auth failure error */</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/864?usp=3Demail">change 864</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/864?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I925accd8267f94ecfd9ccea85ba=
e965dc2a10208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 864 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--C79oXL/Y9yw=--

