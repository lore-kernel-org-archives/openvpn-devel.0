From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Jun 2024 16:58:21 +0000
In-Reply-To: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
References: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <79e7cc3c9a096e4388d7dcb86edd498285625601-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v/wvpwH8cjE="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Lay the foundation
 to support both old and new versions of DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v/wvpwH8cjE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/662?usp=3Demail )

Change subject: Lay the foundation to support both old and new versions of =
DCO
......................................................................


Patch Set 1: Code-Review-1

(4 comments)

Patchset:

PS1:
A few small nitpicks


File src/openvpn/dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/662/comment/23d9dd04_2e8af958 :
PS1, Line 129:  * @param nl_msg    the message to use
"The"


http://gerrit.openvpn.net/c/openvpn/+/662/comment/e8c66910_d887f4a2 :
PS1, Line 174:  * extended in the future if we need to lookup more than one=
 mcast id.
"can be extended" ?


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/662/comment/7b654a13_31b82c62 :
PS1, Line 1233:     int cmd_del_peer =3D OVPN_CMD_DEL_PEER;
Why is this indirection required?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672
Gerrit-Change-Number: 662
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Wed, 26 Jun 2024 16:58:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--v/wvpwH8cjE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/662?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">A few small nitpicks</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.h:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/662/comment/23d9dd04_2e8af958">Patch Set #1, Line 129:</a> <c=
ode style=3D"font-family:monospace,monospace"> * @param nl_msg    the messa=
ge to use</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">&quot;The&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/662/comment/e8c66910_d887f4a2">Patch Set #1, Line 174:</a> <code styl=
e=3D"font-family:monospace,monospace"> * extended in the future if we need =
to lookup more than one mcast id.</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">&quot;can be extended&quot; ?</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/662/comment/7b654a13_31b82c62">Patch Set #1, Line 1233:<=
/a> <code style=3D"font-family:monospace,monospace">    int cmd_del_peer =
=3D OVPN_CMD_DEL_PEER;</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Why is this indirection required?</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=
=3Demail">change 662</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6662605b60d4859949970cfe256=
c55cbcbd4a672 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 662 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Jun 2024 16:58:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--v/wvpwH8cjE=--

