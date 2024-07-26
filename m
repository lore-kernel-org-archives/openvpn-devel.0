From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 09:42:44 +0000
In-Reply-To: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
References: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <85401b502abec8758cb91fe6ee35b22985aac00d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lFdiuAaw3/0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 HAProxy's PROXY protocol
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lFdiuAaw3/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/685?usp=3Demail )

Change subject: Add support for HAProxy's PROXY protocol
......................................................................


Patch Set 1: Code-Review-1

(3 comments)

Patchset:

PS1:
Only looked through it superficially. Aside from the comments it would be g=
ood if we could have some kind of unit-test for the parsing code.


File src/openvpn/proxy_protocol.h:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/364aa307_26397b78 :
PS1, Line 8:  *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
Wrong copyright


File src/openvpn/proxy_protocol.c:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/f678bd92_399015cd :
PS1, Line 8:  *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
Wrong copyright



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Gerrit-Change-Number: 685
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 26 Jul 2024 09:42:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--lFdiuAaw3/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/685?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Only looked through it superficially. Aside f=
rom the comments it would be good if we could have some kind of unit-test f=
or the parsing code.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/proxy_protocol.h:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment=
/364aa307_26397b78">Patch Set #1, Line 8:</a> <code style=3D"font-family:mo=
nospace,monospace"> *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...2146...=
...&gt;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Wrong copyright</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/proxy_protocol.c:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/f6=
78bd92_399015cd">Patch Set #1, Line 8:</a> <code style=3D"font-family:monos=
pace,monospace"> *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...=
&gt;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">W=
rong copyright</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/685?usp=3Demail">change 685</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/685?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9766c68feaba71279f26c3310ee=
e4b5ca215e6ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 685 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 26 Jul 2024 09:42:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--lFdiuAaw3/0=--

