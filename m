From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 May 2025 09:27:21 +0000
In-Reply-To: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., gert@...1296...
Message-ID: <7746b5e111f4545d3372e1d3a098350b9f79d40e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yLO+O6eFAXQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Changes.rst: Collect, fix,
 and improve entries for 2.7 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yLO+O6eFAXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1032?usp=3Demail )

Change subject: Changes.rst: Collect, fix, and improve entries for 2.7 rele=
ase
......................................................................


Patch Set 1:

(3 comments)

Patchset:

PS1:
> went through "git log", found a few things that I found noteworthy. [=E2=
=80=A6]
Done


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/1032/comment/14ce78b6_78eda386 :
PS1, Line 42:
> cmake build support on Windows has indeed been added in 2. [=E2=80=A6]
--key and --cert have been mentioned below
automatic service is not actually part of this release since it is released=
 separately, isn't it?


http://gerrit.openvpn.net/c/openvpn/+/1032/comment/d00040c6_2fceb3cf :
PS1, Line 165: Overview of changes in 2.6
> - Windows build version is now logged and send to server in IV_PLAT_VER v=
ariable [=E2=80=A6]
What actually are the changes to --dns, though? All changes I could find we=
re also backported to 2.6?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Gerrit-Change-Number: 1032
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 27 May 2025 09:27:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--yLO+O6eFAXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1032?tab=3Dcomments">Patch Set #1:</a> </p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">went through &quot;=
git log&quot;, found a few things that I found noteworthy. [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1032/comment/14ce78b6_78eda386">Patch Set #1, Li=
ne 42:</a> <code style=3D"font-family:monospace,monospace"></code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">cmake build support on Windows has indeed been added in 2. [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">--key and --cert have been mentioned below<br>automatic service is not=
 actually part of this release since it is released separately, isn&#39;t i=
t?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032/commen=
t/d00040c6_2fceb3cf">Patch Set #1, Line 165:</a> <code style=3D"font-family=
:monospace,monospace">Overview of changes in 2.6</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">- Wi=
ndows build version is now logged and send to server in IV_PLAT_VER variabl=
e [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">What actually are the changes to --dns, though? All changes I=
 could find were also backported to 2.6?</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">c=
hange 1032</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea=
0c36362cccb91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1032 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 May 2025 09:27:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yLO+O6eFAXQ=--

