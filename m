From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 01:06:22 +0000
References: <gerrit.1732583163000.Ib88ce925b20c5912de489ef1b62615c4b87d365c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c62202a4b021d55d8bc3a3be318b5b2e6d765041-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="60kaqPd7c6Y="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--60kaqPd7c6Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail

to review the following change.


Change subject: Fix wrong doxygen comments
......................................................................

Fix wrong doxygen comments

Add some missing "<" to trailing comments
to make sure they apply to the correct line.

Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpnmsica/msica_arg.h
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
M src/tapctl/tap.h
5 files changed, 26 insertions(+), 23 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/820/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--60kaqPd7c6Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix wrong doxygen comments<br><br>Add some missing &quot;&lt;=
&quot; to trailing comments<br>to make sure they apply to the correct line.=
<br><br>Change-Id: Ib88ce925b20c5912de489ef1b62615c4b87d365c<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/opti=
ons.c<br>M src/openvpnmsica/msica_arg.h<br>M src/openvpnmsica/openvpnmsica.=
c<br>M src/openvpnmsica/openvpnmsica.h<br>M src/tapctl/tap.h<br>5 files cha=
nged, 26 insertions(+), 23 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/20/820/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/options.c b/src/openvpn/options.c</span><br><span>index 10ee9f6..043b240=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -929,10 +929,10 @@</span><br><span>=
 </span><br><span> struct pull_filter</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_UNDEF  0    /** undefin=
ed filter type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine PUF_TYPE_ACCEPT 1    /** filter type to accept a matching option */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_IGNORE 2=
    /** filter type to ignore a matching option */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_REJECT 3    /** filter type t=
o reject and trigger SIGUSR1 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define PUF_TYPE_UNDEF  0    /**&lt; undefined filter type */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_ACCE=
PT 1    /**&lt; filter type to accept a matching option */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_IGNORE 2    /**&lt;=
 filter type to ignore a matching option */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define PUF_TYPE_REJECT 3    /**&lt; filter type to=
 reject and trigger SIGUSR1 */</span><br><span>     int type;</span><br><sp=
an>     int size;</span><br><span>     char *pattern;</span><br><span>@@ -3=
846,14 +3846,14 @@</span><br><span>  *  Check file/directory sanity</span><=
br><span>  *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifndef ENABLE_SMALL  /** Expect people using the stripped down=
 version to know what they do */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef ENABLE_SMALL  /* Expect people using the stripped down=
 version to know what they do */</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define CHKACC_FILE (1&lt;&lt;0)       /** Che=
ck for a file/directory presence */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define CHKACC_DIRPATH (1&lt;&lt;1)    /** Check for director=
y presence where a file should reside */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define CHKACC_FILEXSTWR (1&lt;&lt;2)  /** If file exist=
s, is it writable? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define CHKACC_ACPTSTDIN (1&lt;&lt;3)  /** If filename is stdin, it&#39;s a=
llowed and &quot;exists&quot; */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define CHKACC_PRIVATE (1&lt;&lt;4)    /** Warn if this (private=
) file is group/others accessible */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CHKACC_ACCEPT_URI (1&lt;&lt;5) /** If filename is a =
URI, no check is done unless it starts with file: */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE (1&lt;&lt;0)       /*=
*&lt; Check for a file/directory presence */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH (1&lt;&lt;1)    /**&lt; Che=
ck for directory presence where a file should reside */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXSTWR (1&lt;&lt;2)  =
/**&lt; If file exists, is it writable? */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN (1&lt;&lt;3)  /**&lt; If fi=
lename is stdin, it&#39;s allowed and &quot;exists&quot; */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_PRIVATE (1&lt;&lt;4)=
    /**&lt; Warn if this (private) file is group/others accessible */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACCEPT_URI=
 (1&lt;&lt;5) /**&lt; Do not check URIs, unless they start with file: */</s=
