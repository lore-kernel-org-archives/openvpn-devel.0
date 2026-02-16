From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 14:54:39 +0000
In-Reply-To: <gerrit.1770799998000.I14395665f197349e374a81b56f28536ff88937a8@...2715...>
References: <gerrit.1770799998000.I14395665f197349e374a81b56f28536ff88937a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ecc92bd401cf4232b64465a562da05f8ff7e32ba-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q6kBXLsbX1w="; charset=UTF-8
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

--q6kBXLsbX1w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1517?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1517
Message-Id: <20260211150648.113547-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
594.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
M src/openvpn/dns.c
M src/openvpn/tun.c
3 files changed, 9 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1517/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14395665f197349e374a81b56f28536ff88937a8
Gerrit-Change-Number: 1517
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q6kBXLsbX1w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1517?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">rework all occurrences of &#39;=
M_ERR | M_ERRNO&#39;<br><br>M_ERR is defined as (M_FATAL | M_ERRNO), so &#3=
9;msg(M_ERR | M_ERRNO, ...)&#39;<br>is just the same as &#39;msg(M_ERR, ...=
)&#39;.<br><br>The occurances in tun.c and dco_freebsd.c are really &quot;i=
f this happens,<br>we can not go on&quot; errors, so &#39;M_ERR&#39; (=3D F=
ATAL, plus log errno string)<br>is the correct thing to do.<br><br>The occu=
rances in dns.c do come with error handling and cleanup after<br>the msg() =
call, so the right thing is &#39;M_WARN | M_ERRNO&#39; instead<br>(warning,=
 plus log errno string).<br><br>Github: fixes OpenVPN/openvpn#939<br><br>Ch=
ange-Id: I14395665f197349e374a81b56f28536ff88937a8<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...220...=
..1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1517<br=
>Message-Id: &lt;20260211150648.113547-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35594.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/dco_freebsd.c<br>M src/openvpn/dns.c<br>M src/openvpn/tun.c<br>3 files c=
hanged, 9 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1517/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><s=
pan>index d1ad092..ee3a5d0 100644</span><br><span>--- a/src/openvpn/dco_fre=
ebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -=
177,7 +177,7 @@</span><br><span>     ret =3D ioctl(dco-&gt;fd, SIOCSDRVSPEC=
, &amp;drv);</span><br><span>     if (ret)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &q=
uot;Failed to create new peer&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg(M_ERR, &quot;Failed to create new peer&quot;)=
;</span><br><span>     }</span><br><span> </span><br><span>     free(drv.if=
d_data);</span><br><span>@@ -317,7 +317,7 @@</span><br><span>     ret =3D i=
octl(tt-&gt;dco.fd, SIOCIFDESTROY, &amp;ifr);</span><br><span>     if (ret)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_ERR | M_ERRNO, &quot;Failed to remove interface %s&quot;, i=
fr.ifr_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_ERR, &quot;Failed to remove interface %s&quot;, ifr.ifr_name);</spa=
n><br><span>     }</span><br><span> </span><br><span>     tt-&gt;dco.ifname=
[0] =3D 0;</span><br><span>@@ -473,7 +473,7 @@</span><br><span>     ret =3D=
 ioctl(dco-&gt;fd, SIOCSDRVSPEC, &amp;drv);</span><br><span>     if (ret)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_ERR | M_ERRNO, &quot;Failed to start vpn&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;Failed =
to start vpn&quot;);</span><br><span>     }</span><br><span> </span><br><sp=
an>     return ret;</span><br><span>@@ -511,7 +511,7 @@</span><br><span>   =
  ret =3D ioctl(dco-&gt;fd, SIOCSDRVSPEC, &amp;drv);</span><br><span>     i=
f (ret)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_ERR | M_ERRNO, &quot;Failed to set key&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;=
Failed to set key&quot;);</span><br><span>     }</span><br><span>     else<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/dns.c b/src=
/openvpn/dns.c</span><br><span>index c00d4b9..3d24050 100644</span><br><spa=
n>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br=
><span>@@ -611,13 +611,13 @@</span><br><span>     int ack_pipe_fd[2];</span=
><br><span>     if (pipe(dns_pipe_fd) !=3D 0 || pipe(ack_pipe_fd) !=3D 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot;);</sp=
an><br><span>         return false;</span><br><span>     }</span><br><span>=
     updown_runner-&gt;pid =3D fork();</span><br><span>     if (updown_runn=
er-&gt;pid =3D=3D -1)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: =
unable to fork&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_WARN | M_ERRNO, &quot;run_dns_up_down: unable to fork&quot=
;);</span><br><span>         close(dns_pipe_fd[0]);</span><br><span>       =
  close(dns_pipe_fd[1]);</span><br><span>         close(ack_pipe_fd[0]);</s=
pan><br><span>@@ -747,7 +747,7 @@</span><br><span>                 {</span>=
<br><span>                     continue;</span><br><span>                 }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M=
_ERR | M_ERRNO, &quot;could not send dns vars filename&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN | M_E=
RRNO, &quot;could not send dns vars filename&quot;);</span><br><span>      =
       }</span><br><span>             break;</span><br><span>         }</sp=
an><br><span>@@ -762,7 +762,7 @@</span><br><span>                 {</span><=
br><span>                     continue;</span><br><span>                 }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_=
ERR | M_ERRNO, &quot;could not receive dns updown status&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN | M=
_ERRNO, &quot;could not receive dns updown status&quot;);</span><br><span> =
            }</span><br><span>             break;</span><br><span>         =
}</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span>=
<br><span>index e38df3e..3f9ee5d 100644</span><br><span>--- a/src/openvpn/t=
un.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -3011,7 +30=
11,7 @@</span><br><span>     /* Retrieve the assigned interface name. */</s=
pan><br><span>     if (getsockopt(fd, SYSPROTO_CONTROL, UTUN_OPT_IFNAME, ut=
unname, &amp;utunname_len))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_ERR | M_ERRNO, &quot;Error retri=
eving utun interface name&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_ERR, &quot;Error retrieving utun interface name=
&quot;);</span><br><span>     }</span><br><span> </span><br><span>     tt-&=
gt;actual_name =3D string_alloc(utunname, NULL);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
517?usp=3Demail">change 1517</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1517=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I14395665f197349e374a81b56f2=
8536ff88937a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1517 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--q6kBXLsbX1w=--

