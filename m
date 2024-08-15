From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 15 Aug 2024 12:36:37 +0000
In-Reply-To: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
References: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <fabf923d6d0d219a9e67f3746658d8238253db92-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kg8PNXI+fRI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: support for
 data_v3 features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Kg8PNXI+fRI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/725?usp=3Demail )

Change subject: dco-win: support for data_v3 features
......................................................................


Patch Set 2: Code-Review-1

(3 comments)

File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/725/comment/a79e147a_2242a84e :
PS2, Line 424: slot
Now that you changed the type of co_flags, change to %u here.


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/725/comment/e9388cee_92854160 :
PS2, Line 562: cipher
%u


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/725/comment/bc8d5955_1befe0c2 :
PS2, Line 340: cipher
%u



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2e0c50d33f8a57c023120cf348f95d34acbfcde5
Gerrit-Change-Number: 725
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 15 Aug 2024 12:36:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Kg8PNXI+fRI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/725/comment/a79e147a_2242a84e">Patch Set #2, Line=
 424:</a> <code style=3D"font-family:monospace,monospace">slot</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Now that you chang=
ed the type of co_flags, change to %u here.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/725/comment/e9388cee_92854160">Patch Set #2, Line 562:</a> <code sty=
le=3D"font-family:monospace,monospace">cipher</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">%u</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/725/comment/bc8d5955_1befe0c2">Patch Set #2, Line 340:</a> <code style=
=3D"font-family:monospace,monospace">cipher</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">%u</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail">ch=
ange 725</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/725?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2e0c50d33f8a57c023120cf348f=
95d34acbfcde5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 15 Aug 2024 12:36:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Kg8PNXI+fRI=--

