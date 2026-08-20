Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8FBC5DF82
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDR8lJaz/+WLSKUIfGY38VKEjFQKOQvFeMfLHodWA+c=; b=YArdYNPv8bznmQbtaqW6roGsrK
	p6INlIYFL+ix1TtWOh7pGRWFgkQvm4Y7ShDxppjOBzKyplvH+5E8eXHXr7XoU8FARb/r25OXfWyH0
	dSb/SK3DVn4B/o7pQ9OaS2pmFYku6K+gwzOR8WmM8A9Udatia1s4X1/CxEe3N4QOK5ro=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx09R-0004wc-DC;
	Thu, 20 Aug 2026 10:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx08w-0004wE-Ar
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BR6omSTEU6vP6NmZpANsEnbrMevVqTnCud042ayEUKY=; b=Pb6NEQMmfsgnluGQ4pLuFIB4by
 eWrded7STfoDz+5M9FYWFN5UkjVnG/RZwNzQEsqrjLBNOX9sG3e/5WtKnXaAmYUSLj3Kkct7AsBEd
 VRy4XYyQx4fSiQMaghGgapxlq/YAcfP16AOQ1bVmwYmXlXkno66JW/jAa6prqPeYd0lk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BR6omSTEU6vP6NmZpANsEnbrMevVqTnCud042ayEUKY=; b=a
 HXZs400NuQ9IZ8tEaqsbSF5qNetIlMlLIFmiREriUTSvp7ug+aUDFqS0iVqZMcoSsMFQHiid4FA7V
 oUDcp3gjED1hI0ScFcMeDs5ivBM/loznLBe/UEgbKJF22XGhYAeaz3Do1BuGCCWFIke+qF3P1wSmk
 lbXAzZhL/5BRixfk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx08o-0005h9-0a for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:37:03 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4998590d392so18503305e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787222211; x=1787827011; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BR6omSTEU6vP6NmZpANsEnbrMevVqTnCud042ayEUKY=;
 b=FoYM7mwl3HnuM/TP6Z8naiBJgeoLmENX1OorHUfraBia40HVieTalwy+Hl3PB2gqq3
 Q3PGB8ja9J9Dzv+gxDHbyMG4DCHWVg4kbQnF9uvGqthK1P8KBgHI57Br1ARTeH/kXLEq
 2lr8hbXYiPBdglhZQik1tij6dLchrxd/p0S+UhxDm4Mt1mbbkAC+DCKQEPtd+fvQ8nup
 f8BemoFIrSZerIbdj/iz6YkLG6R+VQGO7aPBF2lB2AOXF32W6aOTU/4YqxCGclTqTlUl
 HHPNkEY5mi8xvufZNjmOrJkDHRNyIT5iFXkz/yby6inhPxOK+WkZ8FaIaQcZG0a8WwTC
 vOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222211; x=1787827011;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BR6omSTEU6vP6NmZpANsEnbrMevVqTnCud042ayEUKY=;
 b=EXNEvG6ayfAo1vIkqcjYaE0fq/FEleI2oQx6yjd+y6R1kfdQ+VFCEnElM41b/WnP2r
 reoPeATTKDFm5r+p9YQ6y3L2eCVPVzlsTQ1QucMICUT2Ph2teQOiwHKxIX65gLw/3Vqs
 KOOKU3AyFPULfHQbL0u7L9vuV40D9Q7v6iVLXIW8Rnx+Q3Udf0KjXk1fcX45yMCbCyLs
 3g+mBXWAfLI6Ep++2CWaXgkBjkGikXctEIfy9zbFuk9nib1cUgoTfqcGFalOvwsMU0RC
 5SphHPxVnhXsYrhK3Qd0xBQdHXruAxT3FMJf+ZAeKvgZfr5OpDVBpVgAMk1Ga+YNJGYY
 C+UQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rruakb4FRmnVquZh98dBEUQ/DKc3Pz0JTT7pwh5cSp1NkR726z6WykDHb/BuL5cZOE6ctE/77/nIwjWQLxN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzLFuKnnH+PQk6hvKzojO6CVoL3ZCxCwYqoJtWbGFhaLUrJ3d4S
 OKEfYR5gE0dtP2E10KiTKc9o71YOVydUE/iyzqjhw7o2KnPkykE+diJsXyxZaSnE2WHW7olWUeR
 crhiXFYPygZwgHHF/8iHah0cuemyNqwMA/wgFIX6QIMHYnQKlB4jbCe0Jy1hPfZ1Dl6E5VWQ2ra
 EkSc9H8w==
X-Gm-Gg: AR+sD10gKw/ZP7o8qAo2ilTvyeeP5A7qPw9TcmV6uJlZBeJxpaljfiauNS4uOl17sTG
 7dz98BR80IYm/YAAIz64u5tEONvQRyExbQuY669ajcZK+53CExwu43vuUYmQouPCCYmo7A39q1y
 nwou6xB73kdoiwXAJ+BVX2PmxQYprP3ty1FqlFD8Jbmw8AtdkQwq+OVN8wa0hf/ENkcYAW32KkD
 EzQVbIzrWPlywwALupJ/6yEt0Grh5k0I1V90YURS9qfBe7aV1uIaOOOv7A2r8rESZaqe9RyiuQe
 DbFQRc2YGWp7Nfb2HQrg6gMP8Y9MVTZ48iFFZUiVHIsdkzosGIHyAe8wVVNfp+G9HVDwJHvmUNB
 k9MCwje6r7BrQONPFqp+k4u4enBjgwuf1c0tw+Yp+66urT0Ud/IhlMdxJkiACQfYZk7bNj54A+b
 Y0DJ4ysNy65XEVKmWXJd/w56LWxIjl83i9InRAgYo8S/M78qgSwrNPzPpS7shHLAeEWbnVY9kyQ
 xx1sAjL17OdPydxAsdcypWEz2Dlcag575I4qbcDR7CYQ0emaIwSiikH8K+lNlUbwH3sN6OHY0Y7
 QQxISP6V5A8Q7s9uQQUaBzj6lOF2mgnbMseNqgK48T+pGHy8hVubxMGX
X-Received: by 2002:a05:600c:4f52:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499aa1fdfb3mr178057195e9.13.1787222210554; 
 Thu, 20 Aug 2026 03:36:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e805a4sm149939425e9.4.2026.08.20.03.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:36:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:36:49 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: f781227c92a3d1017e9d8a67e83e4465b43edf66
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e247a6ad502e4f78ffaaa272be3044ce53425d1e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx08o-0005h9-0a
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6508316290822737121=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6508316290822737121==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ZVEBaXR6wo="; charset=UTF-8

--4ZVEBaXR6wo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1793?usp=3Demail )

Change subject: Reformat all shell-scripts with shf=
mt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reformat a=
ll shell-scripts with shfmt

According to =2E/dev-tools/reformat-shell=2Esh=
=2E

Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
3
Message-Id: <20260820091539=2E4592-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38547=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-too=
ls/git-pre-commit-format=2Esh
M dev-tools/run-cppcheck=2Esh
M dev-tools/upd=
ate-copyright=2Esh
M tests/lwip_client_up=2Esh
M tests/null_client_up=2Esh
=
M tests/t_client=2Esh=2Ein
M tests/t_cltsrv=2Esh
M tests/t_lpback=2Esh
M te=
sts/t_net=2Esh
M tests/t_server_null=2Esh
M tests/t_server_null_client=2Esh=

M tests/t_server_null_server=2Esh
M tests/t_server_null_stress=2Esh
M test=
s/update_t_client_ips=2Esh
14 files changed, 386 insertions(+), 385 deletio=
ns(-)




diff --git a/dev-tools/git-pre-commit-format=2Esh b/dev-tools/git=
-pre-commit-format=2Esh
index 9b2ecaf=2E=2E3507289 100755
--- a/dev-tools/g=
it-pre-commit-format=2Esh
+++ b/dev-tools/git-pre-commit-format=2Esh
@@ -26=
,7 +26,6 @@
 # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F SUCH DAMAGE=2E
 
-
 # git pre-commit hook that runs a stylecheck=2E
 # Fe=
atures:
 #  - abort commit when commit does not comply with the style guide=
lines
@@ -43,12 +42,11 @@
 # exit on error
 set -e
 
-
 # If called so, ins=
tall this script as pre-commit hook
-if [ "$1" =3D "install" ] ; then
+if [=
 "$1" =3D "install" ]; then
     TARGET=3D"$(git rev-parse --git-path hooks=
)/pre-commit"
 
-    if [ -e "$TARGET" ] ; then
+    if [ -e "$TARGET" ]; t=
hen
         printf "$TARGET file exists=2E Won't overwrite=2E\n"
         =
printf "Aborting installation=2E\n"
         exit 1
@@ -62,18 +60,19 @@
 fi=

 
 # check whether the given file matches any of the set extensions
-match=
es_extension() {
+matches_extension()
+{
     local filename=3D"$(basename =
-- "$1")"
     local extension=3D"=2E${filename##*=2E}"
     local ext
 
- =
   for ext in =2Ec =2Eh ; do [ "$ext" =3D "$extension" ] && return 0; done
=
+    for ext in =2Ec =2Eh; do [ "$ext" =3D "$extension" ] && return 0; done=

 
     return 1
 }
 
 # necessary check for initial commit
-if git rev-par=
se --verify HEAD >/dev/null 2>&1 ; then
+if git rev-parse --verify HEAD >/d=
ev/null 2>&1; then
     against=3DHEAD
 else
     # Initial commit: diff ag=
ainst an empty tree object
@@ -88,8 +87,8 @@
 
     # Allow to use in paral=
lel with pre-commit
     if [ $(basename "$0") =3D "pre-commit=2Elegacy" ];=
 then
-       echo "Skipping clang-format check in favor of pre-commit"
-  =
     exit 0
+        echo "Skipping clang-format check in favor of pre-comm=
it"
+        exit 0
     fi
 else
     TOOL=3Duncrustify
@@ -98,7 +97,7 @@
=
     TOOL_CMD=3D"$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
 
     # make sure t=
he config file is correctly set
-    if [ ! -f "$UNCRUST_CONFIG" ] ; then
+=
    if [ ! -f "$UNCRUST_CONFIG" ]; then
         printf "Error: uncrustify =
config file not found=2E\n"
         printf "Expected to find it at $UNCRUS=
T_CONFIG=2E\n"
         printf "Aborting commit=2E\n"
@@ -106,7 +105,7 @@
 =
    fi
 fi
 
-if [ -z "$TOOL_BIN" ] ; then
+if [ -z "$TOOL_BIN" ]; then
   =
  printf "Error: $TOOL executable not found=2E\n"
     printf "Is it instal=
led and in your \$PATH?\n"
     printf "Aborting commit=2E\n"
@@ -120,44 +1=
19,43 @@
 # create one patch containing all changes to the files
 # sed to =
remove quotes around the filename, if inserted by the system
 # (done somet=
imes, if the filename contains special characters, like the quote itself)
-=
git diff-index --cached --diff-filter=3DACMR --name-only $against -- | \
-s=
ed -e 's/^"\(=2E*\)"$/\1/' | \
-while read file
-do
-    # ignore file if w=
e do check for file extensions and the file
-    # does not match the exten=
sions =2Ec or =2Eh
-    if ! matches_extension "$file"; then
-        conti=
nue;
-    fi
+git diff-index --cached --diff-filter=3DACMR --name-only $aga=
inst -- |
+    sed -e 's/^"\(=2E*\)"$/\1/' |
+    while read file; do
+    =
    # ignore file if we do check for file extensions and the file
+        =
# does not match the extensions =2Ec or =2Eh
+        if ! matches_extensio=
n "$file"; then
+            continue
+        fi
 
-    # escape special c=
haracters in the target filename:
-    # phase 1 (characters escaped in the=
 output diff):
-    #     - '\': backslash needs to be escaped in the outpu=
t diff
-    #     - '"': quote needs to be escaped in the output diff if pr=
esent inside
-    #            of the filename, as it used to bracket the e=
ntire filename part
-    # phase 2 (characters escaped in the match replace=
ment):
-    #     - '\': backslash needs to be escaped again for sed itself=

-    #            (i=2Ee=2E double escaping after phase 1)
-    #     - '&=
': would expand to matched string
-    #     - '|': used as sed split char =
instead of '/'
-    # printf %s particularly important if the filename cont=
ains the % character
-    file_escaped_target=3D$(printf "%s" "$file" | sed=
 -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
+        # escape special characters=
 in the target filename:
+        # phase 1 (characters escaped in the outp=
ut diff):
+        #     - '\': backslash needs to be escaped in the output=
 diff
+        #     - '"': quote needs to be escaped in the output diff if=
 present inside
+        #            of the filename, as it used to bracke=
t the entire filename part
+        # phase 2 (characters escaped in the ma=
tch replacement):
+        #     - '\': backslash needs to be escaped again=
 for sed itself
+        #            (i=2Ee=2E double escaping after phase=
 1)
+        #     - '&': would expand to matched string
+        #     - '=
|': used as sed split char instead of '/'
+        # printf %s particularly=
 important if the filename contains the % character
+        file_escaped_t=
arget=3D$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
 =

-    # uncrustify our sourcefile, create a patch with diff and append it t=
o our $patch
-    # The sed call is necessary to transform the patch from
-=
    #    --- - timestamp
-    #    +++ $tmpout timestamp
-    # to both lin=
es working on the same file and having a a/ and b/ prefix=2E
-    # Else it=
 can not be applied with 'git apply'=2E
-    git show ":$file" | $TOOL_CMD =
> "$tmpout"
-    git show ":$file" | diff -u -- - "$tmpout" | \
-        se=
d -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/=
$file_escaped_target\"|" >> "$patch"
-done
+        # uncrustify our source=
file, create a patch with diff and append it to our $patch
+        # The s=
ed call is necessary to transform the patch from
+        #    --- - timest=
amp
+        #    +++ $tmpout timestamp
+        # to both lines working on=
 the same file and having a a/ and b/ prefix=2E
+        # Else it can not =
be applied with 'git apply'=2E
+        git show ":$file" | $TOOL_CMD >"$tm=
pout"
+        git show ":$file" | diff -u -- - "$tmpout" |
+            se=
d -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/=
$file_escaped_target\"|" >>"$patch"
+    done
 
 rm -f "$tmpout"
 
 # if no=
 patch has been generated all is ok, clean up the file stub and exit
-if [ =
! -s "$patch" ] ; then
+if [ ! -s "$patch" ]; then
     rm -f "$patch"
    =
 exit 0
 fi
@@ -165,7 +163,7 @@
 # a patch has been created, notify the use=
r and exit
 printf "Formatting of some code does not follow the project gui=
delines=2E\n"
 
-if [ $(wc -l < $patch) -gt 80 ] ; then
+if [ $(wc -l <$pat=
ch) -gt 80 ]; then
     printf "The file $patch contains the necessary fixe=
s=2E\n"
 else
     printf "Here's the patch that fixes the formatting:\n\n"=

diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
ind=
ex 40db33e=2E=2Ea7aa3c4 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-=
tools/run-cppcheck=2Esh
@@ -20,24 +20,23 @@
  --check-level=3Dexhaustive --=
max-configs=3D10 \
  --error-exitcode=3D1"
 
-
 set -x
 
 mkdir -p "$CPPCHE=
CK_DIR"
 cd "${SOURCE_DIR}"
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
-      =
   --platform=3Dunix64 \
-         --library=3Dposix=2Ecfg --library=3Dbsd=
=2Ecfg --library=3Dgnu=2Ecfg \
-         -U_WIN32 \
-         src/openvpn/ =
src/compat/ src/plugins/ sample/ \
-         tests/unit_tests/example_test/=
 tests/unit_tests/openvpn/ \
-         tests/unit_tests/plugins/
+    --pla=
tform=3Dunix64 \
+    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --libra=
ry=3Dgnu=2Ecfg \
+    -U_WIN32 \
+    src/openvpn/ src/compat/ src/plugins/=
 sample/ \
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
=
+    tests/unit_tests/plugins/
 cppcheck $COMMON_ARGS \
-         --platfor=
m=3Dwin64 \
-         --library=3Dwindows=2Ecfg \
-         -D_WIN32 \
-   =
      -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
- =
        -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFL=
Y \
-         -UTARGET_AIX \
-         src/openvpn* src/compat/ \
-        =
 tests/unit_tests/example_test/ tests/unit_tests/openvpn*
+    --platform=
=3Dwin64 \
+    --library=3Dwindows=2Ecfg \
+    -D_WIN32 \
+    -UTARGET_L=
INUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+    -UTARGET_DARW=
IN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+    -UTARGET_AIX=
 \
+    src/openvpn* src/compat/ \
+    tests/unit_tests/example_test/ test=
s/unit_tests/openvpn*
diff --git a/dev-tools/update-copyright=2Esh b/dev-to=
ols/update-copyright=2Esh
index 96546dd=2E=2E7ca6002 100755
--- a/dev-tools=
/update-copyright=2Esh
+++ b/dev-tools/update-copyright=2Esh
@@ -34,8 +34,7=
 @@
 COPY_YEAR=3D"$1"
 
 cd "$(git rev-parse --show-toplevel)"
-for file in=
 $(git ls-files | grep -v vendor/);
-do
+for file in $(git ls-files | grep =
-v vendor/); do
     echo -n "Updating $file =2E=2E=2E"
     # The first se=
