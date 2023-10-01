From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 1 Oct 2023 12:02:56 +0000
In-Reply-To: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
References: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <075578c79043b335f7f8f4a825af31b83dc8990b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1o0DiKjaOnk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change type of
 frame.mss_fix to uint16_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--1o0DiKjaOnk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/268?usp=3Demail )

Change subject: Change type of frame.mss_fix to uint16_t
......................................................................


Patch Set 3:

(2 comments)

File src/openvpn/mss.c:

http://gerrit.openvpn.net/c/openvpn/+/268/comment/94038c59_cb6b931f :
PS3, Line 195:                 mssval +=3D opt[3];
why is this change needed?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/268/comment/817b1791_91077f03 :
PS3, Line 7257:             if (mssfix > UINT16_MAX)
If we introduce a check here, we should also ensure a minimum value - we as=
sign `ce.mssfix-40` to `frame->mss_fix`, which is (now) unsigned, so the re=
sult will be something huge for values 1..39, and 0 for `--mssfix 40`.  For=
 IPv6, only values >=3D 60 make sense.

Now, the code in `mss_fixup_dowork()` won't adjust a given mss upwards, but=
 it's still kind of unexpected behaviour...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Gerrit-Change-Number: 268
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 01 Oct 2023 12:02:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--1o0DiKjaOnk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mss.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/268/comment/94038c59_cb6b931f">Patch Set #3, Line 195:</a> <c=
ode style=3D"font-family:monospace,monospace">                mssval +=3D o=
pt[3];</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>why is this change needed?</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/268/comment=
/817b1791_91077f03">Patch Set #3, Line 7257:</a> <code style=3D"font-family=
:monospace,monospace">            if (mssfix &gt; UINT16_MAX)</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">If we introduce a c=
heck here, we should also ensure a minimum value - we assign `ce.mssfix-40`=
 to `frame-&gt;mss_fix`, which is (now) unsigned, so the result will be som=
ething huge for values 1..39, and 0 for `--mssfix 40`.  For IPv6, only valu=
es &gt;=3D 60 make sense.</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Now, the code in `mss_fixup_dowork()` won&#39;t adjust a given=
 mss upwards, but it&#39;s still kind of unexpected behaviour...</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/268?usp=3Demail">change 268</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61=
f8cd6b6c6ee26 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 268 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Oct 2023 12:02:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--1o0DiKjaOnk=--

