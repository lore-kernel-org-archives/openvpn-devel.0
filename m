From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 27 Feb 2025 00:29:40 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8cf737aee3db4edbab77eaafdbfa86379037580d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y3+wjer7gj8="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--y3+wjer7gj8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 8:

(5 comments)

File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/e7242d2e_9ce75db6 :
PS7, Line 91:     [[ "$(readlink /etc/resolv.conf)" =3D~ systemd ]] || retu=
rn 1
> This fallback is nice, but I really would like to see some kind of messag=
e about it in the log.
Problem is that scripts can't log anything afaik.


File src/openvpn/dns.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/431ae915_d56a1d76 :
PS7, Line 545:     int res =3D openvpn_run_script(&argv, es, S_FATAL|S_EXIT=
CODE, "dns script");
> This actually lead to annoying problems in my testing. [=E2=80=A6]
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/65694cc7_b840e8a4 :
PS7, Line 911:     o->dns_options.script =3D DNS_UPDOWN_PATH;
> This does not work well as an unconditional default I think. [=E2=80=A6]
Built-in script now runs as built-in and should not be complained about any=
 longer.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/55e960a6_805f6e3f :
PS7, Line 8045:     else if (streq(p[0], "dns-script") && p[1])
> New script should be documented in `doc/man-sections/script-options. [=E2=
=80=A6]
Actually missed pushing the doc commit the whole time, thanks for pointing =
it out.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/c7497690_9e53e4ce :
PS7, Line 8052:         set_user_script(options, &options->dns_options.scri=
pt, p[1], p[0], false);
> Again, this does not behave nice at all. [=E2=80=A6]
Not sure if we need the possibility to disable --dns-script, as on Windows =
it is not possible either, but it is implemented now by --dns-script disabl=
e, with disable being a reserved "filename" for that purpose. Seemed reason=
able.

Also the built-in script requires script-security 1 now, 2 is only needed f=
or user defined scripts, works as intended this way.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 8
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 27 Feb 2025 00:29:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--y3+wjer7gj8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/systemd-dns=
-updown.sh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/838/comment/e7242d2e_9ce75db6">Patch S=
et #7, Line 91:</a> <code style=3D"font-family:monospace,monospace">    [[ =
&quot;$(readlink /etc/resolv.conf)&quot; =3D~ systemd ]] || return 1</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">This fallback is nice, but I really would like to see some =
kind of message about it in the log.</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Problem is that scripts can&#39;t log =
anything afaik.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/dns.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/431ae915_d56a1d=
76">Patch Set #7, Line 545:</a> <code style=3D"font-family:monospace,monosp=
ace">    int res =3D openvpn_run_script(&amp;argv, es, S_FATAL|S_EXITCODE, =
&quot;dns script&quot;);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">This actually lead to annoyi=
ng problems in my testing. [=E2=80=A6]</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/838/comment/65694cc7_b840e8a4">Patch Set #7, Line 911:</a> <co=
de style=3D"font-family:monospace,monospace">    o-&gt;dns_options.script =
=3D DNS_UPDOWN_PATH;</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This does not work well as an un=
conditional default I think. [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Built-in script now runs as built-=
in and should not be complained about any longer.</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/838/comment/55e960a6_805f6e3f">Patch Se=
t #7, Line 8045:</a> <code style=3D"font-family:monospace,monospace">    el=
se if (streq(p[0], &quot;dns-script&quot;) &amp;&amp; p[1])</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">New script should be documented in `doc/man-sections/script-options.=
 [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Actually missed pushing the doc commit the whole time, thanks =
for pointing it out.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/838/comment/c7497690_9e53e4ce">Patch Set #7, Line 8052:</a> <code st=
yle=3D"font-family:monospace,monospace">        set_user_script(options, &a=
mp;options-&gt;dns_options.script, p[1], p[0], false);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Again, this does not behave nice at all. [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure if we need =
the possibility to disable --dns-script, as on Windows it is not possible e=
ither, but it is implemented now by --dns-script disable, with disable bein=
g a reserved &quot;filename&quot; for that purpose. Seemed reasonable.</p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Also the built-in=
 script requires script-security 1 now, 2 is only needed for user defined s=
cripts, works as intended this way.</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change =
838</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Feb 2025 00:29:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--y3+wjer7gj8=--

