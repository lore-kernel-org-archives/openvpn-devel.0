From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 15:46:02 +0000
In-Reply-To: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
References: <gerrit.1731290343000.I9e9433b56dcbaa538d9bed30e50cf74948c647cc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <52c770d6cb92d2306b34fdcda73911e475f60cb6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hi5Fv2Lg7QY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Rename
 aead-tag-at-end to aead-epoch
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

--Hi5Fv2Lg7QY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/805?usp=3Demail )

Change subject: Rename aead-tag-at-end to aead-epoch
......................................................................


Patch Set 8: Code-Review-1

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/805/comment/2441bc09_930b0af9 :
PS8, Line 8:
maybe add a short explanation like: "We combine several data-format changes=
 into one flag since they will be introduced together and so we do not need=
 to separate them."


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/805/comment/7b1afc57_7cafb3b5 :
PS8, Line 373:      * AEAD tag is at the end of the  packet and using epoch
Remove "at", remove additional space before "packet". The sentence is still=
 not great then, but at least superficially correct. Maybe simpler:
"Bit-flag indicating that the AEAD tag is at the end of the packet and epoc=
h keys are used"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50cf74948c647cc
Gerrit-Change-Number: 805
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 27 Dec 2024 15:46:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Hi5Fv2Lg7QY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/805?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/805/comment/2441bc09_930b0af9">Patch Set #8, Line 8:</a> <code st=
yle=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">maybe add a short explanation like: &quo=
t;We combine several data-format changes into one flag since they will be i=
ntroduced together and so we do not need to separate them.&quot;</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/805/comment/7b1afc57_7cafb3b5">Patch Set #8, Line =
373:</a> <code style=3D"font-family:monospace,monospace">     * AEAD tag is=
 at the end of the  packet and using epoch</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Remove &quot;at&quot;, remove addition=
al space before &quot;packet&quot;. The sentence is still not great then, b=
ut at least superficially correct. Maybe simpler:<br>&quot;Bit-flag indicat=
ing that the AEAD tag is at the end of the packet and epoch keys are used&q=
uot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/805?usp=3Demail">change 805</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/805?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e9433b56dcbaa538d9bed30e50=
cf74948c647cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 805 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Dec 2024 15:46:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Hi5Fv2Lg7QY=--

