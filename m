From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 18 Mar 2025 13:45:16 +0000
References: <gerrit.1742305513000.If15862fe537496ac836fc443936ff8e7876a39c0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8b317413606dbdbb45a935975877a55d8fe4e51a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a2nIdUm8wxE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Clean
 up use of TEXT() from DNS patches
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

--a2nIdUm8wxE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/910?usp=3Demail

to review the following change.


Change subject: openvpnserv: Clean up use of TEXT() from DNS patches
......................................................................

openvpnserv: Clean up use of TEXT() from DNS patches

These are slightly different and so not covered
by my automatic conversion script. Use __func__
to make the actual string slightly shorter.

Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 37 insertions(+), 47 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/910/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index bc53f04..5812824 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1194,30 +1194,30 @@

     if (apply_gpol && ApplyGpolSettings() =3D=3D FALSE)
     {
-        MsgToEventLog(M_ERR, L"ApplyDnsSettings: sending GPOL notification=
 failed");
+        MsgToEventLog(M_ERR, L"%s: sending GPOL notification failed", __fu=
nc__);
     }

     scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (scm =3D=3D NULL)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "OpenSCManager call failed (%lu)"), GetL=
astError());
+        MsgToEventLog(M_ERR, L"%s: OpenSCManager call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }

     dnssvc =3D OpenServiceA(scm, "Dnscache", SERVICE_PAUSE_CONTINUE);
     if (dnssvc =3D=3D NULL)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "OpenService call failed (%lu)"), GetLas=
tError());
+        MsgToEventLog(M_ERR, L"%s: OpenService call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }

     SERVICE_STATUS status;
     if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) =3D=
=3D 0)
     {
-        MsgToEventLog(M_ERR, TEXT("ApplyDnsSettings: "
-                                  "ControlService call failed (%lu)"), Get=
LastError());
+        MsgToEventLog(M_ERR, L"%s: ControlService call failed (%lu)",
+                      __func__, GetLastError());
         goto out;
     }

@@ -1255,22 +1255,19 @@
     err =3D InterfaceLuid(itf_name, &luid);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "failed to convert itf alias '%s'"), itf=
_name);
+        MsgToEventLog(M_ERR, L"%s: failed to convert itf alias '%s'", __fu=
nc__, itf_name);
         goto out;
     }
     err =3D ConvertInterfaceLuidToGuid(&luid, &guid);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "Failed to convert itf '%s' LUID"), itf_=
name);
+        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' LUID", __fun=
c__, itf_name);
         goto out;
     }

     if (StringFromIID(&guid, &iid_str) !=3D S_OK)
     {
-        MsgToEventLog(M_ERR, TEXT("InterfaceIdString: "
-                                  "Failed to convert itf '%s' IID"), itf_n=
ame);
+        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' IID", __func=
__, itf_name);
         err =3D ERROR_OUTOFMEMORY;
         goto out;
     }
@@ -1420,8 +1417,7 @@
         {
             return FALSE;
         }
-        MsgToEventLog(M_ERR, TEXT("InitialSearchListExists: "
-                                  "failed to get InitialSearchList (%lu)")=
, err);
+        MsgToEventLog(M_ERR, L"InitialSearchListExists: failed to get Init=
ialSearchList (%lu)", err);
     }

     return TRUE;
@@ -1456,8 +1452,8 @@
     LSTATUS err =3D RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (=
PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_ERR, TEXT("StoreInitialDnsSearchList: "
-                                  "failed to set InitialSearchList value (=
%lu)"), err);
+        MsgToEventLog(M_ERR, L"%s: failed to set InitialSearchList value (=
%lu)",
+                      __func__, err);
         return FALSE;
     }

@@ -1485,8 +1481,8 @@
         err =3D RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL=
, list, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                         "could not get SearchList from re=
gistry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from re=
gistry (%lu)",
+                          __func__, err);
             return FALSE;
         }

@@ -1499,9 +1495,8 @@
         size_t domlen =3D wcslen(domains);
         if (listlen + domlen + 2 > _countof(list))
         {
-            MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                         "not enough space in list for sea=
rch domains (len=3D%lu)"),
-                          domlen);
+            MsgToEventLog(M_SYSERR, L"%s: not enough space in list for sea=
rch domains (len=3D%lu)",
+                          __func__, domlen);
             return FALSE;
         }

@@ -1519,8 +1514,8 @@
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("AddDnsSearchDomains: "
-                                     "could not set SearchList to registry=
 (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList to registry=
 (%lu)",
+                      __func__, err);
         return FALSE;
     }