d operation covers 20xx-20yy copyright lines,
     # The second sed operati=
on changes 20xx -> 20xx-20yy
diff --git a/tests/lwip_client_up=2Esh b/tests=
/lwip_client_up=2Esh
index a6b4d24=2E=2Eb1941a4 100755
--- a/tests/lwip_cli=
ent_up=2Esh
+++ b/tests/lwip_client_up=2Esh
@@ -2,16 +2,17 @@
 #
 # Determi=
ne the OpenVPN PID from its pid file=2E This works reliably even when
 # th=
e OpenVPN process is backgrounded for parallel tests=2E
-MY_PPID=3D`cat $pi=
d`
+MY_PPID=3D$(cat $pid)
 
 # Add this client's VPN IP and PID to a file=
=2E This enables
 # t_server_null_client=2Esh to kill this OpenVPN client a=
fter fping tests have
 # finished=2E
-echo "$ifconfig_local,$MY_PPID" >> =
=2E/$test_name=2Elwip
+echo "$ifconfig_local,$MY_PPID" >>=2E/$test_name=2El=
wip
 
 # Wait long enough to allow fping tests to finish=2E Also ensure tha=
t this
 # OpenVPN client is killed even if t_server_null_client=2Esh failed=
 to do it=2E
-(sleep 15
-echo "ERROR: t_server_null_client=2Esh failed to k=
ill OpenVPN client with PID $MY_PPID in test $test_name=2E Killing it in lw=
ip_client_up=2Esh=2E"
-kill -15 $MY_PPID
+(
+    sleep 15
+    echo "ERROR:=
 t_server_null_client=2Esh failed to kill OpenVPN client with PID $MY_PPID =
in test $test_name=2E Killing it in lwip_client_up=2Esh=2E"
+    kill -15 $=
MY_PPID
 ) &
diff --git a/tests/null_client_up=2Esh b/tests/null_client_up=
=2Esh
index d4df0c6=2E=2Ebe339ee 100755
--- a/tests/null_client_up=2Esh
+++=
 b/tests/null_client_up=2Esh
@@ -4,8 +4,11 @@
 
 # Determine the OpenVPN PI=
D from its pid file=2E This works reliably even when
 # the OpenVPN process=
 is backgrounded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY_PPID=3D$(c=
at $pid)
 
 # Allow OpenVPN to finish initializing while waiting in the bac=
kground and then
 # killing the process gracefully=2E
-(sleep 5 ; kill -15 =
$MY_PPID) &
+(
+    sleep 5
+    kill -15 $MY_PPID
+) &
diff --git a/tests/=
t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 2f37845=2E=2E305441be 1=
00755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,=
9 +19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=
=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r=
 "${top_builddir}"/t_client=2Erc ] ; then
+if [ -r "${top_builddir}"/t_clie=
nt=2Erc ]; then
     =2E "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcd=
ir}"/t_client=2Erc ] ; then
+elif [ -r "${srcdir}"/t_client=2Erc ]; then
  =
   =2E "${srcdir}"/t_client=2Erc
 else
     echo "$0: cannot find 't_client=
=2Erc' in build dir ('${top_builddir}')" >&2
@@ -32,37 +32,35 @@
 # Check f=
or external dependencies
 FPING=3D"fping"
 FPING6=3D"fping6"
-which fping >=
 /dev/null
+which fping >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fp=
ing is not available in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
-whi=
ch fping6 > /dev/null
+which fping6 >/dev/null
 if [ $? -ne 0 ]; then
     =
echo "$0: fping6 is not available in \$PATH, assuming fping 4=2E0 or later"=
 >&2
     FPING=3D"fping -4"
     FPING6=3D"fping -6"
 fi
 
-KILL_EXEC=3D`w=
hich kill`
+KILL_EXEC=3D$(which kill)
 if [ $? -ne 0 ]; then
     echo "$0:=
 kill not found in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ !=
 -x "${openvpn}" ]
-then
+if [ ! -x "${openvpn}" ]; then
     echo "no (exe=
cutable) openvpn binary in current build tree=2E FAIL=2E" >&2
     exit 1
 =
fi
 
-if [ ! -w =2E ]
-then
+if [ ! -w =2E ]; then
     echo "current direc=
tory is not writable (required for logging)=2E FAIL=2E" >&2
     exit 1
 fi=

 
-if [ -z "$TEST_RUN_LIST" ] ; then
+if [ -z "$TEST_RUN_LIST" ]; then
   =
  echo "TEST_RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
     ex=
it "${TCLIENT_SKIP_RC}"
 fi
@@ -72,16 +70,14 @@
 
 # make sure we have perm=
issions to run ifconfig/route from OpenVPN
 # can't use "id -u" here - does=
n't work on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then =
:
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-   =
 if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ];=
 then
         # Check if we have a valid kerberos ticket
         klist -l=
 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        i=
f [ $? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and =
fallback to RUN_SUDO
             PREFER_KSU=3D0
             echo "$0: No =
Kerberos ticket available=2E  Will not use ksu=2E"
@@ -90,8 +86,7 @@
      =
   fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUD=
O" ]; then
         echo "$0: this test must run be as root, or RUN_SUDO=3D=
=2E=2E=2E " >&2
         echo "      must be set correctly in 't_client=2Er=
c'=2E SKIP=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -99,20 +94,19 @@
 =
        # We have to use sudo=2E Make sure that we (hopefully) do not have
=
         # to ask the users password during the test=2E This is done to
   =
      # prevent timing issues, e=2Eg=2E when the waits for openvpn to start=

-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KILL_EXE=
C -0 succeeded, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 fai=
led, cannot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	fi
+   =
     if $RUN_SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_SUDO $=
KILL_EXEC -0 succeeded, good=2E"
+        else
+            echo "$0: $RUN_=
SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+            exit "=
${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_client-`hostname`=
-`date +%Y%m%d-%H%M%S`
+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S=
)
 LOGDIR_ABS=3D"$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if mkdir $LOGDIR;=
 then
+    :
 else
     echo "can't create log directory '$LOGDIR'=2E FAIL=
=2E" >&2
     exit 1
@@ -132,21 +126,28 @@
 output_start()
 {
     case $V =
in
-	0) outbuf=3D"" ;;			# no per-test output at all
-	1) printf "$@\n"			#=
 compact, details only on failure
-           outbuf=3D"\n" ;;
-	*) printf =
"\n$@\n" ;;		# print all, with a bit formatting
+        0) outbuf=3D"" ;; =
# no per-test output at all
+        1)
+            printf "$@\n" # compac=
t, details only on failure
+            outbuf=3D"\n"
+            ;;
+    =
    *) printf "\n$@\n" ;; # print all, with a bit formatting
     esac
 }
 =

 output()
 {
-    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; then END_NL=3D""=
 ; shift ; fi
+    END_NL=3D"\n"
+    if [ "X$1" =3D "X-n" ]; then
+       =
 END_NL=3D""
+        shift
+    fi
     case $V in
-	0) ;;				# no per-tes=
t output at all
-	1) outbuf=3D"$outbuf$@${END_NL}"	# print details only on =
failure
-           ;;
-	*) printf "$@${END_NL}" ;;	# print everything
+   =
     0) ;; # no per-test output at all
+        1)
+            outbuf=3D"$=
outbuf$@${END_NL}" # print details only on failure
+            ;;
+       =
 *) printf "$@${END_NL}" ;; # print everything
     esac
 }
 
@@ -154,62 +1=
55,61 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=3D$(( $fail_co=
unt + 1 ))
+    fail_count=3D$(($fail_count + 1))
 }
 
 # print "all interf=
ace IP addresses" + "all routes"
 # this is higly system dependent=2E=2E=2E=

 get_ifconfig_route()
 {
-    UNAME=3D`uname -s`
+    UNAME=3D$(uname -s)
=
     case $UNAME in
-	Linux)
+        Linux)
             # linux / iproute=
2? (-> if configure got a path)
-            if [ -n "@IPROUTE@" ]
-       =
     then
+            if [ -n "@IPROUTE@" ]; then
                 echo "-=
- linux iproute2 --"
-                @IPROUTE@ addr show     | grep -v val=
id_lft
+                @IPROUTE@ addr show | grep -v valid_lft
           =
      @IPROUTE@ route show
                 @IPROUTE@ -o -6 route show | gr=
ep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cw=
nd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
             else
=
-	        echo "-- linux / ifconfig --"
-	        LANG=3DC @IFCONFIG@ -a |e=
grep  "( addr:|encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 -6
+           =
     echo "-- linux / ifconfig --"
+                LANG=3DC @IFCONFIG@ -a =
| egrep "( addr:|encap:)"
+                LANG=3DC @NETSTAT@ -rn -4 -6
   =
          fi
             ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD=
/NetBSD/Darwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-=
	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	Ope=
nBSD)
-	   echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)=
" | \
-		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -=
rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	   echo "=
-- Solaris --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ =
-rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	   echo "--=
 AIX --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | =
awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
+        FreeBSD | NetBSD =
| Darwin)
+            echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+      =
      @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | =
awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+        OpenBSD)=

+            echo "-- OpenBSD --"
+            @IFCONFIG@ -a | egrep "(fla=
gs=3D|inet)" |
+                sed -e 's/pltime [0-9]*//' -e 's/vltime [0-=
9]*//'
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF =
}'
+            ;;
+        SunOS)
+            echo "-- Solaris --"
+     =
       @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn |=
 awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
+        AIX)
+  =
          echo "-- AIX --"
+            @IFCONFIG@ -a | egrep "(flags=3D|in=
et)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
=
+            ;;
         *)
-           echo "get_ifconfig_route(): no idea=
 how to get info on your OS (`uname -s`)=2E  FAIL=2E" >&2
-           exit =
20
-           ;;
+            echo "get_ifconfig_route(): no idea how to g=
et info on your OS ($(uname -s))=2E  FAIL=2E" >&2
+            exit 20
+   =
         ;;
     esac
 
     # another round of per-platform information ga=
thering, for DNS info
     # for most of the platforms "cat /etc/resolv=2Ec=
onf" is good enough
     # except Linux and MacOS
     case $UNAME in
-	Lin=
ux)
-            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; =
then
+        Linux)
+            if [ -x /usr/bin/resolvectl -a -d /run/sy=
stemd/system ]; then
                 echo "-- linux resolvectl --"
       =
          resolvectl status
             else
@@ -217,7 +217,7 @@
         =
        cat /etc/resolv=2Econf
             fi
             ;;
-	Darwin)
+ =
       Darwin)
             echo "-- MacOS scutil --dns"
             scuti=
l --dns
             ;;
@@ -234,19 +234,19 @@
 #  arg2: IPv4/IPv6 address t=
hat must show up in out of "get_ifconfig_route"
 check_ifconfig()
 {
-    p=
roto=3D$1 ; shift
+    proto=3D$1
+    shift
     expect_list=3D"$@"
 
-   =
 if [ -z "$expect_list" ] ; then return ; fi
-    if [ "$expect_list" =3D "=
-" ] ; then return ; fi
+    if [ -z "$expect_list" ]; then return; fi
+   =
 if [ "$expect_list" =3D "-" ]; then return; fi
 
-    for expect in $expec=
t_list
-    do
-	if get_ifconfig_route | fgrep "$expect" >/dev/null
-	then =
:
-	else
-	    fail "check_ifconfig(): expected IPv$proto address '$expect'=
 not found in ifconfig output=2E"
-	fi
+    for expect in $expect_list; do
=
+        if get_ifconfig_route | fgrep "$expect" >/dev/null; then
+        =
    :
+        else
+            fail "check_ifconfig(): expected IPv$proto=
 address '$expect' not found in ifconfig output=2E"
+        fi
     done
 =
}
 
@@ -257,47 +257,48 @@
 #  arg3=2E=2E=2E -> fping arguments (host list)
=
 run_ping_tests()
 {
-    proto=3D$1 ; want=3D$2 ; shift ; shift
+    proto=
=3D$1
+    want=3D$2
+    shift
+    shift
     targetlist=3D"$@"
 
     # =
"no targets" is fine
-    if [ -z "$targetlist" ] ; then return ; fi
+    i=
f [ -z "$targetlist" ]; then return; fi
 
     case $proto in
-	4) cmd=3D"$=
FPING" ;;
-	6) cmd=3D"$FPING6" ;;
-	*) echo "internal error in run_ping_tes=
ts arg 1: '$proto'" >&2
-	   exit 1 ;;
+        4) cmd=3D"$FPING" ;;
+     =
   6) cmd=3D"$FPING6" ;;
+        *)
+            echo "internal error in r=
un_ping_tests arg 1: '$proto'" >&2
+            exit 1
+            ;;
    =
 esac
 
     case $want in
-	want_ok)   sizes_list=3D"64 1440 3000" ;;
-	wa=
nt_fail) sizes_list=3D"64" ;;
+        want_ok) sizes_list=3D"64 1440 3000"=
 ;;
+        want_fail) sizes_list=3D"64" ;;
     esac
 
-    for bytes in =
$sizes_list
-    do
-	output "run IPv$proto ping tests ($want), $bytes byte=
 packets=2E=2E=2E"
+    for bytes in $sizes_list; do
+        output "run I=
Pv$proto ping tests ($want), $bytes byte packets=2E=2E=2E"
 
-	echo "$cmd -=
b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eou=
t
-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:f=
ping=2Eout 2>&1
+        echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $=
targetlist" >>$LOGDIR/$SUF:fping=2Eout
+        $cmd -b $bytes -C 20 -p 250=
 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
 
-	# while Ope=
nVPN is running, pings must succeed (want=3D'want_ok')
-	# before OpenVPN i=
s up, pings must NOT succeed (want=3D'want_fail')
+        # while OpenVPN =
is running, pings must succeed (want=3D'want_ok')
+        # before OpenVPN=
 is up, pings must NOT succeed (want=3D'want_fail')
 
-	rc=3D$?
-	if [ $rc =
=3D 0 ] 				# all ping OK
-	then
-	    if [ $want =3D "want_fail" ]		# not =
what we want
-	    then
-		fail "IPv$proto ping test succeeded, but needs t=
o *fail*=2E"
-	    fi
-	else					# ping failed
-	    if [ $want =3D "want_o=
k" ]		# not what we wanted
-	    then
-		fail "IPv$proto ping test ($bytes =
bytes) failed, but should succeed=2E"
-	    fi
-	fi
+        rc=3D$?
+     =
   if [ $rc =3D 0 ]; then                 # all ping OK
+            if [ $=
want =3D "want_fail" ]; then # not what we want
+                fail "IPv$=
proto ping test succeeded, but needs to *fail*=2E"
+            fi
+       =
 else                               # ping failed
+            if [ $want =
=3D "want_ok" ]; then # not what we wanted
+                fail "IPv$proto=
 ping test ($bytes bytes) failed, but should succeed=2E"
+            fi
+ =
       fi
     done
 }
 
@@ -308,8 +309,7 @@
 SUMMARY_SKIP=3D
 SUMMARY_FAIL=
=3D
 
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # =
get config variables
     eval test_prep=3D\"\$PREPARE_$SUF\"
     eval tes=
t_check_skip=3D\"\$CHECK_SKIP_$SUF\"
@@ -336,11 +336,13 @@
 
     if [ -n "=
$test_check_skip" ]; then
         output "check whether we need to skip: '=
$test_check_skip'"
-        if eval $test_check_skip; then :
+        if ev=
al $test_check_skip; then
+            :
         else
             output =
"skip check failed, SKIP test $SUF=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP =
$SUF"
-	    printf "$outbuf" ; continue
+            SUMMARY_SKIP=3D"$SUMMA=
RY_SKIP $SUF"
+            printf "$outbuf"
+            continue
         =
fi
     fi
 
@@ -355,13 +357,14 @@
     output "\nrun pre-openvpn ping test=
s - targets must not be reachable=2E=2E=2E"
     run_ping_tests 4 want_fail=
 "$ping4_hosts"
     run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$=
fail_count" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0 ]; then
         o=
utput "OK=2E\n"
     else
-	fail "make sure that ping hosts are ONLY reacha=
ble via VPN, SKIP test $SUF=2E"
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exi=
t_code=3D31
-	printf "$outbuf" ; continue
+        fail "make sure that pin=
g hosts are ONLY reachable via VPN, SKIP test $SUF=2E"
+        SUMMARY_FAI=
L=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D31
+        printf "$outbuf"
=
+        continue
     fi
 
     pidfile=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"=

@@ -376,18 +379,17 @@
     # to $ovpn_init_check times=2E
     ovpn_init_c=
heck=3D30
     ovpn_init_success=3D0
-    while [ $ovpn_init_check -gt 0 ];=

-    do
-       sleep 1  # Wait for OpenVPN to initialize and have had tim=
e to write the pid file
-       grep "Initialization Sequence Completed" $L=
OGDIR/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ]; then
-        =
   ovpn_init_check=3D0
-           ovpn_init_success=3D1
-       fi
-      =
 ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
+    while [ $ovpn_init_chec=
k -gt 0 ]; do
+        sleep 1 # Wait for OpenVPN to initialize and have ha=
d time to write the pid file
+        grep "Initialization Sequence Complet=
ed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+        if [ $? -eq 0 ]; then
+ =
           ovpn_init_check=3D0
+            ovpn_init_success=3D1
+        =
fi
+        ovpn_init_check=3D$(($ovpn_init_check - 1))
     done
 
