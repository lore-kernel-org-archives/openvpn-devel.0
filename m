From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 20 Sep 2024 15:45:54 +0000
In-Reply-To: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
References: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6e1f3d00ca6c0a1c47119862644c75076fa8263c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PyjCtaT0Igc="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PyjCtaT0Igc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/746?usp=3Demail )

Change subject: Move cipher/data-ciphers warning to D_LOW (verb 4)
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS3:
So as discussed today, this only scratches the top of the itch... what we w=
ant

- make "--data-ciphers" accept something like "default plus AES-128-CBC", s=
o future changes in "default" (adding a new supercipher, or deprecating som=
ething) will have an effect, and not get negated by having `--data-ciphers =
AES-128-GCM:AES-128-CBC` stuck in config files (again)
- adjust the warning messages(2) to print the full syntax for the `--data-c=
ipher` command to be added



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 20 Sep 2024 15:45:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--PyjCtaT0Igc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/746?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
46?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">So as discussed today, this only scratches the top=
 of the itch... what we want</p><ul><li>make &quot;--data-ciphers&quot; acc=
ept something like &quot;default plus AES-128-CBC&quot;, so future changes =
in &quot;default&quot; (adding a new supercipher, or deprecating something)=
 will have an effect, and not get negated by having `--data-ciphers AES-128=
-GCM:AES-128-CBC` stuck in config files (again)</li><li>adjust the warning =
messages(2) to print the full syntax for the `--data-cipher` command to be =
added</li></ul></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/746?usp=3Demail">change 746</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/746?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Sep 2024 15:45:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--PyjCtaT0Igc=--

