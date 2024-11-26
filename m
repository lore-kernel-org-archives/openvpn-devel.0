From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 15:09:18 +0000
In-Reply-To: <gerrit.1732583163000.Ib88ce925b20c5912de489ef1b62615c4b87d365c@...2715...>
References: <gerrit.1732583163000.Ib88ce925b20c5912de489ef1b62615c4b87d365c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3f9d4beb14d34fee5c56e8f49cd92eae72d7f90d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cm95nrjvLFc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix wrong doxygen
 comments
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

--Cm95nrjvLFc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/82=
0?usp=3Demail )

Change subject: Fix wrong doxygen comments
......................................................................

Fix wrong doxygen comments

Add some missing "<" to trailing comments
to make sure they apply to the correct line.

Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20241126102651.18905-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
897.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpnmsica/msica_arg.h
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
M src/tapctl/tap.h
5 files changed, 26 insertions(+), 23 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 10ee9f6..043b240 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -929,10 +929,10 @@

 struct pull_filter
 {
-#define PUF_TYPE_UNDEF  0    /** undefined filter type */
-#define PUF_TYPE_ACCEPT 1    /** filter type to accept a matching option */
-#define PUF_TYPE_IGNORE 2    /** filter type to ignore a matching option */
-#define PUF_TYPE_REJECT 3    /** filter type to reject and trigger SIGUSR1=
 */
+#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
+#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option =
*/
+#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option =
*/
+#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR=
1 */
     int type;
     int size;
     char *pattern;
@@ -3846,14 +3846,14 @@
  *  Check file/directory sanity
  *
  */
-#ifndef ENABLE_SMALL  /** Expect people using the stripped down version to=
 know what they do */
+#ifndef ENABLE_SMALL  /* Expect people using the stripped down version to =
know what they do */

-#define CHKACC_FILE (1<<0)       /** Check for a file/directory presence */
-#define CHKACC_DIRPATH (1<<1)    /** Check for directory presence where a =
file should reside */
-#define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
-#define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed an=
d "exists" */
-#define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/=
others accessible */
-#define CHKACC_ACCEPT_URI (1<<5) /** If filename is a URI, no check is don=
e unless it starts with file: */
+#define CHKACC_FILE (1<<0)       /**< Check for a file/directory presence =
*/
+#define CHKACC_DIRPATH (1<<1)    /**< Check for directory presence where a=
 file should reside */
+#define CHKACC_FILEXSTWR (1<<2)  /**< If file exists, is it writable? */
+#define CHKACC_ACPTSTDIN (1<<3)  /**< If filename is stdin, it's allowed a=
nd "exists" */
+#define CHKACC_PRIVATE (1<<4)    /**< Warn if this (private) file is group=
/others accessible */
+#define CHKACC_ACCEPT_URI (1<<5) /**< Do not check URIs, unless they start=
 with file: */

 static bool
 check_file_access(const int type, const char *file, const int mode, const =
char *opt)
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 6cd272c..cec046f 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -37,8 +37,8 @@
  */
 struct msica_arg
 {
-    struct msica_arg *next; /** Pointer to the next argument in the sequen=
ce */
-    TCHAR val[];            /** Zero terminated argument string */
+    struct msica_arg *next; /**< Pointer to the next argument in the seque=
nce */
+    TCHAR val[];            /**< Zero terminated argument string */
 };


@@ -47,8 +47,8 @@
  */
 struct msica_arg_seq
 {
-    struct msica_arg *head; /** Pointer to the first argument in the seque=
nce */
-    struct msica_arg *tail; /** Pointer to the last argument in the sequen=
ce */
+    struct msica_arg *head; /**< Pointer to the first argument in the sequ=
ence */
+    struct msica_arg *tail; /**< Pointer to the last argument in the seque=
nce */
 };


diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 5ffb5b3..154fff4 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -59,9 +59,10 @@
  * Local constants
  */

-#define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to rese=
rve for one TAP/TUN adapter creation/deletition. */
+/** Amount of tick space to reserve for one TAP/TUN adapter creation/delet=
ition. */
+#define MSICA_ADAPTER_TICK_SIZE        (16 * 1024)

-#define FILE_NEED_REBOOT        L".ovpn_need_reboot"
+#define FILE_NEED_REBOOT               L".ovpn_need_reboot"

 #define OPENVPN_CONNECT_ADAPTER_SUBSTR L"OpenVPN Connect"

@@ -88,7 +89,9 @@
     free(szSequence);
     if (uiResult !=3D ERROR_SUCCESS)
     {
-        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() =
to set GetLastError(). But we do have an error code. Set last error manuall=
y. */
+        /* MSDN does not mention MsiSetProperty() to set GetLastError(). B=
ut we do have an error
+         * code. Set last error manually. */
+        SetLastError(uiResult);
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\")=
 failed", __FUNCTION__, szProperty);
         return uiResult;
     }
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 6640d7e..7aacdf3 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -38,7 +38,7 @@
  */
 struct openvpnmsica_thread_data
 {
-    MSIHANDLE hInstall; /** Handle to the installation session. */
+    MSIHANDLE hInstall; /**< Handle to the installation session. */
 };


diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 9c403cc..680c13a 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -135,11 +135,11 @@
  */
 struct tap_adapter_node
 {
-    GUID guid;             /** Adapter GUID */
-    LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
-    LPTSTR szName;         /** Adapter name */
+    GUID guid;             /**< Adapter GUID */
+    LPTSTR szzHardwareIDs; /**< Device hardware ID(s) */
+    LPTSTR szName;         /**< Adapter name */

-    struct tap_adapter_node *pNext; /** Pointer to next adapter */
+    struct tap_adapter_node *pNext; /**< Pointer to next adapter */
 };



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c
Gerrit-Change-Number: 820
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Cm95nrjvLFc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/820?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix wrong doxygen comments<br><br>Add some mis=
sing &quot;&lt;&quot; to trailing comments<br>to make sure they apply to th=
e correct line.<br><br>Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20241126102651.=
18905-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg29897.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpnmsica=
/msica_arg.h<br>M src/openvpnmsica/openvpnmsica.c<br>M src/openvpnmsica/ope=
nvpnmsica.h<br>M src/tapctl/tap.h<br>5 files changed, 26 insertions(+), 23 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 10ee9f6..043b240 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -929,10 +9=
29,10 @@</span><br><span> </span><br><span> struct pull_filter</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYP=
E_UNDEF  0    /** undefined filter type */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define PUF_TYPE_ACCEPT 1    /** filter type to accept=
 a matching option */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define PUF_TYPE_IGNORE 2    /** filter type to ignore a matching option */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_REJE=
CT 3    /** filter type to reject and trigger SIGUSR1 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_UNDEF  0    /**&lt; u=
ndefined filter type */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PUF_TYPE_ACCEPT 1    /**&lt; filter type to accept a matching o=
ption */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF=
_TYPE_IGNORE 2    /**&lt; filter type to ignore a matching option */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_REJECT 3 =
   /**&lt; filter type to reject and trigger SIGUSR1 */</span><br><span>   =
  int type;</span><br><span>     int size;</span><br><span>     char *patte=
rn;</span><br><span>@@ -3846,14 +3846,14 @@</span><br><span>  *  Check file=
/directory sanity</span><br><span>  *</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL  /** Expect peopl=
e using the stripped down version to know what they do */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL  /* Expect peopl=
e using the stripped down version to know what they do */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILE (=
1&lt;&lt;0)       /** Check for a file/directory presence */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_DIRPATH (1&lt;&lt;1) =
   /** Check for directory presence where a file should reside */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILEXSTWR (1&lt;=
&lt;2)  /** If file exists, is it writable? */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define CHKACC_ACPTSTDIN (1&lt;&lt;3)  /** If file=
name is stdin, it&#39;s allowed and &quot;exists&quot; */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_PRIVATE (1&lt;&lt;4)    =
/** Warn if this (private) file is group/others accessible */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACCEPT_URI (1&lt;&lt=
;5) /** If filename is a URI, no check is done unless it starts with file: =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FI=
LE (1&lt;&lt;0)       /**&lt; Check for a file/directory presence */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH (1&=
lt;&lt;1)    /**&lt; Check for directory presence where a file should resid=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_=
FILEXSTWR (1&lt;&lt;2)  /**&lt; If file exists, is it writable? */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN (1&=
lt;&lt;3)  /**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&=
quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHK=
ACC_PRIVATE (1&lt;&lt;4)    /**&lt; Warn if this (private) file is group/ot=
hers accessible */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CHKACC_ACCEPT_URI (1&lt;&lt;5) /**&lt; Do not check URIs, unless the=
y start with file: */</span><br><span> </span><br><span> static bool</span>=
<br><span> check_file_access(const int type, const char *file, const int mo=
de, const char *opt)</span><br><span>diff --git a/src/openvpnmsica/msica_ar=
g.h b/src/openvpnmsica/msica_arg.h</span><br><span>index 6cd272c..cec046f 1=
00644</span><br><span>--- a/src/openvpnmsica/msica_arg.h</span><br><span>++=
+ b/src/openvpnmsica/msica_arg.h</span><br><span>@@ -37,8 +37,8 @@</span><b=
r><span>  */</span><br><span> struct msica_arg</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct msica_arg *next; /**=
 Pointer to the next argument in the sequence */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    TCHAR val[];            /** Zero terminated =
argument string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct msica_arg *next; /**&lt; Pointer to the next argument in the sequ=
ence */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    TCHAR va=
l[];            /**&lt; Zero terminated argument string */</span><br><span>=
 };</span><br><span> </span><br><span> </span><br><span>@@ -47,8 +47,8 @@</=