-    op=
id=3D`cat $pidfile`
+    opid=3D$(cat $pidfile)
     if [ -n "$opid" ]; the=
n
         output "  OpenVPN running with PID $opid"
     else
@@ -398,16 +=
400,17 @@
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
        =
 output "$0:  OpenVPN did not initialize in a reasonable time"
         if =
[ -n "$opid" ]; then
-           $RUN_SUDO $KILL_EXEC $opid
+            $R=
UN_SUDO $KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EXEC $sudopid=

-	output "tail -5 $SUF:openvpn=2Elog"
-	output "`tail -5 $LOGDIR/$SUF:open=
vpn=2Elog`"
-	fail "skip rest of sub-tests for test run $SUF=2E"
-	trap - 0=
 1 2 3 15
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
-	printf "=
$outbuf" ; continue
+        output "tail -5 $SUF:openvpn=2Elog"
+        o=
utput "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+        fail "skip rest of s=
ub-tests for test run $SUF=2E"
+        trap - 0 1 2 3 15
+        SUMMARY_=
FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
+        printf "$outbu=
f"
+        continue
     fi
 
     # make sure openvpn client is terminate=
d in case shell exits
@@ -418,17 +421,16 @@
     output "save ifconfig+rout=
e"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route=2Etxt
 
-    if [ "=
$expect_ifconfig4" =3D "-" ] ; then
+    if [ "$expect_ifconfig4" =3D "-" ]=
; then
         output "skip ifconfig+route check"
     else
-	output -n "c=
ompare pre-openvpn ifconfig+route with current values=2E=2E=2E"
-	if diff $=
LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-		$LOGDIR/$SUF:ifconfig_route=2Etxt=
 >/dev/null
-	then
-	    fail "no differences between ifconfig/route before=
 OpenVPN start and now=2E"
-	else
-	    output " OK!\n"
-	fi
+        outpu=
t -n "compare pre-openvpn ifconfig+route with current values=2E=2E=2E"
+   =
     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
+            $LOGDIR/$=
SUF:ifconfig_route=2Etxt >/dev/null; then
+            fail "no differences=
 between ifconfig/route before OpenVPN start and now=2E"
+        else
+   =
         output " OK!\n"
+        fi
     fi
 
     # post init script need=
ed?
@@ -449,8 +451,8 @@
     $RUN_SUDO $KILL_EXEC $opid
     wait $!
     r=
c=3D$?
-    if [ $rc !=3D 0 ] ; then
-	fail "OpenVPN return code $rc, expec=
t 0"
+    if [ $rc !=3D 0 ]; then
+        fail "OpenVPN return code $rc, e=
xpect 0"
     fi
 
     output "\nsave post-openvpn ifconfig + route=2E=2E=
=2E"
@@ -458,23 +460,22 @@
 
     output -n "compare pre- and post-openvpn =
ifconfig + route=2E=2E=2E"
     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Et=
xt \
-	    $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_ro=
ute_diff=2Etxt
-    then
-	output " OK=2E\n"
+        $LOGDIR/$SUF:ifconfig=
_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then
+        ou=
tput " OK=2E\n"
     else
-	output "\n\n" "`cat $LOGDIR/$SUF:ifconfig_route=
_diff=2Etxt`" "\n"
-	fail "differences between pre- and post-ifconfig/route=
=2E"
+        output "\n\n" "$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)"=
 "\n"
+        fail "differences between pre- and post-ifconfig/route=2E"
 =
    fi
-    if [ "$fail_count" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0=
 ]; then
         output "test run $SUF: all tests OK=2E\n"
-	SUMMARY_OK=3D=
"$SUMMARY_OK $SUF"
+        SUMMARY_OK=3D"$SUMMARY_OK $SUF"
     else
-	if =
[ "$V" -gt 0 ] ; then
-	    printf "$outbuf"
-	    echo "test run $SUF: $fa=
il_count test failures=2E FAIL=2E"
+        if [ "$V" -gt 0 ]; then
+      =
      printf "$outbuf"
+            echo "test run $SUF: $fail_count test f=
ailures=2E FAIL=2E"
         fi
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exi=
t_code=3D30
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=
=3D30
     fi
 
     if [ -n "$test_cleanup" ]; then
@@ -484,9 +485,9 @@
 
=
 done
 
-if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=3D" none"; fi
-if [ -z "=
$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" none"; fi
-if [ -z "$SUMMARY_FAIL"=
 ] ; then SUMMARY_FAIL=3D" none"; fi
+if [ -z "$SUMMARY_OK" ]; then SUMMARY=
_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP" ]; then SUMMARY_SKIP=3D" none"; =
fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMARY_FAIL=3D" none"; fi
 echo "Test =
sets succeeded:$SUMMARY_OK=2E"
 echo "Test sets skipped:$SUMMARY_SKIP=2E"
 =
echo "Test sets failed:$SUMMARY_FAIL=2E"
diff --git a/tests/t_cltsrv=2Esh b=
/tests/t_cltsrv=2Esh
index 6b7df65=2E=2E03c3845 100755
--- a/tests/t_cltsrv=
=2Esh
+++ b/tests/t_cltsrv=2Esh
@@ -24,50 +24,58 @@
 trap "rm -f log=2E$$ l=
og=2E$$=2Esignal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log=2E$$ log=2E$$=
=2Esignal ; exit 1" 0 3
 addopts=3D
-case `uname -s` in
+case $(uname -s) i=
n
     FreeBSD)
-    # FreeBSD jails map the outgoing IP to the jail IP - w=
e need to
-    # allow the real IP unless we want the test to run forever=
=2E
-    if test "`sysctl 2>/dev/null -n security=2Ejail=2Ejailed`" =3D 1 \=

-    || ps -ostate=3D -p $$ | grep -q J; then
-	addopts=3D"--float"
-	if t=
est "x`ifconfig | grep inet`" =3D x ; then
-	    echo "###"
-	    echo "###=
 To run the test in a FreeBSD jail, you MUST add an IP alias for the jail's=
 IP=2E"
-	    echo "###"
-	    exit 77
-	fi
-    fi
-    ;;
+        # Free=
BSD jails map the outgoing IP to the jail IP - we need to
+        # allow =
the real IP unless we want the test to run forever=2E
+        if test "$(s=
ysctl 2>/dev/null -n security=2Ejail=2Ejailed)" =3D 1 ||
+            ps -o=
state=3D -p $$ | grep -q J; then
+            addopts=3D"--float"
+        =
    if test "x$(ifconfig | grep inet)" =3D x; then
+                echo "#=
##"
+                echo "### To run the test in a FreeBSD jail, you MUST =
add an IP alias for the jail's IP=2E"
+                echo "###"
+        =
        exit 77
+            fi
+        fi
+        ;;
 esac
 
 # make sur=
e that the --down script is executable -- fail (rather than
 # skip) test i=
f it isn't=2E
 downscript=3D"=2E=2E/tests/t_cltsrv-down=2Esh"
 root=3D"${to=
p_srcdir}/sample"
-test -x "${root}/${downscript}" || chmod +x "${root}/${d=
ownscript}" || { echo >&2 "${root}/${downscript} is not executable, failing=
=2E" ; exit 1 ; }
+test -x "${root}/${downscript}" || chmod +x "${root}/${d=
ownscript}" || {
+    echo >&2 "${root}/${downscript} is not executable, fa=
iling=2E"
+    exit 1
+}
 echo "The following test will take about two minu=
tes=2E" >&2
 echo "If the addresses are in use, this test will retry up to =
two times=2E" >&2
 
 # go
 success=3D0
-for i in 1 2 3 ; do
-  set +e
-  (
=
-  "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role=
 srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-con=
fig-files/loopback-server" &
-  "${openvpn}" --script-security 2 --cd "${to=
p_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls=
-exit --ping-exit 180 --config "sample-config-files/loopback-client"
-  ) 3=
>log=2E$$=2Esignal >log=2E$$ 2>&1
-  e1=3D$?
-  wait $!
-  e2=3D$?
-  grep =
'TCP/UDP: Socket bind failed on local address=2E*in use' log=2E$$ >/dev/nul=
l && {
-    echo 'address in use, retrying in 150 s'
-    sleep 150
-    co=
ntinue
-  }
-  grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && { cat l=
og=2E$$=2Esignal ; echo ; cat log=2E$$ ; exit 1 ; }
-  success=3D1
-  break=

+for i in 1 2 3; do
+    set +e
+    (
+        "${openvpn}" --script-secu=
rity 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" -=
-tls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
=
+        "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${add=
opts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 -=
-config "sample-config-files/loopback-client"
+    ) 3>log=2E$$=2Esignal >l=
og=2E$$ 2>&1
+    e1=3D$?
+    wait $!
+    e2=3D$?
+    grep 'TCP/UDP: Soc=
ket bind failed on local address=2E*in use' log=2E$$ >/dev/null && {
+     =
   echo 'address in use, retrying in 150 s'
+        sleep 150
+        con=
tinue
+    }
+    grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && {
+ =
       cat log=2E$$=2Esignal
+        echo
+        cat log=2E$$
+        e=
xit 1
+    }
+    success=3D1
+    break
 done
 
 set -e
@@ -75,14 +83,14 @=
@
 # exit code - defaults to 0, PASS
 ec=3D0
 
-if [ $success !=3D 1 ] ; th=
en
-  # couldn't run test -- addresses in use, skip test
-  cat log=2E$$
- =
 ec=3D77
-elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then
-  # failure -- fail=
 test
-  cat log=2E$$
-  ec=3D1
+if [ $success !=3D 1 ]; then
+    # couldn=
't run test -- addresses in use, skip test
+    cat log=2E$$
+    ec=3D77
+=
elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then
+    # failure -- fail test
+  =
  cat log=2E$$
+    ec=3D1
 fi
 
 rm log=2E$$ log=2E$$=2Esignal
diff --git =
a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh
index 6802506=2E=2E058206f 1007=
55
--- a/tests/t_lpback=2Esh
+++ b/tests/t_lpback=2Esh
@@ -37,51 +37,56 @@
=
 test_start()
 {
     case $V in
-        0) outbuf=3D"" ;;                =
  # no per-test output at all
-        1) outbuf=3D"$@" ;;                #=
 compact, details only on failure
-        *) printf "$@" ;;               =
 # print all
+        0) outbuf=3D"" ;;   # no per-test output at all
+    =
    1) outbuf=3D"$@" ;; # compact, details only on failure
+        *) prin=
tf "$@" ;; # print all
     esac
 }
 test_end()
 {
-    RC=3D$1 ; LOG=3D$2
=
-    if [ $RC !=3D 0 ]
-    then
+    RC=3D$1
+    LOG=3D$2
+    if [ $RC !=
=3D 0 ]; then
         case $V in
-            0) ;;                       =
         # no per-test output
-            1) echo "$outbuf" "FAIL (RC=3D$R=
C)"; cat $LOG ;;
-            *) echo "FAIL (RC=3D$RC)"; cat $LOG ;;
+     =
       0) ;; # no per-test output
+            1)
+                echo "$o=
utbuf" "FAIL (RC=3D$RC)"
+                cat $LOG
+                ;;
+   =
         *)
+                echo "FAIL (RC=3D$RC)"
+                cat $L=
OG
+                ;;
         esac
         e=3D1
-        tests_failed=
=3D$(( $tests_failed + 1 ))
+        tests_failed=3D$(($tests_failed + 1))
=
     else
         case $V in
-            0|1) ;;                         =
     # no per-test output for 'OK'
-            *) echo "OK"               =
          # print all
+            0 | 1) ;;       # no per-test output for=
 'OK'
+            *) echo "OK" ;; # print all
         esac
-        tests=
_passed=3D$(( $tests_passed + 1 ))
+        tests_passed=3D$(($tests_passed=
 + 1))
     fi
 }
 
 # if running with V=3D1, give an indication what test =
runs now
-if [ "$V" =3D 1  ] ; then
+if [ "$V" =3D 1 ]; then
     echo "$0:=
 running with V=3D$V, only printing test fails"
 fi
 
-
 # Get list of supp=
orted ciphers from openvpn --show-ciphers output
-CIPHERS=3D$(${openvpn} --=
show-ciphers | \
-            sed -e '/The following/,/^$/d' -e s'/ =2E*//'=
 -e '/^[[:space:]]*$/d')
+CIPHERS=3D$(${openvpn} --show-ciphers |
+    sed =
-e '/The following/,/^$/d' -e s'/ =2E*//' -e '/^[[:space:]]*$/d')
 
 # SK, =
2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # bro=
ken (see http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867), so exc=
lude
 # that cipher from this test=2E
 # GD, 2014-07-06 so is DES-CFB1
 # G=
D, 2014-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
=
-CIPHERS=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
=
+CIPHERS=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)')
 =

 e=3D0
-if [ -z "$CIPHERS" ] ; then
+if [ -z "$CIPHERS" ]; then
     echo =
"'openvpn --show-ciphers' FAILED (empty list)"
     e=3D1
 fi
@@ -91,10 +96=
,9 @@
 
 set +e
 
-for cipher in ${CIPHERS}
-do
+for cipher in ${CIPHERS}; =
do
     test_start "Testing cipher ${cipher}=2E=2E=2E "
-    ( "${openvpn}"=
 --test-crypto --cipher ${cipher} ) >log=2E$$ 2>&1
+    ("${openvpn}" --tes=
t-crypto --cipher ${cipher}) >log=2E$$ 2>&1
     test_end $? log=2E$$
 done=

 
@@ -121,7 +125,7 @@
     >log=2E$$ 2>&1
 test_end $? log=2E$$
 
-if [ "$=
V" -ge 1  ] ; then
+if [ "$V" -ge 1 ]; then
     echo "$0: tests passed: $t=
ests_passed  failed: $tests_failed"
 fi
 
diff --git a/tests/t_net=2Esh b/t=
ests/t_net=2Esh
index 8134832=2E=2E17e028e 100755
--- a/tests/t_net=2Esh
++=
+ b/tests/t_net=2Esh
@@ -9,7 +9,6 @@
 top_builddir=3D"${top_builddir:-=2E=
=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
-
 # b=
ail out right away on non-linux=2E NetLink (the object of this test) is onl=
y
 # used on Linux, therefore testing other platform is not needed=2E
 #
@@=
 -69,7 +68,6 @@
     done
 }
 
-
 ## execution starts here
 
 # t_client=2E=
rc required only for RUN_SUDO definition
@@ -89,21 +87,18 @@
     exit 77
 =
fi
 
-
 # Ensure PREFER_KSU is in a known state
 PREFER_KSU=3D"${PREFER_KSU=
:-0}"
 
 # make sure we have permissions to run the networking unit-test
-I=
D=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+ID=3D$(id)
+if expr=
 "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" =
-eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check=
 if we have a valid kerberos ticket
         klist -l 1>/dev/null 2>/dev/nu=
ll
-        if [ $? -ne 0 ];
-        then
+        if [ $? -ne 0 ]; then
 =
            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
 =
            PREFER_KSU=3D0
             echo "$0: No Kerberos ticket availa=
ble=2E  Will not use ksu=2E"
@@ -112,16 +107,14 @@
         fi
     fi
 
- =
   if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
       =
  echo "$0: no RUN_SUDO=3D=2E=2E=2E in t_client=2Erc or environment, defaul=
ting to 'sudo'=2E" >&2
         echo "      if that does not work, set RUN_=
SUDO=3D correctly for your system=2E" >&2
         RUN_SUDO=3D"sudo"
     f=
i
 
     # check that we can run the unit-test binary with sudo
-    if $RU=
N_SUDO $UNIT_TEST test
-    then
+    if $RUN_SUDO $UNIT_TEST test; then
  =
       echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good=2E"
     else
       =
  echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on=2E SKIP=2E" >&2
diff =
--git a/tests/t_server_null=2Esh b/tests/t_server_null=2Esh
index 74ffd52=
=2E=2Ec633614 100755
--- a/tests/t_server_null=2Esh
+++ b/tests/t_server_nu=
ll=2Esh
@@ -2,7 +2,7 @@
 #
 TSERVER_NULL_SKIP_RC=3D"${TSERVER_NULL_SKIP_RC:=
-77}"
 
-if ! [ -r "=2E/t_server_null=2Erc" ] ; then
+if ! [ -r "=2E/t_serv=
er_null=2Erc" ]; then
     echo "${0}: cannot find '=2E/t_server_null=2Erc=
=2E SKIPPING TEST=2E'" >&2
     exit "${TSERVER_NULL_SKIP_RC}"
 fi
@@ -22,1=
1 +22,10 @@
 # make sure we have permissions to run ifconfig/route from Ope=
nVPN
 # can't use "id -u" here - doesn't work on Solaris
 ID=3D$(id)
-if ex=
pr "$ID" : "uid=3D0" >/dev/null
-then :
+if expr "$ID" : "uid=3D0" >/dev/nu=
ll; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if =
[ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we have a valid kerbero=
s ticket
         if klist -l 1>/dev/null 2>/dev/null; then
             RU=
N_SUDO=3D"ksu -q -e"
@@ -37,26 +36,24 @@
         fi
     fi
 
-    if [ -z=
 "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "${=
0}: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E " >&2
         e=
cho "      must be set correctly in 't_server_null=2Erc'=2E SKIP=2E" >&2
  =
       exit "${TSERVER_NULL_SKIP_RC}"
     else
-	# Run a no-op command wit=
h privilege escalation (e=2Eg=2E sudo) so that
-	# we (hopefully) do not ha=
ve to ask the users password during the test=2E
-	if $RUN_SUDO "${KILL_EXEC=
}" -0 $$
-	then
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=
=2E"
-	else
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=
=2E SKIP=2E" >&2
-	    exit "${TSERVER_NULL_SKIP_RC}"
-	fi
+        # Run a=
 no-op command with privilege escalation (e=2Eg=2E sudo) so that
+        #=
 we (hopefully) do not have to ask the users password during the test=2E
+ =
       if $RUN_SUDO "${KILL_EXEC}" -0 $$; then
+            echo "${0}: $RU=
N_SUDO $KILL_EXEC -0 succeeded, good=2E"
+        else
+            echo "$=
{0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+        =
    exit "${TSERVER_NULL_SKIP_RC}"
+        fi
     fi
 fi
 
 srcdir=3D"${s=
rcdir:-=2E}"
-export t_server_null_logdir=3Dt_server_null-`hostname`-`date =
+%Y%m%d-%H%M%S`
+export t_server_null_logdir=3Dt_server_null-$(hostname)-$(=
date +%Y%m%d-%H%M%S)
 
 # Create directory for server and client logs
 mkdi=
r $t_server_null_logdir
diff --git a/tests/t_server_null_client=2Esh b/test=
s/t_server_null_client=2Esh
index 1745de5=2E=2E3203cc2 100755
--- a/tests/t=
_server_null_client=2Esh
+++ b/tests/t_server_null_client=2Esh
@@ -1,9 +1,1=
0 @@
 #!/bin/sh
 
-should_run_test() {
+should_run_test()
+{
     test_name=
=3D"$1"
 
-    if echo "$test_name"|grep -q _lwip; then
+    if echo "$test=
_name" | grep -q _lwip; then
         if [ "$has_lwipovpn" =3D "no" ]; then=

             return 1
         fi
@@ -12,7 +13,8 @@
     return 0
 }
 
-la=
unch_client() {
+launch_client()
+{
     test_name=3D$1
     log=3D"${test_=
name}=2Elog"
     pid=3D"${test_name}=2Epid"
@@ -30,7 +32,8 @@
         --l=
og "${t_server_null_logdir}/${log}" &
 }
 
-ping_and_kill() {
+ping_and_kil=
l()
+{
     if fping -q -c 5 $1; then
         echo "PASS: fping lwipovpn c=
lient $target"
     else
@@ -46,9 +49,10 @@
     kill -15 $2
 }
 
-ping_lwi=
p_clients() {
+ping_lwip_clients()
+{
     if [ "$has_lwipovpn" =3D "yes" ]=
; then
-        lwip_client_count=3D$(echo "$lwip_test_names"|wc -w|tr -d "=
 ")
+        lwip_client_count=3D$(echo "$lwip_test_names" | wc -w | tr -d =
" ")
     else
         lwip_client_count=3D0
     fi
@@ -60,10 +64,10 @@
 =
    count=3D0
     maxcount=3D10
     while [ $count -le $maxcount ]; do
- =
       lwip_client_ips=3D$(cat =2E/*=2Elwip 2>/dev/null|wc -l)
+        lwi=
p_client_ips=3D$(cat =2E/*=2Elwip 2>/dev/null | wc -l)
         if [ $lwip_=
client_ips -lt $lwip_client_count ]; then
             echo "Waiting for LW=
IP clients to start up ($count/$maxcount)"
-            count=3D$(( count +=
 1))
+            count=3D$((count + 1))
             sleep 1
         else=

             echo "$lwip_client_ips/$lwip_client_count LWIP clients up"
@@=
 -73,8 +77,8 @@
 
     wait_pids=3D""
     for line in $(cat =2E/*=2Elwip 2=
>/dev/null); do
-        target_ip=3D$(echo $line|cut -d "," -f 1)
-       =
 client_pid=3D$(echo $line|cut -d "," -f 2)
+        target_ip=3D$(echo $li=
ne | cut -d "," -f 1)
+        client_pid=3D$(echo $line | cut -d "," -f 2)=

         ping_and_kill $target_ip $client_pid &
         wait_pids=3D"$wai=
t_pids $!"
     done
@@ -84,7 +88,8 @@
     test -e =2E/lwip_failed && retu=
rn 1 || return 0
 }
 
-wait_for_results() {
+wait_for_results()
+{
     tes=
ts_running=3D"yes"
 
     # Wait a bit to allow an OpenVPN client process t=
o create a pidfile to
@@ -106,12 +111,13 @@
     done
 }
 
-get_client_test=
_result() {
+get_client_test_result()
+{
     test_name=3D$1
     should_pa=
ss=3D$2
     log=3D"${test_name}=2Elog"
 
-    grep "Initialization Sequenc=
e Completed" "${t_server_null_logdir}/${log}" > /dev/null
+    grep "Initia=
lization Sequence Completed" "${t_server_null_logdir}/${log}" >/dev/null
  =
   exit_code=3D$?
 
     if [ $exit_code -eq 0 ] && [ "${should_pass}" =3D =
"yes" ]; then
@@ -144,7 +150,7 @@
 server_max_wait=3D15
 while [ $count -lt=
 $server_max_wait ]; do
     servers_up=3D0
-    server_count=3D$(echo "$TE=
ST_SERVER_LIST"|wc -w|tr -d " ")
+    server_count=3D$(echo "$TEST_SERVER_L=
IST" | wc -w | tr -d " ")
 
     # We need to trim single-quotes because so=
me shells return quoted values
     # and some don't=2E Using "set -o posix=
" which would resolve this problem is
@@ -152,13 +158,13 @@
     #
     # W=
hile inactive server configurations may get checked they won't increase
   =
  # the active server count as the processes won't be running=2E
-    for i=
 in $(set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"); do
-        =
server_pid=3D$(cat "$i=2Epid" 2> /dev/null)
-        if [ -z "$server_pid" =
] ; then
+    for i in $(set | grep 'SERVER_NAME_' | cut -d "=3D" -f 2 | tr=
 -d "[\']"); do
+        server_pid=3D$(cat "$i=2Epid" 2>/dev/null)
+      =
  if [ -z "$server_pid" ]; then
             continue
         fi
-        =
if $RUN_SUDO kill -0 $server_pid > /dev/null 2>&1; then
-            server=
s_up=3D$(( $servers_up + 1 ))
+        if $RUN_SUDO kill -0 $server_pid >/d=
ev/null 2>&1; then
+            servers_up=3D$(($servers_up + 1))
         =
fi
     done
 
@@ -168,7 +174,7 @@
         retval=3D0
         break
     =
else
-        count=3D$(( count + 1))
+        count=3D$((count + 1))
     =
    sleep 1
     fi
 
@@ -199,15 +205,14 @@
 # safe to check the test resul=
ts=2E
 test_names=3D""
 lwip_test_names=3D""
-for SUF in $TEST_RUN_LIST
-do=

+for SUF in $TEST_RUN_LIST; do
     eval test_name=3D\"\$TEST_NAME_$SUF\"
=
     eval client_exec=3D\"\$CLIENT_EXEC_$SUF\"
     eval client_conf=3D\"\$=
CLIENT_CONF_$SUF\"
 
     test_names=3D"${test_names} ${test_name}"
 
-    =
if echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | grep -=
q _lwip; then
         lwip_test_names=3D"${lwip_test_names} ${test_name}"
=
     fi
 
@@ -219,13 +224,11 @@
 ping_lwip_clients
 retval=3D$?
 
-
 # Wait=
 until all OpenVPN clients have exited
 (wait_for_results)
 
 # Check test =
results
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     =
eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval should_pass=3D\"\$SHOULD_PA=
SS_$SUF\"
 
diff --git a/tests/t_server_null_server=2Esh b/tests/t_server_n=
ull_server=2Esh
index e1775f0=2E=2Ea8d7268 100755
--- a/tests/t_server_null=
_server=2Esh
+++ b/tests/t_server_null_server=2Esh
@@ -1,6 +1,7 @@
 #!/bin/=
sh
 
-launch_server() {
+launch_server()
+{
     server_name=3D$1
     serv=
er_exec=3D$2
     server_conf=3D$3
@@ -17,10 +18,10 @@
 
     # Try to laun=
ch the server
     $RUN_SUDO "${server_exec}" \
-               $server_con=
f \
-               --status "${status}" 1 \
-               --writepid "${=
pid}" \
-               --explicit-exit-notify 3 > "$log" 2>&1 &
+        $=
server_conf \
+        --status "${status}" 1 \
+        --writepid "${pid}=
" \
+        --explicit-exit-notify 3 >"$log" 2>&1 &
 
     sleep 1
 
@@ -4=
4,8 +45,7 @@
 retval=3D0
 
 # Launch test servers
-for SUF in $TEST_SERVER_=
LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=3D\"\$SERV=
ER_NAME_$SUF\"
     eval server_exec=3D\"\$SERVER_EXEC_$SUF\"
     eval ser=
ver_conf=3D\"\$SERVER_CONF_$SUF\"
@@ -57,8 +57,7 @@
 # the test run=2E
 #
 =
export server_pid_files=3D""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in =
$TEST_SERVER_LIST; do
     eval server_name=3D\"\$SERVER_NAME_$SUF\"
     s=
erver_pid_files=3D"${server_pid_files} =2E/${server_name}=2Epid"
 done
@@ -=
69,12 +68,11 @@
 count=3D0
 maxcount=3D4
 while [ $count -le $maxcount ]; d=
o
-    if ls t_server_null_client=2Esh*=2Epid > /dev/null 2>&1
-    then
+ =
   if ls t_server_null_client=2Esh*=2Epid >/dev/null 2>&1; then
         co=
unt=3D0
         sleep 1
     else
-	count=3D$(( count + 1))
+        count=
=3D$((count + 1))
         sleep 1
     fi
 done
@@ -85,11 +83,10 @@
 # ser=
ver process does not exit in 15 seconds assume it never will, move on and
 =
# hope for the best=2E
 echo "Waiting for servers to exit"
-for PID_FILE in=
 $server_pid_files
-do
+for PID_FILE in $server_pid_files; do
     SERVER_P=
ID=3D$(cat "${PID_FILE}")
 
-    if [ -z "$SERVER_PID" ] ; then
+    if [ -=
z "$SERVER_PID" ]; then
         echo "WARNING: could not kill server ${PID=
_FILE}!"
         continue
     fi
@@ -99,17 +96,16 @@
 
     count=3D0
   =
  maxcount=3D75
-    while [ $count -le $maxcount ]
-    do
-        $RUN_S=
UDO kill -0 "${SERVER_PID}" 2> /dev/null || break
-        count=3D$(( coun=
t + 1))
+    while [ $count -le $maxcount ]; do
+        $RUN_SUDO kill -0 =
"${SERVER_PID}" 2>/dev/null || break
+        count=3D$((count + 1))
      =
   sleep 0=2E2
     done
 
     # If server is still up send a SIGKILL
    =
 if [ $count -ge $maxcount ]; then
         $RUN_SUDO $KILL_EXEC -9 "${SERV=
ER_PID}"
-        SERVER_NAME=3D$(basename $PID_FILE|cut -d =2E -f 1)
+    =
    SERVER_NAME=3D$(basename $PID_FILE | cut -d =2E -f 1)
         echo "ER=
ROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!"
=
         echo "Tail of server log:"
         tail -n 20 "${t_server_null_lo=
gdir}/${SERVER_NAME}=2Elog"
diff --git a/tests/t_server_null_stress=2Esh b/=
tests/t_server_null_stress=2Esh
index 0bb9452=2E=2E2fc9fde 100755
--- a/tes=
ts/t_server_null_stress=2Esh
+++ b/tests/t_server_null_stress=2Esh
@@ -7,8 =
+7,7 @@
 =2E =2E/t_server_null_default=2Erc
 
 export pid_files=3D""
-for S=
UF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval ser=
ver_name=3D\"\$SERVER_NAME_$SUF\"
     pid_files=3D"${pid_files} =2E/${serv=
er_name}=2Epid"
 done
@@ -18,16 +17,16 @@
 
 count=3D0
 while [ $count -lt =
$ITERATIONS ]; do
-    count=3D$(( count + 1 ))
-    make check TESTS=3Dt_s=
erver_null=2Esh SUBDIRS=3D > /dev/null 2>&1
+    count=3D$((count + 1))
+  =
  make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D >/dev/null 2>&1
     ret=
val=3D$?
 
-    echo "Iteration ${count}: return value ${retval}" >> "${LOG=
_BASEDIR}/make-check=2Elog"
+    echo "Iteration ${count}: return value ${r=
etval}" >>"${LOG_BASEDIR}/make-check=2Elog"
     if [ $retval -ne 0 ]; then=

-	DIR=3D"${LOG_BASEDIR}/make-check-${count}"
+        DIR=3D"${LOG_BASEDIR=
}/make-check-${count}"
         mkdir -p "${DIR}"
         cp t_server_null=
*=2Elog "${DIR}/"
         cp test-suite=2Elog "${DIR}/"
-        ps aux|gr=
ep openvpn|grep -vE '(suppress|grep)' > "${DIR}/psaux"
+        ps aux | gr=
ep openvpn | grep -vE '(suppress|grep)' >"${DIR}/psaux"
     fi
 done
diff =
--git a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh
ind=
ex 96e3826=2E=2E777a286 100755
--- a/tests/update_t_client_ips=2Esh
+++ b/t=
ests/update_t_client_ips=2Esh
@@ -5,12 +5,12 @@
 
 RC=3D"$TOP_BUILDDIR/t_cl=
ient_ips=2Erc"
 
-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1
+g=
rep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then=

-    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $RC
+    echo "=
EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >>$RC
 fi
 
-grep EXPECT_IFCON=
FIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG6_$TESTNUM=3D $R=
C >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG6_$TESTN=
UM=3D$ifconfig_ipv6_local" >> $RC
+    echo "EXPECT_IFCONFIG6_$TESTNUM=3D$i=
fconfig_ipv6_local" >>$RC
 fi

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Gerrit-Change-Number: 1=
793
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--4ZVEBaXR6wo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1793?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Reformat all shell-scripts with shfmt<br><=
br>According to =2E/dev-tools/reformat-shell=2Esh=2E<br><br>Change-Id: I76c=
d38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
93<br>Message-Id: &lt;20260820091539=2E4592-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38547=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M dev-tools/git-pre-commit-format=2Esh<br>M dev-tools/=
run-cppcheck=2Esh<br>M dev-tools/update-copyright=2Esh<br>M tests/lwip_clie=
nt_up=2Esh<br>M tests/null_client_up=2Esh<br>M tests/t_client=2Esh=2Ein<br>=
M tests/t_cltsrv=2Esh<br>M tests/t_lpback=2Esh<br>M tests/t_net=2Esh<br>M t=
ests/t_server_null=2Esh<br>M tests/t_server_null_client=2Esh<br>M tests/t_s=
erver_null_server=2Esh<br>M tests/t_server_null_stress=2Esh<br>M tests/upda=
te_t_client_ips=2Esh<br>14 files changed, 386 insertions(+), 385 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/dev-tools/git-pre-commit-format=2Esh b/dev=
-tools/git-pre-commit-format=2Esh</span><br><span>index 9b2ecaf=2E=2E350728=
9 100755</span><br><span>--- a/dev-tools/git-pre-commit-format=2Esh</span><=
br><span>+++ b/dev-tools/git-pre-commit-format=2Esh</span><br><span>@@ -26,=
7 +26,6 @@</span><br><span> # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) A=
RISING IN ANY WAY OUT OF THE USE</span><br><span> # OF THIS SOFTWARE, EVEN =
IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # git pre-com=
mit hook that runs a stylecheck=2E</span><br><span> # Features:</span><br><=
span> #  - abort commit when commit does not comply with the style guidelin=
es</span><br><span>@@ -43,12 +42,11 @@</span><br><span> # exit on error</sp=
an><br><span> set -e</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> # If called so, install this script as p=
re-commit hook</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &q=
uot;$1&quot; =3D &quot;install&quot; ] ; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if [ &quot;$1&quot; =3D &quot;install&quot; ]; th=
en</span><br><span>     TARGET=3D&quot;$(git rev-parse --git-path hooks)/pr=
e-commit&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if [ -e &quot;$TARGET&quot; ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -e &quot;$TARGET&quot; ]; then</=
span><br><span>         printf &quot;$TARGET file exists=2E Won&#39;t overw=
rite=2E\n&quot;</span><br><span>         printf &quot;Aborting installation=
=2E\n&quot;</span><br><span>         exit 1</span><br><span>@@ -62,18 +60,1=
9 @@</span><br><span> fi</span><br><span> </span><br><span> # check whether=
 the given file matches any of the set extensions</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-matches_extension() {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+matches_extension()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span>     local filename=3D&quot=
;$(basename -- &quot;$1&quot;)&quot;</span><br><span>     local extension=
=3D&quot;=2E${filename##*=2E}&quot;</span><br><span>     local ext</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for ext =
in =2Ec =2Eh ; do [ &quot;$ext&quot; =3D &quot;$extension&quot; ] &amp;&amp=
; return 0; done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for ext in =2Ec =2Eh; do [ &quot;$ext&quot; =3D &quot;$extension&quot; ] &=
amp;&amp; return 0; done</span><br><span> </span><br><span>     return 1</s=
pan><br><span> }</span><br><span> </span><br><span> # necessary check for i=
nitial commit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if git r=
ev-parse --verify HEAD &gt;/dev/null 2&gt;&amp;1 ; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+if git rev-parse --verify HEAD &gt;/dev=
/null 2&gt;&amp;1; then</span><br><span>     against=3DHEAD</span><br><span=
> else</span><br><span>     # Initial commit: diff against an empty tree ob=
ject</span><br><span>@@ -88,8 +87,8 @@</span><br><span> </span><br><span>  =
   # Allow to use in parallel with pre-commit</span><br><span>     if [ $(b=
asename &quot;$0&quot;) =3D &quot;pre-commit=2Elegacy&quot; ]; then</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-       echo &quot;Skipping cl=
ang-format check in favor of pre-commit&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-       exit 0</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        echo &quot;Skipping clang-format check in favor o=
f pre-commit&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       exit 0</span><br><span>     fi</span><br><span> else</span><br><span=
>     TOOL=3Duncrustify</span><br><span>@@ -98,7 +97,7 @@</span><br><span> =
    TOOL_CMD=3D&quot;$TOOL_BIN -q -l C -c $UNCRUST_CONFIG&quot;</span><br><=
span> </span><br><span>     # make sure the config file is correctly set</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ ! -f &quot;$UNC=
RUST_CONFIG&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if [ ! -f &quot;$UNCRUST_CONFIG&quot; ]; then</span><br><span>  =
       printf &quot;Error: uncrustify config file not found=2E\n&quot;</spa=
n><br><span>         printf &quot;Expected to find it at $UNCRUST_CONFIG=2E=
\n&quot;</span><br><span>         printf &quot;Aborting commit=2E\n&quot;</=
span><br><span>@@ -106,7 +105,7 @@</span><br><span>     fi</span><br><span>=
 fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
if [ -z &quot;$TOOL_BIN&quot; ] ; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if [ -z &quot;$TOOL_BIN&quot; ]; then</span><br><span>  =
   printf &quot;Error: $TOOL executable not found=2E\n&quot;</span><br><spa=
n>     printf &quot;Is it installed and in your \$PATH?\n&quot;</span><br><=
span>     printf &quot;Aborting commit=2E\n&quot;</span><br><span>@@ -120,4=
4 +119,43 @@</span><br><span> # create one patch containing all changes to =
the files</span><br><span> # sed to remove quotes around the filename, if i=
nserted by the system</span><br><span> # (done sometimes, if the filename c=
ontains special characters, like the quote itself)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-git diff-index --cached --diff-filter=3DACMR -=
-name-only $against -- | \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-sed -e &#39;s/^&quot;\(=2E*\)&quot;$/\1/&#39; | \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-while read file</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    # ignore file if we do check for file extensions and the file</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # does not match th=
e extensions =2Ec or =2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ! matches_extension &quot;$file&quot;; then</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        continue;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+git diff-index --cached --diff-filter=3DACMR --name-only $a=
gainst -- |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed =
-e &#39;s/^&quot;\(=2E*\)&quot;$/\1/&#39; |</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while read file; do</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # ignore file if we do check for file e=
xtensions and the file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        # does not match the extensions =2Ec or =2Eh</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if ! matches_extension &quot;$f=
ile&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    # escape special characters in the target filename:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    # phase 1 (characters escaped in =
the output diff):</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
#     - &#39;\&#39;: backslash needs to be escaped in the output diff</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;&quot;&#39=
;: quote needs to be escaped in the output diff if present inside</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    #            of the filenam=
e, as it used to bracket the entire filename part</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    # phase 2 (characters escaped in the match =
replacement):</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #   =
  - &#39;\&#39;: backslash needs to be escaped again for sed itself</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    #            (i=2Ee=2E do=
uble escaping after phase 1)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    #     - &#39;&amp;&#39;: would expand to matched string</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;|&#39;: used =
as sed split char instead of &#39;/&#39;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    # printf %s particularly important if the filename c=
ontains the % character</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    file_escaped_target=3D$(printf &quot;%s&quot; &quot;$file&quot; | sed=
 -e &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # escape specia=
l characters in the target filename:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # phase 1 (characters escaped in the output diff):=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     - &#3=
9;\&#39;: backslash needs to be escaped in the output diff</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        #     - &#39;&quot;&#39;: qu=
ote needs to be escaped in the output diff if present inside</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        #            of the filena=
me, as it used to bracket the entire filename part</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        # phase 2 (characters escaped in the=
 match replacement):</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        #     - &#39;\&#39;: backslash needs to be escaped again for sed i=
tself</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     =
       (i=2Ee=2E double escaping after phase 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        #     - &#39;&amp;&#39;: would expand t=
o matched string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     #     - &#39;|&#39;: used as sed split char instead of &#39;/&#39;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # printf %s par=
ticularly important if the filename contains the % character</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        file_escaped_target=3D$(pr=
intf &quot;%s&quot; &quot;$file&quot; | sed -e &#39;s/[\&quot;]/\\&amp;/g&#=
39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    # uncrustify our sourcefile, create=
 a patch with diff and append it to our $patch</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    # The sed call is necessary to transform the p=
atch from</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #    ---=
 - timestamp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #    =
+++ $tmpout timestamp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    # to both lines working on the same file and having a a/ and b/ prefix=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Else it can =
not be applied with &#39;git apply&#39;=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    git show &quot;:$file&quot; | $TOOL_CMD &gt; &quot=
;$tmpout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    git=
 show &quot;:$file&quot; | diff -u -- - &quot;$tmpout&quot; | \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        sed -e &quot;1s|--- -|---=
 \&quot;b/$file_escaped_target\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ \&=
quot;a/$file_escaped_target\&quot;|&quot; &gt;&gt; &quot;$patch&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # uncrustify our sourcefile, crea=
te a patch with diff and append it to our $patch</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # The sed call is necessary to transfo=
rm the patch from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      #    --- - timestamp</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        #    +++ $tmpout timestamp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        # to both lines working on the same file and =
having a a/ and b/ prefix=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # Else it can not be applied with &#39;git apply&#39;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        git show &quo=
t;:$file&quot; | $TOOL_CMD &gt;&quot;$tmpout&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        git show &quot;:$file&quot; | diff -=
u -- - &quot;$tmpout&quot; |</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            sed -e &quot;1s|--- -|--- \&quot;b/$file_escaped_targe=
t\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_escaped_target\&=
quot;|&quot; &gt;&gt;&quot;$patch&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    done</span><br><span> </span><br><span> rm -f &quot=
;$tmpout&quot;</span><br><span> </span><br><span> # if no patch has been ge=
nerated all is ok, clean up the file stub and exit</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-if [ ! -s &quot;$patch&quot; ] ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -s &quot;$patch&quot;=
 ]; then</span><br><span>     rm -f &quot;$patch&quot;</span><br><span>    =
 exit 0</span><br><span> fi</span><br><span>@@ -165,7 +163,7 @@</span><br><=
span> # a patch has been created, notify the user and exit</span><br><span>=
 printf &quot;Formatting of some code does not follow the project guideline=
s=2E\n&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-if [ $(wc -l &lt; $patch) -gt 80 ] ; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+if [ $(wc -l &lt;$patch) -gt 80 ]; then</spa=
n><br><span>     printf &quot;The file $patch contains the necessary fixes=
=2E\n&quot;</span><br><span> else</span><br><span>     printf &quot;Here&#3=
9;s the patch that fixes the formatting:\n\n&quot;</span><br><span>diff --g=
it a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><s=
pan>index 40db33e=2E=2Ea7aa3c4 100755</span><br><span>--- a/dev-tools/run-c=
ppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><s=
pan>@@ -20,24 +20,23 @@</span><br><span>  --check-level=3Dexhaustive --max-=
configs=3D10 \</span><br><span>  --error-exitcode=3D1&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
et -x</span><br><span> </span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot;=
</span><br><span> cd &quot;${SOURCE_DIR}&quot;</span><br><span> cppcheck $C=
OMMON_ARGS $INCLUDE_FLAGS \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         --platform=3Dunix64 \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --lib=
rary=3Dgnu=2Ecfg \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
      -U_WIN32 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         tests/unit_tests/example_test/ tes=
ts/unit_tests/openvpn/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         tests/unit_tests/plugins/</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    --platform=3Dunix64 \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg -=
-library=3Dgnu=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    -U_WIN32 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tests/unit_tests/example_test/ tests/unit=
_tests/openvpn/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  tests/unit_tests/plugins/</span><br><span> cppcheck $COMMON_ARGS \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         --platform=3Dwin64 =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --library=
=3Dwindows=2Ecfg \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
      -D_WIN32 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         -UTARGET_DARWIN -=
UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         -UTARGET_AIX \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         src/openvpn* src/compat/ \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         tests/unit_tests/e=
xample_test/ tests/unit_tests/openvpn*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    --platform=3Dwin64 \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    --library=3Dwindows=2Ecfg \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32 \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET=
_OPENBSD -UTARGET_NETBSD \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGO=
NFLY \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_=
AIX \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n* src/compat/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 tests/unit_tests/example_test/ tests/unit_tests/openvpn*</span><br><span>d=
iff --git a/dev-tools/update-copyright=2Esh b/dev-tools/update-copyright=2E=
sh</span><br><span>index 96546dd=2E=2E7ca6002 100755</span><br><span>--- a/=
dev-tools/update-copyright=2Esh</span><br><span>+++ b/dev-tools/update-copy=
right=2Esh</span><br><span>@@ -34,8 +34,7 @@</span><br><span> COPY_YEAR=3D&=
quot;$1&quot;</span><br><span> </span><br><span> cd &quot;$(git rev-parse -=
-show-toplevel)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
for file in $(git ls-files | grep -v vendor/);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+for file in $(git ls-files | grep -v vendor/); do</span><br><span> =
    echo -n &quot;Updating $file =2E=2E=2E&quot;</span><br><span>     # The=
 first sed operation covers 20xx-20yy copyright lines,</span><br><span>    =
 # The second sed operation changes 20xx -&gt; 20xx-20yy</span><br><span>di=
ff --git a/tests/lwip_client_up=2Esh b/tests/lwip_client_up=2Esh</span><br>=
<span>index a6b4d24=2E=2Eb1941a4 100755</span><br><span>--- a/tests/lwip_cl=
ient_up=2Esh</span><br><span>+++ b/tests/lwip_client_up=2Esh</span><br><spa=
n>@@ -2,16 +2,17 @@</span><br><span> #</span><br><span> # Determine the Ope=
nVPN PID from its pid file=2E This works reliably even when</span><br><span=
> # the OpenVPN process is backgrounded for parallel tests=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+MY_PPID=3D$(cat $pid)</span><br><s=
pan> </span><br><span> # Add this client&#39;s VPN IP and PID to a file=2E =
This enables</span><br><span> # t_server_null_client=2Esh to kill this Open=
VPN client after fping tests have</span><br><span> # finished=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;$ifconfig_local,$MY_P=
PID&quot; &gt;&gt; =2E/$test_name=2Elwip</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+echo &quot;$ifconfig_local,$MY_PPID&quot; &gt;&gt;=2E/=
$test_name=2Elwip</span><br><span> </span><br><span> # Wait long enough to =
allow fping tests to finish=2E Also ensure that this</span><br><span> # Ope=
nVPN client is killed even if t_server_null_client=2Esh failed to do it=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-(sleep 15</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-echo &quot;ERROR: t_server_null_cl=
ient=2Esh failed to kill OpenVPN client with PID $MY_PPID in test $test_nam=
e=2E Killing it in lwip_client_up=2Esh=2E&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-kill -15 $MY_PPID</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+(</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sleep 15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   echo &quot;ERROR: t_server_null_client=2Esh failed to kill OpenVPN clien=
t with PID $MY_PPID in test $test_name=2E Killing it in lwip_client_up=2Esh=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    kill -=
15 $MY_PPID</span><br><span> ) &amp;</span><br><span>diff --git a/tests/nul=
l_client_up=2Esh b/tests/null_client_up=2Esh</span><br><span>index d4df0c6=
=2E=2Ebe339ee 100755</span><br><span>--- a/tests/null_client_up=2Esh</span>=
<br><span>+++ b/tests/null_client_up=2Esh</span><br><span>@@ -4,8 +4,11 @@<=
/span><br><span> </span><br><span> # Determine the OpenVPN PID from its pid=
 file=2E This works reliably even when</span><br><span> # the OpenVPN proce=
ss is backgrounded for parallel tests=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+MY_PPID=3D$(cat $pid)</span><br><span> </span><br><span=
> # Allow OpenVPN to finish initializing while waiting in the background an=
d then</span><br><span> # killing the process gracefully=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-(sleep 5 ; kill -15 $MY_PPID) &amp;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+(</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    sleep 5</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    kill -15 $MY_PPID</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+) &amp;</span><br><span>diff --git a/tests/t_=
client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 2f37845=
=2E=2E305441be 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span>=
<br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -19,9 +19,9 @@<=
/span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_b=
uilddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&q=
uot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_c=
lient=2Erc ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span> =
    =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]=
 ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+elif [ -r &q=
uot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span>     =2E &quot;${=
srcdir}&quot;/t_client=2Erc</span><br><span> else</span><br><span>     echo=
 &quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#39;${top_bui=
lddir}&#39;)&quot; &gt;&amp;2</span><br><span>@@ -32,37 +32,35 @@</span><br=
><span> # Check for external dependencies</span><br><span> FPING=3D&quot;fp=
ing&quot;</span><br><span> FPING6=3D&quot;fping6&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-which fping &gt; /dev/null</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+which fping &gt;/dev/null</span><br=
><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: fping is =
not available in \$PATH&quot; &gt;&amp;2</span><br><span>     exit &quot;${=
TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-which fping6 &gt; /dev/null</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+which fping6 &gt;/dev/null</span><br><span> if=
 [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: fping6 is not avail=
able in \$PATH, assuming fping 4=2E0 or later&quot; &gt;&amp;2</span><br><s=
pan>     FPING=3D&quot;fping -4&quot;</span><br><span>     FPING6=3D&quot;f=
ping -6&quot;</span><br><span> fi</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`which kill`</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=3D$(which kill)</span><br><s=
pan> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: kill not fou=
nd in \$PATH&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKI=
P_RC}&quot;</span><br><span> fi</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${openvpn}&quot; ]</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; ]; then</span><b=
r><span>     echo &quot;no (executable) openvpn binary in current build tre=
e=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     exit 1</span><br><span> =
fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
f [ ! -w =2E ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -w =2E ]; then<=
/span><br><span>     echo &quot;current directory is not writable (required=
 for logging)=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     exit 1</span=
><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-if [ -z &quot;$TEST_RUN_LIST&quot; ] ; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$TEST_RUN_LIST&quot; ]; th=
en</span><br><span>     echo &quot;TEST_RUN_LIST empty, no tests defined=2E=
  SKIP test=2E&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_S=
KIP_RC}&quot;</span><br><span> fi</span><br><span>@@ -72,16 +70,14 @@</span=
><br><span> </span><br><span> # make sure we have permissions to run ifconf=
ig/route from OpenVPN</span><br><span> # can&#39;t use &quot;id -u&quot; he=
re - doesn&#39;t work on Solaris</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-ID=3D`id`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
f expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ID=3D$(id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null;=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :</span><b=
r><span> else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [=
 &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; then</span><br><span>       =
  # Check if we have a valid kerberos ticket</span><br><span>         klist=
 -l 1&gt;/dev/null 2&gt;/dev/null</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if [ $? -ne 0 ];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if [ $? -ne 0 ]; then</span><br><span>             # No ker=
beros ticket found, skip ksu and fallback to RUN_SUDO</span><br><span>     =
        PREFER_KSU=3D0</span><br><span>             echo &quot;$0: No Kerbe=
ros ticket available=2E  Will not use ksu=2E&quot;</span><br><span>@@ -90,8=
 +86,7 @@</span><br><span>         fi</span><br><span>     fi</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot=
;$RUN_SUDO&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &q=
uot;$RUN_SUDO&quot; ]; then</span><br><span>         echo &quot;$0: this te=
st must run be as root, or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</span><br=
><span>         echo &quot;      must be set correctly in &#39;t_client=2Er=
c&#39;=2E SKIP=2E&quot; &gt;&amp;2</span><br><span>         exit &quot;${TC=
LIENT_SKIP_RC}&quot;</span><br><span>@@ -99,20 +94,19 @@</span><br><span>  =
       # We have to use sudo=2E Make sure that we (hopefully) do not have</=
span><br><span>         # to ask the users password during the test=2E This=
 is done to</span><br><span>         # prevent timing issues, e=2Eg=2E when=
 the waits for openvpn to start</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	if $RUN_SUDO $KILL_EXEC -0 $$</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC =
-0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    exit &quot;${TCLIENT_SKIP_RC}&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if $RUN_SUDO $KILL_EXEC -0 $$; t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo=
 &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$0: $RUN_SUDO $KIL=
L_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            exit &quot;${TCLIENT_SKI=
P_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fi</span><br><span>     fi</span><br><span> fi</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-LOGDIR=3Dt_client-`hostname`-`da=
te +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+L=
OGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span> LOGDIR=
_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-if mkdir $LOGDIR</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if mkdir=
 $LOGDIR; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :=
