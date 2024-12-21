From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 22:40:34 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <61369fa05fa93b24f3dd1d45904280c08f044a5f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LkfcQgePlxo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LkfcQgePlxo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 4:

(5 comments)

File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/44d589a3_55773eae :
PS3, Line 232:         strncpynt(dns.domains + dstlen, o->domain_search_lis=
t[i], srclen);
> Hm, this doesn't appear to work. [=E2=80=A6]
Yeah, in this case it's better since remaining buffer is checked before to =
fit the terminating zero. strcpy would work as well, but usually raises an =
eyebrow with tools. So, adding the missing srclen + 1 for strncpy for the a=
ctual fix.


http://gerrit.openvpn.net/c/openvpn/+/824/comment/d469bffe_01c87c06 :
PS3, Line 1745:     /* Empty for _WIN32 and all other unixoid platforms */
> Spurious change that cause uncrustify errors
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/824/comment/64d0080e_818b319f :
PS3, Line 1771:     /* Empty for _WIN32 and all other unixoid platforms */
> Spurious change that causes uncrustify errors
Acknowledged


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/7cee0941_deaae7b2 :
PS3, Line 1333:         MsgToEventLog(M_ERR, L"InterfaceIdString: "
> Why `L""` here and not `TEXT()`?
TEXT() expands to L"" when UNICODE is defined, but will change for consiste=
ncy anyway. There's another one at #766, but unrelated to this changeset. W=
ill try to remember to ship a followup patch for this later.


http://gerrit.openvpn.net/c/openvpn/+/824/comment/da696840_4fc75d6d :
PS3, Line 2302:                     break;
> extra "break"
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sat, 21 Dec 2024 22:40:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--LkfcQgePlxo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/824/comment/44d589a3_55773eae">Patch Set #3, Line 232:</a> <c=
ode style=3D"font-family:monospace,monospace">        strncpynt(dns.domains=
 + dstlen, o-&gt;domain_search_list[i], srclen);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Hm, =
this doesn&#39;t appear to work. [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Yeah, in this case it&#39;s be=
tter since remaining buffer is checked before to fit the terminating zero. =
strcpy would work as well, but usually raises an eyebrow with tools. So, ad=
ding the missing srclen + 1 for strncpy for the actual fix.</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/d469bffe_01c87c06=
">Patch Set #3, Line 1745:</a> <code style=3D"font-family:monospace,monospa=
ce">    /* Empty for _WIN32 and all other unixoid platforms */</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Spurious change that cause uncrustify errors</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/64d0080e_=
818b319f">Patch Set #3, Line 1771:</a> <code style=3D"font-family:monospace=
,monospace">    /* Empty for _WIN32 and all other unixoid platforms */</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Spurious change that causes uncrustify errors</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledge=
d</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
nserv/interactive.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/7cee0941_deaae7b2=
">Patch Set #3, Line 1333:</a> <code style=3D"font-family:monospace,monospa=
ce">        MsgToEventLog(M_ERR, L&quot;InterfaceIdString: &quot;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Why `L&quot;&quot;` here and not `TEXT()`?</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">TEXT() expands to L=
&quot;&quot; when UNICODE is defined, but will change for consistency anywa=
y. There&#39;s another one at #766, but unrelated to this changeset. Will t=
ry to remember to ship a followup patch for this later.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/da696840_4fc75d6d">=
Patch Set #3, Line 2302:</a> <code style=3D"font-family:monospace,monospace=
">                    break;</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">extra &quot;break&quot;<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/824?usp=3Demail">change 824</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/824?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 21 Dec 2024 22:40:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LkfcQgePlxo=--

