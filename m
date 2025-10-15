From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 07:25:27 +0000
References: <gerrit.1760513121000.I61f9d9bb26112eac0c0a47cb9d17982b075887ff@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f091f966baa5649426ef4d8526d071665a7fdef8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6quThxN4SPk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove
 dco_read/write_bytes from dco_context_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6quThxN4SPk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1276?usp=3Demail

to review the following change.


Change subject: dco: remove dco_read/write_bytes from dco_context_t
......................................................................

dco: remove dco_read/write_bytes from dco_context_t

Remove dco_read_bytes and dco_write_bytes from all dco_context_t
structures, as peer statistics are now stored directly in the
corresponding c2 fields across all DCO interfaces.

Change-Id: I61f9d9bb26112eac0c0a47cb9d17982b075887ff
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.h
M src/openvpn/multi.c
4 files changed, 0 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1276/1

diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 2f486f0..0797b82 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -59,8 +59,6 @@
     int dco_message_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;

     struct context *c;
 } dco_context_t;
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 310d433..efd5b27 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -81,8 +81,6 @@
     int dco_message_key_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
 } dco_context_t;

 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4f3f028..02b8389 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -55,9 +55,6 @@
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;

-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
-
     struct context *c;
 };

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..053c54d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3266,8 +3266,6 @@
      * installed, and we do not need to clean up the state in the kernel */
     mi->context.c2.tls_multi->dco_peer_id =3D -1;
     mi->context.sig->signal_text =3D reason;
-    mi->context.c2.dco_read_bytes =3D dco->dco_read_bytes;
-    mi->context.c2.dco_write_bytes =3D dco->dco_write_bytes;
     multi_signal_instance(m, mi, SIGTERM);
 }

@@ -3337,8 +3335,6 @@
     dco->dco_message_type =3D 0;
     dco->dco_message_peer_id =3D -1;
     dco->dco_del_peer_reason =3D -1;
-    dco->dco_read_bytes =3D 0;
-    dco->dco_write_bytes =3D 0;
     return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1276?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61f9d9bb26112eac0c0a47cb9d17982b075887ff
Gerrit-Change-Number: 1276
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--6quThxN4SPk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1276?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco: remove dco_read/write_bytes from dco_c=
ontext_t<br><br>Remove dco_read_bytes and dco_write_bytes from all dco_cont=
ext_t<br>structures, as peer statistics are now stored directly in the<br>c=
orresponding c2 fields across all DCO interfaces.<br><br>Change-Id: I61f9d9=
bb26112eac0c0a47cb9d17982b075887ff<br>Signed-off-by: Ralf Lici &lt;ralf@...493...=
2726...&gt;<br>---<br>M src/openvpn/dco_freebsd.h<br>M src/openvpn/dco_linu=
x.h<br>M src/openvpn/dco_win.h<br>M src/openvpn/multi.c<br>4 files changed,=
 0 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/76/1276/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h</span><br><span=
>index 2f486f0..0797b82 100644</span><br><span>--- a/src/openvpn/dco_freebs=
d.h</span><br><span>+++ b/src/openvpn/dco_freebsd.h</span><br><span>@@ -59,=
8 +59,6 @@</span><br><span>     int dco_message_peer_id;</span><br><span>  =
   int dco_del_peer_reason;</span><br><span>     struct sockaddr_storage dc=
o_float_peer_ss;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
int64_t dco_read_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    uint64_t dco_write_bytes;</span><br><span> </span><br><span>     stru=
ct context *c;</span><br><span> } dco_context_t;</span><br><span>diff --git=
 a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index =
310d433..efd5b27 100644</span><br><span>--- a/src/openvpn/dco_linux.h</span=
><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -81,8 +81,6 @@<=
/span><br><span>     int dco_message_key_id;</span><br><span>     int dco_d=
el_peer_reason;</span><br><span>     struct sockaddr_storage dco_float_peer=
_ss;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t dco_=
read_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64=
_t dco_write_bytes;</span><br><span> } dco_context_t;</span><br><span> </sp=
an><br><span> #endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX=
) */</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_w=
in.h</span><br><span>index 4f3f028..02b8389 100644</span><br><span>--- a/sr=
c/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><=
span>@@ -55,9 +55,6 @@</span><br><span>     int dco_del_peer_reason;</span>=
<br><span>     struct sockaddr_storage dco_float_peer_ss;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t dco_read=
_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t d=
co_write_bytes;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>     struct context *c;</span><br><span> };</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span>=
<br><span>index 2863ff1..053c54d 100644</span><br><span>--- a/src/openvpn/m=
ulti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3266,8=
 +3266,6 @@</span><br><span>      * installed, and we do not need to clean =
up the state in the kernel */</span><br><span>     mi-&gt;context.c2.tls_mu=
lti-&gt;dco_peer_id =3D -1;</span><br><span>     mi-&gt;context.sig-&gt;sig=
nal_text =3D reason;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   mi-&gt;context.c2.dco_read_bytes =3D dco-&gt;dco_read_bytes;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.dco_write_b=
ytes =3D dco-&gt;dco_write_bytes;</span><br><span>     multi_signal_instanc=
e(m, mi, SIGTERM);</span><br><span> }</span><br><span> </span><br><span>@@ =
-3337,8 +3335,6 @@</span><br><span>     dco-&gt;dco_message_type =3D 0;</sp=
an><br><span>     dco-&gt;dco_message_peer_id =3D -1;</span><br><span>     =
dco-&gt;dco_del_peer_reason =3D -1;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    dco-&gt;dco_read_bytes =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    dco-&gt;dco_write_bytes =3D 0;</span><br><spa=
n>     return ret &gt; 0;</span><br><span> }</span><br><span> #endif /* if =
defined(ENABLE_DCO) */</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1276?usp=3Demail">change 12=
76</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1276?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61f9d9bb26112eac0c0a47cb9d1=
7982b075887ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1276 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--6quThxN4SPk=--

