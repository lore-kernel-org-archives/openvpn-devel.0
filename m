From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 30 Jul 2025 18:04:15 +0000
In-Reply-To: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
References: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <b170cd5c6289e85de7fa7aeb5ec94d09d0c75b1e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TO6lX3dNom8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix broken DHCP
 options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TO6lX3dNom8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1090?usp=3Demail )

Change subject: Fix broken DHCP options
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
This plays together with the code in tun.c that checks whether or not the T=
AP driver needs to be informed about DHCP options

```
    /* user-supplied DHCP options capability */
    if (tt->options.dhcp_options)
    {
..
            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OP=
T,
..
```

... so if we no longer flag these "it can be done with DHCP or not" options=
 as "well, if we have DHCP, we should set them!" (DHCP_OPTIONS_DHCP_OPTIONA=
L), and we have no "this can only be done with DHCP!" options (DHCP_OPTIONS=
_DHCP_REQUIRED), then tun.c just assumes "well, nothing required, nothing t=
o set up" and DNS will not work.

I experienced the issue myself with 2.7_alpha2 and a setup that ended up us=
ing TAP and DHCP, and the explanation makes sense.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b
Gerrit-Change-Number: 1090
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 30 Jul 2025 18:04:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--TO6lX3dNom8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1090?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">This plays together with the code in tun.c t=
hat checks whether or not the TAP driver needs to be informed about DHCP op=
tions</p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">```<br>    /* user-supplied DHCP options capability */<br>    if (tt-=
&gt;options.dhcp_options)<br>    {<br>..<br>            if (!DeviceIoContro=
l(tt-&gt;hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,<br>..<br>```</pre><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">... so if we no longer =
flag these &quot;it can be done with DHCP or not&quot; options as &quot;wel=
l, if we have DHCP, we should set them!&quot; (DHCP_OPTIONS_DHCP_OPTIONAL),=
 and we have no &quot;this can only be done with DHCP!&quot; options (DHCP_=
OPTIONS_DHCP_REQUIRED), then tun.c just assumes &quot;well, nothing require=
d, nothing to set up&quot; and DNS will not work.</p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I experienced the issue myself with 2.=
7_alpha2 and a setup that ended up using TAP and DHCP, and the explanation =
makes sense.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1090?usp=3Demail">change 1090</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1090?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d75efcceb826d06e74abd003d5=
377468ff9fe3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1090 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 30 Jul 2025 18:04:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--TO6lX3dNom8=--