@@ -1551,8 +1546,8 @@
     {
         if (err !=3D ERROR_FILE_NOT_FOUND)
         {
-            MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
-                                         "could not get InitialSearchList =
from registry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList =
from registry (%lu)",
+                          __func__, err);
         }
         goto out;
     }
@@ -1561,8 +1556,8 @@
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("ResetDnsSearchDomains: "
-                                     "could not set SearchList in registry=
 (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry=
 (%lu)",
+                      __func__, err);
         goto out;
     }

@@ -1589,16 +1584,15 @@
     err =3D RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, li=
st, &size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                     "could not get SearchList from regist=
ry (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from regist=
ry (%lu)",
+                      __func__, err);
         return;
     }

     PWSTR dst =3D wcsstr(list, domains);
     if (!dst)
     {
-        MsgToEventLog(M_ERR, TEXT("RemoveDnsSearchDomains: "
-                                  "could not find domains in search list")=
);
+        MsgToEventLog(M_ERR, L"%s: could not find domains in search list",=
 __func__);
         return;
     }

@@ -1618,8 +1612,8 @@
         err =3D RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_S=
Z, NULL, initial, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                         "could not get InitialSearchList =
from registry (%lu)"), err);
+            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList =
from registry (%lu)",
+                          __func__, err);
             return;
         }

@@ -1635,8 +1629,8 @@
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("RemoveDnsSearchDomains: "
-                                     "could not set SearchList in registry=
 (%lu)"), err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry=
 (%lu)",
+                      __func__, err);
     }
 }

@@ -1692,8 +1686,7 @@
     BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol, &list_key);
     if (list_key =3D=3D INVALID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetDnsSearchDomains: "
-                                     "could not get search list registry k=
ey"));
+        MsgToEventLog(M_SYSERR, L"%s: could not get search list registry k=
ey", __func__);
         return ERROR_FILE_NOT_FOUND;
     }

@@ -1762,9 +1755,8 @@
     if (err)
     {
         *key =3D INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR, TEXT("GetInterfacesKey: "
-                                     "could not open interfaces registry k=
ey for family %d (%lu)"),
-                      family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not open interfaces registry k=
ey for family %d (%lu)",
+                      __func__, family, err);
     }

     return err ? FALSE : TRUE;
@@ -1794,18 +1786,16 @@
     err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
-                                     "could not open interface key for %s =
family %d (%lu)"),
-                      itf_id, family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not open interface key for %s =
family %d (%lu)",
+                      __func__, itf_id, family, err);
         goto out;
     }

     err =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, str=
len(value) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
-                                     "could not set name servers '%S' for =
%s family %d (%lu)"),
-                      value, itf_id, family, err);
+        MsgToEventLog(M_SYSERR, L"%s: could not set name servers '%S' for =
%s family %d (%lu)",
+                      __func__, value, itf_id, family, err);
     }

 out:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/910?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0
Gerrit-Change-Number: 910
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--a2nIdUm8wxE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/910?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">openvpnserv: Clean up use of TEXT() from DNS patches<br><br>T=
hese are slightly different and so not covered<br>by my automatic conversio=
n script. Use __func__<br>to make the actual string slightly shorter.<br><b=
r>Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpnserv/intera=
ctive.c<br>1 file changed, 37 insertions(+), 47 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/910/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</=
span><br><span>index bc53f04..5812824 100644</span><br><span>--- a/src/open=
vpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</=
span><br><span>@@ -1194,30 +1194,30 @@</span><br><span> </span><br><span>  =
   if (apply_gpol &amp;&amp; ApplyGpolSettings() =3D=3D FALSE)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Msg=
ToEventLog(M_ERR, L&quot;ApplyDnsSettings: sending GPOL notification failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Msg=
ToEventLog(M_ERR, L&quot;%s: sending GPOL notification failed&quot;, __func=
__);</span><br><span>     }</span><br><span> </span><br><span>     scm =3D =
OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);</span><br><span>     if (=
scm =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings:=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                    &quot;OpenSCManager call failed (%lu)&quot;), GetLastEr=
ror());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_ERR, L&quot;%s: OpenSCManager call failed (%lu)&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                      __func=
__, GetLastError());</span><br><span>         goto out;</span><br><span>   =
  }</span><br><span> </span><br><span>     dnssvc =3D OpenServiceA(scm, &qu=
ot;Dnscache&quot;, SERVICE_PAUSE_CONTINUE);</span><br><span>     if (dnssvc=
 =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                 &quot;OpenService call failed (%lu)&quot;), GetLastError()=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEven=
