From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 13:51:28 +0000
In-Reply-To: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
References: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <39b8d74d50bfb6232c965848b3a8c597c5b346f2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L+2vwYZax9s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Deprecate --fast-io
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L+2vwYZax9s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1425?usp=3Demail )

Change subject: Deprecate --fast-io option
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

File doc/man-sections/unsupported-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1425/comment/e0878cd5_9c32f4ab?usp=3D=
email :
PS3, Line 53: --fast-io
The options are alphabetically sorted. Please put it in the right spot.


http://gerrit.openvpn.net/c/openvpn/+/1425/comment/d3d06463_5f63df3e?usp=3D=
email :
PS3, Line 54:   Ignored since OpenVPN 2.7. This option became broken with l=
atest changes
"latest" feels wrong in this context. How about "This option became broken =
due to changes to the event loop."?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1425/comment/4514d830_40647eb5?usp=3D=
email :
PS3, Line 6600:         msg(M_WARN, "DEPRECATED OPTION: --fast-io option ig=
nored. ");
Remove superfluous space at the end of the line.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Gerrit-Change-Number: 1425
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Tue, 09 Dec 2025 13:51:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--L+2vwYZax9s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/unsuppor=
ted-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1425/comment/e0878cd5_9c32f4ab?=
usp=3Demail">Patch Set #3, Line 53:</a> <code style=3D"font-family:monospac=
e,monospace">--fast-io</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">The options are alphabetically sorted. Pl=
ease put it in the right spot.</p></li><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1425/comment/d3d06463_5f63df3e?usp=3Demail">Patch Set #3, =
Line 54:</a> <code style=3D"font-family:monospace,monospace">  Ignored sinc=
e OpenVPN 2.7. This option became broken with latest changes</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&qu=
ot;latest&quot; feels wrong in this context. How about &quot;This option be=
came broken due to changes to the event loop.&quot;?</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1425/comment/4514d830_40647eb5?usp=3Demail">Patch Set #3, Lin=
e 6600:</a> <code style=3D"font-family:monospace,monospace">        msg(M_W=
ARN, &quot;DEPRECATED OPTION: --fast-io option ignored. &quot;);</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Remove superfluous space at the end of the line.</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=
=3Demail">change 1425</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1425?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c0a0b55ad56e704d4bd19f1fbc=
1c30c83fae14c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1425 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Dec 2025 13:51:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--L+2vwYZax9s=--

