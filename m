Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E776CC44523
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DsjA7fc7ImHchrkw3EQo505nptRhsJWN9kzeVeHJoiI=; b=WSRAFVTj+njzU2
	XkWEv5Toll0QrN48cmUUz8CfyRjUFs7XTvthmSrZEPLKK6thNkPoYOzN4lyignNjEKgvWNveJSCwL
	y24eWW0ztZ51hBD+zde0U0im2x5WIT61v1VImqAIbUmsoU/VnGWfC5BWXFTKnWfwiaH8q1Le3oCzQ
	Q7M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wklKD-0005FA-4s;
	Fri, 17 Jul 2026 16:22:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wklK9-0005F1-MD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wy7H8hekWKrF69TCoAt0NLOzbRz7uh6PSq1SiseqPa4=; b=S/37WFsI7BqyoDBoX6sblPeV1E
 GRW/suK9HWymZIJd+FmkB4EGT6jaelhdEHoYPWGERfx0SquMarwLg5/XFw65AXHkcYAV39RE3EId4
 Wn6veFuSO7Pp9XAgmUv5pieEX9aZi7hQzMNZX1rde9GOps/vYmbgi32Jdzo5sQj00nNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wy7H8hekWKrF69TCoAt0NLOzbRz7uh6PSq1SiseqPa4=; b=Y
 sXPlmPY5XLOCrXuMUiaC7vprPoawKG0AKFSphGMAdjM2WwJFfOCLoeT5FV+dagpwupd0/HTeFKP3v
 IaGPoeEpeytauq7DYIsrBpUIvfqgXmsUXubYoBeNpehoSv51ajX3X+ONDCHNerYpyylL87F7SRqrn
 URFFY6T4mdaKMttk=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wklK2-0002MG-E9 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:05 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so4563124f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784305312; x=1784910112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wy7H8hekWKrF69TCoAt0NLOzbRz7uh6PSq1SiseqPa4=;
 b=DHGxXAwW5wu7VGeeXvXiG/BVNtF53t5YhQg7QWpzFdMmcXbzU5a26xLO7YSt6FXN2O
 J2NUiLL8zcDfSs8BSYhe/nZ42cPfOJmgWxHx5qbi6d08wmYAc0+SQSUsI7K7dj4vYT+2
 si1Y8YJAnemK2VKDM1RHGU8Tppml49AqFUCd5Yah+iOOh6laKElZfGU0KJntD79cG034
 nHJELKgGZwteevn/q6ihg3atzmJylt4KNE1VHb8SheGzEKgeH0k8Z4N6lYpPvOPvw03W
 aBUicXYgV+9dAtG2Wx7RhEGZE2sj8bQkK+o0g3TceY0K0m2E3zzBPQzJE6N7oXEvvwJW
 cswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784305312; x=1784910112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wy7H8hekWKrF69TCoAt0NLOzbRz7uh6PSq1SiseqPa4=;
 b=PmuuG3IIOctV+yJoaAb3Xd2ZmuKedZygt9Cl/jS1gcKughRKbzqgsaaiBGesxvDIX2
 6bVIqtqvRfPuUIVpTPxCrqbYF3epXU1xeC0WPtmiTz/eENCfIBNeikCDO7sfmNgGg7/q
 Wr8YrB9d4G9Tm/5QhB7Y0IIUbZ/EFqXPO2aLtxA+4A8/j2jEmG5iVJ0tJ1nbSVFhuMy2
 UPe5ZEYfyEbQ/F0C8cgIakbTPUMserReqvRFjXpAEaYxAa4sPk7g1WIvH+rkACebNOXW
 6bPjnh1Ao5n+0pSPJSPaHCqkDboJkSoyY95f46o4Pp9X23W2iQjeY47Rsgk7DUulIQN2
 z9Ig==
X-Gm-Message-State: AOJu0YxQvBU25INjQnu+BzFQdL7dcEeWmRFceRBlw8CGaz6CBDXQim2W
 uvuwHynursbZ4/z/+bNaXjDMkYdwfCrD6Q1dZNevTRpZoV4EDdkQwQ5UmDRxbyEHYfeACSjUySj
 leseOV6CreMwvqf0CEote4lyLrd4zUVoko6QmRABsvLfMgcOlLQk8TQfeSgDsZ+dBeKr2PfT4cp
 rLBVbfFw==
X-Gm-Gg: AfdE7cmpE9FHA/KAmATjwDZojR+MM3b491cU5ojUPdbu4sEtip/YDn1Nrzy3i1uHeJ+
 vYwYxHQ+24NIAKtt1+rnJzwbDo8AVGNDu5VHDz1FQwjhUPDWFlIIgHE2Cvh7UxG+sz2FaHxGxB9
 9f32ReZwwCRX8bQl1KAmepivtZNro5YF3ORn9BmAJmWAo0Rhfhr5V3htZHWFE1sJssiQ+Q8M90t
 6MdqMOhxFbtEIz7q65hAPnN20W1eoJFYPIYGtY91gLxlQ5V+5VdAoC0X/eYloVfEQkjVWSgUkJ3
 E5LxDEN0vcHOi3w9h1/fTh/JEFWQyjFVm57+zxdNqg8qsdtJA42ccgO+avFHHmPhNmFMPpEBd3p
 ZVfBkBrzNjG3geF/TsTDZ7WsyPZ07V4uk1ulhPPKUJ1revMqvNd8us1X3fqqLO3hrFbEbs8Y2Pe
 YDRDVfCQntBZJL6CXRlvQ9qWj1HgLIAwDuAiqekq1AKj2c3US437jdGKMEoSHv6k9iUldqRMf5U
 JsF3+QapF+p/CTm1Im2wGF4u93AzcvMWvo1/EvTYPslqIIFIeESi+SqlQV6H6G26w29
X-Received: by 2002:a05:6000:71a:b0:47f:2de3:b34d with SMTP id
 ffacd0b85a97d-47f6233498bmr4408513f8f.46.1784305310571; 
 Fri, 17 Jul 2026 09:21:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcd13sm4899457f8f.26.2026.07.17.09.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:21:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 16:21:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: d0cd33880c2af6a8573bee59a325bf8b084440be
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b10d5b94724e2b1c9f29e2cfd64f36447d6d0d06-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wklK2-0002MG-E9
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5106228158672758641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5106228158672758641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BABN8j8lvKA="; charset=UTF-8

--BABN8j8lvKA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1793?usp=3Demail

to review the following change=2E


Chang=
e subject: Reformat all shell-scripts with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reformat all shell-scripts with shfmt=


According to =2E/dev-tools/reformat-shell=2Esh=2E

Change-Id: I76cd38fc4f=
43c2b75ed4ca6b9a5c9ffdbf332a0f
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
---
M dev-tools/gen-release-tarballs=2Esh
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
15 files changed, 447 insertions(+), 468 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1793/=
1

