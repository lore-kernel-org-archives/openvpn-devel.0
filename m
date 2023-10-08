From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 11:37:25 +0000
In-Reply-To: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
References: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b89dbc180fa832dfe4375ae561871c5f180605ed-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nIsmBfd4j+w="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print server temp
 key details
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nIsmBfd4j+w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/364?usp=3Demail )

Change subject: Print server temp key details
......................................................................


Patch Set 4: Code-Review+1

(2 comments)

Patchset:

PS4:
Generally LGTM, but could we provide some motivation in the commit message =
what the value of this information is?


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/364/comment/b324bd7e_a92be993 :
PS4, Line 2127:  * Print human readable information about the certifcate in=
to buf
"certificate"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
Gerrit-Change-Number: 364
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Sun, 08 Oct 2023 11:37:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--nIsmBfd4j+w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/364?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Generally LGTM, but could we provide some mot=
ivation in the commit message what the value of this information is?</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_op=
enssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/364/comment/b324bd7e_a92be993">Patch Set =
#4, Line 2127:</a> <code style=3D"font-family:monospace,monospace"> * Print=
 human readable information about the certifcate into buf</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;certificate&quot;=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/364?usp=3Demail">change 364</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
64?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf12bb51a2aac7bcf19070f0b56=
fa3b1a5863bc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Oct 2023 11:37:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--nIsmBfd4j+w=--

