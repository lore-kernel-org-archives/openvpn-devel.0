Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08D5C5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hsY9XeCCitUidARSLr9Y5TQKIR5qb60n2KsZ7TK7PSQ=; b=N+htnpNZ12xEgcVBxsx34b2rvw
	kSjBXlklY6SG4SCwqOIJbk7qLguwlyTGQTGYNtnubBlgEWLx4hCQT1ycCEEUmPgp1uCfKASLxk52p
	5jqyydfnVIXJNoOlmbsfnWgdSZ4PGK5rfYt+xftKmO0ysuouLE+L3Saw0Bd85T0i2wS4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx08v-00011A-1s;
	Thu, 20 Aug 2026 10:37:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx08s-000110-TQ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UwGrjVqxfsYXPbwHOgkixV6RpNwkc70LhezK+yJtzCU=; b=IJrPdAbAMoUOsKtAJ0drBOqE+Z
 uv0zB/DJX2Mg5HANVU0yJNdk058P12X/qHB+gP20Lz+W9WV/NLIJXVq7s9IlZ4NHvoQUFU1InUww3
 WLFnO7k8ehcC0wlP/U0JX/x+OazFVVhfI6P93CDG+Z5N+IBLbTbykf6jebsNXHxvoEtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UwGrjVqxfsYXPbwHOgkixV6RpNwkc70LhezK+yJtzCU=; b=X
 5NWroHlcbJYv9sqZDYFXexu+JiCSXn0cnhZ47/fIcGluxuFUJEh/3/Epfk/odHV9Mmol4tJJRxC8P
 aSyEKGxdCB5Q3RKRebQ/Y40hvIWiyM/vmmdvxCyroV+YAsY5RlaMjHp+ElZzOpIIOT6QOnLY1GObg
 BqAwR4BJ2jxRFybA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx08m-00044r-AL for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:37:02 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so17623615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787222210; x=1787827010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UwGrjVqxfsYXPbwHOgkixV6RpNwkc70LhezK+yJtzCU=;
 b=V3IvPUgsRydOF5hQ4qQp72dlH/P72wxlLiO/AJ93L7E7pu6R2fYZvTzFUoV39lySoX
 tFVYELz16PSXGaHdC7MIG1loBEN6CBGif3uYKzEx1zcz2zPrb1JX28Gr2344Xoh/+Brq
 +kIg/l0VsVvfw7Khoffj+qgKluXlZ8tn3liRMfHmCJ68DTDdkxeoKsLBgPx7izqJvkJS
 YoZ834tyhhYUfnUJ5fB7mHzcdNeT5qcdfhHP4oIWTmnW1KSwi/3eHBHQb3IHS9/zzYiU
 e2bjl+GrBJA/egwUcsUT239QRX179PFgDcZuNdlw/Ap5RSseXl7m3xAjzJM4S+Cq/VP0
 yzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222210; x=1787827010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UwGrjVqxfsYXPbwHOgkixV6RpNwkc70LhezK+yJtzCU=;
 b=jjYcQNneR0ebMU/lKlvwxS8vijaLrOfobA5WkhP48BfIbKCPpOAJEfChPlW7WFHjYF
 aYpDkEtDuX6ywlTP+6j9WsknkpZAPfmtJbIOoNDtENi2xzmsAQwnUtoadx6epP3dOeqq
 6omHp9r4as5d/BWYA9SuRI01SBMJdhBJkpuhVCWB7pbuEOFemEJmbBZb/my45o/zNbE0
 +XIJRLjybYbgd5Ckmi2U56kugtzeUnlq6IhQH6eG55vlZKcDUBAbkYSJVmGE0YIBffaK
 Us9t6nWv1iQkRx2QBb2Cdc6vw2iB2CR6jwCP89H2MD0zdrODEvhlm6NvrNyryQ5HEbaB
 xxmQ==
X-Gm-Message-State: AOJu0Yxz6UiDI6+SoShHjYgWRBtmZdS8aUCnUIx7bc/6gnGij/86DjBb
 yvrAIZfY665R6WiHCmgXa4ZFe/7J9UqNCiQ0F16m8EN0Ah1AgnsKtrLb5mHqgzJsDhTVc7UdeRX
 wnJim3yC79zz5xWMBUjJofLPPgG1bctqfZ8NAXpRTSpwLPgk1l/6hIeKXrC0XAIKoPM0N
X-Gm-Gg: AR+sD131S7lZx5GEBHpgmQGD8wSlJKI1gHIKGzpXGr3VDXBolP7+OxoKQemRtrtZDU4
 mwRYa6JmKLpEPSRgizX/7xLsSDEpNaVgk+HVPPo+Xs8kiO0WGzw5ESLXM0JFRIetDg//fDtSqFS
 ++2YWD4CNaYnow/QKZ6E1qAPpoQ1LS1EQAy2fo6rHU5AFfPdH2f4wX5m3vy8//wwxs/H1mLU88G
 GmDQvv/3JVL8hnjpcNYqRlKfymP0+8kssxX1Lk1S1cY9lx0noS45KjzIDgodWcAHjr9AJMHYi/k
 vXHq9CajNMdqov2MgvxKhv48J6BGxEEhUt1f88dNUfy5ZuW6DdNRxl9fSDFfx6EuokwmcElRXH3
 w+NXA4AAvapNVwtCFRnTqsMoUGnUjeseb9k3RcbLn0lDNw/NPN+OFWmv2SPgQuAtiO32l0hZ65F
 cqrV4F0nBiZVIobCTRx/+3XrelelgENiCiC3JlW3WJviVnOdx43O2q479mk0i2P3zfv1n9OfKIx
 5ec/97dl0woaZEpn22v8wLSao345ylWDctCWexWi85tr5g+4ezzkY3pkSOiAAO3oF8IdHQmv2Bm
 +k/KescQ4QVTrugZatHEvcjEbAjXhlVDIw+1UrB6q/q3Dq+MmXI=
X-Received: by 2002:a05:600c:4743:b0:499:8ff5:8ecc with SMTP id
 5b1f17b1804b1-499aa1dea9emr165828645e9.15.1787222208922; 
 Thu, 20 Aug 2026 03:36:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e805a4sm149937445e9.4.2026.08.20.03.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:36:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:36:45 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: f781227c92a3d1017e9d8a67e83e4465b43edf66
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e247a6ad502e4f78ffaaa272be3044ce53425d1e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx08m-00044r-AL
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8595442865609588417=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8595442865609588417==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k3P89T7fhDA="; charset=UTF-8

--k3P89T7fhDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: Reformat all shell-scripts with shfmt
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reformat all shell-=
scripts with shfmt

According to =2E/dev-tools/reformat-shell=2Esh=2E

Chan=
ge-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793
Message=
-Id: <20260820091539=2E4592-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38547=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/git-pr=
e-commit-format=2Esh
M dev-tools/run-cppcheck=2Esh
M dev-tools/update-copyr=
ight=2Esh
M tests/lwip_client_up=2Esh
M tests/null_client_up=2Esh
M tests/t=
_client=2Esh=2Ein
M tests/t_cltsrv=2Esh
M tests/t_lpback=2Esh
M tests/t_net=
=2Esh
M tests/t_server_null=2Esh
M tests/t_server_null_client=2Esh
M tests/=
t_server_null_server=2Esh
M tests/t_server_null_stress=2Esh
M tests/update_=
t_client_ips=2Esh
14 files changed, 386 insertions(+), 385 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1793/5=


diff --git a/dev-tools/git-pre-commit-format=2Esh b/dev-tools/git-pre-com=
mit-format=2Esh
index 9b2ecaf=2E=2E3507289 100755
--- a/dev-tools/git-pre-c=
ommit-format=2Esh
+++ b/dev-tools/git-pre-commit-format=2Esh
@@ -26,7 +26,6=
 @@
 # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT O=
F THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH D=
AMAGE=2E
 
-
 # git pre-commit hook that runs a stylecheck=2E
 # Features:
=
 #  - abort commit when commit does not comply with the style guidelines
@@=
 -43,12 +42,11 @@
 # exit on error
 set -e
 
-
 # If called so, install thi=
s script as pre-commit hook
-if [ "$1" =3D "install" ] ; then
+if [ "$1" =
=3D "install" ]; then
     TARGET=3D"$(git rev-parse --git-path hooks)/pre-=
commit"
 
-    if [ -e "$TARGET" ] ; then
+    if [ -e "$TARGET" ]; then
  =
       printf "$TARGET file exists=2E Won't overwrite=2E\n"
         printf=
 "Aborting installation=2E\n"
         exit 1
@@ -62,18 +60,19 @@
 fi
 
 # =
check whether the given file matches any of the set extensions
-matches_ext=
ension() {
+matches_extension()
+{
     local filename=3D"$(basename -- "$1=
")"
     local extension=3D"=2E${filename##*=2E}"
     local ext
 
-    for=
 ext in =2Ec =2Eh ; do [ "$ext" =3D "$extension" ] && return 0; done
+    f=
or ext in =2Ec =2Eh; do [ "$ext" =3D "$extension" ] && return 0; done
 
   =
  return 1
 }
 
 # necessary check for initial commit
-if git rev-parse --v=
erify HEAD >/dev/null 2>&1 ; then
+if git rev-parse --verify HEAD >/dev/nul=
l 2>&1; then
     against=3DHEAD
 else
     # Initial commit: diff against =
an empty tree object
@@ -88,8 +87,8 @@
 
     # Allow to use in parallel wi=
th pre-commit
     if [ $(basename "$0") =3D "pre-commit=2Elegacy" ]; then
=
-       echo "Skipping clang-format check in favor of pre-commit"
-       e=
xit 0
+        echo "Skipping clang-format check in favor of pre-commit"
+ =
       exit 0
     fi
 else
     TOOL=3Duncrustify
@@ -98,7 +97,7 @@
     T=
OOL_CMD=3D"$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
 
     # make sure the con=
fig file is correctly set
-    if [ ! -f "$UNCRUST_CONFIG" ] ; then
+    if=
 [ ! -f "$UNCRUST_CONFIG" ]; then
         printf "Error: uncrustify config=
 file not found=2E\n"
         printf "Expected to find it at $UNCRUST_CONF=
IG=2E\n"
         printf "Aborting commit=2E\n"
@@ -106,7 +105,7 @@
     fi=

 fi
 
-if [ -z "$TOOL_BIN" ] ; then
+if [ -z "$TOOL_BIN" ]; then
     prin=
tf "Error: $TOOL executable not found=2E\n"
     printf "Is it installed an=
d in your \$PATH?\n"
     printf "Aborting commit=2E\n"
@@ -120,44 +119,43 =
@@
 # create one patch containing all changes to the files
 # sed to remove=
 quotes around the filename, if inserted by the system
 # (done sometimes, =
if the filename contains special characters, like the quote itself)
-git di=
ff-index --cached --diff-filter=3DACMR --name-only $against -- | \
-sed -e =
's/^"\(=2E*\)"$/\1/' | \
-while read file
-do
-    # ignore file if we do c=
heck for file extensions and the file
-    # does not match the extensions =
=2Ec or =2Eh
-    if ! matches_extension "$file"; then
-        continue;
-=
    fi
+git diff-index --cached --diff-filter=3DACMR --name-only $against -=
- |
+    sed -e 's/^"\(=2E*\)"$/\1/' |
+    while read file; do
+        # =
ignore file if we do check for file extensions and the file
+        # does=
 not match the extensions =2Ec or =2Eh
+        if ! matches_extension "$fi=
le"; then
+            continue
+        fi
 
-    # escape special charact=
ers in the target filename:
-    # phase 1 (characters escaped in the outpu=
t diff):
-    #     - '\': backslash needs to be escaped in the output diff=

-    #     - '"': quote needs to be escaped in the output diff if present =
inside
-    #            of the filename, as it used to bracket the entire =
filename part
-    # phase 2 (characters escaped in the match replacement):=

-    #     - '\': backslash needs to be escaped again for sed itself
-    =
#            (i=2Ee=2E double escaping after phase 1)
-    #     - '&': wou=
ld expand to matched string
-    #     - '|': used as sed split char instea=
d of '/'
-    # printf %s particularly important if the filename contains t=
he % character
-    file_escaped_target=3D$(printf "%s" "$file" | sed -e 's=
/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
+        # escape special characters in th=
e target filename:
+        # phase 1 (characters escaped in the output dif=
f):
+        #     - '\': backslash needs to be escaped in the output diff
=
+        #     - '"': quote needs to be escaped in the output diff if prese=
nt inside
+        #            of the filename, as it used to bracket the =
entire filename part
+        # phase 2 (characters escaped in the match re=
placement):
+        #     - '\': backslash needs to be escaped again for s=
ed itself
+        #            (i=2Ee=2E double escaping after phase 1)
+ =
       #     - '&': would expand to matched string
+        #     - '|': us=
ed as sed split char instead of '/'
+        # printf %s particularly impor=
tant if the filename contains the % character
+        file_escaped_target=
=3D$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
 
-   =
 # uncrustify our sourcefile, create a patch with diff and append it to our=
 $patch
-    # The sed call is necessary to transform the patch from
-    #=
    --- - timestamp
-    #    +++ $tmpout timestamp
-    # to both lines wo=
rking on the same file and having a a/ and b/ prefix=2E
-    # Else it can =
not be applied with 'git apply'=2E
-    git show ":$file" | $TOOL_CMD > "$t=
mpout"
-    git show ":$file" | diff -u -- - "$tmpout" | \
-        sed -e =
"1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file=
_escaped_target\"|" >> "$patch"
-done
+        # uncrustify our sourcefile,=
 create a patch with diff and append it to our $patch
+        # The sed ca=
ll is necessary to transform the patch from
+        #    --- - timestamp
+=
        #    +++ $tmpout timestamp
+        # to both lines working on the =
same file and having a a/ and b/ prefix=2E
+        # Else it can not be ap=
plied with 'git apply'=2E
+        git show ":$file" | $TOOL_CMD >"$tmpout"=

+        git show ":$file" | diff -u -- - "$tmpout" |
+            sed -e =
"1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file=
_escaped_target\"|" >>"$patch"
+    done
 
 rm -f "$tmpout"
 
 # if no patc=
h has been generated all is ok, clean up the file stub and exit
-if [ ! -s =
"$patch" ] ; then
+if [ ! -s "$patch" ]; then
     rm -f "$patch"
     exit=
 0
 fi
@@ -165,7 +163,7 @@
 # a patch has been created, notify the user and=
 exit
 printf "Formatting of some code does not follow the project guidelin=
es=2E\n"
 
-if [ $(wc -l < $patch) -gt 80 ] ; then
+if [ $(wc -l <$patch) -=
gt 80 ]; then
     printf "The file $patch contains the necessary fixes=2E\=
n"
 else
     printf "Here's the patch that fixes the formatting:\n\n"
diff=
 --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 40=
db33e=2E=2Ea7aa3c4 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools=
/run-cppcheck=2Esh
@@ -20,24 +20,23 @@
  --check-level=3Dexhaustive --max-c=
onfigs=3D10 \
  --error-exitcode=3D1"
 
-
 set -x
 
 mkdir -p "$CPPCHECK_DI=
R"
 cd "${SOURCE_DIR}"
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
-         --=
platform=3Dunix64 \
-         --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg=
 --library=3Dgnu=2Ecfg \
-         -U_WIN32 \
-         src/openvpn/ src/co=
mpat/ src/plugins/ sample/ \
-         tests/unit_tests/example_test/ tests=
/unit_tests/openvpn/ \
-         tests/unit_tests/plugins/
+    --platform=
=3Dunix64 \
+    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3D=
gnu=2Ecfg \
+    -U_WIN32 \
+    src/openvpn/ src/compat/ src/plugins/ samp=
le/ \
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
+    =
tests/unit_tests/plugins/
 cppcheck $COMMON_ARGS \
-         --platform=3Dw=
in64 \
-         --library=3Dwindows=2Ecfg \
-         -D_WIN32 \
-        =
 -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
-      =
   -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
-=
         -UTARGET_AIX \
-         src/openvpn* src/compat/ \
-         test=
s/unit_tests/example_test/ tests/unit_tests/openvpn*
+    --platform=3Dwin6=
4 \
+    --library=3Dwindows=2Ecfg \
+    -D_WIN32 \
+    -UTARGET_LINUX -U=
TARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+    -UTARGET_DARWIN -UTA=
RGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+    -UTARGET_AIX \
+   =
 src/openvpn* src/compat/ \
+    tests/unit_tests/example_test/ tests/unit_=
tests/openvpn*
diff --git a/dev-tools/update-copyright=2Esh b/dev-tools/upd=
ate-copyright=2Esh
index 96546dd=2E=2E7ca6002 100755
--- a/dev-tools/update=
-copyright=2Esh
+++ b/dev-tools/update-copyright=2Esh
@@ -34,8 +34,7 @@
 CO=
PY_YEAR=3D"$1"
 
 cd "$(git rev-parse --show-toplevel)"
-for file in $(git =
ls-files | grep -v vendor/);
-do
+for file in $(git ls-files | grep -v vend=
or/); do
     echo -n "Updating $file =2E=2E=2E"
     # The first sed opera=
tion covers 20xx-20yy copyright lines,
     # The second sed operation chan=