diff --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release=
-tarballs=2Esh
index 6071b57=2E=2E08ae385 100755
--- a/dev-tools/gen-releas=
e-tarballs=2Esh
+++ b/dev-tools/gen-release-tarballs=2Esh
@@ -21,7 +21,7 @@=

 if [ $# -ne 4 ]; then
     echo "Usage: $0 <remote-name> <tag-name> <sign=
-key> <dest-dir>"
     echo ""
-    echo "   remote-name  -- valid remotes:=
 `git remote | tr \\\n ' '`"
+    echo "   remote-name  -- valid remotes: $=
(git remote | tr \\n ' ')"
     echo "   tag-name     -- An existing releas=
e tag"
     echo "   sign-key     -- PGP key used to sign all files"
     e=
cho "   dest-dir     -- Where to put the complete set of release tarballs"
=
@@ -48,7 +48,7 @@
 fi
 
 # Extract the git URL
-giturl=3D"`git remote get-u=
rl $arg_remote_name 2>/dev/null`"
+giturl=3D"$(git remote get-url $arg_remo=
te_name 2>/dev/null)"
 if [ $? -ne 0 ]; then
     echo "** ERROR ** Invalid=
 git remote name: $arg_remote_name"
     exit 2
@@ -58,19 +58,17 @@
 echo "=
test" | gpg -a --clearsign -u "$arg_sign_key" 2>/dev/null 1>/dev/null
 if [=
 $? -ne 0 ]; then
     echo "** ERROR ** Failed when testing the PGP signin=
g=2E  Wrong signing key?"
-    exit 2;
+    exit 2
 fi
 
-
 #
 # Helper fun=
ctions
 #
 
-get_filename()
-{
+get_filename() {
     local wildcard=3D"$1"=

 
-    res=3D"`find =2E -maxdepth 1 -type f -name \"$wildcard\" | head -n1=
 | cut -d/ -f2-`"
+    res=3D"$(find =2E -maxdepth 1 -type f -name \"$wildc=
ard\" | head -n1 | cut -d/ -f2-)"
     if [ $? -ne 0 ]; then
         echo =
"-- 'find' failed=2E"
         exit 5
@@ -82,12 +80,11 @@
     echo "$res"
=
 }
 
-copy_files()
-{
+copy_files() {
     local fileext=3D"$1"
     local =
dest=3D"$2"
 
-    file=3D"`get_filename openvpn-*=2E*=2E*=2E$fileext`"
+  =
  file=3D"$(get_filename openvpn-*=2E*=2E*=2E$fileext)"
     if [ -z "$file=
" ]; then
         echo "** ERROR Failed to find source file"
         exit=
 5
@@ -96,46 +93,45 @@
     cp "$file" "$dest"
     if [ $? -ne 0 ]; then
 =
        echo "** ERROR ** Failed to copy $file to $destdir"
-        exit 3=
;
+        exit 3
     fi
 }
 
-sign_file()
-{
+sign_file() {
     local si=
gnkey=3D"$1"
     local srchfile=3D"$2"
     local signtype=3D"$3"
-    loc=
al file=3D"`get_filename $srchfile`"
+    local file=3D"$(get_filename $src=
hfile)"
 
     echo "-- Signing $file =2E=2E=2E"
     case "$signtype" in
-=
        inline)
-            # Have the signature in the same file as the d=
ata
-            gpg -a --clearsign -u "$signkey" "$file" 2>/dev/null
-    =
        res=3D$?
-            if [ $res -eq 0 ]; then
-                rm -=
f "$file"
-            fi
-            ;;
+    inline)
+        # Have the =
signature in the same file as the data
+        gpg -a --clearsign -u "$sig=
nkey" "$file" 2>/dev/null
+        res=3D$?
+        if [ $res -eq 0 ]; the=
n
+            rm -f "$file"
+        fi
+        ;;
 
-        detached)
-=
            # Have the signature in a separate file
-            gpg -a --d=
etach-sign -u "$signkey" "$file" 2>/dev/null
-            res=3D$?
-       =
     ;;
+    detached)
+        # Have the signature in a separate file
+  =
      gpg -a --detach-sign -u "$signkey" "$file" 2>/dev/null
+        res=
=3D$?
+        ;;
 
-        *)
-            echo "** ERROR **  Unknown sig=
ning type \"$signtype\"=2E"
-            exit 4;
+    *)
+        echo "** =
ERROR **  Unknown signing type \"$signtype\"=2E"
+        exit 4
+        ;=
;
     esac
 
     if [ $res -ne 0 ]; then
         echo "** ERROR **  Fail=
ed to sign the file $PWD/$file"
-        exit 4;
+        exit 4
     fi
 }=

 
-
 #
 # Preparations
 #
@@ -143,12 +139,12 @@
 # Create the destination =
directory, using a sub-dir with the tag-name
 destdir=3D""
 case "$arg_dest=
_dir" in
-    /*) # Absolute path
-        destdir=3D"$arg_dest_dir/$arg_ta=
g_name"
-        ;;
-    *)  # Make absolute path from relative path
-     =
   destdir=3D"$PWD/$arg_dest_dir/$arg_tag_name"
-        ;;
+/*) # Absolute=
 path
+    destdir=3D"$arg_dest_dir/$arg_tag_name"
+    ;;
+*) # Make absol=
ute path from relative path
+    destdir=3D"$PWD/$arg_dest_dir/$arg_tag_nam=
e"
+    ;;
 esac
 echo "-- Destination directory: $destdir"
 if [ -e "$dest=
dir" ]; then
@@ -168,61 +164,61 @@
 #
 
 # Clone the remote repository
-wor=
kdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
+workdir=3D"$=
(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
 cd $workdir
 echo "-=
- Working directory: $workdir"
 echo "-- git clone $giturl"
-git clone $git=
url openvpn-gen-tarball 2> "$workdir/git-clone=2Elog" 1>&2
+git clone $gitu=
rl openvpn-gen-tarball 2>"$workdir/git-clone=2Elog" 1>&2
 if [ $? -ne 0 ]; =
then
     echo "** ERROR **  git clone failed=2E  See $workdir/git-clone=2E=
log for details"
-    exit 3;
+    exit 3
 fi
 cd openvpn-gen-tarball
 
 # =
Check out the proper release tag
 echo "-- Checking out tag $arg_tag_name =
=2E=2E=2E "
-git checkout -b mkrelease "$arg_tag_name" 2> "$workdir/git-che=
ckout-tag=2Elog" 1>&2
+git checkout -b mkrelease "$arg_tag_name" 2>"$workdi=
r/git-checkout-tag=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     echo "** ERROR *=
*  git checkout failed=2E  See $workdir/git-checkout-tag=2Elog for details"=

-    exit 3;
+    exit 3
 fi
 
 # Prepare the source tree
 echo "-- Runnin=
g autoreconf + a simple configure =2E=2E=2E "
-(autoreconf -vi && =2E/confi=
gure) 2> "$workdir/autotools-prep=2Elog" 1>&2
+(autoreconf -vi && =2E/confi=
gure) 2>"$workdir/autotools-prep=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     ec=
ho "** ERROR **  Failed running autotools=2E  See $workdir/autotools-prep=
=2Elog for details"
-    exit 3;
+    exit 3
 fi
 
 # Generate the tar/zip =
files
 echo "-- Running make distcheck (generates =2Etar=2Egz) =2E=2E=2E "
=
-(make distcheck) 2> "$workdir/make-distcheck=2Elog" 1>&2
+(make distcheck)=
 2>"$workdir/make-distcheck=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     echo "*=
* ERROR **  make distcheck failed=2E  See $workdir/make-distcheck=2Elog for=
 details"
-    exit 3;
+    exit 3
 fi
 copy_files tar=2Egz "$destdir"
 
 e=
cho "-- Running make dist-xz (generates =2Etar=2Exz) =2E=2E=2E "
-(make dis=
t-xz) 2> "$workdir/make-dist-xz=2Elog" 1>&2
+(make dist-xz) 2>"$workdir/mak=
e-dist-xz=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     echo "** ERROR **  make d=
ist-xz failed=2E  See $workdir/make-dist-xz=2Elog for details"
-    exit 3;=

+    exit 3
 fi
 copy_files tar=2Exz "$destdir"
 
 echo "-- Running make d=
ist-zip (generates =2Ezip) =2E=2E=2E "
-(make dist-zip) 2> "$workdir/make-d=
ist-zip=2Elog" 1>&2
+(make dist-zip) 2>"$workdir/make-dist-zip=2Elog" 1>&2
=
 if [ $? -ne 0 ]; then
     echo "** ERROR **  make dist-zip failed=2E  See=
 $workdir/make-dist-zip=2Elog for details"
-    exit 3;
+    exit 3
 fi
 co=
py_files zip "$destdir"
 
 # Generate SHA256 checksums
 cd "$destdir"
-sha2=
56sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip > "openvpn-$arg_tag_name=2E=
sha256sum"
+sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip >"openvpn-$=
arg_tag_name=2Esha256sum"
 
 # Sign all the files
 echo "-- Signing files =
=2E=2E=2E "
diff --git a/dev-tools/git-pre-commit-format=2Esh b/dev-tools/g=
it-pre-commit-format=2Esh
index 9b2ecaf=2E=2Ef475130 100755
--- a/dev-tools=
/git-pre-commit-format=2Esh
+++ b/dev-tools/git-pre-commit-format=2Esh
@@ -=
26,7 +26,6 @@
 # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY=
 OF SUCH DAMAGE=2E
 
-
 # git pre-commit hook that runs a stylecheck=2E
 # =
Features:
 #  - abort commit when commit does not comply with the style gui=
delines
@@ -43,12 +42,11 @@
 # exit on error
 set -e
 
-
 # If called so, i=
nstall this script as pre-commit hook
-if [ "$1" =3D "install" ] ; then
+if=
 [ "$1" =3D "install" ]; then
     TARGET=3D"$(git rev-parse --git-path hoo=
ks)/pre-commit"
 
-    if [ -e "$TARGET" ] ; then
+    if [ -e "$TARGET" ];=
 then
         printf "$TARGET file exists=2E Won't overwrite=2E\n"
       =
  printf "Aborting installation=2E\n"
         exit 1
@@ -67,13 +65,13 @@
 =
    local extension=3D"=2E${filename##*=2E}"
     local ext
 
-    for ext =
in =2Ec =2Eh ; do [ "$ext" =3D "$extension" ] && return 0; done
+    for ex=
t in =2Ec =2Eh; do [ "$ext" =3D "$extension" ] && return 0; done
 
     ret=
urn 1
 }
 
 # necessary check for initial commit
-if git rev-parse --verify=
 HEAD >/dev/null 2>&1 ; then
+if git rev-parse --verify HEAD >/dev/null 2>&=
1; then
     against=3DHEAD
 else
     # Initial commit: diff against an em=
pty tree object
@@ -88,8 +86,8 @@
 
     # Allow to use in parallel with pr=
e-commit
     if [ $(basename "$0") =3D "pre-commit=2Elegacy" ]; then
-    =
   echo "Skipping clang-format check in favor of pre-commit"
-       exit 0=

+        echo "Skipping clang-format check in favor of pre-commit"
+      =
  exit 0
     fi
 else
     TOOL=3Duncrustify
@@ -98,7 +96,7 @@
     TOOL_C=
MD=3D"$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
 
     # make sure the config f=
ile is correctly set
-    if [ ! -f "$UNCRUST_CONFIG" ] ; then
+    if [ ! =
-f "$UNCRUST_CONFIG" ]; then
         printf "Error: uncrustify config file=
 not found=2E\n"
         printf "Expected to find it at $UNCRUST_CONFIG=2E=
\n"
         printf "Aborting commit=2E\n"
@@ -106,7 +104,7 @@
     fi
 fi
=
 
-if [ -z "$TOOL_BIN" ] ; then
+if [ -z "$TOOL_BIN" ]; then
     printf "E=
rror: $TOOL executable not found=2E\n"
     printf "Is it installed and in =
your \$PATH?\n"
     printf "Aborting commit=2E\n"
@@ -120,44 +118,43 @@
 #=
 create one patch containing all changes to the files
 # sed to remove quot=
es around the filename, if inserted by the system
 # (done sometimes, if th=
e filename contains special characters, like the quote itself)
-git diff-in=
dex --cached --diff-filter=3DACMR --name-only $against -- | \
-sed -e 's/^"=
\(=2E*\)"$/\1/' | \
-while read file
-do
-    # ignore file if we do check =
for file extensions and the file
-    # does not match the extensions =2Ec =
or =2Eh
-    if ! matches_extension "$file"; then
-        continue;
-    f=
i
+git diff-index --cached --diff-filter=3DACMR --name-only $against -- |
+=
    sed -e 's/^"\(=2E*\)"$/\1/' |
+    while read file; do
+        # ignor=
e file if we do check for file extensions and the file
+        # does not =
match the extensions =2Ec or =2Eh
+        if ! matches_extension "$file"; =
then
+            continue
+        fi
 
-    # escape special characters i=
n the target filename:
-    # phase 1 (characters escaped in the output dif=
f):
-    #     - '\': backslash needs to be escaped in the output diff
-   =
 #     - '"': quote needs to be escaped in the output diff if present insid=
e
-    #            of the filename, as it used to bracket the entire filen=
ame part
-    # phase 2 (characters escaped in the match replacement):
-   =
 #     - '\': backslash needs to be escaped again for sed itself
-    #    =
        (i=2Ee=2E double escaping after phase 1)
-    #     - '&': would ex=
pand to matched string
-    #     - '|': used as sed split char instead of =
'/'
-    # printf %s particularly important if the filename contains the % =
character
-    file_escaped_target=3D$(printf "%s" "$file" | sed -e 's/[\"]=
/\\&/g' -e 's/[\&|]/\\&/g')
+        # escape special characters in the tar=
get filename:
+        # phase 1 (characters escaped in the output diff):
+=
        #     - '\': backslash needs to be escaped in the output diff
+    =
    #     - '"': quote needs to be escaped in the output diff if present in=
side
+        #            of the filename, as it used to bracket the entir=
e filename part
+        # phase 2 (characters escaped in the match replace=
ment):
+        #     - '\': backslash needs to be escaped again for sed it=
self
+        #            (i=2Ee=2E double escaping after phase 1)
+      =
  #     - '&': would expand to matched string
+        #     - '|': used as=
 sed split char instead of '/'
+        # printf %s particularly important =
if the filename contains the % character
+        file_escaped_target=3D$(p=
rintf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
 
-    # unc=
rustify our sourcefile, create a patch with diff and append it to our $patc=
h
-    # The sed call is necessary to transform the patch from
-    #    --=
- - timestamp
-    #    +++ $tmpout timestamp
-    # to both lines working =
on the same file and having a a/ and b/ prefix=2E
-    # Else it can not be=
 applied with 'git apply'=2E
-    git show ":$file" | $TOOL_CMD > "$tmpout"=

-    git show ":$file" | diff -u -- - "$tmpout" | \
-        sed -e "1s|--=
- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file_escap=
ed_target\"|" >> "$patch"
-done
+        # uncrustify our sourcefile, creat=
e a patch with diff and append it to our $patch
+        # The sed call is =
necessary to transform the patch from
+        #    --- - timestamp
+      =
  #    +++ $tmpout timestamp
+        # to both lines working on the same f=
ile and having a a/ and b/ prefix=2E
+        # Else it can not be applied =
with 'git apply'=2E
+        git show ":$file" | $TOOL_CMD >"$tmpout"
+    =
    git show ":$file" | diff -u -- - "$tmpout" |
+            sed -e "1s|--=
- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file_escap=
ed_target\"|" >>"$patch"
+    done
 
 rm -f "$tmpout"
 
 # if no patch has =
been generated all is ok, clean up the file stub and exit
-if [ ! -s "$patc=
h" ] ; then
+if [ ! -s "$patch" ]; then
     rm -f "$patch"
     exit 0
 fi=

@@ -165,7 +162,7 @@
 # a patch has been created, notify the user and exit
=
 printf "Formatting of some code does not follow the project guidelines=2E\=
n"
 
-if [ $(wc -l < $patch) -gt 80 ] ; then
+if [ $(wc -l <$patch) -gt 80 =
]; then
     printf "The file $patch contains the necessary fixes=2E\n"
 el=
se
     printf "Here's the patch that fixes the formatting:\n\n"
diff --git=
 a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 40db33e=
=2E=2Ea7aa3c4 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-=
cppcheck=2Esh
@@ -20,24 +20,23 @@
  --check-level=3Dexhaustive --max-config=
s=3D10 \
  --error-exitcode=3D1"
 
-
 set -x
 
 mkdir -p "$CPPCHECK_DIR"
 c=
d "${SOURCE_DIR}"
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
-         --platf=
orm=3Dunix64 \
-         --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --li=
brary=3Dgnu=2Ecfg \
-         -U_WIN32 \
-         src/openvpn/ src/compat/=
 src/plugins/ sample/ \
-         tests/unit_tests/example_test/ tests/unit=
_tests/openvpn/ \
-         tests/unit_tests/plugins/
+    --platform=3Duni=
x64 \
+    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2E=
cfg \
+    -U_WIN32 \
+    src/openvpn/ src/compat/ src/plugins/ sample/ \
=
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
+    tests/=
unit_tests/plugins/
 cppcheck $COMMON_ARGS \
-         --platform=3Dwin64 \=

-         --library=3Dwindows=2Ecfg \
-         -D_WIN32 \
-         -UTAR=
GET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
-         -UT=
ARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
-      =
   -UTARGET_AIX \
-         src/openvpn* src/compat/ \
-         tests/unit=
_tests/example_test/ tests/unit_tests/openvpn*
+    --platform=3Dwin64 \
+ =
   --library=3Dwindows=2Ecfg \
+    -D_WIN32 \
+    -UTARGET_LINUX -UTARGET=
_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+    -UTARGET_DARWIN -UTARGET_A=
NDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+    -UTARGET_AIX \
+    src/o=
penvpn* src/compat/ \
+    tests/unit_tests/example_test/ tests/unit_tests/=
openvpn*
diff --git a/dev-tools/update-copyright=2Esh b/dev-tools/update-co=
pyright=2Esh
index 96546dd=2E=2E7ca6002 100755
--- a/dev-tools/update-copyr=
ight=2Esh
+++ b/dev-tools/update-copyright=2Esh
@@ -34,8 +34,7 @@
 COPY_YEA=
R=3D"$1"
 
 cd "$(git rev-parse --show-toplevel)"
-for file in $(git ls-fil=
es | grep -v vendor/);
-do
+for file in $(git ls-files | grep -v vendor/); =
do
     echo -n "Updating $file =2E=2E=2E"
     # The first sed operation c=
overs 20xx-20yy copyright lines,
     # The second sed operation changes 20=
xx -> 20xx-20yy
diff --git a/tests/lwip_client_up=2Esh b/tests/lwip_client_=
up=2Esh
index a6b4d24=2E=2Eb1941a4 100755
--- a/tests/lwip_client_up=2Esh
+=
++ b/tests/lwip_client_up=2Esh
@@ -2,16 +2,17 @@
 #
 # Determine the OpenVP=
N PID from its pid file=2E This works reliably even when
 # the OpenVPN pro=
cess is backgrounded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY_PPID=
=3D$(cat $pid)
 
 # Add this client's VPN IP and PID to a file=2E This enab=
les
 # t_server_null_client=2Esh to kill this OpenVPN client after fping te=
sts have
 # finished=2E
-echo "$ifconfig_local,$MY_PPID" >> =2E/$test_name=
=2Elwip
+echo "$ifconfig_local,$MY_PPID" >>=2E/$test_name=2Elwip
 
 # Wait =
long enough to allow fping tests to finish=2E Also ensure that this
 # Open=
VPN client is killed even if t_server_null_client=2Esh failed to do it=2E
-=
(sleep 15
-echo "ERROR: t_server_null_client=2Esh failed to kill OpenVPN cl=
ient with PID $MY_PPID in test $test_name=2E Killing it in lwip_client_up=
=2Esh=2E"
-kill -15 $MY_PPID
+(
+    sleep 15
+    echo "ERROR: t_server_nu=
ll_client=2Esh failed to kill OpenVPN client with PID $MY_PPID in test $tes=
t_name=2E Killing it in lwip_client_up=2Esh=2E"
+    kill -15 $MY_PPID
 ) &=

diff --git a/tests/null_client_up=2Esh b/tests/null_client_up=2Esh
index d=
4df0c6=2E=2Ebe339ee 100755
--- a/tests/null_client_up=2Esh
+++ b/tests/null=
_client_up=2Esh
@@ -4,8 +4,11 @@
 
 # Determine the OpenVPN PID from its pi=
d file=2E This works reliably even when
 # the OpenVPN process is backgroun=
ded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY_PPID=3D$(cat $pid)
 
 #=
 Allow OpenVPN to finish initializing while waiting in the background and t=
hen
 # killing the process gracefully=2E
-(sleep 5 ; kill -15 $MY_PPID) &
+=
(
+    sleep 5
+    kill -15 $MY_PPID
+) &
diff --git a/tests/t_client=2Esh=
=2Ein b/tests/t_client=2Esh=2Ein
index 7233187=2E=2E4b6c51d 100755
--- a/te=
sts/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,9 +19,9 @@
 sr=
cdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E}"
 openvpn=
=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
-if [ -r "${top_buildd=
ir}"/t_client=2Erc ] ; then
+if [ -r "${top_builddir}"/t_client=2Erc ]; the=
n
     =2E "${top_builddir}"/t_client=2Erc
-elif [ -r "${srcdir}"/t_client=
=2Erc ] ; then
+elif [ -r "${srcdir}"/t_client=2Erc ]; then
     =2E "${src=
dir}"/t_client=2Erc
 else
     echo "$0: cannot find 't_client=2Erc' in bui=
ld dir ('${top_builddir}')" >&2
@@ -32,37 +32,35 @@
 # Check for external d=
ependencies
 FPING=3D"fping"
 FPING6=3D"fping6"
-which fping > /dev/null
+w=
hich fping >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping is not av=
ailable in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
-which fping6 > /=
dev/null
+which fping6 >/dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fpi=
ng6 is not available in \$PATH, assuming fping 4=2E0 or later" >&2
     FPI=
NG=3D"fping -4"
     FPING6=3D"fping -6"
 fi
 
-KILL_EXEC=3D`which kill`
+K=
ILL_EXEC=3D$(which kill)
 if [ $? -ne 0 ]; then
     echo "$0: kill not fou=
nd in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
 
-if [ ! -x "${openvp=
n}" ]
-then
+if [ ! -x "${openvpn}" ]; then
     echo "no (executable) open=
vpn binary in current build tree=2E FAIL=2E" >&2
     exit 1
 fi
 
-if [ ! =
-w =2E ]
-then
+if [ ! -w =2E ]; then
     echo "current directory is not w=
ritable (required for logging)=2E FAIL=2E" >&2
     exit 1
 fi
 
-if [ -z "=
$TEST_RUN_LIST" ] ; then
+if [ -z "$TEST_RUN_LIST" ]; then
     echo "TEST_=
RUN_LIST empty, no tests defined=2E  SKIP test=2E" >&2
     exit "${TCLIENT=
_SKIP_RC}"
 fi
@@ -72,16 +70,14 @@
 
 # make sure we have permissions to ru=
n ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work on S=
olaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+ID=3D$(id)=

+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${PREF=
ER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
       =
  # Check if we have a valid kerberos ticket
         klist -l 1>/dev/null =
2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if [ $? -ne 0 =
]; then
             # No kerberos ticket found, skip ksu and fallback to R=
UN_SUDO
             PREFER_KSU=3D0
             echo "$0: No Kerberos tick=
et available=2E  Will not use ksu=2E"
@@ -90,8 +86,7 @@
         fi
     fi=

 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; then
  =
       echo "$0: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E " >=
&2
         echo "      must be set correctly in 't_client=2Erc'=2E SKIP=2E=
" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -99,19 +94,18 @@
         # We =
have to use sudo=2E Make sure that we (hopefully) do not have
         # to=
 ask the users password during the test=2E This is done to
         # preve=
nt timing issues, e=2Eg=2E when the waits for openvpn to start
-	if $RUN_SU=
DO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 succeede=
d, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot g=
o on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKIP_RC}"
-	fi
+        if $RUN_=
SUDO $KILL_EXEC -0 $$; then
+            echo "$0: $RUN_SUDO $KILL_EXEC -0 =
succeeded, good=2E"
+        else
+            echo "$0: $RUN_SUDO $KILL_EX=
EC -0 failed, cannot go on=2E SKIP=2E" >&2
+            exit "${TCLIENT_SKI=
P_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_client-`hostname`-`date +%Y%m%=
d-%H%M%S`
-if mkdir $LOGDIR
-then :
+LOGDIR=3Dt_client-$(hostname)-$(date +=
%Y%m%d-%H%M%S)
+if mkdir $LOGDIR; then
+    :
 else
     echo "can't create=
 log directory '$LOGDIR'=2E FAIL=2E" >&2
     exit 1
@@ -128,103 +122,105 @=
@
 
 # output progress information
 #  depending on verbosity level, collec=
t & print only on failure
-output_start()
-{
+output_start() {
     case $V=
 in
-	0) outbuf=3D"" ;;			# no per-test output at all
-	1) echo -e "$@"			#=
 compact, details only on failure
-           outbuf=3D"\n" ;;
-	*) echo -e=
 "\n$@\n" ;;		# print all, with a bit formatting
+    0) outbuf=3D"" ;; # n=
o per-test output at all
+    1)
+        echo -e "$@" # compact, details o=
nly on failure
+        outbuf=3D"\n"
+        ;;
+    *) echo -e "\n$@\n" =
;; # print all, with a bit formatting
     esac
 }
 
-output()
-{
-    NO_N=
L=3D''; if [ "X$1" =3D "X-n" ] ; then NO_NL=3D$1 ; shift ; fi
+output() {
+=
    NO_NL=3D''
+    if [ "X$1" =3D "X-n" ]; then
+        NO_NL=3D$1
+     =
   shift
+    fi
     case $V in
-	0) ;;				# no per-test output at all
-	1=
) outbuf=3D"$outbuf$@" 		# print details only on failure
-	   test -z "$NO_=
NL" && outbuf=3D"$outbuf\n"
-           ;;
-	*) echo -e $NO_NL "$@" ;;	# pr=
int everything
+    0) ;; # no per-test output at all
+    1)
+        outb=
uf=3D"$outbuf$@" # print details only on failure
+        test -z "$NO_NL" =
&& outbuf=3D"$outbuf\n"
+        ;;
+    *) echo -e $NO_NL "$@" ;; # print =
everything
     esac
 }
 
 # print failure message, increase FAIL counter
-=
fail()
-{
+fail() {
     output "FAIL: $@\n"
-    fail_count=3D$(( $fail_co=
unt + 1 ))
+    fail_count=3D$(($fail_count + 1))
 }
 
 # print "all interf=
ace IP addresses" + "all routes"
 # this is higly system dependent=2E=2E=2E=

-get_ifconfig_route()
-{
-    UNAME=3D`uname -s`
+get_ifconfig_route() {
+=
    UNAME=3D$(uname -s)
     case $UNAME in
-	Linux)
-            # linux /=
 iproute2? (-> if configure got a path)
-            if [ -n "@IPROUTE@" ]
=
-            then
-                echo "-- linux iproute2 --"
-           =
     @IPROUTE@ addr show     | grep -v valid_lft
-                @IPROUTE@=
 route show
-                @IPROUTE@ -o -6 route show | grep -v ' cache' =
| sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0=
-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
-            else
-	        echo =
"-- linux / ifconfig --"
-	        LANG=3DC @IFCONFIG@ -a |egrep  "( addr:|=
encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 -6
-            fi
-          =
  ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X]=
 --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk =
'$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	OpenBSD)
-	   echo "-- Open=
BSD --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)" | \
-		sed -e 's/pltim=
e [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ {=
 print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	   echo "-- Solaris --"
-	   @IFC=
ONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ =
{ print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	   echo "-- AIX --"
-	   @IFCONFIG@=
 -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { prin=
t $1,$2,$3,$6 }'
-	   ;;
-        *)
-           echo "get_ifconfig_route()=
: no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E" >&2
-       =
    exit 20
-           ;;
+    Linux)
+        # linux / iproute2? (-> if =
configure got a path)
+        if [ -n "@IPROUTE@" ]; then
+            ech=
o "-- linux iproute2 --"
+            @IPROUTE@ addr show | grep -v valid_l=
ft
+            @IPROUTE@ route show
+            @IPROUTE@ -o -6 route sho=
w | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hopli=
mit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
+        els=
e
+            echo "-- linux / ifconfig --"
+            LANG=3DC @IFCONFI=
G@ -a | egrep "( addr:|encap:)"
+            LANG=3DC @NETSTAT@ -rn -4 -6
+=
        fi
+        ;;
+    FreeBSD | NetBSD | Darwin)
+        echo "-- Fr=
eeBSD/NetBSD/Darwin [MacOS X] --"
+        @IFCONFIG@ -a | egrep "(flags=3D=
|inet)"
+        @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
=
+        ;;
+    OpenBSD)
+        echo "-- OpenBSD --"
+        @IFCONFIG@=
 -a | egrep "(flags=3D|inet)" |
+            sed -e 's/pltime [0-9]*//' -e =
's/vltime [0-9]*//'
+        @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$=
2,$3,$NF }'
+        ;;
+    SunOS)
+        echo "-- Solaris --"
+        =
@IFCONFIG@ -a | egrep "(flags=3D|inet)"
+        @NETSTAT@ -rn | awk '$3 !~=
 /^UHL/ { print $1,$2,$3,$6 }'
+        ;;
+    AIX)
+        echo "-- AIX =
--"
+        @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+        @NETSTAT@ -rn=
 | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+        ;;
+    *)
+        ec=
ho "get_ifconfig_route(): no idea how to get info on your OS ($(uname -s))=
=2E  FAIL=2E" >&2
+        exit 20
+        ;;
     esac
 
     # another r=
ound of per-platform information gathering, for DNS info
     # for most of=
 the platforms "cat /etc/resolv=2Econf" is good enough
     # except Linux =
and MacOS
     case $UNAME in
-	Linux)
-            if [ -x /usr/bin/resolv=
ectl -a -d /run/systemd/system ] ; then
-                echo "-- linux res=
olvectl --"
-                resolvectl status
-            else
-         =
       echo "-- linux resolv=2Econf --"
-                cat /etc/resolv=2E=
conf
-            fi
-            ;;
-	Darwin)
-            echo "-- MacOS =
scutil --dns"
-            scutil --dns
-            ;;
-        *)
-      =
      echo "-- resolv=2Econf --"
+    Linux)
+        if [ -x /usr/bin/reso=
lvectl -a -d /run/systemd/system ]; then
+            echo "-- linux resolv=
ectl --"
+            resolvectl status
+        else
+            echo "--=
 linux resolv=2Econf --"
             cat /etc/resolv=2Econf
-            ;=
;
+        fi
+        ;;
+    Darwin)
+        echo "-- MacOS scutil --dns=
"
+        scutil --dns
+        ;;
+    *)
+        echo "-- resolv=2Econf=
 --"
+        cat /etc/resolv=2Econf
+        ;;
     esac
 }
 
@@ -232,21 =
+228,20 @@
 # check ifconfig
 #  arg1: "4" or "6" -> for message
 #  arg2: =
IPv4/IPv6 address that must show up in out of "get_ifconfig_route"
-check_i=
fconfig()
-{
-    proto=3D$1 ; shift
+check_ifconfig() {
+    proto=3D$1
+ =
   shift
     expect_list=3D"$@"
 
-    if [ -z "$expect_list" ] ; then ret=
urn ; fi
-    if [ "$expect_list" =3D "-" ] ; then return ; fi
+    if [ -z=
 "$expect_list" ]; then return; fi
+    if [ "$expect_list" =3D "-" ]; then=
 return; fi
 
-    for expect in $expect_list
-    do
-	if get_ifconfig_rou=
te | fgrep "$expect" >/dev/null
-	then :
-	else
-	    fail "check_ifconfig(=
): expected IPv$proto address '$expect' not found in ifconfig output=2E"
-	=
fi
+    for expect in $expect_list; do
+        if get_ifconfig_route | fgr=
ep "$expect" >/dev/null; then
+            :
+        else
+            fai=
l "check_ifconfig(): expected IPv$proto address '$expect' not found in ifco=
nfig output=2E"
+        fi
     done
 }
 
@@ -255,49 +250,49 @@
 #  arg1: =
"4" or "6" -> fping/fing6
 #  arg2: "want_ok" or "want_fail" (expected ping=
 result)
 #  arg3=2E=2E=2E -> fping arguments (host list)
-run_ping_tests()=

-{
-    proto=3D$1 ; want=3D$2 ; shift ; shift
+run_ping_tests() {
+    pr=
oto=3D$1
+    want=3D$2
+    shift
+    shift
     targetlist=3D"$@"
 
    =
 # "no targets" is fine
-    if [ -z "$targetlist" ] ; then return ; fi
+  =
  if [ -z "$targetlist" ]; then return; fi
 
     case $proto in
-	4) cmd=
=3D"$FPING" ;;
-	6) cmd=3D"$FPING6" ;;
-	*) echo "internal error in run_pin=
g_tests arg 1: '$proto'" >&2
-	   exit 1 ;;
+    4) cmd=3D"$FPING" ;;
+    =
6) cmd=3D"$FPING6" ;;
+    *)
+        echo "internal error in run_ping_tes=
ts arg 1: '$proto'" >&2
+        exit 1
+        ;;
     esac
 
     case $=
want in
-	want_ok)   sizes_list=3D"64 1440 3000" ;;
-	want_fail) sizes_list=
=3D"64" ;;
+    want_ok) sizes_list=3D"64 1440 3000" ;;
+    want_fail) siz=
es_list=3D"64" ;;
     esac
 
-    for bytes in $sizes_list
-    do
-	outpu=
t "run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E"
+    for=
 bytes in $sizes_list; do
+        output "run IPv$proto ping tests ($want)=
, $bytes byte packets=2E=2E=2E"
 
-	echo "$cmd -b $bytes -C 20 -p 250 -q $f=
ping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
-	$cmd -b $bytes -C 20 -p=
 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
+        ec=
ho "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:=
fping=2Eout
+        $cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist=
 >>$LOGDIR/$SUF:fping=2Eout 2>&1
 
-	# while OpenVPN is running, pings must=
 succeed (want=3D'want_ok')
-	# before OpenVPN is up, pings must NOT succee=
d (want=3D'want_fail')
+        # while OpenVPN is running, pings must succ=
eed (want=3D'want_ok')
+        # before OpenVPN is up, pings must NOT succ=
eed (want=3D'want_fail')
 
-	rc=3D$?
-	if [ $rc =3D 0 ] 				# all ping OK
-=
	then
-	    if [ $want =3D "want_fail" ]		# not what we want
-	    then
-		=
fail "IPv$proto ping test succeeded, but needs to *fail*=2E"
-	    fi
-	els=
e					# ping failed
-	    if [ $want =3D "want_ok" ]		# not what we wanted
=
-	    then
-		fail "IPv$proto ping test ($bytes bytes) failed, but should s=
ucceed=2E"
-	    fi
-	fi
+        rc=3D$?
+        if [ $rc =3D 0 ]; then  =
               # all ping OK
+            if [ $want =3D "want_fail" ]; the=
n # not what we want
+                fail "IPv$proto ping test succeeded, =
but needs to *fail*=2E"
+            fi
+        else                      =
         # ping failed
+            if [ $want =3D "want_ok" ]; then # not =
what we wanted
+                fail "IPv$proto ping test ($bytes bytes) fa=
iled, but should succeed=2E"
+            fi
+        fi
     done
 }
 
@@ =
-308,8 +303,7 @@
 SUMMARY_SKIP=3D
 SUMMARY_FAIL=3D
 
-for SUF in $TEST_RUN_=
LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # get config variables
     ev=
al test_prep=3D\"\$PREPARE_$SUF\"
     eval test_check_skip=3D\"\$CHECK_SKI=
P_$SUF\"
@@ -336,11 +330,13 @@
 
     if [ -n "$test_check_skip" ]; then
  =
       output "check whether we need to skip: '$test_check_skip'"
-        =
if eval $test_check_skip; then :
+        if eval $test_check_skip; then
+ =
           :
         else
             output "skip check failed, SKIP tes=
t $SUF=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    echo -e "$outbuf=
" ; continue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+            =
echo -e "$outbuf"
+            continue
         fi
     fi
 
@@ -355,13 +3=
51,14 @@
     output "\nrun pre-openvpn ping tests - targets must not be re=
achable=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
     run_p=
ing_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_count" =3D 0 ] ; then=

+    if [ "$fail_count" =3D 0 ]; then
         output "OK=2E\n"
     else
=
-	fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SU=
F=2E"
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D31
-	echo -e "$ou=
tbuf" ; continue
+        fail "make sure that ping hosts are ONLY reachabl=
e via VPN, SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
=
+        exit_code=3D31
+        echo -e "$outbuf"
+        continue
     f=
i
 
     pidfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid"
@@ -3=
76,18 +373,17 @@
     # to $ovpn_init_check times=2E
     ovpn_init_check=
=3D30
     ovpn_init_success=3D0
-    while [ $ovpn_init_check -gt 0 ];
-  =
  do
-       sleep 1  # Wait for OpenVPN to initialize and have had time to=
 write the pid file
-       grep "Initialization Sequence Completed" $LOGDI=
R/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ]; then
-           o=
vpn_init_check=3D0
-           ovpn_init_success=3D1
-       fi
-       ovp=
n_init_check=3D$(( $ovpn_init_check - 1 ))
+    while [ $ovpn_init_check -g=
t 0 ]; do
+        sleep 1 # Wait for OpenVPN to initialize and have had ti=
me to write the pid file
+        grep "Initialization Sequence Completed" =
$LOGDIR/$SUF:openvpn=2Elog >/dev/null
+        if [ $? -eq 0 ]; then
+     =
       ovpn_init_check=3D0
+            ovpn_init_success=3D1
+        fi
+=
        ovpn_init_check=3D$(($ovpn_init_check - 1))
     done
 
-    opid=
=3D`cat $pidfile`
+    opid=3D$(cat $pidfile)
     if [ -n "$opid" ]; then
=
         output "  OpenVPN running with PID $opid"
     else
@@ -398,16 +39=
4,17 @@
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
         o=
utput "$0:  OpenVPN did not initialize in a reasonable time"
         if [ =
-n "$opid" ]; then
-           $RUN_SUDO $KILL_EXEC $opid
+            $RUN=
_SUDO $KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EXEC $sudopid
-=
	output "tail -5 $SUF:openvpn=2Elog"
-	output "`tail -5 $LOGDIR/$SUF:openvp=
n=2Elog`"
-	fail "skip rest of sub-tests for test run $SUF=2E"
-	trap - 0 1=
 2 3 15
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
-	echo -e "$=
outbuf" ; continue
+        output "tail -5 $SUF:openvpn=2Elog"
+        ou=
tput "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+        fail "skip rest of su=
b-tests for test run $SUF=2E"
+        trap - 0 1 2 3 15
+        SUMMARY_F=
AIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
+        echo -e "$outbu=
f"
+        continue
     fi
 
     # make sure openvpn client is terminate=
d in case shell exits
@@ -418,17 +415,16 @@
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
@@ -449,8 +445,8 @@
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
@@ -458,23 +454,22 @@
 
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
-	    echo -e -n "$outbuf"
-	    echo -e "test run $S=
UF: $fail_count test failures=2E FAIL=2E\n"
+        if [ "$V" -gt 0 ]; the=
n
+            echo -e -n "$outbuf"
+            echo -e "test run $SUF: $f=
ail_count test failures=2E FAIL=2E\n"
         fi
-	SUMMARY_FAIL=3D"$SUMMAR=
Y_FAIL $SUF"
-	exit_code=3D30
+        SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
=
+        exit_code=3D30
     fi
 
     if [ -n "$test_cleanup" ]; then
@@ -=
484,9 +479,9 @@
 
 done
 
-if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=3D" no=
ne"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" none"; fi
-if [ =
-z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D" none"; fi
+if [ -z "$SUMMARY_O=
K" ]; then SUMMARY_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP" ]; then SUMMAR=
Y_SKIP=3D" none"; fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMARY_FAIL=3D" none=
"; fi
 echo "Test sets succeeded:$SUMMARY_OK=2E"
 echo "Test sets skipped:$=
SUMMARY_SKIP=2E"
 echo "Test sets failed:$SUMMARY_FAIL=2E"
diff --git a/tes=
ts/t_cltsrv=2Esh b/tests/t_cltsrv=2Esh
index 6b7df65=2E=2Ef4442a2 100755
--=
- a/tests/t_cltsrv=2Esh
+++ b/tests/t_cltsrv=2Esh
@@ -24,19 +24,19 @@
 trap=
 "rm -f log=2E$$ log=2E$$=2Esignal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f =
log=2E$$ log=2E$$=2Esignal ; exit 1" 0 3
 addopts=3D
-case `uname -s` in
- =
   FreeBSD)
+case $(uname -s) in
+FreeBSD)
     # FreeBSD jails map the out=
going IP to the jail IP - we need to
     # allow the real IP unless we wan=
t the test to run forever=2E
-    if test "`sysctl 2>/dev/null -n security=
=2Ejail=2Ejailed`" =3D 1 \
-    || ps -ostate=3D -p $$ | grep -q J; then
-	=
addopts=3D"--float"
-	if test "x`ifconfig | grep inet`" =3D x ; then
-	    =
echo "###"
-	    echo "### To run the test in a FreeBSD jail, you MUST add =
an IP alias for the jail's IP=2E"
-	    echo "###"
-	    exit 77
-	fi
+    =
if test "$(sysctl 2>/dev/null -n security=2Ejail=2Ejailed)" =3D 1 ||
+     =
   ps -ostate=3D -p $$ | grep -q J; then
+        addopts=3D"--float"
+    =
    if test "x$(ifconfig | grep inet)" =3D x; then
+            echo "###"
=
+            echo "### To run the test in a FreeBSD jail, you MUST add an I=
P alias for the jail's IP=2E"
+            echo "###"
+            exit 77
=
+        fi
     fi
     ;;
 esac
@@ -45,29 +45,37 @@
 # skip) test if it i=
sn't=2E
 downscript=3D"=2E=2E/tests/t_cltsrv-down=2Esh"
 root=3D"${top_srcd=
ir}/sample"
-test -x "${root}/${downscript}" || chmod +x "${root}/${downscr=
ipt}" || { echo >&2 "${root}/${downscript} is not executable, failing=2E" ;=
 exit 1 ; }
+test -x "${root}/${downscript}" || chmod +x "${root}/${downscr=
ipt}" || {
+    echo >&2 "${root}/${downscript} is not executable, failing=
=2E"
+    exit 1
+}
 echo "The following test will take about two minutes=
=2E" >&2
 echo "If the addresses are in use, this test will retry up to two=
 times=2E" >&2
 
 # go
 success=3D0
-for i in 1 2 3 ; do
-  set +e
-  (
-  =
"${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv role sr=
v --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config=
-files/loopback-server" &
-  "${openvpn}" --script-security 2 --cd "${top_s=
rcdir}/sample" ${addopts} --setenv role clt --down "${downscript}" --tls-ex=
it --ping-exit 180 --config "sample-config-files/loopback-client"
-  ) 3>lo=
g=2E$$=2Esignal >log=2E$$ 2>&1
-  e1=3D$?
-  wait $!
-  e2=3D$?
-  grep 'TC=
P/UDP: Socket bind failed on local address=2E*in use' log=2E$$ >/dev/null &=
& {
-    echo 'address in use, retrying in 150 s'
-    sleep 150
-    conti=
nue
-  }
-  grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && { cat log=
=2E$$=2Esignal ; echo ; cat log=2E$$ ; exit 1 ; }
-  success=3D1
-  break
+=
for i in 1 2 3; do
+    set +e
+    (
+        "${openvpn}" --script-securi=
ty 2 --cd "${root}" ${addopts} --setenv role srv --down "${downscript}" --t=
ls-exit --ping-exit 180 --config "sample-config-files/loopback-server" &
+ =
       "${openvpn}" --script-security 2 --cd "${top_srcdir}/sample" ${addop=
ts} --setenv role clt --down "${downscript}" --tls-exit --ping-exit 180 --c=
onfig "sample-config-files/loopback-client"
+    ) 3>log=2E$$=2Esignal >log=
=2E$$ 2>&1
+    e1=3D$?
+    wait $!
+    e2=3D$?
+    grep 'TCP/UDP: Socke=
t bind failed on local address=2E*in use' log=2E$$ >/dev/null && {
+       =
 echo 'address in use, retrying in 150 s'
+        sleep 150
+        conti=
nue
+    }
+    grep -v ':inactive$' log=2E$$=2Esignal >/dev/null && {
+   =
     cat log=2E$$=2Esignal
+        echo
+        cat log=2E$$
+        exi=
t 1
+    }
+    success=3D1
+    break
 done
 
 set -e
@@ -75,14 +83,14 @@
=
 # exit code - defaults to 0, PASS
 ec=3D0
 
-if [ $success !=3D 1 ] ; then=

-  # couldn't run test -- addresses in use, skip test
-  cat log=2E$$
-  e=
c=3D77
-elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then
-  # failure -- fail t=
est
-  cat log=2E$$
-  ec=3D1
+if [ $success !=3D 1 ]; then
+    # couldn't=
 run test -- addresses in use, skip test
+    cat log=2E$$
+    ec=3D77
+el=
if [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then
+    # failure -- fail test
+    =
cat log=2E$$
+    ec=3D1
 fi
 
 rm log=2E$$ log=2E$$=2Esignal
diff --git a/=
tests/t_lpback=2Esh b/tests/t_lpback=2Esh
index 6802506=2E=2E8379f8f 100755=

--- a/tests/t_lpback=2Esh
+++ b/tests/t_lpback=2Esh
@@ -34,54 +34,57 @@
 
=
 # output progress information
 #  depending on verbosity level, collect & =
print only on failure
-test_start()
-{
+test_start() {
     case $V in
-   =
     0) outbuf=3D"" ;;                  # no per-test output at all
-      =
  1) outbuf=3D"$@" ;;                # compact, details only on failure
-  =
      *) printf "$@" ;;                # print all
+    0) outbuf=3D"" ;;  =
 # no per-test output at all
+    1) outbuf=3D"$@" ;; # compact, details on=
ly on failure
+    *) printf "$@" ;; # print all
     esac
 }
-test_end()
-=
{
-    RC=3D$1 ; LOG=3D$2
-    if [ $RC !=3D 0 ]
-    then
+test_end() {
+ =
   RC=3D$1
+    LOG=3D$2
+    if [ $RC !=3D 0 ]; then
         case $V in
-=
            0) ;;                                # no per-test output
-    =
        1) echo "$outbuf" "FAIL (RC=3D$RC)"; cat $LOG ;;
-            *) ec=
ho "FAIL (RC=3D$RC)"; cat $LOG ;;
+        0) ;; # no per-test output
+    =
    1)
+            echo "$outbuf" "FAIL (RC=3D$RC)"
+            cat $LOG
=
+            ;;
+        *)
+            echo "FAIL (RC=3D$RC)"
+          =
  cat $LOG
+            ;;
         esac
         e=3D1
-        tests_fail=
ed=3D$(( $tests_failed + 1 ))
+        tests_failed=3D$(($tests_failed + 1)=
)
     else
         case $V in
-            0|1) ;;                       =
       # no per-test output for 'OK'
-            *) echo "OK"             =
            # print all
+        0 | 1) ;;       # no per-test output for '=
OK'
+        *) echo "OK" ;; # print all
         esac
-        tests_passe=
d=3D$(( $tests_passed + 1 ))
+        tests_passed=3D$(($tests_passed + 1))=

     fi
 }
 
 # if running with V=3D1, give an indication what test runs n=
ow
-if [ "$V" =3D 1  ] ; then
+if [ "$V" =3D 1 ]; then
     echo "$0: runni=
ng with V=3D$V, only printing test fails"
 fi
 
-
 # Get list of supported =
ciphers from openvpn --show-ciphers output
-CIPHERS=3D$(${openvpn} --show-c=
iphers | \
-            sed -e '/The following/,/^$/d' -e s'/ =2E*//' -e '/=
^[[:space:]]*$/d')
+CIPHERS=3D$(${openvpn} --show-ciphers |
+    sed -e '/T=
he following/,/^$/d' -e s'/ =2E*//' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-0=
6-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (s=
ee http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867), so exclude
 =
# that cipher from this test=2E
 # GD, 2014-07-06 so is DES-CFB1
 # GD, 201=
4-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
-CIPHE=
RS=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
+CIPHE=
RS=3D$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)')
 
 e=3D=
0
-if [ -z "$CIPHERS" ] ; then
+if [ -z "$CIPHERS" ]; then
     echo "'open=
vpn --show-ciphers' FAILED (empty list)"
     e=3D1
 fi
@@ -91,10 +94,9 @@
=
 
 set +e
 
-for cipher in ${CIPHERS}
-do
+for cipher in ${CIPHERS}; do
   =
  test_start "Testing cipher ${cipher}=2E=2E=2E "
-    ( "${openvpn}" --tes=
t-crypto --cipher ${cipher} ) >log=2E$$ 2>&1
+    ("${openvpn}" --test-cryp=
to --cipher ${cipher}) >log=2E$$ 2>&1
     test_end $? log=2E$$
 done
 
@@ =
-121,7 +123,7 @@
     >log=2E$$ 2>&1
 test_end $? log=2E$$
 
-if [ "$V" -ge=
 1  ] ; then
+if [ "$V" -ge 1 ]; then
     echo "$0: tests passed: $tests_p=
assed  failed: $tests_failed"
 fi
 
diff --git a/tests/t_net=2Esh b/tests/t=
_net=2Esh
index 8134832=2E=2Efbedb54 100755
--- a/tests/t_net=2Esh
+++ b/te=
sts/t_net=2Esh
@@ -9,7 +9,6 @@
 top_builddir=3D"${top_builddir:-=2E=2E}"
 o=
penvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
 
-
 # bail out =
right away on non-linux=2E NetLink (the object of this test) is only
 # use=
d on Linux, therefore testing other platform is not needed=2E
 #
@@ -31,8 +=
30,7 @@
 
 LAST_STATE=3D$((${#GET_STATE[@]} - 1))
 
-reload_dummy()
-{
+rel=
oad_dummy() {
     $RUN_SUDO ip link del $IFACE
     $RUN_SUDO ip link add =
$IFACE address 00:11:22:33:44:55 type dummy
     $RUN_SUDO ip link set dev =
$IFACE state up
@@ -43,8 +41,7 @@
     fi
 }
 
-run_test()
-{
+run_test() {=

     # run all test cases from 0 to $1 in sequence
     CMD=3D
     for k =
in $(seq 0 $1); do
@@ -69,7 +66,6 @@
     done
 }
 
-
 ## execution starts =
here
 
 # t_client=2Erc required only for RUN_SUDO definition
@@ -89,21 +85=
,18 @@
     exit 77
 fi
 
-
 # Ensure PREFER_KSU is in a known state
 PREFE=
R_KSU=3D"${PREFER_KSU:-0}"
 
 # make sure we have permissions to run the ne=
tworking unit-test
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/null
-then :=

+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    =
if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; =
then
         # Check if we have a valid kerberos ticket
         klist -l =
1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then
+        if=
 [ $? -ne 0 ]; then
             # No kerberos ticket found, skip ksu and f=
allback to RUN_SUDO
             PREFER_KSU=3D0
             echo "$0: No K=
erberos ticket available=2E  Will not use ksu=2E"
@@ -112,16 +105,14 @@
   =
      fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_=
SUDO" ]; then
         echo "$0: no RUN_SUDO=3D=2E=2E=2E in t_client=2Erc o=
r environment, defaulting to 'sudo'=2E" >&2
         echo "      if that do=
es not work, set RUN_SUDO=3D correctly for your system=2E" >&2
         RUN=
_SUDO=3D"sudo"
     fi
 
     # check that we can run the unit-test binary =
with sudo
-    if $RUN_SUDO $UNIT_TEST test
-    then
+    if $RUN_SUDO $UN=
IT_TEST test; then
         echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good=
=2E"
     else
         echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on=
=2E SKIP=2E" >&2
diff --git a/tests/t_server_null=2Esh b/tests/t_server_nul=
l=2Esh
index 74ffd52=2E=2Ec633614 100755
--- a/tests/t_server_null=2Esh
+++=
 b/tests/t_server_null=2Esh
@@ -2,7 +2,7 @@
 #
 TSERVER_NULL_SKIP_RC=3D"${T=
SERVER_NULL_SKIP_RC:-77}"
 
-if ! [ -r "=2E/t_server_null=2Erc" ] ; then
+i=
f ! [ -r "=2E/t_server_null=2Erc" ]; then
     echo "${0}: cannot find '=2E=
/t_server_null=2Erc=2E SKIPPING TEST=2E'" >&2
     exit "${TSERVER_NULL_SKI=
P_RC}"
 fi
@@ -22,11 +22,10 @@
 # make sure we have permissions to run ifco=
nfig/route from OpenVPN
 # can't use "id -u" here - doesn't work on Solaris=

 ID=3D$(id)
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+if expr "$ID" :=
 "uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];=

-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Check if we h=
ave a valid kerberos ticket
         if klist -l 1>/dev/null 2>/dev/null; t=
hen
             RUN_SUDO=3D"ksu -q -e"
@@ -37,26 +36,24 @@
         fi
   =
  fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_SUDO" ]; the=
n
         echo "${0}: this test must run be as root, or RUN_SUDO=3D=2E=2E=
=2E " >&2
         echo "      must be set correctly in 't_server_null=2Erc=
'=2E SKIP=2E" >&2
         exit "${TSERVER_NULL_SKIP_RC}"
     else
-	# Run=
 a no-op command with privilege escalation (e=2Eg=2E sudo) so that
-	# we (=
hopefully) do not have to ask the users password during the test=2E
-	if $R=
UN_SUDO "${KILL_EXEC}" -0 $$
-	then
-	    echo "${0}: $RUN_SUDO $KILL_EXEC =
-0 succeeded, good=2E"
-	else
-	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 fai=
led, cannot go on=2E SKIP=2E" >&2
-	    exit "${TSERVER_NULL_SKIP_RC}"
-	fi=

+        # Run a no-op command with privilege escalation (e=2Eg=2E sudo) s=
o that
+        # we (hopefully) do not have to ask the users password duri=
ng the test=2E
+        if $RUN_SUDO "${KILL_EXEC}" -0 $$; then
+          =
  echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
+        else
+  =
          echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=
=2E" >&2
+            exit "${TSERVER_NULL_SKIP_RC}"
+        fi
     fi
 f=
i
 
 srcdir=3D"${srcdir:-=2E}"
-export t_server_null_logdir=3Dt_server_null=
-`hostname`-`date +%Y%m%d-%H%M%S`
+export t_server_null_logdir=3Dt_server_n=
ull-$(hostname)-$(date +%Y%m%d-%H%M%S)
 
 # Create directory for server and=
 client logs
 mkdir $t_server_null_logdir
diff --git a/tests/t_server_null_=
client=2Esh b/tests/t_server_null_client=2Esh
index 1745de5=2E=2E2741d5d 10=
0755
--- a/tests/t_server_null_client=2Esh
+++ b/tests/t_server_null_client=
=2Esh
@@ -3,7 +3,7 @@
 should_run_test() {
     test_name=3D"$1"
 
-    if =
echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | grep -q _=
lwip; then
         if [ "$has_lwipovpn" =3D "no" ]; then
             retu=
rn 1
         fi
@@ -48,7 +48,7 @@
 
 ping_lwip_clients() {
     if [ "$has=
_lwipovpn" =3D "yes" ]; then
-        lwip_client_count=3D$(echo "$lwip_tes=
t_names"|wc -w|tr -d " ")
+        lwip_client_count=3D$(echo "$lwip_test_n=
ames" | wc -w | tr -d " ")
     else
         lwip_client_count=3D0
     fi=

@@ -60,10 +60,10 @@
     count=3D0
     maxcount=3D10
     while [ $count =
-le $maxcount ]; do
-        lwip_client_ips=3D$(cat =2E/*=2Elwip 2>/dev/nu=
ll|wc -l)
+        lwip_client_ips=3D$(cat =2E/*=2Elwip 2>/dev/null | wc -l=
)
         if [ $lwip_client_ips -lt $lwip_client_count ]; then
           =
  echo "Waiting for LWIP clients to start up ($count/$maxcount)"
-         =
   count=3D$(( count + 1))
+            count=3D$((count + 1))
            =
 sleep 1
         else
             echo "$lwip_client_ips/$lwip_client_cou=
nt LWIP clients up"
@@ -73,8 +73,8 @@
 
     wait_pids=3D""
     for line i=
n $(cat =2E/*=2Elwip 2>/dev/null); do
-        target_ip=3D$(echo $line|cut=
 -d "," -f 1)
-        client_pid=3D$(echo $line|cut -d "," -f 2)
+        =
target_ip=3D$(echo $line | cut -d "," -f 1)
+        client_pid=3D$(echo $l=
ine | cut -d "," -f 2)
         ping_and_kill $target_ip $client_pid &
    =
     wait_pids=3D"$wait_pids $!"
     done
@@ -111,7 +111,7 @@
     should_=
pass=3D$2
     log=3D"${test_name}=2Elog"
 
-    grep "Initialization Seque=
nce Completed" "${t_server_null_logdir}/${log}" > /dev/null
+    grep "Init=
ialization Sequence Completed" "${t_server_null_logdir}/${log}" >/dev/null
=
     exit_code=3D$?
 
     if [ $exit_code -eq 0 ] && [ "${should_pass}" =
=3D "yes" ]; then
@@ -144,7 +144,7 @@
 server_max_wait=3D15
 while [ $count=
 -lt $server_max_wait ]; do
     servers_up=3D0
-    server_count=3D$(echo =
"$TEST_SERVER_LIST"|wc -w|tr -d " ")
+    server_count=3D$(echo "$TEST_SERV=
ER_LIST" | wc -w | tr -d " ")
 
     # We need to trim single-quotes becaus=
e some shells return quoted values
     # and some don't=2E Using "set -o p=
osix" which would resolve this problem is
@@ -152,13 +152,13 @@
     #
    =
 # While inactive server configurations may get checked they won't increase=

     # the active server count as the processes won't be running=2E
-    f=
or i in $(set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"); do
-    =
    server_pid=3D$(cat "$i=2Epid" 2> /dev/null)
-        if [ -z "$server_p=
id" ] ; then
+    for i in $(set | grep 'SERVER_NAME_' | cut -d "=3D" -f 2 =
| tr -d "[\']"); do
+        server_pid=3D$(cat "$i=2Epid" 2>/dev/null)
+  =
      if [ -z "$server_pid" ]; then
             continue
         fi
-    =
    if $RUN_SUDO kill -0 $server_pid > /dev/null 2>&1; then
-            se=
rvers_up=3D$(( $servers_up + 1 ))
+        if $RUN_SUDO kill -0 $server_pid=
 >/dev/null 2>&1; then
+            servers_up=3D$(($servers_up + 1))
     =
    fi
     done
 
@@ -168,7 +168,7 @@
         retval=3D0
         break
 =
    else
-        count=3D$(( count + 1))
+        count=3D$((count + 1))
 =
        sleep 1
     fi
 
@@ -199,15 +199,14 @@
 # safe to check the test r=
esults=2E
 test_names=3D""
 lwip_test_names=3D""
-for SUF in $TEST_RUN_LIST=

-do
+for SUF in $TEST_RUN_LIST; do
     eval test_name=3D\"\$TEST_NAME_$SU=
F\"
     eval client_exec=3D\"\$CLIENT_EXEC_$SUF\"
     eval client_conf=3D=
\"\$CLIENT_CONF_$SUF\"
 
     test_names=3D"${test_names} ${test_name}"
 
-=
    if echo "$test_name"|grep -q _lwip; then
+    if echo "$test_name" | gr=
ep -q _lwip; then
         lwip_test_names=3D"${lwip_test_names} ${test_nam=
e}"
     fi
 
@@ -219,13 +218,11 @@
 ping_lwip_clients
 retval=3D$?
 
-
 # =
Wait until all OpenVPN clients have exited
 (wait_for_results)
 
 # Check t=
est results
-for SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
 =
    eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval should_pass=3D\"\$SHOUL=
D_PASS_$SUF\"
 
diff --git a/tests/t_server_null_server=2Esh b/tests/t_serv=
er_null_server=2Esh
index 65b7d56=2E=2E327939a 100755
--- a/tests/t_server_=
null_server=2Esh
+++ b/tests/t_server_null_server=2Esh
@@ -13,10 +13,10 @@
=
 
     # Try to launch the server
     $RUN_SUDO "${server_exec}" \
-      =
         $server_conf \
-               --status "${status}" 1 \
-         =
      --writepid "${pid}" \
-               --explicit-exit-notify 3 > "$lo=
g" 2>&1 &
+        $server_conf \
+        --status "${status}" 1 \
+      =
  --writepid "${pid}" \
+        --explicit-exit-notify 3 >"$log" 2>&1 &
 
=
     sleep 1
 
@@ -40,8 +40,7 @@
 retval=3D0
 
 # Launch test servers
-for =
SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval se=
rver_name=3D\"\$SERVER_NAME_$SUF\"
     eval server_exec=3D\"\$SERVER_EXEC_=
$SUF\"
     eval server_conf=3D\"\$SERVER_CONF_$SUF\"
@@ -53,8 +52,7 @@
 # =
the test run=2E
 #
 export server_pid_files=3D""
-for SUF in $TEST_SERVER_L=
IST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=3D\"\$SERVE=
R_NAME_$SUF\"
     server_pid_files=3D"${server_pid_files} =2E/${server_nam=
e}=2Epid"
 done
@@ -65,12 +63,11 @@
 count=3D0
 maxcount=3D4
 while [ $coun=
t -le $maxcount ]; do
-    if ls t_server_null_client=2Esh*=2Epid > /dev/nu=
ll 2>&1
-    then
+    if ls t_server_null_client=2Esh*=2Epid >/dev/null 2>=
&1; then
         count=3D0
         sleep 1
     else
-	count=3D$(( count =
+ 1))
+        count=3D$((count + 1))
         sleep 1
     fi
 done
@@ -81=
,11 +78,10 @@
 # server process does not exit in 15 seconds assume it never=
 will, move on and
 # hope for the best=2E
 echo "Waiting for servers to ex=
it"
-for PID_FILE in $server_pid_files
-do
+for PID_FILE in $server_pid_fil=
es; do
     SERVER_PID=3D$(cat "${PID_FILE}")
 
-    if [ -z "$SERVER_PID" =
] ; then
+    if [ -z "$SERVER_PID" ]; then
         echo "WARNING: could n=
ot kill server ${PID_FILE}!"
         continue
     fi
@@ -95,17 +91,16 @@
=
 
     count=3D0
     maxcount=3D75
-    while [ $count -le $maxcount ]
-  =
  do
-        $RUN_SUDO kill -0 "${SERVER_PID}" 2> /dev/null || break
-    =
    count=3D$(( count + 1))
+    while [ $count -le $maxcount ]; do
+      =
  $RUN_SUDO kill -0 "${SERVER_PID}" 2>/dev/null || break
+        count=3D$=
((count + 1))
         sleep 0=2E2
     done
 
     # If server is still up=
 send a SIGKILL
     if [ $count -ge $maxcount ]; then
         $RUN_SUDO $=
KILL_EXEC -9 "${SERVER_PID}"
-        SERVER_NAME=3D$(basename $PID_FILE|cu=
t -d =2E -f 1)
+        SERVER_NAME=3D$(basename $PID_FILE | cut -d =2E -f =
1)
         echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with =
pid ${SERVER_PID}!"
         echo "Tail of server log:"
         tail -n 20=
 "${t_server_null_logdir}/${SERVER_NAME}=2Elog"
diff --git a/tests/t_server=
_null_stress=2Esh b/tests/t_server_null_stress=2Esh
index 0bb9452=2E=2E2fc9=
fde 100755
--- a/tests/t_server_null_stress=2Esh
+++ b/tests/t_server_null_=
stress=2Esh
@@ -7,8 +7,7 @@
 =2E =2E/t_server_null_default=2Erc
 
 export p=
id_files=3D""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LI=
ST; do
     eval server_name=3D\"\$SERVER_NAME_$SUF\"
     pid_files=3D"${p=
id_files} =2E/${server_name}=2Epid"
 done
@@ -18,16 +17,16 @@
 
 count=3D0
=
 while [ $count -lt $ITERATIONS ]; do
-    count=3D$(( count + 1 ))
-    ma=
ke check TESTS=3Dt_server_null=2Esh SUBDIRS=3D > /dev/null 2>&1
+    count=
=3D$((count + 1))
+    make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D >/d=
ev/null 2>&1
     retval=3D$?
 
-    echo "Iteration ${count}: return value=
 ${retval}" >> "${LOG_BASEDIR}/make-check=2Elog"
+    echo "Iteration ${cou=
nt}: return value ${retval}" >>"${LOG_BASEDIR}/make-check=2Elog"
     if [ =
$retval -ne 0 ]; then
-	DIR=3D"${LOG_BASEDIR}/make-check-${count}"
+       =
 DIR=3D"${LOG_BASEDIR}/make-check-${count}"
         mkdir -p "${DIR}"
    =
     cp t_server_null*=2Elog "${DIR}/"
         cp test-suite=2Elog "${DIR}=
/"
-        ps aux|grep openvpn|grep -vE '(suppress|grep)' > "${DIR}/psaux"=

+        ps aux | grep openvpn | grep -vE '(suppress|grep)' >"${DIR}/psaux=
"
     fi
 done
diff --git a/tests/update_t_client_ips=2Esh b/tests/update_=
t_client_ips=2Esh
index 96e3826=2E=2E777a286 100755
--- a/tests/update_t_cl=
ient_ips=2Esh
+++ b/tests/update_t_client_ips=2Esh
@@ -5,12 +5,12 @@
 
 RC=
=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
 
-grep EXPECT_IFCONFIG4_$TESTNUM=3D $=
RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/dev/null 2>&1
=
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_loc=
al" >> $RC
+    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >>$RC
 f=
i
 
-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+grep EXPECT_IF=
CONFIG6_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "E=
XPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $RC
+    echo "EXPECT_I=
FCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >>$RC
 fi

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
=
Gerrit-Change-Number: 1793
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--BABN8j8lvKA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Reformat all shell-scripts with shfmt<br><br>According to =2E/dev-tool=
s/reformat-shell=2Esh=2E<br><br>Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ff=
dbf332a0f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>---<br>M dev-tools/gen-release-tarballs=2Esh<br>M dev-tools/git-pre-c=
ommit-format=2Esh<br>M dev-tools/run-cppcheck=2Esh<br>M dev-tools/update-co=
pyright=2Esh<br>M tests/lwip_client_up=2Esh<br>M tests/null_client_up=2Esh<=
br>M tests/t_client=2Esh=2Ein<br>M tests/t_cltsrv=2Esh<br>M tests/t_lpback=
=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_null=2Esh<br>M tests/t_serv=
er_null_client=2Esh<br>M tests/t_server_null_server=2Esh<br>M tests/t_serve=
r_null_stress=2Esh<br>M tests/update_t_client_ips=2Esh<br>15 files changed,=
 447 insertions(+), 468 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93/1793/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release-tarba=
lls=2Esh</span><br><span>index 6071b57=2E=2E08ae385 100755</span><br><span>=
--- a/dev-tools/gen-release-tarballs=2Esh</span><br><span>+++ b/dev-tools/g=
en-release-tarballs=2Esh</span><br><span>@@ -21,7 +21,7 @@</span><br><span>=
 if [ $# -ne 4 ]; then</span><br><span>     echo &quot;Usage: $0 &lt;remote=
-name&gt; &lt;tag-name&gt; &lt;sign-key&gt; &lt;dest-dir&gt;&quot;</span><b=
r><span>     echo &quot;&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    echo &quot;   remote-name  -- valid remotes: `git remote | tr =
\\\n &#39; &#39;`&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    echo &quot;   remote-name  -- valid remotes: $(git remote | tr \\n =
&#39; &#39;)&quot;</span><br><span>     echo &quot;   tag-name     -- An ex=
isting release tag&quot;</span><br><span>     echo &quot;   sign-key     --=
 PGP key used to sign all files&quot;</span><br><span>     echo &quot;   de=
st-dir     -- Where to put the complete set of release tarballs&quot;</span=
><br><span>@@ -48,7 +48,7 @@</span><br><span> fi</span><br><span> </span><b=
r><span> # Extract the git URL</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-giturl=3D&quot;`git remote get-url $arg_remote_name 2&gt;/dev/null=
`&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+giturl=3D&qu=
ot;$(git remote get-url $arg_remote_name 2&gt;/dev/null)&quot;</span><br><s=
pan> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;** ERROR ** Inva=
lid git remote name: $arg_remote_name&quot;</span><br><span>     exit 2</sp=
an><br><span>@@ -58,19 +58,17 @@</span><br><span> echo &quot;test&quot; | g=
pg -a --clearsign -u &quot;$arg_sign_key&quot; 2&gt;/dev/null 1&gt;/dev/nul=
l</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;**=
 ERROR ** Failed when testing the PGP signing=2E  Wrong signing key?&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    exit 2</span><br><span> fi=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> #</span><br><span> # Helper functions</span><br><span> #</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_fil=
ename()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+get_filename() {</span><br><span=
>     local wildcard=3D&quot;$1&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    res=3D&quot;`find =2E -maxdepth 1 -ty=
pe f -name \&quot;$wildcard\&quot; | head -n1 | cut -d/ -f2-`&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    res=3D&quot;$(find =2E =
-maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n1 | cut -d/ -f2-=
)&quot;</span><br><span>     if [ $? -ne 0 ]; then</span><br><span>        =
 echo &quot;-- &#39;find&#39; failed=2E&quot;</span><br><span>         exit=
 5</span><br><span>@@ -82,12 +80,11 @@</span><br><span>     echo &quot;$res=
&quot;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-copy_files()</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+copy_=
files() {</span><br><span>     local fileext=3D&quot;$1&quot;</span><br><sp=
an>     local dest=3D&quot;$2&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    file=3D&quot;`get_filename openvpn-*=2E=
*=2E*=2E$fileext`&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    file=3D&quot;$(get_filename openvpn-*=2E*=2E*=2E$fileext)&quot;</sp=
an><br><span>     if [ -z &quot;$file&quot; ]; then</span><br><span>       =
  echo &quot;** ERROR Failed to find source file&quot;</span><br><span>    =
     exit 5</span><br><span>@@ -96,46 +93,45 @@</span><br><span>     cp &qu=
ot;$file&quot; &quot;$dest&quot;</span><br><span>     if [ $? -ne 0 ]; then=
</span><br><span>         echo &quot;** ERROR ** Failed to copy $file to $d=
estdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
xit 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit =
3</span><br><span>     fi</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-sign_file()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+sign_file() {</span><br><span>     local signkey=3D&quot;$1&q=
uot;</span><br><span>     local srchfile=3D&quot;$2&quot;</span><br><span> =
    local signtype=3D&quot;$3&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    local file=3D&quot;`get_filename $srchfile`&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    local file=3D&quot;$(ge=
t_filename $srchfile)&quot;</span><br><span> </span><br><span>     echo &qu=
ot;-- Signing $file =2E=2E=2E&quot;</span><br><span>     case &quot;$signty=
pe&quot; in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            # Ha=
ve the signature in the same file as the data</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            gpg -a --clearsign -u &quot;$signkey&qu=
ot; &quot;$file&quot; 2&gt;/dev/null</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            res=3D$?</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if [ $res -eq 0 ]; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                rm -f &quot;$file&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            fi</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    inline)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        # Have the signature in the same file as =
the data</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gpg=
 -a --clearsign -u &quot;$signkey&quot; &quot;$file&quot; 2&gt;/dev/null</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        res=3D$?</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $res -eq 0 ]=
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
m -f &quot;$file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ;;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        detached)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         # Have the signature in a separate file</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            gpg -a --detach-sign -u &quot;$signk=
ey&quot; &quot;$file&quot; 2&gt;/dev/null</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            res=3D$?</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    detached)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        # Have the signature in a separate file</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gpg -a --detach-sign -u &quot;$=
signkey&quot; &quot;$file&quot; 2&gt;/dev/null</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        res=3D$?</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ;;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            echo &quot;** ERROR **  Unknown signing ty=
pe \&quot;$signtype\&quot;=2E&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            exit 4;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        echo &quot;** ERROR **  Unknown signing type \&quot;$signtype\&quo=
t;=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
exit 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ;;</s=
pan><br><span>     esac</span><br><span> </span><br><span>     if [ $res -n=
e 0 ]; then</span><br><span>         echo &quot;** ERROR **  Failed to sign=
 the file $PWD/$file&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        exit 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        exit 4</span><br><span>     fi</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #<=
/span><br><span> # Preparations</span><br><span> #</span><br><span>@@ -143,=
12 +139,12 @@</span><br><span> # Create the destination directory, using a =
sub-dir with the tag-name</span><br><span> destdir=3D&quot;&quot;</span><br=
><span> case &quot;$arg_dest_dir&quot; in</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /*) # Absolute path</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        destdir=3D&quot;$arg_dest_dir/$arg_tag_name&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    *)  # Make absolute path=
 from relative path</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      destdir=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*) # Absolute path</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    destdir=3D&quot;$arg_dest_dir/$arg_tag_na=
me&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+*) # Make absolute path =
from relative path</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   destdir=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ;;</span><br><span> esac</span><b=
r><span> echo &quot;-- Destination directory: $destdir&quot;</span><br><spa=
n> if [ -e &quot;$destdir&quot; ]; then</span><br><span>@@ -168,61 +164,61 =
@@</span><br><span> #</span><br><span> </span><br><span> # Clone the remote=
 repository</span><br><span style=3D"color: hsl(0, 100%, 40%);">-workdir=3D=
&quot;`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+workdir=3D&quot;$(mktemp -d -p=
 /var/tmp openvpn-build-release-XXXXXX)&quot;</span><br><span> cd $workdir<=
/span><br><span> echo &quot;-- Working directory: $workdir&quot;</span><br>=
<span> echo &quot;-- git clone $giturl&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-git clone $giturl openvpn-gen-tarball 2&gt; &quot;$w=
orkdir/git-clone=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+git clone $giturl openvpn-gen-tarball 2&gt;&quot;$work=
dir/git-clone=2Elog&quot; 1&gt;&amp;2</span><br><span> if [ $? -ne 0 ]; the=
n</span><br><span>     echo &quot;** ERROR **  git clone failed=2E  See $wo=
rkdir/git-clone=2Elog for details&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    exit 3;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    exit 3</span><br><span> fi</span><br><span> cd openvpn-gen-ta=
rball</span><br><span> </span><br><span> # Check out the proper release tag=
</span><br><span> echo &quot;-- Checking out tag $arg_tag_name =2E=2E=2E &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-git checkout -b m=
krelease &quot;$arg_tag_name&quot; 2&gt; &quot;$workdir/git-checkout-tag=2E=
log&quot; 1&gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+git checkout -b mkrelease &quot;$arg_tag_name&quot; 2&gt;&quot;$workdir/g=
it-checkout-tag=2Elog&quot; 1&gt;&amp;2</span><br><span> if [ $? -ne 0 ]; t=
hen</span><br><span>     echo &quot;** ERROR **  git checkout failed=2E  Se=
e $workdir/git-checkout-tag=2Elog for details&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    exit 3</span><br><span> fi</span><br><span> </s=
pan><br><span> # Prepare the source tree</span><br><span> echo &quot;-- Run=
ning autoreconf + a simple configure =2E=2E=2E &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-(autoreconf -vi &amp;&amp; =2E/configure) 2=
&gt; &quot;$workdir/autotools-prep=2Elog&quot; 1&gt;&amp;2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+(autoreconf -vi &amp;&amp; =2E/confi=
gure) 2&gt;&quot;$workdir/autotools-prep=2Elog&quot; 1&gt;&amp;2</span><br>=
<span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;** ERROR **  F=
ailed running autotools=2E  See $workdir/autotools-prep=2Elog for details&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 3</span><br><spa=
n> fi</span><br><span> </span><br><span> # Generate the tar/zip files</span=
><br><span> echo &quot;-- Running make distcheck (generates =2Etar=2Egz) =
=2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(make=
 distcheck) 2&gt; &quot;$workdir/make-distcheck=2Elog&quot; 1&gt;&amp;2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+(make distcheck) 2&gt;&=
quot;$workdir/make-distcheck=2Elog&quot; 1&gt;&amp;2</span><br><span> if [ =
$? -ne 0 ]; then</span><br><span>     echo &quot;** ERROR **  make distchec=
k failed=2E  See $workdir/make-distcheck=2Elog for details&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    exit 3</span><br><span> fi</span><br=
><span> copy_files tar=2Egz &quot;$destdir&quot;</span><br><span> </span><b=
r><span> echo &quot;-- Running make dist-xz (generates =2Etar=2Exz) =2E=2E=
=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(make dist-=
xz) 2&gt; &quot;$workdir/make-dist-xz=2Elog&quot; 1&gt;&amp;2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+(make dist-xz) 2&gt;&quot;$workdi=
r/make-dist-xz=2Elog&quot; 1&gt;&amp;2</span><br><span> if [ $? -ne 0 ]; th=
en</span><br><span>     echo &quot;** ERROR **  make dist-xz failed=2E  See=
 $workdir/make-dist-xz=2Elog for details&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    exit 3;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    exit 3</span><br><span> fi</span><br><span> copy_files=
 tar=2Exz &quot;$destdir&quot;</span><br><span> </span><br><span> echo &quo=
t;-- Running make dist-zip (generates =2Ezip) =2E=2E=2E &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-(make dist-zip) 2&gt; &quot;$workd=
ir/make-dist-zip=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+(make dist-zip) 2&gt;&quot;$workdir/make-dist-zip=2Elo=
g&quot; 1&gt;&amp;2</span><br><span> if [ $? -ne 0 ]; then</span><br><span>=
     echo &quot;** ERROR **  make dist-zip failed=2E  See $workdir/make-dis=
t-zip=2Elog for details&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    exit 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    exit 3</span><br><span> fi</span><br><span> copy_files zip &quot;$destd=
ir&quot;</span><br><span> </span><br><span> # Generate SHA256 checksums</sp=
an><br><span> cd &quot;$destdir&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip &gt; &q=
uot;openvpn-$arg_tag_name=2Esha256sum&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip=
 &gt;&quot;openvpn-$arg_tag_name=2Esha256sum&quot;</span><br><span> </span>=
<br><span> # Sign all the files</span><br><span> echo &quot;-- Signing file=
s =2E=2E=2E &quot;</span><br><span>diff --git a/dev-tools/git-pre-commit-fo=
rmat=2Esh b/dev-tools/git-pre-commit-format=2Esh</span><br><span>index 9b2e=
caf=2E=2Ef475130 100755</span><br><span>--- a/dev-tools/git-pre-commit-form=
at=2Esh</span><br><span>+++ b/dev-tools/git-pre-commit-format=2Esh</span><b=
r><span>@@ -26,7 +26,6 @@</span><br><span> # OR TORT (INCLUDING NEGLIGENCE =
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE</span><br><span> # OF THIS =
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> # git pre-commit hook that runs a stylecheck=2E</span><br><span> # Featur=
es:</span><br><span> #  - abort commit when commit does not comply with the=
 style guidelines</span><br><span>@@ -43,12 +42,11 @@</span><br><span> # ex=
it on error</span><br><span> set -e</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # If called so, install t=
his script as pre-commit hook</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-if [ &quot;$1&quot; =3D &quot;install&quot; ] ; then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$1&quot; =3D &quot;inst=
all&quot; ]; then</span><br><span>     TARGET=3D&quot;$(git rev-parse --git=
-path hooks)/pre-commit&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if [ -e &quot;$TARGET&quot; ] ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -e &quot;$TARGET&qu=
ot; ]; then</span><br><span>         printf &quot;$TARGET file exists=2E Wo=
n&#39;t overwrite=2E\n&quot;</span><br><span>         printf &quot;Aborting=
 installation=2E\n&quot;</span><br><span>         exit 1</span><br><span>@@=
 -67,13 +65,13 @@</span><br><span>     local extension=3D&quot;=2E${filenam=
e##*=2E}&quot;</span><br><span>     local ext</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for ext in =2Ec =2Eh ; do [ &=
quot;$ext&quot; =3D &quot;$extension&quot; ] &amp;&amp; return 0; done</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for ext in =2Ec =2Eh=
; do [ &quot;$ext&quot; =3D &quot;$extension&quot; ] &amp;&amp; return 0; d=
one</span><br><span> </span><br><span>     return 1</span><br><span> }</spa=
n><br><span> </span><br><span> # necessary check for initial commit</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-if git rev-parse --verify HEA=
D &gt;/dev/null 2&gt;&amp;1 ; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if git rev-parse --verify HEAD &gt;/dev/null 2&gt;&amp;1; th=
en</span><br><span>     against=3DHEAD</span><br><span> else</span><br><spa=
n>     # Initial commit: diff against an empty tree object</span><br><span>=
@@ -88,8 +86,8 @@</span><br><span> </span><br><span>     # Allow to use in =
parallel with pre-commit</span><br><span>     if [ $(basename &quot;$0&quot=
;) =3D &quot;pre-commit=2Elegacy&quot; ]; then</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-       echo &quot;Skipping clang-format check in f=
avor of pre-commit&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-       exit 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     echo &quot;Skipping clang-format check in favor of pre-commit&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit 0</span><=
br><span>     fi</span><br><span> else</span><br><span>     TOOL=3Duncrusti=
fy</span><br><span>@@ -98,7 +96,7 @@</span><br><span>     TOOL_CMD=3D&quot;=
$TOOL_BIN -q -l C -c $UNCRUST_CONFIG&quot;</span><br><span> </span><br><spa=
n>     # make sure the config file is correctly set</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if [ ! -f &quot;$UNCRUST_CONFIG&quot; ]=
 ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ ! -=
