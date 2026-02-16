From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 14:32:19 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726...
Message-ID: <f897d3a5284e7b9dffb8b81d00b64820efbc2aab-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A1Lv2+X4rls="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--A1Lv2+X4rls=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici.

plaisthos has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reject incoming reneg request if primary key is not fu=
lly valid
......................................................................


Patch Set 2: Code-Review+2

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1478/comment/d36c7cbc_c403a599?usp=3D=
email :
PS2, Line 12: checks deauthenticate the key without demoting its TLS state.
Should we add the scenario where we just waiting for the hand-window to hav=
e the key be fully authenticated? The patch seem to address this but the co=
mmit message does not.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1478/comment/7f990c4b_9382fc22?usp=3D=
email :
PS2, Line 3757:                     "TLS Error: rejecting incoming renegoti=
ation request: key not fully authenticated/valid");
Maybe make this message a bit more verbose to help later debugging and prin=
t the key-id in ks too?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Mon, 16 Feb 2026 14:32:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--A1Lv2+X4rls=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1478/comment/d36c7cbc_c403a599?usp=3Demail">Patch Set #2, Line=
 12:</a> <code style=3D"font-family:monospace,monospace">checks deauthentic=
ate the key without demoting its TLS state.</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Should we add the sc=
enario where we just waiting for the hand-window to have the key be fully a=
uthenticated? The patch seem to address this but the commit message does no=
t.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1478/comment/7f990c4b_9382fc22?usp=3Dema=
il">Patch Set #2, Line 3757:</a> <code style=3D"font-family:monospace,monos=
pace">                    &quot;TLS Error: rejecting incoming renegotiation=
 request: key not fully authenticated/valid&quot;);</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe make t=
his message a bit more verbose to help later debugging and print the key-id=
 in ks too?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1478?usp=3Demail">change 1478</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc309=
08a617265a5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Feb 2026 14:32:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--A1Lv2+X4rls=--

