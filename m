From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 14:13:10 +0000
In-Reply-To: <gerrit.1704979923000.Ic19f859c3aca8b30aa51b12dcb906a6e7e735019@...2715...>
References: <gerrit.1704979923000.Ic19f859c3aca8b30aa51b12dcb906a6e7e735019@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <b22f234b37ba7b71a58cac2bf44a2e7d098b5ba4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZlhyJQixSb8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: CMakeLists.txt:
 Don't fail on missing compile_commands.json
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZlhyJQixSb8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/495?usp=3Demail )

Change subject: CMakeLists.txt: Don't fail on missing compile_commands.json
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/495/comment/ff72c046_d852df10 :
PS2, Line 7: CMakeLists.txt: Don't fail on missing compile_commands.json
Change to CMake: Don't fail if compile_commands.json symlink can't be creat=
ed.


http://gerrit.openvpn.net/c/openvpn/+/495/comment/78f9bf15_9a748563 :
PS2, Line 15: There a two issues:
I would suggest replacing this whole section with:

<--->
Creating symlinks on Windows by default requires an elevated prompt,
which is not normally the case (but it turned out is the case for GHA).
Without elevated prompt this fails the build.
Fix by make symlink creation non-fatal by providing variable
to store result.

Since CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefile genera=
tors and doesn't produce anything on MSVC,
the symlink is useless in this case anyway.
<---->

This makes it clearer what the actual issue is, but mentions
the other issue as justification.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic19f859c3aca8b30aa51b12dcb906a6e7e735019
Gerrit-Change-Number: 495
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 12 Jan 2024 14:13:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ZlhyJQixSb8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/495/comment/ff72c046_d852df10">Patch Set #2, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">CMakeLists.txt: Don&#39;t fail on m=
issing compile_commands.json</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Change to CMake: Don&#39;t fail if compile_commands.=
json symlink can&#39;t be created.</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/495/comment/78f9bf15_9a748563">Patch Set #2, Line 15:<=
/a> <code style=3D"font-family:monospace,monospace">There a two issues:</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I would s=
uggest replacing this whole section with:</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">&lt;---&gt;<br>Creating symlinks on Windows by=
 default requires an elevated prompt,<br>which is not normally the case (bu=
t it turned out is the case for GHA).<br>Without elevated prompt this fails=
 the build.<br>Fix by make symlink creation non-fatal by providing variable=
<br>to store result.</p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Since CMAKE_EXPORT_COMPILE_COMMANDS works only on Ninja and Makefil=
e generators and doesn&#39;t produce anything on MSVC,<br>the symlink is us=
eless in this case anyway.<br>&lt;----&gt;</p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This makes it clearer what the actual issue i=
s, but mentions<br>the other issue as justification.</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=
=3Demail">change 495</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/495?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic19f859c3aca8b30aa51b12dcb9=
06a6e7e735019 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 495 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Jan 2024 14:13:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZlhyJQixSb8=--