f &quot;$UNCRUST_CONFIG&quot; ]; then</span><br><span>         printf &quot=
;Error: uncrustify config file not found=2E\n&quot;</span><br><span>       =
  printf &quot;Expected to find it at $UNCRUST_CONFIG=2E\n&quot;</span><br>=
<span>         printf &quot;Aborting commit=2E\n&quot;</span><br><span>@@ -=
106,7 +104,7 @@</span><br><span>     fi</span><br><span> fi</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$TOOL=
_BIN&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if [ -z &quot;$TOOL_BIN&quot; ]; then</span><br><span>     printf &quot;Err=
or: $TOOL executable not found=2E\n&quot;</span><br><span>     printf &quot=
;Is it installed and in your \$PATH?\n&quot;</span><br><span>     printf &q=
uot;Aborting commit=2E\n&quot;</span><br><span>@@ -120,44 +118,43 @@</span>=
<br><span> # create one patch containing all changes to the files</span><br=
><span> # sed to remove quotes around the filename, if inserted by the syst=
em</span><br><span> # (done sometimes, if the filename contains special cha=
racters, like the quote itself)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-git diff-index --cached --diff-filter=3DACMR --name-only $against=
 -- | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sed -e &#39;s/=
^&quot;\(=2E*\)&quot;$/\1/&#39; | \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-while read file</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # ignor=
e file if we do check for file extensions and the file</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    # does not match the extensions =2Ec o=
r =2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ! matche=
s_extension &quot;$file&quot;; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        continue;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+git=
 diff-index --cached --diff-filter=3DACMR --name-only $against -- |</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -e &#39;s/^&quot;\(=
