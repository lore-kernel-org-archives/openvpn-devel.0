From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 13:18:39 +0000
In-Reply-To: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
References: <gerrit.1758101669000.Idb137ecbade4b0584a4d74aee34978062e247bc5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d0e4a5c9ff385ac56f220449bf5cfbe1668769d7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iAoZ8SOcEXA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 dev-tools/gerrit-send-mail.py: include Gerrit URL into the commit mes...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iAoZ8SOcEXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
96?usp=3Demail )

Change subject: dev-tools/gerrit-send-mail.py: include Gerrit URL into the =
commit message
......................................................................

dev-tools/gerrit-send-mail.py: include Gerrit URL into the commit message

We used to reference to one of the mailing list archives as the formal
reference for the patch and the review discussions.  With the problematic
reliability of the archives, I've started to manually add the URLs in
the OpenVPN Gerrit to the commits because they give a better reference
and (usually) all the feedback is there in a useful format.

So, enhance this dev-tool script to do this automatically.

Change-Id: Idb137ecbade4b0584a4d74aee34978062e247bc5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1196
Message-Id: <20250917120720.30738-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59234672/
Signed-off-by: Gert Doering <gert@...1296...>
---
M dev-tools/gerrit-send-mail.py
1 file changed, 3 insertions(+), 1 deletion(-)




diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 0b49ae9..450e920 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -99,6 +99,7 @@
     assert comment_start > signed_off_end
     acked_by_text =3D ""
     acked_by_names =3D ""
+    gerrit_url =3D f"{args.url}/c/{details['project']}/+/{args.changeid}"
     for ack in details["acked_by"]:
         acked_by_text +=3D f"Acked-by: {ack}\n"
         acked_by_names +=3D f"{ack}\n"
@@ -106,12 +107,13 @@
         patch_text[:signed_off_end]
         + signed_off_text
         + acked_by_text
+        + f"Gerrit URL: {gerrit_url}\n"
         + patch_text[signed_off_end:comment_start]
         + f"""
 This change was reviewed on Gerrit and approved by at least one
 developer. I request to merge it to {details["target"]}.

-Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
+Gerrit URL: {gerrit_url}
 This mail reflects revision {details["revision"]} of this Change.
 {signed_off_comment}
 Acked-by according to Gerrit (reflected above):

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb137ecbade4b0584a4d74aee34978062e247bc5
Gerrit-Change-Number: 1196
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--iAoZ8SOcEXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1196?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dev-tools/gerrit-send-mail.py: include Gerrit=
 URL into the commit message<br><br>We used to reference to one of the mail=
ing list archives as the formal<br>reference for the patch and the review d=
iscussions.  With the problematic<br>reliability of the archives, I&#39;ve =
started to manually add the URLs in<br>the OpenVPN Gerrit to the commits be=
cause they give a better reference<br>and (usually) all the feedback is the=
re in a useful format.<br><br>So, enhance this dev-tool script to do this a=
utomatically.<br><br>Change-Id: Idb137ecbade4b0584a4d74aee34978062e247bc5<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1196<br>Message-Id: &lt;20250917120720.30738-1-gert@...2132...=
.&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59234672/<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M dev-tools=
/gerrit-send-mail.py<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.=
py</span><br><span>index 0b49ae9..450e920 100755</span><br><span>--- a/dev-=
tools/gerrit-send-mail.py</span><br><span>+++ b/dev-tools/gerrit-send-mail.=
py</span><br><span>@@ -99,6 +99,7 @@</span><br><span>     assert comment_st=
art &gt; signed_off_end</span><br><span>     acked_by_text =3D &quot;&quot;=
</span><br><span>     acked_by_names =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gerrit_url =3D f&quot;{args.url}/c/{d=
etails[&#39;project&#39;]}/+/{args.changeid}&quot;</span><br><span>     for=
 ack in details[&quot;acked_by&quot;]:</span><br><span>         acked_by_te=
xt +=3D f&quot;Acked-by: {ack}\n&quot;</span><br><span>         acked_by_na=
mes +=3D f&quot;{ack}\n&quot;</span><br><span>@@ -106,12 +107,13 @@</span><=
br><span>         patch_text[:signed_off_end]</span><br><span>         + si=
gned_off_text</span><br><span>         + acked_by_text</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        + f&quot;Gerrit URL: {gerrit_url=
}\n&quot;</span><br><span>         + patch_text[signed_off_end:comment_star=
t]</span><br><span>         + f&quot;&quot;&quot;</span><br><span> This cha=
nge was reviewed on Gerrit and approved by at least one</span><br><span> de=
veloper. I request to merge it to {details[&quot;target&quot;]}.</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Gerrit URL: {a=
rgs.url}/c/{details[&quot;project&quot;]}/+/{args.changeid}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Gerrit URL: {gerrit_url}</span><br>=
<span> This mail reflects revision {details[&quot;revision&quot;]} of this =
Change.</span><br><span> {signed_off_comment}</span><br><span> Acked-by acc=
ording to Gerrit (reflected above):</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Dema=
il">change 1196</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1196?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb137ecbade4b0584a4d74aee34=
978062e247bc5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1196 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--iAoZ8SOcEXA=--