</span><br><span> else</span><br><span>     echo &quot;can&#39;t create log=
 directory &#39;$LOGDIR&#39;=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>  =
   exit 1</span><br><span>@@ -132,21 +126,28 @@</span><br><span> output_sta=
rt()</span><br><span> {</span><br><span>     case $V in</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	0) outbuf=3D&quot;&quot; ;;			# no per-t=
est output at all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	1) =
printf &quot;$@\n&quot;			# compact, details only on failure</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-           outbuf=3D&quot;\n&quot; ;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) printf &quot;\n$=
@\n&quot; ;;		# print all, with a bit formatting</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        0) outbuf=3D&quot;&quot; ;; # no per-t=
est output at all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 printf &quot;$@\n&quot; # compact, details only on failure</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            outbuf=3D&quot;\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *) printf &quot;=
\n$@\n&quot; ;; # print all, with a bit formatting</span><br><span>     esa=
c</span><br><span> }</span><br><span> </span><br><span> output()</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    END_NL=3D=
&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot;X-n&quot; ] ; then END_NL=3D=
&quot;&quot; ; shift ; fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    END_NL=3D&quot;\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ &quot;X$1&quot; =3D &quot;X-n&quot; ]; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        END_NL=3D&quot;&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        shift</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> =
    case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) ;;	=
			# no per-test output at all</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	1) outbuf=3D&quot;$outbuf$@${END_NL}&quot;	# print details only o=
n failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           ;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) printf &quot;$@$=
{END_NL}&quot; ;;	# print everything</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        0) ;; # no per-test output at all</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        1)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            outbuf=3D&quot;$outbuf$@${END_NL}=
&quot; # print details only on failure</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        *) printf &quot;$@${END_NL}&quot; ;; # print everythi=
ng</span><br><span>     esac</span><br><span> }</span><br><span> </span><br=
><span>@@ -154,62 +155,61 @@</span><br><span> fail()</span><br><span> {</sp=
an><br><span>     output &quot;FAIL: $@\n&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    fail_count=3D$(( $fail_count + 1 ))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    fail_count=3D$(($fail_cou=
nt + 1))</span><br><span> }</span><br><span> </span><br><span> # print &quo=
t;all interface IP addresses&quot; + &quot;all routes&quot;</span><br><span=
> # this is higly system dependent=2E=2E=2E</span><br><span> get_ifconfig_r=
oute()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    UNAME=3D`uname -s`</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    UNAME=3D$(uname -s)</span><br><span>     case $UNAME in</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	Linux)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><br><span>          =
   # linux / iproute2? (-&gt; if configure got a path)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if [ -n &quot;@IPROUTE@&quot; =
]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ -n &qu=
ot;@IPROUTE@&quot; ]; then</span><br><span>                 echo &quot;-- l=
inux iproute2 --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                @IPROUTE@ addr show     | grep -v valid_lft</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                @IPROUTE@ addr sho=
w | grep -v valid_lft</span><br><span>                 @IPROUTE@ route show=
</span><br><span>                 @IPROUTE@ -o -6 route show | grep -v &#39=
; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e &#39;s/ (mtu|h=
oplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar) [0-9]+ms//g&#=
39;</span><br><span>             else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	        echo &quot;-- linux / ifconfig --&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	        LANG=3DC @IFCONFIG@ -a =
|egrep  &quot;( addr:|encap:)&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	        LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                echo &quot;-- linux / ifc=
onfig --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           LANG=3DC @IFCONFIG@ -a | egrep &quot;( addr:|encap:)&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                LANG=3DC =
@NETSTAT@ -rn -4 -6</span><br><span>             fi</span><br><span>       =
      ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	FreeBSD|NetB=