=2E*\)&quot;$/\1/&#39; |</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    while read file; do</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # ignore file if we do check for file extensions and the f=
ile</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # does n=
ot match the extensions =2Ec or =2Eh</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if ! matches_extension &quot;$file&quot;; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # escape sp=
ecial characters in the target filename:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    # phase 1 (characters escaped in the output diff):</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;=
: backslash needs to be escaped in the output diff</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    #     - &#39;&quot;&#39;: quote needs to b=
e escaped in the output diff if present inside</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    #            of the filename, as it used to br=
acket the entire filename part</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    # phase 2 (characters escaped in the match replacement):</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;: ba=
ckslash needs to be escaped again for sed itself</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    #            (i=2Ee=2E double escaping after=
 phase 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - =
&#39;&amp;&#39;: would expand to matched string</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    #     - &#39;|&#39;: used as sed split char i=
nstead of &#39;/&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    # printf %s particularly important if the filename contains the % chara=
cter</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    file_escaped_=
target=3D$(printf &quot;%s&quot; &quot;$file&quot; | sed -e &#39;s/[\&quot;=
]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # escape special characters in th=
e target filename:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       # phase 1 (characters escaped in the output diff):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        #     - &#39;\&#39;: backslas=
h needs to be escaped in the output diff</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        #     - &#39;&quot;&#39;: quote needs to be es=
caped in the output diff if present inside</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        #            of the filename, as it used to =
bracket the entire filename part</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        # phase 2 (characters escaped in the match replacement=
):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     - &=
#39;\&#39;: backslash needs to be escaped again for sed itself</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        #            (i=2Ee=2E d=
ouble escaping after phase 1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        #     - &#39;&amp;&#39;: would expand to matched string</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     - &#39;=
|&#39;: used as sed split char instead of &#39;/&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # printf %s particularly importan=
t if the filename contains the % character</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        file_escaped_target=3D$(printf &quot;%s&quot=
; &quot;$file&quot; | sed -e &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39;s/[\&a=
mp;|]/\\&amp;/g&#39;)</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    # uncrustify our sourcefile, create a patch with diff=
 and append it to our $patch</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    # The sed call is necessary to transform the patch from</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    #    --- - timestamp</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    #    +++ $tmpout timest=
amp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # to both line=
s working on the same file and having a a/ and b/ prefix=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    # Else it can not be applied with=
 &#39;git apply&#39;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    git show &quot;:$file&quot; | $TOOL_CMD &gt; &quot;$tmpout&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    git show &quot;:$file&=
quot; | diff -u -- - &quot;$tmpout&quot; | \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        sed -e &quot;1s|--- -|--- \&quot;b/$file_esc=
aped_target\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_escape=
d_target\&quot;|&quot; &gt;&gt; &quot;$patch&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-done</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        # uncrustify our sourcefile, create a patch with diff=
 and append it to our $patch</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        # The sed call is necessary to transform the patch from</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        #    --- - tim=
estamp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #    =
+++ $tmpout timestamp</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        # to both lines working on the same file and having a a/ and b/ p=
refix=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # E=
lse it can not be applied with &#39;git apply&#39;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        git show &quot;:$file&quot; | $TO=
OL_CMD &gt;&quot;$tmpout&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        git show &quot;:$file&quot; | diff -u -- - &quot;$tmpout=
&quot; |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 sed -e &quot;1s|--- -|--- \&quot;b/$file_escaped_target\&quot;|&quot; -e &=
quot;2s|+++ $tmpout|+++ \&quot;a/$file_escaped_target\&quot;|&quot; &gt;&gt=
;&quot;$patch&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    done</span><br><span> </span><br><span> rm -f &quot;$tmpout&quot;</span=
><br><span> </span><br><span> # if no patch has been generated all is ok, c=
lean up the file stub and exit</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-if [ ! -s &quot;$patch&quot; ] ; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if [ ! -s &quot;$patch&quot; ]; then</span><br><=
span>     rm -f &quot;$patch&quot;</span><br><span>     exit 0</span><br><s=
pan> fi</span><br><span>@@ -165,7 +162,7 @@</span><br><span> # a patch has =
been created, notify the user and exit</span><br><span> printf &quot;Format=
ting of some code does not follow the project guidelines=2E\n&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $(wc -=
l &lt; $patch) -gt 80 ] ; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if [ $(wc -l &lt;$patch) -gt 80 ]; then</span><br><span>     pri=
ntf &quot;The file $patch contains the necessary fixes=2E\n&quot;</span><br=
><span> else</span><br><span>     printf &quot;Here&#39;s the patch that fi=
xes the formatting:\n\n&quot;</span><br><span>diff --git a/dev-tools/run-cp=
pcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index 40db33e=2E=
=2Ea7aa3c4 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><=
br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -20,24 +20,23=
 @@</span><br><span>  --check-level=3Dexhaustive --max-configs=3D10 \</span=
