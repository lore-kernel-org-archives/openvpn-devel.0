From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:25 +0000
References: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <978bf898f522619d2bba74c788709ee371c79ab9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7X56TQKHDXU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Fix
 memory leak when loading DLLs
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

--7X56TQKHDXU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1670?usp=3Demail

to review the following change.


Change subject: openvpnserv: Fix memory leak when loading DLLs
......................................................................

openvpnserv: Fix memory leak when loading DLLs

Identified by cppcheck.

Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 14 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1670/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ace25b9..e25c511 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1071,6 +1071,7 @@
     publish_fn_t RtlPublishWnfStateData;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2A;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;
+    BOOL ret =3D FALSE;

     HMODULE ntdll =3D LoadLibraryA("ntdll.dll");
     if (ntdll =3D=3D NULL)
@@ -1081,16 +1082,19 @@
     RtlPublishWnfStateData =3D (publish_fn_t)GetProcAddress(ntdll, "RtlPub=
lishWnfStateData");
     if (RtlPublishWnfStateData =3D=3D NULL)
     {
-        return FALSE;
+        goto cleanup;
     }

     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM=
_CHANGES_HI, 0, 0, 0, 0)
         !=3D ERROR_SUCCESS)
     {
-        return FALSE;
+        goto cleanup;
     }

-    return TRUE;
+    ret =3D TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return ret;
 }

 /**
@@ -1106,6 +1110,7 @@
                                      unsigned int Length, INT64 ExplicitSc=
ope);
     publish_fn_t RtlPublishWnfStateData;
     const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;
+    BOOL ret =3D FALSE;

     HMODULE ntdll =3D LoadLibraryA("ntdll.dll");
     if (ntdll =3D=3D NULL)
@@ -1116,15 +1121,18 @@
     RtlPublishWnfStateData =3D (publish_fn_t)GetProcAddress(ntdll, "RtlPub=
lishWnfStateData");
     if (RtlPublishWnfStateData =3D=3D NULL)
     {
-        return FALSE;
+        goto cleanup;
     }

     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D E=
RROR_SUCCESS)
     {
-        return FALSE;
+        goto cleanup;
     }

-    return TRUE;
+    ret =3D TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return ret;
 }

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1670?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Gerrit-Change-Number: 1670
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7X56TQKHDXU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1670?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Fix memory leak when loading D=
LLs<br><br>Identified by cppcheck.<br><br>Change-Id: Iad3f0c36ac3795fa6a13f=
2d63bd00ad9c2c30d48<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 14 inser=
tions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/70/1670/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>ind=
ex ace25b9..e25c511 100644</span><br><span>--- a/src/openvpnserv/interactiv=
e.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ =
-1071,6 +1071,7 @@</span><br><span>     publish_fn_t RtlPublishWnfStateData=
;</span><br><span>     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2=
A;</span><br><span>     const DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC08=
75;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D=
 FALSE;</span><br><span> </span><br><span>     HMODULE ntdll =3D LoadLibrar=
yA(&quot;ntdll.dll&quot;);</span><br><span>     if (ntdll =3D=3D NULL)</spa=
n><br><span>@@ -1081,16 +1082,19 @@</span><br><span>     RtlPublishWnfState=
Data =3D (publish_fn_t)GetProcAddress(ntdll, &quot;RtlPublishWnfStateData&q=
uot;);</span><br><span>     if (RtlPublishWnfStateData =3D=3D NULL)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto cleanup;</span><br><span>     }</span><br><span> </span><br><span>=
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM=
_CHANGES_HI, 0, 0, 0, 0)</span><br><span>         !=3D ERROR_SUCCESS)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto cleanup;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return TRUE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D TRUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cleanup:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    FreeLibrary(ntdll);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><sp=
an> </span><br><span> /**</span><br><span>@@ -1106,6 +1110,7 @@</span><br><=
span>                                      unsigned int Length, INT64 Expli=
citScope);</span><br><span>     publish_fn_t RtlPublishWnfStateData;</span>=
<br><span>     const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FAL=
SE;</span><br><span> </span><br><span>     HMODULE ntdll =3D LoadLibraryA(&=
quot;ntdll.dll&quot;);</span><br><span>     if (ntdll =3D=3D NULL)</span><b=
r><span>@@ -1116,15 +1121,18 @@</span><br><span>     RtlPublishWnfStateData=
 =3D (publish_fn_t)GetProcAddress(ntdll, &quot;RtlPublishWnfStateData&quot;=
);</span><br><span>     if (RtlPublishWnfStateData =3D=3D NULL)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto cleanup;</span><br><span>     }</span><br><span> </span><br><span>    =
 if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) !=3D ERROR=
_SUCCESS)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return TRUE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D TRUE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+cleanup:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    FreeLibrary(ntdll);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> =
}</span><br><span> </span><br><span> /**</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1670?usp=
=3Demail">change 1670</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1670?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd=
00ad9c2c30d48 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1670 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7X56TQKHDXU=--

