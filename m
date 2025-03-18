From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 18 Mar 2025 17:48:18 +0000
In-Reply-To: <gerrit.1742305513000.If15862fe537496ac836fc443936ff8e7876a39c0@...2715...>
References: <gerrit.1742305513000.If15862fe537496ac836fc443936ff8e7876a39c0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <bf8258cde0111a80168f2f21bea2cec718ed04b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qXwEaeL63Bc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qXwEaeL63Bc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
0?usp=3Demail )

Change subject: openvpnserv: Clean up use of TEXT() from DNS patches
......................................................................

openvpnserv: Clean up use of TEXT() from DNS patches

These are slightly different and so not covered
by my automatic conversion script. Use __func__
to make the actual string slightly shorter.

Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250318173914.24425-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
161.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 38 insertions(+), 47 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index bc53f04..50363b6 100644
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
@@ -1420,8 +1417,8 @@
         {
             return FALSE;
         }
-        MsgToEventLog(M_ERR, TEXT("InitialSearchListExists: "
-                                  "failed to get InitialSearchList (%lu)")=
, err);
+        MsgToEventLog(M_ERR, L"%s: failed to get InitialSearchList (%lu)",
+                      __func__, err);
     }

     return TRUE;
@@ -1456,8 +1453,8 @@
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

@@ -1485,8 +1482,8 @@
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

@@ -1499,9 +1496,8 @@
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

@@ -1519,8 +1515,8 @@
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

@@ -1551,8 +1547,8 @@
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
@@ -1561,8 +1557,8 @@
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

@@ -1589,16 +1585,15 @@
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

@@ -1618,8 +1613,8 @@
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

@@ -1635,8 +1630,8 @@
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

@@ -1692,8 +1687,7 @@
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

@@ -1762,9 +1756,8 @@
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
@@ -1794,18 +1787,16 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-MessageType: merged

--qXwEaeL63Bc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/910?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">openvpnserv: Clean up use of TEXT() from DNS p=
atches<br><br>These are slightly different and so not covered<br>by my auto=
matic conversion script. Use __func__<br>to make the actual string slightly=
 shorter.<br><br>Change-Id: If15862fe537496ac836fc443936ff8e7876a39c0<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250318173914.24425-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg31161.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 38 i=
nsertions(+), 47 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index bc53f04..50363b6 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1194,30 +1194,30 @@</span><br><span> </span><br><spa=
n>     if (apply_gpol &amp;&amp; ApplyGpolSettings() =3D=3D FALSE)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MsgToEventLog(M_ERR, L&quot;ApplyDnsSettings: sending GPOL notification fa=
iled&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 MsgToEventLog(M_ERR, L&quot;%s: sending GPOL notification failed&quot;, __=
func__);</span><br><span>     }</span><br><span> </span><br><span>     scm =
=3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);</span><br><span>     =
if (scm =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSetti=
ngs: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                        &quot;OpenSCManager call failed (%lu)&quot;), GetLa=
stError());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
MsgToEventLog(M_ERR, L&quot;%s: OpenSCManager call failed (%lu)&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                      __=
func__, GetLastError());</span><br><span>         goto out;</span><br><span=
>     }</span><br><span> </span><br><span>     dnssvc =3D OpenServiceA(scm,=
 &quot;Dnscache&quot;, SERVICE_PAUSE_CONTINUE);</span><br><span>     if (dn=
ssvc =3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings=
: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                     &quot;OpenService call failed (%lu)&quot;), GetLastErr=
or());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgTo=
EventLog(M_ERR, L&quot;%s: OpenService call failed (%lu)&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                      __func__,=
 GetLastError());</span><br><span>         goto out;</span><br><span>     }=
