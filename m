From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 13:04:17 +0000
In-Reply-To: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
References: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5368ab6144be4d2b8ba3b7c38376c173191d7fa7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yGKd+EK/2QA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: if a local IPv6
 address is provided, socket must be v6-only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yGKd+EK/2QA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/761?usp=3Demail )

Change subject: if a local IPv6 address is provided, socket must be v6-only
......................................................................


Patch Set 1:

(1 comment)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/761/comment/022a32f8_4e0ee3ea :
PS1, Line 7: if
> Please add more details in commit message. [=E2=80=A6]
Chiming in as I am responsible for this change (implemented loooong ago).
Unfortunately I can't recall the reason why we needed this, but I think it =
has to do with some "interesting" combination of sockets, like:
- one on a specific ipv6
- one on wildcard ipv4
or something along those lines.

I am unable to trigger any conflict using multiple instances right now (wit=
h master branch).

We can exclude this patch for the time being and get back to it once tests =
will reveal what the problem was (or when maybe my memory about this will g=
et back)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I705fd9bf9298a54560eca12e3797351f4af321a7
Gerrit-Change-Number: 761
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 01 Oct 2024 13:04:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--yGKd+EK/2QA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/761/comment/022a32f8_4e0ee3ea">Patch Set #1, Line 7:</a> <code style=
=3D"font-family:monospace,monospace">if</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please add mo=
re details in commit message. [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Chiming in as I am responsible fo=
r this change (implemented loooong ago). Unfortunately I can&#39;t recall t=
he reason why we needed this, but I think it has to do with some &quot;inte=
resting&quot; combination of sockets, like:</p><ul><li>one on a specific ip=
v6</li><li>one on wildcard ipv4</li><li>or something along those lines.</li=
></ul><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I am unabl=
e to trigger any conflict using multiple instances right now (with master b=
ranch).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">We ca=
n exclude this patch for the time being and get back to it once tests will =
reveal what the problem was (or when maybe my memory about this will get ba=
ck)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/761?usp=3Demail">change 761</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/761?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I705fd9bf9298a54560eca12e379=
7351f4af321a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 01 Oct 2024 13:04:17=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yGKd+EK/2QA=--

