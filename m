From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 13 Apr 2026 15:20:05 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ea6c3dfbb384d0f30274a74564625d67e9a30bfd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S7wsWix0vz4="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S7wsWix0vz4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1625?usp=3Demail )

Change subject: Enable per-socket bind_dev via --local
......................................................................


Patch Set 2:

(4 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/deef9428_ebae9b5d?usp=3D=
email :
PS1, Line 114:      local host|* [port] [protocol] [bind device]
> Should also add a reference to `--bind-dev` somewhere in the documentatio=
n below. [=E2=80=A6]
I did it only for --bind-dev at the moment, if you're fine with that will d=
o the same way for --port and --proto in a different patch.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/63bf8009_24bcad5f?usp=3D=
email :
PS1, Line 6010:             msg(M_WARN | M_ERRNO, "Note: bind_dev is ignore=
d on non-Linux systems");
> No syscalls involved here, so M_ERRNO makes no sense
Done


http://gerrit.openvpn.net/c/openvpn/+/1625/comment/d7b038f0_ac763769?usp=3D=
email :
PS1, Line 6541: #if defined(TARGET_LINUX)
> Why this random change?
Just a leftover, initially this patch also aimed to enable bind-dev for fre=
ebsd, then I decided to do that in a different patch.


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/cf628b0d_3b3678c2?usp=3D=
email :
PS1, Line 1413:     /* bind_dev from local_list will trump on the global op=
tion. */
> Remove "on", remove the trailing full stop
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 13 Apr 2026 15:20:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--S7wsWix0vz4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">View =
Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options=
.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1625/comment/deef9428_ebae9b5d?usp=3Demail">=
Patch Set #1, Line 114:</a> <code style=3D"font-family:monospace,monospace"=
>     local host|* [port] [protocol] [bind device]</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sh=
ould also add a reference to `--bind-dev` somewhere in the documentation be=
low. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I did it only for --bind-dev at the momen=
t, if you&#39;re fine with that will do the same way for --port and --proto=
 in a different patch.</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625/comment/63b=
f8009_24bcad5f?usp=3Demail">Patch Set #1, Line 6010:</a> <code style=3D"fon=
t-family:monospace,monospace">            msg(M_WARN | M_ERRNO, &quot;Note:=
 bind_dev is ignored on non-Linux systems&quot;);</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">No =
syscalls involved here, so M_ERRNO makes no sense</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625/comment/d7b=
038f0_ac763769?usp=3Demail">Patch Set #1, Line 6541:</a> <code style=3D"fon=
t-family:monospace,monospace">#if defined(TARGET_LINUX)</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Why this random change?</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Just a leftover, initially this=
 patch also aimed to enable bind-dev for freebsd, then I decided to do that=
 in a different patch.</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625/comment/cf62=
8b0d_3b3678c2?usp=3Demail">Patch Set #1, Line 1413:</a> <code style=3D"font=
-family:monospace,monospace">    /* bind_dev from local_list will trump on =
the global option. */</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Remove &quot;on&quot;, remove t=
he trailing full stop</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail=
">change 1625</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Apr 2026 15:20:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--S7wsWix0vz4=--

