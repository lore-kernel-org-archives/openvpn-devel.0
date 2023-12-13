From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 13 Dec 2023 14:57:14 +0000
In-Reply-To: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2bfb0f1a7b269ca362d630b5c40e5f3cecea74dc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tHYtk9P0vh8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move get_tmp_dir to
 win32-util.c and error out on failure
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

--tHYtk9P0vh8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/481?usp=3Demail )

Change subject: Move get_tmp_dir to win32-util.c and error out on failure
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/481/comment/466d524c_f6e1e499 :
PS1, Line 891:         /* Warn if we can't find a valid temporary directory=
, which should
M_USAGE is not really "Warn"


File src/openvpn/win32-util.h:

http://gerrit.openvpn.net/c/openvpn/+/481/comment/14243ada_3a632f04 :
PS1, Line 44: const char *win_get_tempdir(void);
corresponding removal from win32.h is missing?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Gerrit-Change-Number: 481
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 13 Dec 2023 14:57:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--tHYtk9P0vh8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/481/comment/466d524c_f6e1e499">Patch Set #1, Line 891=
:</a> <code style=3D"font-family:monospace,monospace">        /* Warn if we=
 can&#39;t find a valid temporary directory, which should</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">M_USAGE is not really &=
quot;Warn&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/win32-util.h:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/481/comment/14243ada=
_3a632f04">Patch Set #1, Line 44:</a> <code style=3D"font-family:monospace,=
monospace">const char *win_get_tempdir(void);</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">corresponding removal from win32.h =
is missing?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/481?usp=3Demail">change 481</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/481?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525ccf7872880367b248ebebb0d=
dc83551498042 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 Dec 2023 14:57:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--tHYtk9P0vh8=--