ges 20xx -> 20xx-20yy
diff --git a/tests/lwip_client_up=2Esh b/tests/lwip_c=
lient_up=2Esh
index a6b4d24=2E=2Eb1941a4 100755
--- a/tests/lwip_client_up=
=2Esh
+++ b/tests/lwip_client_up=2Esh
@@ -2,16 +2,17 @@
 #
 # Determine the=
 OpenVPN PID from its pid file=2E This works reliably even when
 # the Open=
VPN process is backgrounded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY=
_PPID=3D$(cat $pid)
 
 # Add this client's VPN IP and PID to a file=2E This=
 enables
 # t_server_null_client=2Esh to kill this OpenVPN client after fpi=
ng tests have
 # finished=2E
-echo "$ifconfig_local,$MY_PPID" >> =2E/$test_=
name=2Elwip
+echo "$ifconfig_local,$MY_PPID" >>=2E/$test_name=2Elwip
 
 # W=
ait long enough to allow fping tests to finish=2E Also ensure that this
 # =
OpenVPN client is killed even if t_server_null_client=2Esh failed to do it=
=2E
-(sleep 15
-echo "ERROR: t_server_null_client=2Esh failed to kill OpenV=
PN client with PID $MY_PPID in test $test_name=2E Killing it in lwip_client=
_up=2Esh=2E"
-kill -15 $MY_PPID
+(
+    sleep 15
+    echo "ERROR: t_server=
_null_client=2Esh failed to kill OpenVPN client with PID $MY_PPID in test $=
test_name=2E Killing it in lwip_client_up=2Esh=2E"
+    kill -15 $MY_PPID
 =
) &
diff --git a/tests/null_client_up=2Esh b/tests/null_client_up=2Esh
inde=
x d4df0c6=2E=2Ebe339ee 100755
--- a/tests/null_client_up=2Esh
+++ b/tests/n=
ull_client_up=2Esh
@@ -4,8 +4,11 @@
 
 # Determine the OpenVPN PID from its=
 pid file=2E This works reliably even when
 # the OpenVPN process is backgr=
ounded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY_PPID=3D$(cat $pid)
 =

 # Allow OpenVPN to finish initializing while waiting in the background an=
d then
 # killing the process gracefully=2E
-(sleep 5 ; kill -15 $MY_PPID) =
&
+(
+    sleep 5
+    kill -15 $MY_PPID
+) &
diff --git a/tests/t_client=
=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 2f37845=2E=2E305441be 100755
--=
- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,9 +19,9 =
@@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E}"
 op=
envpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r "${top_b=
uilddir}"/t_client=2Erc ] ; then
+if [ -r "${top_builddir}"/t_client=2Erc ]=
; then
     =2E "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcdir}"/t_cl=
ient=2Erc ] ; then
+elif [ -r "${srcdir}"/t_client=2Erc ]; then
     =2E "$=
{srcdir}"/t_client=2Erc
 else
     echo "$0: cannot find 't_client=2Erc' in=
 build dir ('${top_builddir}')" >&2
@@ -32,37 +32,35 @@
 # Check for extern=
al dependencies
 FPING=3D"fping"
 FPING6=3D"fping6"
-which fping > /dev/nul=
l
+which fping >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping is no=
t available in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
-which fping6=
 > /dev/null
+which fping6 >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0:=
 fping6 is not available in \$PATH, assuming fping 4=2E0 or later" >&2
    =
 FPING=3D"fping -4"
     FPING6=3D"fping -6"
 fi
 
-KILL_EXEC=3D`which kill=
`
+KILL_EXEC=3D$(which kill)
 if [ $? -ne 0 ]; then
     echo "$0: kill not=
 found in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${op=
envpn}" ]
-then
+if [ ! -x "${openvpn}" ]; then
     echo "no (executable) =
openvpn binary in current build tree=2E FAIL=2E" >&2
     exit 1
 fi
 
-if =
[ ! -w =2E ]
-then
+if [ ! -w =2E ]; then
     echo "current directory is n=
ot writable (required for logging)=2E FAIL=2E" >&2
     exit 1
 fi
 
-if [ =
-z "$TEST_RUN_LIST" ] ; then
+if [ -z "$TEST_RUN_LIST" ]; then
     echo "T=
EST_RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCL=
IENT_SKIP_RC}"
 fi
@@ -72,16 +70,14 @@
 
 # make sure we have permissions t=
o run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work =
on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+ID=3D$=
(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${=
PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
   =
      # Check if we have a valid kerberos ticket
         klist -l 1>/dev/n=
ull 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if [ $? -n=
e 0 ]; then
             # No kerberos ticket found, skip ksu and fallback =
to RUN_SUDO
             PREFER_KSU=3D0
             echo "$0: No Kerberos =
ticket available=2E  Will not use ksu=2E"
@@ -90,8 +86,7 @@
         fi
   =
  fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; the=
n
         echo "$0: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E=
 " >&2
         echo "      must be set correctly in 't_client=2Erc'=2E SKI=
P=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -99,20 +94,19 @@
         #=
 We have to use sudo=2E Make sure that we (hopefully) do not have
         =
# to ask the users password during the test=2E This is done to
         # p=
revent timing issues, e=2Eg=2E when the waits for openvpn to start
-	if $RU=
N_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 succ=
eeded, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cann=
ot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	fi
+        if $=
RUN_SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_SUDO $KILL_EXEC=
 -0 succeeded, good=2E"
+        else
+            echo "$0: $RUN_SUDO $KIL=
L_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+            exit "${TCLIENT=
_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_client-`hostname`-`date +%=
Y%m%d-%H%M%S`
+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
 LOGDIR=
_ABS=3D"$PWD/$LOGDIR"
-if mkdir $LOGDIR
-then :
+if mkdir $LOGDIR; then
+  =
  :
 else
     echo "can't create log directory '$LOGDIR'=2E FAIL=2E" >&2
 =
    exit 1
@@ -132,21 +126,28 @@
 output_start()
 {
     case $V in
-	0) ou=
tbuf=3D"" ;;			# no per-test output at all
-	1) printf "$@\n"			# compact, =
details only on failure
-           outbuf=3D"\n" ;;
-	*) printf "\n$@\n" ;=
;		# print all, with a bit formatting
+        0) outbuf=3D"" ;; # no per-t=
est output at all
+        1)
+            printf "$@\n" # compact, details=
 only on failure
+            outbuf=3D"\n"
+            ;;
+        *) pri=
ntf "\n$@\n" ;; # print all, with a bit formatting
     esac
 }
 
 output()=

 {
-    END_NL=3D"\n"; if [ "X$1" =3D "X-n" ] ; then END_NL=3D"" ; shift ;=
 fi
+    END_NL=3D"\n"
+    if [ "X$1" =3D "X-n" ]; then
+        END_NL=3D=
""
+        shift
+    fi
     case $V in
-	0) ;;				# no per-test output a=
t all
-	1) outbuf=3D"$outbuf$@${END_NL}"	# print details only on failure
- =
          ;;
-	*) printf "$@${END_NL}" ;;	# print everything
+        0) ;;=
 # no per-test output at all
+        1)
+            outbuf=3D"$outbuf$@${=
END_NL}" # print details only on failure
+            ;;
+        *) printf=
 "$@${END_NL}" ;; # print everything
     esac
 }
 
@@ -154,62 +155,61 @@
 =
fail()
 {
     output "FAIL: $@\n"
-    fail_count=3D$(( $fail_count + 1 ))=

+    fail_count=3D$(($fail_count + 1))
 }
 
 # print "all interface IP add=
resses" + "all routes"
 # this is higly system dependent=2E=2E=2E
 get_ifco=
nfig_route()
 {
-    UNAME=3D`uname -s`
+    UNAME=3D$(uname -s)
     case =
$UNAME in
-	Linux)
+        Linux)
             # linux / iproute2? (-> if =
configure got a path)
-            if [ -n "@IPROUTE@" ]
-            then
=
+            if [ -n "@IPROUTE@" ]; then
                 echo "-- linux ip=
route2 --"
-                @IPROUTE@ addr show     | grep -v valid_lft
+  =
              @IPROUTE@ addr show | grep -v valid_lft
                 @IPR=
OUTE@ route show
                 @IPROUTE@ -o -6 route show | grep -v ' ca=
che' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthres=
h) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
             else
-	        =
echo "-- linux / ifconfig --"
-	        LANG=3DC @IFCONFIG@ -a |egrep  "( a=
ddr:|encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 -6
+                echo =
"-- linux / ifconfig --"
+                LANG=3DC @IFCONFIG@ -a | egrep "(=
 addr:|encap:)"
+                LANG=3DC @NETSTAT@ -rn -4 -6
             =
fi
             ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD/NetBSD/Da=
rwin [MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETST=
AT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	OpenBSD)
-	  =
 echo "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)" | \
-		s=
ed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -rn | awk '=
$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	   echo "-- Solaris=
 --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk =
'$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	   echo "-- AIX --"
-=
	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~=
 /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
+        FreeBSD | NetBSD | Darwin)
=
+            echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+            @IFC=
ONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }'
+            ;;
+        OpenBSD)
+        =
    echo "-- OpenBSD --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet=
)" |
+                sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
+  =
          @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+      =
      ;;
+        SunOS)
+            echo "-- Solaris --"
+            @IF=
CONFIG@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !=
~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;
+        AIX)
+            =
echo "-- AIX --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+    =
        @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+         =
   ;;
         *)
-           echo "get_ifconfig_route(): no idea how to ge=
t info on your OS (`uname -s`)=2E  FAIL=2E" >&2
-           exit 20
-      =
     ;;
+            echo "get_ifconfig_route(): no idea how to get info on=
 your OS ($(uname -s))=2E  FAIL=2E" >&2
+            exit 20
+            ;=
;
     esac
 
     # another round of per-platform information gathering, f=
or DNS info
     # for most of the platforms "cat /etc/resolv=2Econf" is go=
od enough
     # except Linux and MacOS
     case $UNAME in
-	Linux)
-     =
       if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then
+    =
    Linux)
+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/syst=
em ]; then
                 echo "-- linux resolvectl --"
                 =
resolvectl status
             else
@@ -217,7 +217,7 @@
                 ca=
t /etc/resolv=2Econf
             fi
             ;;
-	Darwin)
+        Dar=
win)
             echo "-- MacOS scutil --dns"
             scutil --dns
  =
           ;;
@@ -234,19 +234,19 @@
 #  arg2: IPv4/IPv6 address that must s=
how up in out of "get_ifconfig_route"
 check_ifconfig()
 {
-    proto=3D$1 =
; shift
+    proto=3D$1
+    shift
     expect_list=3D"$@"
 
-    if [ -z "=
$expect_list" ] ; then return ; fi
-    if [ "$expect_list" =3D "-" ] ; the=
n return ; fi
+    if [ -z "$expect_list" ]; then return; fi
+    if [ "$ex=
pect_list" =3D "-" ]; then return; fi
 
-    for expect in $expect_list
-  =
  do
-	if get_ifconfig_route | fgrep "$expect" >/dev/null
-	then :
-	else
-=
	    fail "check_ifconfig(): expected IPv$proto address '$expect' not found=
 in ifconfig output=2E"
-	fi
+    for expect in $expect_list; do
+        i=
f get_ifconfig_route | fgrep "$expect" >/dev/null; then
+            :
+   =
     else
+            fail "check_ifconfig(): expected IPv$proto address '=
$expect' not found in ifconfig output=2E"
+        fi
     done
 }
 
@@ -25=
7,47 +257,48 @@
 #  arg3=2E=2E=2E -> fping arguments (host list)
 run_ping_=
tests()
 {
-    proto=3D$1 ; want=3D$2 ; shift ; shift
+    proto=3D$1
+   =
 want=3D$2
+    shift
+    shift
     targetlist=3D"$@"
 
     # "no target=
s" is fine
-    if [ -z "$targetlist" ] ; then return ; fi
+    if [ -z "$t=
argetlist" ]; then return; fi
 
     case $proto in
-	4) cmd=3D"$FPING" ;;
=
-	6) cmd=3D"$FPING6" ;;
-	*) echo "internal error in run_ping_tests arg 1: =
'$proto'" >&2
-	   exit 1 ;;
+        4) cmd=3D"$FPING" ;;
+        6) cmd=
=3D"$FPING6" ;;
+        *)
+            echo "internal error in run_ping_t=
ests arg 1: '$proto'" >&2
+            exit 1
+            ;;
     esac
 
 =
    case $want in
-	want_ok)   sizes_list=3D"64 1440 3000" ;;
-	want_fail) =
sizes_list=3D"64" ;;
+        want_ok) sizes_list=3D"64 1440 3000" ;;
+    =
    want_fail) sizes_list=3D"64" ;;
     esac
 
-    for bytes in $sizes_li=
st
-    do
-	output "run IPv$proto ping tests ($want), $bytes byte packets=
=2E=2E=2E"
+    for bytes in $sizes_list; do
+        output "run IPv$proto=
 ping tests ($want), $bytes byte packets=2E=2E=2E"
 
-	echo "$cmd -b $bytes=
 -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
-	$cmd=
 -b $bytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eo=
ut 2>&1
+        echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetli=
st" >>$LOGDIR/$SUF:fping=2Eout
+        $cmd -b $bytes -C 20 -p 250 -q $fpi=
ng_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
 
-	# while OpenVPN is =
running, pings must succeed (want=3D'want_ok')
-	# before OpenVPN is up, pi=
ngs must NOT succeed (want=3D'want_fail')
+        # while OpenVPN is runni=
ng, pings must succeed (want=3D'want_ok')
+        # before OpenVPN is up, =
pings must NOT succeed (want=3D'want_fail')
 
-	rc=3D$?
-	if [ $rc =3D 0 ] =
				# all ping OK
-	then
-	    if [ $want =3D "want_fail" ]		# not what we =
want
-	    then
-		fail "IPv$proto ping test succeeded, but needs to *fail*=
=2E"
-	    fi
-	else					# ping failed
-	    if [ $want =3D "want_ok" ]		# =
not what we wanted
-	    then
-		fail "IPv$proto ping test ($bytes bytes) f=
ailed, but should succeed=2E"
-	    fi
-	fi
+        rc=3D$?
+        if [ =
$rc =3D 0 ]; then                 # all ping OK
+            if [ $want =3D=
 "want_fail" ]; then # not what we want
+                fail "IPv$proto pi=
ng test succeeded, but needs to *fail*=2E"
+            fi
+        else   =
                            # ping failed
+            if [ $want =3D "want=
_ok" ]; then # not what we wanted
+                fail "IPv$proto ping tes=
t ($bytes bytes) failed, but should succeed=2E"
+            fi
+        fi=

     done
 }
 
@@ -308,8 +309,7 @@
 SUMMARY_SKIP=3D
 SUMMARY_FAIL=3D
 
-fo=
r SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # get confi=
g variables
     eval test_prep=3D\"\$PREPARE_$SUF\"
     eval test_check_s=
kip=3D\"\$CHECK_SKIP_$SUF\"
@@ -336,11 +336,13 @@
 
     if [ -n "$test_che=
ck_skip" ]; then
         output "check whether we need to skip: '$test_che=
ck_skip'"
-        if eval $test_check_skip; then :
+        if eval $test_=
check_skip; then
+            :
         else
             output "skip che=
ck failed, SKIP test $SUF=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	 =
   printf "$outbuf" ; continue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $=
SUF"
+            printf "$outbuf"
+            continue
         fi
     f=
i
 
@@ -355,13 +357,14 @@
     output "\nrun pre-openvpn ping tests - targe=
ts must not be reachable=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_=
hosts"
     run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_coun=
t" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0 ]; then
         output "OK=
=2E\n"
     else
-	fail "make sure that ping hosts are ONLY reachable via V=
PN, SKIP test $SUF=2E"
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D=
31
-	printf "$outbuf" ; continue
+        fail "make sure that ping hosts a=
re ONLY reachable via VPN, SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SUM=
MARY_FAIL $SUF"
+        exit_code=3D31
+        printf "$outbuf"
+        =
continue
     fi
 
     pidfile=3D"$LOGDIR_ABS/openvpn-$SUF=2Epid"
@@ -376,=
18 +379,17 @@
     # to $ovpn_init_check times=2E
     ovpn_init_check=3D30=

     ovpn_init_success=3D0
-    while [ $ovpn_init_check -gt 0 ];
-    do
=
-       sleep 1  # Wait for OpenVPN to initialize and have had time to writ=
e the pid file
-       grep "Initialization Sequence Completed" $LOGDIR/$SU=
F:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ]; then
-           ovpn_i=
nit_check=3D0
-           ovpn_init_success=3D1
-       fi
-       ovpn_ini=
t_check=3D$(( $ovpn_init_check - 1 ))
+    while [ $ovpn_init_check -gt 0 ]=
; do
+        sleep 1 # Wait for OpenVPN to initialize and have had time to=
 write the pid file
+        grep "Initialization Sequence Completed" $LOGD=
IR/$SUF:openvpn=2Elog >/dev/null
+        if [ $? -eq 0 ]; then
+          =
  ovpn_init_check=3D0
+            ovpn_init_success=3D1
+        fi
+     =
   ovpn_init_check=3D$(($ovpn_init_check - 1))
     done
 
