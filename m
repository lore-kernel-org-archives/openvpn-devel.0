From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 7 Dec 2023 18:23:03 +0000
In-Reply-To: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <ae003e4b96e91f7454fb176ed05b7d9a17ce4109-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kDitvAFMPR0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow specifying
 custom mbed TLS directories with CMake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, MaxF <max@...2606...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kDitvAFMPR0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/377?usp=3Demail )

Change subject: Allow specifying custom mbed TLS directories with CMake
......................................................................


Patch Set 5:

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/377/comment/6f04d272_ba7cbaef :
PS5, Line 11:
> Add a comment here that this also fixes existing issues with mbedTLS supp=
ort in CMake build.
Done


File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/377/comment/0e0af093_732576f5 :
PS5, Line 261:
> spurious whitespace
Done


File config.h.cmake.in:

http://gerrit.openvpn.net/c/openvpn/+/377/comment/ba7c404c_16e8f83c :
PS5, Line 389: /* we always assume a recent mbed TLS version */
> obsolete comment
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Gerrit-Change-Number: 377
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Thu, 07 Dec 2023 18:23:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--kDitvAFMPR0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/377/comment/6f04d272_ba7cbaef">Patch Set #5, Line 11:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Add a comment h=
ere that this also fixes existing issues with mbedTLS support in CMake buil=
d.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File CMak=
eLists.txt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/377/comment/0e0af093_732576f5">Patch S=
et #5, Line 261:</a> <code style=3D"font-family:monospace,monospace">      =
  </code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">spurious whitespace</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File config.h.cmake.in:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/377/comment/ba7c404c_16e8f83c">Patch Set #5, Line 389:</a> <code sty=
le=3D"font-family:monospace,monospace">/* we always assume a recent mbed TL=
S version */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">obsolete comment</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377=
?usp=3Demail">change 377</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c=
7c6734bd7374e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 07 Dec 2023 18:23:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--kDitvAFMPR0=--