><br><span>  --error-exitcode=3D1&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> set -x</span><br><spa=
n> </span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot;</span><br><span> cd=
 &quot;${SOURCE_DIR}&quot;</span><br><span> cppcheck $COMMON_ARGS $INCLUDE_=
FLAGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --pla=
tform=3Dunix64 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         -U_WIN32 \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         src/openvpn/ src=
/compat/ src/plugins/ sample/ \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         tests/unit_tests/example_test/ tests/unit_tests/openvpn/=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         tests/unit=
_tests/plugins/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
--platform=3Dunix64 \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    --library=3Dposix=2Ecfg --library=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -U_WIN32 \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ src/com=
pat/ src/plugins/ sample/ \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_tests/plu=
gins/</span><br><span> cppcheck $COMMON_ARGS \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         --platform=3Dwin64 \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         --library=3Dwindows=2Ecfg \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         -D_WIN32 \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         -UTARGET_LINUX -UTAR=
GET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET=
_SOLARIS -UTARGET_DRAGONFLY \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         -UTARGET_AIX \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         src/openvpn* src/compat/ \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         tests/unit_tests/example_test/ tests/unit_=
tests/openvpn*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -=
-platform=3Dwin64 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    --library=3Dwindows=2Ecfg \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    -D_WIN32 \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_DARW=
IN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_AIX \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn* src/compat/ \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_tests/exampl=
e_test/ tests/unit_tests/openvpn*</span><br><span>diff --git a/dev-tools/up=
date-copyright=2Esh b/dev-tools/update-copyright=2Esh</span><br><span>index=
 96546dd=2E=2E7ca6002 100755</span><br><span>--- a/dev-tools/update-copyrig=
ht=2Esh</span><br><span>+++ b/dev-tools/update-copyright=2Esh</span><br><sp=
an>@@ -34,8 +34,7 @@</span><br><span> COPY_YEAR=3D&quot;$1&quot;</span><br>=
<span> </span><br><span> cd &quot;$(git rev-parse --show-toplevel)&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-for file in $(git ls-fil=
es | grep -v vendor/);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for file in $(gi=
t ls-files | grep -v vendor/); do</span><br><span>     echo -n &quot;Updati=
ng $file =2E=2E=2E&quot;</span><br><span>     # The first sed operation cov=
ers 20xx-20yy copyright lines,</span><br><span>     # The second sed operat=
ion changes 20xx -&gt; 20xx-20yy</span><br><span>diff --git a/tests/lwip_cl=
ient_up=2Esh b/tests/lwip_client_up=2Esh</span><br><span>index a6b4d24=2E=
=2Eb1941a4 100755</span><br><span>--- a/tests/lwip_client_up=2Esh</span><br=
><span>+++ b/tests/lwip_client_up=2Esh</span><br><span>@@ -2,16 +2,17 @@</s=
pan><br><span> #</span><br><span> # Determine the OpenVPN PID from its pid =
file=2E This works reliably even when</span><br><span> # the OpenVPN proces=
s is backgrounded for parallel tests=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+MY_PPID=3D$(cat $pid)</span><br><span> </span><br><span>=
 # Add this client&#39;s VPN IP and PID to a file=2E This enables</span><br=
