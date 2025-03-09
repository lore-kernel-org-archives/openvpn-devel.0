From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Mar 2025 15:21:04 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <0bc98d34f4542b7e50a67cdef4b0b227cce8d4c1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LO66ede9YMg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LO66ede9YMg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 12: Code-Review-1

(8 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/0e9bde67_521ea38a :
PS12, Line 23:
please reference the github issue about WMIC no longer working on Win11

Github: OpenVPN/openvpn#642


Patchset:

PS12:
a couple of very minor nits, but there's one thing I consider important eno=
ugh to clarify before applying.


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/614ca4f1_082ef8e0 :
PS12, Line 1171: ApplyGpolSettings32()
`(void)`


http://gerrit.openvpn.net/c/openvpn/+/824/comment/15f3c9b6_c46bf981 :
PS12, Line 1211: ApplyGpolSettings64()
`(void)`


http://gerrit.openvpn.net/c/openvpn/+/824/comment/31278e47_77ce57be :
PS12, Line 1248: ApplyGpolSettings()
`(void)`


http://gerrit.openvpn.net/c/openvpn/+/824/comment/17e52f07_1dd206a9 :
PS12, Line 1609:  * If it doesn't exists, resets to empty, effectively disa=
bling it.
typo here ("exists")


http://gerrit.openvpn.net/c/openvpn/+/824/comment/94c13555_6c14a07a :
PS12, Line 1631:         goto out;
my understanding of the code flow is that the `goto out` should be inside t=
he `if (err !=3D ERROR_FILE_NOT_FOUND)` because otherwise the described beh=
aviour "if it doesn't exist =3D FILE NOT FOUND, reset to empty" can never b=
e triggered.


http://gerrit.openvpn.net/c/openvpn/+/824/comment/c8ba0a57_5dfb1b78 :
PS12, Line 1698:         }
in this case ("no InitialSearchList can be found") this whole function woul=
d then fail to do anything, as RegSetValueExW() is skipped.  Is this intent=
ional?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 12
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Sun, 09 Mar 2025 15:21:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--LO66ede9YMg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">V=
iew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/824/comment/0e9bde67_521ea38a">Patch Set #12, Line 23:</a> <co=
de style=3D"font-family:monospace,monospace"></code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">please reference the github issue a=
bout WMIC no longer working on Win11</p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Github: OpenVPN/openvpn#642</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?t=
ab=3Dcomments">Patch Set #12:</a> </p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">a couple of very minor nits, but there&#39;s one thin=
g I consider important enough to clarify before applying.</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/824/comment/614ca4f1_082ef8e0">Patch Set #12, Li=
ne 1171:</a> <code style=3D"font-family:monospace,monospace">ApplyGpolSetti=
ngs32()</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">`(void)`</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
24/comment/15f3c9b6_c46bf981">Patch Set #12, Line 1211:</a> <code style=3D"=
font-family:monospace,monospace">ApplyGpolSettings64()</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">`(void)`</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/31278e47_77ce57be=
">Patch Set #12, Line 1248:</a> <code style=3D"font-family:monospace,monosp=
ace">ApplyGpolSettings()</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">`(void)`</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/824/comment/17e52f07_1dd206a9">Patch Set #12, Line 1609:</a> =
<code style=3D"font-family:monospace,monospace"> * If it doesn&#39;t exists=
, resets to empty, effectively disabling it.</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">typo here (&quot;exists&quot;)</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/94c1355=
5_6c14a07a">Patch Set #12, Line 1631:</a> <code style=3D"font-family:monosp=
ace,monospace">        goto out;</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">my understanding of the code flow is that the `g=
oto out` should be inside the `if (err !=3D ERROR_FILE_NOT_FOUND)` because =
otherwise the described behaviour &quot;if it doesn&#39;t exist =3D FILE NO=
T FOUND, reset to empty&quot; can never be triggered.</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/c8ba0a57_5dfb1b78">Pa=
tch Set #12, Line 1698:</a> <code style=3D"font-family:monospace,monospace"=
>        }</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">in this case (&quot;no InitialSearchList can be found&quot;) this whol=
e function would then fail to do anything, as RegSetValueExW() is skipped. =
 Is this intentional?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">change 824</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/824?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 09 Mar 2025 15:21:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LO66ede9YMg=--