SD|Darwin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &q=
uot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn=
 | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OpenBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	   echo &quot;-- OpenBSD --&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; | \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		sed -e &#39;s/pltim=
e [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print =
$1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 =
  ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SunOS)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- Solaris --&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a =
| egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6=
 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	AIX)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- AIX --&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(f=
lags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 =
  @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | NetBSD | Darwin)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- =
FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(flags=3D|inet=
)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
@NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        OpenBSD)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- OpenBSD --&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            @I=
FCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                sed -e &#39;s/pltime [0-9]*//=
&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print =
$1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   SunOS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  echo &quot;-- Solaris --&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            @NETSTAT=
@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        AIX)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            echo &quot;-- AIX --&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | e=
grep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$=
2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ;;</span><br><span>         *)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-           echo &quot;get_ifconfig_route(): no idea how to =
get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt;&amp;2</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-           exit 20</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           ;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            echo &quot;get_ifconfig_route():=
 no idea how to get info on your OS ($(uname -s))=2E  FAIL=2E&quot; &gt;&am=
p;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit=
 20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</=
span><br><span>     esac</span><br><span> </span><br><span>     # another r=
ound of per-platform information gathering, for DNS info</span><br><span>  =
   # for most of the platforms &quot;cat /etc/resolv=2Econf&quot; is good e=
nough</span><br><span>     # except Linux and MacOS</span><br><span>     ca=
se $UNAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Linux)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if [ -x /us=
r/bin/resolvectl -a -d /run/systemd/system ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if [ -x /usr/bin/resolvectl -a -d =
/run/systemd/system ]; then</span><br><span>                 echo &quot;-- =
linux resolvectl --&quot;</span><br><span>                 resolvectl statu=
s</span><br><span>             else</span><br><span>@@ -217,7 +217,7 @@</sp=
an><br><span>                 cat /etc/resolv=2Econf</span><br><span>      =
       fi</span><br><span>             ;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	Darwin)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        Darwin)</span><br><span>             echo &quot;-- MacOS s=
cutil --dns&quot;</span><br><span>             scutil --dns</span><br><span=
>             ;;</span><br><span>@@ -234,19 +234,19 @@</span><br><span> #  =
arg2: IPv4/IPv6 address that must show up in out of &quot;get_ifconfig_rout=
e&quot;</span><br><span> check_ifconfig()</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    proto=3D$1 ; shift</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    shift</span><br><span>     expect_=
list=3D&quot;$@&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if [ -z &quot;$expect_list&quot; ] ; then return ; fi=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$expec=
t_list&quot; =3D &quot;-&quot; ] ; then return ; fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$expect_list&quot; ]; t=
hen return; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f [ &quot;$expect_list&quot; =3D &quot;-&quot; ]; then return; fi</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for expec=
t in $expect_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if get_ifconfig_ro=
ute | fgrep &quot;$expect&quot; &gt;/dev/null</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	then :</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    f=
ail &quot;check_ifconfig(): expected IPv$proto address &#39;$expect&#39; no=
t found in ifconfig output=2E&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for expect in $expect_list; do</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if get_ifconfig_route | fgrep &quot;$expect&quot; &gt;=
/dev/null; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fail =
&quot;check_ifconfig(): expected IPv$proto address &#39;$expect&#39; not fo=
und in ifconfig output=2E&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        fi</span><br><span>     done</span><br><span> }</span><=
br><span> </span><br><span>@@ -257,47 +257,48 @@</span><br><span> #  arg3=
=2E=2E=2E -&gt; fping arguments (host list)</span><br><span> run_ping_tests=
()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    proto=3D$1 ; want=3D$2 ; shift ; shift</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    want=3D$2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    shift</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    shift</span><br><span>     targetlist=3D&quot;$@&quot;</span><br><spa=
n> </span><br><span>     # &quot;no targets&quot; is fine</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$targetlist&quot; ] ;=
 then return ; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if [ -z &quot;$targetlist&quot; ]; then return; fi</span><br><span> </spa=
n><br><span>     case $proto in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	*) echo &quot;internal error in run_ping_t=
ests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	   exit 1 ;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        4) cmd=3D&quot;$FPING&quot; ;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        6) cmd=3D&quot;$FPING6&quot; ;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;inte=
rnal error in run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><=
span>     esac</span><br><span> </span><br><span>     case $want in</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	want_ok)   sizes_list=3D&quo=
t;64 1440 3000&quot; ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        want_ok) sizes_list=3D&quot;64 1440 3000&q=
uot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        want=
_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span>     esac</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for bytes i=
n $sizes_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;run IPv$p=
roto ping tests ($want), $bytes byte packets=2E=2E=2E&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for bytes in $sizes_list; do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;r=
un IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo &quot=
;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist&quot; &gt;&gt;$LOGD=
IR/$SUF:fping=2Eout</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$=
cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist &gt;&gt;$LOGDIR/$SUF:=
fping=2Eout 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetli=
st&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        $cmd -b $bytes -C 20 -p 250 -q $fping_args $t=
argetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	# while OpenVPN is runn=
ing, pings must succeed (want=3D&#39;want_ok&#39;)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	# before OpenVPN is up, pings must NOT succee=
d (want=3D&#39;want_fail&#39;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        # while OpenVPN is running, pings must succeed (want=3D&=
#39;want_ok&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      # before OpenVPN is up, pings must NOT succeed (want=3D&#39;want_fail=
&#39;)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if [ $rc =
=3D 0 ] 				# all ping OK</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    if [ $w=
ant =3D &quot;want_fail&quot; ]		# not what we want</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test succeeded, but needs t=
o *fail*=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
 fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else					# ping f=
ailed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    if [ $want =
=3D &quot;want_ok&quot; ]		# not what we wanted</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	    then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-		fail &quot;IPv$proto ping test ($bytes bytes) failed, but s=
hould succeed=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        rc=3D$?</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if [ $rc =3D 0 ]; then   =
              # all ping OK</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if [ $want =3D &quot;want_fail&quot; ]; then # not what=
 we want</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     fail &quot;IPv$proto ping test succeeded, but needs to *fail*=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else            =
                   # ping failed</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if [ $want =3D &quot;want_ok&quot; ]; then # not w=
hat we wanted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          fail &quot;IPv$proto ping test ($bytes bytes) failed, but should =
succeed=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fi</span><br><span>     done</span><br><span> }</span><br><span> </span><br=
><span>@@ -308,8 +309,7 @@</span><br><span> SUMMARY_SKIP=3D</span><br><span=
> SUMMARY_FAIL=3D</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+for SUF in $TEST_RUN_LIST; do</span><br><span>     # get config variables<=
/span><br><span>     eval test_prep=3D\&quot;\$PREPARE_$SUF\&quot;</span><b=
r><span>     eval test_check_skip=3D\&quot;\$CHECK_SKIP_$SUF\&quot;</span><=
br><span>@@ -336,11 +336,13 @@</span><br><span> </span><br><span>     if [ =
-n &quot;$test_check_skip&quot; ]; then</span><br><span>         output &qu=
ot;check whether we need to skip: &#39;$test_check_skip&#39;&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if eval $test_check_sk=
ip; then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f eval $test_check_skip; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            :</span><br><span>         else</span><br><span>     =
        output &quot;skip check failed, SKIP test $SUF=2E&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	    SUMMARY_SKIP=3D&quot;$SUMMAR=
Y_SKIP $SUF&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
 printf &quot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf=
 &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            continue</span><br><span>         fi</span><br><span>     fi</=
span><br><span> </span><br><span>@@ -355,13 +357,14 @@</span><br><span>    =
 output &quot;\nrun pre-openvpn ping tests - targets must not be reachable=
=2E=2E=2E&quot;</span><br><span>     run_ping_tests 4 want_fail &quot;$ping=
4_hosts&quot;</span><br><span>     run_ping_tests 6 want_fail &quot;$ping6_=
hosts&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &=
quot;$fail_count&quot; =3D 0 ] ; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ]; then</span><br>=
<span>         output &quot;OK=2E\n&quot;</span><br><span>     else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;make sure that pi=
ng hosts are ONLY reachable via VPN, SKIP test $SUF=2E&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL =
$SUF&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exit_code=
=3D31</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	printf &quot;$o=
utbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        fail &quot;make sure that ping hosts are ONLY reachable via VPN,=
 SKIP test $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        exit_code=3D31</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        continue</=
span><br><span>     fi</span><br><span> </span><br><span>     pidfile=3D&qu=
ot;$LOGDIR_ABS/openvpn-$SUF=2Epid&quot;</span><br><span>@@ -376,18 +379,17 =
@@</span><br><span>     # to $ovpn_init_check times=2E</span><br><span>    =
 ovpn_init_check=3D30</span><br><span>     ovpn_init_success=3D0</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    while [ $ovpn_init_check -gt=
 0 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-       sleep 1  # Wait for Open=
VPN to initialize and have had time to write the pid file</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-       grep &quot;Initialization Sequen=
ce Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-       if [ $? -eq 0 ]; then</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_check=3D0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_=
success=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       fi<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-       ovpn_init_check=
=3D$(( $ovpn_init_check - 1 ))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    while [ $ovpn_init_check -gt 0 ]; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sleep 1 # Wait for OpenVPN to ini=
tialize and have had time to write the pid file</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        grep &quot;Initialization Sequence Comp=
leted&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ $? -eq 0 ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ovpn_init_check=3D0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ovpn_in=
it_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ovpn_i=
nit_check=3D$(($ovpn_init_check - 1))</span><br><span>     done</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opid=3D`cat=
 $pidfile`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opid=
=3D$(cat $pidfile)</span><br><span>     if [ -n &quot;$opid&quot; ]; then</=
span><br><span>         output &quot;  OpenVPN running with PID $opid&quot;=
</span><br><span>     else</span><br><span>@@ -398,16 +400,17 @@</span><br>=
<span>     if [ $ovpn_init_success -ne 1 -o -z &quot;$opid&quot; ]; then</s=
pan><br><span>         output &quot;$0:  OpenVPN did not initialize in a re=
asonable time&quot;</span><br><span>         if [ -n &quot;$opid&quot; ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           $RUN_SU=
DO $KILL_EXEC $opid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            $RUN_SUDO $KILL_EXEC $opid</span><br><span>         fi</span><b=
r><span>         $RUN_SUDO $KILL_EXEC $sudopid</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	output &quot;tail -5 $SUF:openvpn=2Elog&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;`tail -5 $L=
OGDIR/$SUF:openvpn=2Elog`&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	fail &quot;skip rest of sub-tests for test run $SUF=2E&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	trap - 0 1 2 3 15</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMA=
RY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	ex=
it_code=3D30</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	printf &=
quot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;$(tail -5 =
$LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        fail &quot;skip rest of sub-tests for test run $SUF=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tr=
ap - 0 1 2 3 15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        exit_code=3D30</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        continue</span><br=
><span>     fi</span><br><span> </span><br><span>     # make sure openvpn c=
lient is terminated in case shell exits</span><br><span>@@ -418,17 +421,16 =
@@</span><br><span>     output &quot;save ifconfig+route&quot;</span><br><s=
pan>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quo=
t;$expect_ifconfig4&quot; =3D &quot;-&quot; ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$expect_ifconfig4&quot; =
=3D &quot;-&quot; ]; then</span><br><span>         output &quot;skip ifconf=
ig+route check&quot;</span><br><span>     else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	output -n &quot;compare pre-openvpn ifconfig+rout=
e with current values=2E=2E=2E&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-		$LOGDIR/$SUF:ifconfig_route=2Et=
xt &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    fail &quot;no di=
fferences between ifconfig/route before OpenVPN start and now=2E&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	    output &quot; OK!\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        output -n &quot;compare pre-openvpn ifcon=
fig+route with current values=2E=2E=2E&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if diff $LOGDIR/$SUF:ifconfig_route_pre=2E=
txt \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            $L=
OGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fail &quot;no differences bet=
ween ifconfig/route before OpenVPN start and now=2E&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            output &quot; OK!\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span=
>     fi</span><br><span> </span><br><span>     # post init script needed?<=
/span><br><span>@@ -449,8 +451,8 @@</span><br><span>     $RUN_SUDO $KILL_EX=
EC $opid</span><br><span>     wait $!</span><br><span>     rc=3D$?</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $rc !=3D 0 ] ; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;OpenVPN ret=
urn code $rc, expect 0&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if [ $rc !=3D 0 ]; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        fail &quot;OpenVPN return code $rc, expect 0&quot;=
</span><br><span>     fi</span><br><span> </span><br><span>     output &quo=
t;\nsave post-openvpn ifconfig + route=2E=2E=2E&quot;</span><br><span>@@ -4=
58,23 +460,22 @@</span><br><span> </span><br><span>     output -n &quot;com=
pare pre- and post-openvpn ifconfig + route=2E=2E=2E&quot;</span><br><span>=
     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    $LOGDIR/$SUF:ifconfig_route_post=2Etxt=
 &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	output &quot; OK=2E\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        $LOGDIR/$SUF:ifconfig_route_post=2Etxt &gt;$LOGDI=
R/$SUF:ifconfig_route_diff=2Etxt; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        output &quot; OK=2E\n&quot;</span><br><span>    =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;\n=
\n&quot; &quot;`cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt`&quot; &quot;\n&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;diff=
erences between pre- and post-ifconfig/route=2E&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        output &quot;\n\n&quot; &quot;$(c=
at $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)&quot; &quot;\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;differences =
between pre- and post-ifconfig/route=2E&quot;</span><br><span>     fi</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$fail_count&=
quot; =3D 0 ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if [ &quot;$fail_count&quot; =3D 0 ]; then</span><br><span>         ou=
tput &quot;test run $SUF: all tests OK=2E\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_OK=3D&qu=
ot;$SUMMARY_OK $SUF&quot;</span><br><span>     else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	if [ &quot;$V&quot; -gt 0 ] ; then</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	    printf &quot;$outbuf&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;tes=
t run $SUF: $fail_count test failures=2E FAIL=2E&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$V&quot; -gt 0 ]; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf=
 &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            echo &quot;test run $SUF: $fail_count test failures=2E FAIL=2E=
