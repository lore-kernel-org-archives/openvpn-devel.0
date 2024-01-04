From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 4 Jan 2024 23:17:56 +0000
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <d1915e41bc48358f10d37a038cc9ff7fe000cae4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qSEgS3qbhZk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make it more
 explicit and visible when pkg-config is not found
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qSEgS3qbhZk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/465?usp=3Demail )

Change subject: Make it more explicit and visible when pkg-config is not fo=
und
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
Other than the two comments I added in the code, the patch does what it say=
s and it makes very straightforward understanding that pkg-config is now no=
t installed.
Tested a couple of cases on my lovely gentoo and it just worked.


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/465/comment/a58bb3dc_c4b892a1 :
PS3, Line 385: 	pkg_config_found=3D"(not found)"
am I wrong or there is some indentation havoc here? The line above uses 8bl=
anks tab, but the lines before have 4 spaces indentation?

I think we uses tabs everywhere else.


http://gerrit.openvpn.net/c/openvpn/+/465/comment/5512845f_c09de864 :
PS3, Line 387: 	pkg_config_found=3D"(using ${PKG_CONFIG})"
many error messages already contain 'using pkg-config', therefore the text =
above will lead to 'using using', which sounds weird.
How about changing 'using' with 'path:'?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Gerrit-Change-Number: 465
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 04 Jan 2024 23:17:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--qSEgS3qbhZk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/465?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Other than the two comments I added in the co=
de, the patch does what it says and it makes very straightforward understan=
ding that pkg-config is now not installed.<br>Tested a couple of cases on m=
y lovely gentoo and it just worked.</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File configure.ac:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465/comment/=
a58bb3dc_c4b892a1">Patch Set #3, Line 385:</a> <code style=3D"font-family:m=
onospace,monospace">	pkg_config_found=3D&quot;(not found)&quot;</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">am I wrong or the=
re is some indentation havoc here? The line above uses 8blanks tab, but the=
 lines before have 4 spaces indentation?</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I think we uses tabs everywhere else.</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465/comment/5512845f_c0=
9de864">Patch Set #3, Line 387:</a> <code style=3D"font-family:monospace,mo=
nospace">	pkg_config_found=3D&quot;(using ${PKG_CONFIG})&quot;</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">many error message=
s already contain &#39;using pkg-config&#39;, therefore the text above will=
 lead to &#39;using using&#39;, which sounds weird.<br>How about changing &=
#39;using&#39; with &#39;path:&#39;?</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail">change=
 465</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/465?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebaa35a23e217a4cd7739af229c=
bfc08a3d8854a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 465 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 04 Jan 2024 23:17:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qSEgS3qbhZk=--

