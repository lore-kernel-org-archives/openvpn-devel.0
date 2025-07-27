From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 27 Jul 2025 12:19:36 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <f7ce4a57a76e0f9c079a3f8a769c7f32213d5ec3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5cGv7Y1ZEVk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5cGv7Y1ZEVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 21: Code-Review-1

(3 comments)

Patchset:

PS21:=20
I'm fine with most of the new version, but I'm still not really happy with =
`apply_push_options()`.  Sorry.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/f3fc7445_db3c4290 :
PS21, Line 5524:         {
please get rid of this extra `if()` level.  Both conditions are checked aga=
in inside, so this is not really adding anything but an indent level.


http://gerrit.openvpn.net/c/openvpn/+/808/comment/37cf1615_f21e2c77 :
PS21, Line 5532:                 || (options->pull_filter_list && !apply_pu=
ll_filter(options, &line[i])))
I find this very hard to understand, even if it's a bit more space-efficien=
t than having two `if()` clauses with their own error handling - but the la=
tter would make the whole flow easier to understand.

Maybe just leaving the `option->pull_filter_list` check inside `apply_pull_=
filter()`  (as it was) would already make this easier to read.  Yes, we'd w=
aste a function call per received push-option, but this is not a critical c=
ode path.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 21
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sun, 27 Jul 2025 12:19:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--5cGv7Y1ZEVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, stipa. </p>
<p>Patch set 21:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/808?tab=3Dcomments">Patch Set #21:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I&#39;m fine with most of the new version, =
but I&#39;m still not really happy with `apply_push_options()`.  Sorry.</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/opt=
ions.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/808/comment/f3fc7445_db3c4290">Patch Set #=
21, Line 5524:</a> <code style=3D"font-family:monospace,monospace">        =
{</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">plea=
se get rid of this extra `if()` level.  Both conditions are checked again i=
nside, so this is not really adding anything but an indent level.</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/37cf1615_f2=
1e2c77">Patch Set #21, Line 5532:</a> <code style=3D"font-family:monospace,=
monospace">                || (options-&gt;pull_filter_list &amp;&amp; !app=
ly_pull_filter(options, &amp;line[i])))</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I find this very hard to understand, even=
 if it&#39;s a bit more space-efficient than having two `if()` clauses with=
 their own error handling - but the latter would make the whole flow easier=
 to understand.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Maybe just leaving the `option-&gt;pull_filter_list` check inside `apply=
_pull_filter()`  (as it was) would already make this easier to read.  Yes, =
we&#39;d waste a function call per received push-option, but this is not a =
critical code path.</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 27 Jul 2025 12:19:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--5cGv7Y1ZEVk=--

