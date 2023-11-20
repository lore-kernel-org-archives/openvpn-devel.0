From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 17:15:44 +0000
In-Reply-To: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
References: <gerrit.1700485351000.Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a0752893f19126891c6d7866f4c5e240bcf4d970-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dMrboPqRvq4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename state_change
 to continue_tls_process
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dMrboPqRvq4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/452?usp=3Demail )

Change subject: Rename state_change to continue_tls_process
......................................................................


Patch Set 3:

(3 comments)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/452/comment/4493eb6f_5624d2ca :
PS1, Line 2936:             if (!read_incoming_tls_ciphertext(&entry->buf, =
ks, &continue_tls_process))
> Should rename argument of read_incoming_tls_ciphertext as well
Done


http://gerrit.openvpn.net/c/openvpn/+/452/comment/1e69d0fc_7323711d :
PS1, Line 2947:         if (!read_incoming_tls_plaintext(ks, buf, wakeup, &=
continue_tls_process))
> Should rename argument of read_incoming_tls_plaintext as well
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/452/comment/c4c12c6f_b4fe17bb :
PS2, Line 3007:             if (!write_outgoing_tls_ciphertext(session, &st=
ate_change))
> Still says state_change, breaking the build
That is what you get for only testing the whole patch set and not each comm=
it.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib6d713f2eb08a4c39d97de3e1a4a832cedc09585
Gerrit-Change-Number: 452
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 20 Nov 2023 17:15:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--dMrboPqRvq4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/452/comment/4493eb6f_5624d2ca">Patch Set #1, Line 2936:</a> <=
code style=3D"font-family:monospace,monospace">            if (!read_incomi=
ng_tls_ciphertext(&amp;entry-&gt;buf, ks, &amp;continue_tls_process))</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Should rename argument of read_incoming_tls_ciphertext as =
well</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/452/=
comment/1e69d0fc_7323711d">Patch Set #1, Line 2947:</a> <code style=3D"font=
-family:monospace,monospace">        if (!read_incoming_tls_plaintext(ks, b=
uf, wakeup, &amp;continue_tls_process))</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should rename=
 argument of read_incoming_tls_plaintext as well</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/452/comment/c4c12c6f_b4fe17bb">Patch Set #2, Line 3007:</a> <c=
ode style=3D"font-family:monospace,monospace">            if (!write_outgoi=
ng_tls_ciphertext(session, &amp;state_change))</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Still =
says state_change, breaking the build</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">That is what you get for only testing=
 the whole patch set and not each commit.</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail">c=
hange 452</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/452?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6d713f2eb08a4c39d97de3e1a4=
a832cedc09585 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 452 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Nov 2023 17:15:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dMrboPqRvq4=--

