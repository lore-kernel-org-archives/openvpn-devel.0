From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Feb 2026 08:53:21 +0000
References: <gerrit.1770799998000.I14395665f197349e374a81b56f28536ff88937a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4b723dee96a5cc68a63ac83acb77570134eabc52-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ysDpwvOm0aU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: rework all
 occurrences of 'M_ERR | M_ERRNO'
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

--ysDpwvOm0aU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail

to review the following change.


Change subject: rework all occurrences of 'M_ERR | M_ERRNO'
......................................................................

rework all occurrences of 'M_ERR | M_ERRNO'

M_ERR is defined as (M_FATAL | M_ERRNO), so 'msg(M_ERR | M_ERRNO, ...)'
is just the same as 'msg(M_ERR, ...)'.

The occurances in tun.c and dco_freebsd.c are really "if this happens,
we can not go on" errors, so 'M_ERR' (=3D FATAL, plus log errno string)
is the correct thing to do.

The occurances in dns.c do come with error handling and cleanup after
the msg() call, so the right thing is 'M_WARN | M_ERRNO' instead
(warning, plus log errno string).

Github: fixes OpenVPN/openvpn#939

Change-Id: I14395665f197349e374a81b56f28536ff88937a8
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dns.c
M src/openvpn/tun.c
3 files changed, 9 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1517/1

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index d1ad092..ee3a5d0 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -177,7 +177,7 @@
     ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to create new peer");
+        msg(M_ERR, "Failed to create new peer");
     }

     free(drv.ifd_data);
@@ -317,7 +317,7 @@
     ret =3D ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to remove interface %s", ifr.ifr_name=
);
+        msg(M_ERR, "Failed to remove interface %s", ifr.ifr_name);
     }

     tt->dco.ifname[0] =3D 0;
@@ -473,7 +473,7 @@
     ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to start vpn");
+        msg(M_ERR, "Failed to start vpn");
     }

     return ret;
@@ -511,7 +511,7 @@
     ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to set key");
+        msg(M_ERR, "Failed to set key");
     }
     else
     {
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index c00d4b9..3d24050 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -611,13 +611,13 @@
     int ack_pipe_fd[2];
     if (pipe(dns_pipe_fd) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)
     {
-        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to create pipes");
         return false;
     }
     updown_runner->pid =3D fork();
     if (updown_runner->pid =3D=3D -1)
     {
-        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to fork");
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to fork");
         close(dns_pipe_fd[0]);
         close(dns_pipe_fd[1]);
         close(ack_pipe_fd[0]);
@@ -747,7 +747,7 @@
                 {
                     continue;
                 }
-                msg(M_ERR | M_ERRNO, "could not send dns vars filename");
+                msg(M_WARN | M_ERRNO, "could not send dns vars filename");
             }
             break;
         }
@@ -762,7 +762,7 @@
                 {
                     continue;
                 }
-                msg(M_ERR | M_ERRNO, "could not receive dns updown status"=
);
+                msg(M_WARN | M_ERRNO, "could not receive dns updown status=
");
             }
             break;
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e38df3e..3f9ee5d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3011,7 +3011,7 @@
     /* Retrieve the assigned interface name. */
     if (getsockopt(fd, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, utunname, &utunn=
ame_len))
     {
-        msg(M_ERR | M_ERRNO, "Error retrieving utun interface name");
+        msg(M_ERR, "Error retrieving utun interface name");
     }

     tt->actual_name =3D string_alloc(utunname, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14395665f197349e374a81b56f28536ff88937a8
Gerrit-Change-Number: 1517
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ysDpwvOm0aU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">rework all occurrences of &#39;M_ERR | M_ER=
RNO&#39;<br><br>M_ERR is defined as (M_FATAL | M_ERRNO), so &#39;msg(M_ERR =
| M_ERRNO, ...)&#39;<br>is just the same as &#39;msg(M_ERR, ...)&#39;.<br><=
br>The occurances in tun.c and dco_freebsd.c are really &quot;if this happe=
ns,<br>we can not go on&quot; errors, so &#39;M_ERR&#39; (=3D FATAL, plus l=
og errno string)<br>is the correct thing to do.<br><br>The occurances in dn=
s.c do come with error handling and cleanup after<br>the msg() call, so the=
 right thing is &#39;M_WARN | M_ERRNO&#39; instead<br>(warning, plus log er=
