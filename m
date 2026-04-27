From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 27 Apr 2026 20:52:02 +0000
In-Reply-To: <gerrit.1777311203000.I9433baee1f5a66d43d4e43e03128ae6a790a7937@...2715...>
References: <gerrit.1777311203000.I9433baee1f5a66d43d4e43e03128ae6a790a7937@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e190ce58c0a0e5dc666897a5a99644a4b0aea17c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5bO+Q4pqZ1Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid recursive call
 of man_read
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

--5bO+Q4pqZ1Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by plaisthos


Change subject: Avoid recursive call of man_read
......................................................................

Avoid recursive call of man_read

Recursion to `man_read()` happens on Windows when `man_process_command`
tries to log the received command because `management_io`
first checks FD_READ and calls `man_read()` again if there is data is
pending in the receive buffer. This is buggy as `man_read()` is not
designed to be re-entrant.

Fix this by disallowing recursion -- just return 0 so that managament_io
will complete without recursion. Check this condition and do not clear
FD_READ from the event mask in management_io when man_read returns
without calling recv(). Read will get serviced next time when the main even=
t loop
calls `management_io` thorugh `process_io`.  Note that `management_io`
always calls `reset_net_event_win32()` (manage.c: 3298) which will pickup
if any new data to read is pending (win32.c: 357) as well as retain FD_READ=
 if
already set.

Giithub: Fixes OpenVPN/openvpn#1023

Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a7937
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/manage.c
M src/openvpn/manage.h
2 files changed, 16 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1639/2

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2a3023c..31c4bb5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2426,6 +2426,12 @@
     unsigned char buf[256];
     ssize_t len =3D 0;

+    if (man->connection.man_read_state !=3D MAN_READ_IDLE)
+    {
+        return 0; /* not ready to read now */
+    }
+    man->connection.man_read_state =3D MAN_READ_ACTIVE;
+
 #ifdef TARGET_ANDROID
     int fd;
     len =3D man_recv_with_fd(man->connection.sd_cli, buf, sizeof(buf), MSG=
_NOSIGNAL, &fd);
@@ -2508,6 +2514,7 @@
             man_reset_client_socket(man, false);
         }
     }
+    man->connection.man_read_state =3D MAN_READ_IDLE;
     return len;
 }

@@ -3309,10 +3316,14 @@
             {
                 if (net_events & FD_READ)
                 {
-                    while (man_read(man) > 0)
+                    if (man->connection.man_read_state =3D=3D MAN_READ_IDL=
E)
                     {
+                        while (man_read(man) > 0)
+                        {
+                        }
+                        net_event_win32_clear_selected_events(&man->connec=
tion.ne32, FD_READ);
                     }
-                    net_event_win32_clear_selected_events(&man->connection=
.ne32, FD_READ);
+                    /* if ACTIVE: reentrancy, skip read and skip clearing =
FD_READ */
                 }

                 if (net_events & FD_WRITE)
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 27d3b60..0632500 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -328,6 +328,9 @@
     int lastfdreceived;
 #endif
     int client_version;
+#define MAN_READ_IDLE   0
+#define MAN_READ_ACTIVE 1
+    int man_read_state;
 };

 struct management

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a7937
Gerrit-Change-Number: 1639
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--5bO+Q4pqZ1Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Avoid recursive call of man_rea=
d<br><br>Recursion to `man_read()` happens on Windows when `man_process_com=
mand`<br>tries to log the received command because `management_io`<br>first=
 checks FD_READ and calls `man_read()` again if there is data is<br>pending=
 in the receive buffer. This is buggy as `man_read()` is not<br>designed to=
 be re-entrant.<br><br>Fix this by disallowing recursion -- just return 0 s=
o that managament_io<br>will complete without recursion. Check this conditi=
on and do not clear<br>FD_READ from the event mask in management_io when ma=
n_read returns<br>without calling recv(). Read will get serviced next time =
when the main event loop<br>calls `management_io` thorugh `process_io`.  No=
te that `management_io`<br>always calls `reset_net_event_win32()` (manage.c=
: 3298) which will pickup<br>if any new data to read is pending (win32.c: 3=
57) as well as retain FD_READ if<br>already set.<br><br>Giithub: Fixes Open=
VPN/openvpn#1023<br><br>Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a793=
7<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src=
/openvpn/manage.c<br>M src/openvpn/manage.h<br>2 files changed, 16 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/39/1639/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/manage.c b/src/openvpn/manage.c</span><br><span>index 2a3023c..31c4bb5 1=
00644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/=
openvpn/manage.c</span><br><span>@@ -2426,6 +2426,12 @@</span><br><span>   =
  unsigned char buf[256];</span><br><span>     ssize_t len =3D 0;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (man=
-&gt;connection.man_read_state !=3D MAN_READ_IDLE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return 0; /* not ready to read now */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    man-&gt;connection.man_read_state =3D MAN_=
READ_ACTIVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #ifdef TARGET_ANDROID</span><br><span>     int fd;</span><br><sp=
an>     len =3D man_recv_with_fd(man-&gt;connection.sd_cli, buf, sizeof(buf=
), MSG_NOSIGNAL, &amp;fd);</span><br><span>@@ -2508,6 +2514,7 @@</span><br>=
<span>             man_reset_client_socket(man, false);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    man-&gt;connection.man_read_state =3D MAN_READ_IDLE;</span><=
br><span>     return len;</span><br><span> }</span><br><span> </span><br><s=
pan>@@ -3309,10 +3316,14 @@</span><br><span>             {</span><br><span>=
                 if (net_events &amp; FD_READ)</span><br><span>            =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     while (man_read(man) &gt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    if (man-&gt;connection.man_read_state =3D=
=3D MAN_READ_IDLE)</span><br><span>                     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        while (man_re=
ad(man) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        net_event_win32_clear_selected_events(&amp;=
man-&gt;connection.ne32, FD_READ);</span><br><span>                     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    net=
_event_win32_clear_selected_events(&amp;man-&gt;connection.ne32, FD_READ);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
/* if ACTIVE: reentrancy, skip read and skip clearing FD_READ */</span><br>=
<span>                 }</span><br><span> </span><br><span>                =
 if (net_events &amp; FD_WRITE)</span><br><span>diff --git a/src/openvpn/ma=
nage.h b/src/openvpn/manage.h</span><br><span>index 27d3b60..0632500 100644=
</span><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openv=
pn/manage.h</span><br><span>@@ -328,6 +328,9 @@</span><br><span>     int la=
stfdreceived;</span><br><span> #endif</span><br><span>     int client_versi=
on;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MAN_READ=
_IDLE   0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MA=
N_READ_ACTIVE 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int man_read_state;</span><br><span> };</span><br><span> </span><br><span> =
struct management</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">change 1639</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9433baee1f5a66d43d4e43e0312=
8ae6a790a7937 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1639 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--5bO+Q4pqZ1Y=--

