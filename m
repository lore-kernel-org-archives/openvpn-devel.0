From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 12:39:41 +0000
In-Reply-To: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c9267e9210cb6dbb1b4c07e12068e0f9ad46ee32-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TfaMnZGmRHg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print SSL peer
 signature information in handshake debug details
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

--TfaMnZGmRHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/365?usp=3Demail )

Change subject: Print SSL peer signature information in handshake debug det=
ails
......................................................................


Patch Set 8: Code-Review-1

(2 comments)

Patchset:

PS8:
Don't like the libressl preprocessor check


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/365/comment/83effa6a_7262c928 :
PS8, Line 2225:      * linking with an unresolved symbol */
Filed https://github.com/libressl/openbsd/issues/147 for it.
Might be better to test for the function explicitly in configure instead of=
 checking for libressl?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5
Gerrit-Change-Number: 365
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 28 Nov 2023 12:39:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--TfaMnZGmRHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/365?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Don&#39;t like the libressl preprocessor chec=
k</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/ssl_openssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/365/comment/83effa6a_7262c928">=
Patch Set #8, Line 2225:</a> <code style=3D"font-family:monospace,monospace=
">     * linking with an unresolved symbol */</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Filed https://github.com/libressl/o=
penbsd/issues/147 for it.<br>Might be better to test for the function expli=
citly in configure instead of checking for libressl?</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=
=3Demail">change 365</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad730=
02068ec6de1e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 365 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Nov 2023 12:39:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--TfaMnZGmRHg=--

