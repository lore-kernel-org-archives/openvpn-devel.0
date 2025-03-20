From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 20 Mar 2025 07:15:40 +0000
In-Reply-To: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
References: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <e031df9c1db425b08e70a50085f53b930964ce9f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dDVswBmije0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Define a
 .clang-format file for the project
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dDVswBmije0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/790?usp=3Demail )

Change subject: Define a .clang-format file for the project
......................................................................


Patch Set 9:

(1 comment)

File .clang-format:

http://gerrit.openvpn.net/c/openvpn/+/790/comment/da770a5b_173d2642 :
PS9, Line 25: ColumnLimit: '100'
How did we end up with 100?

Before we had something like a 80 soft and 120 hard limit. This would chang=
e that to a 100 hard if I understand that?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff
Gerrit-Change-Number: 790
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 20 Mar 2025 07:15:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--dDVswBmije0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File .clang-format:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/790/comment/da770a5b_173d2642">Patch Set #9, Line 25:</a> <code st=
yle=3D"font-family:monospace,monospace">ColumnLimit: &#39;100&#39;</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">How did we end=
 up with 100?</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Before we had something like a 80 soft and 120 hard limit. This would chan=
ge that to a 100 hard if I understand that?</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail"=
>change 790</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783f=
c622a2e3c19ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Mar 2025 07:15:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dDVswBmije0=--

