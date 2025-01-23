From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 17:50:33 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <08a01ee976a4d8f375e2f60b6b6c43458979390b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="miY1kiFwxm8="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: multiproto: move
 generic event handling code in dedicated files
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

--miY1kiFwxm8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/763?usp=3Demail )

Change subject: multiproto: move generic event handling code in dedicated f=
iles
......................................................................


Patch Set 13:

(2 comments)

Patchset:

PS13:
close :-) (the code compiles and passes light tests, but there is a comment=
 that is more confusing than helpful)


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/763/comment/d62d69ef_43444458 :
PS13, Line 180:                                     *   transport. */
getting close... but this comment does not make sense.  What is it that is =
stored here?  Are there other protocols but UDP and TCP?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Gerrit-Change-Number: 763
Gerrit-PatchSet: 13
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 23 Jan 2025 17:50:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--miY1kiFwxm8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
763?tab=3Dcomments">Patch Set #13:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">close :-) (the code compiles and passes light te=
sts, but there is a comment that is more confusing than helpful)</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.h:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/763/comment/d62d69ef_43444458">Patch Set #13, Line =
180:</a> <code style=3D"font-family:monospace,monospace">                  =
                  *   transport. */</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">getting close... but this comment does not ma=
ke sense.  What is it that is stored here?  Are there other protocols but U=
DP and TCP?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/763?usp=3Demail">change 763</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/763?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e5a84969988e4f027a18658d4a=
b268c13fbf929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 23 Jan 2025 17:50:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--miY1kiFwxm8=--

