From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 10:15:00 +0000
In-Reply-To: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
References: <gerrit.1732634928000.I9a278374f492a538f0c174ced1746c3b1f82b8c9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <271c3cb95e61c601db84dae208bd152ed1477fd4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LimsrgF1TxI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Haiku: Introduce
 basic platform / tun support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kallisti5 <alex@...2837...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LimsrgF1TxI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, kallisti5, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/687?usp=3Demail )

Change subject: Haiku: Introduce basic platform / tun support
......................................................................


Patch Set 6: Code-Review+2

(2 comments)

Patchset:

PS6:
LGTM.  Tested via buildbots and GHA, and neither complain that we accidentl=
y broke something (well, uncrustify complains, but I'll fix that on the fly=
 as it's "just whitespace")


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/687/comment/2ba4bc97_2a2926cb :
PS4, Line 1637:         /* XXX: Need to add ifconfig_remote_netmask since r=
ight now it is just NULL */
> It's a common old-school FIXME comment. (something searchable that someth=
ing needs done) [=E2=80=A6]
I do understand XXX comments, I just do not want them in our code unless th=
ere really is something left to be fixed ;-) - so thanks for removing.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a278374f492a538f0c174ced1746c3b1f82b8c9
Gerrit-Change-Number: 687
Gerrit-PatchSet: 6
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: kallisti5 <alex@...2837...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 10:15:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: kallisti5 <alex@...2837...>
Gerrit-MessageType: comment

--LimsrgF1TxI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, kallisti5, plaistho=
s. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/687?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">LGTM.  Tested via buildbots and GHA, and neit=
her complain that we accidently broke something (well, uncrustify complains=
, but I&#39;ll fix that on the fly as it&#39;s &quot;just whitespace&quot;)=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/tun.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/687/comment/2ba4bc97_2a2926cb">Patch Set #=
4, Line 1637:</a> <code style=3D"font-family:monospace,monospace">        /=
* XXX: Need to add ifconfig_remote_netmask since right now it is just NULL =
*/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">It&#39;s a common old-school FIXME comment. (somet=
hing searchable that something needs done) [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">I do understand XXX =
comments, I just do not want them in our code unless there really is someth=
ing left to be fixed ;-) - so thanks for removing.</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=
=3Demail">change 687</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/687?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a278374f492a538f0c174ced17=
46c3b1f82b8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 687 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: kallisti5 &lt;alex@...2839...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 10:15:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: kallisti5 &lt;alex@...2840...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LimsrgF1TxI=--

