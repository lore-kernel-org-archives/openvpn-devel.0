From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 12:59:15 +0000
In-Reply-To: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
References: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <343a991bfe7c79def960136ffc919990fd3b6eac-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pi6Y1N5p1jQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not underestimate
 number of encrypted/decrypted AEAD blocks
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

--pi6Y1N5p1jQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1358?usp=3Demail )

Change subject: Do not underestimate number of encrypted/decrypted  AEAD bl=
ocks
......................................................................


Patch Set 1: Code-Review-1

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1358/comment/a141389a_c2889698?usp=3D=
email :
PS1, Line 9: Even thought the current code typically counts all the encrypt=
ed/decrypted
"though"


http://gerrit.openvpn.net/c/openvpn/+/1358/comment/cd75af22_24654220?usp=3D=
email :
PS1, Line 16: Other implementations that AES-GCM (like IPSec, MacSEC, TLS 1=
.2) currently
"that use" ?


http://gerrit.openvpn.net/c/openvpn/+/1358/comment/2ce4762d_48224900?usp=3D=
email :
PS1, Line 17: do not honour these usage limits at all. So this currently no=
t something
That whole last sentence is difficult to parse, mostly because of redundanc=
ies. Maybe something like: "So the absence of usage limit enforcement is no=
t currently considered a security vulnerability, yet."



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Gerrit-Change-Number: 1358
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 07 Nov 2025 12:59:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--pi6Y1N5p1jQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1358/comment/a141389a_c2889698?usp=3Demail">Patch Set #1, Line=
 9:</a> <code style=3D"font-family:monospace,monospace">Even thought the cu=
rrent code typically counts all the encrypted/decrypted</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;t=
hough&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
358/comment/cd75af22_24654220?usp=3Demail">Patch Set #1, Line 16:</a> <code=
 style=3D"font-family:monospace,monospace">Other implementations that AES-G=
CM (like IPSec, MacSEC, TLS 1.2) currently</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;that use&quot; =
?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1358/comment=
/2ce4762d_48224900?usp=3Demail">Patch Set #1, Line 17:</a> <code style=3D"f=
ont-family:monospace,monospace">do not honour these usage limits at all. So=
 this currently not something</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">That whole last sentence is diffic=
ult to parse, mostly because of redundancies. Maybe something like: &quot;S=
o the absence of usage limit enforcement is not currently considered a secu=
rity vulnerability, yet.&quot;</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail">change 1358=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1358?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I429d768fb33ef2c58484287d409=
1440ad8599053 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1358 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07 Nov 2025 12:59:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--pi6Y1N5p1jQ=--

