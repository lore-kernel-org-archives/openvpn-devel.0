From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 21 Mar 2025 14:09:47 +0000
In-Reply-To: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c41d64f6d96286583cdc2a851c94c4725913cef6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f0L1itly5Kw="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: win: implement
 --dns option support with NRPT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f0L1itly5Kw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/837?usp=3Demail )

Change subject: win: implement --dns option support with NRPT
......................................................................


Patch Set 14: -Code-Review

(3 comments)

Patchset:

PS14:
Is split-dns already supposed to work? In my server config I have


push "dns server 1 resolve-domains fi"
push "dns server 1 address 1.1.1.1"

push "dns server 2 resolve-domains io"
push "dns server 2 address 8.8.8.8"

so I would expect .fi go to 1.1.1.1 and .io to 8.8.8.8, but instead only on=
e registry entry .fi is created with 1.1.1.1.

Also, with that

push "dns server 1 resolve-domains fi"
push "dns server 1 address 1.1.1.1"

in addition to NRPT we set 1.1.1.1 on VPN adapter and many DNS requests not=
 directed to .fi domains also resolved via 1.1.1.1. This contradicts to wha=
t documentation says: "where only the given domains are resolved by the ser=
ver".


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/837/comment/8e6ebec0_a562e6ce :
PS14, Line 2259:         MsgToEventLog(M_SYSERR, TEXT("IsInterfaceConnected=
: "
At least on my machine I have 6 "real" network adapters (according to Get-N=
etAdapter | Format-List Name, InterfaceGuid) and 12 registry keys, apparent=
ly those are disabled/hidden etc. Because of that I got lots of scary
"IsInterfaceConnected: could not convert interface {F2D72071-CB76-4D6F-9DC8=
-EDAA3AC6B387} GUID to LUID" messages. Let's don't display this error messa=
ge - at least if ConvertInterfaceGuidToLuid returns ERROR_INVALID_PARAMETER.


http://gerrit.openvpn.net/c/openvpn/+/837/comment/427ad111_8562738a :
PS14, Line 2510:     for (int i =3D 0; i < _countof(data); ++i)
Does it really make sense to create keys for all adapters, even if there ar=
e no domains/servers defined?

Could we do it only if there are adapter-specific domains defined?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Gerrit-Change-Number: 837
Gerrit-PatchSet: 14
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 21 Mar 2025 14:09:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--f0L1itly5Kw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 14:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
837?tab=3Dcomments">Patch Set #14:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Is split-dns already supposed to work? In my ser=
ver config I have</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;"><br>push &quot;dns server 1 resolve-domains fi&quot;<br>push &quot;dns=
 server 1 address 1.1.1.1&quot;</p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">push &quot;dns server 2 resolve-domains io&quot;<br>push=
 &quot;dns server 2 address 8.8.8.8&quot;</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">so I would expect .fi go to 1.1.1.1 and .io to=
 8.8.8.8, but instead only one registry entry .fi is created with 1.1.1.1.<=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Also, with th=
at</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">push &quot=
;dns server 1 resolve-domains fi&quot;<br>push &quot;dns server 1 address 1=
.1.1.1&quot;</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
in addition to NRPT we set 1.1.1.1 on VPN adapter and many DNS requests not=
 directed to .fi domains also resolved via 1.1.1.1. This contradicts to wha=
t documentation says: &quot;where only the given domains are resolved by th=
e server&quot;.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpnserv/interactive.c:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837/comment/8e6=
ebec0_a562e6ce">Patch Set #14, Line 2259:</a> <code style=3D"font-family:mo=
nospace,monospace">        MsgToEventLog(M_SYSERR, TEXT(&quot;IsInterfaceCo=
nnected: &quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">At least on my machine I have 6 &quot;real&quot; network adapters=
 (according to Get-NetAdapter | Format-List Name, InterfaceGuid) and 12 reg=
istry keys, apparently those are disabled/hidden etc. Because of that I got=
 lots of scary <br>&quot;IsInterfaceConnected: could not convert interface =
{F2D72071-CB76-4D6F-9DC8-EDAA3AC6B387} GUID to LUID&quot; messages. Let&#39=
;s don&#39;t display this error message - at least if ConvertInterfaceGuidT=
oLuid returns ERROR_INVALID_PARAMETER.</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/837/comment/427ad111_8562738a">Patch Set #14, Line=
 2510:</a> <code style=3D"font-family:monospace,monospace">    for (int i =
=3D 0; i &lt; _countof(data); ++i)</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Does it really make sense to create keys for a=
ll adapters, even if there are no domains/servers defined? </p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Could we do it only if there=
 are adapter-specific domains defined?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">chan=
ge 837</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5=
adbebaaf209cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 21 Mar 2025 14:09:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--f0L1itly5Kw=--

