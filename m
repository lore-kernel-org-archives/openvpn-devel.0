From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 14:06:58 +0000
References: <gerrit.1727273213000.Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1838210b47c0914e3119d4f491d6c9a6f8bb5c35-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="laqMa1AZ7Vs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix socketpair
 return status not being checked in port share code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--laqMa1AZ7Vs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail

to review the following change.


Change subject: Fix socketpair return status not being checked in port shar=
e code
......................................................................

Fix socketpair return status not being checked in port share code

found by Coverity after tun_afunix introduced another call to
socketpair, so it started to complain that we only check the
return code in 4 of 5 cases.

Change-Id: Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639
---
M src/openvpn/ps.c
1 file changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/770/1

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 4ca3a12..129f65c 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -234,7 +234,12 @@
         }
         else
         {
-            socketpair(PF_UNIX, SOCK_DGRAM, 0, sd_null);
+            if (!socketpair(AF_UNIX, SOCK_DGRAM, 0, sd_null))
+            {
+                msg(M_WARN|M_ERRNO, "PORT SHARE: socketpair failed -- unab=
le to communicate with background process "
+                    "(%d, %d)", sd, sd_send);
+                goto done;
+            }
             memcpy(CMSG_DATA(h), &sd_null[0], sizeof(sd_null[0]));
         }

@@ -246,6 +251,7 @@
                 );
         }

+done:
         close_socket_if_defined(sd_null[0]);
         close_socket_if_defined(sd_null[1]);
         free(mesg.msg_control);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639
Gerrit-Change-Number: 770
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--laqMa1AZ7Vs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix socketpair return status not being checked in port share =
code<br><br>found by Coverity after tun_afunix introduced another call to<b=
r>socketpair, so it started to complain that we only check the<br>return co=
de in 4 of 5 cases.<br><br>Change-Id: Id99a3ba13c0f1d0bc7e4699fb67ee9dff622=
1639<br>---<br>M src/openvpn/ps.c<br>1 file changed, 7 insertions(+), 1 del=
etion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/70/770/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</spa=
n><br><span>index 4ca3a12..129f65c 100644</span><br><span>--- a/src/openvpn=
/ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -234,7 +234=
,12 @@</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      socketpair(PF_UNIX, SOCK_DGRAM, 0, sd_null);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (!socketpair(AF_UNIX, SOCK_DG=
RAM, 0, sd_null))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(M_WARN|M_ERRNO, &quot;PORT SHARE: socketpair failed -- unable t=
o communicate with background process &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    &quot;(%d, %d)&quot;, sd, sd_s=
end);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span>             memcpy(CMSG_DATA(h), &amp;sd_null[0], s=
izeof(sd_null[0]));</span><br><span>         }</span><br><span> </span><br>=
<span>@@ -246,6 +251,7 @@</span><br><span>                 );</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+done:</span><br><span>         close_socket_if_defined(sd_null[=
0]);</span><br><span>         close_socket_if_defined(sd_null[1]);</span><b=
r><span>         free(mesg.msg_control);</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=
=3Demail">change 770</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67=
ee9dff6221639 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--laqMa1AZ7Vs=--

