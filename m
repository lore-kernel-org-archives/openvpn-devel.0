From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Apr 2025 12:53:18 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bea7a9df5fa33a09fa6d12a8f9440928ff2b5b43-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T3xP3U9AYu4="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T3xP3U9AYu4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 21:

(1 comment)

Patchset:

PS21:
Working my way through it, first findings

```
2025-04-16 14:44:56 /usr/local/libexec/openvpn/dns-updown
2025-04-16 14:44:56 dns up command exited with status 127
```

so if trying to test this from a build environment, without it being instal=
led ever before, it will not work, with a non very helpful error message ("=
this file does not exist").

Then, trying to run from build directory

```
SU .. openvpn ... --dns-updown ../distro/dns-scripts/dns-updown
Options error: --dns-updown script fails with '../distro/dns-scripts/dns-up=
down': Permission denied (errno=3D13)
Options error: Please correct this error.
```

does not work because (as I feared) this is built with no x-bit

```
gert@...2718... ~/t_server.git/tests $ ls -l ../distro/dns-scripts/dns-updo=
wn
-rw-r--r-- 1 gert gert 5324 Apr 16 05:30 ../distro/dns-scripts/dns-updown
```

can we get this in place with an x bit?  (I could add a precondition to t_c=
lient.rc but this would really be modifying the build results on "make chec=
k" which is not something I want)



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
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 16 Apr 2025 12:53:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--T3xP3U9AYu4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
38?tab=3Dcomments">Patch Set #21:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Working my way through it, first findings</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-04-16 14=
:44:56 /usr/local/libexec/openvpn/dns-updown<br>2025-04-16 14:44:56 dns up =
command exited with status 127<br>```</p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">so if trying to test this from a build environment=
, without it being installed ever before, it will not work, with a non very=
 helpful error message (&quot;this file does not exist&quot;).</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Then, trying to run from=
 build directory</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">```<br>SU .. openvpn ... --dns-updown ../distro/dns-scripts/dns-updown<=
br>Options error: --dns-updown script fails with &#39;../distro/dns-scripts=
/dns-updown&#39;: Permission denied (errno=3D13)<br>Options error: Please c=
orrect this error.<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">does not work because (as I feared) this is built with no x-bi=
t</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>gert=
@...2718... ~/t_server.git/tests $ ls -l ../distro/dns-scripts/dns-updown<b=
r>-rw-r--r-- 1 gert gert 5324 Apr 16 05:30 ../distro/dns-scripts/dns-updown=
<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">can w=
e get this in place with an x bit?  (I could add a precondition to t_client=
.rc but this would really be modifying the build results on &quot;make chec=
k&quot; which is not something I want)</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">chan=
ge 838</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Apr 2025 12:53:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--T3xP3U9AYu4=--

