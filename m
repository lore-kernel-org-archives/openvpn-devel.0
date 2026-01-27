From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 23:30:53 +0000
References: <gerrit.1769556650000.Id530d890ba01cffb74d3dc04ad10b153f7bea1d4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b494d9dc8742b5f56d16edab62647e56543cc04f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cGGdpgfRHvI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Prevent NULL
 pointer dereference with --dns-updown
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

--cGGdpgfRHvI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail

to review the following change.


Change subject: Prevent NULL pointer dereference with --dns-updown
......................................................................

Prevent NULL pointer dereference with --dns-updown

If the dns-updown option appears in the config twice, there is a chance
of a NULL pointer dereference when comparing the script path to the
default script path. This happens when a custom script is set, after the
dns-updown script was disabled first. In that case the script path is
NULL, which leads to the deref during a strcmp(3).

Reported-by: <aarnav@...2953...>
Change-Id: Id530d890ba01cffb74d3dc04ad10b153f7bea1d4
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1498/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85669e0..2bca647 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7890,7 +7890,7 @@
         }
         else
         {
-            if (streq(dns->updown, DEFAULT_DNS_UPDOWN))
+            if (dns->updown && streq(dns->updown, DEFAULT_DNS_UPDOWN))
             {
                 /* Unset the default command to prevent warnings */
                 dns->updown =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id530d890ba01cffb74d3dc04ad10b153f7bea1d4
Gerrit-Change-Number: 1498
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--cGGdpgfRHvI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Prevent NULL pointer dereference with --dns=
-updown<br><br>If the dns-updown option appears in the config twice, there =
is a chance<br>of a NULL pointer dereference when comparing the script path=
 to the<br>default script path. This happens when a custom script is set, a=
fter the<br>dns-updown script was disabled first. In that case the script p=
ath is<br>NULL, which leads to the deref during a strcmp(3).<br><br>Reporte=
d-by: &lt;aarnav@...2953...&gt;<br>Change-Id: Id530d890ba01cffb74d3dc04ad10=
b153f7bea1d4<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<b=
r>M src/openvpn/options.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/98/1498/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/ope=
nvpn/options.c</span><br><span>index 85669e0..2bca647 100644</span><br><spa=
n>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</=
span><br><span>@@ -7890,7 +7890,7 @@</span><br><span>         }</span><br><=
span>         else</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (streq(dns-&gt;updown, DEFAULT_DNS_U=
PDOWN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (dns-&gt;updown &amp;&amp; streq(dns-&gt;updown, DEFAULT_DNS_UPDOWN))</s=
pan><br><span>             {</span><br><span>                 /* Unset the =
default command to prevent warnings */</span><br><span>                 dns=
-&gt;updown =3D NULL;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail">change 149=
8</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1498?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id530d890ba01cffb74d3dc04ad1=
0b153f7bea1d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1498 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--cGGdpgfRHvI=--

