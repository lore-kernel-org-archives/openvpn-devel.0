From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Mar 2025 09:21:48 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <0d8c81453d974e0ae9b4a2948ea0a5f0ff3e1eeb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HUu3ZacAOxc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HUu3ZacAOxc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 13: Code-Review+2

(3 comments)

Patchset:

PS13:
There's still a partly unresolved discussion and it needs to be tested what=
 happens with multiple concurrent VPNs modifying the global search list - b=
ut for all normal cases this should work fine.  I'm moving forward, and we =
can fix this particular corner case later if it turns out to be problematic.


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/3d28cfaf_6da650d8 :
PS12, Line 1631:         goto out;
> Yeah that is intentional. [=E2=80=A6]
With the adjusted comment ("doesn't reset anything") the code now matches t=
he comment, so fine with me :-)


http://gerrit.openvpn.net/c/openvpn/+/824/comment/3e617702_23668b59 :
PS12, Line 1698:         }
> When we get there something is inconsistent in the registry. [=E2=80=A6]
Indeed, we should never end in this state at all - though I do wonder what =
happens if there are overlapping VPNs modifying the global search list (bot=
h adding to it, and then the first existing and resetting the `InitialSearc=
hList`).  Guess we'll find out when the first issue gets openened :-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 13
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 12 Mar 2025 09:21:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--HUu3ZacAOxc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos, s=
tipa. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/824?tab=3Dcomments">Patch Set #13:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">There&#39;s still a partly unresolved discu=
ssion and it needs to be tested what happens with multiple concurrent VPNs =
modifying the global search list - but for all normal cases this should wor=
k fine.  I&#39;m moving forward, and we can fix this particular corner case=
 later if it turns out to be problematic.</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/824/comment/3d28cfaf_6da650d8">Patch Set #12, Line 1631:</a> <=
code style=3D"font-family:monospace,monospace">        goto out;</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Yeah that is intentional. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">With the adjusted commen=
t (&quot;doesn&#39;t reset anything&quot;) the code now matches the comment=
, so fine with me :-)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/824/comment/3e617702_23668b59">Patch Set #12, Line 1698:</a> <code =
style=3D"font-family:monospace,monospace">        }</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">W=
hen we get there something is inconsistent in the registry. [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ind=
eed, we should never end in this state at all - though I do wonder what hap=
pens if there are overlapping VPNs modifying the global search list (both a=
dding to it, and then the first existing and resetting the `InitialSearchLi=
st`).  Guess we&#39;ll find out when the first issue gets openened :-)</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/824?usp=3Demail">change 824</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 12 Mar 2025 09:21:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HUu3ZacAOxc=--

