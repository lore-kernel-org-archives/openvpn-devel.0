From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 14:30:01 +0000
References: <gerrit.1769005798000.I575d65912ce9065a0b0868e73998b4a9aece62af@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d6e22260461a867b03a51880dbef1a4ab13ed9ca-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EGGS92ykTfI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: Do not
 trigger actions on management disconnect if not authen...
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

--EGGS92ykTfI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1484?usp=3Demail

to review the following change.


Change subject: manage: Do not trigger actions on management disconnect if =
not authenticated
......................................................................

manage: Do not trigger actions on management disconnect if not authenticated

If the management interface requires authentication via password
and the remote did not specify it, do not do trigger actions
requested by --management-forget-disconnect and --management-signal
on disconnect.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#5
Change-Id: I575d65912ce9065a0b0868e73998b4a9aece62af
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1484/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8fa8784..37ae6b3 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2073,13 +2073,14 @@
     }
     if (!exiting)
     {
-        if (man->settings.flags & MF_FORGET_DISCONNECT)
+        if (man->settings.flags & MF_FORGET_DISCONNECT && !man_password_ne=
eded(man))
         {
+            msg(D_MANAGEMENT, "MANAGEMENT: Reset authentication on disconn=
ect");
             ssl_purge_auth(false);
             (void)ssl_clean_auth_token();
         }

-        if (man->settings.flags & MF_SIGNAL)
+        if (man->settings.flags & MF_SIGNAL && !man_password_needed(man))
         {
             int mysig =3D man_mod_signal(man, SIGUSR1);
             if (mysig >=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1484?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I575d65912ce9065a0b0868e73998b4a9aece62af
Gerrit-Change-Number: 1484
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--EGGS92ykTfI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1484?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">manage: Do not trigger actions on managemen=
t disconnect if not authenticated<br><br>If the management interface requir=
es authentication via password<br>and the remote did not specify it, do not=
 do trigger actions<br>requested by --management-forget-disconnect and --ma=
nagement-signal<br>on disconnect.<br><br>Reported-By: Joshua Rogers &lt;con=
tact@...2949...&gt;<br>Found-By: ZeroPath (https://zeropath.com)<br>Github:=
 openvpn-private-issues#5<br>Change-Id: I575d65912ce9065a0b0868e73998b4a9ae=
ce62af<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M src/openvpn/manage.c<br>1 file changed, 3 insertions(+), 2 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/84/1484/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/op=
envpn/manage.c</span><br><span>index 8fa8784..37ae6b3 100644</span><br><spa=
n>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</sp=
an><br><span>@@ -2073,13 +2073,14 @@</span><br><span>     }</span><br><span=
>     if (!exiting)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (man-&gt;settings.flags &amp; MF_FORGET_DIS=
CONNECT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(man-&gt;settings.flags &amp; MF_FORGET_DISCONNECT &amp;&amp; !man_password=
_needed(man))</span><br><span>         {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(D_MANAGEMENT, &quot;MANAGEMENT: Reset =
authentication on disconnect&quot;);</span><br><span>             ssl_purge=
_auth(false);</span><br><span>             (void)ssl_clean_auth_token();</s=
pan><br><span>         }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (man-&gt;settings.flags &amp; MF_SIGNAL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;se=
ttings.flags &amp; MF_SIGNAL &amp;&amp; !man_password_needed(man))</span><b=
r><span>         {</span><br><span>             int mysig =3D man_mod_signa=
l(man, SIGUSR1);</span><br><span>             if (mysig &gt;=3D 0)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1484?usp=3Demail">change 1484</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1484?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I575d65912ce9065a0b0868e7399=
8b4a9aece62af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1484 </div>
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

--EGGS92ykTfI=--

