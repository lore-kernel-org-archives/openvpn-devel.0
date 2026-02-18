From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 19:44:45 +0000
In-Reply-To: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <624621b386c643be64182151f5eb43eba16e467b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lxQZNI3vxYk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix setting DCO
 ifmode failing on big endian archs
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

--lxQZNI3vxYk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

ordex has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1547?usp=3Demail )

Change subject: Fix setting DCO ifmode failing on big endian archs
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1547/comment/aafb395a_49dc4aa8?usp=3D=
email :
PS1, Line 1342:          * other than uint8_t here causes the values to be =
0 when passed
maybe you can mention that the enum is probably wending up being a uint16 o=
r uint32? Because you are implying that, but this detail is actually the cr=
ux of the issue. In a few months from now we may not remember anymore.

What you are mentioning in this comment is just how endianess works (it can=
 stay if you like it)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Gerrit-Change-Number: 1547
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 18 Feb 2026 19:44:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--lxQZNI3vxYk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1547/comment/aafb395a_49dc4aa8?usp=3Demail">Patc=
h Set #1, Line 1342:</a> <code style=3D"font-family:monospace,monospace">  =
       * other than uint8_t here causes the values to be 0 when passed</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">maybe you can mention that the enum is probably wending up being a u=
int16 or uint32? Because you are implying that, but this detail is actually=
 the crux of the issue. In a few months from now we may not remember anymor=
e.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">What you are mentioning in this comment is just how endianess works =
(it can stay if you like it)</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">change 1547</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fb=
c63030fa10f35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Feb 2026 19:44:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--lxQZNI3vxYk=--

