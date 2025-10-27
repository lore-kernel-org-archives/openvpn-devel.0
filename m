From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 21:10:34 +0000
References: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f46f52e8c4f91c5bfbe543ef1eb0d34572e02ed3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ml1HThSfLKs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid possible race
 condition that kill OpenVPN itself
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

--Ml1HThSfLKs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail

to review the following change.


Change subject: Avoid possible race condition that kill OpenVPN itself
......................................................................

Avoid possible race condition that kill OpenVPN itself

If for whatever reason the child pid is zero, we would kill ourselves
since killing 0 means killing the own process group.

Reported-By: contact@...2949...
Found-By: Zeropath
Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
---
M src/openvpn/tun_afunix.c
1 file changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1319/1

diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 4d48a31..124db6d 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -128,7 +128,12 @@
         close(tt->fd);
         tt->fd =3D 0;
     }
-    kill(tt->afunix.childprocess, SIGINT);
+    /* only kill the child process if the PID is not 0 to avoid killing
+     * ourselves by accident */
+    if (tt->afunix.childprocess)
+    {
+        kill(tt->afunix.childprocess, SIGINT);
+    }

     free(tt->actual_name);
     free(tt);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
Gerrit-Change-Number: 1319
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Ml1HThSfLKs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Avoid possible race condition that kill Ope=
nVPN itself<br><br>If for whatever reason the child pid is zero, we would k=
ill ourselves<br>since killing 0 means killing the own process group.<br><b=
r>Reported-By: contact@...2949...<br>Found-By: Zeropath<br>Change-Id: I7b94=
de92723f9528b01cb932bb079eedf0f1f272<br>---<br>M src/openvpn/tun_afunix.c<b=
r>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1319/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span=
><br><span>index 4d48a31..124db6d 100644</span><br><span>--- a/src/openvpn/=
tun_afunix.c</span><br><span>+++ b/src/openvpn/tun_afunix.c</span><br><span=
>@@ -128,7 +128,12 @@</span><br><span>         close(tt-&gt;fd);</span><br>=
<span>         tt-&gt;fd =3D 0;</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    kill(tt-&gt;afunix.childprocess, SIGIN=
T);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only kill=
 the child process if the PID is not 0 to avoid killing</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * ourselves by accident */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;afunix.child=
process)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        kill(tt-&gt;afuni=
x.childprocess, SIGINT);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> </span><br><span>     free(tt-&gt;actual_name);=
</span><br><span>     free(tt);</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail">=
change 1319</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b94de92723f9528b01cb932bb0=
79eedf0f1f272 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1319 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Ml1HThSfLKs=--

