From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Dec 2024 13:54:26 +0000
In-Reply-To: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
References: <gerrit.1727098847000.Ie2471e6b2d6974e70423b09918ad1c2136253754@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <375a6840bfbc8921c9a5e362d152b4a4a2044caa-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r/yxFhf539U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: override ai_family
 if 'local' numeric address was specified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r/yxFhf539U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/762?usp=3Demail )

Change subject: override ai_family if 'local' numeric address was specified
......................................................................


Patch Set 7: Code-Review-2

(1 comment)

Patchset:

PS7:
Hah, how annoying.

The client-side behaviour is fine (changing "a mismatch of proto and litera=
l address will fail" to "upgrade to the other proto"), but the *server* sid=
e behaviour breaks all my dual-stack servers.

So a config with

```
port 51194
proto udp6
```

(no `local` statement whatsoever, so "ANY") ends up IPv4-only

```
$ netstat -an |grep 51194
udp        0      0 0.0.0.0:51194           0.0.0.0:*=20=20=20=20=20=20=20=
=20=20
```

... which is inacceptable.  (This is FreeBSD output, which clearly differen=
tiates between "udp", "udp6" and "0.0.0.0:51194" vs. ":::51194").  Meh.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918ad1c2136253754
Gerrit-Change-Number: 762
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Tue, 24 Dec 2024 13:54:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--r/yxFhf539U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/762?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Hah, how annoying.</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">The client-side behaviour is fine (chang=
ing &quot;a mismatch of proto and literal address will fail&quot; to &quot;=
upgrade to the other proto&quot;), but the *server* side behaviour breaks a=
ll my dual-stack servers.</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">So a config with</p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">```<br>port 51194<br>proto udp6<br>```</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">(no `local` statement whatsoever=
, so &quot;ANY&quot;) ends up IPv4-only</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">```<br>$ netstat -an |grep 51194<br>udp        0=
      0 0.0.0.0:51194           0.0.0.0:*                          <br>```<=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">... which is =
inacceptable.  (This is FreeBSD output, which clearly differentiates betwee=
n &quot;udp&quot;, &quot;udp6&quot; and &quot;0.0.0.0:51194&quot; vs. &quot=
;:::51194&quot;).  Meh.</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/762?usp=3Demail">change 762</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/762?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2471e6b2d6974e70423b09918a=
d1c2136253754 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 762 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Dec 2024 13:54:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--r/yxFhf539U=--

