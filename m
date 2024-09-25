From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 12:00:52 +0000
In-Reply-To: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
References: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eda0a619d3b6308c295b5c021593e5bed47ab400-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AQpFALqPoSI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: io_work: convert
 shift argument to uintptr_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AQpFALqPoSI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/759?usp=3Demail )

Change subject: io_work: convert shift argument to uintptr_t
......................................................................


Patch Set 1:

(3 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/759/comment/b8b190fc_6d65f800 :
PS1, Line 2054:     static uintptr_t socket_shift =3D 0;   /* depends on SO=
CKET_READ and SOCKET_WRITE */
> Why the replacement of the macros here?
I think this patch predates the introduction of those macros.
So this assignments need to be changed.


http://gerrit.openvpn.net/c/openvpn/+/759/comment/e513c4d7_f82f90ad :
PS1, Line 2171:
> Probably need to change here as well? This patch does not work, but the f=
ollowup patch does. [=E2=80=A6]
the & should not be there.


http://gerrit.openvpn.net/c/openvpn/+/759/comment/b177699b_21cb28af :
PS1, Line 2176: dco_shift
> Miss here as well?
the & should not be there



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6e71e8c2b78089
Gerrit-Change-Number: 759
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 12:00:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--AQpFALqPoSI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/759/comment/b8b190fc_6d65f800">Patch Set #1, Line 2054:</=
a> <code style=3D"font-family:monospace,monospace">    static uintptr_t soc=
ket_shift =3D 0;   /* depends on SOCKET_READ and SOCKET_WRITE */</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Why the replacement of the macros here?</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I think this patch pred=
ates the introduction of those macros.<br>So this assignments need to be ch=
anged.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/759/com=
ment/e513c4d7_f82f90ad">Patch Set #1, Line 2171:</a> <code style=3D"font-fa=
mily:monospace,monospace">  </code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Probably need to change =
here as well? This patch does not work, but the followup patch does. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">the &amp; should not be there.</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/759/comment/b177699b_21cb28af">Patch Set #1, Line =
2176:</a> <code style=3D"font-family:monospace,monospace">dco_shift</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Miss here as well?</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">the &amp; should not be there</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/759?usp=3Demail">change 759</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6=
e71e8c2b78089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 759 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 12:00:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--AQpFALqPoSI=--

