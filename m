From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Feb 2026 10:59:59 +0000
In-Reply-To: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <47db9dbf3962fd098d682e77dc7a243df3ef9bed-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zeIVu4Qf3HA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change
 stream_buf_read_setup_dowork parameter to struct steam_buf
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

--zeIVu4Qf3HA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1483?usp=3Demail )

Change subject: Change stream_buf_read_setup_dowork parameter to struct ste=
am_buf
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1483/comment/3dd852a6_53430d82?usp=3D=
email :
PS2, Line 2130:         ASSERT(buf_copy(sb->buf, &sock->stream_buf.residual=
));
socket.c:2130:35: error: =E2=80=98sock=E2=80=99 undeclared (first use in th=
is function)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Gerrit-Change-Number: 1483
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 11 Feb 2026 10:59:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--zeIVu4Qf3HA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1483/comment/3dd852a6_53430d82?usp=3Demail">Patch Set =
#2, Line 2130:</a> <code style=3D"font-family:monospace,monospace">        =
ASSERT(buf_copy(sb-&gt;buf, &amp;sock-&gt;stream_buf.residual));</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>socket.c:2130:35: error: =E2=80=98sock=E2=80=99 undeclared (first use in t=
his function)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1483?usp=3Demail">change 1483</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1483?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637c=
d3bde3881d6e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Feb 2026 10:59:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--zeIVu4Qf3HA=--

