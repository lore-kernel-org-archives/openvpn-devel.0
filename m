From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 17 Apr 2025 11:48:56 +0000
In-Reply-To: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
References: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <f90894ca35f1f7907a53efba9a46b721f5272f99-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aAUlov7qsdU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl.c:
 Prevent potential double-free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aAUlov7qsdU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/942?usp=3Demail )

Change subject: ssl_openssl.c: Prevent potential double-free
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/942/comment/6db32f5d_f59632ce :
PS1, Line 1189:     if (info)
> there is no need for this check. Like most free() methods, passing NULL l=
eads to nothing. [=E2=80=A6]
Done


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/942/comment/8c265995_42864120 :
PS3, Line 1190:     info =3D NULL;
what is this for? the variable is going out of scope at this point.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Gerrit-Change-Number: 942
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 17 Apr 2025 11:48:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--aAUlov7qsdU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/942/comment/6db32f5d_f59632ce">Patch Set #1, Line=
 1189:</a> <code style=3D"font-family:monospace,monospace">    if (info)</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">there is no need for this check. Like most free() metho=
ds, passing NULL leads to nothing. [=E2=80=A6]</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/942/comment/8c265995_42864120">Patch Set #3, Line 1190:</a=
> <code style=3D"font-family:monospace,monospace">    info =3D NULL;</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">what is this=
 for? the variable is going out of scope at this point.</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?=
usp=3Demail">change 942</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/942?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4507be07cd5573b2117e837ef03=
187535a38a4b1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Apr 2025 11:48:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--aAUlov7qsdU=--

