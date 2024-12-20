From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 21:07:33 +0000
In-Reply-To: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
References: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4d8d91769248409fc8a7b400accb1843f0f36789-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i3ec0KVFXq0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: service: add
 utf8to16 function that takes a size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i3ec0KVFXq0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/836?usp=3Demail )

Change subject: service: add utf8to16 function that takes a size
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1:
Breaks GHA MinGW builds for me :-(

https://github.com/cron2/openvpn/actions/runs/12438329894/job/34730024149

```
  /usr/bin/i686-w64-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/=
Debug/interactive.c.obj: in function `InterfaceLuid':
2474
  /home/runner/work/openvpn/openvpn/src/openvpnserv/interactive.c:554: unde=
fined reference to `utf8to16'
2475
  /usr/bin/i686-w64-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/=
Debug/interactive.c.obj: in function `SetDNSDomain':
2476
  /home/runner/work/openvpn/openvpn/src/openvpnserv/interactive.c:1242: und=
efined reference to `utf8to16'
2477
  /usr/bin/i686-w64-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/=
Debug/interactive.c.obj: in function `HandleDNSConfigMessage':
2478
  /home/runner/work/openvpn/openvpn/src/openvpnserv/interactive.c:1297: und=
efined reference to `utf8to16'
2479
  /usr/bin/i686-w64-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/=
Debug/interactive.c.obj: in function `HandleWINSConfigMessage':
2480
  /home/runner/work/openvpn/openvpn/src/openvpnserv/interactive.c:1394: und=
efined reference to `utf8to16'
```

so it seems the macro definition is not included "in the right places".  Do=
es this need another patch to be applied as prerequisite?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b4aa3d63c0b684bf95841271c04bc5d9c37793b
Gerrit-Change-Number: 836
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 20 Dec 2024 21:07:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--i3ec0KVFXq0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/836?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Breaks GHA MinGW builds for me :-(</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">https://github.com/cron2=
/openvpn/actions/runs/12438329894/job/34730024149</p><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">```<br>  /usr/bin/i686-w6=
4-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/Debug/interactive.=
c.obj: in function `InterfaceLuid&#39;:<br>2474<br>  /home/runner/work/open=
vpn/openvpn/src/openvpnserv/interactive.c:554: undefined reference to `utf8=
to16&#39;<br>2475<br>  /usr/bin/i686-w64-mingw32-ld: src/openvpnserv/CMakeF=
iles/openvpnserv.dir/Debug/interactive.c.obj: in function `SetDNSDomain&#39=
;:<br>2476<br>  /home/runner/work/openvpn/openvpn/src/openvpnserv/interacti=
ve.c:1242: undefined reference to `utf8to16&#39;<br>2477<br>  /usr/bin/i686=
-w64-mingw32-ld: src/openvpnserv/CMakeFiles/openvpnserv.dir/Debug/interacti=
ve.c.obj: in function `HandleDNSConfigMessage&#39;:<br>2478<br>  /home/runn=
er/work/openvpn/openvpn/src/openvpnserv/interactive.c:1297: undefined refer=
ence to `utf8to16&#39;<br>2479<br>  /usr/bin/i686-w64-mingw32-ld: src/openv=
pnserv/CMakeFiles/openvpnserv.dir/Debug/interactive.c.obj: in function `Han=
dleWINSConfigMessage&#39;:<br>2480<br>  /home/runner/work/openvpn/openvpn/s=
rc/openvpnserv/interactive.c:1394: undefined reference to `utf8to16&#39;<br=
>```</pre><p style=3D"white-space: pre-wrap; word-wrap: break-word;">so it =
seems the macro definition is not included &quot;in the right places&quot;.=
  Does this need another patch to be applied as prerequisite?</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/836?usp=3Demail">change 836</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b4aa3d63c0b684bf95841271c0=
4bc5d9c37793b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 836 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Dec 2024 21:07:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--i3ec0KVFXq0=--

