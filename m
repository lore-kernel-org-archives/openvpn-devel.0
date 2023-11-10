From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 13:54:56 +0000
In-Reply-To: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <7848a402b1856df9f6bafe1fb18ae87e579132ae-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J9tLZ0V4ae8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Make --dns
 options apply for tap-windows6 driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J9tLZ0V4ae8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/423?usp=3Demail )

Change subject: Make --dns options apply for tap-windows6 driver
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

Patchset:

PS1:
Looks slightly wrong to me.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/423/comment/e351d6ca_8df85345 :
PS1, Line 8018:             options->tuntap_options.dhcp_options |=3D DHCP_=
OPTIONS_DHCP_REQUIRED;
I would move this to tuntap_options_copy_dns() function. Also avoids the ad=
ditional #ifdefs. The #ifdefs seem to be wrong anyway, since all the others=
 are for _WIN32 || TARGET_ANDROID



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Gerrit-Change-Number: 423
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 10 Nov 2023 13:54:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--J9tLZ0V4ae8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos, stipa. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/423?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Looks slightly wrong to me.</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/423/comment/e351d6ca_8df85345">Patch Set #1, Line 8018:<=
/a> <code style=3D"font-family:monospace,monospace">            options-&gt=
;tuntap_options.dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">I would move this t=
o tuntap_options_copy_dns() function. Also avoids the additional #ifdefs. T=
he #ifdefs seem to be wrong anyway, since all the others are for _WIN32 || =
TARGET_ANDROID</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/423?usp=3Demail">change 423</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/423?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 423 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Nov 2023 13:54:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--J9tLZ0V4ae8=--