tLog(M_ERR, L&quot;%s: OpenService call failed (%lu)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                      __func__, Get=
LastError());</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span> </span><br><span>     SERVICE_STATUS status;</span><br><span>=
     if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;status) =
=3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
             &quot;ControlService call failed (%lu)&quot;), GetLastError())=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEvent=
Log(M_ERR, L&quot;%s: ControlService call failed (%lu)&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      __func__, G=
etLastError());</span><br><span>         goto out;</span><br><span>     }</=
span><br><span> </span><br><span>@@ -1255,22 +1255,19 @@</span><br><span>  =
   err =3D InterfaceLuid(itf_name, &amp;luid);</span><br><span>     if (err=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MsgToEventLog(M_ERR, TEXT(&quot;InterfaceIdString: &quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
      &quot;failed to convert itf alias &#39;%s&#39;&quot;), itf_name);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M=
_ERR, L&quot;%s: failed to convert itf alias &#39;%s&#39;&quot;, __func__, =
itf_name);</span><br><span>         goto out;</span><br><span>     }</span>=
<br><span>     err =3D ConvertInterfaceLuidToGuid(&amp;luid, &amp;guid);</s=
pan><br><span>     if (err)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;Interf=
aceIdString: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                &quot;Failed to convert itf &#39;%s&#39; LU=
ID&quot;), itf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        MsgToEventLog(M_ERR, L&quot;%s: Failed to convert itf &#39;%s&#39=
; LUID&quot;, __func__, itf_name);</span><br><span>         goto out;</span=
><br><span>     }</span><br><span> </span><br><span>     if (StringFromIID(=
&amp;guid, &amp;iid_str) !=3D S_OK)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quo=
t;InterfaceIdString: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                  &quot;Failed to convert itf &#39;%s=
&#39; IID&quot;), itf_name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        MsgToEventLog(M_ERR, L&quot;%s: Failed to convert itf &#39=
;%s&#39; IID&quot;, __func__, itf_name);</span><br><span>         err =3D E=
RROR_OUTOFMEMORY;</span><br><span>         goto out;</span><br><span>     }=
</span><br><span>@@ -1420,8 +1417,7 @@</span><br><span>         {</span><br=
><span>             return FALSE;</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&q=
uot;InitialSearchListExists: &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                  &quot;failed to get Initial=
SearchList (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MsgToEventLog(M_ERR, L&quot;InitialSearchListExists: fai=
led to get InitialSearchList (%lu)&quot;, err);</span><br><span>     }</spa=
n><br><span> </span><br><span>     return TRUE;</span><br><span>@@ -1456,8 =
+1452,8 @@</span><br><span>     LSTATUS err =3D RegSetValueExW(key, L&quot;=
InitialSearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><span>   =
  if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;StoreInitialDnsSearchLi=
st: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                       &quot;failed to set InitialSearchList value (%lu)&qu=
ot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
MsgToEventLog(M_ERR, L&quot;%s: failed to set InitialSearchList value (%lu)=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          __func__, err);</span><br><span>         return FALSE;</span><br>=
<span>     }</span><br><span> </span><br><span>@@ -1485,8 +1481,8 @@</span>=
<br><span>         err =3D RegGetValueW(key, NULL, L&quot;SearchList&quot;,=
 RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><span>         if (err)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                       &quot;could not get SearchList from registry (%lu)&q=
uot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     MsgToEventLog(M_SYSERR, L&quot;%s: could not get SearchList from regis=
try (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                       __func__, err);</span><br><span>             return =
FALSE;</span><br><span>         }</span><br><span> </span><br><span>@@ -149=
9,9 +1495,8 @@</span><br><span>         size_t domlen =3D wcslen(domains);<=
/span><br><span>         if (listlen + domlen + 2 &gt; _countof(list))</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                    &quot;not enough space in list for search domains (len=
=3D%lu)&quot;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                    domlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            MsgToEventLog(M_SYSERR, L&quot;%s: not enough space in=
 list for search domains (len=3D%lu)&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                          __func__, domlen);</span>=
<br><span>             return FALSE;</span><br><span>         }</span><br><=
span> </span><br><span>@@ -1519,8 +1514,8 @@</span><br><span>     err =3D R=
egSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);<=
/span><br><span>     if (err)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;=
AddDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                     &quot;could not set SearchList t=
o registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set SearchL=
ist to registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                      __func__, err);</span><br><span>         ret=
urn FALSE;</span><br><span>     }</span><br><span> </span><br><span>@@ -155=
1,8 +1546,8 @@</span><br><span>     {</span><br><span>         if (err !=3D=
 ERROR_FILE_NOT_FOUND)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            MsgToEventLog(M_SYSERR, TEXT(&quot;=
ResetDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                         &quot;could not get Initia=
lSearchList from registry (%lu)&quot;), err);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, L&quot;%s: co=
uld not get InitialSearchList from registry (%lu)&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                          __func__, er=
r);</span><br><span>         }</span><br><span>         goto out;</span><br=
><span>     }</span><br><span>@@ -1561,8 +1556,8 @@</span><br><span>     er=
r =3D RegSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, =
size);</span><br><span>     if (err)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(=
&quot;ResetDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                     &quot;could not set Sear=
chList in registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set=
 SearchList in registry (%lu)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                      __func__, err);</span><br><span>    =
     goto out;</span><br><span>     }</span><br><span> </span><br><span>@@ =