</span><br><span> </span><br><span>     SERVICE_STATUS status;</span><br><s=
pan>     if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;statu=
s) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;ApplyDnsSettings: &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                &quot;ControlService call failed (%lu)&quot;), GetLastError=
());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEv=
entLog(M_ERR, L&quot;%s: ControlService call failed (%lu)&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                      __func__=
, GetLastError());</span><br><span>         goto out;</span><br><span>     =
}</span><br><span> </span><br><span>@@ -1255,22 +1255,19 @@</span><br><span=
>     err =3D InterfaceLuid(itf_name, &amp;luid);</span><br><span>     if (=
err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MsgToEventLog(M_ERR, TEXT(&quot;InterfaceIdString: &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
         &quot;failed to convert itf alias &#39;%s&#39;&quot;), itf_name);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLo=
g(M_ERR, L&quot;%s: failed to convert itf alias &#39;%s&#39;&quot;, __func_=
_, itf_name);</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span>     err =3D ConvertInterfaceLuidToGuid(&amp;luid, &amp;guid);=
</span><br><span>     if (err)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;Int=
erfaceIdString: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                  &quot;Failed to convert itf &#39;%s&#39;=
 LUID&quot;), itf_name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MsgToEventLog(M_ERR, L&quot;%s: Failed to convert itf &#39;%s&=
#39; LUID&quot;, __func__, itf_name);</span><br><span>         goto out;</s=
pan><br><span>     }</span><br><span> </span><br><span>     if (StringFromI=
ID(&amp;guid, &amp;iid_str) !=3D S_OK)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&=
quot;InterfaceIdString: &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                  &quot;Failed to convert itf &#39=
;%s&#39; IID&quot;), itf_name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%s: Failed to convert itf &=
#39;%s&#39; IID&quot;, __func__, itf_name);</span><br><span>         err =
=3D ERROR_OUTOFMEMORY;</span><br><span>         goto out;</span><br><span> =
    }</span><br><span>@@ -1420,8 +1417,8 @@</span><br><span>         {</spa=
n><br><span>             return FALSE;</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TE=
XT(&quot;InitialSearchListExists: &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                  &quot;failed to get In=
itialSearchList (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%s: failed to get Initi=
alSearchList (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      __func__, err);</span><br><span>     }</span><b=
r><span> </span><br><span>     return TRUE;</span><br><span>@@ -1456,8 +145=
3,8 @@</span><br><span>     LSTATUS err =3D RegSetValueExW(key, L&quot;Init=
ialSearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><span>     if=
 (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;StoreInitialDnsSearchList: =
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                   &quot;failed to set InitialSearchList value (%lu)&quot;)=
, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_ERR, L&quot;%s: failed to set InitialSearchList value (%lu)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      __func__, err);</span><br><span>         return FALSE;</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -1485,8 +1482,8 @@</span><br>=
<span>         err =3D RegGetValueW(key, NULL, L&quot;SearchList&quot;, RRF=
_RT_REG_SZ, NULL, list, &amp;size);</span><br><span>         if (err)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                   &quot;could not get SearchList from registry (%lu)&quot;=
), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 MsgToEventLog(M_SYSERR, L&quot;%s: could not get SearchList from registry =
(%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   __func__, err);</span><br><span>             return FALS=
E;</span><br><span>         }</span><br><span> </span><br><span>@@ -1499,9 =
+1496,8 @@</span><br><span>         size_t domlen =3D wcslen(domains);</spa=
n><br><span>         if (listlen + domlen + 2 &gt; _countof(list))</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         MsgToEventLog(M_SYSERR, TEXT(&quot;AddDnsSearchDomains: &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                &quot;not enough space in list for search domains (len=3D%l=
u)&quot;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
               domlen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            MsgToEventLog(M_SYSERR, L&quot;%s: not enough space in list=
 for search domains (len=3D%lu)&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          __func__, domlen);</span><br><=
span>             return FALSE;</span><br><span>         }</span><br><span>=
 </span><br><span>@@ -1519,8 +1515,8 @@</span><br><span>     err =3D RegSet=
ValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span=
><br><span>     if (err)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;AddDns=
SearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                     &quot;could not set SearchList to regi=
stry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set SearchList to=
 registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                      __func__, err);</span><br><span>         return FA=
LSE;</span><br><span>     }</span><br><span> </span><br><span>@@ -1551,8 +1=
547,8 @@</span><br><span>     {</span><br><span>         if (err !=3D ERROR=
_FILE_NOT_FOUND)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            MsgToEventLog(M_SYSERR, TEXT(&quot;ResetD=
nsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                         &quot;could not get InitialSearc=
hList from registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, L&quot;%s: could no=
t get InitialSearchList from registry (%lu)&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          __func__, err);</s=
pan><br><span>         }</span><br><span>         goto out;</span><br><span=
>     }</span><br><span>@@ -1561,8 +1557,8 @@</span><br><span>     err =3D =
RegSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);=
</span><br><span>     if (err)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;=
ResetDnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                     &quot;could not set SearchList=
 in registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set Searc=
