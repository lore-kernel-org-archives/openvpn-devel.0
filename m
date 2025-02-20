From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 08:06:41 +0000
In-Reply-To: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
References: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <85cbe0f92ddffb5bab741e09be48bb4dbe1bb736-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eArhaXy+bWg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: kernel
 notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eArhaXy+bWg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/816?usp=3Demail )

Change subject: dco-win: kernel notifications
......................................................................


Patch Set 20:

(3 comments)

File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/cf098fa0_497af99a :
PS20, Line 644: dco_handle_overlapped_success(dco_context_t *dco, bool queu=
ed)
> can you add a comment what this function does?  As a non-windows programm=
er I find `Overlapped` a fo [=E2=80=A6]
Will do.


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/835acd5c_18103b81 :
PS20, Line 409: #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || define=
d(TARGET_FREEBSD) || defined(TARGET_WIN32))
> this is a minor nitpick, but I find this line very long and hard to read =
now - can you wrap it? [=E2=80=A6]
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/816/comment/899c1243_9d323748 :
PS20, Line 3231: #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defin=
ed(TARGET_FREEBSD) || defined(TARGET_WIN32))
> same thing
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e
Gerrit-Change-Number: 816
Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 20 Feb 2025 08:06:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--eArhaXy+bWg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/816/comment/cf098fa0_497af99a">Patch Set #20, Line 644:</=
a> <code style=3D"font-family:monospace,monospace">dco_handle_overlapped_su=
ccess(dco_context_t *dco, bool queued)</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">can you add a =
comment what this function does?  As a non-windows programmer I find `Overl=
apped` a fo [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Will do.</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/mudp.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816/comme=
nt/835acd5c_18103b81">Patch Set #20, Line 409:</a> <code style=3D"font-fami=
ly:monospace,monospace">#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_=
LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">this is a minor nitpick, but I find this line very long and hard to =
read now - can you wrap it? [=E2=80=A6]</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/816/comment/899c1243_9d323748">Patch Set #20, Line 3231:</a> <code styl=
e=3D"font-family:monospace,monospace">#if defined(ENABLE_DCO) &amp;&amp; (d=
efined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">same thing</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">change=
 816</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a=
462b622ebbc6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 816 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Feb 2025 08:06:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eArhaXy+bWg=--

