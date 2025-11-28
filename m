From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 16:03:13 +0000
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <efd05d436116bdcfd5b3a4b49fb5a97d60fb4917-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gw2JxnNA8DE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Drop Mbed TLS 2.X
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gw2JxnNA8DE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

flichtenheld has posted comments on this change by MaxF. ( http://gerrit.op=
envpn.net/c/openvpn/+/1412?usp=3Demail )

Change subject: Drop Mbed TLS 2.X compatibility
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS1:
> CMake doesn't check the version. [=E2=80=A6]
CMake should really use pkg-config for mbedTLS. Not sure why it doesn't. We=
 can handle that in a separate patch.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Gerrit-Change-Number: 1412
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Fri, 28 Nov 2025 16:03:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: MaxF <max@...2606...>

--Gw2JxnNA8DE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1412?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">CMak=
e doesn&#39;t check the version. [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">CMake should =
really use pkg-config for mbedTLS. Not sure why it doesn&#39;t. We can hand=
le that in a separate patch.</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">change 1412</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824=
d9c7c2d4d64ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1412 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Nov 2025 16:03:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>

</body></html>=

--Gw2JxnNA8DE=--

