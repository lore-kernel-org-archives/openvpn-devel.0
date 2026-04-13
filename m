From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 Apr 2026 11:20:44 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <24b6c4f5c5226594d12690f68431dbef3860ea4b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vCvFUpKa2a4="; charset=UTF-8
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

--vCvFUpKa2a4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1625?usp=3Demail )

Change subject: Enable per-socket bind_dev via --local
......................................................................


Patch Set 1: Code-Review-1

(4 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/15733805_d4bc2521?usp=3D=
email :
PS1, Line 114:      local host|* [port] [protocol] [bind device]
Should also add a reference to `--bind-dev` somewhere in the documentation =
below. I realize we do not have corresponding references for `port` and `pr=
otocol` either, but maybe we can also fix that?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/d6b4199e_963ab8ae?usp=3D=
email :
PS1, Line 6010:             msg(M_WARN | M_ERRNO, "Note: bind_dev is ignore=
d on non-Linux systems");
No syscalls involved here, so M_ERRNO makes no sense


http://gerrit.openvpn.net/c/openvpn/+/1625/comment/b13fa4de_a8359f50?usp=3D=
email :
PS1, Line 6541: #if defined(TARGET_LINUX)
Why this random change?


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/90dda228_fbf9b24f?usp=3D=
email :
PS1, Line 1413:     /* bind_dev from local_list will trump on the global op=
tion. */
Remove "on", remove the trailing full stop



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Mon, 13 Apr 2026 11:20:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--vCvFUpKa2a4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-opt=
ions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1625/comment/15733805_d4bc2521?usp=3Dema=
il">Patch Set #1, Line 114:</a> <code style=3D"font-family:monospace,monosp=
ace">     local host|* [port] [protocol] [bind device]</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should =
also add a reference to `--bind-dev` somewhere in the documentation below. =
I realize we do not have corresponding references for `port` and `protocol`=
 either, but maybe we can also fix that?</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1625/comment/d6b4199e_963ab8ae?usp=3Demail">Patch Set #1, Line 6010:</a> =
<code style=3D"font-family:monospace,monospace">            msg(M_WARN | M_=
ERRNO, &quot;Note: bind_dev is ignored on non-Linux systems&quot;);</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">No syscalls involved here, so M_ERRNO makes no sense</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1625/comment/b13fa4de_a8359f50?=
usp=3Demail">Patch Set #1, Line 6541:</a> <code style=3D"font-family:monosp=
ace,monospace">#if defined(TARGET_LINUX)</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Why this random change?=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/socket.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1625/comment/90dda228_fbf9b24f?usp=3Dem=
ail">Patch Set #1, Line 1413:</a> <code style=3D"font-family:monospace,mono=
space">    /* bind_dev from local_list will trump on the global option. */<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Remove &quot;on&quot;, remove the trailing full stop</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1625?usp=3Demail">change 1625</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1625?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Apr 2026 11:20:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--vCvFUpKa2a4=--

