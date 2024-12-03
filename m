From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 3 Dec 2024 13:48:12 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <20543d92afbd4416d1dc6c55967ec0fd946d56db-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/wf3Y3laoOA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/wf3Y3laoOA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 10: Code-Review-1

(4 comments)

Patchset:

PS10:
I've pointed out a few more places where you could use uint. Let me know if=
 this is excessive nitpicking.


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/56ca9914_0cae7c14 :
PS10, Line 355: int64_t
This could be uint


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/ca8aab0e_b7f91c98 :
PS10, Line 134: static int64_t
              : tls_get_limit_aead(const char *ciphername)
              : {
              :     int64_t limit =3D cipher_get_aead_limits(ciphername);
              :
              :     if (limit =3D=3D 0)
              :     {
              :         return 0;
              :     }
              :
              :     /* set limit to 7/8 of the limit so the renogiation can=
 succeed before
              :      * we go over the limit */
              :     limit =3D limit * 7/8;
              :
              :     msg(D_SHOW_KEYS, "Note: AEAD cipher %s will be limited =
to a sum of %"
              :         PRIi64 " for block and packets before renegotiation=
",
              :         ciphername, limit);
              :     return limit;
              : }
This function could return uint


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/166427ee_9749af9d :
PS10, Line 338:     int64_t aead_usage_limit;
This could be uint



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 03 Dec 2024 13:48:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--/wf3Y3laoOA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/796?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I&#39;ve pointed out a few more places wher=
e you could use uint. Let me know if this is excessive nitpicking.</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/796/comment/56ca9914_0cae7c14">Patch Set #10, Li=
ne 355:</a> <code style=3D"font-family:monospace,monospace">int64_t</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This could be=
 uint</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/796/comment/ca8aab0e_b7f91c98">Patch =
Set #10, Line 134:</a> </p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">static int64_t<br>tls_get_limit_aead(co=
nst char *ciphername)<br>{<br>    int64_t limit =3D cipher_get_aead_limits(=
ciphername);<br><br>    if (limit =3D=3D 0)<br>    {<br>        return 0;<b=
r>    }<br><br>    /* set limit to 7/8 of the limit so the renogiation can =
succeed before<br>     * we go over the limit */<br>    limit =3D limit * 7=
/8;<br><br>    msg(D_SHOW_KEYS, &quot;Note: AEAD cipher %s will be limited =
to a sum of %&quot;<br>        PRIi64 &quot; for block and packets before r=
enegotiation&quot;,<br>        ciphername, limit);<br>    return limit;<br>=
}<br></pre></blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">This function could return uint</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/796/comment/166427ee_9749af9d">Patch Set #10, Line 338:</a> <code s=
tyle=3D"font-family:monospace,monospace">    int64_t aead_usage_limit;</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This could=
 be uint</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Dec 2024 13:48:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/wf3Y3laoOA=--

