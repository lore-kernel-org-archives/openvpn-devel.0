From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 8 Apr 2024 06:59:00 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e482ee922a6ed74d8587e2f73195653fc11aef75-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xIWvw8oB8yE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 openvpn_snprintf and similar functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xIWvw8oB8yE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/547?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................


Patch Set 2: Code-Review+2

(4 comments)

Patchset:

PS2:
closing some comments as they were commenting code that did not really chan=
ge with this patch...

The only remaining comment is about a comment in the UT which is a bit cryp=
tic. Maybe that can be adjusted on the fly.

Other than that, the code looks good to me <3


File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/f78adfbf_ca231ac7 :
PS2, Line 962:                 if (sret >=3D sizeof(buf))
> if this can truly happen, does it mean that the buffer is undersized comp=
ared to the size of all var [=E2=80=A6]
Done


File src/openvpn/socks.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/0f6508ea_b21108c0 :
PS2, Line 114:                         (int) strlen(creds.username), creds.=
username,
> normally we don't put a paceb etween the cast and the variable name. [=E2=
=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/547/comment/b4ed3e45_e9af3876 :
PS2, Line 116:     ASSERT(sret <=3D sizeof(to_send));
> why ASSERT here while in other cases we just go to error or cleanup?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Gerrit-Change-Number: 547
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 08 Apr 2024 06:59:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--xIWvw8oB8yE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/547?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">closing some comments as they were commenting=
 code that did not really change with this patch...</p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">The only remaining comment is about =
a comment in the UT which is a bit cryptic. Maybe that can be adjusted on t=
he fly.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Other=
 than that, the code looks good to me &lt;3</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/proxy.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/547/comment/f78adfbf_ca231ac7">Patch Set #2, Line 962:</a> <code style=
=3D"font-family:monospace,monospace">                if (sret &gt;=3D sizeo=
f(buf))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">if this can truly happen, does it mean that t=
he buffer is undersized compared to the size of all var [=E2=80=A6]</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/so=
cks.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/547/comment/0f6508ea_b21108c0">Patch Set #2=
, Line 114:</a> <code style=3D"font-family:monospace,monospace">           =
             (int) strlen(creds.username), creds.username,</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">normally we don&#39;t put a paceb etween the cast and the variable na=
me. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/547/comment/b4ed3e45_e9af3876">Patch Set #2, Line 116:</a> <code sty=
le=3D"font-family:monospace,monospace">    ASSERT(sret &lt;=3D sizeof(to_se=
nd));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">why ASSERT here while in other cases we just go=
 to error or cleanup?</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">change 547</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/547?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Apr 2024 06:59:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xIWvw8oB8yE=--