><span> # t_server_null_client=2Esh to kill this OpenVPN client after fping=
 tests have</span><br><span> # finished=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-echo &quot;$ifconfig_local,$MY_PPID&quot; &gt;&gt; =2E=
/$test_name=2Elwip</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
cho &quot;$ifconfig_local,$MY_PPID&quot; &gt;&gt;=2E/$test_name=2Elwip</spa=
n><br><span> </span><br><span> # Wait long enough to allow fping tests to f=
inish=2E Also ensure that this</span><br><span> # OpenVPN client is killed =
even if t_server_null_client=2Esh failed to do it=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-(sleep 15</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-echo &quot;ERROR: t_server_null_client=2Esh failed to k=
ill OpenVPN client with PID $MY_PPID in test $test_name=2E Killing it in lw=
ip_client_up=2Esh=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-kill -15 $MY_PPID</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sleep 15</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;ERROR: =
t_server_null_client=2Esh failed to kill OpenVPN client with PID $MY_PPID i=
n test $test_name=2E Killing it in lwip_client_up=2Esh=2E&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    kill -15 $MY_PPID</span><br=
><span> ) &amp;</span><br><span>diff --git a/tests/null_client_up=2Esh b/te=
sts/null_client_up=2Esh</span><br><span>index d4df0c6=2E=2Ebe339ee 100755</=
span><br><span>--- a/tests/null_client_up=2Esh</span><br><span>+++ b/tests/=
null_client_up=2Esh</span><br><span>@@ -4,8 +4,11 @@</span><br><span> </spa=
n><br><span> # Determine the OpenVPN PID from its pid file=2E This works re=
liably even when</span><br><span> # the OpenVPN process is backgrounded for=
 parallel tests=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MY_=
PPID=3D`cat $pid`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MY=
_PPID=3D$(cat $pid)</span><br><span> </span><br><span> # Allow OpenVPN to f=
inish initializing while waiting in the background and then</span><br><span=
> # killing the process gracefully=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-(sleep 5 ; kill -15 $MY_PPID) &amp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+(</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sleep 5</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    kill -15 $MY_PPID</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+) &amp;</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein</span><br><span>index 7233187=2E=2E4b6c51d 100755</=
span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t=
_client=2Esh=2Ein</span><br><span>@@ -19,9 +19,9 @@</span><br><span> srcdir=
=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top_b=
uilddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_bu=
ilddir}/src/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ] ; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -r &quot;${top_bui=
lddir}&quot;/t_client=2Erc ]; then</span><br><span>     =2E &quot;${top_bui=
lddir}&quot;/t_client=2Erc</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ] ; then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+elif [ -r &quot;${srcdir}&quot;/t_c=
lient=2Erc ]; then</span><br><span>     =2E &quot;${srcdir}&quot;/t_client=
=2Erc</span><br><span> else</span><br><span>     echo &quot;$0: cannot find=
 &#39;t_client=2Erc&#39; in build dir (&#39;${top_builddir}&#39;)&quot; &gt=
;&amp;2</span><br><span>@@ -32,37 +32,35 @@</span><br><span> # Check for ex=
ternal dependencies</span><br><span> FPING=3D&quot;fping&quot;</span><br><s=
pan> FPING6=3D&quot;fping6&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-which fping &gt; /dev/null</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+which fping &gt;/dev/null</span><br><span> if [ $? -ne 0 =
]; then</span><br><span>     echo &quot;$0: fping is not available in \$PAT=
H&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;=
</span><br><span> fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-w=
hich fping6 &gt; /dev/null</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+which fping6 &gt;/dev/null</span><br><span> if [ $? -ne 0 ]; then</s=
pan><br><span>     echo &quot;$0: fping6 is not available in \$PATH, assumi=
ng fping 4=2E0 or later&quot; &gt;&amp;2</span><br><span>     FPING=3D&quot=
;fping -4&quot;</span><br><span>     FPING6=3D&quot;fping -6&quot;</span><b=
r><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-KILL_EXEC=3D`which kill`</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+KILL_EXEC=3D$(which kill)</span><br><span> if [ $? -ne 0 ]; th=
en</span><br><span>     echo &quot;$0: kill not found in \$PATH&quot; &gt;&=
amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><s=
pan> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-if [ ! -x &quot;${openvpn}&quot; ]</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if [ ! -x &quot;${openvpn}&quot; ]; then</span><br><span>     echo &quot;=
no (executable) openvpn binary in current build tree=2E FAIL=2E&quot; &gt;&=
amp;2</span><br><span>     exit 1</span><br><span> fi</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -w =2E ]</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if [ ! -w =2E ]; then</span><br><span>     ech=
o &quot;current directory is not writable (required for logging)=2E FAIL=2E=
&quot; &gt;&amp;2</span><br><span>     exit 1</span><br><span> fi</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot=
;$TEST_RUN_LIST&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if [ -z &quot;$TEST_RUN_LIST&quot; ]; then</span><br><span>     =
echo &quot;TEST_RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot; &gt=
;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br>=
<span> fi</span><br><span>@@ -72,16 +70,14 @@</span><br><span> </span><br><=
span> # make sure we have permissions to run ifconfig/route from OpenVPN</s=
pan><br><span> # can&#39;t use &quot;id -u&quot; here - doesn&#39;t work on=
 Solaris</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ID=3D`id`</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-if expr &quot;$ID&quot; :=
 &quot;uid=3D0&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ID=3D$(id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if expr &=
quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quo=
t; -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREF=
ER_KSU}&quot; -eq 1 ]; then</span><br><span>         # Check if we have a v=
alid kerberos ticket</span><br><span>         klist -l 1&gt;/dev/null 2&gt;=
/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [=
 $? -ne 0 ];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $? =
-ne 0 ]; then</span><br><span>             # No kerberos ticket found, skip=
 ksu and fallback to RUN_SUDO</span><br><span>             PREFER_KSU=3D0</=
span><br><span>             echo &quot;$0: No Kerberos ticket available=2E =
 Will not use ksu=2E&quot;</span><br><span>@@ -90,8 +86,7 @@</span><br><spa=
n>         fi</span><br><span>     fi</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; t=
hen</span><br><span>         echo &quot;$0: this test must run be as root, =
or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</span><br><span>         echo &qu=
ot;      must be set correctly in &#39;t_client=2Erc&#39;=2E SKIP=2E&quot; =
&gt;&amp;2</span><br><span>         exit &quot;${TCLIENT_SKIP_RC}&quot;</sp=
an><br><span>@@ -99,19 +94,18 @@</span><br><span>         # We have to use =
sudo=2E Make sure that we (hopefully) do not have</span><br><span>         =
# to ask the users password during the test=2E This is done to</span><br><s=
pan>         # prevent timing issues, e=2Eg=2E when the waits for openvpn t=
o start</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if $RUN_SUDO =
$KILL_EXEC -0 $$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;$0: $=
RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=
=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if $RUN_SUDO $KILL_EXEC -0 $$; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$0: $RUN_SUDO $KIL=
L_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot g=
o on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span>     fi=
</span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-LOGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-if mkdir $LOGDIR</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+LOGDIR=3Dt_client-$(hostname)-$(date +%Y%m%d-%H=
%M%S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if mkdir $LOGD=
IR; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :</span=
><br><span> else</span><br><span>     echo &quot;can&#39;t create log direc=
tory &#39;$LOGDIR&#39;=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     exi=
t 1</span><br><span>@@ -128,103 +122,105 @@</span><br><span> </span><br><sp=
an> # output progress information</span><br><span> #  depending on verbosit=
y level, collect &amp; print only on failure</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-output_start()</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ou=
tput_start() {</span><br><span>     case $V in</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	0) outbuf=3D&quot;&quot; ;;			# no per-test outpu=
t at all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	1) echo -e &=
quot;$@&quot;			# compact, details only on failure</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-           outbuf=3D&quot;\n&quot; ;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	*) echo -e &quot;\n$@\n&quot;=
 ;;		# print all, with a bit formatting</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    0) outbuf=3D&quot;&quot; ;; # no per-test output at=
 all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        echo -e &quot;$@&quo=
t; # compact, details only on failure</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        outbuf=3D&quot;\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    *) echo -e &quot;\n$@\n&quot; ;; # print all, with=
 a bit formatting</span><br><span>     esac</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-output()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    NO_NL=3D&#39;&#39;; if [ &quot;X$1&quot; =3D =
&quot;X-n&quot; ] ; then NO_NL=3D$1 ; shift ; fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+output() {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    NO_NL=3D&#39;&#39;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if [ &quot;X$1&quot; =3D &quot;X-n&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NO_NL=3D$1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        shift</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>   =
  case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) ;;			=
	# no per-test output at all</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	1) outbuf=3D&quot;$outbuf$@&quot; 		# print details only on failure=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   test -z &quot;$NO=
_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           ;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	*) echo -e $NO_NL &quot;$@&quot; ;;	# print everyt=
hing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0) ;; # no =
per-test output at all</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ou=
tbuf=3D&quot;$outbuf$@&quot; # print details only on failure</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        test -z &quot;$NO_NL&quot;=
 &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    *) echo -e $NO_NL &quot;$@&quot; ;; # print everything</s=
pan><br><span>     esac</span><br><span> }</span><br><span> </span><br><spa=
n> # print failure message, increase FAIL counter</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-fail()</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fail(=
) {</span><br><span>     output &quot;FAIL: $@\n&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$(( $fail_count + 1 ))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fail_count=3D$(($f=
ail_count + 1))</span><br><span> }</span><br><span> </span><br><span> # pri=
nt &quot;all interface IP addresses&quot; + &quot;all routes&quot;</span><b=
r><span> # this is higly system dependent=2E=2E=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-get_ifconfig_route()</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    UNAME=3D`uname -s`</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_ifconfig_route() {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    UNAME=3D$(uname -s)</span><br><span>     case $UNAME in</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Linux)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            # linux / iproute2? (-&gt=
; if configure got a path)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if [ -n &quot;@IPROUTE@&quot; ]</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            then</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                echo &quot;-- linux iproute2 --&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                @IPRO=
UTE@ addr show     | grep -v valid_lft</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                @IPROUTE@ route show</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                @IPROUTE@ -o -6 route show =
| grep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e =
&#39;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar)=
 [0-9]+ms//g&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	        =
echo &quot;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	        LANG=3DC @IFCONFIG@ -a |egrep  &quot;( addr:|enc=
ap:)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	        LA=
NG=3DC @NETSTAT@ -rn -4 -6</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	FreeBSD|=
NetBSD|Darwin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ech=
o &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|i=
net)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTA=
T@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OpenBSD)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	   echo &quot;-- OpenBSD --&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot=
; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		sed -e &#39;s/=
pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ {=
 print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SunOS)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- Solari=
s --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONF=
IG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$=
2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AIX)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- AIX --&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &qu=
ot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        *)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-           echo &quot;get_ifconfig_route(): no idea=
 how to get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt;&amp;2</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-           exit 20</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           ;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    Linux)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        # linux / iproute2? (-&gt; if configu=
re got a path)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if [ -n &quot;@IPROUTE@&quot; ]; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            echo &quot;-- linux iproute2 --&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            @IPROUTE@ ad=
dr show | grep -v valid_lft</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            @IPROUTE@ route show</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            @IPROUTE@ -o -6 route show | grep -v &#39;=
 cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39; -e &#39;s/ (mtu|ho=
plimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rttvar) [0-9]+ms//g&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-=
- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            LANG=3DC @IFCONFIG@ -a | egrep &quot;( addr:|encap:)&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            LANG=
=3DC @NETSTAT@ -rn -4 -6</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FreeBSD |=
 NetBSD | Darwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        @IFCONFIG@ -a | egrep &quo=
t;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenBSD)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;-- OpenBSD --&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        @IFCON=
FIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            sed -e &#39;s/pltime [0-9]*//&#39; -e=
 &#39;s/vltime [0-9]*//&#39;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF=
 }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SunOS)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;-- Solaris =
--&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        @IF=
CONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { =
print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
AIX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &q=
uot;-- AIX --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        @NETSTAT@ -rn | awk &#39;$3 !=
~ /^UHL/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  echo &quot;get_ifconfig_route(): no idea how to get info on your OS ($(un=
ame -s))=2E  FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        exit 20</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ;;</span><br><span>     esac</span><br><span> </span>=
<br><span>     # another round of per-platform information gathering, for D=
NS info</span><br><span>     # for most of the platforms &quot;cat /etc/res=
olv=2Econf&quot; is good enough</span><br><span>     # except Linux and Mac=
OS</span><br><span>     case $UNAME in</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	Linux)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ech=
o &quot;-- linux resolvectl --&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                resolvectl status</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                echo &quot;-- linux resolv=2Econf --&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
cat /etc/resolv=2Econf</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Darwin)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            echo &quot;-- =
MacOS scutil --dns&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            scutil --dns</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       *)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
echo &quot;-- resolv=2Econf --&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    Linux)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ]; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo =
&quot;-- linux resolvectl --&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            resolvectl status</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            echo &quot;-- linux resolv=2Econf --&quot;</s=
pan><br><span>             cat /etc/resolv=2Econf</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            ;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    Darwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     echo &quot;-- MacOS scutil --dns&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        scutil --dns</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        echo &quot;-- resolv=2Econf --&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cat /etc/resolv=2Econf</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ;;</span><br><span>     esac=
</span><br><span> }</span><br><span> </span><br><span>@@ -232,21 +228,20 @@=
</span><br><span> # check ifconfig</span><br><span> #  arg1: &quot;4&quot; =
or &quot;6&quot; -&gt; for message</span><br><span> #  arg2: IPv4/IPv6 addr=
ess that must show up in out of &quot;get_ifconfig_route&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_ifconfig()</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    proto=3D$1 ; shift</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_ifconfig() {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    proto=3D$1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    shift</span><br><span>     expect_list=3D&quot;$@&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 [ -z &quot;$expect_list&quot; ] ; then return ; fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$expect_list&quot; =3D &quot=
;-&quot; ] ; then return ; fi</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if [ -z &quot;$expect_list&quot; ]; then return; fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$expect_list&q=
uot; =3D &quot;-&quot; ]; then return; fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for expect in $expect_list</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	if get_ifconfig_route | fgrep &quot;$expec=
t&quot; &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	then :</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	    fail &quot;check_ifconfig=
(): expected IPv$proto address &#39;$expect&#39; not found in ifconfig outp=
ut=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for expect in $expect_=
list; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
get_ifconfig_route | fgrep &quot;$expect&quot; &gt;/dev/null; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            :</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fail &quot;check_ifconfig(): =
expected IPv$proto address &#39;$expect&#39; not found in ifconfig output=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi=
</span><br><span>     done</span><br><span> }</span><br><span> </span><br><=
span>@@ -255,49 +250,49 @@</span><br><span> #  arg1: &quot;4&quot; or &quot=
;6&quot; -&gt; fping/fing6</span><br><span> #  arg2: &quot;want_ok&quot; or=
 &quot;want_fail&quot; (expected ping result)</span><br><span> #  arg3=2E=
=2E=2E -&gt; fping arguments (host list)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-run_ping_tests()</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pr=
oto=3D$1 ; want=3D$2 ; shift ; shift</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+run_ping_tests() {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    proto=3D$1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    want=3D$2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    shift</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
hift</span><br><span>     targetlist=3D&quot;$@&quot;</span><br><span> </sp=
an><br><span>     # &quot;no targets&quot; is fine</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$targetlist&quot; ] ; then r=
eturn ; fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ =
-z &quot;$targetlist&quot; ]; then return; fi</span><br><span> </span><br><=
span>     case $proto in</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	*) echo &quot;internal error in run_ping_tests arg=
 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	   exit 1 ;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    4) cmd=3D&quot;$FPING&quot; ;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    6) cmd=3D&quot;$FPING6&quot; ;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    *)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        echo &quot;internal error in run_ping_t=
ests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ;;</span><br><span>     esac</span><br><span> =
</span><br><span>     case $want in</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	want_ok)   sizes_list=3D&quot;64 1440 3000&quot; ;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	want_fail) sizes_list=3D&quot=
;64&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wan=
t_ok) sizes_list=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    want_fail) sizes_list=3D&quot;64&quot; ;;</s=
pan><br><span>     esac</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for bytes in $sizes_list</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	output &quot;run IPv$proto ping tests ($want), $bytes byte pac=
kets=2E=2E=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for bytes in $sizes_list; do</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        output &quot;run IPv$proto ping tests ($want), $bytes =
byte packets=2E=2E=2E&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_a=
rgs $targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	$cmd -b $bytes -C 20 -p 250 -q $fping_arg=
s $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$cmd -b $bytes -C=
 20 -p 250 -q $fping_args $targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eou=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        $cmd -b $b=
ytes -C 20 -p 250 -q $fping_args $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eo=
ut 2&gt;&amp;1</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	# while OpenVPN is running, pings must succeed (want=3D&#39;wan=
t_ok&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# before O=
penVPN is up, pings must NOT succeed (want=3D&#39;want_fail&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        # while OpenVPN is ru=
nning, pings must succeed (want=3D&#39;want_ok&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # before OpenVPN is up, pings mus=
t NOT succeed (want=3D&#39;want_fail&#39;)</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	rc=3D$?</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	if [ $rc =3D 0 ] 				# all ping OK</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	    if [ $want =3D &quot;want_fail&quot; ]		# not =
what we want</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$prot=
o ping test succeeded, but needs to *fail*=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    fi</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	else					# ping failed</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	    if [ $want =3D &quot;want_ok&quot; ]		# not what w=
e wanted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    then</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto pi=
ng test ($bytes bytes) failed, but should succeed=2E&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	    fi</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        rc=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if [ $rc =3D 0 ]; then                 # all ping OK</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if [ $want =3D &quo=
t;want_fail&quot; ]; then # not what we want</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                fail &quot;IPv$proto ping test suc=
ceeded, but needs to *fail*=2E&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else                               # ping failed</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ $want =3D=
 &quot;want_ok&quot; ]; then # not what we wanted</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                fail &quot;IPv$proto ping tes=
t ($bytes bytes) failed, but should succeed=2E&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        fi</span><br><span>     done</span><br=
><span> }</span><br><span> </span><br><span>@@ -308,8 +303,7 @@</span><br><=
span> SUMMARY_SKIP=3D</span><br><span> SUMMARY_FAIL=3D</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIS=
T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><=
br><span>     # get config variables</span><br><span>     eval test_prep=3D=
\&quot;\$PREPARE_$SUF\&quot;</span><br><span>     eval test_check_skip=3D\&=
quot;\$CHECK_SKIP_$SUF\&quot;</span><br><span>@@ -336,11 +330,13 @@</span><=
br><span> </span><br><span>     if [ -n &quot;$test_check_skip&quot; ]; the=
n</span><br><span>         output &quot;check whether we need to skip: &#39=
;$test_check_skip&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if eval $test_check_skip; then :</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if eval $test_check_skip; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            :</span><br><spa=
n>         else</span><br><span>             output &quot;skip check failed=
, SKIP test $SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot;$outbuf&quot; ; continu=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SUMMAR=
Y_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            echo -e &quot;$outbuf&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue</span><br><spa=
n>         fi</span><br><span>     fi</span><br><span> </span><br><span>@@ =
-355,13 +351,14 @@</span><br><span>     output &quot;\nrun pre-openvpn ping=
 tests - targets must not be reachable=2E=2E=2E&quot;</span><br><span>     =
