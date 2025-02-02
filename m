From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 2 Feb 2025 21:12:12 +0000
In-Reply-To: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
References: <gerrit.1727098847000.I705fd9bf9298a54560eca12e3797351f4af321a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <d486332984f8483159abb0d8baab3f8a8d00fbe2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ar7E87AcsDk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: if a local IPv6
 address is provided, socket must be v6-only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ar7E87AcsDk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/761?usp=3Demail )

Change subject: if a local IPv6 address is provided, socket must be v6-only
......................................................................


Patch Set 16: Code-Review-1

(1 comment)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/761/comment/78420fab_8b8d4fb4 :
PS1, Line 7: if
> The only thing that comes to my mind is that if we wanted to have a wildc=
ard ipv6 socket (i.e. [=E2=80=A6]
The more I think about this, the more I find that we should cover this by d=
ocumentation :-) - changing the default bind behaviour will break people's =
config on upgrading a server config with `local ::` or `proto udp6`, becaus=
e it will stop listening to IPv4.

So what we should do is to document that `* udp6` or `::`will default to `i=
pv4 + ipv6`, unless `bind ipv6only` is configured - and not try to solve th=
is in code, at least not for 2.7 when "just one socket" configs will be the=
 normal case on upgrading.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I705fd9bf9298a54560eca12e3797351f4af321a7
Gerrit-Change-Number: 761
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Sun, 02 Feb 2025 21:12:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--ar7E87AcsDk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 16:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/761?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/761/comment/78420fab_8b8d4fb4">Patch Set #1, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">if</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The only=
 thing that comes to my mind is that if we wanted to have a wildcard ipv6 s=
ocket (i.e. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">The more I think about this, the more I find that w=
e should cover this by documentation :-) - changing the default bind behavi=
our will break people&#39;s config on upgrading a server config with `local=
 ::` or `proto udp6`, because it will stop listening to IPv4.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">So what we should do is =
to document that `* udp6` or `::`will default to `ipv4 + ipv6`, unless `bin=
d ipv6only` is configured - and not try to solve this in code, at least not=
 for 2.7 when &quot;just one socket&quot; configs will be the normal case o=
n upgrading.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/761?usp=3Demail">change 761</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/761?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I705fd9bf9298a54560eca12e379=
7351f4af321a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 02 Feb 2025 21:12:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ar7E87AcsDk=--

