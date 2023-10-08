From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 11:26:06 +0000
In-Reply-To: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
References: <gerrit.1696674325000.I86641bf60d62a50e9b2719e809d2429d65c00097@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <76ecf3ff712021925ce2544ef66b6f5eda6118a1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zmpkPy+5Nek="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add warning for the
 --show-groups command that some groups are missing
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

--zmpkPy+5Nek=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/366?usp=3Demail )

Change subject: Add warning for the --show-groups command that some groups =
are missing
......................................................................


Patch Set 5: Code-Review+2

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/366/comment/5f4d8ebe_072b757d :
PS5, Line 10: in a certain way in the list of all EC cruves. Note this fact=
 and point
"curves"


Patchset:

PS5:
Small typos can be fixed on the fly. Otherwise LGTM


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/366/comment/4c983b16_783b7c50 :
PS5, Line 2364:            "Note this output does only list curves/group th=
at OpenSSL considers as\n"
"groups"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
Gerrit-Change-Number: 366
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Sun, 08 Oct 2023 11:26:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--zmpkPy+5Nek=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/366/comment/5f4d8ebe_072b757d">Patch Set #5, Line 10:</a> <code s=
tyle=3D"font-family:monospace,monospace">in a certain way in the list of al=
l EC cruves. Note this fact and point</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">&quot;curves&quot;</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/366?ta=
b=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Small typos can be fixed on the fly. Otherwise LGTM</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
_openssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/366/comment/4c983b16_783b7c50">Patch S=
et #5, Line 2364:</a> <code style=3D"font-family:monospace,monospace">     =
      &quot;Note this output does only list curves/group that OpenSSL consi=
ders as\n&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">&quot;groups&quot;</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/366?usp=3Demail">change 366</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/366?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86641bf60d62a50e9b2719e809d=
2429d65c00097 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 366 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Oct 2023 11:26:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--zmpkPy+5Nek=--

