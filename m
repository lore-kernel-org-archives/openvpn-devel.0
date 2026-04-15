From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 15:41:47 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <8653032900102522943fde2795546c285bd8b462-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5e9Xb42goAY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable per-socket
 bind_dev via --local
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

--5e9Xb42goAY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1625?usp=3Demail )

Change subject: Enable per-socket bind_dev via --local
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/ae0af796_9da7928a?usp=3D=
email :
PS3, Line 121:   The optional arguments correspond to existing options: ``p=
ort`` to
Maybe better:

The optional arguments override defaults set by the following options:
* ``port`` overrides ``--lport``
* ``protocol`` overrides ``--proto``
* ``bind device`` overrides ``--bind-dev``

(To explicitly say that these options set defaults which we can then overri=
de)


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/182e6971_7f4b5f87?usp=3D=
email :
PS3, Line 11:   This option can also be used inside a ``--local`` statement
Maybe better:

The default defined by this option can be overridden on a per-socket basis =
by specifying a ``bind device`` argument to ``--local``.

The current text sounds like you can use ``--bind-dev`` in a different cont=
ext which is not correct.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Wed, 15 Apr 2026 15:41:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--5e9Xb42goAY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-opt=
ions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1625/comment/ae0af796_9da7928a?usp=3Dema=
il">Patch Set #3, Line 121:</a> <code style=3D"font-family:monospace,monosp=
ace">  The optional arguments correspond to existing options: ``port`` to</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Maybe better:</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">The optional arguments override defaults set by=
 the following options:</p><ul class=3D"blocks"><li>``port`` overrides ``--=
lport``</li><li>``protocol`` overrides ``--proto``</li><li>``bind device`` =
overrides ``--bind-dev``</li></ul><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">(To explicitly say that these options se=
t defaults which we can then override)</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File doc/man-sections/vpn-network-options.rst:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1625/comment/182e6971_7f4b5f87?usp=3Demail">Patch Set #3=
, Line 11:</a> <code style=3D"font-family:monospace,monospace">  This optio=
n can also be used inside a ``--local`` statement</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe better:<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">The default defined by this option can be overridden on a per-socket ba=
sis by specifying a ``bind device`` argument to ``--local``.</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The curren=
t text sounds like you can use ``--bind-dev`` in a different context which =
is not correct.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">change 1625</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1625?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Apr 2026 15:41:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--5e9Xb42goAY=--

