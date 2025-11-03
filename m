From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 15:10:44 +0000
In-Reply-To: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
References: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3be22a31918c93fcca3faf30b05020b180d5b522-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mqLl5oGIMUY="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mqLl5oGIMUY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1339/2

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

Gerrit-MessageType: newpatchset
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

--mqLl5oGIMUY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: fix DNS address list gene=
ration<br><br>While generating the address list string for the DNS server a=
ddresses,<br>to be set in the registry, the offset is calculated the wrong =
way. This<br>results in gaps between addresses after the first two.<br><br>=
Reported-By: aarnav@...2953...<br><br>Change-Id: I7252d5a252e91ffc03db142aa=
226c9eb1656480b<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Ac=
ked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://ger=
rit.openvpn.net/c/openvpn/+/1339<br>Message-Id: &lt;20251103115945.6615-1-g=
ert@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 1 insertion(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/39/1339/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/=
interactive.c b/src/openvpnserv/interactive.c</span><br><span>index 577d89c=
..58f1e02 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span>=
<br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1873,7 +1=
873,7 @@</span><br><span>             {</span><br><span>                 Rt=
lIpv4AddressToStringA(&amp;msg-&gt;addr[i].ipv4, addrs + offset);</span><br=
><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            offset +=3D strlen(addrs);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            offset =3D strlen(addrs);</span><br><span>  =
       }</span><br><span> </span><br><span>         err =3D SetNameServers(=
iid, msg-&gt;family, addrs);</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail">cha=
nge 1339</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--mqLl5oGIMUY=--

