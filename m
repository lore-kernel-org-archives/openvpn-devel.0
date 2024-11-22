From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 14:41:26 +0000
In-Reply-To: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
References: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <deaba3d470f767e822267859efa77d64d1399200-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/WVCNFHKH70="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp.c: keep offset
 value when reset buffer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/WVCNFHKH70=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/814?usp=3Demail )

Change subject: mudp.c: keep offset value when reset buffer
......................................................................


Patch Set 1:

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/814/comment/e9f0fd7c_69e29b82 :
PS1, Line 7: mudp.c: keep offset value when reset buffer
"resetting"


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/814/comment/fcb8e952_68fe37ee :
PS1, Line 57:     /* dco-win server requres prepend with sockaddr, so prese=
rve offset */
"requires"


http://gerrit.openvpn.net/c/openvpn/+/814/comment/dfafbbbe_9d592c2d :
PS1, Line 58:     buf_init(&c->c2.buffers->aux_buf, buf.offset);
buf_init can fail (buf_reset_len cannot). Do we need error handling here?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I145573555aaace5e94774b5f977d032d3747ed72
Gerrit-Change-Number: 814
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 22 Nov 2024 14:41:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--/WVCNFHKH70=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/814/comment/e9f0fd7c_69e29b82">Patch Set #1, Line 7:</a> <code style=
=3D"font-family:monospace,monospace">mudp.c: keep offset value when reset b=
uffer</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
&quot;resetting&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/814/comment/fcb8e952=
_68fe37ee">Patch Set #1, Line 57:</a> <code style=3D"font-family:monospace,=
monospace">    /* dco-win server requres prepend with sockaddr, so preserve=
 offset */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">&quot;requires&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/814/comment/dfafbbbe_9d592c2d">Patch Set #1, Line 58:</a> <code=
 style=3D"font-family:monospace,monospace">    buf_init(&amp;c-&gt;c2.buffe=
rs-&gt;aux_buf, buf.offset);</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">buf_init can fail (buf_reset_len cannot). Do we need=
 error handling here?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail">change 814</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/814?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I145573555aaace5e94774b5f977=
d032d3747ed72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 814 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 22 Nov 2024 14:41:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/WVCNFHKH70=--

