From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 06:47:29 +0000
References: <gerrit.1763880426000.Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <43b86d378bf4c1f48861af4f0cc6c8840ebed761-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VGvyB5we6EM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: make sure
 registry string is terminated
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

--VGvyB5we6EM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail

to review the following change.


Change subject: iservice: make sure registry string is terminated
......................................................................

iservice: make sure registry string is terminated

When reading the interface domains from the registry, check that the
string is zero terminated, since the code in GetItfDnsDomains depends
on the fact when doing size calculations during the conversion.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1392/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index f31a8a9..ec80a30 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2163,7 +2163,7 @@
     {
         *size =3D buf_size;
         err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (P=
BYTE)domains, size);
-        if (!err && *size > one_glyph && wcschr(domains, '.'))
+        if (!err && *size > one_glyph && domains[(*size / one_glyph) - 1] =
=3D=3D '\0' && wcschr(domains, '.'))
         {
             /*
              * Found domain(s), now convert them:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f
Gerrit-Change-Number: 1392
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--VGvyB5we6EM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: make sure registry string is term=
inated<br><br>When reading the interface domains from the registry, check t=
hat the<br>string is zero terminated, since the code in GetItfDnsDomains de=
pends<br>on the fact when doing size calculations during the conversion.<br=
><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>Reported-by: stepha=
n@...2953...<br>Change-Id: Icaeca22bdbd8ead0cb12345b1bcc2b5c0f46236f<br>Sig=
ned-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv=
/interactive.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/92/1392/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvp=
nserv/interactive.c</span><br><span>index f31a8a9..ec80a30 100644</span><br=
><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvp=
nserv/interactive.c</span><br><span>@@ -2163,7 +2163,7 @@</span><br><span> =
    {</span><br><span>         *size =3D buf_size;</span><br><span>        =
 err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)dom=
ains, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (!err &amp;&amp; *size &gt; one_glyph &amp;&amp; wcschr(domains, &#39;.&#=
39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!e=
rr &amp;&amp; *size &gt; one_glyph &amp;&amp; domains[(*size / one_glyph) -=
 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(domains, &#39;.&#39;))</span><br>=
<span>         {</span><br><span>             /*</span><br><span>          =
    * Found domain(s), now convert them:</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1392?usp=
=3Demail">change 1392</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1392?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaeca22bdbd8ead0cb12345b1bc=
c2b5c0f46236f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1392 </div>
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

--VGvyB5we6EM=--

