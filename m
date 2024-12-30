From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 17:42:11 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <07d58f6ef6fb90fa301386498953f57f58bf2e01-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DmYJ5VP38l0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
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

--DmYJ5VP38l0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 10:

(3 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/2e09fad4_f8cd789d :
PS7, Line 114:   open a socket.
> Done, for the text. [=E2=80=A6]
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/0fb1fac6_8c60bfdc :
PS7, Line 3827:     /* use the same listen list for every outgoing connecti=
on */
> We handle everything as a list, but later on there's a specific sanity ch=
eck that in the case of cli [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/436/comment/843e9fd5_709eae74 :
PS7, Line 6250:             e->bind_local =3D true;
> I removed the bind_local variable on the local_entry and rely on the o->c=
e. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 10
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Mon, 30 Dec 2024 17:42:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--DmYJ5VP38l0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options.=
rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/436/comment/2e09fad4_f8cd789d">Patch Set #7, =
Line 114:</a> <code style=3D"font-family:monospace,monospace">  open a sock=
et.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">Done, for the text. [=E2=80=A6]</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/436/comment/0fb1fac6_8c60bfdc">Patch Set #7, Line 3=
827:</a> <code style=3D"font-family:monospace,monospace">    /* use the sam=
e listen list for every outgoing connection */</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We han=
dle everything as a list, but later on there&#39;s a specific sanity check =
that in the case of cli [=E2=80=A6]</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/436/comment/843e9fd5_709eae74">Patch Set #7, Lin=
e 6250:</a> <code style=3D"font-family:monospace,monospace">            e-&=
gt;bind_local =3D true;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">I removed the bind_local vari=
able on the local_entry and rely on the o-&gt;ce. [=E2=80=A6]</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/436?usp=3Demail">change 436</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Dec 2024 17:42:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--DmYJ5VP38l0=--

