From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 11:54:17 +0000
In-Reply-To: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
References: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1046367b706e2ad51eb7376e3265538b196d3590-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bcg65xirREk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: pass link_socket
 object to i/o functions
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

--Bcg65xirREk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/758?usp=3Demail )

Change subject: pass link_socket object to i/o functions
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/758/comment/b7acdcf0_2ef7ae9c :
PS1, Line 928: read_incoming_link(struct context *c, struct link_socket *ls)
> Why not use "link_socket" as the variable name? No need to be cryptic. [=
=E2=80=A6]
Because calls from line 950 and below becomes messy due to line length =F0=
=9F=98=84
So "ls" seems a reasonable compromise.

socket.c:969:link_socket_update_flags() and
socket.c:983:link_socket_update_buffer_sizes()
also use "ls"

Otherwise all other functions call it "sock".

Any preference?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d
Gerrit-Change-Number: 758
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 11:54:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Bcg65xirREk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/758/comment/b7acdcf0_2ef7ae9c">Patch Set #1, Line 928:</a>=
 <code style=3D"font-family:monospace,monospace">read_incoming_link(struct =
context *c, struct link_socket *ls)</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why not use &quot=
;link_socket&quot; as the variable name? No need to be cryptic. [=E2=80=A6]=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Because calls from line 950 and below becomes messy due to line length =F0=
=9F=98=84<br>So &quot;ls&quot; seems a reasonable compromise.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">socket.c:969:link_socket=
_update_flags() and<br>socket.c:983:link_socket_update_buffer_sizes()<br>al=
so use &quot;ls&quot;</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Otherwise all other functions call it &quot;sock&quot;.</p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Any preference?</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/758?usp=3Demail">change 758</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/758?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe8=
0de8009d9b40d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 758 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 11:54:17=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Bcg65xirREk=--

