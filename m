From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 11:13:28 +0000
In-Reply-To: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
References: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <37f5b9aa42ebc9eeff85fa8dff3b5931a9895997-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MhTUfy4sv3M="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_pkt: Avoid
 conversion warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MhTUfy4sv3M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1360?usp=3Demail )

Change subject: ssl_pkt: Avoid conversion warnings
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/ssl_pkt.c:

http://gerrit.openvpn.net/c/openvpn/+/1360/comment/a1fe2aaa_8b703041?usp=3D=
email :
PS1, Line 168:     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D 1 << P_OPCOD=
E_SHIFT);
key should be <=3D 7 instead of <=3D 8. I think this is the same problem as=
 in https://gerrit.openvpn.net/c/openvpn/+/1298/3/src/openvpn/ssl.c#3985



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Gerrit-Change-Number: 1360
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 11 Nov 2025 11:13:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--MhTUfy4sv3M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1360/comment/a1fe2aaa_8b703041?usp=3Demail">Patch Set=
 #1, Line 168:</a> <code style=3D"font-family:monospace,monospace">    ASSE=
RT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D 1 &lt;&lt; P_OP=
CODE_SHIFT);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">key should be &lt;=3D 7 instead of &lt;=3D 8. I thi=
nk this is the same problem as in https://gerrit.openvpn.net/c/openvpn/+/12=
98/3/src/openvpn/ssl.c#3985</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail">change 1360</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1360?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a1786b2bf15852222c28e1b73a=
b7edbb5f19d7f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1360 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 11 Nov 2025 11:13:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--MhTUfy4sv3M=--

