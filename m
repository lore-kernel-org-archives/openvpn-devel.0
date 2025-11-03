From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 15:10:46 +0000
In-Reply-To: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
References: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3be22a31918c93fcca3faf30b05020b180d5b522-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/m1RjyjVEHA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: fix DNS
 address list generation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/m1RjyjVEHA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
39?usp=3Demail )

Change subject: iservice: fix DNS address list generation
......................................................................

iservice: fix DNS address list generation

While generating the address list string for the DNS server addresses,
to be set in the registry, the offset is calculated the wrong way. This
results in gaps between addresses after the first two.

Reported-By: aarnav@...2953...

Change-Id: I7252d5a252e91ffc03db142aa226c9eb1656480b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1339
Message-Id: <20251103115945.6615-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 577d89c..58f1e02 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1873,7 +1873,7 @@
             {
                 RtlIpv4AddressToStringA(&msg->addr[i].ipv4, addrs + offset=
);
             }
-            offset +=3D strlen(addrs);
+            offset =3D strlen(addrs);
         }

         err =3D SetNameServers(iid, msg->family, addrs);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7252d5a252e91ffc03db142aa226c9eb1656480b
Gerrit-Change-Number: 1339
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/m1RjyjVEHA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1339?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: fix DNS address list generation<br><br=
>While generating the address list string for the DNS server addresses,<br>=
to be set in the registry, the offset is calculated the wrong way. This<br>=
results in gaps between addresses after the first two.<br><br>Reported-By: =
aarnav@...2953...<br><br>Change-Id: I7252d5a252e91ffc03db142aa226c9eb165648=
0b<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Lev S=
tipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1339<br>Message-Id: &lt;20251103115945.6615-1-gert@...2132...=
.&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpnserv/interactive.c<br>1 file changed, 1 insertion(+), 1 deletion(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 577d89c..58f1e02 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1873,7 +1873,7 @@</span><br><span>             {</sp=
an><br><span>                 RtlIpv4AddressToStringA(&amp;msg-&gt;addr[i].=
ipv4, addrs + offset);</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            offset +=3D strlen(addrs);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            offset =3D s=
trlen(addrs);</span><br><span>         }</span><br><span> </span><br><span>=
         err =3D SetNameServers(iid, msg-&gt;family, addrs);</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1339?usp=3Demail">change 1339</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7252d5a252e91ffc03db142aa22=
6c9eb1656480b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1339 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/m1RjyjVEHA=--

