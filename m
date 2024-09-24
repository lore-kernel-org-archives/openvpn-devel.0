From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 10:28:34 +0000
In-Reply-To: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
References: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3bb5107b4983a4447e12b78c3811a2c8993fe4c9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8wsqHh29P8c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Automatically enable
 ifconfig-exec/route-exec behaviour for afunix tu...
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

--8wsqHh29P8c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/750?usp=3Demail )

Change subject: Automatically enable ifconfig-exec/route-exec behaviour for=
 afunix tun/tap
......................................................................


Patch Set 11: Code-Review+2

(1 comment)

File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/750/comment/0b10a0ed_debf7137 :
PS10, Line 1747:     if (tt->backend_driver !=3D DRIVER_AFUNIX && tt->backe=
nd_driver !=3D DRIVER_NULL)
> I think there is rebase corruption here - this should go into the "DRIVER=
_NULL" patch
confusion on my part, sorry



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Gerrit-Change-Number: 750
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Sep 2024 10:28:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--8wsqHh29P8c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/750/comment/0b10a0ed_debf7137">Patch Set #10, Line 1747:<=
/a> <code style=3D"font-family:monospace,monospace">    if (tt-&gt;backend_=
driver !=3D DRIVER_AFUNIX &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_NULL=
)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">I think there is rebase corruption here - this shou=
ld go into the &quot;DRIVER_NULL&quot; patch</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">confusion on my part, sorry</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/750?usp=3Demail">change 750</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a2957699757665d70514ba7caf=
e833443018ad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Sep 2024 10:28:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8wsqHh29P8c=--