run_ping_tests 4 want_fail &quot;$ping4_hosts&quot;</span><br><span>     ru=
n_ping_tests 6 want_fail &quot;$ping6_hosts&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fai=
l_count&quot; =3D 0 ]; then</span><br><span>         output &quot;OK=2E\n&q=
uot;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	fail &quot;make sure that ping hosts are ONLY reachable via VPN, =
SKIP test $SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	exit_code=3D31</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ; continue</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;make sure that =
ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SU=
MMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        exit_code=3D31</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        echo -e &quot;$outbuf&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        continue</span><br><span>     fi</span><br><sp=
an> </span><br><span>     pidfile=3D&quot;${top_builddir}/tests/$LOGDIR/ope=
nvpn-$SUF=2Epid&quot;</span><br><span>@@ -376,18 +373,17 @@</span><br><span=
>     # to $ovpn_init_check times=2E</span><br><span>     ovpn_init_check=
=3D30</span><br><span>     ovpn_init_success=3D0</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    while [ $ovpn_init_check -gt 0 ];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-       sleep 1  # Wait for OpenVPN to initializ=
e and have had time to write the pid file</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-       grep &quot;Initialization Sequence Completed&quo=
t; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-       if [ $? -eq 0 ]; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-           ovpn_init_check=3D0</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_success=3D1</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-       fi</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-       ovpn_init_check=3D$(( $ovpn_ini=
t_check - 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile [ $ovpn_init_check -gt 0 ]; do</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sleep 1 # Wait for OpenVPN to initialize and have h=
ad time to write the pid file</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        grep &quot;Initialization Sequence Completed&quot; $LOGDI=
R/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if [ $? -eq 0 ]; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ovpn_init_check=3D0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ovpn_init_success=3D1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ovpn_init_check=3D$(($ovp=
n_init_check - 1))</span><br><span>     done</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    opid=3D`cat $pidfile`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D$(cat $pidfile)</=
span><br><span>     if [ -n &quot;$opid&quot; ]; then</span><br><span>     =
    output &quot;  OpenVPN running with PID $opid&quot;</span><br><span>   =
  else</span><br><span>@@ -398,16 +394,17 @@</span><br><span>     if [ $ovp=
n_init_success -ne 1 -o -z &quot;$opid&quot; ]; then</span><br><span>      =
   output &quot;$0:  OpenVPN did not initialize in a reasonable time&quot;<=
/span><br><span>         if [ -n &quot;$opid&quot; ]; then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           $RUN_SUDO $KILL_EXEC $opid<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUD=
O $KILL_EXEC $opid</span><br><span>         fi</span><br><span>         $RU=
N_SUDO $KILL_EXEC $sudopid</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	output &quot;`tail -5 $LOGDIR/$SUF:openvpn=
=2Elog`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &q=
uot;skip rest of sub-tests for test run $SUF=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	trap - 0 1 2 3 15</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot=
; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        output &quot;$(tail -5 $LOGDIR/$SUF:open=
vpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     fail &quot;skip rest of sub-tests for test run $SUF=2E&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        trap - 0 1 2 3 15</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D=
&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        exit_code=3D30</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        echo -e &quot;$outbuf&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        continue</span><br><span>     fi</spa=
n><br><span> </span><br><span>     # make sure openvpn client is terminated=
 in case shell exits</span><br><span>@@ -418,17 +415,16 @@</span><br><span>=
     output &quot;save ifconfig+route&quot;</span><br><span>     get_ifconf=
ig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$expect_ifconfig4=
&quot; =3D &quot;-&quot; ] ; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; t=
hen</span><br><span>         output &quot;skip ifconfig+route check&quot;</=
span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	output -n &quot;compare pre-openvpn ifconfig+route with current values=
=2E=2E=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if di=
ff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		$LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	    fail &quot;no differences between ifc=
onfig/route before OpenVPN start and now=2E&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	    output &quot; OK!\n&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        output -n &quot;compare pre-openvpn ifconfig+route with curren=
t values=2E=2E=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            $LOGDIR/$SUF:ifconfig_r=
oute=2Etxt &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            fail &quot;no differences between ifconfig/route bef=
ore OpenVPN start and now=2E&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            output &quot; OK!\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        fi</span><br><span>     fi</span><br><spa=
n> </span><br><span>     # post init script needed?</span><br><span>@@ -449=
,8 +445,8 @@</span><br><span>     $RUN_SUDO $KILL_EXEC $opid</span><br><spa=
n>     wait $!</span><br><span>     rc=3D$?</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if [ $rc !=3D 0 ] ; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	fail &quot;OpenVPN return code $rc, expect 0&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ $rc !=
=3D 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  fail &quot;OpenVPN return code $rc, expect 0&quot;</span><br><span>     f=
i</span><br><span> </span><br><span>     output &quot;\nsave post-openvpn i=
fconfig + route=2E=2E=2E&quot;</span><br><span>@@ -458,23 +454,22 @@</span>=
<br><span> </span><br><span>     output -n &quot;compare pre- and post-open=
vpn ifconfig + route=2E=2E=2E&quot;</span><br><span>     if diff $LOGDIR/$S=
UF:ifconfig_route_pre=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	    $LOGDIR/$SUF:ifconfig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconf=
ig_route_diff=2Etxt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot; =
OK=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  $LOGDIR/$SUF:ifconfig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_di=
ff=2Etxt; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   output &quot; OK=2E\n&quot;</span><br><span>     else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	output &quot;\n\n&quot; &quot;`cat $LOG=
DIR/$SUF:ifconfig_route_diff=2Etxt`&quot; &quot;\n&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	fail &quot;differences between pre- and=
 post-ifconfig/route=2E&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        output &quot;\n\n&quot; &quot;$(cat $LOGDIR/$SUF:ifconfig=
_route_diff=2Etxt)&quot; &quot;\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        fail &quot;differences between pre- and post-if=
config/route=2E&quot;</span><br><span>     fi</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fail_co=
unt&quot; =3D 0 ]; then</span><br><span>         output &quot;test run $SUF=
: all tests OK=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot=
;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	if [ &quot;$V&quot; -gt 0 ] ; then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	    echo -e -n &quot;$outbuf&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot;test run $SUF: $fail_c=
ount test failures=2E FAIL=2E\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if [ &quot;$V&quot; -gt 0 ]; then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            echo -e -n &quot;$outbu=
f&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
echo -e &quot;test run $SUF: $fail_count test failures=2E FAIL=2E\n&quot;</=
span><br><span>         fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit_=
code=3D30</span><br><span>     fi</span><br><span> </span><br><span>     if=
 [ -n &quot;$test_cleanup&quot; ]; then</span><br><span>@@ -484,9 +479,9 @@=
</span><br><span> </span><br><span> done</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMARY_OK&quot; ] ; th=
en SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-if [ -z &quot;$SUMMARY_SKIP&quot; ] ; then SUMMARY_SKIP=3D&=
quot; none&quot;; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
f [ -z &quot;$SUMMARY_FAIL&quot; ] ; then SUMMARY_FAIL=3D&quot; none&quot;;=
 fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$S=
UMMARY_OK&quot; ]; then SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_SKIP&quot; ];=
 then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_FAIL&quot; ]; then SUMMARY_FA=
IL=3D&quot; none&quot;; fi</span><br><span> echo &quot;Test sets succeeded:=
$SUMMARY_OK=2E&quot;</span><br><span> echo &quot;Test sets skipped:$SUMMARY=
_SKIP=2E&quot;</span><br><span> echo &quot;Test sets failed:$SUMMARY_FAIL=
=2E&quot;</span><br><span>diff --git a/tests/t_cltsrv=2Esh b/tests/t_cltsrv=
=2Esh</span><br><span>index 6b7df65=2E=2Ef4442a2 100755</span><br><span>---=
 a/tests/t_cltsrv=2Esh</span><br><span>+++ b/tests/t_cltsrv=2Esh</span><br>=
<span>@@ -24,19 +24,19 @@</span><br><span> trap &quot;rm -f log=2E$$ log=2E=
$$=2Esignal ; trap 0 ; exit 77&quot; 1 2 15</span><br><span> trap &quot;rm =
-f log=2E$$ log=2E$$=2Esignal ; exit 1&quot; 0 3</span><br><span> addopts=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-case `uname -s` in=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    FreeBSD)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+case $(uname -s) in</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+FreeBSD)</span><br><span>   =
  # FreeBSD jails map the outgoing IP to the jail IP - we need to</span><br=
