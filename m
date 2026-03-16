From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 17:26:23 +0000
In-Reply-To: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3fcc56e15951e8938b66a5b8b24ba7f2c4a0ce0f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CrueKBPBPuE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Cache built
 crypto libraries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CrueKBPBPuE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1577?usp=3Demail )

Change subject: GHA: Cache built crypto libraries
......................................................................


Patch Set 3: Code-Review-2

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1577/comment/0e48c15e_1dbdc41a?usp=3D=
email :
PS3, Line 9: Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Add Signed-off


File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/1577/comment/fb75cf9f_6a2d8101?usp=3D=
email :
PS3, Line 428:           path: /opt/
This does not seem to work. In my actions I see

```
/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /home/runner=
/work/openvpn/openvpn --files-from manifest.txt --use-compress-program zstd=
mt
/usr/bin/tar: ../../../../../opt/hca/diagnostics.json: Cannot open: Permiss=
ion denied
/usr/bin/tar: Exiting with failure status due to previous errors
Warning: Failed to save: "/usr/bin/tar" failed with error: The process '/us=
r/bin/tar' failed with exit code 2

```


http://gerrit.openvpn.net/c/openvpn/+/1577/comment/1784dc61_d405d972?usp=3D=
email :
PS3, Line 429:           key: ${{ matrix.os }}-mbedtls-${{ env.MBEDTLS_VERS=
ION }}
Do we need separate caches for the "normal" and the "asan" build?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Gerrit-Change-Number: 1577
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 16 Mar 2026 17:26:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--CrueKBPBPuE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1577/comment/0e48c15e_1dbdc41a?usp=3Demail">Patch Set #3, Line=
 9:</a> <code style=3D"font-family:monospace,monospace">Change-Id: Ie21fdb0=
1b843a7af09fcd469b08c775eee7e3745</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Add Signed-off</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yam=
l:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1577/comment/fb75cf9f_6a2d8101?usp=3Demail">Pat=
ch Set #3, Line 428:</a> <code style=3D"font-family:monospace,monospace">  =
        path: /opt/</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">This does not seem to work. In my actions I =
see</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">```<br>/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P =
-C /home/runner/work/openvpn/openvpn --files-from manifest.txt --use-compre=
ss-program zstdmt<br>/usr/bin/tar: ../../../../../opt/hca/diagnostics.json:=
 Cannot open: Permission denied<br>/usr/bin/tar: Exiting with failure statu=
s due to previous errors<br>Warning: Failed to save: &quot;/usr/bin/tar&quo=
t; failed with error: The process &#39;/usr/bin/tar&#39; failed with exit c=
ode 2</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">```</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1577/comment/1784dc61_d405d972?usp=3Demail">Patch Set #3, Line 429:</a> <co=
de style=3D"font-family:monospace,monospace">          key: ${{ matrix.os }=
}-mbedtls-${{ env.MBEDTLS_VERSION }}</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Do we need separate caches =
for the &quot;normal&quot; and the &quot;asan&quot; build?</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
577?usp=3Demail">change 1577</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08=
c775eee7e3745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1577 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Mar 2026 17:26:23=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--CrueKBPBPuE=--

