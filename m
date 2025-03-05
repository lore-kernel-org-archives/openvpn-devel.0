From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 5 Mar 2025 10:47:07 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c8d05098849968202226efef3cc569a9581ef225-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s9l1+24/L+4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s9l1+24/L+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 9: Code-Review-2

(8 comments)

Patchset:

PS9:
You broke it


File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/57d1206f_56136b77 :
PS7, Line 91:     [[ "$(readlink /etc/resolv.conf)" =3D~ systemd ]] || retu=
rn 1
> In that case, yeah. [=E2=80=A6]
Done


File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/4b946c0f_aa2c619b :
PS9, Line 75: "$
Maybe we could add a comment here like: "Add as a routing-only domain (~ pr=
efix) unless already configured as a search domain". Sure, this is document=
ed in systemd documentation, but unless you're intimately familiar with tha=
t this code just looks like gibberish.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/80d52a50_87e35eb1 :
PS9, Line 75: =3D~
This broken now. If this matches it does continue but it does not increase =
"i" so it is an endless loop.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/1795ad88_bac2fb33 :
PS9, Line 116:         [ -n "${!transport_var}" -a "${!transport_var}" =3D =
"DoH" ] || break
I think this line could use a comment like "skip DoH dns entries", otherwis=
e it takes a while to understand what this does.


File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/ebb56b30_2366159f :
PS9, Line 258:   environment values will be passed to ``--up`` and ``--down=
`` if no ``--dns``
This sentence is too complicated. After reading it I'm now more confused th=
an before how --dhcp-option and --dns interact.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/39eeba0b_9ae2c8e3 :
PS7, Line 8045:     else if (streq(p[0], "dns-script") && p[1])
> Actually missed pushing the doc commit the whole time, thanks for pointin=
g it out.
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/8ee3982a_93d7f782 :
PS9, Line 531:     "--dns-script cmd : Run cmd as user defined dns configur=
ation script\n"
Would change this to `--dns-script disable|cmd`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 9
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 05 Mar 2025 10:47:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--s9l1+24/L+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 9:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">Vi=
ew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/838?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">You broke it</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File distro/dns-scripts/systemd-dns-updown.sh:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/838/comment/57d1206f_56136b77">Patch Set #7, Line 91=
:</a> <code style=3D"font-family:monospace,monospace">    [[ &quot;$(readli=
nk /etc/resolv.conf)&quot; =3D~ systemd ]] || return 1</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">In that case, yeah. [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File distro/dns-scripts/systemd-dns-updown.sh:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/838/comment/4b946c0f_aa2c619b">Patch Set #9, Line 75:</a=
> <code style=3D"font-family:monospace,monospace">&quot;$</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe we could add a co=
mment here like: &quot;Add as a routing-only domain (~ prefix) unless alrea=
dy configured as a search domain&quot;. Sure, this is documented in systemd=
 documentation, but unless you&#39;re intimately familiar with that this co=
de just looks like gibberish.</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/838/comment/80d52a50_87e35eb1">Patch Set #9, Line 75:</a> <=
code style=3D"font-family:monospace,monospace">=3D~</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">This broken now. If this matc=
hes it does continue but it does not increase &quot;i&quot; so it is an end=
less loop.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
38/comment/1795ad88_bac2fb33">Patch Set #9, Line 116:</a> <code style=3D"fo=
nt-family:monospace,monospace">        [ -n &quot;${!transport_var}&quot; -=
a &quot;${!transport_var}&quot; =3D &quot;DoH&quot; ] || break</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I think this line =
could use a comment like &quot;skip DoH dns entries&quot;, otherwise it tak=
es a while to understand what this does.</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File doc/man-sections/script-options.rst:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/838/comment/ebb56b30_2366159f">Patch Set #9, Line 258:</a> =
<code style=3D"font-family:monospace,monospace">  environment values will b=
e passed to ``--up`` and ``--down`` if no ``--dns``</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">This sentence is too complica=
ted. After reading it I&#39;m now more confused than before how --dhcp-opti=
on and --dns interact.</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/39ee=
ba0b_9ae2c8e3">Patch Set #7, Line 8045:</a> <code style=3D"font-family:mono=
space,monospace">    else if (streq(p[0], &quot;dns-script&quot;) &amp;&amp=
; p[1])</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Actually missed pushing the doc commit the wh=
ole time, thanks for pointing it out.</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/838/comment/8ee3982a_93d7f782">Patch Set #9, Line 531:</a> <code style=
=3D"font-family:monospace,monospace">    &quot;--dns-script cmd : Run cmd a=
s user defined dns configuration script\n&quot;</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Would change this to `--dns-scrip=
t disable|cmd`</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Mar 2025 10:47:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--s9l1+24/L+4=--

