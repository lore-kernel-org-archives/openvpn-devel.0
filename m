From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 25 Apr 2025 11:39:02 +0000
In-Reply-To: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <559b0ce0243d1e96a5e245980e3562b85f49cbfa-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iC1vEeNCKes="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make dh none
 behaviour default if not specified and add dh auto
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

--iC1vEeNCKes=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/945?usp=3Demail )

Change subject: Make dh none behaviour default if not specified and add dh =
auto
......................................................................


Patch Set 2: Code-Review-1

(6 comments)

Patchset:

PS2:
Some more nitpicking


File doc/man-sections/tls-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/0875d49b_2e79eee5 :
PS1, Line 183:   Set ``file`` to :code:`auto` enables using builtin Diffie =
Hellman
> "Setting"
Done


http://gerrit.openvpn.net/c/openvpn/+/945/comment/24f9ab7c_0d7f8e5e :
PS1, Line 188:   use the public well-known parameter or using ``none``.
> "parameters"
Done


File doc/man-sections/tls-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/46dda9bc_dd7a8286 :
PS2, Line 179:   Note that this requires peers to be using an SSL library t=
hat supports
"to use" instead of "to be using". While not incorrect I think it sounds cl=
unky.


http://gerrit.openvpn.net/c/openvpn/+/945/comment/ff6311bb_0efb9609 :
PS2, Line 188:   use the public well-known parameters or using ``none``.
"use" versus "using". Maybe just remove the "using"?


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/945/comment/3cee585a_d672dc5f :
PS2, Line 538:         if (options->dh_file && !strcmp(options->dh_file, "a=
uto"))
Any reason not to use streq() here like in options.c?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
Gerrit-Change-Number: 945
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 25 Apr 2025 11:39:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--iC1vEeNCKes=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/945?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Some more nitpicking</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File doc/man-sections/tls-options.rst:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/945/comment/0875d49b_2e79eee5">Patch Set #1, Line 18=
3:</a> <code style=3D"font-family:monospace,monospace">  Set ``file`` to :c=
ode:`auto` enables using builtin Diffie Hellman</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot=
;Setting&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/945/comment/24f9ab7c_0d7f8e5e">Patch Set #1, Line 188:</a> <code styl=
e=3D"font-family:monospace,monospace">  use the public well-known parameter=
 or using ``none``.</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">&quot;parameters&quot;</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/=
tls-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/945/comment/46dda9bc_dd7a8286">=
Patch Set #2, Line 179:</a> <code style=3D"font-family:monospace,monospace"=
>  Note that this requires peers to be using an SSL library that supports</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;t=
o use&quot; instead of &quot;to be using&quot;. While not incorrect I think=
 it sounds clunky.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/945/comment/ff6311bb_0efb9609">Patch Set #2, Line 188:</a> <code style=
=3D"font-family:monospace,monospace">  use the public well-known parameters=
 or using ``none``.</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">&quot;use&quot; versus &quot;using&quot;. Maybe just remove t=
he &quot;using&quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945/comment/3cee585a_=
d672dc5f">Patch Set #2, Line 538:</a> <code style=3D"font-family:monospace,=
monospace">        if (options-&gt;dh_file &amp;&amp; !strcmp(options-&gt;d=
h_file, &quot;auto&quot;))</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Any reason not to use streq() here like in options.c?<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/945?usp=3Demail">change 945</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/94=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940f=
da9d900465289 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Apr 2025 11:39:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--iC1vEeNCKes=--

