From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 28 Apr 2025 06:12:05 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e4b8bc5c7ca4d4359fa41167d88d99509cd9c734-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xUlmhsl7L8w="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xUlmhsl7L8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 21:

(3 comments)

Patchset:

PS21:
> So, tested Gentoo and Debian. [=E2=80=A6]
Okay, I think Debian Trixie had a little resolved rage-quit for a short tim=
e, but it seems to be back now. See: https://bugs.debian.org/cgi-bin/bugrep=
ort.cgi?bug=3D1098914

With that out of the way a final fallback to direct resolv.conf manipulatio=
n is the appropriate thing to do.


File distro/dns-scripts/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/62e0d181_77af43a2 :
PS21, Line 27:
> can we `chmod +x` this here?  Then it could be run from `t_client. [=E2=
=80=A6]
Done


File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/50dccc8f_5ae0d38a :
PS21, Line 194: do_resolved || do_resolvconf
> On a system that has neither systemd nor `/sbin/resolvconf`  (namely my g=
entoo system here), this wi [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 21
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 28 Apr 2025 06:12:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--xUlmhsl7L8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
838?tab=3Dcomments">Patch Set #21:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So, tested Gentoo an=
d Debian. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Okay, I think Debian Trixie had a little resolved rag=
e-quit for a short time, but it seems to be back now. See: https://bugs.deb=
ian.org/cgi-bin/bugreport.cgi?bug=3D1098914</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">With that out of the way a final fallback to=
 direct resolv.conf manipulation is the appropriate thing to do.</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/Mak=
efile.am:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/838/comment/62e0d181_77af43a2">Patch Set=
 #21, Line 27:</a> <code style=3D"font-family:monospace,monospace"></code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">can we `chmod +x` this here?  Then it could be run from `t_c=
lient. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File distro/dns-scripts/systemd-dns-updown.sh:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/838/comment/50dccc8f_5ae0d38a">Patch Set #21, Line 194:</a> <code style=
=3D"font-family:monospace,monospace">do_resolved || do_resolvconf</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">On a system that has neither systemd nor `/sbin/resolvconf`  (=
namely my gentoo system here), this wi [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?=
usp=3Demail">change 838</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Apr 2025 06:12:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xUlmhsl7L8w=--

