From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 15:10:41 +0000
In-Reply-To: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
References: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <94253c21aedf6f121861a2af91d994fe98bbcfdb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QHVV6n8vlGI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove null check
 after checking for checking for did_open_tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QHVV6n8vlGI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/772?usp=3Demail )

Change subject: Remove null check after checking for checking for did_open_=
tun
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
Indeed, this patch makes sense - if it would be NULL, the check is too late=
, so in this place it does not add anything useful.

After staring at the code for quite some time I am reasonably convinced tha=
t c2.did_open_tun will only be set if `do_open_tun()` was called, which wil=
l either have a previously-set tuntap or will allocate a new one in `do_ini=
t_tun()`.

`do_close_tun()` seems to be the only code path that could set `tuntap =3D =
NULL` (and it does not clear `did_open_tun`), but it is only called in sequ=
ences where it's either reopened right away, or where the instance ends for=
 good.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9966636163c7dfa208d26f1cadbf5b81937f3a34
Gerrit-Change-Number: 772
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 15:10:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--QHVV6n8vlGI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/772?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/772?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Indeed, this patch makes sense - if it would b=
e NULL, the check is too late, so in this place it does not add anything us=
eful.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">After s=
taring at the code for quite some time I am reasonably convinced that c2.di=
d_open_tun will only be set if `do_open_tun()` was called, which will eithe=
r have a previously-set tuntap or will allocate a new one in `do_init_tun()=
`.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">`do_close_=
tun()` seems to be the only code path that could set `tuntap =3D NULL` (and=
 it does not clear `did_open_tun`), but it is only called in sequences wher=
e it&#39;s either reopened right away, or where the instance ends for good.=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/772?usp=3Demail">change 772</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
72?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9966636163c7dfa208d26f1cadb=
f5b81937f3a34 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 772 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 15:10:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QHVV6n8vlGI=--

