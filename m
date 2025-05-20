From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 07:14:38 +0000
References: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <771361fd8fc94dcef8b7366bfafca10b08c3321d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P5TaFNO2qcg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win: fix collecting
 DNS exclude domains
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

--P5TaFNO2qcg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail

to review the following change.


Change subject: win: fix collecting DNS exclude domains
......................................................................

win: fix collecting DNS exclude domains

The size of the returned MULTI_SZ wide string was calculated wrongly.
Instead of adding the size of a WCHAR, only the size of a char was used.
As a result, the domains string was stored too short and was missing the
final string terminator.

Fixes: OpenVPN/openvpn#747
Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1028/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a1581a6..66afb7b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2226,7 +2226,7 @@
                     {
                         /* This was the last domain */
                         *pos =3D '\0';
-                        *size +=3D 1;
+                        *size +=3D one_glyph;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
                     }
                 }
@@ -2248,13 +2248,13 @@
                 memmove(pos + 1, pos, buf_size - converted_size - one_glyp=
h);
                 domains[buf_len - 1] =3D '\0';
                 *pos =3D '.';
-                *size +=3D 1;
+                *size +=3D one_glyph;

                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) =3D '\0';
-                    *size +=3D 1;
+                    *size +=3D one_glyph;
                     return NO_ERROR;
                 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Gerrit-Change-Number: 1028
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--P5TaFNO2qcg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win: fix collecting DNS exclude domains<br><br>The size of t=
he returned MULTI_SZ wide string was calculated wrongly.<br>Instead of addi=
ng the size of a WCHAR, only the size of a char was used.<br>As a result, t=
he domains string was stored too short and was missing the<br>final string =
terminator.<br><br>Fixes: OpenVPN/openvpn#747<br>Change-Id: Ie3fcd845344fd0=
c3ce9a2f99612fb19fe5ebb2f1<br>Signed-off-by: Heiko Hund &lt;heiko@...2866...=
.&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 3 insert=
ions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/28/1028/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interact=
ive.c b/src/openvpnserv/interactive.c</span><br><span>index a1581a6..66afb7=
b 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><spa=
n>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2226,7 +2226,7 @@=
</span><br><span>                     {</span><br><span>                   =
      /* This was the last domain */</span><br><span>                      =
   *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        *size +=3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        *size +=3D one_glyph;</span><=
br><span>                         return wcslen(domains) ? NO_ERROR : ERROR=
_FILE_NOT_FOUND;</span><br><span>                     }</span><br><span>   =
              }</span><br><span>@@ -2248,13 +2248,13 @@</span><br><span>   =
              memmove(pos + 1, pos, buf_size - converted_size - one_glyph);=
</span><br><span>                 domains[buf_len - 1] =3D &#39;\0&#39;;</s=
pan><br><span>                 *pos =3D &#39;.&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                *size +=3D 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                *size +=3D one_gl=
yph;</span><br><span> </span><br><span>                 if (!comma)</span><=
br><span>                 {</span><br><span>                     /* Convers=
ion is done */</span><br><span>                     *(pos + domain_len) =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             *size +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    *size +=3D one_glyph;</span><br><span>          =
           return NO_ERROR;</span><br><span>                 }</span><br><s=
pan> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail">change 1028</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1028?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612=
fb19fe5ebb2f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1028 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--P5TaFNO2qcg=--

