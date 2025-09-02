From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 15:46:44 +0000
In-Reply-To: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
References: <gerrit.1756824907000.I40c11864745cc1619cb9cbf490b168f90feb5eac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <98cee57b4f48b0ed5a8a3f7bfcfd5576306ee8e3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y7/0KwNzdYc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: validate
 tun interface before fetching stats
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y7/0KwNzdYc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1166?usp=3Demail )

Change subject: dco_linux: validate tun interface before fetching stats
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

Patchset:

PS1:
breaks BYTECOUNT on Linux+DCO for me (`tuntap_defined()` always returns FAL=
SE)


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/1166/comment/a34991d7_2990cc7c :
PS1, Line 1187:     if (!tuntap_defined(c->c1.tuntap))
this does not work, as it checks

```
return tt && tt->fd >=3D 0;
```

and with DCO, tt->fd is not set, so this totally breaks counters in client =
mode with DCO.  It does not crash, though.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40c11864745cc1619cb9cbf490b168f90feb5eac
Gerrit-Change-Number: 1166
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Tue, 02 Sep 2025 15:46:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Y7/0KwNzdYc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1166?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">breaks BYTECOUNT on Linux+DCO for me (`tunt=
ap_defined()` always returns FALSE)</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
166/comment/a34991d7_2990cc7c">Patch Set #1, Line 1187:</a> <code style=3D"=
font-family:monospace,monospace">    if (!tuntap_defined(c-&gt;c1.tuntap))<=
/code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this d=
oes not work, as it checks</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```    <br>return tt &amp;&amp; tt-&gt;fd &gt;=3D 0;<br>```</=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">and with DCO, =
tt-&gt;fd is not set, so this totally breaks counters in client mode with D=
CO.  It does not crash, though.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail">change 116=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1166?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40c11864745cc1619cb9cbf490b=
168f90feb5eac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1166 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 02 Sep 2025 15:46:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Y7/0KwNzdYc=--

