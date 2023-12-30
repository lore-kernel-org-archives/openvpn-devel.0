From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 30 Dec 2023 16:00:04 +0000
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db3f46968c823b5520bbf5dd49f325ddacc7eff5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="umwBU3yoDmY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add test_ssl unit
 test and test export of PEM to file
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

--umwBU3yoDmY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/471?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Add test_ssl unit test and test export of PEM to file
......................................................................


Patch Set 3: Code-Review-2

(1 comment)

Patchset:

PS3:
this fails the GHA mingw builds with

```
  /home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/test_ssl.c: In=
 function =E2=80=98crypto_pem_encode_certificate=E2=80=99:
  Error: /home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/test_ss=
l.c:112:5: error: implicit declaration of function =E2=80=98backend_x509_wr=
ite_pem=E2=80=99 [-Werror=3Dimplicit-function-declaration]
    112 |     backend_x509_write_pem(cert, tmpfile);
        |     ^~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
```

(see https://github.com/cron2/openvpn/actions/runs/7365003797/job/200458928=
88) so it can't go in yet.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Gerrit-Change-Number: 471
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Sat, 30 Dec 2023 16:00:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--umwBU3yoDmY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/471?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">this fails the GHA mingw builds with</p><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>  =
/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/test_ssl.c: In f=
unction =E2=80=98crypto_pem_encode_certificate=E2=80=99:<br>  Error: /home/=
runner/work/openvpn/openvpn/tests/unit_tests/openvpn/test_ssl.c:112:5: erro=
r: implicit declaration of function =E2=80=98backend_x509_write_pem=E2=80=
=99 [-Werror=3Dimplicit-function-declaration]<br>    112 |     backend_x509=
_write_pem(cert, tmpfile);<br>        |     ^~~~~~~~~~~~~~~~~~~~~~<br>  cc1=
: all warnings being treated as errors<br>```</pre><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">(see https://github.com/cron2/openvpn/ac=
tions/runs/7365003797/job/20045892888) so it can&#39;t go in yet.</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/471?usp=3Demail">change 471</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c=
77ba0d6fa3381 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 471 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 30 Dec 2023 16:00:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--umwBU3yoDmY=--

