From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 8 May 2024 13:49:37 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <96bdbc8e5923a899b532f0a444a07f6d11c7481b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O4wX2nkDwts="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config first
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O4wX2nkDwts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/556?usp=3Demail )

Change subject: configure: Try to detect LZO with pkg-config first
......................................................................


Patch Set 2:

(1 comment)

File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/556/comment/269f68bb_0cc07361 :
PS2, Line 1148:     if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
Isn't this -z LZO_LIBS always true since it is under the -z LZO_LIBS check =
anyway?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 08 May 2024 13:49:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--O4wX2nkDwts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/556/comment/269f68bb_0cc07361">Patch Set #2, Line 1148:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if test -z &quot;${LZO_CFLAGS}=
&quot; -a -z &quot;${LZO_LIBS}&quot;; then</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Isn&#39;t this -z LZO_LIBS always true=
 since it is under the -z LZO_LIBS check anyway?</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3De=
mail">change 556</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 May 2024 13:49:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--O4wX2nkDwts=--

