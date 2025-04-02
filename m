From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 10:52:56 +0000
References: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c7f68c2ac7404f83bf7fbf6119318503652b6a17-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VZwUR+67KKE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Make sure
 renovate notifies us about AWS LC releases
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

--VZwUR+67KKE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail

to review the following change.


Change subject: GHA: Make sure renovate notifies us about AWS LC releases
......................................................................

GHA: Make sure renovate notifies us about AWS LC releases

Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/932/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5e8e15d..2df495c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -469,6 +469,7 @@
         uses: actions/checkout@...2844... # v4.2.2
         with:
           path: aws-lc
+          # versioning=3Dsemver-coerced
           repository: aws/aws-lc
           ref: v1.42.0
       - uses: lukka/get-cmake@...2870... # v3.31.6

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40
Gerrit-Change-Number: 932
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--VZwUR+67KKE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Make sure renovate notifies us about AWS LC releases<br>=
<br>Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/bu=
ild.yaml<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/932/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span=
><br><span>index 5e8e15d..2df495c 100644</span><br><span>--- a/.github/work=
flows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><=
br><span>@@ -469,6 +469,7 @@</span><br><span>         uses: actions/checkou=
t@...2844... # v4.2.2</span><br><span>         with:</span><br><span>      =
     path: aws-lc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        # versioning=3Dsemver-coerced</span><br><span>           repository=
: aws/aws-lc</span><br><span>           ref: v1.42.0</span><br><span>      =
 - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/932?=
usp=3Demail">change 932</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3434c35da75ede90a1b479b1521=
42142ecc2fd40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 932 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--VZwUR+67KKE=--

