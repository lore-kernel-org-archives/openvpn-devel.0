From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 27 Apr 2026 17:33:25 +0000
References: <gerrit.1777311203000.I9433baee1f5a66d43d4e43e03128ae6a790a7937@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <980c92a9aad69e8ae61d829218e5432dab1f198b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tES271nDGRQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid recursive
 call of man_read
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

--tES271nDGRQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail

to review the following change.


Change subject: Avoid recursive call of man_read
......................................................................

Avoid recursive call of man_read

Recursion to `man_read()` happens on Windows when `man_process_command`
tries to log the received command because `management_io`
first checks FD_READ and calls `man_read()` again if there is data is
pending in the receive buffer. This is buggy as `man_read()` is not
designed to be re-entrant.

Fix this by disallowing recursion -- just return 0 so that managament_io
will complete without recursion. Although this will also clear
FD_READ from the event mask via
    `net_event_win32_clear_selected_events(&man->connection.ne32, FD_READ)`
(manage.c:3312), read will get serviced next time when the main event loop
calls `management_io` thorugh `process_io`.  Note that `management_io`
always calls `reset_net_event_win32()` (manage.c: 3298) which will pickup
if any data to read is pending (win32.c: 357) as FD_READ is level triggered.

Giithub: Fixes OpenVPN/openvpn#1023

Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a7937
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/manage.c
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1639/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2a3023c..4d46e61 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2425,6 +2425,13 @@
      */
     unsigned char buf[256];
     ssize_t len =3D 0;
+    static int recursive_level =3D 0;
+
+    if (recursive_level > 0)
+    {
+        return 0; /* not ready to read now */
+    }
+    recursive_level++;

 #ifdef TARGET_ANDROID
     int fd;
@@ -2508,6 +2515,7 @@
             man_reset_client_socket(man, false);
         }
     }
+    recursive_level--;
     return len;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a7937
Gerrit-Change-Number: 1639
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--tES271nDGRQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Avoid recursive call of man_read<br><br>Rec=
ursion to `man_read()` happens on Windows when `man_process_command`<br>tri=
es to log the received command because `management_io`<br>first checks FD_R=
EAD and calls `man_read()` again if there is data is<br>pending in the rece=
ive buffer. This is buggy as `man_read()` is not<br>designed to be re-entra=
nt.<br><br>Fix this by disallowing recursion -- just return 0 so that manag=
ament_io<br>will complete without recursion. Although this will also clear<=
br>FD_READ from the event mask via<br>    `net_event_win32_clear_selected_e=
vents(&amp;man-&gt;connection.ne32, FD_READ)`<br>(manage.c:3312), read will=
 get serviced next time when the main event loop<br>calls `management_io` t=
horugh `process_io`.  Note that `management_io`<br>always calls `reset_net_=
event_win32()` (manage.c: 3298) which will pickup<br>if any data to read is=
 pending (win32.c: 357) as FD_READ is level triggered.<br><br>Giithub: Fixe=
s OpenVPN/openvpn#1023<br><br>Change-Id: I9433baee1f5a66d43d4e43e03128ae6a7=
90a7937<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br=
>M src/openvpn/manage.c<br>1 file changed, 8 insertions(+), 0 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/39/1639/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/open=
vpn/manage.c</span><br><span>index 2a3023c..4d46e61 100644</span><br><span>=
--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span=
><br><span>@@ -2425,6 +2425,13 @@</span><br><span>      */</span><br><span>=
     unsigned char buf[256];</span><br><span>     ssize_t len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    static int recursive_l=
evel =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (recursive_level &gt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return 0; /* not read=
y to read now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    recursive_lev=
el++;</span><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><s=
pan>     int fd;</span><br><span>@@ -2508,6 +2515,7 @@</span><br><span>    =
         man_reset_client_socket(man, false);</span><br><span>         }</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    recursive_level--;</span><br><span>     return len;</span><br><span> }=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">change 1639</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9433baee1f5a66d43d4e43e0312=
8ae6a790a7937 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1639 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--tES271nDGRQ=--