><span>     # allow the real IP unless we want the test to run forever=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if test &quot;`sysc=
tl 2&gt;/dev/null -n security=2Ejail=2Ejailed`&quot; =3D 1 \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    || ps -ostate=3D -p $$ | grep -q=
 J; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	addopts=3D&q=
uot;--float&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if =
test &quot;x`ifconfig | grep inet`&quot; =3D x ; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;###&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;### To run the test in =
a FreeBSD jail, you MUST add an IP alias for the jail&#39;s IP=2E&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;###&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    exit 77</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if test &quot;$(sysctl 2&gt;/dev/null -n s=
ecurity=2Ejail=2Ejailed)&quot; =3D 1 ||</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ps -ostate=3D -p $$ | grep -q J; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        addopts=3D&quot;--flo=
at&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
test &quot;x$(ifconfig | grep inet)&quot; =3D x; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;###&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;### T=
o run the test in a FreeBSD jail, you MUST add an IP alias for the jail&#39=
;s IP=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       echo &quot;###&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            exit 77</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        fi</span><br><span>     fi</span><br><span>     ;;</span><b=
r><span> esac</span><br><span>@@ -45,29 +45,37 @@</span><br><span> # skip) =
test if it isn&#39;t=2E</span><br><span> downscript=3D&quot;=2E=2E/tests/t_=
cltsrv-down=2Esh&quot;</span><br><span> root=3D&quot;${top_srcdir}/sample&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test -x &quot;${r=
oot}/${downscript}&quot; || chmod +x &quot;${root}/${downscript}&quot; || {=
 echo &gt;&amp;2 &quot;${root}/${downscript} is not executable, failing=2E&=
quot; ; exit 1 ; }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est -x &quot;${root}/${downscript}&quot; || chmod +x &quot;${root}/${downsc=
ript}&quot; || {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 echo &gt;&amp;2 &quot;${root}/${downscript} is not executable, failing=2E&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> echo=
 &quot;The following test will take about two minutes=2E&quot; &gt;&amp;2</=
span><br><span> echo &quot;If the addresses are in use, this test will retr=
y up to two times=2E&quot; &gt;&amp;2</span><br><span> </span><br><span> # =
go</span><br><span> success=3D0</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-for i in 1 2 3 ; do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  set +e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &quot;${openvpn}&quot=
; --script-security 2 --cd &quot;${root}&quot; ${addopts} --setenv role srv=
 --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 --config &quot=
;sample-config-files/loopback-server&quot; &amp;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  &quot;${openvpn}&quot; --script-security 2 --c=
d &quot;${top_srcdir}/sample&quot; ${addopts} --setenv role clt --down &quo=
t;${downscript}&quot; --tls-exit --ping-exit 180 --config &quot;sample-conf=
ig-files/loopback-client&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  ) 3&gt;log=2E$$=2Esignal &gt;log=2E$$ 2&gt;&amp;1</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  e1=3D$?</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  wait $!</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  e2=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  grep &#39;TCP/UDP: Socket bind failed on local address=2E*in use&#39; =
log=2E$$ &gt;/dev/null &amp;&amp; {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &#39;address in use, retrying in 150 s&#39;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    sleep 150</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    continue</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  grep -v &#39;:inactive$&#39; log=2E$$=2Esignal &gt;/dev/null &a=
mp;&amp; { cat log=2E$$=2Esignal ; echo ; cat log=2E$$ ; exit 1 ; }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  success=3D1</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  break</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+for i in 1 2 3; do</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    set +e</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    (</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;${openvpn}&quot; --script-security 2 --cd &quot;${root}&quo=
t; ${addopts} --setenv role srv --down &quot;${downscript}&quot; --tls-exit=
 --ping-exit 180 --config &quot;sample-config-files/loopback-server&quot; &=
amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;$=
{openvpn}&quot; --script-security 2 --cd &quot;${top_srcdir}/sample&quot; $=
{addopts} --setenv role clt --down &quot;${downscript}&quot; --tls-exit --p=
ing-exit 180 --config &quot;sample-config-files/loopback-client&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ) 3&gt;log=2E$$=2Esig=
nal &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    e1=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    wait $!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e2=
=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    grep &#39;=
TCP/UDP: Socket bind failed on local address=2E*in use&#39; log=2E$$ &gt;/d=
ev/null &amp;&amp; {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        echo &#39;address in use, retrying in 150 s&#39;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        sleep 150</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        continue</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    grep -v &#39;:inactive$&#39; log=2E$$=2Esignal &gt;=
/dev/null &amp;&amp; {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cat log=2E$$=2Esignal</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        echo</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cat log=2E$$</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    success=
=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    break</span=
><br><span> done</span><br><span> </span><br><span> set -e</span><br><span>=
@@ -75,14 +83,14 @@</span><br><span> # exit code - defaults to 0, PASS</spa=
n><br><span> ec=3D0</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-if [ $success !=3D 1 ] ; then</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  # couldn&#39;t run test -- addresses in use, skip=
 test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cat log=2E$$</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ec=3D77</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0=
 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  # failure =
-- fail test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cat log=
=2E$$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ec=3D1</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if [ $success !=3D 1 ]; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # couldn&#39;t=
 run test -- addresses in use, skip test</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    cat log=2E$$</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ec=3D77</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # failure -- fail test</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    cat log=2E$$</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ec=3D1</span><br><span> fi</span>=
<br><span> </span><br><span> rm log=2E$$ log=2E$$=2Esignal</span><br><span>=
diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><br><span>inde=
x 6802506=2E=2E8379f8f 100755</span><br><span>--- a/tests/t_lpback=2Esh</sp=
an><br><span>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -34,54 +34,57 @@<=
/span><br><span> </span><br><span> # output progress information</span><br>=
<span> #  depending on verbosity level, collect &amp; print only on failure=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_start()</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_start() {</span><br><span>     case $V in</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        0) outbuf=3D&qu=
ot;&quot; ;;                  # no per-test output at all</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        1) outbuf=3D&quot;$@&quot; ;;  =
              # compact, details only on failure</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        *) printf &quot;$@&quot; ;;             =
   # print all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
) outbuf=3D&quot;&quot; ;;   # no per-test output at all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    1) outbuf=3D&quot;$@&quot; ;; # co=
mpact, details only on failure</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *) printf &quot;$@&quot; ;; # print all</span><br><span>    =
 esac</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-test_end()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    RC=3D$1 ; LOG=3D$2</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $RC !=3D 0 ]</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_end() {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    RC=3D$1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    LOG=3D$2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if [ $RC !=3D 0 ]; then</span><br><span>         case $V=
 in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            0) ;; =
                               # no per-test output</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            1) echo &quot;$outbuf&quot; &qu=
ot;FAIL (RC=3D$RC)&quot;; cat $LOG ;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            *) echo &quot;FAIL (RC=3D$RC)&quot;; cat $LOG ;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0) ;; # no=
 per-test output</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
echo &quot;$outbuf&quot; &quot;FAIL (RC=3D$RC)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cat $LOG</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        *)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            echo &quot;FAIL (RC=3D$RC)&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            cat $LOG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><sp=
an>         esac</span><br><span>         e=3D1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        tests_failed=3D$(( $tests_failed + 1 ))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests_failed=
=3D$(($tests_failed + 1))</span><br><span>     else</span><br><span>       =
  case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   0|1) ;;                              # no per-test output for &#39;OK&#3=
9;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *) echo=
 &quot;OK&quot;                         # print all</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0 | 1) ;;       # no per-test out=
put for &#39;OK&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        *) echo &quot;OK&quot; ;; # print all</span><br><span>         esa=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tests_passed=
=3D$(( $tests_passed + 1 ))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tests_passed=3D$(($tests_passed + 1))</span><br><span>     =
fi</span><br><span> }</span><br><span> </span><br><span> # if running with =
V=3D1, give an indication what test runs now</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-if [ &quot;$V&quot; =3D 1  ] ; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$V&quot; =3D 1 ]; then</s=
pan><br><span>     echo &quot;$0: running with V=3D$V, only printing test f=
ails&quot;</span><br><span> fi</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> # Get list of supported cipher=
s from openvpn --show-ciphers output</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-CIPHERS=3D$(${openvpn} --show-ciphers | \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            sed -e &#39;/The following/,=
/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39;/^[[:space:]]*$/d&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+CIPHERS=3D$(${openvpn} --show=
-ciphers |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -=
e &#39;/The following/,/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39;/^[[:space=
:]]*$/d&#39;)</span><br><span> </span><br><span> # SK, 2014-06-04: currentl=
y the DES-EDE3-CFB1 implementation of OpenSSL is</span><br><span> # broken =
(see http://rt=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867), so exclude=
</span><br><span> # that cipher from this test=2E</span><br><span> # GD, 20=
14-07-06 so is DES-CFB1</span><br><span> # GD, 2014-07-06 do not test RC5-*=
 either (fails on NetBSD w/o libcrypto_rc5)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-CIPHERS=3D$(echo &quot;$CIPHERS&quot; | egrep -v &#39=
;^(DES-EDE3-CFB1|DES-CFB1|RC5-)&#39; )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CIPHERS=3D$(echo &quot;$CIPHERS&quot; | egrep -v &#39;^(=
DES-EDE3-CFB1|DES-CFB1|RC5-)&#39;)</span><br><span> </span><br><span> e=3D0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$CIPHER=
S&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if =
[ -z &quot;$CIPHERS&quot; ]; then</span><br><span>     echo &quot;&#39;open=
vpn --show-ciphers&#39; FAILED (empty list)&quot;</span><br><span>     e=3D=
1</span><br><span> fi</span><br><span>@@ -91,10 +94,9 @@</span><br><span> <=
/span><br><span> set +e</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-for cipher in ${CIPHERS}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+for cipher in ${CIPHERS}; do</span><br><span>     test_start &quot;Te=
sting cipher ${cipher}=2E=2E=2E &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ( &quot;${openvpn}&quot; --test-crypto --cipher ${ciph=
er} ) &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    (&quot;${openvpn}&quot; --test-crypto --cipher ${cipher}) &g=
t;log=2E$$ 2&gt;&amp;1</span><br><span>     test_end $? log=2E$$</span><br>=
<span> done</span><br><span> </span><br><span>@@ -121,7 +123,7 @@</span><br=
><span>     &gt;log=2E$$ 2&gt;&amp;1</span><br><span> test_end $? log=2E$$<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [=
 &quot;$V&quot; -ge 1  ] ; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if [ &quot;$V&quot; -ge 1 ]; then</span><br><span>     echo &qu=
ot;$0: tests passed: $tests_passed  failed: $tests_failed&quot;</span><br><=
span> fi</span><br><span> </span><br><span>diff --git a/tests/t_net=2Esh b/=
tests/t_net=2Esh</span><br><span>index 8134832=2E=2Efbedb54 100755</span><b=
r><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span=
><br><span>@@ -9,7 +9,6 @@</span><br><span> top_builddir=3D&quot;${top_buil=
ddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_build=
dir}/src/openvpn/openvpn}&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> # bail out right away on non-=
linux=2E NetLink (the object of this test) is only</span><br><span> # used =
on Linux, therefore testing other platform is not needed=2E</span><br><span=
> #</span><br><span>@@ -31,8 +30,7 @@</span><br><span> </span><br><span> LA=
ST_STATE=3D$((${#GET_STATE[@]} - 1))</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-reload_dummy()</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+reload_dummy() {</span><br><span>     $RUN_SUDO ip link del $IFACE<=
/span><br><span>     $RUN_SUDO ip link add $IFACE address 00:11:22:33:44:55=
 type dummy</span><br><span>     $RUN_SUDO ip link set dev $IFACE state up<=
/span><br><span>@@ -43,8 +41,7 @@</span><br><span>     fi</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ru=
n_test()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+run_test() {</span><br><span>  =
   # run all test cases from 0 to $1 in sequence</span><br><span>     CMD=
=3D</span><br><span>     for k in $(seq 0 $1); do</span><br><span>@@ -69,7 =
+66,6 @@</span><br><span>     done</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> ## exec=
ution starts here</span><br><span> </span><br><span> # t_client=2Erc requir=
ed only for RUN_SUDO definition</span><br><span>@@ -89,21 +85,18 @@</span><=
br><span>     exit 77</span><br><span> fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # Ensure PREFER_KSU=
 is in a known state</span><br><span> PREFER_KSU=3D&quot;${PREFER_KSU:-0}&q=
uot;</span><br><span> </span><br><span> # make sure we have permissions to =
run the networking unit-test</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-ID=3D`id`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if ex=
pr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ID=3D$(id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :</span><br><s=
pan> else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ &qu=
ot;${PREFER_KSU}&quot; -eq 1 ];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; then</span><br><span>         # =
Check if we have a valid kerberos ticket</span><br><span>         klist -l =
1&gt;/dev/null 2&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if [ $? -ne 0 ];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if [ $? -ne 0 ]; then</span><br><span>             # No kerbero=
s ticket found, skip ksu and fallback to RUN_SUDO</span><br><span>         =
    PREFER_KSU=3D0</span><br><span>             echo &quot;$0: No Kerberos =
ticket available=2E  Will not use ksu=2E&quot;</span><br><span>@@ -112,16 +=
105,14 @@</span><br><span>         fi</span><br><span>     fi</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot=
;$RUN_SUDO&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &q=
uot;$RUN_SUDO&quot; ]; then</span><br><span>         echo &quot;$0: no RUN_=
SUDO=3D=2E=2E=2E in t_client=2Erc or environment, defaulting to &#39;sudo&#=
39;=2E&quot; &gt;&amp;2</span><br><span>         echo &quot;      if that d=
oes not work, set RUN_SUDO=3D correctly for your system=2E&quot; &gt;&amp;2=
</span><br><span>         RUN_SUDO=3D&quot;sudo&quot;</span><br><span>     =
fi</span><br><span> </span><br><span>     # check that we can run the unit-=
test binary with sudo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if $RUN_SUDO $UNIT_TEST test</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if $RUN_SUDO $UNIT_TEST test; then</span><br><span>         echo &quot;=
$0: $RUN_SUDO $UNIT_TEST succeeded, good=2E&quot;</span><br><span>     else=
</span><br><span>         echo &quot;$0: $RUN_SUDO $UNIT_TEST failed, canno=
t go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span>diff --git a/tests/t_se=
rver_null=2Esh b/tests/t_server_null=2Esh</span><br><span>index 74ffd52=2E=
=2Ec633614 100755</span><br><span>--- a/tests/t_server_null=2Esh</span><br>=
<span>+++ b/tests/t_server_null=2Esh</span><br><span>@@ -2,7 +2,7 @@</span>=
<br><span> #</span><br><span> TSERVER_NULL_SKIP_RC=3D&quot;${TSERVER_NULL_S=
KIP_RC:-77}&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-if ! [ -r &quot;=2E/t_server_null=2Erc&quot; ] ; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if ! [ -r &quot;=2E/t_serve=
r_null=2Erc&quot; ]; then</span><br><span>     echo &quot;${0}: cannot find=
 &#39;=2E/t_server_null=2Erc=2E SKIPPING TEST=2E&#39;&quot; &gt;&amp;2</spa=
n><br><span>     exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span> =
fi</span><br><span>@@ -22,11 +22,10 @@</span><br><span> # make sure we have=
 permissions to run ifconfig/route from OpenVPN</span><br><span> # can&#39;=
t use &quot;id -u&quot; here - doesn&#39;t work on Solaris</span><br><span>=
 ID=3D$(id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if expr &q=
uot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-then :</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null;=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    :</span><b=
r><span> else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [=
 &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; then</span><br><span>       =
  # Check if we have a valid kerberos ticket</span><br><span>         if kl=
ist -l 1&gt;/dev/null 2&gt;/dev/null; then</span><br><span>             RUN=
_SUDO=3D&quot;ksu -q -e&quot;</span><br><span>@@ -37,26 +36,24 @@</span><br=
><span>         fi</span><br><span>     fi</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$RUN_SUDO&quot; ]<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot;=
 ]; then</span><br><span>         echo &quot;${0}: this test must run be as=
 root, or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</span><br><span>         e=
cho &quot;      must be set correctly in &#39;t_server_null=2Erc&#39;=2E SK=
IP=2E&quot; &gt;&amp;2</span><br><span>         exit &quot;${TSERVER_NULL_S=
KIP_RC}&quot;</span><br><span>     else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	# Run a no-op command with privilege escalation (e=2Eg=
=2E sudo) so that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# w=
e (hopefully) do not have to ask the users password during the test=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	if $RUN_SUDO &quot;${KILL=
_EXEC}&quot; -0 $$</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;${0=
}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	    echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 failed, canno=
t go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	    exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        # Run a no-op command with privilege escalati=
on (e=2Eg=2E sudo) so that</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        # we (hopefully) do not have to ask the users password durin=
g the test=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if $RUN_SUDO &quot;${KILL_EXEC}&quot; -0 $$; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;${0}: $RUN_SUDO $K=
ILL_EXEC -0 succeeded, good=2E&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 failed, cann=
ot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><spa=
n>     fi</span><br><span> fi</span><br><span> </span><br><span> srcdir=3D&=
quot;${srcdir:-=2E}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-export t_server_null_logdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%H=
%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+export t_serve=
r_null_logdir=3Dt_server_null-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br>=
<span> </span><br><span> # Create directory for server and client logs</spa=
n><br><span> mkdir $t_server_null_logdir</span><br><span>diff --git a/tests=
/t_server_null_client=2Esh b/tests/t_server_null_client=2Esh</span><br><spa=
n>index 1745de5=2E=2E2741d5d 100755</span><br><span>--- a/tests/t_server_nu=
ll_client=2Esh</span><br><span>+++ b/tests/t_server_null_client=2Esh</span>=
<br><span>@@ -3,7 +3,7 @@</span><br><span> should_run_test() {</span><br><s=
pan>     test_name=3D&quot;$1&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;$test_name&quot;|grep -q =
_lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if e=
cho &quot;$test_name&quot; | grep -q _lwip; then</span><br><span>         i=
f [ &quot;$has_lwipovpn&quot; =3D &quot;no&quot; ]; then</span><br><span>  =
           return 1</span><br><span>         fi</span><br><span>@@ -48,7 +4=
8,7 @@</span><br><span> </span><br><span> ping_lwip_clients() {</span><br><=
span>     if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&quot; ]; then</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        lwip_client_count=3D=
$(echo &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; &quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_count=3D$(ec=
ho &quot;$lwip_test_names&quot; | wc -w | tr -d &quot; &quot;)</span><br><s=
pan>     else</span><br><span>         lwip_client_count=3D0</span><br><spa=
n>     fi</span><br><span>@@ -60,10 +60,10 @@</span><br><span>     count=3D=
0</span><br><span>     maxcount=3D10</span><br><span>     while [ $count -l=
e $maxcount ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    lwip_client_ips=3D$(cat =2E/*=2Elwip 2&gt;/dev/null|wc -l)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_ips=3D$(cat =
=2E/*=2Elwip 2&gt;/dev/null | wc -l)</span><br><span>         if [ $lwip_cl=
ient_ips -lt $lwip_client_count ]; then</span><br><span>             echo &=
quot;Waiting for LWIP clients to start up ($count/$maxcount)&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            count=3D$(( count =
+ 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
unt=3D$((count + 1))</span><br><span>             sleep 1</span><br><span> =
        else</span><br><span>             echo &quot;$lwip_client_ips/$lwip=
_client_count LWIP clients up&quot;</span><br><span>@@ -73,8 +73,8 @@</span=
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
/span><br><span>@@ -111,7 +111,7 @@</span><br><span>     should_pass=3D$2</=
span><br><span>     log=3D&quot;${test_name}=2Elog&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quot;Initial=
ization Sequence Completed&quot; &quot;${t_server_null_logdir}/${log}&quot;=
 &gt; /dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
grep &quot;Initialization Sequence Completed&quot; &quot;${t_server_null_lo=
gdir}/${log}&quot; &gt;/dev/null</span><br><span>     exit_code=3D$?</span>=
<br><span> </span><br><span>     if [ $exit_code -eq 0 ] &amp;&amp; [ &quot=
;${should_pass}&quot; =3D &quot;yes&quot; ]; then</span><br><span>@@ -144,7=
 +144,7 @@</span><br><span> server_max_wait=3D15</span><br><span> while [ $=
count -lt $server_max_wait ]; do</span><br><span>     servers_up=3D0</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    server_count=3D$(echo &q=
uot;$TEST_SERVER_LIST&quot;|wc -w|tr -d &quot; &quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    server_count=3D$(echo &quot;$TEST_SE=
RVER_LIST&quot; | wc -w | tr -d &quot; &quot;)</span><br><span> </span><br>=
<span>     # We need to trim single-quotes because some shells return quote=
d values</span><br><span>     # and some don&#39;t=2E Using &quot;set -o po=
six&quot; which would resolve this problem is</span><br><span>@@ -152,13 +1=
52,13 @@</span><br><span>     #</span><br><span>     # While inactive serve=
r configurations may get checked they won&#39;t increase</span><br><span>  =
   # the active server count as the processes won&#39;t be running=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for i in $(set|grep &#3=
9;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&quot;)=
; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pi=
d=3D$(cat &quot;$i=2Epid&quot; 2&gt; /dev/null)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if [ -z &quot;$server_pid&quot; ] ; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for i in $(set |=
 grep &#39;SERVER_NAME_&#39; | cut -d &quot;=3D&quot; -f 2 | tr -d &quot;[\=
&#39;]&quot;); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      server_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt;/dev/null)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;$server_pid=
&quot; ]; then</span><br><span>             continue</span><br><span>      =
   fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if $RUN_=
SUDO kill -0 $server_pid &gt; /dev/null 2&gt;&amp;1; then</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            servers_up=3D$(( $servers_u=
p + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
$RUN_SUDO kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            servers_up=3D$(($serv=
ers_up + 1))</span><br><span>         fi</span><br><span>     done</span><b=
r><span> </span><br><span>@@ -168,7 +168,7 @@</span><br><span>         retv=
al=3D0</span><br><span>         break</span><br><span>     else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        count=3D$(( count + 1))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        count=3D$((co=
unt + 1))</span><br><span>         sleep 1</span><br><span>     fi</span><b=
r><span> </span><br><span>@@ -199,15 +199,14 @@</span><br><span> # safe to =
check the test results=2E</span><br><span> test_names=3D&quot;&quot;</span>=
<br><span> lwip_test_names=3D&quot;&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     eval test_name=3D=
\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     eval client_exec=3D\&qu=
ot;\$CLIENT_EXEC_$SUF\&quot;</span><br><span>     eval client_conf=3D\&quot=
;\$CLIENT_CONF_$SUF\&quot;</span><br><span> </span><br><span>     test_name=
s=3D&quot;${test_names} ${test_name}&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;$test_name&quot;|g=
rep -q _lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if echo &quot;$test_name&quot; | grep -q _lwip; then</span><br><span>   =
      lwip_test_names=3D&quot;${lwip_test_names} ${test_name}&quot;</span><=
br><span>     fi</span><br><span> </span><br><span>@@ -219,13 +218,11 @@</s=
pan><br><span> ping_lwip_clients</span><br><span> retval=3D$?</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 # Wait until all OpenVPN clients have exited</span><br><span> (wait_for_re=
sults)</span><br><span> </span><br><span> # Check test results</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span> =
    eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     ev=
al should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</span><br><span> </span><=
br><span>diff --git a/tests/t_server_null_server=2Esh b/tests/t_server_null=
_server=2Esh</span><br><span>index 65b7d56=2E=2E327939a 100755</span><br><s=
pan>--- a/tests/t_server_null_server=2Esh</span><br><span>+++ b/tests/t_ser=
ver_null_server=2Esh</span><br><span>@@ -13,10 +13,10 @@</span><br><span> <=
/span><br><span>     # Try to launch the server</span><br><span>     $RUN_S=
UDO &quot;${server_exec}&quot; \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-               $server_conf \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-               --status &quot;${status}&quot; 1 \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-               --writepid &q=
uot;${pid}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
            --explicit-exit-notify 3 &gt; &quot;$log&quot; 2&gt;&amp;1 &amp=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        $server_co=
nf \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --statu=
s &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        --writepid &quot;${pid}&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        --explicit-exit-notify 3 &gt;&quot;$log=
&quot; 2&gt;&amp;1 &amp;</span><br><span> </span><br><span>     sleep 1</sp=
an><br><span> </span><br><span>@@ -40,8 +40,7 @@</span><br><span> retval=3D=
0</span><br><span> </span><br><span> # Launch test servers</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVER_LIST</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do</span><br><span=
>     eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span> =
    eval server_exec=3D\&quot;\$SERVER_EXEC_$SUF\&quot;</span><br><span>   =
  eval server_conf=3D\&quot;\$SERVER_CONF_$SUF\&quot;</span><br><span>@@ -5=
3,8 +52,7 @@</span><br><span> # the test run=2E</span><br><span> #</span><b=
r><span> export server_pid_files=3D&quot;&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVER_LIST</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do</span><br><span>     eval =
server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span>     server_=
pid_files=3D&quot;${server_pid_files} =2E/${server_name}=2Epid&quot;</span>=
<br><span> done</span><br><span>@@ -65,12 +63,11 @@</span><br><span> count=
=3D0</span><br><span> maxcount=3D4</span><br><span> while [ $count -le $max=
count ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ls =
t_server_null_client=2Esh*=2Epid &gt; /dev/null 2&gt;&amp;1</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if ls t_server_null_client=2Esh*=2Epid &gt;/=
dev/null 2&gt;&amp;1; then</span><br><span>         count=3D0</span><br><sp=
an>         sleep 1</span><br><span>     else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	count=3D$(( count + 1))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        count=3D$((count + 1))</span><br><span=
>         sleep 1</span><br><span>     fi</span><br><span> done</span><br><=
span>@@ -81,11 +78,10 @@</span><br><span> # server process does not exit in=
 15 seconds assume it never will, move on and</span><br><span> # hope for t=
he best=2E</span><br><span> echo &quot;Waiting for servers to exit&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-for PID_FILE in $server_=
pid_files</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+for PID_FILE in $server_pid_f=
iles; do</span><br><span>     SERVER_PID=3D$(cat &quot;${PID_FILE}&quot;)</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f [ -z &quot;$SERVER_PID&quot; ] ; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if [ -z &quot;$SERVER_PID&quot; ]; then</span><br><=
span>         echo &quot;WARNING: could not kill server ${PID_FILE}!&quot;<=
/span><br><span>         continue</span><br><span>     fi</span><br><span>@=
@ -95,17 +91,16 @@</span><br><span> </span><br><span>     count=3D0</span><=
br><span>     maxcount=3D75</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    while [ $count -le $maxcount ]</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        $RUN_SUDO kill -0 &quot;${SERVER_PID}&quot; 2&gt; /dev/null || =
break</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        count=3D=
$(( count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
while [ $count -le $maxcount ]; do</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        $RUN_SUDO kill -0 &quot;${SERVER_PID}&quot; 2&gt;/de=
v/null || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    count=3D$((count + 1))</span><br><span>         sleep 0=2E2</span><br><=
span>     done</span><br><span> </span><br><span>     # If server is still =
up send a SIGKILL</span><br><span>     if [ $count -ge $maxcount ]; then</s=
pan><br><span>         $RUN_SUDO $KILL_EXEC -9 &quot;${SERVER_PID}&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        SERVER_NAME=3D$(=
basename $PID_FILE|cut -d =2E -f 1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        SERVER_NAME=3D$(basename $PID_FILE | cut -d =2E -f =
1)</span><br><span>         echo &quot;ERROR: had to send SIGKILL to server=
 ${SERVER_NAME} with pid ${SERVER_PID}!&quot;</span><br><span>         echo=
 &quot;Tail of server log:&quot;</span><br><span>         tail -n 20 &quot;=
${t_server_null_logdir}/${SERVER_NAME}=2Elog&quot;</span><br><span>diff --g=
it a/tests/t_server_null_stress=2Esh b/tests/t_server_null_stress=2Esh</spa=
n><br><span>index 0bb9452=2E=2E2fc9fde 100755</span><br><span>--- a/tests/t=
_server_null_stress=2Esh</span><br><span>+++ b/tests/t_server_null_stress=
=2Esh</span><br><span>@@ -7,8 +7,7 @@</span><br><span> =2E =2E/t_server_nul=
l_default=2Erc</span><br><span> </span><br><span> export pid_files=3D&quot;=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TES=
T_SERVER_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_L=
IST; do</span><br><span>     eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&=
quot;</span><br><span>     pid_files=3D&quot;${pid_files} =2E/${server_name=
}=2Epid&quot;</span><br><span> done</span><br><span>@@ -18,16 +17,16 @@</sp=
an><br><span> </span><br><span> count=3D0</span><br><span> while [ $count -=
lt $ITERATIONS ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   count=3D$(( count + 1 ))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D &gt; /dev/null 2=
&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    count=
=3D$((count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D &gt;/dev/null 2&gt;&amp;=
1</span><br><span>     retval=3D$?</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo &quot;Iteration ${count}: return v=
alue ${retval}&quot; &gt;&gt; &quot;${LOG_BASEDIR}/make-check=2Elog&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;Iterat=
ion ${count}: return value ${retval}&quot; &gt;&gt;&quot;${LOG_BASEDIR}/mak=
e-check=2Elog&quot;</span><br><span>     if [ $retval -ne 0 ]; then</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	DIR=3D&quot;${LOG_BASEDIR}/m=
ake-check-${count}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        DIR=3D&quot;${LOG_BASEDIR}/make-check-${count}&quot;</span><br=
><span>         mkdir -p &quot;${DIR}&quot;</span><br><span>         cp t_s=
erver_null*=2Elog &quot;${DIR}/&quot;</span><br><span>         cp test-suit=
e=2Elog &quot;${DIR}/&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ps aux|grep openvpn|grep -vE &#39;(suppress|grep)&#39; &gt; &=
quot;${DIR}/psaux&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ps aux | grep openvpn | grep -vE &#39;(suppress|grep)&#39; &gt;=
&quot;${DIR}/psaux&quot;</span><br><span>     fi</span><br><span> done</spa=
n><br><span>diff --git a/tests/update_t_client_ips=2Esh b/tests/update_t_cl=
ient_ips=2Esh</span><br><span>index 96e3826=2E=2E777a286 100755</span><br><=
span>--- a/tests/update_t_client_ips=2Esh</span><br><span>+++ b/tests/updat=
e_t_client_ips=2Esh</span><br><span>@@ -5,12 +5,12 @@</span><br><span> </sp=
an><br><span> RC=3D&quot;$TOP_BUILDDIR/t_client_ips=2Erc&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep EXPECT_IFCO=
NFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt;/dev=
/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG4_$TESTNUM=
=3D$ifconfig_local&quot; &gt;&gt; $RC</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_loca=
l&quot; &gt;&gt;$RC</span><br><span> fi</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC &=
gt; /dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</span=
><br><span> if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local=
&quot; &gt;&gt; $RC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local&quot; &gt;&=
gt;$RC</span><br><span> fi</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">c=
hange 1793</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1793 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--BABN8j8lvKA=--


--===============5106228158672758641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5106228158672758641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5106228158672758641==--

