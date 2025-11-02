From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 2 Nov 2025 14:13:39 +0000
References: <gerrit.1762092816000.I7252d5a252e91ffc03db142aa226c9eb1656480b@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <12c5e4ddf15f7bf9ac0a93de24b87434169d9f98-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f4IgVfg+EXs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f4IgVfg+EXs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail

to review the following change.


Change subject: iservice: fix DNS address list generation
......................................................................

iservice: fix DNS address list generation

While generating the address list string for the DNS server addresses,
to be set in the registry, the offset is calculated the wrong way. This
results in gaps between addresses after the first two.

Change-Id: I7252d5a252e91ffc03db142aa226c9eb1656480b
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1339/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7252d5a252e91ffc03db142aa226c9eb1656480b
Gerrit-Change-Number: 1339
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--f4IgVfg+EXs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1339?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: fix DNS address list generation<b=
r><br>While generating the address list string for the DNS server addresses=
,<br>to be set in the registry, the offset is calculated the wrong way. Thi=
s<br>results in gaps between addresses after the first two.<br><br>Change-I=
d: I7252d5a252e91ffc03db142aa226c9eb1656480b<br>Signed-off-by: Heiko Hund &=
lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1339/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</spa=
n><br><span>index 577d89c..58f1e02 100644</span><br><span>--- a/src/openvpn=
serv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</spa=
n><br><span>@@ -1873,7 +1873,7 @@</span><br><span>             {</span><br>=
<span>                 RtlIpv4AddressToStringA(&amp;msg-&gt;addr[i].ipv4, a=
ddrs + offset);</span><br><span>             }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            offset +=3D strlen(addrs);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            offset =3D strlen(a=
ddrs);</span><br><span>         }</span><br><span> </span><br><span>       =
  err =3D SetNameServers(iid, msg-&gt;family, addrs);</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1339?usp=3Demail">change 1339</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1339?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7252d5a252e91ffc03db142aa22=
6c9eb1656480b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1339 </div>
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

</body></html>=

--f4IgVfg+EXs=--