&quot;</span><br><span>         fi</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAI=
L $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 exit_code=3D30</span><br><span>     fi</span><br><span> </span><br><span> =
    if [ -n &quot;$test_cleanup&quot; ]; then</span><br><span>@@ -484,9 +48=
5,9 @@</span><br><span> </span><br><span> done</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_OK&quot; =
] ; then SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_SKIP&quot; ] ; then SUMMARY_SK=
IP=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-if [ -z &quot;$SUMMARY_FAIL&quot; ] ; then SUMMARY_FAIL=3D&quot; none&=
quot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &q=
uot;$SUMMARY_OK&quot; ]; then SUMMARY_OK=3D&quot; none&quot;; fi</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_SKIP&qu=
ot; ]; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_FAIL&quot; ]; then SUMM=
ARY_FAIL=3D&quot; none&quot;; fi</span><br><span> echo &quot;Test sets succ=
eeded:$SUMMARY_OK=2E&quot;</span><br><span> echo &quot;Test sets skipped:$S=
UMMARY_SKIP=2E&quot;</span><br><span> echo &quot;Test sets failed:$SUMMARY_=
FAIL=2E&quot;</span><br><span>diff --git a/tests/t_cltsrv=2Esh b/tests/t_cl=
tsrv=2Esh</span><br><span>index 6b7df65=2E=2E03c3845 100755</span><br><span=
>--- a/tests/t_cltsrv=2Esh</span><br><span>+++ b/tests/t_cltsrv=2Esh</span>=
<br><span>@@ -24,50 +24,58 @@</span><br><span> trap &quot;rm -f log=2E$$ lo=
g=2E$$=2Esignal ; trap 0 ; exit 77&quot; 1 2 15</span><br><span> trap &quot=
;rm -f log=2E$$ log=2E$$=2Esignal ; exit 1&quot; 0 3</span><br><span> addop=
ts=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-case `uname -s` =
in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+case $(uname -s) =
in</span><br><span>     FreeBSD)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    # FreeBSD jails map the outgoing IP to the jail IP - we need=
 to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # allow the re=
al IP unless we want the test to run forever=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if test &quot;`sysctl 2&gt;/dev/null -n secur=
ity=2Ejail=2Ejailed`&quot; =3D 1 \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    || ps -ostate=3D -p $$ | grep -q J; then</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	addopts=3D&quot;--float&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	if test &quot;x`ifconfig | gr=
ep inet`&quot; =3D x ; then</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	    echo &quot;###&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	    echo &quot;### To run the test in a FreeBSD jail, you MUST a=
dd an IP alias for the jail&#39;s IP=2E&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	    echo &quot;###&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	    exit 77</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        # FreeBSD jails map=
 the outgoing IP to the jail IP - we need to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        # allow the real IP unless we want the tes=
t to run forever=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if test &quot;$(sysctl 2&gt;/dev/null -n security=2Ejail=2Ejailed)&=
quot; =3D 1 ||</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ps -ostate=3D -p $$ | grep -q J; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            addopts=3D&quot;--float&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if test &quot;x$=
(ifconfig | grep inet)&quot; =3D x; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                echo &quot;###&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                echo &quot;### To run=
 the test in a FreeBSD jail, you MUST add an IP alias for the jail&#39;s IP=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      echo &quot;###&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                exit 77</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ;;</span><br><span> esac</span><br><span> </span><br><span> # make sur=
e that the --down script is executable -- fail (rather than</span><br><span=
> # skip) test if it isn&#39;t=2E</span><br><span> downscript=3D&quot;=2E=
=2E/tests/t_cltsrv-down=2Esh&quot;</span><br><span> root=3D&quot;${top_srcd=
ir}/sample&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test =
-x &quot;${root}/${downscript}&quot; || chmod +x &quot;${root}/${downscript=
}&quot; || { echo &gt;&amp;2 &quot;${root}/${downscript} is not executable,=
 failing=2E&quot; ; exit 1 ; }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test -x &quot;${root}/${downscript}&quot; || chmod +x &quot;${ro=
ot}/${downscript}&quot; || {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    echo &gt;&amp;2 &quot;${root}/${downscript} is not executable,=
 failing=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span> echo &quot;The following test will take about two minutes=2E&quot; =
&gt;&amp;2</span><br><span> echo &quot;If the addresses are in use, this te=
st will retry up to two times=2E&quot; &gt;&amp;2</span><br><span> </span><=
br><span> # go</span><br><span> success=3D0</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-for i in 1 2 3 ; do</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  set +e</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  (</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;${o=
penvpn}&quot; --script-security 2 --cd &quot;${root}&quot; ${addopts} --set=
env role srv --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 --=
config &quot;sample-config-files/loopback-server&quot; &amp;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &quot;${openvpn}&quot; --script-se=
curity 2 --cd &quot;${top_srcdir}/sample&quot; ${addopts} --setenv role clt=
 --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 --config &quot=
;sample-config-files/loopback-client&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  ) 3&gt;log=2E$$=2Esignal &gt;log=2E$$ 2&gt;&amp;1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  e1=3D$?</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  wait $!</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  e2=3D$?</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  grep &#39;TCP/UDP: Socket bind failed on local address=2E*=
in use&#39; log=2E$$ &gt;/dev/null &amp;&amp; {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    echo &#39;address in use, retrying in 150 s&#=
39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sleep 150</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    continue</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  grep -v &#39;:inactive$&#39; log=2E$$=2Esignal &gt;=
/dev/null &amp;&amp; { cat log=2E$$=2Esignal ; echo ; cat log=2E$$ ; exit 1=
 ; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  success=3D1</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  break</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+for i in 1 2 3; do</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    set +e</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    (</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;${openvpn}&quot; --script-security 2 --cd &quot=
;${root}&quot; ${addopts} --setenv role srv --down &quot;${downscript}&quot=
; --tls-exit --ping-exit 180 --config &quot;sample-config-files/loopback-se=
rver&quot; &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     &quot;${openvpn}&quot; --script-security 2 --cd &quot;${top_srcdir}/sa=
mple&quot; ${addopts} --setenv role clt --down &quot;${downscript}&quot; --=
tls-exit --ping-exit 180 --config &quot;sample-config-files/loopback-client=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ) 3&gt;lo=
g=2E$$=2Esignal &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    e1=3D$?</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    wait $!</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    e2=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 grep &#39;TCP/UDP: Socket bind failed on local address=2E*in use&#39; log=
=2E$$ &gt;/dev/null &amp;&amp; {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        echo &#39;address in use, retrying in 150 s&#39;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 150</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        continue</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    grep -v &#39;:inactive$&#39; log=2E$$=2E=
signal &gt;/dev/null &amp;&amp; {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cat log=2E$$=2Esignal</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        echo</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cat log=2E$$</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
reak</span><br><span> done</span><br><span> </span><br><span> set -e</span>=
<br><span>@@ -75,14 +83,14 @@</span><br><span> # exit code - defaults to 0,=
 PASS</span><br><span> ec=3D0</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-if [ $success !=3D 1 ] ; then</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  # couldn&#39;t run test -- addresses in=
 use, skip test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cat =
log=2E$$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ec=3D77</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ $e1 !=3D 0 ] || [ =
$e2 !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
# failure -- fail test</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  cat log=2E$$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ec=
=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ $success !=
=3D 1 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # =
couldn&#39;t run test -- addresses in use, skip test</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cat log=2E$$</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ec=3D77</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    # failure -- fail test</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cat log=2E$$</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ec=3D1</span><br><sp=
an> fi</span><br><span> </span><br><span> rm log=2E$$ log=2E$$=2Esignal</sp=
an><br><span>diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><=
br><span>index 6802506=2E=2E058206f 100755</span><br><span>--- a/tests/t_lp=
back=2Esh</span><br><span>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -37,=
51 +37,56 @@</span><br><span> test_start()</span><br><span> {</span><br><sp=
an>     case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     0) outbuf=3D&quot;&quot; ;;                  # no per-test output at a=
ll</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        1) outbuf=
=3D&quot;$@&quot; ;;                # compact, details only on failure</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        *) printf &quot;$@=
&quot; ;;                # print all</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        0) outbuf=3D&quot;&quot; ;;   # no per-test output=
 at all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        1) o=
utbuf=3D&quot;$@&quot; ;; # compact, details only on failure</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        *) printf &quot;$@&quot; ;=
; # print all</span><br><span>     esac</span><br><span> }</span><br><span>=
 test_end()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    RC=3D$1 ; LOG=3D$2</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if [ $RC !=3D 0 ]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   RC=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LOG=
=3D$2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ $RC !=
=3D 0 ]; then</span><br><span>         case $V in</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            0) ;;                              =
  # no per-test output</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            1) echo &quot;$outbuf&quot; &quot;FAIL (RC=3D$RC)&quot;; cat $=
LOG ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *) =
echo &quot;FAIL (RC=3D$RC)&quot;; cat $LOG ;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            0) ;; # no per-test output</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                echo &quot;$outbuf&=
quot; &quot;FAIL (RC=3D$RC)&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                cat $LOG</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            *)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                echo &quot;FAIL (RC=3D$RC)&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                cat $LOG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                ;;</span><br=
><span>         esac</span><br><span>         e=3D1</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tests_failed=3D$(( $tests_failed + =
1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests_f=
ailed=3D$(($tests_failed + 1))</span><br><span>     else</span><br><span>  =
       case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        0|1) ;;                              # no per-test output for &#39;=
OK&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *)=
 echo &quot;OK&quot;                         # print all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            0 | 1) ;;       # no per-t=
est output for &#39;OK&#39;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            *) echo &quot;OK&quot; ;; # print all</span><br><span> =
        esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
ests_passed=3D$(( $tests_passed + 1 ))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        tests_passed=3D$(($tests_passed + 1))</span><br>=
<span>     fi</span><br><span> }</span><br><span> </span><br><span> # if ru=
nning with V=3D1, give an indication what test runs now</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$V&quot; =3D 1  ] ; then</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$V&quot; =3D 1=
 ]; then</span><br><span>     echo &quot;$0: running with V=3D$V, only prin=
ting test fails&quot;</span><br><span> fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # Get list of suppo=
rted ciphers from openvpn --show-ciphers output</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-CIPHERS=3D$(${openvpn} --show-ciphers | \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            sed -e &#39;/The =
following/,/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39;/^[[:space:]]*$/d&#39;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CIPHERS=3D$(${open=
vpn} --show-ciphers |</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sed -e &#39;/The following/,/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39=
;/^[[:space:]]*$/d&#39;)</span><br><span> </span><br><span> # SK, 2014-06-0=
4: currently the DES-EDE3-CFB1 implementation of OpenSSL is</span><br><span=
> # broken (see http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867),=
 so exclude</span><br><span> # that cipher from this test=2E</span><br><spa=
n> # GD, 2014-07-06 so is DES-CFB1</span><br><span> # GD, 2014-07-06 do not=
 test RC5-* either (fails on NetBSD w/o libcrypto_rc5)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-CIPHERS=3D$(echo &quot;$CIPHERS&quot; | eg=
rep -v &#39;^(DES-EDE3-CFB1|DES-CFB1|RC5-)&#39; )</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+CIPHERS=3D$(echo &quot;$CIPHERS&quot; | egrep=
 -v &#39;^(DES-EDE3-CFB1|DES-CFB1|RC5-)&#39;)</span><br><span> </span><br><=
span> e=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &q=
uot;$CIPHERS&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+if [ -z &quot;$CIPHERS&quot; ]; then</span><br><span>     echo &quo=
t;&#39;openvpn --show-ciphers&#39; FAILED (empty list)&quot;</span><br><spa=
n>     e=3D1</span><br><span> fi</span><br><span>@@ -91,10 +96,9 @@</span><=
br><span> </span><br><span> set +e</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-for cipher in ${CIPHERS}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+for cipher in ${CIPHERS}; do</span><br><span>     test_st=
art &quot;Testing cipher ${cipher}=2E=2E=2E &quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto --c=
ipher ${cipher} ) &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    (&quot;${openvpn}&quot; --test-crypto --cipher $=
{cipher}) &gt;log=2E$$ 2&gt;&amp;1</span><br><span>     test_end $? log=2E$=
$</span><br><span> done</span><br><span> </span><br><span>@@ -121,7 +125,7 =
@@</span><br><span>     &gt;log=2E$$ 2&gt;&amp;1</span><br><span> test_end =
$? log=2E$$</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-if [ &quot;$V&quot; -ge 1  ] ; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+if [ &quot;$V&quot; -ge 1 ]; then</span><br><span> =
    echo &quot;$0: tests passed: $tests_passed  failed: $tests_failed&quot;=
</span><br><span> fi</span><br><span> </span><br><span>diff --git a/tests/t=
_net=2Esh b/tests/t_net=2Esh</span><br><span>index 8134832=2E=2E17e028e 100=
755</span><br><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_ne=
t=2Esh</span><br><span>@@ -9,7 +9,6 @@</span><br><span> top_builddir=3D&quo=
t;${top_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:=
-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # bail out right =
away on non-linux=2E NetLink (the object of this test) is only</span><br><s=
pan> # used on Linux, therefore testing other platform is not needed=2E</sp=
an><br><span> #</span><br><span>@@ -69,7 +68,6 @@</span><br><span>     done=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> ## execution starts here</span><br><span>=
 </span><br><span> # t_client=2Erc required only for RUN_SUDO definition</s=
pan><br><span>@@ -89,21 +87,18 @@</span><br><span>     exit 77</span><br><s=
pan> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> # Ensure PREFER_KSU is in a known state</span><br><sp=
an> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;</span><br><span> </span><br><=
span> # make sure we have permissions to run the networking unit-test</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ID=3D`id`</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0=
&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
hen :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ID=3D$(id)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot;=
 : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 ];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; =
-eq 1 ]; then</span><br><span>         # Check if we have a valid kerberos =
ticket</span><br><span>         klist -l 1&gt;/dev/null 2&gt;/dev/null</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if [ $? -ne 0 ]; then<=
/span><br><span>             # No kerberos ticket found, skip ksu and fallb=
ack to RUN_SUDO</span><br><span>             PREFER_KSU=3D0</span><br><span=
>             echo &quot;$0: No Kerberos ticket available=2E  Will not use =
ksu=2E&quot;</span><br><span>@@ -112,16 +107,14 @@</span><br><span>        =
 fi</span><br><span>     fi</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span>=
<br><span>         echo &quot;$0: no RUN_SUDO=3D=2E=2E=2E in t_client=2Erc =
or environment, defaulting to &#39;sudo&#39;=2E&quot; &gt;&amp;2</span><br>=
<span>         echo &quot;      if that does not work, set RUN_SUDO=3D corr=
ectly for your system=2E&quot; &gt;&amp;2</span><br><span>         RUN_SUDO=
=3D&quot;sudo&quot;</span><br><span>     fi</span><br><span> </span><br><sp=
an>     # check that we can run the unit-test binary with sudo</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if $RUN_SUDO $UNIT_TEST test</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if $RUN_SUDO $UNIT_TEST test; =
then</span><br><span>         echo &quot;$0: $RUN_SUDO $UNIT_TEST succeeded=
, good=2E&quot;</span><br><span>     else</span><br><span>         echo &qu=
ot;$0: $RUN_SUDO $UNIT_TEST failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;=
2</span><br><span>diff --git a/tests/t_server_null=2Esh b/tests/t_server_nu=
ll=2Esh</span><br><span>index 74ffd52=2E=2Ec633614 100755</span><br><span>-=
-- a/tests/t_server_null=2Esh</span><br><span>+++ b/tests/t_server_null=2Es=
h</span><br><span>@@ -2,7 +2,7 @@</span><br><span> #</span><br><span> TSERV=
ER_NULL_SKIP_RC=3D&quot;${TSERVER_NULL_SKIP_RC:-77}&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if ! [ -r &quot;=2E/t=
_server_null=2Erc&quot; ] ; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if ! [ -r &quot;=2E/t_server_null=2Erc&quot; ]; then</span><br=
><span>     echo &quot;${0}: cannot find &#39;=2E/t_server_null=2Erc=2E SKI=
PPING TEST=2E&#39;&quot; &gt;&amp;2</span><br><span>     exit &quot;${TSERV=
ER_NULL_SKIP_RC}&quot;</span><br><span> fi</span><br><span>@@ -22,11 +22,10=
 @@</span><br><span> # make sure we have permissions to run ifconfig/route =
from OpenVPN</span><br><span> # can&#39;t use &quot;id -u&quot; here - does=
n&#39;t work on Solaris</span><br><span> ID=3D$(id)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0&quo=
t; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then =
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr &quot;$ID&=
quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 =
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&q=
uot; -eq 1 ]; then</span><br><span>         # Check if we have a valid kerb=
eros ticket</span><br><span>         if klist -l 1&gt;/dev/null 2&gt;/dev/n=
ull; then</span><br><span>             RUN_SUDO=3D&quot;ksu -q -e&quot;</sp=
an><br><span>@@ -37,26 +36,24 @@</span><br><span>         fi</span><br><spa=
n>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><span>        =
 echo &quot;${0}: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E &q=
