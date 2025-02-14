From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 10:20:55 +0000
In-Reply-To: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
References: <gerrit.1739527719000.I02afe6817433ca21aae76671c35151ec6a066933@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <58c83d180b7b3b0188676da3b86f4bb8f75c2e40-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u14Ofs1Zwpo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 get_dafault_gateway(): Make sure the get_default_gateway() function n...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u14Ofs1Zwpo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/898?usp=3Demail )

Change subject: get_dafault_gateway(): Make sure the get_default_gateway() =
function never receives IPV4_INVALID_ADDR as a destination.
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:
Typo in `get_dafault...` in the commit message, and please add a few words =
why this is needed ("commit ... added using the remote VPN host address to =
query the default gateway which fails when connecting using IPv6")


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/898/comment/4d8cea43_70bff5a2 :
PS1, Line 5876:         get_default_gateway_ipv6(&rgi6, &remote_ipv6, &net_=
ctx);
this change is not needed.  get_ip_addr() will return `0` on everything tha=
t is not a valid IPv4 address (or can resolve to one).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02afe6817433ca21aae76671c35151ec6a066933
Gerrit-Change-Number: 898
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Fri, 14 Feb 2025 10:20:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--u14Ofs1Zwpo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/898?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Typo in `get_dafault...` in the commit messag=
e, and please add a few words why this is needed (&quot;commit ... added us=
ing the remote VPN host address to query the default gateway which fails wh=
en connecting using IPv6&quot;)</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/898/com=
ment/4d8cea43_70bff5a2">Patch Set #1, Line 5876:</a> <code style=3D"font-fa=
mily:monospace,monospace">        get_default_gateway_ipv6(&amp;rgi6, &amp;=
remote_ipv6, &amp;net_ctx);</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">this change is not needed.  get_ip_addr() will return=
 `0` on everything that is not a valid IPv4 address (or can resolve to one)=
.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/898?usp=3Demail">change 898</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
898?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I02afe6817433ca21aae76671c35=
151ec6a066933 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 898 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Feb 2025 10:20:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--u14Ofs1Zwpo=--