hList in registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      __func__, err);</span><br><span>         g=
oto out;</span><br><span>     }</span><br><span> </span><br><span>@@ -1589,=
16 +1585,15 @@</span><br><span>     err =3D RegGetValueW(key, NULL, L&quot;=
SearchList&quot;, RRF_RT_REG_SZ, NULL, list, &amp;size);</span><br><span>  =
   if (err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsSearchDoma=
ins: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                           &quot;could not get SearchList from registry (%l=
u)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     MsgToEventLog(M_SYSERR, L&quot;%s: could not get SearchList from regis=
try (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   __func__, err);</span><br><span>         return;</span><=
br><span>     }</span><br><span> </span><br><span>     PWSTR dst =3D wcsstr=
(list, domains);</span><br><span>     if (!dst)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ER=
R, TEXT(&quot;RemoveDnsSearchDomains: &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                  &quot;could not fi=
nd domains in search list&quot;));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;%s: could not find domai=
ns in search list&quot;, __func__);</span><br><span>         return;</span>=
<br><span>     }</span><br><span> </span><br><span>@@ -1618,8 +1613,8 @@</s=
pan><br><span>         err =3D RegGetValueW(key, NULL, L&quot;InitialSearch=
List&quot;, RRF_RT_REG_SZ, NULL, initial, &amp;size);</span><br><span>     =
    if (err)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            MsgToEventLog(M_SYSERR, TEXT(&quot;RemoveDnsS=
earchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                        &quot;could not get InitialSearchLi=
st from registry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            MsgToEventLog(M_SYSERR, L&quot;%s: could not g=
et InitialSearchList from registry (%lu)&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                          __func__, err);</span=
><br><span>             return;</span><br><span>         }</span><br><span>=
 </span><br><span>@@ -1635,8 +1630,8 @@</span><br><span>     err =3D RegSet=
ValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span=
><br><span>     if (err)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, TEXT(&quot;Remove=
DnsSearchDomains: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     &quot;could not set SearchList in r=
egistry (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set SearchList=
 in registry (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      __func__, err);</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span>@@ -1692,8 +1687,7 @@</span><b=
r><span>     BOOL have_list =3D GetDnsSearchListKey(itf_name, gpol, &amp;li=
st_key);</span><br><span>     if (list_key =3D=3D INVALID_HANDLE_VALUE)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      MsgToEventLog(M_SYSERR, TEXT(&quot;SetDnsSearchDomains: &quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
         &quot;could not get search list registry key&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, =
L&quot;%s: could not get search list registry key&quot;, __func__);</span><=
br><span>         return ERROR_FILE_NOT_FOUND;</span><br><span>     }</span=
><br><span> </span><br><span>@@ -1762,9 +1756,8 @@</span><br><span>     if =
(err)</span><br><span>     {</span><br><span>         *key =3D INVALID_HAND=
LE_VALUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgT=
oEventLog(M_SYSERR, TEXT(&quot;GetInterfacesKey: &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                     &quo=
t;could not open interfaces registry key for family %d (%lu)&quot;),</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                      family=
, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgT=
oEventLog(M_SYSERR, L&quot;%s: could not open interfaces registry key for f=
amily %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      __func__, family, err);</span><br><span>     }</spa=
n><br><span> </span><br><span>     return err ? FALSE : TRUE;</span><br><sp=
an>@@ -1794,18 +1787,16 @@</span><br><span>     err =3D RegOpenKeyExW(itfs,=
 itf_id, 0, KEY_ALL_ACCESS, &amp;itf);</span><br><span>     if (err)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   MsgToEventLog(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
      &quot;could not open interface key for %s family %d (%lu)&quot;),</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                      itf=
_id, family, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       MsgToEventLog(M_SYSERR, L&quot;%s: could not open interface key for =
%s family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      __func__, itf_id, family, err);</span><br><span=
>         goto out;</span><br><span>     }</span><br><span> </span><br><spa=
n>     err =3D RegSetValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ, (PBYT=
E)value, strlen(value) + 1);</span><br><span>     if (err)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEv=
entLog(M_SYSERR, TEXT(&quot;SetNameServersValue: &quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                     &quo=
t;could not set name servers &#39;%S&#39; for %s family %d (%lu)&quot;),</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      va=
lue, itf_id, family, err);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MsgToEventLog(M_SYSERR, L&quot;%s: could not set name server=
s &#39;%S&#39; for %s family %d (%lu)&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                      __func__, value, itf_id, fam=
ily, err);</span><br><span>     }</span><br><span> </span><br><span> out:</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/910?usp=3Demail">change 910</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/910?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If15862fe537496ac836fc443936=
ff8e7876a39c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 910 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--qXwEaeL63Bc=--

