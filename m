From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 10:07:53 +0000
In-Reply-To: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
References: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <272e12ac2bf2cfbe0330497731c1c6bc98c5247c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vnO7c++b3zc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Enable -Wconversion
 -Wno-sign-conversion by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vnO7c++b3zc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1168?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Enable -Wconversion -Wno-sign-conversion by default
......................................................................


Patch Set 13: Code-Review-2

(1 comment)

Patchset:

PS13:
This fails building GHA, I guess because something-pkcs11 is not yet guarded

https://github.com/cron2/openvpn/actions/runs/17972875656/job/51119449471

```
  CC       pkcs11_testdriver-mock_get_random.o
284
test_pkcs11.c: In function =E2=80=98test_pkcs11_ids=E2=80=99:
285
test_pkcs11.c:381:57: error: conversion from =E2=80=98size_t=E2=80=99 {aka =
=E2=80=98long unsigned int=E2=80=99} to =E2=80=98int=E2=80=99 may change va=
lue [-Werror=3Dconversion]
286
  381 |         int derlen =3D openvpn_base64_decode(base64, der, strlen(ba=
se64));
287
      |                                                         ^~~~~~~~~~~=
~~~
288
  CC       ../../../src/openvpn/pkcs11_testdriver-xkey_helper.o
289
  CC       ../../../src/openvpn/pkcs11_testdriver-xkey_provider.o``

```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59
Gerrit-Change-Number: 1168
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 24 Sep 2025 10:07:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--vnO7c++b3zc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p>The change is no longer submittable: Code-Review is unsatisfied now=
.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1168?tab=3Dcomments">Patch Set #13:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This fails building GHA, I guess because s=
omething-pkcs11 is not yet guarded</p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">https://github.com/cron2/openvpn/actions/runs/1797287=
5656/job/51119449471</p><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">```<br>  CC       pkcs11_testdriver-mock_get_random.o<=
br>284<br>test_pkcs11.c: In function =E2=80=98test_pkcs11_ids=E2=80=99:<br>=
285<br>test_pkcs11.c:381:57: error: conversion from =E2=80=98size_t=E2=80=
=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98int=E2=80=99 may =
change value [-Werror=3Dconversion]<br>286<br>  381 |         int derlen =
=3D openvpn_base64_decode(base64, der, strlen(base64));<br>287<br>      |  =
                                                       ^~~~~~~~~~~~~~<br>28=
8<br>  CC       ../../../src/openvpn/pkcs11_testdriver-xkey_helper.o<br>289=
<br>  CC       ../../../src/openvpn/pkcs11_testdriver-xkey_provider.o``</pr=
e><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1168?usp=3Demail">change 1168</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1168?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad5b00c35a1f1993b1fa99e8b94=
5ab17b230ef59 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1168 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Sep 2025 10:07:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--vnO7c++b3zc=--

