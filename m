From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 16:52:39 +0000
In-Reply-To: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <24865ca60dfb00b5a3760bb8f86b4461355867a1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Djw7rMBx8A="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9Djw7rMBx8A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/481?usp=3Demail )

Change subject: Move get_tmp_dir to win32-util.c and error out on failure
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/481/comment/0aedaf28_cfeef61a :
PS1, Line 891:         /* Warn if we can't find a valid temporary directory=
, which should
> M_USAGE is not really "Warn"
Done


File src/openvpn/win32-util.h:

http://gerrit.openvpn.net/c/openvpn/+/481/comment/fc97a5eb_3cd9a134 :
PS1, Line 44: const char *win_get_tempdir(void);
> corresponding removal from win32. [=E2=80=A6]
yes. Fixed.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Gerrit-Change-Number: 481
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 02 Jan 2024 16:52:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--9Djw7rMBx8A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/481?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/481/comment/0aedaf28_cfeef61a">Patch Set #1, Line 891:</a=
> <code style=3D"font-family:monospace,monospace">        /* Warn if we can=
&#39;t find a valid temporary directory, which should</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>M_USAGE is not really &quot;Warn&quot;</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/win32-util.h:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/481/comment/fc97a5eb_3cd9a134">Patch Set #1, Line 44:</a> <code st=
yle=3D"font-family:monospace,monospace">const char *win_get_tempdir(void);<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">corresponding removal from win32. [=E2=80=A6]</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">yes. Fi=
xed.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/481?usp=3Demail">change 481</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/481?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525ccf7872880367b248ebebb0d=
dc83551498042 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 481 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 02 Jan 2024 16:52:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--9Djw7rMBx8A=--

