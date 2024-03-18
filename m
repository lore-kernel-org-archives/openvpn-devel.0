From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 18 Mar 2024 16:30:01 +0000
In-Reply-To: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
References: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1b288677817dd4b2204e977f61ffc13373b7e9f2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3jyMQS7DsA0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow the TLS
 session to send out TLS alerts
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

--3jyMQS7DsA0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/449?usp=3Demail )

Change subject: Allow the TLS session to send out TLS alerts
......................................................................


Patch Set 6: Code-Review+2

(2 comments)

Patchset:

PS6:
Looks good to me, but did not test it.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/46b395cc_6e433008 :
PS6, Line 3236:                 msg(D_TLS_ERRORS, "TLS Error: generate_key_=
expansion failed");
While here, can we fix the error message, please?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d
Gerrit-Change-Number: 449
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 18 Mar 2024 16:30:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--3jyMQS7DsA0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/449?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Looks good to me, but did not test it.</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/449/comment/46b395cc_6e433008">Patch Set #6, Line=
 3236:</a> <code style=3D"font-family:monospace,monospace">                =
msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansion failed&quot;);</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">While he=
re, can we fix the error message, please?</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail">c=
hange 449</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ad48915004ddee587e97c8ed19=
0ba8ee989e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 449 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Mar 2024 16:30:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--3jyMQS7DsA0=--

