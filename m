From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 13 Apr 2026 17:23:52 +0000
In-Reply-To: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
References: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <f1b501dce496228718ccd18bf8e331fb0da823ca-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WJELiLopwYo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: verify_x509_name:
 Improve the error message on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WJELiLopwYo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1624?usp=3Demail )

Change subject: verify_x509_name: Improve the error message on failure
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/1624/comment/b73b8520_97809e57?usp=3D=
email :
PS1, Line 397:         msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
> by applying the same logic, shouldn't we just print the string we have ma=
tched against, instead of t [=E2=80=A6]
Here is my thought on this:
On success, its just a gratuitous message and its not confusing. We are jus=
t printing what the subject (DN) of the certificate is.
On error, its a critical message that says what was expected and what was f=
ound. The current code tries to match something and prints something else.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Gerrit-Change-Number: 1624
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Mon, 13 Apr 2026 17:23:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>

--WJELiLopwYo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1624/comment/b73b8520_97809e57?usp=3Demail">Patch Set =
#1, Line 397:</a> <code style=3D"font-family:monospace,monospace">        m=
sg(D_HANDSHAKE, &quot;VERIFY X509NAME OK: %s&quot;, subject);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">by applying the same logic, shouldn&#39;t we just print the string=
 we have matched against, instead of t [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Here is=
 my thought on this:<br>On success, its just a gratuitous message and its n=
ot confusing. We are just printing what the subject (DN) of the certificate=
 is.<br>On error, its a critical message that says what was expected and wh=
at was found. The current code tries to match something and prints somethin=
g else.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1624?usp=3Demail">change 1624</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1624?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd56=
3a07ace6bd38a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1624 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Apr 2026 17:23:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>

</body></html>=

--WJELiLopwYo=--

