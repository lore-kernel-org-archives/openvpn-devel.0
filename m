From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 12:31:29 +0000
References: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <14f626763927ded1a4a0661105a72289b87c4dbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oNMwgaduAHM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Increase default
 size of internal hash maps to 1024
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oNMwgaduAHM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1563?usp=3Demail )


Change subject: Increase default size of internal hash maps to 1024
......................................................................

Increase default size of internal hash maps to 1024

The default of 256 seems quite low for today's standards and cause hash
collisions quite quickly.

Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/advanced-options.rst
M src/openvpn/options.c
2 files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1563/1

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advan=
ced-options.rst
index e1115e4..d922d5d 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -36,7 +36,7 @@

      hash-size r v

-  By default, both tables are sized at 256 buckets.
+  By default, both tables are sized at 1024 buckets.

 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8daec42..630a4eb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -849,8 +849,8 @@
 #endif
     o->vlan_accept =3D VLAN_ALL;
     o->vlan_pvid =3D 1;
-    o->real_hash_size =3D 256;
-    o->virtual_hash_size =3D 256;
+    o->real_hash_size =3D 1024;
+    o->virtual_hash_size =3D 1024;
     o->n_bcast_buf =3D 256;
     o->tcp_queue_limit =3D 64;
     o->max_clients =3D 1024;

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Gerrit-Change-Number: 1563
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oNMwgaduAHM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1563?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Increase default size of internal hash maps to 1024<br><br>The default =
of 256 seems quite low for today&#39;s standards and cause hash<br>collisio=
ns quite quickly.<br><br>Change-Id: Ia699b0dfa407ac377970bb130434298eaaec59=
2b<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/m=
an-sections/advanced-options.rst<br>M src/openvpn/options.c<br>2 files chan=
ged, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/63/1563/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-opt=
ions.rst</span><br><span>index e1115e4..d922d5d 100644</span><br><span>--- =
a/doc/man-sections/advanced-options.rst</span><br><span>+++ b/doc/man-secti=
ons/advanced-options.rst</span><br><span>@@ -36,7 +36,7 @@</span><br><span>=
 </span><br><span>      hash-size r v</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  By default, both tables are sized at 25=
6 buckets.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  By defa=
ult, both tables are sized at 1024 buckets.</span><br><span> </span><br><sp=
an> --bcast-buffers n</span><br><span>   Allocate ``n`` buffers for broadca=
st datagrams (default :code:`256`).</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 8daec42..630a4eb =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -849,8 +849,8 @@</span><br><span> #e=
ndif</span><br><span>     o-&gt;vlan_accept =3D VLAN_ALL;</span><br><span> =
    o-&gt;vlan_pvid =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    o-&gt;real_hash_size =3D 256;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    o-&gt;virtual_hash_size =3D 256;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    o-&gt;real_hash_size =3D 1024;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;virtual_hash_siz=
e =3D 1024;</span><br><span>     o-&gt;n_bcast_buf =3D 256;</span><br><span=
>     o-&gt;tcp_queue_limit =3D 64;</span><br><span>     o-&gt;max_clients =
=3D 1024;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">change 1563</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia699b0dfa407ac377970bb13043=
4298eaaec592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1563 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--oNMwgaduAHM=--

