From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 17 Feb 2026 08:10:55 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c8820a5b3cb6984be08bd80f58f0ec24e9e210ed-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="omGKHEEcfGE="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--omGKHEEcfGE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

ralf_lici has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reject incoming reneg request if primary key is not fu=
lly valid
......................................................................


Patch Set 3:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1478/comment/02b189c3_6784af74?usp=3D=
email :
PS2, Line 12: checks deauthenticate the key without demoting its TLS state.
> Should we add the scenario where we just waiting for the hand-window to h=
ave the key be fully authen [=E2=80=A6]
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1478/comment/5ea276c4_a76158a4?usp=3D=
email :
PS2, Line 3757:                     "TLS Error: rejecting incoming renegoti=
ation request: key not fully authenticated/valid");
> Maybe make this message a bit more verbose to help later debugging and pr=
int the key-id in ks too?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 17 Feb 2026 08:10:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--omGKHEEcfGE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1478/comment/02b189c3_6784af74?usp=3Demail">Patch Set #2, Line 12:</=
a> <code style=3D"font-family:monospace,monospace">checks deauthenticate th=
e key without demoting its TLS state.</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we add t=
he scenario where we just waiting for the hand-window to have the key be fu=
lly authen [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1478/comment/5ea276c4_a76158a4?usp=3Demail">Patch Set #2, Line 3757:</a> =
<code style=3D"font-family:monospace,monospace">                    &quot;T=
LS Error: rejecting incoming renegotiation request: key not fully authentic=
ated/valid&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Maybe make this message a bit more=
 verbose to help later debugging and print the key-id in ks too?</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
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
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Feb 2026 08:10:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--omGKHEEcfGE=--

