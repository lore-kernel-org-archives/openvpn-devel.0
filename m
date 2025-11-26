From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:11:17 +0000
In-Reply-To: <gerrit.1763880426000.I02e2c7b27b5a39b11556e4753c648baa05344ffc@...2715...>
References: <gerrit.1763880426000.I02e2c7b27b5a39b11556e4753c648baa05344ffc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1242d0a84e7b8d90901d94adbcb5545b88ddee75-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DNWE2ZbPxmw="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DNWE2ZbPxmw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
94?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1394
Message-Id: <20251126104706.5378-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
677.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 4 insertions(+), 2 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 4a3e689..ce37ac2f 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02e2c7b27b5a39b11556e4753c648baa05344ffc
Gerrit-Change-Number: 1394
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DNWE2ZbPxmw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1394?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: handle ignoring itf domains correctly<=
br><br>GetItfDnsDomains() does ignore domains, which are in the search doma=
ins<br>list. Handling of this was done wrong if there was more than one<br>=
interface domain. In any case the size returned to the caller was<br>calcul=
ated wrong.<br><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>Repor=
ted-by: stephan@...2953...<br>Change-Id: I02e2c7b27b5a39b11556e4753c648baa0=
5344ffc<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: =
Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.=
net/c/openvpn/+/1394<br>Message-Id: &lt;20251126104706.5378-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg34677.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 4 insertions(+)=
, 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 4a3e689..ce37ac2f 100644</span><br><span>--- a/src=
/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactiv=
e.c</span><br><span>@@ -2190,14 +2190,16 @@</span><br><span>               =
  {</span><br><span>                     if (comma)</span><br><span>       =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  pos =3D comma + 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        /* Overwrite the ignored domain wi=
th remaining one(s) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        memmove(pos, comma + 1, buf_size - converted_siz=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        *size -=3D domain_size + one_glyph;</span><br><span>               =
          continue;</span><br><span>                     }</span><br><span>=
                     else</span><br><span>                     {</span><br>=
<span>                         /* This was the last domain */</span><br><sp=
an>                         *pos =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        *size +=3D one_glyph;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    *size -=3D domain_size;</span><br><span>                         return=
 wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><span>       =
              }</span><br><span>                 }</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1394?usp=3Demail">change 1394</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/13=
94?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02e2c7b27b5a39b11556e4753c6=
48baa05344ffc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1394 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--DNWE2ZbPxmw=--

