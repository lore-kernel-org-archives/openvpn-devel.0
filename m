From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 06:47:33 +0000
References: <gerrit.1763880426000.I02e2c7b27b5a39b11556e4753c648baa05344ffc@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3dc66ac2faf7abaa3d5ea313d3f769ba8af4f9bc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eh2QMDKQuxU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: handle
 ignoring itf domains correctly
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

--eh2QMDKQuxU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1394?usp=3Demail

to review the following change.


Change subject: iservice: handle ignoring itf domains correctly
......................................................................

iservice: handle ignoring itf domains correctly

GetItfDnsDomains() does ignore domains, which are in the search domains
list. Handling of this was done wrong if there was more than one
interface domain. In any case the size returned to the caller was
calculated wrong.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I02e2c7b27b5a39b11556e4753c648baa05344ffc
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 4 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1394/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 006f748..8916bea 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2190,14 +2190,16 @@
                 {
                     if (comma)
                     {
-                        pos =3D comma + 1;
+                        /* Overwrite the ignored domain with remaining one=
(s) */
+                        memmove(pos, comma + 1, buf_size - converted_size);
+                        *size -=3D domain_size + one_glyph;
                         continue;
                     }
                     else
                     {
                         /* This was the last domain */
                         *pos =3D '\0';
-                        *size +=3D one_glyph;
+                        *size -=3D domain_size;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
                     }
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1394?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02e2c7b27b5a39b11556e4753c648baa05344ffc
Gerrit-Change-Number: 1394
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--eh2QMDKQuxU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1394?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: handle ignoring itf domains corre=
ctly<br><br>GetItfDnsDomains() does ignore domains, which are in the search=
 domains<br>list. Handling of this was done wrong if there was more than on=
e<br>interface domain. In any case the size returned to the caller was<br>c=
alculated wrong.<br><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>=
Reported-by: stephan@...2953...<br>Change-Id: I02e2c7b27b5a39b11556e4753c64=
8baa05344ffc<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<b=
r>M src/openvpnserv/interactive.c<br>1 file changed, 4 insertions(+), 2 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/94/1394/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/inter=
active.c b/src/openvpnserv/interactive.c</span><br><span>index 006f748..891=
6bea 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><=
span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2190,14 +2190,=
16 @@</span><br><span>                 {</span><br><span>                  =
   if (comma)</span><br><span>                     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        pos =3D comma + 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    /* Overwrite the ignored domain with remaining one(s) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        memmove(po=
s, comma + 1, buf_size - converted_size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        *size -=3D domain_size + one_=
glyph;</span><br><span>                         continue;</span><br><span> =
                    }</span><br><span>                     else</span><br><=
span>                     {</span><br><span>                         /* Thi=
s was the last domain */</span><br><span>                         *pos =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                *size +=3D one_glyph;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        *size -=3D domain_size;</span><br=
><span>                         return wcslen(domains) ? NO_ERROR : ERROR_F=
ILE_NOT_FOUND;</span><br><span>                     }</span><br><span>     =
            }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1394?usp=3Demail">change 1394</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1394?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02e2c7b27b5a39b11556e4753c6=
48baa05344ffc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1394 </div>
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

--eh2QMDKQuxU=--

