From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 28 Aug 2024 14:42:52 +0000
In-Reply-To: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
References: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fb81fc7fdf4c2cbe82621c00c4a47aba00358e41-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CfGDEbDZJQ0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Interpret --key and
 --cert option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CfGDEbDZJQ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/726?usp=3Demail )

Change subject: Interpret --key and --cert option argument as URI
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
So I actually tried to use this in a test scenario. After lots of trials an=
d tribulations I actually managed to let this load a RSA key via pkcs11-pro=
vider and GoogleCloud KMS pkcs11 library. So basic functionality seems to b=
e okay. But where I have hit a brick wall right now is that when I add hook=
 scripts openvpn just hangs completely. AFAICT this is because pkcs11 provi=
der actually uses a thread pool to do its work and that interacts really ba=
dly with fork(). Not completely sure, yet. Might try to do some more tests =
with different backends to see whether it is a generic pkcs11-provider prob=
lem. If anyone has any ideas on how to work-around this issue, that would b=
e welcome.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90caba14231879a
Gerrit-Change-Number: 726
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Wed, 28 Aug 2024 14:42:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--CfGDEbDZJQ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
26?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">So I actually tried to use this in a test scenario=
. After lots of trials and tribulations I actually managed to let this load=
 a RSA key via pkcs11-provider and GoogleCloud KMS pkcs11 library. So basic=
 functionality seems to be okay. But where I have hit a brick wall right no=
w is that when I add hook scripts openvpn just hangs completely. AFAICT thi=
s is because pkcs11 provider actually uses a thread pool to do its work and=
 that interacts really badly with fork(). Not completely sure, yet. Might t=
ry to do some more tests with different backends to see whether it is a gen=
eric pkcs11-provider problem. If anyone has any ideas on how to work-around=
 this issue, that would be welcome.</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail">change =
726</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90=
caba14231879a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Aug 2024 14:42:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--CfGDEbDZJQ0=--