rno string).<br><br>Github: fixes OpenVPN/openvpn#939<br><br>Change-Id: I14=
395665f197349e374a81b56f28536ff88937a8<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/d=
ns.c<br>M src/openvpn/tun.c<br>3 files changed, 9 insertions(+), 9 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/17/1517/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.c =
b/src/openvpn/dco_freebsd.c</span><br><span>index d1ad092..ee3a5d0 100644</=
span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/op=
envpn/dco_freebsd.c</span><br><span>@@ -177,7 +177,7 @@</span><br><span>   =
  ret =3D ioctl(dco-&gt;fd, SIOCSDRVSPEC, &amp;drv);</span><br><span>     i=
f (ret)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_ERR | M_ERRNO, &quot;Failed to create new peer&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR=
, &quot;Failed to create new peer&quot;);</span><br><span>     }</span><br>=
<span> </span><br><span>     free(drv.ifd_data);</span><br><span>@@ -317,7 =
+317,7 @@</span><br><span>     ret =3D ioctl(tt-&gt;dco.fd, SIOCIFDESTROY, =
&amp;ifr);</span><br><span>     if (ret)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &quo=
t;Failed to remove interface %s&quot;, ifr.ifr_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;Failed to remove=
 interface %s&quot;, ifr.ifr_name);</span><br><span>     }</span><br><span>=
 </span><br><span>     tt-&gt;dco.ifname[0] =3D 0;</span><br><span>@@ -473,=
7 +473,7 @@</span><br><span>     ret =3D ioctl(dco-&gt;fd, SIOCSDRVSPEC, &a=
mp;drv);</span><br><span>     if (ret)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &quot;=
Failed to start vpn&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_ERR, &quot;Failed to start vpn&quot;);</span><br><spa=
n>     }</span><br><span> </span><br><span>     return ret;</span><br><span=
>@@ -511,7 +511,7 @@</span><br><span>     ret =3D ioctl(dco-&gt;fd, SIOCSDR=
VSPEC, &amp;drv);</span><br><span>     if (ret)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRN=
O, &quot;Failed to set key&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_ERR, &quot;Failed to set key&quot;);</span><br=
><span>     }</span><br><span>     else</span><br><span>     {</span><br><s=
pan>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>inde=
x c00d4b9..3d24050 100644</span><br><span>--- a/src/openvpn/dns.c</span><br=
><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -611,13 +611,13 @@</span>=
<br><span>     int ack_pipe_fd[2];</span><br><span>     if (pipe(dns_pipe_f=
d) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &quot;=
run_dns_up_down: unable to create pipes&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;run_dns_up_=
down: unable to create pipes&quot;);</span><br><span>         return false;=
</span><br><span>     }</span><br><span>     updown_runner-&gt;pid =3D fork=
();</span><br><span>     if (updown_runner-&gt;pid =3D=3D -1)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_ERR | M_ERRNO, &quot;run_dns_up_down: unable to fork&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &q=
uot;run_dns_up_down: unable to fork&quot;);</span><br><span>         close(=
dns_pipe_fd[0]);</span><br><span>         close(dns_pipe_fd[1]);</span><br>=
<span>         close(ack_pipe_fd[0]);</span><br><span>@@ -747,7 +747,7 @@</=
span><br><span>                 {</span><br><span>                     cont=
inue;</span><br><span>                 }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                msg(M_ERR | M_ERRNO, &quot;could not sen=
d dns vars filename&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                msg(M_WARN | M_ERRNO, &quot;could not send dns vars=
 filename&quot;);</span><br><span>             }</span><br><span>          =
   break;</span><br><span>         }</span><br><span>@@ -762,7 +762,7 @@</s=
pan><br><span>                 {</span><br><span>                     conti=
nue;</span><br><span>                 }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                msg(M_ERR | M_ERRNO, &quot;could not rece=
ive dns updown status&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                msg(M_WARN | M_ERRNO, &quot;could not receive dns=
 updown status&quot;);</span><br><span>             }</span><br><span>     =
        break;</span><br><span>         }</span><br><span>diff --git a/src/=
openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index e38df3e..3f9ee5d 10=
0644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/open=
vpn/tun.c</span><br><span>@@ -3011,7 +3011,7 @@</span><br><span>     /* Ret=
rieve the assigned interface name. */</span><br><span>     if (getsockopt(f=
d, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, utunname, &amp;utunname_len))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_ERR | M_ERRNO, &quot;Error retrieving utun interface name&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &q=
uot;Error retrieving utun interface name&quot;);</span><br><span>     }</sp=
an><br><span> </span><br><span>     tt-&gt;actual_name =3D string_alloc(utu=
nname, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail">change 1517</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I14395665f197349e374a81b56f2=
8536ff88937a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1517 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ysDpwvOm0aU=--