uot; &gt;&amp;2</span><br><span>         echo &quot;      must be set corre=
ctly in &#39;t_server_null=2Erc&#39;=2E SKIP=2E&quot; &gt;&amp;2</span><br>=
<span>         exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span>   =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# Run a no-op =
command with privilege escalation (e=2Eg=2E sudo) so that</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	# we (hopefully) do not have to ask th=
e users password during the test=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	if $RUN_SUDO &quot;${KILL_EXEC}&quot; -0 $$</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	    echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 succeede=
d, good=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;${0}:=
 $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    exit &quot;${TSERV=
ER_NULL_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Run a=
 no-op command with privilege escalation (e=2Eg=2E sudo) so that</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        # we (hopefully) do no=
t have to ask the users password during the test=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if $RUN_SUDO &quot;${KILL_EXEC}&q=
uot; -0 $$; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;${0}=
: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit &qu=
ot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        fi</span><br><span>     fi</span><br><span> fi</span><=
br><span> </span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-export t_server_null_logdir=3Dt_s=
erver_null-`hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+export t_server_null_logdir=3Dt_server_null-$(hostn=
ame)-$(date +%Y%m%d-%H%M%S)</span><br><span> </span><br><span> # Create dir=
ectory for server and client logs</span><br><span> mkdir $t_server_null_log=
dir</span><br><span>diff --git a/tests/t_server_null_client=2Esh b/tests/t_=
server_null_client=2Esh</span><br><span>index 1745de5=2E=2E3203cc2 100755</=
span><br><span>--- a/tests/t_server_null_client=2Esh</span><br><span>+++ b/=
tests/t_server_null_client=2Esh</span><br><span>@@ -1,9 +1,10 @@</span><br>=
<span> #!/bin/sh</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-should_run_test() {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+should_run_test()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span>     test_name=3D&quot;$1&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;=
$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if echo &quot;$test_name&quot; | grep -q _lwip; then</=
span><br><span>         if [ &quot;$has_lwipovpn&quot; =3D &quot;no&quot; ]=
; then</span><br><span>             return 1</span><br><span>         fi</s=
pan><br><span>@@ -12,7 +13,8 @@</span><br><span>     return 0</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-launch_client() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
launch_client()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span>     test_name=3D$1</span><br><span>     log=3D&quot;${test_n=
ame}=2Elog&quot;</span><br><span>     pid=3D&quot;${test_name}=2Epid&quot;<=
/span><br><span>@@ -30,7 +32,8 @@</span><br><span>         --log &quot;${t_=
server_null_logdir}/${log}&quot; &amp;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ping_and_kill() {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ping_and_kill()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     if f=
ping -q -c 5 $1; then</span><br><span>         echo &quot;PASS: fping lwipo=
vpn client $target&quot;</span><br><span>     else</span><br><span>@@ -46,9=
 +49,10 @@</span><br><span>     kill -15 $2</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ping_lwip_client=
s() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ping_lwip_clie=
nts()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan>     if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&quot; ]; then</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        lwip_client_count=3D$=
(echo &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; &quot;)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_count=3D$(ech=
o &quot;$lwip_test_names&quot; | wc -w | tr -d &quot; &quot;)</span><br><sp=
an>     else</span><br><span>         lwip_client_count=3D0</span><br><span=
>     fi</span><br><span>@@ -60,10 +64,10 @@</span><br><span>     count=3D0=
</span><br><span>     maxcount=3D10</span><br><span>     while [ $count -le=
 $maxcount ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   lwip_client_ips=3D$(cat =2E/*=2Elwip 2&gt;/dev/null|wc -l)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_ips=3D$(cat =
=2E/*=2Elwip 2&gt;/dev/null | wc -l)</span><br><span>         if [ $lwip_cl=
ient_ips -lt $lwip_client_count ]; then</span><br><span>             echo &=
quot;Waiting for LWIP clients to start up ($count/$maxcount)&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            count=3D$(( count =
+ 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
unt=3D$((count + 1))</span><br><span>             sleep 1</span><br><span> =
        else</span><br><span>             echo &quot;$lwip_client_ips/$lwip=
_client_count LWIP clients up&quot;</span><br><span>@@ -73,8 +77,8 @@</span=
><br><span> </span><br><span>     wait_pids=3D&quot;&quot;</span><br><span>=
     for line in $(cat =2E/*=2Elwip 2&gt;/dev/null); do</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        target_ip=3D$(echo $line|cut -d &=
quot;,&quot; -f 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     client_pid=3D$(echo $line|cut -d &quot;,&quot; -f 2)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        target_ip=3D$(echo $line | cu=
t -d &quot;,&quot; -f 1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        client_pid=3D$(echo $line | cut -d &quot;,&quot; -f 2)</span><=
br><span>         ping_and_kill $target_ip $client_pid &amp;</span><br><spa=
n>         wait_pids=3D&quot;$wait_pids $!&quot;</span><br><span>     done<=
/span><br><span>@@ -84,7 +88,8 @@</span><br><span>     test -e =2E/lwip_fai=
led &amp;&amp; return 1 || return 0</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_for_results() {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+wait_for_results()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     t=
ests_running=3D&quot;yes&quot;</span><br><span> </span><br><span>     # Wai=
t a bit to allow an OpenVPN client process to create a pidfile to</span><br=
><span>@@ -106,12 +111,13 @@</span><br><span>     done</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_c=
lient_test_result() {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+get_client_test_result()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span>     test_name=3D$1</span><br><span>     should_pa=
ss=3D$2</span><br><span>     log=3D&quot;${test_name}=2Elog&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quo=
t;Initialization Sequence Completed&quot; &quot;${t_server_null_logdir}/${l=
og}&quot; &gt; /dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    grep &quot;Initialization Sequence Completed&quot; &quot;${t_serve=
r_null_logdir}/${log}&quot; &gt;/dev/null</span><br><span>     exit_code=3D=
$?</span><br><span> </span><br><span>     if [ $exit_code -eq 0 ] &amp;&amp=
; [ &quot;${should_pass}&quot; =3D &quot;yes&quot; ]; then</span><br><span>=
@@ -144,7 +150,7 @@</span><br><span> server_max_wait=3D15</span><br><span> =
while [ $count -lt $server_max_wait ]; do</span><br><span>     servers_up=
=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    server_count=
=3D$(echo &quot;$TEST_SERVER_LIST&quot;|wc -w|tr -d &quot; &quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    server_count=3D$(echo &q=
uot;$TEST_SERVER_LIST&quot; | wc -w | tr -d &quot; &quot;)</span><br><span>=
 </span><br><span>     # We need to trim single-quotes because some shells =
return quoted values</span><br><span>     # and some don&#39;t=2E Using &qu=
ot;set -o posix&quot; which would resolve this problem is</span><br><span>@=
@ -152,13 +158,13 @@</span><br><span>     #</span><br><span>     # While in=
active server configurations may get checked they won&#39;t increase</span>=
<br><span>     # the active server count as the processes won&#39;t be runn=
ing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for i in $(=
set|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&=
#39;]&quot;); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   server_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt; /dev/null)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if [ -z &quot;$server_pid&quo=
t; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
i in $(set | grep &#39;SERVER_NAME_&#39; | cut -d &quot;=3D&quot; -f 2 | tr=
 -d &quot;[\&#39;]&quot;); do</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        server_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt;/dev/null)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot=
;$server_pid&quot; ]; then</span><br><span>             continue</span><br>=
<span>         fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if $RUN_SUDO kill -0 $server_pid &gt; /dev/null 2&gt;&amp;1; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            servers_up=3D$(=
( $servers_up + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if $RUN_SUDO kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            servers_u=
p=3D$(($servers_up + 1))</span><br><span>         fi</span><br><span>     d=
one</span><br><span> </span><br><span>@@ -168,7 +174,7 @@</span><br><span> =
        retval=3D0</span><br><span>         break</span><br><span>     else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        count=3D$(( c=
ount + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
ount=3D$((count + 1))</span><br><span>         sleep 1</span><br><span>    =
 fi</span><br><span> </span><br><span>@@ -199,15 +205,14 @@</span><br><span=
> # safe to check the test results=2E</span><br><span> test_names=3D&quot;&=
quot;</span><br><span> lwip_test_names=3D&quot;&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     eval =
test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     eval client=
_exec=3D\&quot;\$CLIENT_EXEC_$SUF\&quot;</span><br><span>     eval client_c=
onf=3D\&quot;\$CLIENT_CONF_$SUF\&quot;</span><br><span> </span><br><span>  =
   test_names=3D&quot;${test_names} ${test_name}&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;$test_=
name&quot;|grep -q _lwip; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if echo &quot;$test_name&quot; | grep -q _lwip; then</span><=
br><span>         lwip_test_names=3D&quot;${lwip_test_names} ${test_name}&q=
uot;</span><br><span>     fi</span><br><span> </span><br><span>@@ -219,13 +=
224,11 @@</span><br><span> ping_lwip_clients</span><br><span> retval=3D$?</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> # Wait until all OpenVPN clients have exited</span><br><span> =
(wait_for_results)</span><br><span> </span><br><span> # Check test results<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_L=
IST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span=
><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><=
span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</span><br><sp=
an> </span><br><span>diff --git a/tests/t_server_null_server=2Esh b/tests/t=
_server_null_server=2Esh</span><br><span>index e1775f0=2E=2Ea8d7268 100755<=
/span><br><span>--- a/tests/t_server_null_server=2Esh</span><br><span>+++ b=
/tests/t_server_null_server=2Esh</span><br><span>@@ -1,6 +1,7 @@</span><br>=
<span> #!/bin/sh</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-launch_server() {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+launch_server()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span>     server_name=3D$1</span><br><span>     server_=
exec=3D$2</span><br><span>     server_conf=3D$3</span><br><span>@@ -17,10 +=
18,10 @@</span><br><span> </span><br><span>     # Try to launch the server<=
/span><br><span>     $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-               $server_conf \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-               --status &quot=
;${status}&quot; 1 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
              --writepid &quot;${pid}&quot; \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               --explicit-exit-notify 3 &gt; &quot;=
$log&quot; 2&gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        $server_conf \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        --status &quot;${status}&quot; 1 \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        --writepid &quot;${pid}&quot; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --explicit-e=
xit-notify 3 &gt;&quot;$log&quot; 2&gt;&amp;1 &amp;</span><br><span> </span=
><br><span>     sleep 1</span><br><span> </span><br><span>@@ -44,8 +45,7 @@=
</span><br><span> retval=3D0</span><br><span> </span><br><span> # Launch te=
st servers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in =
$TEST_SERVER_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERV=
ER_LIST; do</span><br><span>     eval server_name=3D\&quot;\$SERVER_NAME_$S=
UF\&quot;</span><br><span>     eval server_exec=3D\&quot;\$SERVER_EXEC_$SUF=
\&quot;</span><br><span>     eval server_conf=3D\&quot;\$SERVER_CONF_$SUF\&=
quot;</span><br><span>@@ -57,8 +57,7 @@</span><br><span> # the test run=2E<=
/span><br><span> #</span><br><span> export server_pid_files=3D&quot;&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVE=
R_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do=
</span><br><span>     eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</=
span><br><span>     server_pid_files=3D&quot;${server_pid_files} =2E/${serv=
er_name}=2Epid&quot;</span><br><span> done</span><br><span>@@ -69,12 +68,11=
 @@</span><br><span> count=3D0</span><br><span> maxcount=3D4</span><br><spa=
n> while [ $count -le $maxcount ]; do</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ls t_server_null_client=2Esh*=2Epid &gt; /dev/null 2=
&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ls t_server_nul=
l_client=2Esh*=2Epid &gt;/dev/null 2&gt;&amp;1; then</span><br><span>      =
   count=3D0</span><br><span>         sleep 1</span><br><span>     else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	count=3D$(( count + 1))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        count=3D$((c=
ount + 1))</span><br><span>         sleep 1</span><br><span>     fi</span><=
br><span> done</span><br><span>@@ -85,11 +83,10 @@</span><br><span> # serve=
r process does not exit in 15 seconds assume it never will, move on and</sp=
an><br><span> # hope for the best=2E</span><br><span> echo &quot;Waiting fo=
r servers to exit&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-for PID_FILE in $server_pid_files</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for=
 PID_FILE in $server_pid_files; do</span><br><span>     SERVER_PID=3D$(cat =
&quot;${PID_FILE}&quot;)</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if [ -z &quot;$SERVER_PID&quot; ] ; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$SERVER_PID=
&quot; ]; then</span><br><span>         echo &quot;WARNING: could not kill =
server ${PID_FILE}!&quot;</span><br><span>         continue</span><br><span=
>     fi</span><br><span>@@ -99,17 +96,16 @@</span><br><span> </span><br><s=
pan>     count=3D0</span><br><span>     maxcount=3D75</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while [ $count -le $maxcount ]</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO kill -0 &quot;${SERVER_PI=
D}&quot; 2&gt; /dev/null || break</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        count=3D$(( count + 1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while [ $count -le $maxcount ]; do</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO kill -0 &quot;=
${SERVER_PID}&quot; 2&gt;/dev/null || break</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        count=3D$((count + 1))</span><br><span>    =
     sleep 0=2E2</span><br><span>     done</span><br><span> </span><br><spa=
n>     # If server is still up send a SIGKILL</span><br><span>     if [ $co=
unt -ge $maxcount ]; then</span><br><span>         $RUN_SUDO $KILL_EXEC -9 =
&quot;${SERVER_PID}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        SERVER_NAME=3D$(basename $PID_FILE|cut -d =2E -f 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        SERVER_NAME=3D$(basenam=
e $PID_FILE | cut -d =2E -f 1)</span><br><span>         echo &quot;ERROR: h=
ad to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!&quot;</=
span><br><span>         echo &quot;Tail of server log:&quot;</span><br><spa=
n>         tail -n 20 &quot;${t_server_null_logdir}/${SERVER_NAME}=2Elog&qu=
ot;</span><br><span>diff --git a/tests/t_server_null_stress=2Esh b/tests/t_=
server_null_stress=2Esh</span><br><span>index 0bb9452=2E=2E2fc9fde 100755</=
span><br><span>--- a/tests/t_server_null_stress=2Esh</span><br><span>+++ b/=
tests/t_server_null_stress=2Esh</span><br><span>@@ -7,8 +7,7 @@</span><br><=
span> =2E =2E/t_server_null_default=2Erc</span><br><span> </span><br><span>=
 export pid_files=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-for SUF in $TEST_SERVER_LIST</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+for SUF in $TEST_SERVER_LIST; do</span><br><span>     eval server_name=3D\=
&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span>     pid_files=3D&quot;${pi=
d_files} =2E/${server_name}=2Epid&quot;</span><br><span> done</span><br><sp=
an>@@ -18,16 +17,16 @@</span><br><span> </span><br><span> count=3D0</span><=
br><span> while [ $count -lt $ITERATIONS ]; do</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    count=3D$(( count + 1 ))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    make check TESTS=3Dt_server_null=2Esh S=
UBDIRS=3D &gt; /dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    count=3D$((count + 1))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    make check TESTS=3Dt_server_null=2Esh SUBDIRS=
=3D &gt;/dev/null 2&gt;&amp;1</span><br><span>     retval=3D$?</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;I=
teration ${count}: return value ${retval}&quot; &gt;&gt; &quot;${LOG_BASEDI=
R}/make-check=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    echo &quot;Iteration ${count}: return value ${retval}&quot; &gt;&=
gt;&quot;${LOG_BASEDIR}/make-check=2Elog&quot;</span><br><span>     if [ $r=
etval -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	D=
IR=3D&quot;${LOG_BASEDIR}/make-check-${count}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        DIR=3D&quot;${LOG_BASEDIR}/make-c=
heck-${count}&quot;</span><br><span>         mkdir -p &quot;${DIR}&quot;</s=
pan><br><span>         cp t_server_null*=2Elog &quot;${DIR}/&quot;</span><b=
r><span>         cp test-suite=2Elog &quot;${DIR}/&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ps aux|grep openvpn|grep -vE &#3=
9;(suppress|grep)&#39; &gt; &quot;${DIR}/psaux&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ps aux | grep openvpn | grep -vE =
&#39;(suppress|grep)&#39; &gt;&quot;${DIR}/psaux&quot;</span><br><span>    =
 fi</span><br><span> done</span><br><span>diff --git a/tests/update_t_clien=
t_ips=2Esh b/tests/update_t_client_ips=2Esh</span><br><span>index 96e3826=
=2E=2E777a286 100755</span><br><span>--- a/tests/update_t_client_ips=2Esh</=
span><br><span>+++ b/tests/update_t_client_ips=2Esh</span><br><span>@@ -5,1=
2 +5,12 @@</span><br><span> </span><br><span> RC=3D&quot;$TOP_BUILDDIR/t_cl=
ient_ips=2Erc&quot;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&=
amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IF=
CONFIG4_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? =
-ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo=
 &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $RC</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFC=
ONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span> fi</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep EX=
PECT_IFCONFIG6_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC=
 &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG6=
_$TESTNUM=3D$ifconfig_ipv6_local&quot; &gt;&gt; $RC</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=
=3D$ifconfig_ipv6_local&quot; &gt;&gt;$RC</span><br><span> fi</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1793?usp=3Demail">change 1793</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf3=
32a0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1793 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razva=
nc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

=
</body></html>
--4ZVEBaXR6wo=--


--===============6508316290822737121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6508316290822737121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6508316290822737121==--

