From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 10:19:00 +0000
In-Reply-To: <gerrit.1775324949000.I4d6501ddfb321f57a76841f29ff92c5a412908bb@...2715...>
References: <gerrit.1775324949000.I4d6501ddfb321f57a76841f29ff92c5a412908bb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <576115c749be1b36f1fbaf376a8cf36bdd8783db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FY4hOcz9VSg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnmsica: Fix
 setting of iTicks in schedule_adapter_delete
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

--FY4hOcz9VSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
08?usp=3Demail )

Change subject: openvpnmsica: Fix setting of iTicks in schedule_adapter_del=
ete
......................................................................

openvpnmsica: Fix setting of iTicks in schedule_adapter_delete

Increase the integer, not the pointer.

Found by cppcheck.

Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1608
Message-Id: <20260404203525.30790-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
476.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnmsica/openvpnmsica.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index a145b64..fdb610c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -613,7 +613,7 @@
                 msica_arg_seq_add_tail(seq, szArgument);
             }

-            iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
+            *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
             break; /* Adapter names are unique. There should be no other a=
dapter with this name. */
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb
Gerrit-Change-Number: 1608
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FY4hOcz9VSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1608?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnmsica: Fix setting of iTicks in schedule_=
adapter_delete<br><br>Increase the integer, not the pointer.<br><br>Found b=
y cppcheck.<br><br>Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/=
c/openvpn/+/1608<br>Message-Id: &lt;20260404203525.30790-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg36476.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpnmsica/openvpnmsica.c<br>1 file changed, 1 insertion(+), =
1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnm=
sica.c</span><br><span>index a145b64..fdb610c 100644</span><br><span>--- a/=
src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/open=
vpnmsica.c</span><br><span>@@ -613,7 +613,7 @@</span><br><span>            =
     msica_arg_seq_add_tail(seq, szArgument);</span><br><span>             =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          iTicks +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            *iTicks +=3D MSICA_ADAPTER_TICK_SIZE=
;</span><br><span>             break; /* Adapter names are unique. There sh=
ould be no other adapter with this name. */</span><br><span>         }</spa=
n><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail">change 1608</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1608?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d6501ddfb321f57a76841f29ff=
92c5a412908bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1608 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--FY4hOcz9VSg=--

