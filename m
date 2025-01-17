From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 Jan 2025 15:11:17 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <10ba2d701dc42196bb789c3f400871e39012a193-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GceHTI+sC5g="; charset=UTF-8
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

--GceHTI+sC5g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 7: Code-Review-2

(5 comments)

Patchset:

PS7:
We need to talk about the user experience.


File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/2ff31b19_51522721 :
PS7, Line 91:     [[ "$(readlink /etc/resolv.conf)" =3D~ systemd ]] || retu=
rn 1
This fallback is nice, but I really would like to see some kind of message =
about it in the log.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/dbe1ec14_c2270313 :
PS7, Line 911:     o->dns_options.script =3D DNS_UPDOWN_PATH;
This does not work well as an unconditional default I think. The problem he=
re is that if you call openvpn without `--script-security 2` it will error =
out. I think that should not happen as a default behavior.

A warning seems appropriate, but a complete failure seems overkill?


http://gerrit.openvpn.net/c/openvpn/+/838/comment/8fe2a8a7_b36878ef :
PS7, Line 8045:     else if (streq(p[0], "dns-script") && p[1])
New script should be documented in `doc/man-sections/script-options.rst`


http://gerrit.openvpn.net/c/openvpn/+/838/comment/6ad4fbec_6e2fe02e :
PS7, Line 8052:         set_user_script(options, &options->dns_options.scri=
pt, p[1], p[0], false);
Again, this does not behave nice at all. This warns that the script is over=
ridden even though it is only set once. And worse, there seems to be no way=
 to unset the script!

```
Options error: --dns-script script fails with '': No such file or directory=
 (errno=3D2)
```

I would change this so that the script is unset by default. IFF script-secu=
rity 2 is set AND the user did not set their own dns-script, then fall back=
 to the default. However, we also need a way for users to disable the dns-s=
cript, obviously.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 17 Jan 2025 15:11:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--GceHTI+sC5g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/838?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">We need to talk about the user experience.</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File distro/dns-scr=
ipts/systemd-dns-updown.sh:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/2ff31b19_5=
1522721">Patch Set #7, Line 91:</a> <code style=3D"font-family:monospace,mo=
nospace">    [[ &quot;$(readlink /etc/resolv.conf)&quot; =3D~ systemd ]] ||=
 return 1</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This fallback is nice, but I really would like to see some kind of mess=
age about it in the log.</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/db=
e1ec14_c2270313">Patch Set #7, Line 911:</a> <code style=3D"font-family:mon=
ospace,monospace">    o-&gt;dns_options.script =3D DNS_UPDOWN_PATH;</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This does not=
 work well as an unconditional default I think. The problem here is that if=
 you call openvpn without `--script-security 2` it will error out. I think =
that should not happen as a default behavior.</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">A warning seems appropriate, but a complet=
e failure seems overkill?</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/838/comment/8fe2a8a7_b36878ef">Patch Set #7, Line 8045:</a> <co=
de style=3D"font-family:monospace,monospace">    else if (streq(p[0], &quot=
;dns-script&quot;) &amp;&amp; p[1])</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">New script should be documented in `doc/man-s=
ections/script-options.rst`</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/838/comment/6ad4fbec_6e2fe02e">Patch Set #7, Line 8052:</a> <=
code style=3D"font-family:monospace,monospace">        set_user_script(opti=
ons, &amp;options-&gt;dns_options.script, p[1], p[0], false);</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Again, this does no=
t behave nice at all. This warns that the script is overridden even though =
it is only set once. And worse, there seems to be no way to unset the scrip=
t!</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>Opt=
ions error: --dns-script script fails with &#39;&#39;: No such file or dire=
ctory (errno=3D2)<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">I would change this so that the script is unset by default. IFF=
 script-security 2 is set AND the user did not set their own dns-script, th=
en fall back to the default. However, we also need a way for users to disab=
le the dns-script, obviously.</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Jan 2025 15:11:17=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GceHTI+sC5g=--

