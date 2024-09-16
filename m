From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 13:04:05 +0000
References: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cedbdcaecfbceb9d718b197844ff07afd73dedc8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XEPVC4Wt3uA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Move
 cipher/data-ciphers warning to D_LOW (verb 4)
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

--XEPVC4Wt3uA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail

to review the following change.


Change subject: Move cipher/data-ciphers warning to D_LOW (verb 4)
......................................................................

Move cipher/data-ciphers warning to D_LOW (verb 4)

These warnings served a purpose in OpenVPN 2.6.x to warn people
about the changed behaviour. But for 2.7 this is will be more
log spam than a helpful message. So only show this warning on a
high verbosity level.

Change-Id: Ie2797a82ad769cb640440d1ba7dfeb416e7b932d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/746/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61f6285..6009e5f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3546,7 +3546,7 @@
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername =3D "BF-CBC";

-        msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.=
5 "
+        msg(D_LOW, "Note: --cipher is not set. OpenVPN versions before 2.5=
 "
             "defaulted to BF-CBC as fallback when cipher negotiation "
             "failed in this case. If you need this fallback please add "
             "'--data-ciphers-fallback BF-CBC' to your configuration "
@@ -3555,7 +3555,7 @@
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing i=
n "
+        msg(D_LOW, "DEPRECATED OPTION: --cipher set to '%s' but missing in=
 "
             "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
             "negotiations. ",
             o->ciphername, o->ncp_ciphers);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2797a82ad769cb640440d1ba7dfeb416e7b932d
Gerrit-Change-Number: 746
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XEPVC4Wt3uA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move cipher/data-ciphers warning to D_LOW (verb 4)<br><br>The=
se warnings served a purpose in OpenVPN 2.6.x to warn people<br>about the c=
hanged behaviour. But for 2.7 this is will be more<br>log spam than a helpf=
ul message. So only show this warning on a<br>high verbosity level.<br><br>=
Change-Id: Ie2797a82ad769cb640440d1ba7dfeb416e7b932d<br>Signed-off-by: Arne=
 Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/options.c<br>1 fil=
e changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/46/746/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index 61f6285..6009=
e5f 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -3546,7 +3546,7 @@</span><br><sp=
an>          * parts of OpenVPN assert that the ciphername is set */</span>=
<br><span>         o-&gt;ciphername =3D &quot;BF-CBC&quot;;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO,=
 &quot;Note: --cipher is not set. OpenVPN versions before 2.5 &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;N=
ote: --cipher is not set. OpenVPN versions before 2.5 &quot;</span><br><spa=
n>             &quot;defaulted to BF-CBC as fallback when cipher negotiatio=
n &quot;</span><br><span>             &quot;failed in this case. If you nee=
d this fallback please add &quot;</span><br><span>             &quot;&#39;-=
-data-ciphers-fallback BF-CBC&#39; to your configuration &quot;</span><br><=
span>@@ -3555,7 +3555,7 @@</span><br><span>     else if (!o-&gt;enable_ncp_=
fallback</span><br><span>              &amp;&amp; !tls_item_in_cipher_list(=
o-&gt;ciphername, o-&gt;ncp_ciphers))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;DEPRECATED=
 OPTION: --cipher set to &#39;%s&#39; but missing in &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;DEPRECATED=
 OPTION: --cipher set to &#39;%s&#39; but missing in &quot;</span><br><span=
>             &quot;--data-ciphers (%s). OpenVPN ignores --cipher for ciphe=
r &quot;</span><br><span>             &quot;negotiations. &quot;,</span><br=
><span>             o-&gt;ciphername, o-&gt;ncp_ciphers);</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/746?usp=3Demail">change 746</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/746?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2797a82ad769cb640440d1ba7d=
feb416e7b932d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 746 </div>
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


--XEPVC4Wt3uA=--

