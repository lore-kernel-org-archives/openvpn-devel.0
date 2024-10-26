From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 26 Oct 2024 09:16:15 +0000
In-Reply-To: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
References: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <44a847f3429a617addd56111e5526820ab7deb5a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QECv0oxJfSQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refuse clients if
 username or password is > USER_PASS_LEN
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

--QECv0oxJfSQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/787?usp=3Demail )

Change subject: Refuse clients if username or password is > USER_PASS_LEN
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1:
This is not working right for me.

I have a client, built with PKCS11 support, that sends a 230 byte username =
and a short passwort (11 characters).  On the server side (not built with P=
KCS11, verified by printing out USER_PASS_LEN at startup), this is using pl=
ugin-auth-pam, and it seems to happily pass things onward, in confusing ways

```
2024-10-26 11:10:24 USER_PASS_LEN=3D128
...
Oct 26 11:06:47 gentoo tun-udp-p2mp-global-authpam[1709]: 194.97.140.21:502=
80 TLS INFO: Username (128) or password (103)  long
Oct 26 11:06:47 gentoo tun-udp-p2mp-global-authpam[1709]: PLUGIN AUTH-PAM: =
deferred authentication
Oct 26 11:06:47 gentoo tun-udp-p2mp-global-authpam[1709]: 194.97.140.21:502=
80 TLS: Username/Password authentication deferred for username 'ThisUserNam=
eIsTooLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReally_Th=
isUserNameIsTooLongReally_ThisUserNameIsT'
```

so it's not overrunning the buffer, and not getting confused anymore, but i=
t *is* truncating the username to 128 bytes and using "the rest" for the pa=
ssword (103 =3D (230-128).  Turning on password logging in plugin-auth-pam =
confirms:

```
Oct 26 11:06:47 gentoo openvpn[1711]: PLUGIN AUTH-PAM: BACKGROUND: USER/PAS=
S: ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsTo=
oLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsT/ooLongReally_ThisUs=
erNameIsTooLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReal=
ly_230ch
```

(the password the client sends is `totallysecret`, and the client username =
ends in `_230ch`)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I60f02c919767eb8f1b95253689a8233f5f68621d
Gerrit-Change-Number: 787
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 26 Oct 2024 09:16:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--QECv0oxJfSQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/787?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">This is not working right for me.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I have a client, built w=
ith PKCS11 support, that sends a 230 byte username and a short passwort (11=
 characters).  On the server side (not built with PKCS11, verified by print=
ing out USER_PASS_LEN at startup), this is using plugin-auth-pam, and it se=
ems to happily pass things onward, in confusing ways</p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">```<br>2024-10-26 11:10:24 USER_PAS=
S_LEN=3D128<br>...<br>Oct 26 11:06:47 gentoo tun-udp-p2mp-global-authpam[17=
09]: 194.97.140.21:50280 TLS INFO: Username (128) or password (103)  long<b=
r>Oct 26 11:06:47 gentoo tun-udp-p2mp-global-authpam[1709]: PLUGIN AUTH-PAM=
: deferred authentication<br>Oct 26 11:06:47 gentoo tun-udp-p2mp-global-aut=
hpam[1709]: 194.97.140.21:50280 TLS: Username/Password authentication defer=
red for username &#39;ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReal=
ly_ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsT&=
#39; <br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
so it&#39;s not overrunning the buffer, and not getting confused anymore, b=
ut it *is* truncating the username to 128 bytes and using &quot;the rest&qu=
ot; for the password (103 =3D (230-128).  Turning on password logging in pl=
ugin-auth-pam confirms:</p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">```<br>Oct 26 11:06:47 gentoo openvpn[1711]: PLUGIN AUTH-PAM: BA=
CKGROUND: USER/PASS: ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReall=
y_ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsT/o=
oLongReally_ThisUserNameIsTooLongReally_ThisUserNameIsTooLongReally_ThisUse=
rNameIsTooLongReally_230ch<br>```</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">(the password the client sends is `totallysecret`, and=
 the client username ends in `_230ch`)</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">chan=
ge 787</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60f02c919767eb8f1b95253689a=
8233f5f68621d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 26 Oct 2024 09:16:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QECv0oxJfSQ=--

