From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Sep 2023 09:54:32 +0000
In-Reply-To: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
References: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277...
Message-ID: <a572af15840e3699233a69beb807de6a4ce48be6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="79U6UuvJC68="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Warn user if
 INFO control command is too long
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--79U6UuvJC68=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/329?usp=3Demail )

Change subject: Warn user if INFO control command is too long
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
Honestly, I still prefer the original patch. But this at least gives the us=
er a chance to notice the problem...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Gerrit-Change-Number: 329
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 12 Sep 2023 09:54:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--79U6UuvJC68=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
29?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Honestly, I still prefer the original patch. But t=
his at least gives the user a chance to notice the problem...</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/329?usp=3Demail">change 329</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95ee=
a57ed420b2542 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 329 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Sep 2023 09:54:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--79U6UuvJC68=--