pan><br><span> </span><br><span> static bool</span><br><span> check_file_ac=
cess(const int type, const char *file, const int mode, const char *opt)</sp=
an><br><span>diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/m=
sica_arg.h</span><br><span>index 6cd272c..cec046f 100644</span><br><span>--=
- a/src/openvpnmsica/msica_arg.h</span><br><span>+++ b/src/openvpnmsica/msi=
ca_arg.h</span><br><span>@@ -37,8 +37,8 @@</span><br><span>  */</span><br><=
span> struct msica_arg</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct msica_arg *next; /** Pointer to the next arg=
ument in the sequence */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    TCHAR val[];            /** Zero terminated argument string */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct msica_arg *nex=
t; /**&lt; Pointer to the next argument in the sequence */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    TCHAR val[];            /**&lt; =
Zero terminated argument string */</span><br><span> };</span><br><span> </s=
pan><br><span> </span><br><span>@@ -47,8 +47,8 @@</span><br><span>  */</spa=
n><br><span> struct msica_arg_seq</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct msica_arg *head; /** Pointer to =
the first argument in the sequence */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct msica_arg *tail; /** Pointer to the last argumen=
t in the sequence */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct msica_arg *head; /**&lt; Pointer to the first argument in the s=
equence */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t msica_arg *tail; /**&lt; Pointer to the last argument in the sequence */<=
/span><br><span> };</span><br><span> </span><br><span> </span><br><span>dif=
f --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c=
</span><br><span>index 5ffb5b3..154fff4 100644</span><br><span>--- a/src/op=
envpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsi=
ca.c</span><br><span>@@ -59,9 +59,10 @@</span><br><span>  * Local constants=
</span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of t=
ick space to reserve for one TAP/TUN adapter creation/deletition. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/** Amount of tick space t=
o reserve for one TAP/TUN adapter creation/deletition. */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define MSICA_ADAPTER_TICK_SIZE      =
  (16 * 1024)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define FILE_NEED_REBOOT        L&quot;.ovpn_need_reboot&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define FILE_NEED_REBO=
OT               L&quot;.ovpn_need_reboot&quot;</span><br><span> </span><br=
><span> #define OPENVPN_CONNECT_ADAPTER_SUBSTR L&quot;OpenVPN Connect&quot;=
</span><br><span> </span><br><span>@@ -88,7 +89,9 @@</span><br><span>     f=
ree(szSequence);</span><br><span>     if (uiResult !=3D ERROR_SUCCESS)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to s=
et GetLastError(). But we do have an error code. Set last error manually. *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* MSDN do=
es not mention MsiSetProperty() to set GetLastError(). But we do have an er=
ror</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * code.=
 Set last error manually. */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SetLastError(uiResult);</span><br><span>         msg(M_NON=
FATAL | M_ERRNO, &quot;%s: MsiSetProperty(\&quot;%&quot; PRIsLPTSTR &quot;\=
&quot;) failed&quot;, __FUNCTION__, szProperty);</span><br><span>         r=
eturn uiResult;</span><br><span>     }</span><br><span>diff --git a/src/ope=
nvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h</span><br><span>=
index 6640d7e..7aacdf3 100644</span><br><span>--- a/src/openvpnmsica/openvp=
nmsica.h</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br><s=
pan>@@ -38,7 +38,7 @@</span><br><span>  */</span><br><span> struct openvpnm=
sica_thread_data</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    MSIHANDLE hInstall; /** Handle to the installation sessio=
n. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MSIHANDLE =
hInstall; /**&lt; Handle to the installation session. */</span><br><span> }=
;</span><br><span> </span><br><span> </span><br><span>diff --git a/src/tapc=
tl/tap.h b/src/tapctl/tap.h</span><br><span>index 9c403cc..680c13a 100644</=
span><br><span>--- a/src/tapctl/tap.h</span><br><span>+++ b/src/tapctl/tap.=
h</span><br><span>@@ -135,11 +135,11 @@</span><br><span>  */</span><br><spa=
n> struct tap_adapter_node</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    GUID guid;             /** Adapter GUID */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPTSTR szzHardwareIDs;=
 /** Device hardware ID(s) */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    LPTSTR szName;         /** Adapter name */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    GUID guid;             /**&lt; Adapt=
er GUID */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPTST=
R szzHardwareIDs; /**&lt; Device hardware ID(s) */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    LPTSTR szName;         /**&lt; Adapter n=
ame */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct tap_adapter_node *pNext; /** Pointer to next adapter */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tap_adapter_no=
de *pNext; /**&lt; Pointer to next adapter */</span><br><span> };</span><br=
><span> </span><br><span> </span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail">change=
 820</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/820?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib88ce925b20c5912de489ef1b62=
615c4b87d365c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 820 </div>
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


--60kaqPd7c6Y=--

