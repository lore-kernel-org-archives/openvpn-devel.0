From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 14:21:29 +0000
In-Reply-To: <gerrit.1727273213000.Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639@...2715...>
References: <gerrit.1727273213000.Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <86f468bd2e4d26b8d52e1046f0264902589c0e50-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fVRE1wZKUcA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix socketpair
 return status not being checked in port share code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fVRE1wZKUcA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/770?usp=3Demail )

Change subject: Fix socketpair return status not being checked in port shar=
e code
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

Patchset:

PS1:
Logic backwards, I think.


File src/openvpn/ps.c:

http://gerrit.openvpn.net/c/openvpn/+/770/comment/a89388f2_ba42e06c :
PS1, Line 237:             if (!socketpair(AF_UNIX, SOCK_DGRAM, 0, sd_null))
Shouldn't that test for -1?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67ee9dff6221639
Gerrit-Change-Number: 770
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 14:21:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--fVRE1wZKUcA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/770?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Logic backwards, I think.</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ps.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/770/comment/a89388f2_ba42e06c">Patch Set #1, Line 237:</a> <co=
de style=3D"font-family:monospace,monospace">            if (!socketpair(AF=
_UNIX, SOCK_DGRAM, 0, sd_null))</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Shouldn&#39;t that test for -1?</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/77=
0?usp=3Demail">change 770</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/770?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id99a3ba13c0f1d0bc7e4699fb67=
ee9dff6221639 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 770 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 14:21:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fVRE1wZKUcA=--