-    opid=3D`cat=
 $pidfile`
+    opid=3D$(cat $pidfile)
     if [ -n "$opid" ]; then
       =
  output "  OpenVPN running with PID $opid"
     else
@@ -398,16 +400,17 @@=

     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
         output "=
$0:  OpenVPN did not initialize in a reasonable time"
         if [ -n "$op=
id" ]; then
-           $RUN_SUDO $KILL_EXEC $opid
+            $RUN_SUDO $=
KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EXEC $sudopid
-	output=
 "tail -5 $SUF:openvpn=2Elog"
-	output "`tail -5 $LOGDIR/$SUF:openvpn=2Elog=
`"
-	fail "skip rest of sub-tests for test run $SUF=2E"
-	trap - 0 1 2 3 15=

-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
-	printf "$outbuf" =
; continue
+        output "tail -5 $SUF:openvpn=2Elog"
+        output "$(=
tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+        fail "skip rest of sub-tests =
for test run $SUF=2E"
+        trap - 0 1 2 3 15
+        SUMMARY_FAIL=3D"$=
SUMMARY_FAIL $SUF"
+        exit_code=3D30
+        printf "$outbuf"
+     =
   continue
     fi
 
     # make sure openvpn client is terminated in case=
 shell exits
@@ -418,17 +421,16 @@
     output "save ifconfig+route"
     g=
et_ifconfig_route >$LOGDIR/$SUF:ifconfig_route=2Etxt
 
-    if [ "$expect_i=
fconfig4" =3D "-" ] ; then
+    if [ "$expect_ifconfig4" =3D "-" ]; then
  =
       output "skip ifconfig+route check"
     else
-	output -n "compare pr=
e-openvpn ifconfig+route with current values=2E=2E=2E"
-	if diff $LOGDIR/$S=
UF:ifconfig_route_pre=2Etxt \
-		$LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/nu=
ll
-	then
-	    fail "no differences between ifconfig/route before OpenVPN =
start and now=2E"
-	else
-	    output " OK!\n"
-	fi
+        output -n "com=
pare pre-openvpn ifconfig+route with current values=2E=2E=2E"
+        if d=
iff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
+            $LOGDIR/$SUF:ifcon=
fig_route=2Etxt >/dev/null; then
+            fail "no differences between =
ifconfig/route before OpenVPN start and now=2E"
+        else
+            =
output " OK!\n"
+        fi
     fi
 
     # post init script needed?
@@ -4=
49,8 +451,8 @@
     $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=3D$?
- =
   if [ $rc !=3D 0 ] ; then
-	fail "OpenVPN return code $rc, expect 0"
+   =
 if [ $rc !=3D 0 ]; then
+        fail "OpenVPN return code $rc, expect 0"
=
     fi
 
     output "\nsave post-openvpn ifconfig + route=2E=2E=2E"
@@ -4=
58,23 +460,22 @@
 
     output -n "compare pre- and post-openvpn ifconfig +=
 route=2E=2E=2E"
     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-	   =
 $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=
=2Etxt
-    then
-	output " OK=2E\n"
+        $LOGDIR/$SUF:ifconfig_route_p=
ost=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then
+        output " O=
K=2E\n"
     else
-	output "\n\n" "`cat $LOGDIR/$SUF:ifconfig_route_diff=2E=
txt`" "\n"
-	fail "differences between pre- and post-ifconfig/route=2E"
+  =
      output "\n\n" "$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)" "\n"
+ =
       fail "differences between pre- and post-ifconfig/route=2E"
     fi
-=
    if [ "$fail_count" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0 ]; then=

         output "test run $SUF: all tests OK=2E\n"
-	SUMMARY_OK=3D"$SUMMAR=
Y_OK $SUF"
+        SUMMARY_OK=3D"$SUMMARY_OK $SUF"
     else
-	if [ "$V" -=
gt 0 ] ; then
-	    printf "$outbuf"
-	    echo "test run $SUF: $fail_count=
 test failures=2E FAIL=2E"
+        if [ "$V" -gt 0 ]; then
+            pr=
intf "$outbuf"
+            echo "test run $SUF: $fail_count test failures=
=2E FAIL=2E"
         fi
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=
=3D30
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
=
     fi
 
     if [ -n "$test_cleanup" ]; then
@@ -484,9 +485,9 @@
 
 done
=
 
-if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=3D" none"; fi
-if [ -z "$SUMMA=
RY_SKIP" ] ; then SUMMARY_SKIP=3D" none"; fi
-if [ -z "$SUMMARY_FAIL" ] ; t=
hen SUMMARY_FAIL=3D" none"; fi
+if [ -z "$SUMMARY_OK" ]; then SUMMARY_OK=3D=
" none"; fi
+if [ -z "$SUMMARY_SKIP" ]; then SUMMARY_SKIP=3D" none"; fi
+if=
 [ -z "$SUMMARY_FAIL" ]; then SUMMARY_FAIL=3D" none"; fi
 echo "Test sets s=
ucceeded:$SUMMARY_OK=2E"
 echo "Test sets skipped:$SUMMARY_SKIP=2E"
 echo "=
Test sets failed:$SUMMARY_FAIL=2E"
diff --git a/tests/t_cltsrv=2Esh b/tests=
/t_cltsrv=2Esh
index 6b7df65=2E=2E03c3845 100755
--- a/tests/t_cltsrv=2Esh
=
+++ b/tests/t_cltsrv=2Esh
@@ -24,50 +24,58 @@
 trap "rm -f log=2E$$ log=2E$=
$=2Esignal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log=2E$$ log=2E$$=2Esign=
al ; exit 1" 0 3
 addopts=3D
-case `uname -s` in
+case $(uname -s) in
     =
FreeBSD)
-    # FreeBSD jails map the outgoing IP to the jail IP - we need =
to
-    # allow the real IP unless we want the test to run forever=2E
-    =
if test "`sysctl 2>/dev/null -n security=2Ejail=2Ejailed`" =3D 1 \
-    || =
ps -ostate=3D -p $$ | grep -q J; then
-	addopts=3D"--float"
-	if test "x`if=
config | grep inet`" =3D x ; then
-	    echo "###"
-	    echo "### To run t=
he test in a FreeBSD jail, you MUST add an IP alias for the jail's IP=2E"
-=
	    echo "###"
-	    exit 77
-	fi
-    fi
-    ;;
+        # FreeBSD jails=
 map the outgoing IP to the jail IP - we need to
+        # allow the real =
IP unless we want the test to run forever=2E
+        if test "$(sysctl 2>/=
dev/null -n security=2Ejail=2Ejailed)" =3D 1 ||
+            ps -ostate=3D =
-p $$ | grep -q J; then
+            addopts=3D"--float"
+            if te=
st "x$(ifconfig | grep inet)" =3D x; then
+                echo "###"
+    =
            echo "### To run the test in a FreeBSD jail, you MUST add an IP=
 alias for the jail's IP=2E"
+                echo "###"
+                e=
xit 77
+            fi
+        fi
+        ;;
 esac
 
 # make sure that th=
e --down script is executable -- fail (rather than
 # skip) test if it isn'=
t=2E
 downscript=3D"=2E=2E/tests/t_cltsrv-down=2Esh"
 root=3D"${top_srcdir}=
/sample"
-test -x "${root}/${downscript}" || chmod +x "${root}/${downscript=
}" || { echo >&2 "${root}/${downscript} is not executable, failing=2E" ; ex=
it 1 ; }
+test -x "${root}/${downscript}" || chmod +x "${root}/${downscript=
}" || {
+    echo >&2 "${root}/${downscript} is not executable, failing=2E"=

+    exit 1
+}
 echo "The following test will take about two minutes=2E" >=
&2
 echo "If the addresses are in use, this test will retry up to two times=
=2E" >&2
 
 # go
 success=3D0
-for i in 1 2 3 ; do
-  set +e
-  (
-  "${ope=
nvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role srv --do=
wn "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-files=
/loopback-server" &
-  "${openvpn}" --script-security 2 --cd "${top_srcdir}=
/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-exit --p=
ing-exit 180 --config "sample-config-files/loopback-client"
-  ) 3>log=2E$$=
=2Esignal >log=2E$$ 2>&1
-  e1=3D$?
-  wait $!
-  e2=3D$?
-  grep 'TCP/UDP:=
 Socket bind failed on local address=2E*in use' log=2E$$ >/dev/null && {
- =
   echo 'address in use, retrying in 150 s'
-    sleep 150
-    continue
- =
 }
-  grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && { cat log=2E$$=
=2Esignal ; echo ; cat log=2E$$ ; exit 1 ; }
-  success=3D1
-  break
+for i=
 in 1 2 3; do
+    set +e
+    (
+        "${openvpn}" --script-security 2 =
--cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --tls-ex=
it --ping-exit 180 --config "sample-config-files/loopback-server" &
+      =
  "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addopts} -=
-setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --config=
 "sample-config-files/loopback-client"
+    ) 3>log=2E$$=2Esignal >log=2E$$=
 2>&1
+    e1=3D$?
+    wait $!
+    e2=3D$?
+    grep 'TCP/UDP: Socket bin=
d failed on local address=2E*in use' log=2E$$ >/dev/null && {
+        echo=
 'address in use, retrying in 150 s'
+        sleep 150
+        continue
+=
    }
+    grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && {
+        =
cat log=2E$$=2Esignal
+        echo
+        cat log=2E$$
+        exit 1
+=
    }
+    success=3D1
+    break
 done
 
 set -e
@@ -75,14 +83,14 @@
 # ex=
it code - defaults to 0, PASS
 ec=3D0
 
-if [ $success !=3D 1 ] ; then
-  #=
 couldn't run test -- addresses in use, skip test
-  cat log=2E$$
-  ec=3D7=
7
-elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then
-  # failure -- fail test
-=
  cat log=2E$$
-  ec=3D1
+if [ $success !=3D 1 ]; then
+    # couldn't run =
test -- addresses in use, skip test
+    cat log=2E$$
+    ec=3D77
+elif [ =
$e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then
+    # failure -- fail test
+    cat l=
og=2E$$
+    ec=3D1
 fi
 
 rm log=2E$$ log=2E$$=2Esignal
diff --git a/tests=
/t_lpback=2Esh b/tests/t_lpback=2Esh
index 6802506=2E=2E058206f 100755
--- =
a/tests/t_lpback=2Esh
+++ b/tests/t_lpback=2Esh
@@ -37,51 +37,56 @@
 test_s=
tart()
 {
     case $V in
-        0) outbuf=3D"" ;;                  # no =
per-test output at all
-        1) outbuf=3D"$@" ;;                # compac=
t, details only on failure
-        *) printf "$@" ;;                # prin=
t all
+        0) outbuf=3D"" ;;   # no per-test output at all
+        1) =
outbuf=3D"$@" ;; # compact, details only on failure
+        *) printf "$@"=
 ;; # print all
     esac
 }
 test_end()
 {
-    RC=3D$1 ; LOG=3D$2
-    if=
 [ $RC !=3D 0 ]
-    then
+    RC=3D$1
+    LOG=3D$2
+    if [ $RC !=3D 0 ]=
; then
         case $V in
-            0) ;;                              =
  # no per-test output
-            1) echo "$outbuf" "FAIL (RC=3D$RC)"; ca=
t $LOG ;;
-            *) echo "FAIL (RC=3D$RC)"; cat $LOG ;;
+            =
0) ;; # no per-test output
+            1)
+                echo "$outbuf" =
"FAIL (RC=3D$RC)"
+                cat $LOG
+                ;;
+          =
  *)
+                echo "FAIL (RC=3D$RC)"
+                cat $LOG
+   =
             ;;
         esac
         e=3D1
-        tests_failed=3D$(( $t=
ests_failed + 1 ))
+        tests_failed=3D$(($tests_failed + 1))
     else=

         case $V in
-            0|1) ;;                              # no=
 per-test output for 'OK'
-            *) echo "OK"                        =
 # print all
+            0 | 1) ;;       # no per-test output for 'OK'
+  =
          *) echo "OK" ;; # print all
         esac
-        tests_passed=
=3D$(( $tests_passed + 1 ))
+        tests_passed=3D$(($tests_passed + 1))
=
     fi
 }
 
 # if running with V=3D1, give an indication what test runs no=
w
-if [ "$V" =3D 1  ] ; then
+if [ "$V" =3D 1 ]; then
     echo "$0: runnin=
g with V=3D$V, only printing test fails"
 fi
 
-
 # Get list of supported c=
iphers from openvpn --show-ciphers output
-CIPHERS=3D$(${openvpn} --show-ci=
phers | \
-            sed -e '/The following/,/^$/d' -e s'/ =2E*//' -e '/^=
[[:space:]]*$/d')
+CIPHERS=3D$(${openvpn} --show-ciphers |
+    sed -e '/Th=
e following/,/^$/d' -e s'/ =2E*//' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-06=
-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (se=
e http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867), so exclude
 #=
 that cipher from this test=2E
 # GD, 2014-07-06 so is DES-CFB1
 # GD, 2014=
-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
-CIPHER=
S=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
+CIPHER=
S=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)')
 
 e=3D0=

-if [ -z "$CIPHERS" ] ; then
+if [ -z "$CIPHERS" ]; then
     echo "'openv=
pn --show-ciphers' FAILED (empty list)"
     e=3D1
 fi
@@ -91,10 +96,9 @@
 =

 set +e
 
-for cipher in ${CIPHERS}
-do
+for cipher in ${CIPHERS}; do
    =
 test_start "Testing cipher ${cipher}=2E=2E=2E "
-    ( "${openvpn}" --test=
-crypto --cipher ${cipher} ) >log=2E$$ 2>&1
+    ("${openvpn}" --test-crypt=
o --cipher ${cipher}) >log=2E$$ 2>&1
     test_end $? log=2E$$
 done
 
@@ -=
121,7 +125,7 @@
     >log=2E$$ 2>&1
 test_end $? log=2E$$
 
-if [ "$V" -ge =
1  ] ; then
+if [ "$V" -ge 1 ]; then
     echo "$0: tests passed: $tests_pa=
ssed  failed: $tests_failed"
 fi
 
diff --git a/tests/t_net=2Esh b/tests/t_=
net=2Esh
index 8134832=2E=2E17e028e 100755
--- a/tests/t_net=2Esh
+++ b/tes=
ts/t_net=2Esh
@@ -9,7 +9,6 @@
 top_builddir=3D"${top_builddir:-=2E=2E}"
 op=
envpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
-
 # bail out r=
ight away on non-linux=2E NetLink (the object of this test) is only
 # used=
 on Linux, therefore testing other platform is not needed=2E
 #
@@ -69,7 +6=
8,6 @@
     done
 }
 
-
 ## execution starts here
 
 # t_client=2Erc requir=
ed only for RUN_SUDO definition
@@ -89,21 +87,18 @@
     exit 77
 fi
 
-
 #=
 Ensure PREFER_KSU is in a known state
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
 =
# make sure we have permissions to run the networking unit-test
-ID=3D`id`
=
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+ID=3D$(id)
+if expr "$ID" : =
"uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
=
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we ha=
ve a valid kerberos ticket
         klist -l 1>/dev/null 2>/dev/null
-     =
   if [ $? -ne 0 ];
-        then
+        if [ $? -ne 0 ]; then
          =
   # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
          =
   PREFER_KSU=3D0
             echo "$0: No Kerberos ticket available=2E  W=
ill not use ksu=2E"
@@ -112,16 +107,14 @@
         fi
     fi
 
-    if [ -=
z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "$=
0: no RUN_SUDO=3D=2E=2E=2E in t_client=2Erc or environment, defaulting to '=
sudo'=2E" >&2
         echo "      if that does not work, set RUN_SUDO=3D c=
orrectly for your system=2E" >&2
         RUN_SUDO=3D"sudo"
     fi
 
     =
# check that we can run the unit-test binary with sudo
-    if $RUN_SUDO $U=
NIT_TEST test
-    then
+    if $RUN_SUDO $UNIT_TEST test; then
         ec=
ho "$0: $RUN_SUDO $UNIT_TEST succeeded, good=2E"
     else
         echo "$=
0: $RUN_SUDO $UNIT_TEST failed, cannot go on=2E SKIP=2E" >&2
diff --git a/t=
ests/t_server_null=2Esh b/tests/t_server_null=2Esh
index 74ffd52=2E=2Ec6336=
14 100755
--- a/tests/t_server_null=2Esh
+++ b/tests/t_server_null=2Esh
@@ =
-2,7 +2,7 @@
 #
 TSERVER_NULL_SKIP_RC=3D"${TSERVER_NULL_SKIP_RC:-77}"
 
-if=
 ! [ -r "=2E/t_server_null=2Erc" ] ; then
+if ! [ -r "=2E/t_server_null=2Er=
c" ]; then
     echo "${0}: cannot find '=2E/t_server_null=2Erc=2E SKIPPING=
 TEST=2E'" >&2
     exit "${TSERVER_NULL_SKIP_RC}"
 fi
@@ -22,11 +22,10 @@
=
 # make sure we have permissions to run ifconfig/route from OpenVPN
 # can'=
t use "id -u" here - doesn't work on Solaris
 ID=3D$(id)
-if expr "$ID" : "=
uid=3D0" >/dev/null
-then :
+if expr "$ID" : "uid=3D0" >/dev/null; then
+  =
  :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_=
KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
   =
      if klist -l 1>/dev/null 2>/dev/null; then
             RUN_SUDO=3D"ks=
u -q -e"
@@ -37,26 +36,24 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO"=
 ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
         echo "${0}: this tes=
t must run be as root, or RUN_SUDO=3D=2E=2E=2E " >&2
         echo "      m=
ust be set correctly in 't_server_null=2Erc'=2E SKIP=2E" >&2
         exit =
"${TSERVER_NULL_SKIP_RC}"
     else
-	# Run a no-op command with privilege =
escalation (e=2Eg=2E sudo) so that
-	# we (hopefully) do not have to ask th=
e users password during the test=2E
-	if $RUN_SUDO "${KILL_EXEC}" -0 $$
-	t=
hen
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
-	else
-	=
    echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&=
2
-	    exit "${TSERVER_NULL_SKIP_RC}"
-	fi
+        # Run a no-op command =
with privilege escalation (e=2Eg=2E sudo) so that
+        # we (hopefully)=
 do not have to ask the users password during the test=2E
+        if $RUN_=
SUDO "${KILL_EXEC}" -0 $$; then
+            echo "${0}: $RUN_SUDO $KILL_EX=
EC -0 succeeded, good=2E"
+        else
+            echo "${0}: $RUN_SUDO =
$KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+            exit "${TSE=
RVER_NULL_SKIP_RC}"
+        fi
     fi
 fi
 
 srcdir=3D"${srcdir:-=2E}"
-e=
xport t_server_null_logdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%H%M%S`=

+export t_server_null_logdir=3Dt_server_null-$(hostname)-$(date +%Y%m%d-%H=
%M%S)
 
 # Create directory for server and client logs
 mkdir $t_server_nul=
l_logdir
diff --git a/tests/t_server_null_client=2Esh b/tests/t_server_null=
_client=2Esh
index 1745de5=2E=2E3203cc2 100755
--- a/tests/t_server_null_cl=
ient=2Esh
+++ b/tests/t_server_null_client=2Esh
@@ -1,9 +1,10 @@
 #!/bin/sh=

 
-should_run_test() {
+should_run_test()
+{
     test_name=3D"$1"
 
-    =
if echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | grep -=
q _lwip; then
         if [ "$has_lwipovpn" =3D "no" ]; then
             r=
eturn 1
         fi
@@ -12,7 +13,8 @@
     return 0
 }
 
-launch_client() {=

+launch_client()
+{
     test_name=3D$1
     log=3D"${test_name}=2Elog"
  =
   pid=3D"${test_name}=2Epid"
@@ -30,7 +32,8 @@
         --log "${t_server_=
null_logdir}/${log}" &
 }
 
-ping_and_kill() {
+ping_and_kill()
+{
     if =
fping -q -c 5 $1; then
         echo "PASS: fping lwipovpn client $target"
=
     else
@@ -46,9 +49,10 @@
     kill -15 $2
 }
 
-ping_lwip_clients() {
+=
ping_lwip_clients()
+{
     if [ "$has_lwipovpn" =3D "yes" ]; then
-       =
 lwip_client_count=3D$(echo "$lwip_test_names"|wc -w|tr -d " ")
+        lw=
ip_client_count=3D$(echo "$lwip_test_names" | wc -w | tr -d " ")
     else
=
         lwip_client_count=3D0
     fi
@@ -60,10 +64,10 @@
     count=3D0
 =
    maxcount=3D10
     while [ $count -le $maxcount ]; do
-        lwip_cli=
ent_ips=3D$(cat =2E/*=2Elwip 2>/dev/null|wc -l)
+        lwip_client_ips=3D=
$(cat =2E/*=2Elwip 2>/dev/null | wc -l)
         if [ $lwip_client_ips -lt =
$lwip_client_count ]; then
             echo "Waiting for LWIP clients to s=
tart up ($count/$maxcount)"
-            count=3D$(( count + 1))
+         =
   count=3D$((count + 1))
             sleep 1
         else
             e=
cho "$lwip_client_ips/$lwip_client_count LWIP clients up"
@@ -73,8 +77,8 @@=

 
     wait_pids=3D""
     for line in $(cat =2E/*=2Elwip 2>/dev/null); do=

-        target_ip=3D$(echo $line|cut -d "," -f 1)
-        client_pid=3D$=
(echo $line|cut -d "," -f 2)
+        target_ip=3D$(echo $line | cut -d ","=
 -f 1)
+        client_pid=3D$(echo $line | cut -d "," -f 2)
         ping_=
and_kill $target_ip $client_pid &
         wait_pids=3D"$wait_pids $!"
    =
 done
@@ -84,7 +88,8 @@
     test -e =2E/lwip_failed && return 1 || return =
0
 }
 
-wait_for_results() {
+wait_for_results()
+{
     tests_running=3D"y=
es"
 
     # Wait a bit to allow an OpenVPN client process to create a pidf=
ile to
@@ -106,12 +111,13 @@
     done
 }
 
-get_client_test_result() {
+ge=
t_client_test_result()
+{
     test_name=3D$1
     should_pass=3D$2
     lo=
g=3D"${test_name}=2Elog"
 
-    grep "Initialization Sequence Completed" "$=
{t_server_null_logdir}/${log}" > /dev/null
+    grep "Initialization Sequen=
ce Completed" "${t_server_null_logdir}/${log}" >/dev/null
     exit_code=3D=
$?
 
     if [ $exit_code -eq 0 ] && [ "${should_pass}" =3D "yes" ]; then
@=
@ -144,7 +150,7 @@
 server_max_wait=3D15
 while [ $count -lt $server_max_wa=
it ]; do
     servers_up=3D0
-    server_count=3D$(echo "$TEST_SERVER_LIST"=
|wc -w|tr -d " ")
+    server_count=3D$(echo "$TEST_SERVER_LIST" | wc -w | =
tr -d " ")
 
     # We need to trim single-quotes because some shells retur=
n quoted values
     # and some don't=2E Using "set -o posix" which would r=
esolve this problem is
@@ -152,13 +158,13 @@
     #
     # While inactive s=
erver configurations may get checked they won't increase
     # the active =
server count as the processes won't be running=2E
-    for i in $(set|grep =
'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"); do
-        server_pid=3D$(=
cat "$i=2Epid" 2> /dev/null)
-        if [ -z "$server_pid" ] ; then
+    f=
or i in $(set | grep 'SERVER_NAME_' | cut -d "=3D" -f 2 | tr -d "[\']"); do=

+        server_pid=3D$(cat "$i=2Epid" 2>/dev/null)
+        if [ -z "$ser=
ver_pid" ]; then
             continue
         fi
-        if $RUN_SUDO ki=
ll -0 $server_pid > /dev/null 2>&1; then
-            servers_up=3D$(( $ser=
vers_up + 1 ))
+        if $RUN_SUDO kill -0 $server_pid >/dev/null 2>&1; t=
hen
+            servers_up=3D$(($servers_up + 1))
         fi
     done
 
=
@@ -168,7 +174,7 @@
         retval=3D0
         break
     else
-        c=
ount=3D$(( count + 1))
+        count=3D$((count + 1))
         sleep 1
   =
  fi
 
@@ -199,15 +205,14 @@
 # safe to check the test results=2E
 test_nam=
es=3D""
 lwip_test_names=3D""
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $T=
EST_RUN_LIST; do
     eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval clien=
t_exec=3D\"\$CLIENT_EXEC_$SUF\"
     eval client_conf=3D\"\$CLIENT_CONF_$SU=
F\"
 
     test_names=3D"${test_names} ${test_name}"
 
-    if echo "$test_=
name"|grep -q _lwip; then
+    if echo "$test_name" | grep -q _lwip; then
 =
        lwip_test_names=3D"${lwip_test_names} ${test_name}"
     fi
 
@@ -2=
19,13 +224,11 @@
 ping_lwip_clients
 retval=3D$?
 
-
 # Wait until all Open=
VPN clients have exited
 (wait_for_results)
 
 # Check test results
-for SU=
F in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     eval test_name=
=3D\"\$TEST_NAME_$SUF\"
     eval should_pass=3D\"\$SHOULD_PASS_$SUF\"
 
di=
ff --git a/tests/t_server_null_server=2Esh b/tests/t_server_null_server=2Es=
h
index e1775f0=2E=2Ea8d7268 100755
--- a/tests/t_server_null_server=2Esh
+=
++ b/tests/t_server_null_server=2Esh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-launch_s=
erver() {
+launch_server()
+{
     server_name=3D$1
     server_exec=3D$2
 =
    server_conf=3D$3
@@ -17,10 +18,10 @@
 
     # Try to launch the server
=
     $RUN_SUDO "${server_exec}" \
-               $server_conf \
-         =
      --status "${status}" 1 \
-               --writepid "${pid}" \
-     =
          --explicit-exit-notify 3 > "$log" 2>&1 &
+        $server_conf \
=
+        --status "${status}" 1 \
+        --writepid "${pid}" \
+        -=
-explicit-exit-notify 3 >"$log" 2>&1 &
 
     sleep 1
 
@@ -44,8 +45,7 @@
 =
retval=3D0
 
 # Launch test servers
-for SUF in $TEST_SERVER_LIST
-do
+for =
SUF in $TEST_SERVER_LIST; do
     eval server_name=3D\"\$SERVER_NAME_$SUF\"=

     eval server_exec=3D\"\$SERVER_EXEC_$SUF\"
     eval server_conf=3D\"\=
$SERVER_CONF_$SUF\"
@@ -57,8 +57,7 @@
 # the test run=2E
 #
 export server_=
pid_files=3D""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_L=
IST; do
     eval server_name=3D\"\$SERVER_NAME_$SUF\"
     server_pid_file=
s=3D"${server_pid_files} =2E/${server_name}=2Epid"
 done
@@ -69,12 +68,11 @=
@
 count=3D0
 maxcount=3D4
 while [ $count -le $maxcount ]; do
-    if ls t=
_server_null_client=2Esh*=2Epid > /dev/null 2>&1
-    then
+    if ls t_ser=
ver_null_client=2Esh*=2Epid >/dev/null 2>&1; then
         count=3D0
      =
   sleep 1
     else
-	count=3D$(( count + 1))
+        count=3D$((count + =
1))
         sleep 1
     fi
 done
@@ -85,11 +83,10 @@
 # server process do=
es not exit in 15 seconds assume it never will, move on and
 # hope for the=
 best=2E
 echo "Waiting for servers to exit"
-for PID_FILE in $server_pid_f=
iles
-do
+for PID_FILE in $server_pid_files; do
     SERVER_PID=3D$(cat "${=
PID_FILE}")
 
-    if [ -z "$SERVER_PID" ] ; then
+    if [ -z "$SERVER_PID=
" ]; then
         echo "WARNING: could not kill server ${PID_FILE}!"
     =
    continue
     fi
@@ -99,17 +96,16 @@
 
     count=3D0
     maxcount=3D7=
5
-    while [ $count -le $maxcount ]
-    do
-        $RUN_SUDO kill -0 "$=
{SERVER_PID}" 2> /dev/null || break
-        count=3D$(( count + 1))
+    w=
hile [ $count -le $maxcount ]; do
+        $RUN_SUDO kill -0 "${SERVER_PID}=
" 2>/dev/null || break
+        count=3D$((count + 1))
         sleep 0=2E2=

     done
 
     # If server is still up send a SIGKILL
     if [ $count -=
ge $maxcount ]; then
         $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
-    =
    SERVER_NAME=3D$(basename $PID_FILE|cut -d =2E -f 1)
+        SERVER_NAM=
E=3D$(basename $PID_FILE | cut -d =2E -f 1)
         echo "ERROR: had to se=
nd SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!"
         echo =
"Tail of server log:"
         tail -n 20 "${t_server_null_logdir}/${SERVER=
_NAME}=2Elog"
diff --git a/tests/t_server_null_stress=2Esh b/tests/t_server=
_null_stress=2Esh
index 0bb9452=2E=2E2fc9fde 100755
--- a/tests/t_server_nu=
ll_stress=2Esh
+++ b/tests/t_server_null_stress=2Esh
@@ -7,8 +7,7 @@
 =2E =
=2E/t_server_null_default=2Erc
 
 export pid_files=3D""
-for SUF in $TEST_S=
ERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=3D\"=
\$SERVER_NAME_$SUF\"
     pid_files=3D"${pid_files} =2E/${server_name}=2Epi=
d"
 done
@@ -18,16 +17,16 @@
 
 count=3D0
 while [ $count -lt $ITERATIONS ]=
; do
-    count=3D$(( count + 1 ))
-    make check TESTS=3Dt_server_null=2E=
sh SUBDIRS=3D > /dev/null 2>&1
+    count=3D$((count + 1))
+    make check =
TESTS=3Dt_server_null=2Esh SUBDIRS=3D >/dev/null 2>&1
     retval=3D$?
 
- =
   echo "Iteration ${count}: return value ${retval}" >> "${LOG_BASEDIR}/mak=
e-check=2Elog"
+    echo "Iteration ${count}: return value ${retval}" >>"${=
LOG_BASEDIR}/make-check=2Elog"
     if [ $retval -ne 0 ]; then
-	DIR=3D"${L=
OG_BASEDIR}/make-check-${count}"
+        DIR=3D"${LOG_BASEDIR}/make-check-=
${count}"
         mkdir -p "${DIR}"
         cp t_server_null*=2Elog "${DI=
R}/"
         cp test-suite=2Elog "${DIR}/"
-        ps aux|grep openvpn|gr=
ep -vE '(suppress|grep)' > "${DIR}/psaux"
+        ps aux | grep openvpn | =
grep -vE '(suppress|grep)' >"${DIR}/psaux"
     fi
 done
diff --git a/tests=
/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh
index 96e3826=2E=
=2E777a286 100755
--- a/tests/update_t_client_ips=2Esh
+++ b/tests/update_t=
_client_ips=2Esh
@@ -5,12 +5,12 @@
 
 RC=3D"$TOP_BUILDDIR/t_client_ips=2Erc=
"
 
-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1
+grep EXPECT_IF=
CONFIG4_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "E=
XPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $RC
+    echo "EXPECT_IFCONF=
IG4_$TESTNUM=3D$ifconfig_local" >>$RC
 fi
 
-grep EXPECT_IFCONFIG6_$TESTNUM=
=3D $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC >/dev/null =
2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfi=
g_ipv6_local" >> $RC
+    echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_=
local" >>$RC
 fi

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1793?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Gerrit-Change-Number: 1793
Gerrit=
-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--k3P89T7fhDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">Reformat all shell-scrip=
ts with shfmt<br><br>According to =2E/dev-tools/reformat-shell=2Esh=2E<br><=
br>Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1793<br>Message-Id: &lt;20260820091539=2E4592-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg38547=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/git-pre-commit-format=2Esh=
<br>M dev-tools/run-cppcheck=2Esh<br>M dev-tools/update-copyright=2Esh<br>M=
 tests/lwip_client_up=2Esh<br>M tests/null_client_up=2Esh<br>M tests/t_clie=
nt=2Esh=2Ein<br>M tests/t_cltsrv=2Esh<br>M tests/t_lpback=2Esh<br>M tests/t=
_net=2Esh<br>M tests/t_server_null=2Esh<br>M tests/t_server_null_client=2Es=
h<br>M tests/t_server_null_server=2Esh<br>M tests/t_server_null_stress=2Esh=
<br>M tests/update_t_client_ips=2Esh<br>14 files changed, 386 insertions(+)=
, 385 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/93/1793/5</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tool=
s/git-pre-commit-format=2Esh b/dev-tools/git-pre-commit-format=2Esh</span><=
br><span>index 9b2ecaf=2E=2E3507289 100755</span><br><span>--- a/dev-tools/=
git-pre-commit-format=2Esh</span><br><span>+++ b/dev-tools/git-pre-commit-f=
ormat=2Esh</span><br><span>@@ -26,7 +26,6 @@</span><br><span> # OR TORT (IN=
CLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE</span><b=
r><span> # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAM=
AGE=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> # git pre-commit hook that runs a stylecheck=2E</span>=
<br><span> # Features:</span><br><span> #  - abort commit when commit does =
not comply with the style guidelines</span><br><span>@@ -43,12 +42,11 @@</s=
pan><br><span> # exit on error</span><br><span> set -e</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # If c=
alled so, install this script as pre-commit hook</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-if [ &quot;$1&quot; =3D &quot;install&quot; ] ; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$1&q=
uot; =3D &quot;install&quot; ]; then</span><br><span>     TARGET=3D&quot;$(=
git rev-parse --git-path hooks)/pre-commit&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -e &quot;$TARGET&quot=
; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ =
-e &quot;$TARGET&quot; ]; then</span><br><span>         printf &quot;$TARGE=
T file exists=2E Won&#39;t overwrite=2E\n&quot;</span><br><span>         pr=
intf &quot;Aborting installation=2E\n&quot;</span><br><span>         exit 1=
</span><br><span>@@ -62,18 +60,19 @@</span><br><span> fi</span><br><span> <=
/span><br><span> # check whether the given file matches any of the set exte=
nsions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-matches_extensi=
on() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+matches_exten=
sion()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span>     local filename=3D&quot;$(basename -- &quot;$1&quot;)&quot;</span>=
<br><span>     local extension=3D&quot;=2E${filename##*=2E}&quot;</span><br=
><span>     local ext</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for ext in =2Ec =2Eh ; do [ &quot;$ext&quot; =3D &quo=
t;$extension&quot; ] &amp;&amp; return 0; done</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for ext in =2Ec =2Eh; do [ &quot;$ext&quot; =
=3D &quot;$extension&quot; ] &amp;&amp; return 0; done</span><br><span> </s=
pan><br><span>     return 1</span><br><span> }</span><br><span> </span><br>=
<span> # necessary check for initial commit</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-if git rev-parse --verify HEAD &gt;/dev/null 2&gt;&am=
p;1 ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if git re=
v-parse --verify HEAD &gt;/dev/null 2&gt;&amp;1; then</span><br><span>     =
against=3DHEAD</span><br><span> else</span><br><span>     # Initial commit:=
 diff against an empty tree object</span><br><span>@@ -88,8 +87,8 @@</span>=
<br><span> </span><br><span>     # Allow to use in parallel with pre-commit=
</span><br><span>     if [ $(basename &quot;$0&quot;) =3D &quot;pre-commit=
=2Elegacy&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-       echo &quot;Skipping clang-format check in favor of pre-commit&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       exit 0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;Skippin=
g clang-format check in favor of pre-commit&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        exit 0</span><br><span>     fi</span>=
<br><span> else</span><br><span>     TOOL=3Duncrustify</span><br><span>@@ -=
98,7 +97,7 @@</span><br><span>     TOOL_CMD=3D&quot;$TOOL_BIN -q -l C -c $U=
NCRUST_CONFIG&quot;</span><br><span> </span><br><span>     # make sure the =
config file is correctly set</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if [ ! -f &quot;$UNCRUST_CONFIG&quot; ] ; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ ! -f &quot;$UNCRUST_CONFIG&q=
uot; ]; then</span><br><span>         printf &quot;Error: uncrustify config=
 file not found=2E\n&quot;</span><br><span>         printf &quot;Expected t=
o find it at $UNCRUST_CONFIG=2E\n&quot;</span><br><span>         printf &qu=
ot;Aborting commit=2E\n&quot;</span><br><span>@@ -106,7 +105,7 @@</span><br=
><span>     fi</span><br><span> fi</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$TOOL_BIN&quot; ] ; then</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$TOOL_BIN&=
quot; ]; then</span><br><span>     printf &quot;Error: $TOOL executable not=
 found=2E\n&quot;</span><br><span>     printf &quot;Is it installed and in =
your \$PATH?\n&quot;</span><br><span>     printf &quot;Aborting commit=2E\n=
&quot;</span><br><span>@@ -120,44 +119,43 @@</span><br><span> # create one =
patch containing all changes to the files</span><br><span> # sed to remove =
quotes around the filename, if inserted by the system</span><br><span> # (d=
one sometimes, if the filename contains special characters, like the quote =
itself)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-git diff-index=
 --cached --diff-filter=3DACMR --name-only $against -- | \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-sed -e &#39;s/^&quot;\(=2E*\)&quot;$/\=
1/&#39; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-while read=
 file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    # ignore file if we do check fo=
r file extensions and the file</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    # does not match the extensions =2Ec or =2Eh</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if ! matches_extension &quot;$file&=
quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
ntinue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+git diff-index --cached --d=
iff-filter=3DACMR --name-only $against -- |</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    sed -e &#39;s/^&quot;\(=2E*\)&quot;$/\1/&#39; |=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while read file=
; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # ignor=
e file if we do check for file extensions and the file</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        # does not match the extensions =
=2Ec or =2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if ! matches_extension &quot;$file&quot;; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            continue</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        fi</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    # escape special characters in the =
target filename:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #=
 phase 1 (characters escaped in the output diff):</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;: backslash needs to be =
escaped in the output diff</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    #     - &#39;&quot;&#39;: quote needs to be escaped in the output =
diff if present inside</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    #            of the filename, as it used to bracket the entire filenam=
e part</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # phase 2 (=
characters escaped in the match replacement):</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;: backslash needs to be esca=
ped again for sed itself</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    #            (i=2Ee=2E double escaping after phase 1)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;&amp;&#39;: would e=
xpand to matched string</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    #     - &#39;|&#39;: used as sed split char instead of &#39;/&#39;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    # printf %s particul=
arly important if the filename contains the % character</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    file_escaped_target=3D$(printf &quot;=
%s&quot; &quot;$file&quot; | sed -e &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39=
;s/[\&amp;|]/\\&amp;/g&#39;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # escape special characters in the target filename:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # phase 1 (charact=
ers escaped in the output diff):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        #     - &#39;\&#39;: backslash needs to be escaped in =
the output diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    #     - &#39;&quot;&#39;: quote needs to be escaped in the output diff =
if present inside</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      #            of the filename, as it used to bracket the entire filena=
me part</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # ph=
ase 2 (characters escaped in the match replacement):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        #     - &#39;\&#39;: backslash ne=
eds to be escaped again for sed itself</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        #            (i=2Ee=2E double escaping after pha=
se 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     =
- &#39;&amp;&#39;: would expand to matched string</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        #     - &#39;|&#39;: used as sed spli=
t char instead of &#39;/&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # printf %s particularly important if the filename contai=
ns the % character</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       file_escaped_target=3D$(printf &quot;%s&quot; &quot;$file&quot; | se=
d -e &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # =
uncrustify our sourcefile, create a patch with diff and append it to our $p=
atch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # The sed cal=
l is necessary to transform the patch from</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    #    --- - timestamp</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    #    +++ $tmpout timestamp</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    # to both lines working on the same fi=
le and having a a/ and b/ prefix=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    # Else it can not be applied with &#39;git apply&#39;=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    git show &quot;:$f=
ile&quot; | $TOOL_CMD &gt; &quot;$tmpout&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    git show &quot;:$file&quot; | diff -u -- - &qu=
ot;$tmpout&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       sed -e &quot;1s|--- -|--- \&quot;b/$file_escaped_target\&quot;|&quot=
; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_escaped_target\&quot;|&quot; &=
gt;&gt; &quot;$patch&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # =
uncrustify our sourcefile, create a patch with diff and append it to our $p=
atch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # The s=
ed call is necessary to transform the patch from</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        #    --- - timestamp</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        #    +++ $tmpout timestamp</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        # to both line=
s working on the same file and having a a/ and b/ prefix=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # Else it can not be applie=
d with &#39;git apply&#39;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        git show &quot;:$file&quot; | $TOOL_CMD &gt;&quot;$tmpout=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        git s=
how &quot;:$file&quot; | diff -u -- - &quot;$tmpout&quot; |</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            sed -e &quot;1s|--- -|-=
-- \&quot;b/$file_escaped_target\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ =
\&quot;a/$file_escaped_target\&quot;|&quot; &gt;&gt;&quot;$patch&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span=
> </span><br><span> rm -f &quot;$tmpout&quot;</span><br><span> </span><br><=
span> # if no patch has been generated all is ok, clean up the file stub an=
d exit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -s &quot=
;$patch&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+if [ ! -s &quot;$patch&quot; ]; then</span><br><span>     rm -f &quot;$p=
atch&quot;</span><br><span>     exit 0</span><br><span> fi</span><br><span>=
@@ -165,7 +163,7 @@</span><br><span> # a patch has been created, notify the=
 user and exit</span><br><span> printf &quot;Formatting of some code does n=
ot follow the project guidelines=2E\n&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-if [ $(wc -l &lt; $patch) -gt 80 ] =
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ $(wc -l =
&lt;$patch) -gt 80 ]; then</span><br><span>     printf &quot;The file $patc=
h contains the necessary fixes=2E\n&quot;</span><br><span> else</span><br><=
span>     printf &quot;Here&#39;s the patch that fixes the formatting:\n\n&=
quot;</span><br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/=
run-cppcheck=2Esh</span><br><span>index 40db33e=2E=2Ea7aa3c4 100755</span><=
br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/=
run-cppcheck=2Esh</span><br><span>@@ -20,24 +20,23 @@</span><br><span>  --c=
heck-level=3Dexhaustive --max-configs=3D10 \</span><br><span>  --error-exit=
code=3D1&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> set -x</span><br><span> </span><br><span> mkdi=
r -p &quot;$CPPCHECK_DIR&quot;</span><br><span> cd &quot;${SOURCE_DIR}&quot=
;</span><br><span> cppcheck $COMMON_ARGS $INCLUDE_FLAGS \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         --platform=3Dunix64 \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         --library=3Dposix=2Ec=
fg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         -U_WIN32 \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         src/openvpn/ src/compat/ src/plugins/ sam=
ple/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         tests/=
unit_tests/example_test/ tests/unit_tests/openvpn/ \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         tests/unit_tests/plugins/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    --platform=3Dunix64 \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    --library=3Dposix=
=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    -U_WIN32 \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    src/openvpn/ src/compat/ src/plugins/ samp=
le/ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit=
_tests/example_test/ tests/unit_tests/openvpn/ \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tests/unit_tests/plugins/</span><br><span>=
 cppcheck $COMMON_ARGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         --platform=3Dwin64 \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         --library=3Dwindows=2Ecfg \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         -D_WIN32 \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_O=
PENBSD -UTARGET_NETBSD \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAG=
ONFLY \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         -UTAR=
GET_AIX \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         src=
/openvpn* src/compat/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         tests/unit_tests/example_test/ tests/unit_tests/openvpn*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    --platform=3Dwin64 \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    --library=3Dwindow=
s=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -D_WIN=
32 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_LI=
NUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_DARWIN -UTARGET_ANDROID -U=
TARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    -UTARGET_AIX \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    src/openvpn* src/compat/ \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tests/unit_tests/example_test/ tests/unit_tes=
ts/openvpn*</span><br><span>diff --git a/dev-tools/update-copyright=2Esh b/=
dev-tools/update-copyright=2Esh</span><br><span>index 96546dd=2E=2E7ca6002 =
100755</span><br><span>--- a/dev-tools/update-copyright=2Esh</span><br><spa=
n>+++ b/dev-tools/update-copyright=2Esh</span><br><span>@@ -34,8 +34,7 @@</=
span><br><span> COPY_YEAR=3D&quot;$1&quot;</span><br><span> </span><br><spa=
n> cd &quot;$(git rev-parse --show-toplevel)&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-for file in $(git ls-files | grep -v vendor/);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+for file in $(git ls-files | grep -v v=
endor/); do</span><br><span>     echo -n &quot;Updating $file =2E=2E=2E&quo=
t;</span><br><span>     # The first sed operation covers 20xx-20yy copyrigh=
t lines,</span><br><span>     # The second sed operation changes 20xx -&gt;=
 20xx-20yy</span><br><span>diff --git a/tests/lwip_client_up=2Esh b/tests/l=
wip_client_up=2Esh</span><br><span>index a6b4d24=2E=2Eb1941a4 100755</span>=
<br><span>--- a/tests/lwip_client_up=2Esh</span><br><span>+++ b/tests/lwip_=
client_up=2Esh</span><br><span>@@ -2,16 +2,17 @@</span><br><span> #</span><=
br><span> # Determine the OpenVPN PID from its pid file=2E This works relia=
bly even when</span><br><span> # the OpenVPN process is backgrounded for pa=
rallel tests=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MY_PPI=
D=3D`cat $pid`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MY_PP=
ID=3D$(cat $pid)</span><br><span> </span><br><span> # Add this client&#39;s=
 VPN IP and PID to a file=2E This enables</span><br><span> # t_server_null_=
client=2Esh to kill this OpenVPN client after fping tests have</span><br><s=
pan> # finished=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ech=
o &quot;$ifconfig_local,$MY_PPID&quot; &gt;&gt; =2E/$test_name=2Elwip</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;$ifconfig_loca=
l,$MY_PPID&quot; &gt;&gt;=2E/$test_name=2Elwip</span><br><span> </span><br>=
<span> # Wait long enough to allow fping tests to finish=2E Also ensure tha=
t this</span><br><span> # OpenVPN client is killed even if t_server_null_cl=
ient=2Esh failed to do it=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-(sleep 15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo =
&quot;ERROR: t_server_null_client=2Esh failed to kill OpenVPN client with P=
ID $MY_PPID in test $test_name=2E Killing it in lwip_client_up=2Esh=2E&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-kill -15 $MY_PPID</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+(</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    sleep 15</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    echo &quot;ERROR: t_server_null_client=2Esh=
 failed to kill OpenVPN client with PID $MY_PPID in test $test_name=2E Kill=
ing it in lwip_client_up=2Esh=2E&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    kill -15 $MY_PPID</span><br><span> ) &amp;</span><br=
><span>diff --git a/tests/null_client_up=2Esh b/tests/null_client_up=2Esh</=
span><br><span>index d4df0c6=2E=2Ebe339ee 100755</span><br><span>--- a/test=
s/null_client_up=2Esh</span><br><span>+++ b/tests/null_client_up=2Esh</span=
><br><span>@@ -4,8 +4,11 @@</span><br><span> </span><br><span> # Determine =
the OpenVPN PID from its pid file=2E This works reliably even when</span><b=
r><span> # the OpenVPN process is backgrounded for parallel tests=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+MY_PPID=3D$(cat $pid)</span=
><br><span> </span><br><span> # Allow OpenVPN to finish initializing while =
waiting in the background and then</span><br><span> # killing the process g=
racefully=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(sleep 5 =
; kill -15 $MY_PPID) &amp;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sleep 5=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    kill -15 $MY_PP=
ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+) &amp;</span><br=
><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</sp=
an><br><span>index 2f37845=2E=2E305441be 100755</span><br><span>--- a/tests=
/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><b=
r><span>@@ -19,9 +19,9 @@</span><br><span> srcdir=3D&quot;${srcdir:-=2E}&qu=
ot;</span><br><span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</sp=
an><br><span> openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvp=
n}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -r &quot=
;${top_builddir}&quot;/t_client=2Erc ] ; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if [ -r &quot;${top_builddir}&quot;/t_client=2Erc=
 ]; then</span><br><span>     =2E &quot;${top_builddir}&quot;/t_client=2Erc=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ -r &quot;${src=
dir}&quot;/t_client=2Erc ] ; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><=
br><span>     =2E &quot;${srcdir}&quot;/t_client=2Erc</span><br><span> else=
</span><br><span>     echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in=
 build dir (&#39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span>@@ =
-32,37 +32,35 @@</span><br><span> # Check for external dependencies</span><=
br><span> FPING=3D&quot;fping&quot;</span><br><span> FPING6=3D&quot;fping6&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-which fping &gt;=
 /dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+which fpi=
ng &gt;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>   =
  echo &quot;$0: fping is not available in \$PATH&quot; &gt;&amp;2</span><b=
r><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-which fping6 &gt; /dev/null<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+which fping6 &gt;/de=
v/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &qu=
ot;$0: fping6 is not available in \$PATH, assuming fping 4=2E0 or later&quo=
t; &gt;&amp;2</span><br><span>     FPING=3D&quot;fping -4&quot;</span><br><=
span>     FPING6=3D&quot;fping -6&quot;</span><br><span> fi</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`which =
kill`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=3D$(=
which kill)</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     ech=
o &quot;$0: kill not found in \$PATH&quot; &gt;&amp;2</span><br><span>     =
exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${openv=
pn}&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn=
}&quot; ]; then</span><br><span>     echo &quot;no (executable) openvpn bin=
ary in current build tree=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     =
exit 1</span><br><span> fi</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-if [ ! -w =2E ]</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if [ ! -w =2E ]; then</span><br><span>     echo &quot;current directory i=
s not writable (required for logging)=2E FAIL=2E&quot; &gt;&amp;2</span><br=
><span>     exit 1</span><br><span> fi</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$TEST_RUN_LIST&quot; ] ; t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$T=
EST_RUN_LIST&quot; ]; then</span><br><span>     echo &quot;TEST_RUN_LIST em=
pty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span>   =
  exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span>@=
@ -72,16 +70,14 @@</span><br><span> </span><br><span> # make sure we have p=
ermissions to run ifconfig/route from OpenVPN</span><br><span> # can&#39;t =
use &quot;id -u&quot; here - doesn&#39;t work on Solaris</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-ID=3D`id`</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/d=
ev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-then :</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ID=3D$(id)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=
=3D0&quot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    :</span><br><span> else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; the=
n</span><br><span>         # Check if we have a valid kerberos ticket</span=
><br><span>         klist -l 1&gt;/dev/null 2&gt;/dev/null</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ $? -ne 0 ]; then</span><br><=
span>             # No kerberos ticket found, skip ksu and fallback to RUN_=
SUDO</span><br><span>             PREFER_KSU=3D0</span><br><span>          =
   echo &quot;$0: No Kerberos ticket available=2E  Will not use ksu=2E&quot=
;</span><br><span>@@ -90,8 +86,7 @@</span><br><span>         fi</span><br><=
span>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><span>     =
    echo &quot;$0: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E &=
quot; &gt;&amp;2</span><br><span>         echo &quot;      must be set corr=
ectly in &#39;t_client=2Erc&#39;=2E SKIP=2E&quot; &gt;&amp;2</span><br><spa=
n>         exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span>@@ -99,20 +9=
4,19 @@</span><br><span>         # We have to use sudo=2E Make sure that we=
 (hopefully) do not have</span><br><span>         # to ask the users passwo=
rd during the test=2E This is done to</span><br><span>         # prevent ti=
ming issues, e=2Eg=2E when the waits for openvpn to start</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	if $RUN_SUDO $KILL_EXEC -0 $$</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 su=
cceeded, good=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot=
;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp=
;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    exit &quot;${T=
CLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if $RUN_=
SUDO $KILL_EXEC -0 $$; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo =
&quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt=
;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fi</span><br><span>     fi</span><br><span> fi</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-LOGDIR=
=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H%M%=
S)</span><br><span> LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-if mkdir $LOGDIR</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if mkdir $LOGDIR; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    :</span><br><span> else</span><br><span>     echo=
 &quot;can&#39;t create log directory &#39;$LOGDIR&#39;=2E FAIL=2E&quot; &g=
t;&amp;2</span><br><span>     exit 1</span><br><span>@@ -132,21 +126,28 @@<=
/span><br><span> output_start()</span><br><span> {</span><br><span>     cas=
e $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) outbuf=3D&=
quot;&quot; ;;			# no per-test output at all</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	1) printf &quot;$@\n&quot;			# compact, details onl=
y on failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
  outbuf=3D&quot;\n&quot; ;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	*) printf &quot;\n$@\n&quot; ;;		# print all, with a bit formatting=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0) outbuf=
=3D&quot;&quot; ;; # no per-test output at all</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            printf &quot;$@\n&quot; # compact, details on=
ly on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      outbuf=3D&quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *) printf &quot;\n$@\n&quot; ;; # print all, with a bit format=
ting</span><br><span>     esac</span><br><span> }</span><br><span> </span><=
br><span> output()</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    END_NL=3D&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot=
;X-n&quot; ] ; then END_NL=3D&quot;&quot; ; shift ; fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    END_NL=3D&quot;\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;X$1&quot; =3D &qu=
ot;X-n&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        END_NL=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        shift</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    fi</span><br><span>     case $V in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	0) ;;				# no per-test output at all</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@${END_NL}=
&quot;	# print details only on failure</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-           ;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	*) printf &quot;$@${END_NL}&quot; ;;	# print everything</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0) ;; # no per-test o=
utput at all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outb=
uf=3D&quot;$outbuf$@${END_NL}&quot; # print details only on failure</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *) printf &quot;$@${END_=
NL}&quot; ;; # print everything</span><br><span>     esac</span><br><span> =
}</span><br><span> </span><br><span>@@ -154,62 +155,61 @@</span><br><span> =
fail()</span><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$((=
 $fail_count + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    fail_count=3D$(($fail_count + 1))</span><br><span> }</span><br><span> <=
/span><br><span> # print &quot;all interface IP addresses&quot; + &quot;all=
 routes&quot;</span><br><span> # this is higly system dependent=2E=2E=2E</s=
pan><br><span> get_ifconfig_route()</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    UNAME=3D`uname -s`</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    UNAME=3D$(uname -s)</span><br><span=
>     case $UNAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
Linux)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux=
)</span><br><span>             # linux / iproute2? (-&gt; if configure got =
a path)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 [ -n &quot;@IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if [ -n &quot;@IPROUTE@&quot; ]; then</span><br><span>    =
             echo &quot;-- linux iproute2 --&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                @IPROUTE@ addr show     | grep=
 -v valid_lft</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          @IPROUTE@ addr show | grep -v valid_lft</span><br><span>         =
        @IPROUTE@ route show</span><br><span>                 @IPROUTE@ -o =
-6 route show | grep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*=
sec//&#39; -e &#39;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s=
/ (rtt|rttvar) [0-9]+ms//g&#39;</span><br><span>             else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	        echo &quot;-- linux / =
ifconfig --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
     LANG=3DC @IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	        LANG=3DC @NETSTAT@ -rn -=
4 -6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 echo &quot;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                LANG=3DC @IFCONFIG@ -a | egrep &quot;(=
 addr:|encap:)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             =
fi</span><br><span>             ;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	FreeBSD|NetBSD|Darwin)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	   echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egr=
ep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#=
39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OpenBSD)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- OpenBSD --&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quo=
t;(flags=3D|inet)&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-		sed -e &#39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk=
 &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	SunOS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
echo &quot;-- Solaris --&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~=
 /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	A=
IX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- =
AIX --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCO=
NFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1=
,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | =
NetBSD | Darwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egr=
ep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,=
$3,$NF }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ope=
nBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ec=
ho &quot;-- OpenBSD --&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                sed -e=
 &#39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#3=
9;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            ;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        SunOS)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            echo &quot;-- Solaris --&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot=
;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&=
#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AIX)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- A=
IX --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !=
~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ;;</span><br><span>         *)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           echo &quot;get_ifconfig_rou=
te(): no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt=
;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           exi=
t 20</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           ;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;=
get_ifconfig_route(): no idea how to get info on your OS ($(uname -s))=2E  =
FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            exit 20</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ;;</span><br><span>     esac</span><br><span> </span><br><=
span>     # another round of per-platform information gathering, for DNS in=
fo</span><br><span>     # for most of the platforms &quot;cat /etc/resolv=
=2Econf&quot; is good enough</span><br><span>     # except Linux and MacOS<=
/span><br><span>     case $UNAME in</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	Linux)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ -x /usr/=
bin/resolvectl -a -d /run/systemd/system ]; then</span><br><span>          =
       echo &quot;-- linux resolvectl --&quot;</span><br><span>            =
     resolvectl status</span><br><span>             else</span><br><span>@@=
 -217,7 +217,7 @@</span><br><span>                 cat /etc/resolv=2Econf</=
span><br><span>             fi</span><br><span>             ;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	Darwin)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        Darwin)</span><br><span>             =
echo &quot;-- MacOS scutil --dns&quot;</span><br><span>             scutil =
--dns</span><br><span>             ;;</span><br><span>@@ -234,19 +234,19 @@=
</span><br><span> #  arg2: IPv4/IPv6 address that must show up in out of &q=
uot;get_ifconfig_route&quot;</span><br><span> check_ifconfig()</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    proto=3D$1 =
; shift</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=3D=
$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    shift</span><=
br><span>     expect_list=3D&quot;$@&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$expect_list&quot;=
 ] ; then return ; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ] ; then return ; fi</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$exp=
ect_list&quot; ]; then return; fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ]; then r=
eturn; fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for expect in $expect_list</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	if get_ifconfig_route | fgrep &quot;$expect&quot; &gt;/dev/null</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	then :</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	    fail &quot;check_ifconfig(): expected IPv$proto address &=
#39;$expect&#39; not found in ifconfig output=2E&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for expect in $expect_list; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if get_ifconfig_route | fgrep &qu=
ot;$expect&quot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            :</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fail &quot;check_ifconfig(): expected IPv$proto address &#3=
9;$expect&#39; not found in ifconfig output=2E&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span>     done</spa=
n><br><span> }</span><br><span> </span><br><span>@@ -257,47 +257,48 @@</spa=
n><br><span> #  arg3=2E=2E=2E -&gt; fping arguments (host list)</span><br><=
span> run_ping_tests()</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    proto=3D$1 ; want=3D$2 ; shift ; shift</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    want=3D$2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    shift</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    shift</span><br><span>     targetlist=3D&quot;$=
@&quot;</span><br><span> </span><br><span>     # &quot;no targets&quot; is =
fine</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot=
;$targetlist&quot; ] ; then return ; fi</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if [ -z &quot;$targetlist&quot; ]; then return; fi<=
/span><br><span> </span><br><span>     case $proto in</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	*) echo &quot;interna=
l error in run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	   exit 1 ;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        4) cmd=3D&quot;$FPING&quot; =
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        6) cmd=3D=
&quot;$FPING6&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      echo &quot;internal error in run_ping_tests arg 1: &#39;$proto&#39;&q=
uot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ;;</span><br><span>     esac</span><br><span> </span><br><span>     =
case $want in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	want_ok=
)   sizes_list=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	want_fail) sizes_list=3D&quot;64&quot; ;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        want_ok) sizes_list=
=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><spa=
n>     esac</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for bytes in $sizes_list</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	output &quot;run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for by=
tes in $sizes_list; do</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        output &quot;run IPv$proto ping tests ($want), $bytes byte packe=
ts=2E=2E=2E&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targe=
tlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetl=
ist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        echo &quot;$cmd -b $bytes -C 20 -p 250=
 -q $fping_args $targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        $cmd -b $bytes -C 20=
 -p 250 -q $fping_args $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&a=
mp;1</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	# while OpenVPN is running, pings must succeed (want=3D&#39;want_ok&#39;)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# before OpenVPN is =
up, pings must NOT succeed (want=3D&#39;want_fail&#39;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        # while OpenVPN is running, pin=
gs must succeed (want=3D&#39;want_ok&#39;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # before OpenVPN is up, pings must NOT succe=
ed (want=3D&#39;want_fail&#39;)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	rc=3D$?</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	if [ $rc =3D 0 ] 				# all ping OK</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	    if [ $want =3D &quot;want_fail&quot; ]		# not what we wan=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test=
 succeeded, but needs to *fail*=2E&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	else					# ping failed</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	    if [ $want =3D &quot;want_ok&quot; ]		# not what we wanted</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test ($byt=
es bytes) failed, but should succeed=2E&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  rc=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 [ $rc =3D 0 ]; then                 # all ping OK</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if [ $want =3D &quot;want_fail&q=
uot; ]; then # not what we want</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                fail &quot;IPv$proto ping test succeeded, but n=
eeds to *fail*=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else                               # ping failed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if [ $want =3D &quot;want_o=
k&quot; ]; then # not what we wanted</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                fail &quot;IPv$proto ping test ($bytes byt=
es) failed, but should succeed=2E&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            fi</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        fi</span><br><span>     done</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -308,8 +309,7 @@</span><br><span> SUMMARY_=
SKIP=3D</span><br><span> SUMMARY_FAIL=3D</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     =
# get config variables</span><br><span>     eval test_prep=3D\&quot;\$PREPA=
RE_$SUF\&quot;</span><br><span>     eval test_check_skip=3D\&quot;\$CHECK_S=
KIP_$SUF\&quot;</span><br><span>@@ -336,11 +336,13 @@</span><br><span> </sp=
an><br><span>     if [ -n &quot;$test_check_skip&quot; ]; then</span><br><s=
pan>         output &quot;check whether we need to skip: &#39;$test_check_s=
kip&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if eval $test_check_skip; then :</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if eval $test_check_skip; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            :</span><br><span>         el=
se</span><br><span>             output &quot;skip check failed, SKIP test $=
SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    SUMM=
ARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	    printf &quot;$outbuf&quot; ; continue</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            SUMMARY_SKIP=3D&quot=
;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            printf &quot;$outbuf&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue</span><br><span>         fi</=
span><br><span>     fi</span><br><span> </span><br><span>@@ -355,13 +357,14=
 @@</span><br><span>     output &quot;\nrun pre-openvpn ping tests - target=
s must not be reachable=2E=2E=2E&quot;</span><br><span>     run_ping_tests =
4 want_fail &quot;$ping4_hosts&quot;</span><br><span>     run_ping_tests 6 =
want_fail &quot;$ping6_hosts&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fail_count&quot; =
=3D 0 ]; then</span><br><span>         output &quot;OK=2E\n&quot;</span><br=
><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail=
 &quot;make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=
=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAI=
L=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	exit_code=3D31</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	printf &quot;$outbuf&quot; ; continue</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        fail &quot;make sure that ping hosts are =
ONLY reachable via VPN, SKIP test $SUF=2E&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit_=
code=3D31</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
intf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        continue</span><br><span>     fi</span><br><span> </span><br><=
span>     pidfile=3D&quot;$LOGDIR_ABS/openvpn-$SUF=2Epid&quot;</span><br><s=
pan>@@ -376,18 +379,17 @@</span><br><span>     # to $ovpn_init_check times=
=2E</span><br><span>     ovpn_init_check=3D30</span><br><span>     ovpn_ini=
t_success=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whil=
e [ $ovpn_init_check -gt 0 ];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
sleep 1  # Wait for OpenVPN to initialize and have had time to write the pi=
d file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       grep &qu=
ot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/=
dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       if [ $=
? -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     ovpn_init_check=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-           ovpn_init_success=3D1</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-       fi</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while [ $ovpn_init_check -gt 0 ]; do=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1 # W=
ait for OpenVPN to initialize and have had time to write the pid file</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        grep &quot;Initia=
lization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $? -eq =
0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ovpn_init_check=3D$(($ovpn_init_check - 1))</span><br><span>=
     done</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    opid=3D`cat $pidfile`</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    opid=3D$(cat $pidfile)</span><br><span>     if [ -n &quot;$=
opid&quot; ]; then</span><br><span>         output &quot;  OpenVPN running =
with PID $opid&quot;</span><br><span>     else</span><br><span>@@ -398,16 +=
400,17 @@</span><br><span>     if [ $ovpn_init_success -ne 1 -o -z &quot;$o=
pid&quot; ]; then</span><br><span>         output &quot;$0:  OpenVPN did no=
t initialize in a reasonable time&quot;</span><br><span>         if [ -n &q=
uot;$opid&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-           $RUN_SUDO $KILL_EXEC $opid</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $opid</span><br><span>=
         fi</span><br><span>         $RUN_SUDO $KILL_EXEC $sudopid</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;tail -5 $SUF:ope=
nvpn=2Elog&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	outp=
ut &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	fail &quot;skip rest of sub-tests for test=
 run $SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	tr=
ap - 0 1 2 3 15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMA=
RY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	printf &quot;$outbuf&quot; ; continue</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        output &quot;tail -5 $SUF:openvpn=
=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 output &quot;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        fail &quot;skip rest of sub-t=
ests for test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit_code=3D30<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf &quot=
;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   continue</span><br><span>     fi</span><br><span> </span><br><span>     =
# make sure openvpn client is terminated in case shell exits</span><br><spa=
n>@@ -418,17 +421,16 @@</span><br><span>     output &quot;save ifconfig+rou=
te&quot;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_=
route=2Etxt</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ] ; then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$expec=
t_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br><span>         output=
 &quot;skip ifconfig+route check&quot;</span><br><span>     else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	output -n &quot;compare pre-ope=
nvpn ifconfig+route with current values=2E=2E=2E&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	if diff $LOGDIR/$SUF:ifconfig_route_pre=
=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		$LOGDIR/$SU=
F:ifconfig_route=2Etxt &gt;/dev/null</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
    fail &quot;no differences between ifconfig/route before OpenVPN start a=
nd now=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    output &quot; OK!=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        output -n &quot;compa=
re pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if diff $LOGDIR/$SUF:i=
fconfig_route_pre=2Etxt \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            $LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            fail &quot;=
no differences between ifconfig/route before OpenVPN start and now=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            output &quot; =
OK!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fi</span><br><span>     fi</span><br><span> </span><br><span>     # post in=
it script needed?</span><br><span>@@ -449,8 +451,8 @@</span><br><span>     =
$RUN_SUDO $KILL_EXEC $opid</span><br><span>     wait $!</span><br><span>   =
  rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $rc=
 !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail=
 &quot;OpenVPN return code $rc, expect 0&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if [ $rc !=3D 0 ]; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        fail &quot;OpenVPN return code $=
rc, expect 0&quot;</span><br><span>     fi</span><br><span> </span><br><spa=
n>     output &quot;\nsave post-openvpn ifconfig + route=2E=2E=2E&quot;</sp=
an><br><span>@@ -458,23 +460,22 @@</span><br><span> </span><br><span>     o=
utput -n &quot;compare pre- and post-openvpn ifconfig + route=2E=2E=2E&quot=
;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	    $LOGDIR/$SUF:ifconfig=
_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	output &quot; OK=2E\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        $LOGDIR/$SUF:ifconfig_route_post=
=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        output &quot; OK=2E\n&quot;</sp=
an><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	output &quot;\n\n&quot; &quot;`cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt=
`&quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	fail &quot;differences between pre- and post-ifconfig/route=2E&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;\n\=
n&quot; &quot;$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)&quot; &quot;\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail &=
quot;differences between pre- and post-ifconfig/route=2E&quot;</span><br><s=
pan>     fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &=
quot;$fail_count&quot; =3D 0 ] ; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ]; then</span><br>=
<span>         output &quot;test run $SUF: all tests OK=2E\n&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_OK=3D&quot;$SUMMARY_O=
K $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>     else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	if [ &quot;$V&quot; -gt 0 ]=
 ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    printf &q=
uot;$outbuf&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
 echo &quot;test run $SUF: $fail_count test failures=2E FAIL=2E&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;$V&quo=
t; -gt 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         printf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            echo &quot;test run $SUF: $fail_count test fail=
ures=2E FAIL=2E&quot;</span><br><span>         fi</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&qu=
ot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        exit_code=3D30</span><br><span>     fi</span><br><span> </s=
pan><br><span>     if [ -n &quot;$test_cleanup&quot; ]; then</span><br><spa=
n>@@ -484,9 +485,9 @@</span><br><span> </span><br><span> done</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SU=
MMARY_OK&quot; ] ; then SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_SKIP&quot; ] ; =
then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_FAIL&quot; ] ; then SUMMARY_FAIL=
=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+if [ -z &quot;$SUMMARY_OK&quot; ]; then SUMMARY_OK=3D&quot; none&quot;=
; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$=
SUMMARY_SKIP&quot; ]; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_FAIL&quo=
t; ]; then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><br><span> echo &quot=
;Test sets succeeded:$SUMMARY_OK=2E&quot;</span><br><span> echo &quot;Test =
sets skipped:$SUMMARY_SKIP=2E&quot;</span><br><span> echo &quot;Test sets f=
ailed:$SUMMARY_FAIL=2E&quot;</span><br><span>diff --git a/tests/t_cltsrv=2E=
sh b/tests/t_cltsrv=2Esh</span><br><span>index 6b7df65=2E=2E03c3845 100755<=
/span><br><span>--- a/tests/t_cltsrv=2Esh</span><br><span>+++ b/tests/t_clt=
srv=2Esh</span><br><span>@@ -24,50 +24,58 @@</span><br><span> trap &quot;rm=
 -f log=2E$$ log=2E$$=2Esignal ; trap 0 ; exit 77&quot; 1 2 15</span><br><s=
pan> trap &quot;rm -f log=2E$$ log=2E$$=2Esignal ; exit 1&quot; 0 3</span><=
br><span> addopts=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
ase `uname -s` in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ca=
se $(uname -s) in</span><br><span>     FreeBSD)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    # FreeBSD jails map the outgoing IP to the ja=
il IP - we need to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 # allow the real IP unless we want the test to run forever=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if test &quot;`sysctl 2&gt;/de=
v/null -n security=2Ejail=2Ejailed`&quot; =3D 1 \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    || ps -ostate=3D -p $$ | grep -q J; then</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	addopts=3D&quot;--float=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if test &quot;=
x`ifconfig | grep inet`&quot; =3D x ; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	    echo &quot;###&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	    echo &quot;### To run the test in a FreeBSD j=
ail, you MUST add an IP alias for the jail&#39;s IP=2E&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;###&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	    exit 77</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Fr=
eeBSD jails map the outgoing IP to the jail IP - we need to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # allow the real IP unless =
we want the test to run forever=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if test &quot;$(sysctl 2&gt;/dev/null -n security=2E=
jail=2Ejailed)&quot; =3D 1 ||</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ps -ostate=3D -p $$ | grep -q J; then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            addopts=3D&quot;--float=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f test &quot;x$(ifconfig | grep inet)&quot; =3D x; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                echo &quot;###&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                echo &=
quot;### To run the test in a FreeBSD jail, you MUST add an IP alias for th=
e jail&#39;s IP=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                echo &quot;###&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                exit 77</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ;;</span><br><span> esac</span><br><span> </span><br><s=
pan> # make sure that the --down script is executable -- fail (rather than<=
/span><br><span> # skip) test if it isn&#39;t=2E</span><br><span> downscrip=
t=3D&quot;=2E=2E/tests/t_cltsrv-down=2Esh&quot;</span><br><span> root=3D&qu=
ot;${top_srcdir}/sample&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-test -x &quot;${root}/${downscript}&quot; || chmod +x &quot;${root}=
/${downscript}&quot; || { echo &gt;&amp;2 &quot;${root}/${downscript} is no=
t executable, failing=2E&quot; ; exit 1 ; }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+test -x &quot;${root}/${downscript}&quot; || chmod =
+x &quot;${root}/${downscript}&quot; || {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    echo &gt;&amp;2 &quot;${root}/${downscript} is no=
t executable, failing=2E&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span> echo &quot;The following test will take about two minu=
tes=2E&quot; &gt;&amp;2</span><br><span> echo &quot;If the addresses are in=
 use, this test will retry up to two times=2E&quot; &gt;&amp;2</span><br><s=
pan> </span><br><span> # go</span><br><span> success=3D0</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-for i in 1 2 3 ; do</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  set +e</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  (</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  &quot;${openvpn}&quot; --script-security 2 --cd &quot;${root}&quot; ${a=
ddopts} --setenv role srv --down &quot;${downscript}&quot; --tls-exit --pin=
g-exit 180 --config &quot;sample-config-files/loopback-server&quot; &amp;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;${openvpn}&quot=
; --script-security 2 --cd &quot;${top_srcdir}/sample&quot; ${addopts} --se=
tenv role clt --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 -=
-config &quot;sample-config-files/loopback-client&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ) 3&gt;log=2E$$=2Esignal &gt;log=2E$$ 2=
&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  e1=3D$?</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  wait $!</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  e2=3D$?</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  grep &#39;TCP/UDP: Socket bind failed on loca=
l address=2E*in use&#39; log=2E$$ &gt;/dev/null &amp;&amp; {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    echo &#39;address in use, retryi=
ng in 150 s&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
leep 150</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    continue<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  grep -v &#39;:inactive$&#39; log=2E$$=
=2Esignal &gt;/dev/null &amp;&amp; { cat log=2E$$=2Esignal ; echo ; cat log=
=2E$$ ; exit 1 ; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  s=
uccess=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  break</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+for i in 1 2 3; do</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    set +e</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    (</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;${openvpn}&quot; --script-securit=
y 2 --cd &quot;${root}&quot; ${addopts} --setenv role srv --down &quot;${do=
wnscript}&quot; --tls-exit --ping-exit 180 --config &quot;sample-config-fil=
es/loopback-server&quot; &amp;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &quot;${openvpn}&quot; --script-security 2 --cd &quot;${=
top_srcdir}/sample&quot; ${addopts} --setenv role clt --down &quot;${downsc=
ript}&quot; --tls-exit --ping-exit 180 --config &quot;sample-config-files/l=
oopback-client&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ) 3&gt;log=2E$$=2Esignal &gt;log=2E$$ 2&gt;&amp;1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    e1=3D$?</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    wait $!</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    e2=3D$?</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    grep &#39;TCP/UDP: Socket bind failed on local address=2E*in=
 use&#39; log=2E$$ &gt;/dev/null &amp;&amp; {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        echo &#39;address in use, retrying in 150=
 s&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        slee=
p 150</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        contin=
ue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    grep -v &#39;:inactive$&#39=
; log=2E$$=2Esignal &gt;/dev/null &amp;&amp; {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cat log=2E$$=2Esignal</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        echo</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cat log=2E$$</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    success=3D1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    break</span><br><span> done</span><br><span> </span><br><span> =
set -e</span><br><span>@@ -75,14 +83,14 @@</span><br><span> # exit code - d=
efaults to 0, PASS</span><br><span> ec=3D0</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-if [ $success !=3D 1 ] ; then</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  # couldn&#39;t run test --=
 addresses in use, skip test</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  cat log=2E$$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  ec=3D77</span><br><span style=3D"color: hsl(0, 100%, 40%);">-elif [ $e1 !=
=3D 0 ] || [ $e2 !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  # failure -- fail test</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  cat log=2E$$</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  ec=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [=
 $success !=3D 1 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    # couldn&#39;t run test -- addresses in use, skip test</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cat log=2E$$</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ec=3D77</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # failure -- =
fail test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cat lo=
g=2E$$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ec=3D1</s=
pan><br><span> fi</span><br><span> </span><br><span> rm log=2E$$ log=2E$$=
=2Esignal</span><br><span>diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=
=2Esh</span><br><span>index 6802506=2E=2E058206f 100755</span><br><span>---=
 a/tests/t_lpback=2Esh</span><br><span>+++ b/tests/t_lpback=2Esh</span><br>=
<span>@@ -37,51 +37,56 @@</span><br><span> test_start()</span><br><span> {<=
/span><br><span>     case $V in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        0) outbuf=3D&quot;&quot; ;;                  # no per-tes=
t output at all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  1) outbuf=3D&quot;$@&quot; ;;                # compact, details only on f=
ailure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *) prin=
tf &quot;$@&quot; ;;                # print all</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0) outbuf=3D&quot;&quot; ;;   # no per-=
test output at all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       1) outbuf=3D&quot;$@&quot; ;; # compact, details only on failure</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        *) printf &quot=
;$@&quot; ;; # print all</span><br><span>     esac</span><br><span> }</span=
><br><span> test_end()</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    RC=3D$1 ; LOG=3D$2</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if [ $RC !=3D 0 ]</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    RC=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    LOG=3D$2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f [ $RC !=3D 0 ]; then</span><br><span>         case $V in</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            0) ;;                     =
           # no per-test output</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            1) echo &quot;$outbuf&quot; &quot;FAIL (RC=3D$RC)&quo=
t;; cat $LOG ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      *) echo &quot;FAIL (RC=3D$RC)&quot;; cat $LOG ;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            0) ;; # no per-test output</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                echo &quot=
;$outbuf&quot; &quot;FAIL (RC=3D$RC)&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                cat $LOG</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            *)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                echo &quot;FAIL (RC=3D$RC)&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                cat $LOG=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ;;<=
/span><br><span>         esac</span><br><span>         e=3D1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tests_failed=3D$(( $tests_fa=
iled + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tests_failed=3D$(($tests_failed + 1))</span><br><span>     else</span><br><=
span>         case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            0|1) ;;                              # no per-test output fo=
r &#39;OK&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     *) echo &quot;OK&quot;                         # print all</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            0 | 1) ;;       # n=
o per-test output for &#39;OK&#39;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            *) echo &quot;OK&quot; ;; # print all</span><br>=
<span>         esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tests_passed=3D$(( $tests_passed + 1 ))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tests_passed=3D$(($tests_passed + 1))</sp=
an><br><span>     fi</span><br><span> }</span><br><span> </span><br><span> =
# if running with V=3D1, give an indication what test runs now</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$V&quot; =3D 1  ] ; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$V&quot=
; =3D 1 ]; then</span><br><span>     echo &quot;$0: running with V=3D$V, on=
ly printing test fails&quot;</span><br><span> fi</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # Get list o=
f supported ciphers from openvpn --show-ciphers output</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-CIPHERS=3D$(${openvpn} --show-ciphers | \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sed -e &#3=
9;/The following/,/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39;/^[[:space:]]*$=
/d&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CIPHERS=3D$=
(${openvpn} --show-ciphers |</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    sed -e &#39;/The following/,/^$/d&#39; -e s&#39;/ =2E*//&#39; =
-e &#39;/^[[:space:]]*$/d&#39;)</span><br><span> </span><br><span> # SK, 20=
14-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is</span><b=
r><span> # broken (see http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=
=3D2867), so exclude</span><br><span> # that cipher from this test=2E</span=
><br><span> # GD, 2014-07-06 so is DES-CFB1</span><br><span> # GD, 2014-07-=
06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-CIPHERS=3D$(echo &quot;$CIPHERS&q=
uot; | egrep -v &#39;^(DES-EDE3-CFB1|DES-CFB1|RC5-)&#39; )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+CIPHERS=3D$(echo &quot;$CIPHERS&quot=
; | egrep -v &#39;^(DES-EDE3-CFB1|DES-CFB1|RC5-)&#39;)</span><br><span> </s=
pan><br><span> e=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
f [ -z &quot;$CIPHERS&quot; ] ; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+if [ -z &quot;$CIPHERS&quot; ]; then</span><br><span>     =
echo &quot;&#39;openvpn --show-ciphers&#39; FAILED (empty list)&quot;</span=
><br><span>     e=3D1</span><br><span> fi</span><br><span>@@ -91,10 +96,9 @=
@</span><br><span> </span><br><span> set +e</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-for cipher in ${CIPHERS}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+for cipher in ${CIPHERS}; do</span><br><span>    =
 test_start &quot;Testing cipher ${cipher}=2E=2E=2E &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-cr=
ypto --cipher ${cipher} ) &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    (&quot;${openvpn}&quot; --test-crypto --=
cipher ${cipher}) &gt;log=2E$$ 2&gt;&amp;1</span><br><span>     test_end $?=
 log=2E$$</span><br><span> done</span><br><span> </span><br><span>@@ -121,7=
 +125,7 @@</span><br><span>     &gt;log=2E$$ 2&gt;&amp;1</span><br><span> t=
est_end $? log=2E$$</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-if [ &quot;$V&quot; -ge 1  ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$V&quot; -ge 1 ]; then</span><=
br><span>     echo &quot;$0: tests passed: $tests_passed  failed: $tests_fa=
iled&quot;</span><br><span> fi</span><br><span> </span><br><span>diff --git=
 a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span>index 8134832=2E=2E1=
7e028e 100755</span><br><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/=
tests/t_net=2Esh</span><br><span>@@ -9,7 +9,6 @@</span><br><span> top_build=
dir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;=
${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # bail =
out right away on non-linux=2E NetLink (the object of this test) is only</s=
pan><br><span> # used on Linux, therefore testing other platform is not nee=
ded=2E</span><br><span> #</span><br><span>@@ -69,7 +68,6 @@</span><br><span=
>     done</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> ## execution starts here</span>=
<br><span> </span><br><span> # t_client=2Erc required only for RUN_SUDO def=
inition</span><br><span>@@ -89,21 +87,18 @@</span><br><span>     exit 77</s=
pan><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> # Ensure PREFER_KSU is in a known state</sp=
an><br><span> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;</span><br><span> </=
span><br><span> # make sure we have permissions to run the networking unit-=
test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ID=3D`id`</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : &qu=
ot;uid=3D0&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ID=
=3D$(id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr &qu=
ot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot;=
 -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER=
_KSU}&quot; -eq 1 ]; then</span><br><span>         # Check if we have a val=
id kerberos ticket</span><br><span>         klist -l 1&gt;/dev/null 2&gt;/d=
ev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ $=
? -ne 0 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $? -n=
e 0 ]; then</span><br><span>             # No kerberos ticket found, skip k=
su and fallback to RUN_SUDO</span><br><span>             PREFER_KSU=3D0</sp=
an><br><span>             echo &quot;$0: No Kerberos ticket available=2E  W=
ill not use ksu=2E&quot;</span><br><span>@@ -112,16 +107,14 @@</span><br><s=
pan>         fi</span><br><span>     fi</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ];=
 then</span><br><span>         echo &quot;$0: no RUN_SUDO=3D=2E=2E=2E in t_=
client=2Erc or environment, defaulting to &#39;sudo&#39;=2E&quot; &gt;&amp;=
2</span><br><span>         echo &quot;      if that does not work, set RUN_=
SUDO=3D correctly for your system=2E&quot; &gt;&amp;2</span><br><span>     =
    RUN_SUDO=3D&quot;sudo&quot;</span><br><span>     fi</span><br><span> </=
span><br><span>     # check that we can run the unit-test binary with sudo<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if $RUN_SUDO $UNIT=
_TEST test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if $RUN_SUDO $UNIT=
_TEST test; then</span><br><span>         echo &quot;$0: $RUN_SUDO $UNIT_TE=
ST succeeded, good=2E&quot;</span><br><span>     else</span><br><span>     =
    echo &quot;$0: $RUN_SUDO $UNIT_TEST failed, cannot go on=2E SKIP=2E&quo=
t; &gt;&amp;2</span><br><span>diff --git a/tests/t_server_null=2Esh b/tests=
/t_server_null=2Esh</span><br><span>index 74ffd52=2E=2Ec633614 100755</span=
><br><span>--- a/tests/t_server_null=2Esh</span><br><span>+++ b/tests/t_ser=
ver_null=2Esh</span><br><span>@@ -2,7 +2,7 @@</span><br><span> #</span><br>=
<span> TSERVER_NULL_SKIP_RC=3D&quot;${TSERVER_NULL_SKIP_RC:-77}&quot;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if ! [ -r=
 &quot;=2E/t_server_null=2Erc&quot; ] ; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if ! [ -r &quot;=2E/t_server_null=2Erc&quot; ]; th=
en</span><br><span>     echo &quot;${0}: cannot find &#39;=2E/t_server_null=
=2Erc=2E SKIPPING TEST=2E&#39;&quot; &gt;&amp;2</span><br><span>     exit &=
quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span> fi</span><br><span>@@ -=
22,11 +22,10 @@</span><br><span> # make sure we have permissions to run ifc=
onfig/route from OpenVPN</span><br><span> # can&#39;t use &quot;id -u&quot;=
 here - doesn&#39;t work on Solaris</span><br><span> ID=3D$(id)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; : &quot;u=
id=3D0&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr =
&quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&qu=
ot; -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PRE=
FER_KSU}&quot; -eq 1 ]; then</span><br><span>         # Check if we have a =
valid kerberos ticket</span><br><span>         if klist -l 1&gt;/dev/null 2=
&gt;/dev/null; then</span><br><span>             RUN_SUDO=3D&quot;ksu -q -e=
&quot;</span><br><span>@@ -37,26 +36,24 @@</span><br><span>         fi</spa=
n><br><span>     fi</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><s=
pan>         echo &quot;${0}: this test must run be as root, or RUN_SUDO=3D=
=2E=2E=2E &quot; &gt;&amp;2</span><br><span>         echo &quot;      must =
be set correctly in &#39;t_server_null=2Erc&#39;=2E SKIP=2E&quot; &gt;&amp;=
2</span><br><span>         exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><=
br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# =
Run a no-op command with privilege escalation (e=2Eg=2E sudo) so that</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	# we (hopefully) do not ha=
ve to ask the users password during the test=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	if $RUN_SUDO &quot;${KILL_EXEC}&quot; -0 $$</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;${0}: $RUN_SUDO $KILL_EXEC=
 -0 succeeded, good=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo=
 &quot;${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; =
&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    exit &=
quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     # Run a no-op command with privilege escalation (e=2Eg=2E sudo) so tha=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # we (hope=
fully) do not have to ask the users password during the test=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if $RUN_SUDO &quot;${KI=
LL_EXEC}&quot; -0 $$; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo =
&quot;${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &=
gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        fi</span><br><span>     fi</span><br><span> =
fi</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-export t_server_null_lo=
gdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+export t_server_null_logdir=3Dt_server_nu=
ll-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span> </span><br><span> # =
Create directory for server and client logs</span><br><span> mkdir $t_serve=
r_null_logdir</span><br><span>diff --git a/tests/t_server_null_client=2Esh =
b/tests/t_server_null_client=2Esh</span><br><span>index 1745de5=2E=2E3203cc=
2 100755</span><br><span>--- a/tests/t_server_null_client=2Esh</span><br><s=
pan>+++ b/tests/t_server_null_client=2Esh</span><br><span>@@ -1,9 +1,10 @@<=
/span><br><span> #!/bin/sh</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-should_run_test() {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+should_run_test()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span>     test_name=3D&quot;$1&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if e=
cho &quot;$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if echo &quot;$test_name&quot; | grep -q _lw=
ip; then</span><br><span>         if [ &quot;$has_lwipovpn&quot; =3D &quot;=
no&quot; ]; then</span><br><span>             return 1</span><br><span>    =
     fi</span><br><span>@@ -12,7 +13,8 @@</span><br><span>     return 0</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-launch_client() {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+launch_client()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span>     test_name=3D$1</span><br><span>     log=3D&quo=
t;${test_name}=2Elog&quot;</span><br><span>     pid=3D&quot;${test_name}=2E=
pid&quot;</span><br><span>@@ -30,7 +32,8 @@</span><br><span>         --log =
&quot;${t_server_null_logdir}/${log}&quot; &amp;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ping_and_ki=
ll() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ping_and_kill=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
>     if fping -q -c 5 $1; then</span><br><span>         echo &quot;PASS: f=
ping lwipovpn client $target&quot;</span><br><span>     else</span><br><spa=
n>@@ -46,9 +49,10 @@</span><br><span>     kill -15 $2</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ping_l=
wip_clients() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ping=
_lwip_clients()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span>     if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&quot; ]; th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        lwip_client=
_count=3D$(echo &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; &quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_cou=
nt=3D$(echo &quot;$lwip_test_names&quot; | wc -w | tr -d &quot; &quot;)</sp=
an><br><span>     else</span><br><span>         lwip_client_count=3D0</span=
><br><span>     fi</span><br><span>@@ -60,10 +64,10 @@</span><br><span>    =
 count=3D0</span><br><span>     maxcount=3D10</span><br><span>     while [ =
$count -le $maxcount ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        lwip_client_ips=3D$(cat =2E/*=2Elwip 2&gt;/dev/null|wc -l)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_ips=
=3D$(cat =2E/*=2Elwip 2&gt;/dev/null | wc -l)</span><br><span>         if [=
 $lwip_client_ips -lt $lwip_client_count ]; then</span><br><span>          =
   echo &quot;Waiting for LWIP clients to start up ($count/$maxcount)&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            count=3D$=
(( count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       count=3D$((count + 1))</span><br><span>             sleep 1</span><b=
r><span>         else</span><br><span>             echo &quot;$lwip_client_=
ips/$lwip_client_count LWIP clients up&quot;</span><br><span>@@ -73,8 +77,8=
 @@</span><br><span> </span><br><span>     wait_pids=3D&quot;&quot;</span><=
br><span>     for line in $(cat =2E/*=2Elwip 2&gt;/dev/null); do</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        target_ip=3D$(echo $line=
|cut -d &quot;,&quot; -f 1)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        client_pid=3D$(echo $line|cut -d &quot;,&quot; -f 2)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        target_ip=3D$(echo $=
line | cut -d &quot;,&quot; -f 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        client_pid=3D$(echo $line | cut -d &quot;,&quot; -f 2=
)</span><br><span>         ping_and_kill $target_ip $client_pid &amp;</span=
><br><span>         wait_pids=3D&quot;$wait_pids $!&quot;</span><br><span> =
    done</span><br><span>@@ -84,7 +88,8 @@</span><br><span>     test -e =2E=
/lwip_failed &amp;&amp; return 1 || return 0</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_for_result=
s() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wait_for_resul=
ts()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an>     tests_running=3D&quot;yes&quot;</span><br><span> </span><br><span> =
    # Wait a bit to allow an OpenVPN client process to create a pidfile to<=
/span><br><span>@@ -106,12 +111,13 @@</span><br><span>     done</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-get_client_test_result() {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_client_test_result()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span>     test_name=3D$1</span><br><span>     =
should_pass=3D$2</span><br><span>     log=3D&quot;${test_name}=2Elog&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
grep &quot;Initialization Sequence Completed&quot; &quot;${t_server_null_lo=
gdir}/${log}&quot; &gt; /dev/null</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    grep &quot;Initialization Sequence Completed&quot; &quot;=
${t_server_null_logdir}/${log}&quot; &gt;/dev/null</span><br><span>     exi=
t_code=3D$?</span><br><span> </span><br><span>     if [ $exit_code -eq 0 ] =
&amp;&amp; [ &quot;${should_pass}&quot; =3D &quot;yes&quot; ]; then</span><=
br><span>@@ -144,7 +150,7 @@</span><br><span> server_max_wait=3D15</span><b=
r><span> while [ $count -lt $server_max_wait ]; do</span><br><span>     ser=
vers_up=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    server=
_count=3D$(echo &quot;$TEST_SERVER_LIST&quot;|wc -w|tr -d &quot; &quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    server_count=3D$(e=
cho &quot;$TEST_SERVER_LIST&quot; | wc -w | tr -d &quot; &quot;)</span><br>=
<span> </span><br><span>     # We need to trim single-quotes because some s=
hells return quoted values</span><br><span>     # and some don&#39;t=2E Usi=
ng &quot;set -o posix&quot; which would resolve this problem is</span><br><=
span>@@ -152,13 +158,13 @@</span><br><span>     #</span><br><span>     # Wh=
ile inactive server configurations may get checked they won&#39;t increase<=
/span><br><span>     # the active server count as the processes won&#39;t b=
e running=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for i=
 in $(set|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &qu=
ot;[\&#39;]&quot;); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        server_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt; /dev/null)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if [ -z &quot;$server_p=
id&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for i in $(set | grep &#39;SERVER_NAME_&#39; | cut -d &quot;=3D&quot; -f =
2 | tr -d &quot;[\&#39;]&quot;); do</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        server_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt;/dev/n=
ull)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z=
 &quot;$server_pid&quot; ]; then</span><br><span>             continue</spa=
n><br><span>         fi</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if $RUN_SUDO kill -0 $server_pid &gt; /dev/null 2&gt;&amp;1; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            servers_u=
p=3D$(( $servers_up + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if $RUN_SUDO kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ser=
vers_up=3D$(($servers_up + 1))</span><br><span>         fi</span><br><span>=
     done</span><br><span> </span><br><span>@@ -168,7 +174,7 @@</span><br><=
span>         retval=3D0</span><br><span>         break</span><br><span>   =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        count=
=3D$(( count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       count=3D$((count + 1))</span><br><span>         sleep 1</span><br><s=
pan>     fi</span><br><span> </span><br><span>@@ -199,15 +205,14 @@</span><=
br><span> # safe to check the test results=2E</span><br><span> test_names=
=3D&quot;&quot;</span><br><span> lwip_test_names=3D&quot;&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>=
     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     e=
val client_exec=3D\&quot;\$CLIENT_EXEC_$SUF\&quot;</span><br><span>     eva=
l client_conf=3D\&quot;\$CLIENT_CONF_$SUF\&quot;</span><br><span> </span><b=
r><span>     test_names=3D&quot;${test_names} ${test_name}&quot;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if echo &q=
uot;$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if echo &quot;$test_name&quot; | grep -q _lwip; th=
en</span><br><span>         lwip_test_names=3D&quot;${lwip_test_names} ${te=
st_name}&quot;</span><br><span>     fi</span><br><span> </span><br><span>@@=
 -219,13 +224,11 @@</span><br><span> ping_lwip_clients</span><br><span> ret=
val=3D$?</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> # Wait until all OpenVPN clients have exited</span><=
br><span> (wait_for_results)</span><br><span> </span><br><span> # Check tes=
t results</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $=
TEST_RUN_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST=
; do</span><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</=
span><br><span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</sp=
an><br><span> </span><br><span>diff --git a/tests/t_server_null_server=2Esh=
 b/tests/t_server_null_server=2Esh</span><br><span>index e1775f0=2E=2Ea8d72=
68 100755</span><br><span>--- a/tests/t_server_null_server=2Esh</span><br><=
span>+++ b/tests/t_server_null_server=2Esh</span><br><span>@@ -1,6 +1,7 @@<=
/span><br><span> #!/bin/sh</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-launch_server() {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+launch_server()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span>     server_name=3D$1</span><br><span>  =
   server_exec=3D$2</span><br><span>     server_conf=3D$3</span><br><span>@=
@ -17,10 +18,10 @@</span><br><span> </span><br><span>     # Try to launch t=
he server</span><br><span>     $RUN_SUDO &quot;${server_exec}&quot; \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-               $server_conf=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               --st=
atus &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-               --writepid &quot;${pid}&quot; \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-               --explicit-exit-notify 3 &=
gt; &quot;$log&quot; 2&gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        $server_conf \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        --status &quot;${status}&quot; 1 \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        --writepid &quot;${pid=
}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --=
explicit-exit-notify 3 &gt;&quot;$log&quot; 2&gt;&amp;1 &amp;</span><br><sp=
an> </span><br><span>     sleep 1</span><br><span> </span><br><span>@@ -44,=
8 +45,7 @@</span><br><span> retval=3D0</span><br><span> </span><br><span> #=
 Launch test servers</span><br><span style=3D"color: hsl(0, 100%, 40%);">-f=
or SUF in $TEST_SERVER_LIST</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in =
$TEST_SERVER_LIST; do</span><br><span>     eval server_name=3D\&quot;\$SERV=
ER_NAME_$SUF\&quot;</span><br><span>     eval server_exec=3D\&quot;\$SERVER=
_EXEC_$SUF\&quot;</span><br><span>     eval server_conf=3D\&quot;\$SERVER_C=
ONF_$SUF\&quot;</span><br><span>@@ -57,8 +57,7 @@</span><br><span> # the te=
st run=2E</span><br><span> #</span><br><span> export server_pid_files=3D&qu=
ot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $=
TEST_SERVER_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVE=
R_LIST; do</span><br><span>     eval server_name=3D\&quot;\$SERVER_NAME_$SU=
F\&quot;</span><br><span>     server_pid_files=3D&quot;${server_pid_files} =
=2E/${server_name}=2Epid&quot;</span><br><span> done</span><br><span>@@ -69=
,12 +68,11 @@</span><br><span> count=3D0</span><br><span> maxcount=3D4</spa=
n><br><span> while [ $count -le $maxcount ]; do</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if ls t_server_null_client=2Esh*=2Epid &gt; /=
dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ls t_=
server_null_client=2Esh*=2Epid &gt;/dev/null 2&gt;&amp;1; then</span><br><s=
pan>         count=3D0</span><br><span>         sleep 1</span><br><span>   =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	count=3D$(( co=
unt + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
unt=3D$((count + 1))</span><br><span>         sleep 1</span><br><span>     =
fi</span><br><span> done</span><br><span>@@ -85,11 +83,10 @@</span><br><spa=
n> # server process does not exit in 15 seconds assume it never will, move =
on and</span><br><span> # hope for the best=2E</span><br><span> echo &quot;=
Waiting for servers to exit&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-for PID_FILE in $server_pid_files</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+for PID_FILE in $server_pid_files; do</span><br><span>     SERVER_PI=
D=3D$(cat &quot;${PID_FILE}&quot;)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$SERVER_PID&quot; ] ; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;=
$SERVER_PID&quot; ]; then</span><br><span>         echo &quot;WARNING: coul=
d not kill server ${PID_FILE}!&quot;</span><br><span>         continue</spa=
n><br><span>     fi</span><br><span>@@ -99,17 +96,16 @@</span><br><span> </=
span><br><span>     count=3D0</span><br><span>     maxcount=3D75</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    while [ $count -le $maxcount=
 ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO kill -0 &quot;${=
SERVER_PID}&quot; 2&gt; /dev/null || break</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        count=3D$(( count + 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while [ $count -le $maxcount ]; do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO kill=
 -0 &quot;${SERVER_PID}&quot; 2&gt;/dev/null || break</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        count=3D$((count + 1))</span><br>=
<span>         sleep 0=2E2</span><br><span>     done</span><br><span> </spa=
n><br><span>     # If server is still up send a SIGKILL</span><br><span>   =
  if [ $count -ge $maxcount ]; then</span><br><span>         $RUN_SUDO $KIL=
L_EXEC -9 &quot;${SERVER_PID}&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        SERVER_NAME=3D$(basename $PID_FILE|cut -d =2E -f 1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SERVER_NAME=
=3D$(basename $PID_FILE | cut -d =2E -f 1)</span><br><span>         echo &q=
uot;ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_P=
ID}!&quot;</span><br><span>         echo &quot;Tail of server log:&quot;</s=
pan><br><span>         tail -n 20 &quot;${t_server_null_logdir}/${SERVER_NA=
ME}=2Elog&quot;</span><br><span>diff --git a/tests/t_server_null_stress=2Es=
h b/tests/t_server_null_stress=2Esh</span><br><span>index 0bb9452=2E=2E2fc9=
fde 100755</span><br><span>--- a/tests/t_server_null_stress=2Esh</span><br>=
<span>+++ b/tests/t_server_null_stress=2Esh</span><br><span>@@ -7,8 +7,7 @@=
</span><br><span> =2E =2E/t_server_null_default=2Erc</span><br><span> </spa=
n><br><span> export pid_files=3D&quot;&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVER_LIST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do</span><br><span>     eval s=
erver_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span>     pid_file=
s=3D&quot;${pid_files} =2E/${server_name}=2Epid&quot;</span><br><span> done=
</span><br><span>@@ -18,16 +17,16 @@</span><br><span> </span><br><span> cou=
nt=3D0</span><br><span> while [ $count -lt $ITERATIONS ]; do</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    count=3D$(( count + 1 ))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    make check TESTS=3Dt_serv=
er_null=2Esh SUBDIRS=3D &gt; /dev/null 2&gt;&amp;1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    count=3D$((count + 1))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    make check TESTS=3Dt_server_null=
=2Esh SUBDIRS=3D &gt;/dev/null 2&gt;&amp;1</span><br><span>     retval=3D$?=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 echo &quot;Iteration ${count}: return value ${retval}&quot; &gt;&gt; &quot=
;${LOG_BASEDIR}/make-check=2Elog&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    echo &quot;Iteration ${count}: return value ${retval=
}&quot; &gt;&gt;&quot;${LOG_BASEDIR}/make-check=2Elog&quot;</span><br><span=
>     if [ $retval -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	DIR=3D&quot;${LOG_BASEDIR}/make-check-${count}&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        DIR=3D&quot;${LOG_BASE=
DIR}/make-check-${count}&quot;</span><br><span>         mkdir -p &quot;${DI=
R}&quot;</span><br><span>         cp t_server_null*=2Elog &quot;${DIR}/&quo=
t;</span><br><span>         cp test-suite=2Elog &quot;${DIR}/&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ps aux|grep openvpn|g=
rep -vE &#39;(suppress|grep)&#39; &gt; &quot;${DIR}/psaux&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ps aux | grep openvpn |=
 grep -vE &#39;(suppress|grep)&#39; &gt;&quot;${DIR}/psaux&quot;</span><br>=
<span>     fi</span><br><span> done</span><br><span>diff --git a/tests/upda=
te_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh</span><br><span>index=
 96e3826=2E=2E777a286 100755</span><br><span>--- a/tests/update_t_client_ip=
s=2Esh</span><br><span>+++ b/tests/update_t_client_ips=2Esh</span><br><span=
>@@ -5,12 +5,12 @@</span><br><span> </span><br><span> RC=3D&quot;$TOP_BUILD=
DIR/t_client_ips=2Erc&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/nul=
l 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+grep E=
XPECT_IFCONFIG4_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> =
if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    echo &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $=
RC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EX=
PECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span=
> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG6_$TESTNU=
M=3D $RC &gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_I=
FCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local&quot; &gt;&gt; $RC</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG6_$TE=
STNUM=3D$ifconfig_ipv6_local&quot; &gt;&gt;$RC</span><br><span> fi</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1793?usp=3Demail">change 1793</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6=
b9a5c9ffdbf332a0f </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1793 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--k3P89T7fhDA=--


--===============8595442865609588417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8595442865609588417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8595442865609588417==--

