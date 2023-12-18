From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 18 Dec 2023 17:42:02 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a6b3c8ae3298f7d00864ae15a87a3a7e27cd73e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jgvdT1r6g08="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement the
 --tls-export-cert feature
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

--jgvdT1r6g08=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/466?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Implement the --tls-export-cert feature
......................................................................


Patch Set 6: Code-Review-2

(4 comments)

Patchset:

PS6:
Tested, does not crash, but only exports level 0 cert (level 1 variable is =
set, but no such file exists).


File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/bff18d9b_f279e622 :
PS6, Line 426: --tls-export-cert-path dir
the manpage calls the option "tls-export-cert-path", while options.c checks=
 for "tls-export-cert" (only, no "new option and also old option for compat=
 reasons") - this needs to be resolved (and keeping the old option name eve=
rywhere is better for not breaking people's configs - so the documentation =
needs to be fixed)


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/189e173c_161fa78f :
PS6, Line 3339:     to.export_peer_cert_dir =3D options->tls_export_peer_ce=
rt_path;
why call this "_dir" in the to, and "_path" in options-> ?


File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/97340248_881cd351 :
PS6, Line 734:     if (opt->export_peer_cert_dir)
Something is not right here.  So the function does set up multiple environm=
ent variables, but only one file is ever created...

I do a "ls -l $peer_cert_2 $peer_cert_1 $peer_cert0" in my tls-verify-scrip=
t, and this is what I see

peer_cert_1=3D/var/tmp/openvpn_pef_6a5f2055b342424a15139e5787303c57.tmp
peer_cert_0=3D/var/tmp/openvpn_pef_18e5d27eafdb9fb54c12a8c446b56c76.tmp
peer_cert=3D/var/tmp/openvpn_pef_18e5d27eafdb9fb54c12a8c446b56c76.tmp
-rw------- 1 root root 1830 Dec 18 18:39 /var/tmp/openvpn_pef_18e5d27eafdb9=
fb54c12a8c446b56c76.tmp

... only one file.

For "multiple files", I would have expected to find the filenames in an arr=
ay so they can all be deleted at the end (and no dangling files), but if on=
ly one file is ever created, no array is needed...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Gerrit-Change-Number: 466
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 18 Dec 2023 17:42:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--jgvdT1r6g08=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/466?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Tested, does not crash, but only exports leve=
l 0 cert (level 1 variable is set, but no such file exists).</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/466/comment/bff18d9b_f279e622">Patch Se=
t #6, Line 426:</a> <code style=3D"font-family:monospace,monospace">--tls-e=
xport-cert-path dir</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">the manpage calls the option &quot;tls-export-cert-path&quot;=
, while options.c checks for &quot;tls-export-cert&quot; (only, no &quot;ne=
w option and also old option for compat reasons&quot;) - this needs to be r=
esolved (and keeping the old option name everywhere is better for not break=
ing people&#39;s configs - so the documentation needs to be fixed)</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/466/comment/189e173c_161fa78f">Patch Set #6, Line =
3339:</a> <code style=3D"font-family:monospace,monospace">    to.export_pee=
r_cert_dir =3D options-&gt;tls_export_peer_cert_path;</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">why call this &quot;_dir&qu=
ot; in the to, and &quot;_path&quot; in options-&gt; ?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/466/comment/97340248_881cd351">Patch Set #6, Line 734:</=
a> <code style=3D"font-family:monospace,monospace">    if (opt-&gt;export_p=
eer_cert_dir)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Something is not right here.  So the function does set up multiple =
environment variables, but only one file is ever created...</p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I do a &quot;ls -l $peer_cer=
t_2 $peer_cert_1 $peer_cert0&quot; in my tls-verify-script, and this is wha=
t I see</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">peer_=
cert_1=3D/var/tmp/openvpn_pef_6a5f2055b342424a15139e5787303c57.tmp<br>peer_=
cert_0=3D/var/tmp/openvpn_pef_18e5d27eafdb9fb54c12a8c446b56c76.tmp<br>peer_=
cert=3D/var/tmp/openvpn_pef_18e5d27eafdb9fb54c12a8c446b56c76.tmp<br>-rw----=
--- 1 root root 1830 Dec 18 18:39 /var/tmp/openvpn_pef_18e5d27eafdb9fb54c12=
a8c446b56c76.tmp</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">... only one file.</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">For &quot;multiple files&quot;, I would have expected to find the=
 filenames in an array so they can all be deleted at the end (and no dangli=
ng files), but if only one file is ever created, no array is needed...</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/466?usp=3Demail">change 466</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Dec 2023 17:42:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jgvdT1r6g08=--

