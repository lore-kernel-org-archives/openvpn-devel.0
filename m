From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 13:38:56 +0000
In-Reply-To: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
References: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2557486a233cb745d6d1ea91066564f80c577cae-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rHnSC6HWCfU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use USER_PASS_LEN
 instead of TLS_USERNAME_LEN for override-username
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

--rHnSC6HWCfU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/913?usp=3Demail )

Change subject: Use USER_PASS_LEN instead of TLS_USERNAME_LEN for override-=
username
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/913/comment/471048b9_b3cd29b2 :
PS2, Line 1710:     if (ssl_verify_username_length(session, up->username))
Missing "not"?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c2c050dd160746a0f8d9c234abe1e258bc8e48d
Gerrit-Change-Number: 913
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 24 Mar 2025 13:38:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--rHnSC6HWCfU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/913/comment/471048b9_b3cd29b2">Patch Set #2, Line 1=
710:</a> <code style=3D"font-family:monospace,monospace">    if (ssl_verify=
_username_length(session, up-&gt;username))</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Missing &quot;not&quot;?</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/913?usp=3Demail">change 913</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/913?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c2c050dd160746a0f8d9c234ab=
e1e258bc8e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 913 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Mar 2025 13:38:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--rHnSC6HWCfU=--

