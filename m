From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 12:24:34 +0000
In-Reply-To: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
References: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <c19f7d026e59125ad90d7da4e58da2b52a0c94f5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+atlYYbg02g="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Move
 cipher/data-ciphers warning to D_LOW (verb 4)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+atlYYbg02g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/746?usp=3Demail )

Change subject: Move cipher/data-ciphers warning to D_LOW (verb 4)
......................................................................


Patch Set 3: Code-Review-1

(1 comment)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/746/comment/30ce7242_48e36053 :
PS3, Line 3558:         msg(D_LOW, "DEPRECATED OPTION: --cipher set to '%s'=
 but missing in "
I do not agree with this part of the patch. Since this only happens if you =
have a --cipher in your config I think it is fine to keep this warning. I w=
ould only reduce the other one since that is basically a warning about the =
recommended config.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2797a82ad769cb640440d1ba7dfeb416e7b932d
Gerrit-Change-Number: 746
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 27 Dec 2024 12:24:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--+atlYYbg02g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/746/comment/30ce7242_48e36053">Patch Set #3, Line 3558=
:</a> <code style=3D"font-family:monospace,monospace">        msg(D_LOW, &q=
uot;DEPRECATED OPTION: --cipher set to &#39;%s&#39; but missing in &quot;</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I do no=
t agree with this part of the patch. Since this only happens if you have a =
--cipher in your config I think it is fine to keep this warning. I would on=
ly reduce the other one since that is basically a warning about the recomme=
nded config.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/746?usp=3Demail">change 746</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/746?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2797a82ad769cb640440d1ba7d=
feb416e7b932d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 746 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Dec 2024 12:24:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--+atlYYbg02g=--