-1589,16 +1584,15 @@</span><br><span>     err =3D RegGetValueW(key, NULL, L=
&quot;SearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><s=
pan>     if (err)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSear=
chDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                                 &quot;could not get SearchList from regist=
ry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not get SearchList from=
 registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                      __func__, err);</span><br><span>         return;</=
span><br><span>     }</span><br><span> </span><br><span>     PWSTR dst =3D =
wcsstr(list, domains);</span><br><span>     if (!dst)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLo=
g(M_ERR, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                  &quot;could =
not find domains in search list&quot;));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%s: could not find=
 domains in search list&quot;, __func__);</span><br><span>         return;<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -1618,8 +1612,8=
 @@</span><br><span>         err =3D RegGetValueW(key, NULL, L&quot;Initial=
SearchList&quot;, RRF_RT_REG_SZ, NULL, initial, &amp;size);</span><br><span=
>         if (err)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            MsgToEventLog(M_SYSERR, TEXT(&quot;Remo=
veDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                         &quot;could not get InitialSe=
archList from registry (%lu)&quot;), err);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, L&quot;%s: could=
 not get InitialSearchList from registry (%lu)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          __func__, err);=
</span><br><span>             return;</span><br><span>         }</span><br>=
<span> </span><br><span>@@ -1635,8 +1629,8 @@</span><br><span>     err =3D =
RegSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);=
</span><br><span>     if (err)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;=
RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                     &quot;could not set SearchLis=
t in registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set Sear=
chList in registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                      __func__, err);</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>@@ -1692,8 +1686,7 @@</s=
pan><br><span>     BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol, &=
amp;list_key);</span><br><span>     if (list_key =3D=3D INVALID_HANDLE_VALU=
E)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MsgToEventLog(M_SYSERR, TEXT(&quot;SetDnsSearchDomains: &quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
               &quot;could not get search list registry key&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SY=
SERR, L&quot;%s: could not get search list registry key&quot;, __func__);</=
span><br><span>         return ERROR_FILE_NOT_FOUND;</span><br><span>     }=
</span><br><span> </span><br><span>@@ -1762,9 +1755,8 @@</span><br><span>  =
   if (err)</span><br><span>     {</span><br><span>         *key =3D INVALI=
D_HANDLE_VALUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  MsgToEventLog(M_SYSERR, TEXT(&quot;GetInterfacesKey: &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
  &quot;could not open interfaces registry key for family %d (%lu)&quot;),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
family, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MsgToEventLog(M_SYSERR, L&quot;%s: could not open interfaces registry key=
 for family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      __func__, family, err);</span><br><span>     =
}</span><br><span> </span><br><span>     return err ? FALSE : TRUE;</span><=
br><span>@@ -1794,18 +1786,16 @@</span><br><span>     err =3D RegOpenKeyExW=
(itfs, itf_id, 0, KEY_ALL_ACCESS, &amp;itf);</span><br><span>     if (err)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        MsgToEventLog(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
            &quot;could not open interface key for %s family %d (%lu)&quot;=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   itf_id, family, err);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not open interface ke=
y for %s family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                      __func__, itf_id, family, err);</span><br=
><span>         goto out;</span><br><span>     }</span><br><span> </span><b=
r><span>     err =3D RegSetValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ,=
 (PBYTE)value, strlen(value) + 1);</span><br><span>     if (err)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        M=
sgToEventLog(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
  &quot;could not set name servers &#39;%S&#39; for %s family %d (%lu)&quot=
;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
    value, itf_id, family, err);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set name =
servers &#39;%S&#39; for %s family %d (%lu)&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                      __func__, value, itf_i=
d, family, err);</span><br><span>     }</span><br><span> </span><br><span> =
out:</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/910?usp=3Demail">change 910</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/910?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If15862fe537496ac836fc443936=
ff8e7876a39c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 910 </div>
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


--a2nIdUm8wxE=--

