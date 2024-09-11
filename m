From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 13:07:48 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <49223bd183f634bdadd90e35877d6ee6c8b63dfe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sfhttdnhwr8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Support CIDR on
 options and extend netbits usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Sfhttdnhwr8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 2: Code-Review-2

(4 comments)

Patchset:

PS2:
Only started going through the code, so only a few comments. Without a docu=
mentation update I find it difficult to judge the changes. Please provide d=
ocumentation update.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/2909683e_d410ca3f :
PS2, Line 1516:     msg(D_SHOW_PARMS, "  server_network =3D %s/%d", print_i=
n_addr_t(o->server_network, 0, &gc), o->server_netbits);
%u


http://gerrit.openvpn.net/c/openvpn/+/739/comment/5e27a458_e0728f32 :
PS2, Line 1519:     msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s/%d", print=
_in_addr_t(o->server_bridge_ip, 0, &gc), o->server_bridge_netbits);
%u


http://gerrit.openvpn.net/c/openvpn/+/739/comment/f1263d0c_6227c36a :
PS2, Line 1535:     msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s/%d", pr=
int_in_addr_t(o->ifconfig_pool_start, 0, &gc), o->ifconfig_pool_netbits);
%u

giving netbits with _start doesn't seem to make sense.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Wed, 11 Sep 2024 13:07:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Sfhttdnhwr8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/739?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Only started going through the code, so only =
a few comments. Without a documentation update I find it difficult to judge=
 the changes. Please provide documentation update.</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/739/comment/2909683e_d410ca3f">Patch Set #2, Line 1516:</a> <c=
ode style=3D"font-family:monospace,monospace">    msg(D_SHOW_PARMS, &quot; =
 server_network =3D %s/%d&quot;, print_in_addr_t(o-&gt;server_network, 0, &=
amp;gc), o-&gt;server_netbits);</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">%u</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/739/comment/5e27a458_e0728f32">Patch Set #2, Line 1519:</a> =
<code style=3D"font-family:monospace,monospace">    msg(D_SHOW_PARMS, &quot=
;  server_bridge_ip =3D %s/%d&quot;, print_in_addr_t(o-&gt;server_bridge_ip=
, 0, &amp;gc), o-&gt;server_bridge_netbits);</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">%u</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/739/comment/f1263d0c_6227c36a">Patch Set #2, Li=
ne 1535:</a> <code style=3D"font-family:monospace,monospace">    msg(D_SHOW=
_PARMS, &quot;  ifconfig_pool_start =3D %s/%d&quot;, print_in_addr_t(o-&gt;=
ifconfig_pool_start, 0, &amp;gc), o-&gt;ifconfig_pool_netbits);</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">%u</p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">giving netbits with _start =
doesn&#39;t seem to make sense.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">change 739<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Sep 2024 13:07:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Sfhttdnhwr8=--

