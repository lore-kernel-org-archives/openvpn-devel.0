From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 6 Jan 2024 15:31:06 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <71d3e97fb31adf54ab7b9642bc8aec6b4468e8c1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZmePAH5/j9o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement the
 --tls-export-cert feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZmePAH5/j9o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/466?usp=3Demail )

Change subject: Implement the --tls-export-cert feature
......................................................................


Patch Set 10: Code-Review+2

(1 comment)

Patchset:

PS10:
OK, this seems to be doing what the (old) manpage leads me to expect

- for each level of certificates, --tls-verify is called once (so "1x for l=
evel 0, 1x for level 1" if no intermediate CAs are used) - this was not cle=
ar to me initially, that it's indeed called multiple times.
- depending on the level of call, exactly one `$peer_cert_<n>` env variable=
 is set, and that certificate file exists
- on level 0, `$peer_cert` is set as well
- indeed, different certs show up in these files

The old code only ever sets `peer_cert`, though, independent of the level, =
so I'm not sure having a (single) `$peer_cert_<n>` variable is that useful =
- if it's only one, `peer_cert` is maybe good enough?

So we could move onward, or move to "always `$peer_cert`, no `_<n>`...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Gerrit-Change-Number: 466
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 06 Jan 2024 15:31:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ZmePAH5/j9o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/466?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">OK, this seems to be doing what the (old) ma=
npage leads me to expect</p><ul><li>for each level of certificates, --tls-v=
erify is called once (so &quot;1x for level 0, 1x for level 1&quot; if no i=
ntermediate CAs are used) - this was not clear to me initially, that it&#39=
;s indeed called multiple times.</li><li>depending on the level of call, ex=
actly one `$peer_cert_&lt;n&gt;` env variable is set, and that certificate =
file exists</li><li>on level 0, `$peer_cert` is set as well</li><li>indeed,=
 different certs show up in these files</li></ul><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The old code only ever sets `peer_cert`, t=
hough, independent of the level, so I&#39;m not sure having a (single) `$pe=
er_cert_&lt;n&gt;` variable is that useful - if it&#39;s only one, `peer_ce=
rt` is maybe good enough?</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">So we could move onward, or move to &quot;always `$peer_cert`,=
 no `_&lt;n&gt;`...</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">change 466</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/466?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 06 Jan 2024 15:31:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZmePAH5/j9o=--