span><br><span>  */</span><br><span> struct msica_arg_seq</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct msica_arg=
 *head; /** Pointer to the first argument in the sequence */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct msica_arg *tail; /** Poin=
ter to the last argument in the sequence */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct msica_arg *head; /**&lt; Pointer to the =
first argument in the sequence */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct msica_arg *tail; /**&lt; Pointer to the last argum=
ent in the sequence */</span><br><span> };</span><br><span> </span><br><spa=
n> </span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/open=
vpnmsica/openvpnmsica.c</span><br><span>index 5ffb5b3..154fff4 100644</span=
><br><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/=
openvpnmsica/openvpnmsica.c</span><br><span>@@ -59,9 +59,10 @@</span><br><s=
pan>  * Local constants</span><br><span>  */</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define MSICA_ADAPTER_TICK_SIZE (1=
6*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creatio=
n/deletition. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
 Amount of tick space to reserve for one TAP/TUN adapter creation/deletitio=
n. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MSICA_=
ADAPTER_TICK_SIZE        (16 * 1024)</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define FILE_NEED_REBOOT        L&quot;.ov=
pn_need_reboot&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define FILE_NEED_REBOOT               L&quot;.ovpn_need_reboot&quot;</spa=
n><br><span> </span><br><span> #define OPENVPN_CONNECT_ADAPTER_SUBSTR L&quo=
t;OpenVPN Connect&quot;</span><br><span> </span><br><span>@@ -88,7 +89,9 @@=
</span><br><span>     free(szSequence);</span><br><span>     if (uiResult !=
=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        SetLastError(uiResult); /* MSDN does not mentio=
n MsiSetProperty() to set GetLastError(). But we do have an error code. Set=
 last error manually. */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* MSDN does not mention MsiSetProperty() to set GetLastError(=
). But we do have an error</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * code. Set last error manually. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SetLastError(uiResult);</span><br=
><span>         msg(M_NONFATAL | M_ERRNO, &quot;%s: MsiSetProperty(\&quot;%=
&quot; PRIsLPTSTR &quot;\&quot;) failed&quot;, __FUNCTION__, szProperty);</=
span><br><span>         return uiResult;</span><br><span>     }</span><br><=
span>diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvp=
nmsica.h</span><br><span>index 6640d7e..7aacdf3 100644</span><br><span>--- =
a/src/openvpnmsica/openvpnmsica.h</span><br><span>+++ b/src/openvpnmsica/op=
envpnmsica.h</span><br><span>@@ -38,7 +38,7 @@</span><br><span>  */</span><=
br><span> struct openvpnmsica_thread_data</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    MSIHANDLE hInstall; /** Handle t=
o the installation session. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    MSIHANDLE hInstall; /**&lt; Handle to the installation sessi=
on. */</span><br><span> };</span><br><span> </span><br><span> </span><br><s=
pan>diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h</span><br><span>index =
9c403cc..680c13a 100644</span><br><span>--- a/src/tapctl/tap.h</span><br><s=
pan>+++ b/src/tapctl/tap.h</span><br><span>@@ -135,11 +135,11 @@</span><br>=
<span>  */</span><br><span> struct tap_adapter_node</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    GUID guid;            =
 /** Adapter GUID */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   LPTSTR szzHardwareIDs; /** Device hardware ID(s) */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    LPTSTR szName;         /** Adapter nam=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GUID guid; =
            /**&lt; Adapter GUID */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    LPTSTR szzHardwareIDs; /**&lt; Device hardware ID(s) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPTSTR szName; =
        /**&lt; Adapter name */</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct tap_adapter_node *pNext; /** Pointer=
 to next adapter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct tap_adapter_node *pNext; /**&lt; Pointer to next adapter */</spa=
n><br><span> };</span><br><span> </span><br><span> </span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/820?usp=3Demail">change 820</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib88ce925b20c5912de489ef1b62=
615c4b87d365c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 820 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Cm95nrjvLFc=--

