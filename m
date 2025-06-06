From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Jun 2025 12:54:08 +0000
In-Reply-To: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
References: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <ce6d44c62d24dbc49527106a97ed4fd569b151ba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QWU+1SKTjKM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: enable
 extended netlink error reporting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QWU+1SKTjKM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1040?usp=3Demail )

Change subject: dco_linux: enable extended netlink error reporting
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1:
This patch works and does what it says on the lid.  Alas, when we're starti=
ng to fix error message printing, we also need to fix it for good...

```
    if (tb_msg[NLMSGERR_ATTR_MSG])
    {
        len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
        msg(M_WARN, "kernel error: %*s\n", len,
            (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
    }
```

there is an extra `\n` which should not be there.  Please :-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3
Gerrit-Change-Number: 1040
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Fri, 06 Jun 2025 12:54:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--QWU+1SKTjKM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1040?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">This patch works and does what it says on th=
e lid.  Alas, when we&#39;re starting to fix error message printing, we als=
o need to fix it for good...</p><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">```<br>    if (tb_msg[NLMSGERR_ATTR_MSG])<br> =
   {<br>        len =3D strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG])=
,<br>                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));<br>        =
msg(M_WARN, &quot;kernel error: %*s\n&quot;, len,<br>            (char *)nl=
a_data(tb_msg[NLMSGERR_ATTR_MSG]));<br>    }<br>```</pre><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">there is an extra `\n` which shoul=
d not be there.  Please :-)</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1040?usp=3Demail">change 1040</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1040?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4457b1d7262e0a39c275d33aaef=
6c4bcbeae6ab3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1040 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Jun 2025 12:54:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QWU+1SKTjKM=--

