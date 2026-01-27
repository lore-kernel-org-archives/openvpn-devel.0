From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 14:42:04 +0000
In-Reply-To: <gerrit.1769005798000.I575d65912ce9065a0b0868e73998b4a9aece62af@...2715...>
References: <gerrit.1769005798000.I575d65912ce9065a0b0868e73998b4a9aece62af@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9ba74cea2adf8d06e598f0a187ce226cd3dcc4c1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YhKBcLxMYhw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YhKBcLxMYhw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
84?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1484
Message-Id: <20260122125707.108048-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
390.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 3 insertions(+), 2 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I575d65912ce9065a0b0868e73998b4a9aece62af
Gerrit-Change-Number: 1484
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YhKBcLxMYhw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1484?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">manage: Do not trigger actions on management dis=
connect if not authenticated<br><br>If the management interface requires au=
thentication via password<br>and the remote did not specify it, do not do t=
rigger actions<br>requested by --management-forget-disconnect and --managem=
ent-signal<br>on disconnect.<br><br>Reported-By: Joshua Rogers &lt;contact@=
...2949...&gt;<br>Found-By: ZeroPath (https://zeropath.com)<br>Github: open=
vpn-private-issues#5<br>Change-Id: I575d65912ce9065a0b0868e73998b4a9aece62a=
f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1484<br>Message-Id: &lt;20260122125707.108048-1-fr=
ank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35390.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 3 insertions=
(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 8fa8784..37ae6b3 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -2073,13 +2073=
,14 @@</span><br><span>     }</span><br><span>     if (!exiting)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (man-&gt;settings.flags &amp; MF_FORGET_DISCONNECT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings.flags &amp; =
MF_FORGET_DISCONNECT &amp;&amp; !man_password_needed(man))</span><br><span>=
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(D_MANAGEMENT, &quot;MANAGEMENT: Reset authentication on disconnect&q=
uot;);</span><br><span>             ssl_purge_auth(false);</span><br><span>=
             (void)ssl_clean_auth_token();</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (man-&gt;settings.flags &amp; MF_SIGNAL)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (man-&gt;settings.flags &amp; MF_SIGNAL &=
amp;&amp; !man_password_needed(man))</span><br><span>         {</span><br><=
span>             int mysig =3D man_mod_signal(man, SIGUSR1);</span><br><sp=
an>             if (mysig &gt;=3D 0)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1484?usp=3Dem=
ail">change 1484</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1484?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I575d65912ce9065a0b0868e7399=
8b4a9aece62af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1484 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YhKBcLxMYhw=--

