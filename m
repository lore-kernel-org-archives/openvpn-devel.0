Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F00C4453C
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCEqzugoWgAA50tzA6s/cTpTM10Ln462N+6RLanOaY0=; b=U5vXdnjs83Pdr4RPqda/y6NdC/
	Nqx0hciIFNKMdJ9T8WOl1vmFCO5nkRA8pk9A/8RLQ7+nuHEwfQwXIUBJ7M14l2X81xQj8MWs82RHt
	LAJjt/dHNA7qCMQ/7NXH+yubGiNgnQtfEUCMF/9r8Va2tuCP8OwKLbqeDmXKSvcrRncY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWjh-0002yE-5k;
	Wed, 22 Jul 2026 13:11:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWjf-0002y8-E3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TfPOepkrUy9b+j0WNJBj3mTKTMWJ3o/SO3KQp7M2T0U=; b=I8mmzwUq9arCjFfDwy74ZExTuX
 QYs33uUM9jzA1GA/k0oI2TtdAg76lnfCReORe/XWeZunELD4xzfmJWHqYQZt9RuUcdeNMjOzZkV1k
 Iqpw1y9NN+uQRL+aLgfOOWYZJM9MX0sqYOqwlEzo9WKQum1on/s1g/v/85HzA8YXLqIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TfPOepkrUy9b+j0WNJBj3mTKTMWJ3o/SO3KQp7M2T0U=; b=e
 PH6vru3V8gurcGz4V+MAQmFL5Xu44Aiay/slzyBJgDdVVU6P4r9JOzeZ9D78ykXNh+fF00/rWH/E2
 yRlOou3aFuYQJ+0HfV8erOgROy1EIa9VYqKIzCA894IsOlg1eV2BGfKOLI6qYuzJpJ70rSeGu/O0z
 1W/HRVKPVnPkYpVU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWjY-0006dh-Uh for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:44 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so96662335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784725890; x=1785330690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TfPOepkrUy9b+j0WNJBj3mTKTMWJ3o/SO3KQp7M2T0U=;
 b=CPsmGRvRZX0zDDg0ARWUtjQrmOoDxnh4lzfhOWOgSbB4k37j9ESNAsUnBLwU7EgDkh
 aFGkp9NEfn9AW8RKye78D/GJVosrOhqr26Jt35dfuTBeCEESwGNkiWd4jzjrP8EzPh7+
 m1/hxFYKBBmll/FKUiG9Gkia/gw1gDqBY5TxhSATVEcNozyDOq8ahFTRoegZ8gPjyXdk
 LIGphIvs2xyxSk8Gd8MEB5zsZVqY3fgsX8H98kj0RNR9P5EUs6pGvfVwjHV323FRo5VN
 JhR1LcYBO1H0q1zm4aTYrsvvgujPVKicZ791YLwDF4MSSJC76wiZP+Z02erDjqiY07fM
 Y4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725890; x=1785330690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TfPOepkrUy9b+j0WNJBj3mTKTMWJ3o/SO3KQp7M2T0U=;
 b=AF/cXIyrRn8spA6sXz+PoLdhNbfJK84DXhrONdqn9VEA1Bs8lL66upOujNflaARlvQ
 3n78D7mUXsSK2XEWgWwN542/FznZUlpEDtiBAg8ol7z0V9dwc0GwO7BxxC+TjekYSbt2
 CWNMddufc2Kig3LinQg7loLdcOl6GFgXw+Mumn9FC/IBZoO0Tue/fwdJw+mhYC7XL+q6
 qAk3bh8i/b2X1kKf16jeUWxWOi1yWgwiTCeYPwVThAQn64wc/g8WmKAr60Wf9lrESEpG
 9s32vJA5zKNYn9xjx4mvh/Bf4fRe5w/1nQerMT1KmPeA5oSPevsa+dAzCE0ZI+5a0SX8
 zGcA==
X-Gm-Message-State: AOJu0YzDlmbhWwUJuaw/8GhB6R2Iv0tPIJH0KyxsR+n2iP7gzmoHXCt+
 Z/PQ5ow5bXkdqFaeYHCojoOLfbw6P2WeGZgvMYR/0urRCBxBI1BPSVSBFulCfkHBXQCejGZ+3xq
 5gWjg9xJZfiB4LMkCTT842eMt2qEp52XdEGxLQBnTvfe6U3QT5I8+kCgFsp6zlnlp0KXW
X-Gm-Gg: AR+sD1130g0E7XkKbX6k/j+bhOgmgTJT9i1gg7UdehUjekRyIaE/msCT8n1PUdW+Z4e
 6RTwmux26DI2RagQxQFNOe99wnsHt5LIeImVoYMs+Y9B9gUjmFyuDdDD/X2yNJW29oHwHk2yRpL
 4AkzarSk8C9XB+RwlQ1k0in1H3i3SycM6IWbXqoGMnXJ8jasvSjPnCxlhJaWaE4v6U8R1I5LLYS
 fepoMWjB6ewGI/pJN3lvPVCTJAY7atUH1NhABLb569wIeeUjUaYMlmP3mOl0NyYxvOAEJHDFVjK
 6Ph0m5oZnVYwUSYug0rt7hZEXjzWO2bG76rUrOJWklLDSMyt3/yJ8JShV5Ac6sMbjNpyTqsGoXZ
 NQa/ZbNMAtjYzSAHhpXjJvL62J7Cy8Z3TgHKtaGt7G6BuYvknyGhtCI1re2pVsjRjPGVbl6dZf5
 Y+//CYIzZrUAlRTfu/Z7hg9d/ZG57GQVWDScODgRYYFXtTc2tfjMGQqO9N+G5NIZ67mPgRTguYV
 mGu2/IZVJkmDGdQ8trTQlm7qOs7VLjYYIEDz1jSS+IZYw7ti0Dju+a66Y0QrgeNxK+o
X-Received: by 2002:a05:600c:350f:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4954a3db7e8mr255137045e9.11.1784725889123; 
 Wed, 22 Jul 2026 06:11:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm6090835f8f.3.2026.07.22.06.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:11:28 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:11:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: d6338dda35d34883f1adeb1dd8c1e4e1686397b8
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5cd069224a54ac242899e6628124c45adb04f234-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWjY-0006dh-Uh
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
Content-Type: multipart/mixed; boundary="===============3921460981439108095=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3921460981439108095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JBN86vR/KqM="; charset=UTF-8

--JBN86vR/KqM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail

to look at the new patch=
 set (#2)=2E

The following approvals got outdated and were removed:
Code-R=
eview+1 by plaisthos


Change subject: Reformat all shell-scripts with shfm=
t
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
---
M dev-tools/gen-release-tarba=
lls=2Esh
M dev-tools/git-pre-commit-format=2Esh
M dev-tools/run-cppcheck=2E=
sh
M dev-tools/update-copyright=2Esh
M tests/lwip_client_up=2Esh
M tests/nu=
ll_client_up=2Esh
M tests/t_client=2Esh=2Ein
M tests/t_cltsrv=2Esh
M tests/=
t_lpback=2Esh
M tests/t_net=2Esh
M tests/t_server_null=2Esh
M tests/t_serve=
r_null_client=2Esh
M tests/t_server_null_server=2Esh
M tests/t_server_null_=
stress=2Esh
M tests/update_t_client_ips=2Esh
15 files changed, 412 insertio=
ns(+), 412 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/93/1793/2

diff --git a/dev-tools/gen-release-tarballs=2E=
sh b/dev-tools/gen-release-tarballs=2Esh
index 6071b57=2E=2E78104c4 100755
=
--- a/dev-tools/gen-release-tarballs=2Esh
+++ b/dev-tools/gen-release-tarba=
lls=2Esh
@@ -21,7 +21,7 @@
 if [ $# -ne 4 ]; then
     echo "Usage: $0 <rem=
ote-name> <tag-name> <sign-key> <dest-dir>"
     echo ""
-    echo "   remo=
te-name  -- valid remotes: `git remote | tr \\\n ' '`"
+    echo "   remote=
-name  -- valid remotes: $(git remote | tr \\n ' ')"
     echo "   tag-name=
     -- An existing release tag"
     echo "   sign-key     -- PGP key used=
 to sign all files"
     echo "   dest-dir     -- Where to put the complete=
 set of release tarballs"
@@ -48,7 +48,7 @@
 fi
 
 # Extract the git URL
-g=
iturl=3D"`git remote get-url $arg_remote_name 2>/dev/null`"
+giturl=3D"$(gi=
t remote get-url $arg_remote_name 2>/dev/null)"
 if [ $? -ne 0 ]; then
    =
 echo "** ERROR ** Invalid git remote name: $arg_remote_name"
     exit 2
@=
@ -58,10 +58,9 @@
 echo "test" | gpg -a --clearsign -u "$arg_sign_key" 2>/d=
ev/null 1>/dev/null
 if [ $? -ne 0 ]; then
     echo "** ERROR ** Failed wh=
en testing the PGP signing=2E  Wrong signing key?"
-    exit 2;
+    exit 2=

 fi
 
-
 #
 # Helper functions
 #
@@ -70,7 +69,7 @@
 {
     local wildcard=
=3D"$1"
 
-    res=3D"`find =2E -maxdepth 1 -type f -name \"$wildcard\" | h=
ead -n1 | cut -d/ -f2-`"
+    res=3D"$(find =2E -maxdepth 1 -type f -name \=
"$wildcard\" | head -n1 | cut -d/ -f2-)"
     if [ $? -ne 0 ]; then
       =
  echo "-- 'find' failed=2E"
         exit 5
@@ -87,7 +86,7 @@
     local f=
ileext=3D"$1"
     local dest=3D"$2"
 
-    file=3D"`get_filename openvpn-*=
=2E*=2E*=2E$fileext`"
+    file=3D"$(get_filename openvpn-*=2E*=2E*=2E$file=
ext)"
     if [ -z "$file" ]; then
         echo "** ERROR Failed to find s=
ource file"
         exit 5
@@ -96,7 +95,7 @@
     cp "$file" "$dest"
     =
if [ $? -ne 0 ]; then
         echo "** ERROR ** Failed to copy $file to $d=
estdir"
-        exit 3;
+        exit 3
     fi
 }
 
@@ -105,7 +104,7 @@
 =
    local signkey=3D"$1"
     local srchfile=3D"$2"
     local signtype=3D"=
$3"
-    local file=3D"`get_filename $srchfile`"
+    local file=3D"$(get_f=
ilename $srchfile)"
 
     echo "-- Signing $file =2E=2E=2E"
     case "$si=
gntype" in
@@ -126,16 +125,16 @@
 
         *)
             echo "** ERROR =
**  Unknown signing type \"$signtype\"=2E"
-            exit 4;
+          =
  exit 4
+            ;;
     esac
 
     if [ $res -ne 0 ]; then
         =
echo "** ERROR **  Failed to sign the file $PWD/$file"
-        exit 4;
+  =
      exit 4
     fi
 }
 
-
 #
 # Preparations
 #
@@ -146,7 +145,7 @@
     =
/*) # Absolute path
         destdir=3D"$arg_dest_dir/$arg_tag_name"
      =
   ;;
-    *)  # Make absolute path from relative path
+    *) # Make absol=
ute path from relative path
         destdir=3D"$PWD/$arg_dest_dir/$arg_tag=
_name"
         ;;
 esac
@@ -168,61 +167,61 @@
 #
 
 # Clone the remote rep=
ository
-workdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
+=
workdir=3D"$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
 cd $work=
dir
 echo "-- Working directory: $workdir"
 echo "-- git clone $giturl"
-gi=
t clone $giturl openvpn-gen-tarball 2> "$workdir/git-clone=2Elog" 1>&2
+git=
 clone $giturl openvpn-gen-tarball 2>"$workdir/git-clone=2Elog" 1>&2
 if [ =
$? -ne 0 ]; then
     echo "** ERROR **  git clone failed=2E  See $workdir/=
git-clone=2Elog for details"
-    exit 3;
+    exit 3
 fi
 cd openvpn-gen-t=
arball
 
 # Check out the proper release tag
 echo "-- Checking out tag $ar=
g_tag_name =2E=2E=2E "
-git checkout -b mkrelease "$arg_tag_name" 2> "$work=
dir/git-checkout-tag=2Elog" 1>&2
+git checkout -b mkrelease "$arg_tag_name"=
 2>"$workdir/git-checkout-tag=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     echo =
"** ERROR **  git checkout failed=2E  See $workdir/git-checkout-tag=2Elog f=
or details"
-    exit 3;
+    exit 3
 fi
 
 # Prepare the source tree
 echo=
 "-- Running autoreconf + a simple configure =2E=2E=2E "
-(autoreconf -vi &=
& =2E/configure) 2> "$workdir/autotools-prep=2Elog" 1>&2
+(autoreconf -vi &=
& =2E/configure) 2>"$workdir/autotools-prep=2Elog" 1>&2
 if [ $? -ne 0 ]; t=
hen
     echo "** ERROR **  Failed running autotools=2E  See $workdir/autot=
ools-prep=2Elog for details"
-    exit 3;
+    exit 3
 fi
 
 # Generate the=
 tar/zip files
 echo "-- Running make distcheck (generates =2Etar=2Egz) =2E=
=2E=2E "
-(make distcheck) 2> "$workdir/make-distcheck=2Elog" 1>&2
+(make d=
istcheck) 2>"$workdir/make-distcheck=2Elog" 1>&2
 if [ $? -ne 0 ]; then
   =
  echo "** ERROR **  make distcheck failed=2E  See $workdir/make-distcheck=
=2Elog for details"
-    exit 3;
+    exit 3
 fi
 copy_files tar=2Egz "$des=
tdir"
 
 echo "-- Running make dist-xz (generates =2Etar=2Exz) =2E=2E=2E "
=
-(make dist-xz) 2> "$workdir/make-dist-xz=2Elog" 1>&2
+(make dist-xz) 2>"$w=
orkdir/make-dist-xz=2Elog" 1>&2
 if [ $? -ne 0 ]; then
     echo "** ERROR =
**  make dist-xz failed=2E  See $workdir/make-dist-xz=2Elog for details"
- =
   exit 3;
+    exit 3
 fi
 copy_files tar=2Exz "$destdir"
 
 echo "-- Runn=
ing make dist-zip (generates =2Ezip) =2E=2E=2E "
-(make dist-zip) 2> "$work=
dir/make-dist-zip=2Elog" 1>&2
+(make dist-zip) 2>"$workdir/make-dist-zip=2E=
log" 1>&2
 if [ $? -ne 0 ]; then
     echo "** ERROR **  make dist-zip fail=
ed=2E  See $workdir/make-dist-zip=2Elog for details"
-    exit 3;
+    exit=
 3
 fi
 copy_files zip "$destdir"
 
 # Generate SHA256 checksums
 cd "$dest=
dir"
-sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip > "openvpn-$arg_t=
ag_name=2Esha256sum"
+sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip >=
"openvpn-$arg_tag_name=2Esha256sum"
 
 # Sign all the files
 echo "-- Signi=
ng files =2E=2E=2E "
diff --git a/dev-tools/git-pre-commit-format=2Esh b/de=
v-tools/git-pre-commit-format=2Esh
index 9b2ecaf=2E=2E3507289 100755
--- a/=
dev-tools/git-pre-commit-format=2Esh
+++ b/dev-tools/git-pre-commit-format=
=2Esh
@@ -26,7 +26,6 @@
 # OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARIS=
ING IN ANY WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE P=
OSSIBILITY OF SUCH DAMAGE=2E
 
-
 # git pre-commit hook that runs a stylech=
eck=2E
 # Features:
 #  - abort commit when commit does not comply with the=
 style guidelines
@@ -43,12 +42,11 @@
 # exit on error
 set -e
 
-
 # If ca=
lled so, install this script as pre-commit hook
-if [ "$1" =3D "install" ] =
; then
+if [ "$1" =3D "install" ]; then
     TARGET=3D"$(git rev-parse --gi=
t-path hooks)/pre-commit"
 
-    if [ -e "$TARGET" ] ; then
+    if [ -e "$=
TARGET" ]; then
         printf "$TARGET file exists=2E Won't overwrite=2E\=
n"
         printf "Aborting installation=2E\n"
         exit 1
@@ -62,18 +=
60,19 @@
 fi
 
 # check whether the given file matches any of the set exten=
sions
-matches_extension() {
+matches_extension()
+{
     local filename=3D=
"$(basename -- "$1")"
     local extension=3D"=2E${filename##*=2E}"
     lo=
cal ext
 
-    for ext in =2Ec =2Eh ; do [ "$ext" =3D "$extension" ] && ret=
urn 0; done
+    for ext in =2Ec =2Eh; do [ "$ext" =3D "$extension" ] && re=
turn 0; done
 
     return 1
 }
 
 # necessary check for initial commit
-if=
 git rev-parse --verify HEAD >/dev/null 2>&1 ; then
+if git rev-parse --ver=
ify HEAD >/dev/null 2>&1; then
     against=3DHEAD
 else
     # Initial com=
mit: diff against an empty tree object
@@ -88,8 +87,8 @@
 
     # Allow to =
use in parallel with pre-commit
     if [ $(basename "$0") =3D "pre-commit=
=2Elegacy" ]; then
-       echo "Skipping clang-format check in favor of pr=
e-commit"
-       exit 0
+        echo "Skipping clang-format check in favo=
r of pre-commit"
+        exit 0
     fi
 else
     TOOL=3Duncrustify
@@ -9=
8,7 +97,7 @@
     TOOL_CMD=3D"$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
 
     =
# make sure the config file is correctly set
-    if [ ! -f "$UNCRUST_CONFI=
G" ] ; then
+    if [ ! -f "$UNCRUST_CONFIG" ]; then
         printf "Error=
: uncrustify config file not found=2E\n"
         printf "Expected to find =
it at $UNCRUST_CONFIG=2E\n"
         printf "Aborting commit=2E\n"
@@ -106,=
7 +105,7 @@
     fi
 fi
 
-if [ -z "$TOOL_BIN" ] ; then
+if [ -z "$TOOL_BIN=
" ]; then
     printf "Error: $TOOL executable not found=2E\n"
     printf =
"Is it installed and in your \$PATH?\n"
     printf "Aborting commit=2E\n"
=
@@ -120,44 +119,43 @@
 # create one patch containing all changes to the fil=
es
 # sed to remove quotes around the filename, if inserted by the system
 =
# (done sometimes, if the filename contains special characters, like the qu=
ote itself)
-git diff-index --cached --diff-filter=3DACMR --name-only $agai=
nst -- | \
-sed -e 's/^"\(=2E*\)"$/\1/' | \
-while read file
-do
-    # ign=
ore file if we do check for file extensions and the file
-    # does not ma=
tch the extensions =2Ec or =2Eh
-    if ! matches_extension "$file"; then
-=
        continue;
-    fi
+git diff-index --cached --diff-filter=3DACMR --n=
ame-only $against -- |
+    sed -e 's/^"\(=2E*\)"$/\1/' |
+    while read f=
ile; do
+        # ignore file if we do check for file extensions and the f=
ile
+        # does not match the extensions =2Ec or =2Eh
+        if ! mat=
ches_extension "$file"; then
+            continue
+        fi
 
-    # esc=
ape special characters in the target filename:
-    # phase 1 (characters e=
scaped in the output diff):
-    #     - '\': backslash needs to be escaped=
 in the output diff
-    #     - '"': quote needs to be escaped in the outp=
ut diff if present inside
-    #            of the filename, as it used to =
bracket the entire filename part
-    # phase 2 (characters escaped in the =
match replacement):
-    #     - '\': backslash needs to be escaped again f=
or sed itself
-    #            (i=2Ee=2E double escaping after phase 1)
- =
   #     - '&': would expand to matched string
-    #     - '|': used as se=
d split char instead of '/'
-    # printf %s particularly important if the =
filename contains the % character
-    file_escaped_target=3D$(printf "%s" =
"$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
+        # escape speci=
al characters in the target filename:
+        # phase 1 (characters escape=
d in the output diff):
+        #     - '\': backslash needs to be escaped =
in the output diff
+        #     - '"': quote needs to be escaped in the o=
utput diff if present inside
+        #            of the filename, as it u=
sed to bracket the entire filename part
+        # phase 2 (characters esca=
ped in the match replacement):
+        #     - '\': backslash needs to be =
escaped again for sed itself
+        #            (i=2Ee=2E double escapin=
g after phase 1)
+        #     - '&': would expand to matched string
+    =
    #     - '|': used as sed split char instead of '/'
+        # printf %s=
 particularly important if the filename contains the % character
+        f=
ile_escaped_target=3D$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\=
&|]/\\&/g')
 
-    # uncrustify our sourcefile, create a patch with diff an=
d append it to our $patch
-    # The sed call is necessary to transform the=
 patch from
-    #    --- - timestamp
-    #    +++ $tmpout timestamp
-    =
# to both lines working on the same file and having a a/ and b/ prefix=2E
-=
    # Else it can not be applied with 'git apply'=2E
-    git show ":$file"=
 | $TOOL_CMD > "$tmpout"
-    git show ":$file" | diff -u -- - "$tmpout" | =
\
-        sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tm=
pout|+++ \"a/$file_escaped_target\"|" >> "$patch"
-done
+        # uncrusti=
fy our sourcefile, create a patch with diff and append it to our $patch
+  =
      # The sed call is necessary to transform the patch from
+        #   =
 --- - timestamp
+        #    +++ $tmpout timestamp
+        # to both lin=
es working on the same file and having a a/ and b/ prefix=2E
+        # Els=
e it can not be applied with 'git apply'=2E
+        git show ":$file" | $T=
OOL_CMD >"$tmpout"
+        git show ":$file" | diff -u -- - "$tmpout" |
+ =
           sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tm=
pout|+++ \"a/$file_escaped_target\"|" >>"$patch"
+    done
 
 rm -f "$tmpou=
t"
 
 # if no patch has been generated all is ok, clean up the file stub an=
d exit
-if [ ! -s "$patch" ] ; then
+if [ ! -s "$patch" ]; then
     rm -f =
"$patch"
     exit 0
 fi
@@ -165,7 +163,7 @@
 # a patch has been created, n=
otify the user and exit
 printf "Formatting of some code does not follow th=
e project guidelines=2E\n"
 
-if [ $(wc -l < $patch) -gt 80 ] ; then
+if [ =
$(wc -l <$patch) -gt 80 ]; then
     printf "The file $patch contains the n=
ecessary fixes=2E\n"
 else
     printf "Here's the patch that fixes the for=
matting:\n\n"
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppc=
heck=2Esh
index 40db33e=2E=2Ea7aa3c4 100755
--- a/dev-tools/run-cppcheck=2E=
sh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -20,24 +20,23 @@
  --check-level=3D=
exhaustive --max-configs=3D10 \
  --error-exitcode=3D1"
 
-
 set -x
 
 mkdi=
r -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
 cppcheck $COMMON_ARGS $INCLUDE_FL=
AGS \
-         --platform=3Dunix64 \
-         --library=3Dposix=2Ecfg --l=
ibrary=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \
-         -U_WIN32 \
-         s=
rc/openvpn/ src/compat/ src/plugins/ sample/ \
-         tests/unit_tests/e=
xample_test/ tests/unit_tests/openvpn/ \
-         tests/unit_tests/plugins=
/
+    --platform=3Dunix64 \
+    --library=3Dposix=2Ecfg --library=3Dbsd=
=2Ecfg --library=3Dgnu=2Ecfg \
+    -U_WIN32 \
+    src/openvpn/ src/compat=
/ src/plugins/ sample/ \
+    tests/unit_tests/example_test/ tests/unit_tes=
ts/openvpn/ \
+    tests/unit_tests/plugins/
 cppcheck $COMMON_ARGS \
-    =
     --platform=3Dwin64 \
-         --library=3Dwindows=2Ecfg \
-         -=
D_WIN32 \
-         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARG=
ET_NETBSD \
-         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UT=
ARGET_DRAGONFLY \
-         -UTARGET_AIX \
-         src/openvpn* src/compa=
t/ \
-         tests/unit_tests/example_test/ tests/unit_tests/openvpn*
+  =
  --platform=3Dwin64 \
+    --library=3Dwindows=2Ecfg \
+    -D_WIN32 \
+  =
  -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+    -=
UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+    =
-UTARGET_AIX \
+    src/openvpn* src/compat/ \
+    tests/unit_tests/exampl=
e_test/ tests/unit_tests/openvpn*
diff --git a/dev-tools/update-copyright=
=2Esh b/dev-tools/update-copyright=2Esh
index 96546dd=2E=2E7ca6002 100755
-=
-- a/dev-tools/update-copyright=2Esh
+++ b/dev-tools/update-copyright=2Esh
=
@@ -34,8 +34,7 @@
 COPY_YEAR=3D"$1"
 
 cd "$(git rev-parse --show-toplevel)=
"
-for file in $(git ls-files | grep -v vendor/);
-do
+for file in $(git ls=
-files | grep -v vendor/); do
     echo -n "Updating $file =2E=2E=2E"
     =
# The first sed operation covers 20xx-20yy copyright lines,
     # The seco=
nd sed operation changes 20xx -> 20xx-20yy
diff --git a/tests/lwip_client_u=
p=2Esh b/tests/lwip_client_up=2Esh
index a6b4d24=2E=2Eb1941a4 100755
--- a/=
tests/lwip_client_up=2Esh
+++ b/tests/lwip_client_up=2Esh
@@ -2,16 +2,17 @@=

 #
 # Determine the OpenVPN PID from its pid file=2E This works reliably e=
ven when
 # the OpenVPN process is backgrounded for parallel tests=2E
-MY_P=
PID=3D`cat $pid`
+MY_PPID=3D$(cat $pid)
 
 # Add this client's VPN IP and P=
ID to a file=2E This enables
 # t_server_null_client=2Esh to kill this Open=
VPN client after fping tests have
 # finished=2E
-echo "$ifconfig_local,$MY=
_PPID" >> =2E/$test_name=2Elwip
+echo "$ifconfig_local,$MY_PPID" >>=2E/$tes=
t_name=2Elwip
 
 # Wait long enough to allow fping tests to finish=2E Also =
ensure that this
 # OpenVPN client is killed even if t_server_null_client=
=2Esh failed to do it=2E
-(sleep 15
-echo "ERROR: t_server_null_client=2Esh=
 failed to kill OpenVPN client with PID $MY_PPID in test $test_name=2E Kill=
ing it in lwip_client_up=2Esh=2E"
-kill -15 $MY_PPID
+(
+    sleep 15
+    =
echo "ERROR: t_server_null_client=2Esh failed to kill OpenVPN client with P=
ID $MY_PPID in test $test_name=2E Killing it in lwip_client_up=2Esh=2E"
+  =
  kill -15 $MY_PPID
 ) &
diff --git a/tests/null_client_up=2Esh b/tests/nul=
l_client_up=2Esh
index d4df0c6=2E=2Ebe339ee 100755
--- a/tests/null_client_=
up=2Esh
+++ b/tests/null_client_up=2Esh
@@ -4,8 +4,11 @@
 
 # Determine the=
 OpenVPN PID from its pid file=2E This works reliably even when
 # the Open=
VPN process is backgrounded for parallel tests=2E
-MY_PPID=3D`cat $pid`
+MY=
_PPID=3D$(cat $pid)
 
 # Allow OpenVPN to finish initializing while waiting=
 in the background and then
 # killing the process gracefully=2E
-(sleep 5 =
; kill -15 $MY_PPID) &
+(
+    sleep 5
+    kill -15 $MY_PPID
+) &
diff --g=
it a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 7233187=2E=
=2E98cabde 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=
=2Ein
@@ -19,9 +19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_b=
uilddir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvp=
n}"
-if [ -r "${top_builddir}"/t_client=2Erc ] ; then
+if [ -r "${top_build=
dir}"/t_client=2Erc ]; then
     =2E "${top_builddir}"/t_client=2Erc
-elif =
[ -r "${srcdir}"/t_client=2Erc ] ; then
+elif [ -r "${srcdir}"/t_client=2Er=
c ]; then
     =2E "${srcdir}"/t_client=2Erc
 else
     echo "$0: cannot fi=
nd 't_client=2Erc' in build dir ('${top_builddir}')" >&2
@@ -32,37 +32,35 @=
@
 # Check for external dependencies
 FPING=3D"fping"
 FPING6=3D"fping6"
-w=
hich fping > /dev/null
+which fping >/dev/null
 if [ $? -ne 0 ]; then
     =
echo "$0: fping is not available in \$PATH" >&2
     exit "${TCLIENT_SKIP_R=
C}"
 fi
-which fping6 > /dev/null
+which fping6 >/dev/null
 if [ $? -ne 0 ]=
; then
     echo "$0: fping6 is not available in \$PATH, assuming fping 4=
=2E0 or later" >&2
     FPING=3D"fping -4"
     FPING6=3D"fping -6"
 fi
 
-=
KILL_EXEC=3D`which kill`
+KILL_EXEC=3D$(which kill)
 if [ $? -ne 0 ]; then
=
     echo "$0: kill not found in \$PATH" >&2
     exit "${TCLIENT_SKIP_RC}"=

 fi
 
-if [ ! -x "${openvpn}" ]
-then
+if [ ! -x "${openvpn}" ]; then
    =
 echo "no (executable) openvpn binary in current build tree=2E FAIL=2E" >&2=

     exit 1
 fi
 
-if [ ! -w =2E ]
-then
+if [ ! -w =2E ]; then
     echo =
"current directory is not writable (required for logging)=2E FAIL=2E" >&2
 =
    exit 1
 fi
 
-if [ -z "$TEST_RUN_LIST" ] ; then
+if [ -z "$TEST_RUN_LIS=
T" ]; then
     echo "TEST_RUN_LIST empty, no tests defined=2E  SKIP test=
=2E" >&2
     exit "${TCLIENT_SKIP_RC}"
 fi
@@ -72,16 +70,14 @@
 
 # make s=
ure we have permissions to run ifconfig/route from OpenVPN
 # can't use "id=
 -u" here - doesn't work on Solaris
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >=
/dev/null
-then :
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+=
    :
 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFE=
R_KSU}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
 =
        klist -l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-       =
 then
+        if [ $? -ne 0 ]; then
             # No kerberos ticket foun=
d, skip ksu and fallback to RUN_SUDO
             PREFER_KSU=3D0
          =
   echo "$0: No Kerberos ticket available=2E  Will not use ksu=2E"
@@ -90,8=
 +86,7 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    i=
f [ -z "$RUN_SUDO" ]; then
         echo "$0: this test must run be as root=
, or RUN_SUDO=3D=2E=2E=2E " >&2
         echo "      must be set correctly =
in 't_client=2Erc'=2E SKIP=2E" >&2
         exit "${TCLIENT_SKIP_RC}"
@@ -9=
9,19 +94,18 @@
         # We have to use sudo=2E Make sure that we (hopeful=
ly) do not have
         # to ask the users password during the test=2E Thi=
s is done to
         # prevent timing issues, e=2Eg=2E when the waits for =
openvpn to start
-	if $RUN_SUDO $KILL_EXEC -0 $$
-	then
-	    echo "$0: $RU=
N_SUDO $KILL_EXEC -0 succeeded, good=2E"
-	else
-	    echo "$0: $RUN_SUDO $=
KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
-	    exit "${TCLIENT_SKI=
P_RC}"
-	fi
+        if $RUN_SUDO $KILL_EXEC -0 $$; then
+            echo =
"$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
+        else
+           =
 echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
+  =
          exit "${TCLIENT_SKIP_RC}"
+        fi
     fi
 fi
 
-LOGDIR=3Dt_c=
lient-`hostname`-`date +%Y%m%d-%H%M%S`
-if mkdir $LOGDIR
-then :
+LOGDIR=3D=
t_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
+if mkdir $LOGDIR; then
+    :
=
 else
     echo "can't create log directory '$LOGDIR'=2E FAIL=2E" >&2
     =
exit 1
@@ -131,22 +125,29 @@
 output_start()
 {
     case $V in
-	0) outbuf=
=3D"" ;;			# no per-test output at all
-	1) echo -e "$@"			# compact, detai=
ls only on failure
-           outbuf=3D"\n" ;;
-	*) echo -e "\n$@\n" ;;		#=
 print all, with a bit formatting
+        0) outbuf=3D"" ;; # no per-test =
output at all
+        1)
+            echo -e "$@" # compact, details only=
 on failure
+            outbuf=3D"\n"
+            ;;
+        *) echo -e =
"\n$@\n" ;; # print all, with a bit formatting
     esac
 }
 
 output()
 {
=
-    NO_NL=3D''; if [ "X$1" =3D "X-n" ] ; then NO_NL=3D$1 ; shift ; fi
+   =
 NO_NL=3D''
+    if [ "X$1" =3D "X-n" ]; then
+        NO_NL=3D$1
+        =
shift
+    fi
     case $V in
-	0) ;;				# no per-test output at all
-	1) o=
utbuf=3D"$outbuf$@" 		# print details only on failure
-	   test -z "$NO_NL"=
 && outbuf=3D"$outbuf\n"
-           ;;
-	*) echo -e $NO_NL "$@" ;;	# print=
 everything
+        0) ;; # no per-test output at all
+        1)
+       =
     outbuf=3D"$outbuf$@" # print details only on failure
+            test=
 -z "$NO_NL" && outbuf=3D"$outbuf\n"
+            ;;
+        *) echo -e $N=
O_NL "$@" ;; # print everything
     esac
 }
 
@@ -154,62 +155,61 @@
 fail(=
)
 {
     output "FAIL: $@\n"
-    fail_count=3D$(( $fail_count + 1 ))
+   =
 fail_count=3D$(($fail_count + 1))
 }
 
 # print "all interface IP addresse=
s" + "all routes"
 # this is higly system dependent=2E=2E=2E
 get_ifconfig_=
route()
 {
-    UNAME=3D`uname -s`
+    UNAME=3D$(uname -s)
     case $UNAM=
E in
-	Linux)
+        Linux)
             # linux / iproute2? (-> if confi=
gure got a path)
-            if [ -n "@IPROUTE@" ]
-            then
+    =
        if [ -n "@IPROUTE@" ]; then
                 echo "-- linux iproute=
2 --"
-                @IPROUTE@ addr show     | grep -v valid_lft
+       =
         @IPROUTE@ addr show | grep -v valid_lft
                 @IPROUTE@=
 route show
                 @IPROUTE@ -o -6 route show | grep -v ' cache' =
| sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0=
-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
             else
-	        echo =
"-- linux / ifconfig --"
-	        LANG=3DC @IFCONFIG@ -a |egrep  "( addr:|=
encap:)"
-	        LANG=3DC @NETSTAT@ -rn -4 -6
+                echo "-- l=
inux / ifconfig --"
+                LANG=3DC @IFCONFIG@ -a | egrep "( addr=
:|encap:)"
+                LANG=3DC @NETSTAT@ -rn -4 -6
             fi
  =
           ;;
-	FreeBSD|NetBSD|Darwin)
-	   echo "-- FreeBSD/NetBSD/Darwin =
[MacOS X] --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -=
rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	OpenBSD)
-	   echo=
 "-- OpenBSD --"
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)" | \
-		sed -e=
 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
-	   @NETSTAT@ -rn | awk '$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }'
-	   ;;
-	SunOS)
-	   echo "-- Solaris --"
=
-	   @IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !=
~ /^UHL/ { print $1,$2,$3,$6 }'
-	   ;;
-	AIX)
-	   echo "-- AIX --"
-	   @=
IFCONFIG@ -a | egrep "(flags=3D|inet)"
-	   @NETSTAT@ -rn | awk '$3 !~ /^UH=
L/ { print $1,$2,$3,$6 }'
-	   ;;
+        FreeBSD | NetBSD | Darwin)
+    =
        echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+            @IFCONFIG=
@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^UH=
L/ { print $1,$2,$3,$NF }'
+            ;;
+        OpenBSD)
+            e=
cho "-- OpenBSD --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)" |
=
+                sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
+       =
     @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
+           =
 ;;
+        SunOS)
+            echo "-- Solaris --"
+            @IFCONFI=
G@ -a | egrep "(flags=3D|inet)"
+            @NETSTAT@ -rn | awk '$3 !~ /^U=
HL/ { print $1,$2,$3,$6 }'
+            ;;
+        AIX)
+            echo =
"-- AIX --"
+            @IFCONFIG@ -a | egrep "(flags=3D|inet)"
+         =
   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
+            ;;=

         *)
-           echo "get_ifconfig_route(): no idea how to get inf=
o on your OS (`uname -s`)=2E  FAIL=2E" >&2
-           exit 20
-           =
;;
+            echo "get_ifconfig_route(): no idea how to get info on your=
 OS ($(uname -s))=2E  FAIL=2E" >&2
+            exit 20
+            ;;
   =
  esac
 
     # another round of per-platform information gathering, for DN=
S info
     # for most of the platforms "cat /etc/resolv=2Econf" is good en=
ough
     # except Linux and MacOS
     case $UNAME in
-	Linux)
-          =
  if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then
+        L=
inux)
+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ];=
 then
                 echo "-- linux resolvectl --"
                 resol=
vectl status
             else
@@ -217,7 +217,7 @@
                 cat /et=
c/resolv=2Econf
             fi
             ;;
-	Darwin)
+        Darwin)
=
             echo "-- MacOS scutil --dns"
             scutil --dns
       =
      ;;
@@ -234,19 +234,19 @@
 #  arg2: IPv4/IPv6 address that must show u=
p in out of "get_ifconfig_route"
 check_ifconfig()
 {
-    proto=3D$1 ; shi=
ft
+    proto=3D$1
+    shift
     expect_list=3D"$@"
 
-    if [ -z "$expe=
ct_list" ] ; then return ; fi
-    if [ "$expect_list" =3D "-" ] ; then ret=
urn ; fi
+    if [ -z "$expect_list" ]; then return; fi
+    if [ "$expect_=
list" =3D "-" ]; then return; fi
 
-    for expect in $expect_list
-    do
=
-	if get_ifconfig_route | fgrep "$expect" >/dev/null
-	then :
-	else
-	    =
fail "check_ifconfig(): expected IPv$proto address '$expect' not found in i=
fconfig output=2E"
-	fi
+    for expect in $expect_list; do
+        if get=
_ifconfig_route | fgrep "$expect" >/dev/null; then
+            :
+        =
else
+            fail "check_ifconfig(): expected IPv$proto address '$expe=
ct' not found in ifconfig output=2E"
+        fi
     done
 }
 
@@ -257,47 =
+257,48 @@
 #  arg3=2E=2E=2E -> fping arguments (host list)
 run_ping_tests=
()
 {
-    proto=3D$1 ; want=3D$2 ; shift ; shift
+    proto=3D$1
+    want=
=3D$2
+    shift
+    shift
     targetlist=3D"$@"
 
     # "no targets" is=
 fine
-    if [ -z "$targetlist" ] ; then return ; fi
+    if [ -z "$target=
list" ]; then return; fi
 
     case $proto in
-	4) cmd=3D"$FPING" ;;
-	6) =
cmd=3D"$FPING6" ;;
-	*) echo "internal error in run_ping_tests arg 1: '$pro=
to'" >&2
-	   exit 1 ;;
+        4) cmd=3D"$FPING" ;;
+        6) cmd=3D"$F=
PING6" ;;
+        *)
+            echo "internal error in run_ping_tests a=
rg 1: '$proto'" >&2
+            exit 1
+            ;;
     esac
 
     ca=
se $want in
-	want_ok)   sizes_list=3D"64 1440 3000" ;;
-	want_fail) sizes_=
list=3D"64" ;;
+        want_ok) sizes_list=3D"64 1440 3000" ;;
+        wa=
nt_fail) sizes_list=3D"64" ;;
     esac
 
-    for bytes in $sizes_list
-  =
  do
-	output "run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=
=2E"
+    for bytes in $sizes_list; do
+        output "run IPv$proto ping =
tests ($want), $bytes byte packets=2E=2E=2E"
 
-	echo "$cmd -b $bytes -C 20=
 -p 250 -q $fping_args $targetlist" >>$LOGDIR/$SUF:fping=2Eout
-	$cmd -b $b=
ytes -C 20 -p 250 -q $fping_args $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&=
1
+        echo "$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist" >>=
$LOGDIR/$SUF:fping=2Eout
+        $cmd -b $bytes -C 20 -p 250 -q $fping_arg=
s $targetlist >>$LOGDIR/$SUF:fping=2Eout 2>&1
 
-	# while OpenVPN is runnin=
g, pings must succeed (want=3D'want_ok')
-	# before OpenVPN is up, pings mu=
st NOT succeed (want=3D'want_fail')
+        # while OpenVPN is running, pi=
ngs must succeed (want=3D'want_ok')
+        # before OpenVPN is up, pings =
must NOT succeed (want=3D'want_fail')
 
-	rc=3D$?
-	if [ $rc =3D 0 ] 				# =
all ping OK
-	then
-	    if [ $want =3D "want_fail" ]		# not what we want
-=
	    then
-		fail "IPv$proto ping test succeeded, but needs to *fail*=2E"
-=
	    fi
-	else					# ping failed
-	    if [ $want =3D "want_ok" ]		# not wh=
at we wanted
-	    then
-		fail "IPv$proto ping test ($bytes bytes) failed,=
 but should succeed=2E"
-	    fi
-	fi
+        rc=3D$?
+        if [ $rc =
=3D 0 ]; then                 # all ping OK
+            if [ $want =3D "wa=
nt_fail" ]; then # not what we want
+                fail "IPv$proto ping t=
est succeeded, but needs to *fail*=2E"
+            fi
+        else       =
                        # ping failed
+            if [ $want =3D "want_ok"=
 ]; then # not what we wanted
+                fail "IPv$proto ping test ($=
bytes bytes) failed, but should succeed=2E"
+            fi
+        fi
   =
  done
 }
 
@@ -308,8 +309,7 @@
 SUMMARY_SKIP=3D
 SUMMARY_FAIL=3D
 
-for SU=
F in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     # get config va=
riables
     eval test_prep=3D\"\$PREPARE_$SUF\"
     eval test_check_skip=
=3D\"\$CHECK_SKIP_$SUF\"
@@ -336,11 +336,13 @@
 
     if [ -n "$test_check_=
skip" ]; then
         output "check whether we need to skip: '$test_check_=
skip'"
-        if eval $test_check_skip; then :
+        if eval $test_che=
ck_skip; then
+            :
         else
             output "skip check =
failed, SKIP test $SUF=2E"
-	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
-	    =
echo -e "$outbuf" ; continue
+            SUMMARY_SKIP=3D"$SUMMARY_SKIP $SU=
F"
+            echo -e "$outbuf"
+            continue
         fi
     fi=

 
@@ -355,13 +357,14 @@
     output "\nrun pre-openvpn ping tests - target=
s must not be reachable=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_h=
osts"
     run_ping_tests 6 want_fail "$ping6_hosts"
-    if [ "$fail_count=
" =3D 0 ] ; then
+    if [ "$fail_count" =3D 0 ]; then
         output "OK=
=2E\n"
     else
-	fail "make sure that ping hosts are ONLY reachable via V=
PN, SKIP test $SUF=2E"
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D=
31
-	echo -e "$outbuf" ; continue
+        fail "make sure that ping hosts =
are ONLY reachable via VPN, SKIP test $SUF=2E"
+        SUMMARY_FAIL=3D"$SU=
MMARY_FAIL $SUF"
+        exit_code=3D31
+        echo -e "$outbuf"
+      =
  continue
     fi
 
     pidfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-=
$SUF=2Epid"
@@ -376,18 +379,17 @@
     # to $ovpn_init_check times=2E
     =
ovpn_init_check=3D30
     ovpn_init_success=3D0
-    while [ $ovpn_init_che=
ck -gt 0 ];
-    do
-       sleep 1  # Wait for OpenVPN to initialize and h=
ave had time to write the pid file
-       grep "Initialization Sequence Co=
mpleted" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ]; the=
n
-           ovpn_init_check=3D0
-           ovpn_init_success=3D1
-      =
 fi
-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
+    while [ $ovp=
n_init_check -gt 0 ]; do
+        sleep 1 # Wait for OpenVPN to initialize =
and have had time to write the pid file
+        grep "Initialization Seque=
nce Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+        if [ $? -eq 0=
 ]; then
+            ovpn_init_check=3D0
+            ovpn_init_success=3D=
1
+        fi
+        ovpn_init_check=3D$(($ovpn_init_check - 1))
     don=
e
 
-    opid=3D`cat $pidfile`
+    opid=3D$(cat $pidfile)
     if [ -n "$o=
pid" ]; then
         output "  OpenVPN running with PID $opid"
     else
@=
@ -398,16 +400,17 @@
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; th=
en
         output "$0:  OpenVPN did not initialize in a reasonable time"
 =
        if [ -n "$opid" ]; then
-           $RUN_SUDO $KILL_EXEC $opid
+   =
         $RUN_SUDO $KILL_EXEC $opid
         fi
         $RUN_SUDO $KILL_EX=
EC $sudopid
-	output "tail -5 $SUF:openvpn=2Elog"
-	output "`tail -5 $LOGDI=
R/$SUF:openvpn=2Elog`"
-	fail "skip rest of sub-tests for test run $SUF=2E"=

-	trap - 0 1 2 3 15
-	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30=

-	echo -e "$outbuf" ; continue
+        output "tail -5 $SUF:openvpn=2Elog=
"
+        output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+        fail "sk=
ip rest of sub-tests for test run $SUF=2E"
+        trap - 0 1 2 3 15
+    =
    SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+        exit_code=3D30
+        ec=
ho -e "$outbuf"
+        continue
     fi
 
     # make sure openvpn client=
 is terminated in case shell exits
@@ -418,17 +421,16 @@
     output "save =
ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route=2Etxt
=
 
-    if [ "$expect_ifconfig4" =3D "-" ] ; then
+    if [ "$expect_ifconfi=
g4" =3D "-" ]; then
         output "skip ifconfig+route check"
     else
-=
	output -n "compare pre-openvpn ifconfig+route with current values=2E=2E=2E=
"
-	if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
-		$LOGDIR/$SUF:ifconfi=
g_route=2Etxt >/dev/null
-	then
-	    fail "no differences between ifconfig=
/route before OpenVPN start and now=2E"
-	else
-	    output " OK!\n"
-	fi
+=
        output -n "compare pre-openvpn ifconfig+route with current values=
=2E=2E=2E"
+        if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \
+      =
      $LOGDIR/$SUF:ifconfig_route=2Etxt >/dev/null; then
+            fail =
"no differences between ifconfig/route before OpenVPN start and now=2E"
+  =
      else
+            output " OK!\n"
+        fi
     fi
 
     # post i=
nit script needed?
@@ -449,8 +451,8 @@
     $RUN_SUDO $KILL_EXEC $opid
    =
 wait $!
     rc=3D$?
-    if [ $rc !=3D 0 ] ; then
-	fail "OpenVPN return =
code $rc, expect 0"
+    if [ $rc !=3D 0 ]; then
+        fail "OpenVPN ret=
urn code $rc, expect 0"
     fi
 
     output "\nsave post-openvpn ifconfig=
 + route=2E=2E=2E"
@@ -458,23 +460,22 @@
 
     output -n "compare pre- and=
 post-openvpn ifconfig + route=2E=2E=2E"
     if diff $LOGDIR/$SUF:ifconfig=
_route_pre=2Etxt \
-	    $LOGDIR/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$S=
UF:ifconfig_route_diff=2Etxt
-    then
-	output " OK=2E\n"
+        $LOGDIR=
/$SUF:ifconfig_route_post=2Etxt >$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; th=
en
+        output " OK=2E\n"
     else
-	output "\n\n" "`cat $LOGDIR/$SUF:=
ifconfig_route_diff=2Etxt`" "\n"
-	fail "differences between pre- and post-=
ifconfig/route=2E"
+        output "\n\n" "$(cat $LOGDIR/$SUF:ifconfig_rout=
e_diff=2Etxt)" "\n"
+        fail "differences between pre- and post-ifconf=
ig/route=2E"
     fi
-    if [ "$fail_count" =3D 0 ] ; then
+    if [ "$fai=
l_count" =3D 0 ]; then
         output "test run $SUF: all tests OK=2E\n"
-=
	SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+        SUMMARY_OK=3D"$SUMMARY_OK $SUF"
 =
    else
-	if [ "$V" -gt 0 ] ; then
-	    echo -e -n "$outbuf"
-	    echo -=
e "test run $SUF: $fail_count test failures=2E FAIL=2E\n"
+        if [ "$V=
" -gt 0 ]; then
+            echo -e -n "$outbuf"
+            echo -e "tes=
t run $SUF: $fail_count test failures=2E FAIL=2E\n"
         fi
-	SUMMARY_F=
AIL=3D"$SUMMARY_FAIL $SUF"
-	exit_code=3D30
+        SUMMARY_FAIL=3D"$SUMMA=
RY_FAIL $SUF"
+        exit_code=3D30
     fi
 
     if [ -n "$test_cleanup=
" ]; then
@@ -484,9 +485,9 @@
 
 done
 
-if [ -z "$SUMMARY_OK" ] ; then SUM=
MARY_OK=3D" none"; fi
-if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" no=
ne"; fi
-if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D" none"; fi
+if [ =
-z "$SUMMARY_OK" ]; then SUMMARY_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP" =
]; then SUMMARY_SKIP=3D" none"; fi
+if [ -z "$SUMMARY_FAIL" ]; then SUMMARY=
_FAIL=3D" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK=2E"
 echo "Test =
sets skipped:$SUMMARY_SKIP=2E"
 echo "Test sets failed:$SUMMARY_FAIL=2E"
di=
ff --git a/tests/t_cltsrv=2Esh b/tests/t_cltsrv=2Esh
index 6b7df65=2E=2E03c=
3845 100755
--- a/tests/t_cltsrv=2Esh
+++ b/tests/t_cltsrv=2Esh
@@ -24,50 +=
24,58 @@
 trap "rm -f log=2E$$ log=2E$$=2Esignal ; trap 0 ; exit 77" 1 2 15=

 trap "rm -f log=2E$$ log=2E$$=2Esignal ; exit 1" 0 3
 addopts=3D
-case `u=
name -s` in
+case $(uname -s) in
     FreeBSD)
-    # FreeBSD jails map the=
 outgoing IP to the jail IP - we need to
-    # allow the real IP unless we=
 want the test to run forever=2E
-    if test "`sysctl 2>/dev/null -n secur=
ity=2Ejail=2Ejailed`" =3D 1 \
-    || ps -ostate=3D -p $$ | grep -q J; then=

-	addopts=3D"--float"
-	if test "x`ifconfig | grep inet`" =3D x ; then
-	 =
   echo "###"
-	    echo "### To run the test in a FreeBSD jail, you MUST a=
dd an IP alias for the jail's IP=2E"
-	    echo "###"
-	    exit 77
-	fi
- =
   fi
-    ;;
+        # FreeBSD jails map the outgoing IP to the jail IP -=
 we need to
+        # allow the real IP unless we want the test to run for=
ever=2E
+        if test "$(sysctl 2>/dev/null -n security=2Ejail=2Ejailed)=
" =3D 1 ||
+            ps -ostate=3D -p $$ | grep -q J; then
+            =
addopts=3D"--float"
+            if test "x$(ifconfig | grep inet)" =3D x; =
then
+                echo "###"
+                echo "### To run the test=
 in a FreeBSD jail, you MUST add an IP alias for the jail's IP=2E"
+       =
         echo "###"
+                exit 77
+            fi
+        fi
+ =
       ;;
 esac
 
 # make sure that the --down script is executable -- fail=
 (rather than
 # skip) test if it isn't=2E
 downscript=3D"=2E=2E/tests/t_cl=
tsrv-down=2Esh"
 root=3D"${top_srcdir}/sample"
-test -x "${root}/${downscri=
pt}" || chmod +x "${root}/${downscript}" || { echo >&2 "${root}/${downscrip=
t} is not executable, failing=2E" ; exit 1 ; }
+test -x "${root}/${downscri=
pt}" || chmod +x "${root}/${downscript}" || {
+    echo >&2 "${root}/${down=
script} is not executable, failing=2E"
+    exit 1
+}
 echo "The following =
test will take about two minutes=2E" >&2
 echo "If the addresses are in use=
, this test will retry up to two times=2E" >&2
 
 # go
 success=3D0
-for i =
in 1 2 3 ; do
-  set +e
-  (
-  "${openvpn}" --script-security 2 --cd "${ro=
ot}" ${addopts} --setenv role srv --down "${downscript}" --tls-exit --ping-=
exit 180 --config "sample-config-files/loopback-server" &
-  "${openvpn}" -=
-script-security 2 --cd "${top_srcdir}/sample" ${addopts} --setenv role clt=
 --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-config-=
files/loopback-client"
-  ) 3>log=2E$$=2Esignal >log=2E$$ 2>&1
-  e1=3D$?
-=
  wait $!
-  e2=3D$?
-  grep 'TCP/UDP: Socket bind failed on local address=
=2E*in use' log=2E$$ >/dev/null && {
-    echo 'address in use, retrying in=
 150 s'
-    sleep 150
-    continue
-  }
-  grep -v ':inactive$' log=2E$$=
=2Esignal >/dev/null && { cat log=2E$$=2Esignal ; echo ; cat log=2E$$ ; exi=
t 1 ; }
-  success=3D1
-  break
+for i in 1 2 3; do
+    set +e
+    (
+   =
     "${openvpn}" --script-security 2 --cd "${root}" ${addopts} --setenv ro=
le srv --down "${downscript}" --tls-exit --ping-exit 180 --config "sample-c=
onfig-files/loopback-server" &
+        "${openvpn}" --script-security 2 --=
cd "${top_srcdir}/sample" ${addopts} --setenv role clt --down "${downscript=
}" --tls-exit --ping-exit 180 --config "sample-config-files/loopback-client=
"
+    ) 3>log=2E$$=2Esignal >log=2E$$ 2>&1
+    e1=3D$?
+    wait $!
+    =
e2=3D$?
+    grep 'TCP/UDP: Socket bind failed on local address=2E*in use' =
log=2E$$ >/dev/null && {
+        echo 'address in use, retrying in 150 s'
=
+        sleep 150
+        continue
+    }
+    grep -v ':inactive$' log=
=2E$$=2Esignal >/dev/null && {
+        cat log=2E$$=2Esignal
+        echo=

+        cat log=2E$$
+        exit 1
+    }
+    success=3D1
+    break
 =
done
 
 set -e
@@ -75,14 +83,14 @@
 # exit code - defaults to 0, PASS
 ec=
=3D0
 
-if [ $success !=3D 1 ] ; then
-  # couldn't run test -- addresses i=
n use, skip test
-  cat log=2E$$
-  ec=3D77
-elif [ $e1 !=3D 0 ] || [ $e2 !=
=3D 0 ] ; then
-  # failure -- fail test
-  cat log=2E$$
-  ec=3D1
+if [ $s=
uccess !=3D 1 ]; then
+    # couldn't run test -- addresses in use, skip te=
st
+    cat log=2E$$
+    ec=3D77
+elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; t=
hen
+    # failure -- fail test
+    cat log=2E$$
+    ec=3D1
 fi
 
 rm log=
=2E$$ log=2E$$=2Esignal
diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=
=2Esh
index 6802506=2E=2E058206f 100755
--- a/tests/t_lpback=2Esh
+++ b/tes=
ts/t_lpback=2Esh
@@ -37,51 +37,56 @@
 test_start()
 {
     case $V in
-    =
    0) outbuf=3D"" ;;                  # no per-test output at all
-       =
 1) outbuf=3D"$@" ;;                # compact, details only on failure
-   =
     *) printf "$@" ;;                # print all
+        0) outbuf=3D"" ;=
;   # no per-test output at all
+        1) outbuf=3D"$@" ;; # compact, det=
ails only on failure
+        *) printf "$@" ;; # print all
     esac
 }
 t=
est_end()
 {
-    RC=3D$1 ; LOG=3D$2
-    if [ $RC !=3D 0 ]
-    then
+    =
RC=3D$1
+    LOG=3D$2
+    if [ $RC !=3D 0 ]; then
         case $V in
-   =
         0) ;;                                # no per-test output
-       =
     1) echo "$outbuf" "FAIL (RC=3D$RC)"; cat $LOG ;;
-            *) echo =
"FAIL (RC=3D$RC)"; cat $LOG ;;
+            0) ;; # no per-test output
+   =
         1)
+                echo "$outbuf" "FAIL (RC=3D$RC)"
+            =
    cat $LOG
+                ;;
+            *)
+                echo "FAI=
L (RC=3D$RC)"
+                cat $LOG
+                ;;
         esac
 =
        e=3D1
-        tests_failed=3D$(( $tests_failed + 1 ))
+        tes=
ts_failed=3D$(($tests_failed + 1))
     else
         case $V in
-         =
   0|1) ;;                              # no per-test output for 'OK'
-    =
        *) echo "OK"                         # print all
+            0 | 1=
) ;;       # no per-test output for 'OK'
+            *) echo "OK" ;; # pri=
nt all
         esac
-        tests_passed=3D$(( $tests_passed + 1 ))
+    =
    tests_passed=3D$(($tests_passed + 1))
     fi
 }
 
 # if running with V=
=3D1, give an indication what test runs now
-if [ "$V" =3D 1  ] ; then
+if =
[ "$V" =3D 1 ]; then
     echo "$0: running with V=3D$V, only printing test=
 fails"
 fi
 
-
 # Get list of supported ciphers from openvpn --show-cipher=
s output
-CIPHERS=3D$(${openvpn} --show-ciphers | \
-            sed -e '/T=
he following/,/^$/d' -e s'/ =2E*//' -e '/^[[:space:]]*$/d')
+CIPHERS=3D$(${=
openvpn} --show-ciphers |
+    sed -e '/The following/,/^$/d' -e s'/ =2E*//=
' -e '/^[[:space:]]*$/d')
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 =
implementation of OpenSSL is
 # broken (see http://rt=2Eopenssl=2Eorg/Ticke=
t/Display=2Ehtml?id=3D2867), so exclude
 # that cipher from this test=2E
 #=
 GD, 2014-07-06 so is DES-CFB1
 # GD, 2014-07-06 do not test RC5-* either (=
fails on NetBSD w/o libcrypto_rc5)
-CIPHERS=3D$(echo "$CIPHERS" | egrep -v =
'^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
+CIPHERS=3D$(echo "$CIPHERS" | egrep -v =
'^(DES-EDE3-CFB1|DES-CFB1|RC5-)')
 
 e=3D0
-if [ -z "$CIPHERS" ] ; then
+if=
 [ -z "$CIPHERS" ]; then
     echo "'openvpn --show-ciphers' FAILED (empty =
list)"
     e=3D1
 fi
@@ -91,10 +96,9 @@
 
 set +e
 
-for cipher in ${CIPHE=
RS}
-do
+for cipher in ${CIPHERS}; do
     test_start "Testing cipher ${cip=
her}=2E=2E=2E "
-    ( "${openvpn}" --test-crypto --cipher ${cipher} ) >log=
=2E$$ 2>&1
+    ("${openvpn}" --test-crypto --cipher ${cipher}) >log=2E$$ 2=
>&1
     test_end $? log=2E$$
 done
 
@@ -121,7 +125,7 @@
     >log=2E$$ 2>=
&1
 test_end $? log=2E$$
 
-if [ "$V" -ge 1  ] ; then
+if [ "$V" -ge 1 ]; t=
hen
     echo "$0: tests passed: $tests_passed  failed: $tests_failed"
 fi
=
 
diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh
index 8134832=2E=2E17e02=
8e 100755
--- a/tests/t_net=2Esh
+++ b/tests/t_net=2Esh
@@ -9,7 +9,6 @@
 to=
p_builddir=3D"${top_builddir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddi=
r}/src/openvpn/openvpn}"
 
-
 # bail out right away on non-linux=2E NetLink=
 (the object of this test) is only
 # used on Linux, therefore testing othe=
r platform is not needed=2E
 #
@@ -69,7 +68,6 @@
     done
 }
 
-
 ## execu=
tion starts here
 
 # t_client=2Erc required only for RUN_SUDO definition
@=
@ -89,21 +87,18 @@
     exit 77
 fi
 
-
 # Ensure PREFER_KSU is in a known =
state
 PREFER_KSU=3D"${PREFER_KSU:-0}"
 
 # make sure we have permissions t=
o run the networking unit-test
-ID=3D`id`
-if expr "$ID" : "uid=3D0" >/dev/=
null
-then :
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null; then
+    :=

 else
-    if [ "${PREFER_KSU}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU=
}" -eq 1 ]; then
         # Check if we have a valid kerberos ticket
      =
   klist -l 1>/dev/null 2>/dev/null
-        if [ $? -ne 0 ];
-        then=

+        if [ $? -ne 0 ]; then
             # No kerberos ticket found, sk=
ip ksu and fallback to RUN_SUDO
             PREFER_KSU=3D0
             ec=
ho "$0: No Kerberos ticket available=2E  Will not use ksu=2E"
@@ -112,16 +1=
07,14 @@
         fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if=
 [ -z "$RUN_SUDO" ]; then
         echo "$0: no RUN_SUDO=3D=2E=2E=2E in t_c=
lient=2Erc or environment, defaulting to 'sudo'=2E" >&2
         echo "    =
  if that does not work, set RUN_SUDO=3D correctly for your system=2E" >&2
=
         RUN_SUDO=3D"sudo"
     fi
 
     # check that we can run the unit-=
test binary with sudo
-    if $RUN_SUDO $UNIT_TEST test
-    then
+    if $=
RUN_SUDO $UNIT_TEST test; then
         echo "$0: $RUN_SUDO $UNIT_TEST succ=
eeded, good=2E"
     else
         echo "$0: $RUN_SUDO $UNIT_TEST failed, c=
annot go on=2E SKIP=2E" >&2
diff --git a/tests/t_server_null=2Esh b/tests/t=
_server_null=2Esh
index 74ffd52=2E=2Ec633614 100755
--- a/tests/t_server_nu=
ll=2Esh
+++ b/tests/t_server_null=2Esh
@@ -2,7 +2,7 @@
 #
 TSERVER_NULL_SKI=
P_RC=3D"${TSERVER_NULL_SKIP_RC:-77}"
 
-if ! [ -r "=2E/t_server_null=2Erc" =
] ; then
+if ! [ -r "=2E/t_server_null=2Erc" ]; then
     echo "${0}: canno=
t find '=2E/t_server_null=2Erc=2E SKIPPING TEST=2E'" >&2
     exit "${TSERV=
ER_NULL_SKIP_RC}"
 fi
@@ -22,11 +22,10 @@
 # make sure we have permissions =
to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work=
 on Solaris
 ID=3D$(id)
-if expr "$ID" : "uid=3D0" >/dev/null
-then :
+if e=
xpr "$ID" : "uid=3D0" >/dev/null; then
+    :
 else
-    if [ "${PREFER_KSU=
}" -eq 1 ];
-    then
+    if [ "${PREFER_KSU}" -eq 1 ]; then
         # Ch=
eck if we have a valid kerberos ticket
         if klist -l 1>/dev/null 2>/=
dev/null; then
             RUN_SUDO=3D"ksu -q -e"
@@ -37,26 +36,24 @@
    =
     fi
     fi
 
-    if [ -z "$RUN_SUDO" ]
-    then
+    if [ -z "$RUN_S=
UDO" ]; then
         echo "${0}: this test must run be as root, or RUN_SUD=
O=3D=2E=2E=2E " >&2
         echo "      must be set correctly in 't_server=
_null=2Erc'=2E SKIP=2E" >&2
         exit "${TSERVER_NULL_SKIP_RC}"
     el=
se
-	# Run a no-op command with privilege escalation (e=2Eg=2E sudo) so tha=
t
-	# we (hopefully) do not have to ask the users password during the test=
=2E
-	if $RUN_SUDO "${KILL_EXEC}" -0 $$
-	then
-	    echo "${0}: $RUN_SUDO =
$KILL_EXEC -0 succeeded, good=2E"
-	else
-	    echo "${0}: $RUN_SUDO $KILL_=
EXEC -0 failed, cannot go on=2E SKIP=2E" >&2
-	    exit "${TSERVER_NULL_SKI=
P_RC}"
-	fi
+        # Run a no-op command with privilege escalation (e=2Eg=
=2E sudo) so that
+        # we (hopefully) do not have to ask the users pa=
ssword during the test=2E
+        if $RUN_SUDO "${KILL_EXEC}" -0 $$; then
=
+            echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E"
+     =
   else
+            echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go =
on=2E SKIP=2E" >&2
+            exit "${TSERVER_NULL_SKIP_RC}"
+        fi
=
     fi
 fi
 
 srcdir=3D"${srcdir:-=2E}"
-export t_server_null_logdir=3Dt_s=
erver_null-`hostname`-`date +%Y%m%d-%H%M%S`
+export t_server_null_logdir=3D=
t_server_null-$(hostname)-$(date +%Y%m%d-%H%M%S)
 
 # Create directory for =
server and client logs
 mkdir $t_server_null_logdir
diff --git a/tests/t_se=
rver_null_client=2Esh b/tests/t_server_null_client=2Esh
index 1745de5=2E=2E=
3203cc2 100755
--- a/tests/t_server_null_client=2Esh
+++ b/tests/t_server_n=
ull_client=2Esh
@@ -1,9 +1,10 @@
 #!/bin/sh
 
-should_run_test() {
+should_=
run_test()
+{
     test_name=3D"$1"
 
-    if echo "$test_name"|grep -q _lw=
ip; then
+    if echo "$test_name" | grep -q _lwip; then
         if [ "$ha=
s_lwipovpn" =3D "no" ]; then
             return 1
         fi
@@ -12,7 +13=
,8 @@
     return 0
 }
 
-launch_client() {
+launch_client()
+{
     test_n=
ame=3D$1
     log=3D"${test_name}=2Elog"
     pid=3D"${test_name}=2Epid"
@@=
 -30,7 +32,8 @@
         --log "${t_server_null_logdir}/${log}" &
 }
 
-pin=
g_and_kill() {
+ping_and_kill()
+{
     if fping -q -c 5 $1; then
         =
echo "PASS: fping lwipovpn client $target"
     else
@@ -46,9 +49,10 @@
   =
  kill -15 $2
 }
 
-ping_lwip_clients() {
+ping_lwip_clients()
+{
     if [=
 "$has_lwipovpn" =3D "yes" ]; then
-        lwip_client_count=3D$(echo "$lw=
ip_test_names"|wc -w|tr -d " ")
+        lwip_client_count=3D$(echo "$lwip_=
test_names" | wc -w | tr -d " ")
     else
         lwip_client_count=3D0
 =
    fi
@@ -60,10 +64,10 @@
     count=3D0
     maxcount=3D10
     while [ $=
count -le $maxcount ]; do
-        lwip_client_ips=3D$(cat =2E/*=2Elwip 2>/=
dev/null|wc -l)
+        lwip_client_ips=3D$(cat =2E/*=2Elwip 2>/dev/null |=
 wc -l)
         if [ $lwip_client_ips -lt $lwip_client_count ]; then
     =
        echo "Waiting for LWIP clients to start up ($count/$maxcount)"
-   =
         count=3D$(( count + 1))
+            count=3D$((count + 1))
      =
       sleep 1
         else
             echo "$lwip_client_ips/$lwip_clie=
nt_count LWIP clients up"
@@ -73,8 +77,8 @@
 
     wait_pids=3D""
     for =
line in $(cat =2E/*=2Elwip 2>/dev/null); do
-        target_ip=3D$(echo $li=
ne|cut -d "," -f 1)
-        client_pid=3D$(echo $line|cut -d "," -f 2)
+  =
      target_ip=3D$(echo $line | cut -d "," -f 1)
+        client_pid=3D$(e=
cho $line | cut -d "," -f 2)
         ping_and_kill $target_ip $client_pid =
&
         wait_pids=3D"$wait_pids $!"
     done
@@ -84,7 +88,8 @@
     tes=
t -e =2E/lwip_failed && return 1 || return 0
 }
 
-wait_for_results() {
+wa=
it_for_results()
+{
     tests_running=3D"yes"
 
     # Wait a bit to allow=
 an OpenVPN client process to create a pidfile to
@@ -106,12 +111,13 @@
   =
  done
 }
 
-get_client_test_result() {
+get_client_test_result()
+{
     t=
est_name=3D$1
     should_pass=3D$2
     log=3D"${test_name}=2Elog"
 
-    =
grep "Initialization Sequence Completed" "${t_server_null_logdir}/${log}" >=
 /dev/null
+    grep "Initialization Sequence Completed" "${t_server_null_l=
ogdir}/${log}" >/dev/null
     exit_code=3D$?
 
     if [ $exit_code -eq 0 =
] && [ "${should_pass}" =3D "yes" ]; then
@@ -144,7 +150,7 @@
 server_max_w=
ait=3D15
 while [ $count -lt $server_max_wait ]; do
     servers_up=3D0
-  =
  server_count=3D$(echo "$TEST_SERVER_LIST"|wc -w|tr -d " ")
+    server_co=
unt=3D$(echo "$TEST_SERVER_LIST" | wc -w | tr -d " ")
 
     # We need to t=
rim single-quotes because some shells return quoted values
     # and some =
don't=2E Using "set -o posix" which would resolve this problem is
@@ -152,1=
3 +158,13 @@
     #
     # While inactive server configurations may get che=
cked they won't increase
     # the active server count as the processes wo=
n't be running=2E
-    for i in $(set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2=
|tr -d "[\']"); do
-        server_pid=3D$(cat "$i=2Epid" 2> /dev/null)
-  =
      if [ -z "$server_pid" ] ; then
+    for i in $(set | grep 'SERVER_NAM=
E_' | cut -d "=3D" -f 2 | tr -d "[\']"); do
+        server_pid=3D$(cat "$i=
=2Epid" 2>/dev/null)
+        if [ -z "$server_pid" ]; then
             co=
ntinue
         fi
-        if $RUN_SUDO kill -0 $server_pid > /dev/null 2>=
&1; then
-            servers_up=3D$(( $servers_up + 1 ))
+        if $RUN_=
SUDO kill -0 $server_pid >/dev/null 2>&1; then
+            servers_up=3D$(=
($servers_up + 1))
         fi
     done
 
@@ -168,7 +174,7 @@
         ret=
val=3D0
         break
     else
-        count=3D$(( count + 1))
+        =
count=3D$((count + 1))
         sleep 1
     fi
 
@@ -199,15 +205,14 @@
 # =
safe to check the test results=2E
 test_names=3D""
 lwip_test_names=3D""
-f=
or SUF in $TEST_RUN_LIST
-do
+for SUF in $TEST_RUN_LIST; do
     eval test_=
name=3D\"\$TEST_NAME_$SUF\"
     eval client_exec=3D\"\$CLIENT_EXEC_$SUF\"
=
     eval client_conf=3D\"\$CLIENT_CONF_$SUF\"
 
     test_names=3D"${test_=
names} ${test_name}"
 
-    if echo "$test_name"|grep -q _lwip; then
+    i=
f echo "$test_name" | grep -q _lwip; then
         lwip_test_names=3D"${lwi=
p_test_names} ${test_name}"
     fi
 
@@ -219,13 +224,11 @@
 ping_lwip_clie=
nts
 retval=3D$?
 
-
 # Wait until all OpenVPN clients have exited
 (wait_f=
or_results)
 
 # Check test results
-for SUF in $TEST_RUN_LIST
-do
+for SUF=
 in $TEST_RUN_LIST; do
     eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval=
 should_pass=3D\"\$SHOULD_PASS_$SUF\"
 
diff --git a/tests/t_server_null_se=
rver=2Esh b/tests/t_server_null_server=2Esh
index 65b7d56=2E=2E0297740 1007=
55
--- a/tests/t_server_null_server=2Esh
+++ b/tests/t_server_null_server=
=2Esh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
-launch_server() {
+launch_server()
+{
 =
    server_name=3D$1
     server_exec=3D$2
     server_conf=3D$3
@@ -13,10 =
+14,10 @@
 
     # Try to launch the server
     $RUN_SUDO "${server_exec}"=
 \
-               $server_conf \
-               --status "${status}" 1 \
=
-               --writepid "${pid}" \
-               --explicit-exit-notif=
y 3 > "$log" 2>&1 &
+        $server_conf \
+        --status "${status}" 1=
 \
+        --writepid "${pid}" \
+        --explicit-exit-notify 3 >"$log"=
 2>&1 &
 
     sleep 1
 
@@ -40,8 +41,7 @@
 retval=3D0
 
 # Launch test ser=
vers
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
  =
   eval server_name=3D\"\$SERVER_NAME_$SUF\"
     eval server_exec=3D\"\$SE=
RVER_EXEC_$SUF\"
     eval server_conf=3D\"\$SERVER_CONF_$SUF\"
@@ -53,8 +5=
3,7 @@
 # the test run=2E
 #
 export server_pid_files=3D""
-for SUF in $TES=
T_SERVER_LIST
-do
+for SUF in $TEST_SERVER_LIST; do
     eval server_name=
=3D\"\$SERVER_NAME_$SUF\"
     server_pid_files=3D"${server_pid_files} =2E/=
${server_name}=2Epid"
 done
@@ -65,12 +64,11 @@
 count=3D0
 maxcount=3D4
 w=
hile [ $count -le $maxcount ]; do
-    if ls t_server_null_client=2Esh*=2Ep=
id > /dev/null 2>&1
-    then
+    if ls t_server_null_client=2Esh*=2Epid >=
/dev/null 2>&1; then
         count=3D0
         sleep 1
     else
-	count=
=3D$(( count + 1))
+        count=3D$((count + 1))
         sleep 1
     fi=

 done
@@ -81,11 +79,10 @@
 # server process does not exit in 15 seconds as=
sume it never will, move on and
 # hope for the best=2E
 echo "Waiting for =
servers to exit"
-for PID_FILE in $server_pid_files
-do
+for PID_FILE in $s=
erver_pid_files; do
     SERVER_PID=3D$(cat "${PID_FILE}")
 
-    if [ -z "=
$SERVER_PID" ] ; then
+    if [ -z "$SERVER_PID" ]; then
         echo "WAR=
NING: could not kill server ${PID_FILE}!"
         continue
     fi
@@ -95,=
17 +92,16 @@
 
     count=3D0
     maxcount=3D75
-    while [ $count -le $m=
axcount ]
-    do
-        $RUN_SUDO kill -0 "${SERVER_PID}" 2> /dev/null |=
| break
-        count=3D$(( count + 1))
+    while [ $count -le $maxcount =
]; do
+        $RUN_SUDO kill -0 "${SERVER_PID}" 2>/dev/null || break
+    =
    count=3D$((count + 1))
         sleep 0=2E2
     done
 
     # If serve=
r is still up send a SIGKILL
     if [ $count -ge $maxcount ]; then
       =
  $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
-        SERVER_NAME=3D$(basename=
 $PID_FILE|cut -d =2E -f 1)
+        SERVER_NAME=3D$(basename $PID_FILE | c=
ut -d =2E -f 1)
         echo "ERROR: had to send SIGKILL to server ${SERVE=
R_NAME} with pid ${SERVER_PID}!"
         echo "Tail of server log:"
      =
   tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}=2Elog"
diff --git a/t=
ests/t_server_null_stress=2Esh b/tests/t_server_null_stress=2Esh
index 0bb9=
452=2E=2E2fc9fde 100755
--- a/tests/t_server_null_stress=2Esh
+++ b/tests/t=
_server_null_stress=2Esh
@@ -7,8 +7,7 @@
 =2E =2E/t_server_null_default=2Er=
c
 
 export pid_files=3D""
-for SUF in $TEST_SERVER_LIST
-do
+for SUF in $T=
EST_SERVER_LIST; do
     eval server_name=3D\"\$SERVER_NAME_$SUF\"
     pid=
_files=3D"${pid_files} =2E/${server_name}=2Epid"
 done
@@ -18,16 +17,16 @@
=
 
 count=3D0
 while [ $count -lt $ITERATIONS ]; do
-    count=3D$(( count +=
 1 ))
-    make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D > /dev/null 2>&=
1
+    count=3D$((count + 1))
+    make check TESTS=3Dt_server_null=2Esh SU=
BDIRS=3D >/dev/null 2>&1
     retval=3D$?
 
-    echo "Iteration ${count}: =
return value ${retval}" >> "${LOG_BASEDIR}/make-check=2Elog"
+    echo "Ite=
ration ${count}: return value ${retval}" >>"${LOG_BASEDIR}/make-check=2Elog=
"
     if [ $retval -ne 0 ]; then
-	DIR=3D"${LOG_BASEDIR}/make-check-${coun=
t}"
+        DIR=3D"${LOG_BASEDIR}/make-check-${count}"
         mkdir -p "=
${DIR}"
         cp t_server_null*=2Elog "${DIR}/"
         cp test-suite=
=2Elog "${DIR}/"
-        ps aux|grep openvpn|grep -vE '(suppress|grep)' > =
"${DIR}/psaux"
+        ps aux | grep openvpn | grep -vE '(suppress|grep)' =
>"${DIR}/psaux"
     fi
 done
diff --git a/tests/update_t_client_ips=2Esh b=
/tests/update_t_client_ips=2Esh
index 96e3826=2E=2E777a286 100755
--- a/tes=
ts/update_t_client_ips=2Esh
+++ b/tests/update_t_client_ips=2Esh
@@ -5,12 +=
5,12 @@
 
 RC=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
 
-grep EXPECT_IFCONFIG4_=
$TESTNUM=3D $RC > /dev/null 2>&1
+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC >/d=
ev/null 2>&1
 if [ $? -ne 0 ]; then
-    echo "EXPECT_IFCONFIG4_$TESTNUM=3D=
$ifconfig_local" >> $RC
+    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_lo=
cal" >>$RC
 fi
 
-grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+g=
rep EXPECT_IFCONFIG6_$TESTNUM=3D $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then=

-    echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $RC
+    e=
cho "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >>$RC
 fi

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b=
9a5c9ffdbf332a0f
Gerrit-Change-Number: 1793
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--JBN86vR/KqM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+1 by pl=
aisthos</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Reformat all shell-scripts with shfmt<br><br>Accor=
ding to =2E/dev-tools/reformat-shell=2Esh=2E<br><br>Change-Id: I76cd38fc4f4=
3c2b75ed4ca6b9a5c9ffdbf332a0f<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/gen-release-tarballs=2Esh<br>M=
 dev-tools/git-pre-commit-format=2Esh<br>M dev-tools/run-cppcheck=2Esh<br>M=
 dev-tools/update-copyright=2Esh<br>M tests/lwip_client_up=2Esh<br>M tests/=
null_client_up=2Esh<br>M tests/t_client=2Esh=2Ein<br>M tests/t_cltsrv=2Esh<=
br>M tests/t_lpback=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_null=2Es=
h<br>M tests/t_server_null_client=2Esh<br>M tests/t_server_null_server=2Esh=
<br>M tests/t_server_null_stress=2Esh<br>M tests/update_t_client_ips=2Esh<b=
r>15 files changed, 412 insertions(+), 412 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/93=
/1793/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tool=
s/gen-release-tarballs=2Esh</span><br><span>index 6071b57=2E=2E78104c4 1007=
55</span><br><span>--- a/dev-tools/gen-release-tarballs=2Esh</span><br><spa=
n>+++ b/dev-tools/gen-release-tarballs=2Esh</span><br><span>@@ -21,7 +21,7 =
@@</span><br><span> if [ $# -ne 4 ]; then</span><br><span>     echo &quot;U=
sage: $0 &lt;remote-name&gt; &lt;tag-name&gt; &lt;sign-key&gt; &lt;dest-dir=
&gt;&quot;</span><br><span>     echo &quot;&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    echo &quot;   remote-name  -- valid remotes=
: `git remote | tr \\\n &#39; &#39;`&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    echo &quot;   remote-name  -- valid remotes: $(g=
it remote | tr \\n &#39; &#39;)&quot;</span><br><span>     echo &quot;   ta=
g-name     -- An existing release tag&quot;</span><br><span>     echo &quot=
;   sign-key     -- PGP key used to sign all files&quot;</span><br><span>  =
   echo &quot;   dest-dir     -- Where to put the complete set of release t=
arballs&quot;</span><br><span>@@ -48,7 +48,7 @@</span><br><span> fi</span><=
br><span> </span><br><span> # Extract the git URL</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-giturl=3D&quot;`git remote get-url $arg_remote_=
name 2&gt;/dev/null`&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+giturl=3D&quot;$(git remote get-url $arg_remote_name 2&gt;/dev/null)=
&quot;</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &qu=
ot;** ERROR ** Invalid git remote name: $arg_remote_name&quot;</span><br><s=
pan>     exit 2</span><br><span>@@ -58,10 +58,9 @@</span><br><span> echo &q=
uot;test&quot; | gpg -a --clearsign -u &quot;$arg_sign_key&quot; 2&gt;/dev/=
null 1&gt;/dev/null</span><br><span> if [ $? -ne 0 ]; then</span><br><span>=
     echo &quot;** ERROR ** Failed when testing the PGP signing=2E  Wrong s=
igning key?&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
exit 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 2</=
span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> #</span><br><span> # Helper functions</spa=
n><br><span> #</span><br><span>@@ -70,7 +69,7 @@</span><br><span> {</span><=
br><span>     local wildcard=3D&quot;$1&quot;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    res=3D&quot;`find =2E -maxdep=
th 1 -type f -name \&quot;$wildcard\&quot; | head -n1 | cut -d/ -f2-`&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=3D&quot;$(f=
ind =2E -maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n1 | cut =
-d/ -f2-)&quot;</span><br><span>     if [ $? -ne 0 ]; then</span><br><span>=
         echo &quot;-- &#39;find&#39; failed=2E&quot;</span><br><span>     =
    exit 5</span><br><span>@@ -87,7 +86,7 @@</span><br><span>     local fil=
eext=3D&quot;$1&quot;</span><br><span>     local dest=3D&quot;$2&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    file=
=3D&quot;`get_filename openvpn-*=2E*=2E*=2E$fileext`&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    file=3D&quot;$(get_filename open=
vpn-*=2E*=2E*=2E$fileext)&quot;</span><br><span>     if [ -z &quot;$file&qu=
ot; ]; then</span><br><span>         echo &quot;** ERROR Failed to find sou=
rce file&quot;</span><br><span>         exit 5</span><br><span>@@ -96,7 +95=
,7 @@</span><br><span>     cp &quot;$file&quot; &quot;$dest&quot;</span><br=
><span>     if [ $? -ne 0 ]; then</span><br><span>         echo &quot;** ER=
ROR ** Failed to copy $file to $destdir&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        exit 3;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        exit 3</span><br><span>     fi</span><br><span>=
 }</span><br><span> </span><br><span>@@ -105,7 +104,7 @@</span><br><span>  =
   local signkey=3D&quot;$1&quot;</span><br><span>     local srchfile=3D&qu=
ot;$2&quot;</span><br><span>     local signtype=3D&quot;$3&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    local file=3D&quot;`get_file=
name $srchfile`&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    local file=3D&quot;$(get_filename $srchfile)&quot;</span><br><span> <=
/span><br><span>     echo &quot;-- Signing $file =2E=2E=2E&quot;</span><br>=
<span>     case &quot;$signtype&quot; in</span><br><span>@@ -126,16 +125,16=
 @@</span><br><span> </span><br><span>         *)</span><br><span>         =
    echo &quot;** ERROR **  Unknown signing type \&quot;$signtype\&quot;=2E=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            exi=
t 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exi=
t 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</=
span><br><span>     esac</span><br><span> </span><br><span>     if [ $res -=
ne 0 ]; then</span><br><span>         echo &quot;** ERROR **  Failed to sig=
n the file $PWD/$file&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        exit 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        exit 4</span><br><span>     fi</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #=
</span><br><span> # Preparations</span><br><span> #</span><br><span>@@ -146=
,7 +145,7 @@</span><br><span>     /*) # Absolute path</span><br><span>     =
    destdir=3D&quot;$arg_dest_dir/$arg_tag_name&quot;</span><br><span>     =
    ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *)  # Make =
absolute path from relative path</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    *) # Make absolute path from relative path</span><br><span=
>         destdir=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;</span><br>=
<span>         ;;</span><br><span> esac</span><br><span>@@ -168,61 +167,61 =
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
caf=2E=2E3507289 100755</span><br><span>--- a/dev-tools/git-pre-commit-form=
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
 -62,18 +60,19 @@</span><br><span> fi</span><br><span> </span><br><span> # =
check whether the given file matches any of the set extensions</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-matches_extension() {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+matches_extension()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     local fil=
ename=3D&quot;$(basename -- &quot;$1&quot;)&quot;</span><br><span>     loca=
l extension=3D&quot;=2E${filename##*=2E}&quot;</span><br><span>     local e=
xt</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for ext in =2Ec =2Eh ; do [ &quot;$ext&quot; =3D &quot;$extension&quot; =
] &amp;&amp; return 0; done</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for ext in =2Ec =2Eh; do [ &quot;$ext&quot; =3D &quot;$extensio=
n&quot; ] &amp;&amp; return 0; done</span><br><span> </span><br><span>     =
return 1</span><br><span> }</span><br><span> </span><br><span> # necessary =
check for initial commit</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-if git rev-parse --verify HEAD &gt;/dev/null 2&gt;&amp;1 ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if git rev-parse --verify HE=
AD &gt;/dev/null 2&gt;&amp;1; then</span><br><span>     against=3DHEAD</spa=
n><br><span> else</span><br><span>     # Initial commit: diff against an em=
pty tree object</span><br><span>@@ -88,8 +87,8 @@</span><br><span> </span><=
br><span>     # Allow to use in parallel with pre-commit</span><br><span>  =
   if [ $(basename &quot;$0&quot;) =3D &quot;pre-commit=2Elegacy&quot; ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       echo &quot;=
Skipping clang-format check in favor of pre-commit&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-       exit 0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        echo &quot;Skipping clang-format check=
 in favor of pre-commit&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        exit 0</span><br><span>     fi</span><br><span> else</spa=
n><br><span>     TOOL=3Duncrustify</span><br><span>@@ -98,7 +97,7 @@</span>=
<br><span>     TOOL_CMD=3D&quot;$TOOL_BIN -q -l C -c $UNCRUST_CONFIG&quot;<=
/span><br><span> </span><br><span>     # make sure the config file is corre=
ctly set</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ ! -f=
 &quot;$UNCRUST_CONFIG&quot; ] ; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if [ ! -f &quot;$UNCRUST_CONFIG&quot; ]; then</span><=
br><span>         printf &quot;Error: uncrustify config file not found=2E\n=
&quot;</span><br><span>         printf &quot;Expected to find it at $UNCRUS=
T_CONFIG=2E\n&quot;</span><br><span>         printf &quot;Aborting commit=
=2E\n&quot;</span><br><span>@@ -106,7 +105,7 @@</span><br><span>     fi</sp=
an><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if [ -z &quot;$TOOL_BIN&quot; ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$TOOL_BIN&quot; ]; then</sp=
an><br><span>     printf &quot;Error: $TOOL executable not found=2E\n&quot;=
</span><br><span>     printf &quot;Is it installed and in your \$PATH?\n&qu=
ot;</span><br><span>     printf &quot;Aborting commit=2E\n&quot;</span><br>=
<span>@@ -120,44 +119,43 @@</span><br><span> # create one patch containing =
all changes to the files</span><br><span> # sed to remove quotes around the=
 filename, if inserted by the system</span><br><span> # (done sometimes, if=
 the filename contains special characters, like the quote itself)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-git diff-index --cached --diff-=
filter=3DACMR --name-only $against -- | \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-sed -e &#39;s/^&quot;\(=2E*\)&quot;$/\1/&#39; | \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-while read file</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    # ignore file if we do check for file extensions=
 and the file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # do=
es not match the extensions =2Ec or =2Eh</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if ! matches_extension &quot;$file&quot;; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        continue;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+git diff-index --cached --diff-filter=3DACMR=
 --name-only $against -- |</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sed -e &#39;s/^&quot;\(=2E*\)&quot;$/\1/&#39; |</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while read file; do</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # ignore file if we do c=
heck for file extensions and the file</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        # does not match the extensions =2Ec or =2Eh</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ! matches_ext=
ension &quot;$file&quot;; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            continue</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        fi</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    # escape special characters in the target filename:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # phase 1 (charact=
ers escaped in the output diff):</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    #     - &#39;\&#39;: backslash needs to be escaped in the ou=
tput diff</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - =
&#39;&quot;&#39;: quote needs to be escaped in the output diff if present i=
nside</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #           =
 of the filename, as it used to bracket the entire filename part</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    # phase 2 (characters escape=
d in the match replacement):</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    #     - &#39;\&#39;: backslash needs to be escaped again for sed=
 itself</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #         =
   (i=2Ee=2E double escaping after phase 1)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    #     - &#39;&amp;&#39;: would expand to matched =
string</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#3=
9;|&#39;: used as sed split char instead of &#39;/&#39;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    # printf %s particularly important if=
 the filename contains the % character</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    file_escaped_target=3D$(printf &quot;%s&quot; &quot;$f=
ile&quot; | sed -e &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&a=
mp;/g&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
# escape special characters in the target filename:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        # phase 1 (characters escaped in =
the output diff):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      #     - &#39;\&#39;: backslash needs to be escaped in the output diff=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #     - &#3=
9;&quot;&#39;: quote needs to be escaped in the output diff if present insi=
de</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        #        =
    of the filename, as it used to bracket the entire filename part</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        # phase 2 (characte=
rs escaped in the match replacement):</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        #     - &#39;\&#39;: backslash needs to be escape=
d again for sed itself</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        #            (i=2Ee=2E double escaping after phase 1)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        #     - &#39;&amp;&#39=
;: would expand to matched string</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        #     - &#39;|&#39;: used as sed split char instead o=
f &#39;/&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  # printf %s particularly important if the filename contains the % charact=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        file_esca=
ped_target=3D$(printf &quot;%s&quot; &quot;$file&quot; | sed -e &#39;s/[\&q=
uot;]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # uncrustify our s=
ourcefile, create a patch with diff and append it to our $patch</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    # The sed call is necessary t=
o transform the patch from</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    #    --- - timestamp</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    #    +++ $tmpout timestamp</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    # to both lines working on the same file and having a =
a/ and b/ prefix=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  # Else it can not be applied with &#39;git apply&#39;=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    git show &quot;:$file&quot; | $TOO=
L_CMD &gt; &quot;$tmpout&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    git show &quot;:$file&quot; | diff -u -- - &quot;$tmpout&quot;=
 | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sed -e &q=
uot;1s|--- -|--- \&quot;b/$file_escaped_target\&quot;|&quot; -e &quot;2s|++=
+ $tmpout|+++ \&quot;a/$file_escaped_target\&quot;|&quot; &gt;&gt; &quot;$p=
atch&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        # uncrustify our s=
ourcefile, create a patch with diff and append it to our $patch</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        # The sed call is neces=
sary to transform the patch from</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        #    --- - timestamp</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        #    +++ $tmpout timestamp</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        # to both lines working on the=
 same file and having a a/ and b/ prefix=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # Else it can not be applied with &#39;git =
apply&#39;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  git show &quot;:$file&quot; | $TOOL_CMD &gt;&quot;$tmpout&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        git show &quot;:$file=
&quot; | diff -u -- - &quot;$tmpout&quot; |</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            sed -e &quot;1s|--- -|--- \&quot;b/$fil=
e_escaped_target\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_e=
scaped_target\&quot;|&quot; &gt;&gt;&quot;$patch&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span> </span><br><sp=
an> rm -f &quot;$tmpout&quot;</span><br><span> </span><br><span> # if no pa=
tch has been generated all is ok, clean up the file stub and exit</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -s &quot;$patch&quot; ] =
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -s &qu=
ot;$patch&quot; ]; then</span><br><span>     rm -f &quot;$patch&quot;</span=
><br><span>     exit 0</span><br><span> fi</span><br><span>@@ -165,7 +163,7=
 @@</span><br><span> # a patch has been created, notify the user and exit</=
span><br><span> printf &quot;Formatting of some code does not follow the pr=
oject guidelines=2E\n&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-if [ $(wc -l &lt; $patch) -gt 80 ] ; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if [ $(wc -l &lt;$patch) -gt =
80 ]; then</span><br><span>     printf &quot;The file $patch contains the n=
ecessary fixes=2E\n&quot;</span><br><span> else</span><br><span>     printf=
 &quot;Here&#39;s the patch that fixes the formatting:\n\n&quot;</span><br>=
<span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Es=
h</span><br><span>index 40db33e=2E=2Ea7aa3c4 100755</span><br><span>--- a/d=
ev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Es=
h</span><br><span>@@ -20,24 +20,23 @@</span><br><span>  --check-level=3Dexh=
austive --max-configs=3D10 \</span><br><span>  --error-exitcode=3D1&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> set -x</span><br><span> </span><br><span> mkdir -p &quot;$CPPC=
HECK_DIR&quot;</span><br><span> cd &quot;${SOURCE_DIR}&quot;</span><br><spa=
n> cppcheck $COMMON_ARGS $INCLUDE_FLAGS \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         --platform=3Dunix64 \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         --library=3Dposix=2Ecfg --library=3Db=
sd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         -U_WIN32 \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         tests/unit_tests/examp=
le_test/ tests/unit_tests/openvpn/ \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         tests/unit_tests/plugins/</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    --platform=3Dunix64 \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    --library=3Dposix=2Ecfg --library=
=3Dbsd=2Ecfg --library=3Dgnu=2Ecfg \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    -U_WIN32 \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/ src/compat/ src/plugins/ sample/ \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tests/unit_tests/example_te=
st/ tests/unit_tests/openvpn/ \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tests/unit_tests/plugins/</span><br><span> cppcheck $COMMON=
_ARGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --pla=
tform=3Dwin64 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   --library=3Dwindows=2Ecfg \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         -D_WIN32 \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_N=
ETBSD \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         -UTAR=
GET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         -UTARGET_AIX \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         src/openvpn* src/com=
pat/ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         tests/=
unit_tests/example_test/ tests/unit_tests/openvpn*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    --platform=3Dwin64 \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    --library=3Dwindows=2Ecfg \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    -D_WIN32 \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    -UTARGET_LINUX -UTARGET_FREE=
BSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -U=
TARGET_DRAGONFLY \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   -UTARGET_AIX \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn* src/compat/ \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    tests/unit_tests/example_test/ tests/unit_tests/openvpn*</span=
><br><span>diff --git a/dev-tools/update-copyright=2Esh b/dev-tools/update-=
copyright=2Esh</span><br><span>index 96546dd=2E=2E7ca6002 100755</span><br>=
<span>--- a/dev-tools/update-copyright=2Esh</span><br><span>+++ b/dev-tools=
/update-copyright=2Esh</span><br><span>@@ -34,8 +34,7 @@</span><br><span> C=
OPY_YEAR=3D&quot;$1&quot;</span><br><span> </span><br><span> cd &quot;$(git=
 rev-parse --show-toplevel)&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-for file in $(git ls-files | grep -v vendor/);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+for file in $(git ls-files | grep -v vendor/); do</span=
><br><span>     echo -n &quot;Updating $file =2E=2E=2E&quot;</span><br><spa=
n>     # The first sed operation covers 20xx-20yy copyright lines,</span><b=
r><span>     # The second sed operation changes 20xx -&gt; 20xx-20yy</span>=
<br><span>diff --git a/tests/lwip_client_up=2Esh b/tests/lwip_client_up=2Es=
h</span><br><span>index a6b4d24=2E=2Eb1941a4 100755</span><br><span>--- a/t=
ests/lwip_client_up=2Esh</span><br><span>+++ b/tests/lwip_client_up=2Esh</s=
pan><br><span>@@ -2,16 +2,17 @@</span><br><span> #</span><br><span> # Deter=
mine the OpenVPN PID from its pid file=2E This works reliably even when</sp=
an><br><span> # the OpenVPN process is backgrounded for parallel tests=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+MY_PPID=3D$(cat $pid)<=
/span><br><span> </span><br><span> # Add this client&#39;s VPN IP and PID t=
o a file=2E This enables</span><br><span> # t_server_null_client=2Esh to ki=
ll this OpenVPN client after fping tests have</span><br><span> # finished=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;$ifconf=
ig_local,$MY_PPID&quot; &gt;&gt; =2E/$test_name=2Elwip</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+echo &quot;$ifconfig_local,$MY_PPID&quot=
; &gt;&gt;=2E/$test_name=2Elwip</span><br><span> </span><br><span> # Wait l=
ong enough to allow fping tests to finish=2E Also ensure that this</span><b=
r><span> # OpenVPN client is killed even if t_server_null_client=2Esh faile=
d to do it=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(sleep 1=
5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;ERROR: t_=
server_null_client=2Esh failed to kill OpenVPN client with PID $MY_PPID in =
test $test_name=2E Killing it in lwip_client_up=2Esh=2E&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-kill -15 $MY_PPID</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+(</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sleep 15</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    echo &quot;ERROR: t_server_null_client=2Esh failed to kill=
 OpenVPN client with PID $MY_PPID in test $test_name=2E Killing it in lwip_=
client_up=2Esh=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    kill -15 $MY_PPID</span><br><span> ) &amp;</span><br><span>diff --g=
it a/tests/null_client_up=2Esh b/tests/null_client_up=2Esh</span><br><span>=
index d4df0c6=2E=2Ebe339ee 100755</span><br><span>--- a/tests/null_client_u=
p=2Esh</span><br><span>+++ b/tests/null_client_up=2Esh</span><br><span>@@ -=
4,8 +4,11 @@</span><br><span> </span><br><span> # Determine the OpenVPN PID=
 from its pid file=2E This works reliably even when</span><br><span> # the =
OpenVPN process is backgrounded for parallel tests=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-MY_PPID=3D`cat $pid`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+MY_PPID=3D$(cat $pid)</span><br><span> </=
span><br><span> # Allow OpenVPN to finish initializing while waiting in the=
 background and then</span><br><span> # killing the process gracefully=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-(sleep 5 ; kill -15 $MY=
_PPID) &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    sleep 5</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    kill -15 $MY_PPID</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+) &amp;</span><br><span>diff --=
git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>i=
ndex 7233187=2E=2E98cabde 100755</span><br><span>--- a/tests/t_client=2Esh=
=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -19=
,9 +19,9 @@</span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br>=
<span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span> =
openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -r &quot;${top_builddi=
r}&quot;/t_client=2Erc ] ; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span=
><br><span>     =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-elif [ -r &quot;${srcdir}&quot;/t_c=
lient=2Erc ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span>     =
=2E &quot;${srcdir}&quot;/t_client=2Erc</span><br><span> else</span><br><sp=
an>     echo &quot;$0: cannot find &#39;t_client=2Erc&#39; in build dir (&#=
39;${top_builddir}&#39;)&quot; &gt;&amp;2</span><br><span>@@ -32,37 +32,35 =
@@</span><br><span> # Check for external dependencies</span><br><span> FPIN=
G=3D&quot;fping&quot;</span><br><span> FPING6=3D&quot;fping6&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-which fping &gt; /dev/null</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+which fping &gt;/dev/nu=
ll</span><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$=
0: fping is not available in \$PATH&quot; &gt;&amp;2</span><br><span>     e=
xit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-which fping6 &gt; /dev/null</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+which fping6 &gt;/dev/null</span><=
br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: fping6 =
is not available in \$PATH, assuming fping 4=2E0 or later&quot; &gt;&amp;2<=
/span><br><span>     FPING=3D&quot;fping -4&quot;</span><br><span>     FPIN=
G6=3D&quot;fping -6&quot;</span><br><span> fi</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-KILL_EXEC=3D`which kill`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+KILL_EXEC=3D$(which kill)</s=
pan><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;$0: ki=
ll not found in \$PATH&quot; &gt;&amp;2</span><br><span>     exit &quot;${T=
CLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-if [ ! -x &quot;${openvpn}&quot; ]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; ]; the=
n</span><br><span>     echo &quot;no (executable) openvpn binary in current=
 build tree=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     exit 1</span><=
br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-if [ ! -w =2E ]</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -w =
=2E ]; then</span><br><span>     echo &quot;current directory is not writab=
le (required for logging)=2E FAIL=2E&quot; &gt;&amp;2</span><br><span>     =
exit 1</span><br><span> fi</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-if [ -z &quot;$TEST_RUN_LIST&quot; ] ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$TEST_RUN_LIST=
&quot; ]; then</span><br><span>     echo &quot;TEST_RUN_LIST empty, no test=
s defined=2E  SKIP test=2E&quot; &gt;&amp;2</span><br><span>     exit &quot=
;${TCLIENT_SKIP_RC}&quot;</span><br><span> fi</span><br><span>@@ -72,16 +70=
,14 @@</span><br><span> </span><br><span> # make sure we have permissions t=
o run ifconfig/route from OpenVPN</span><br><span> # can&#39;t use &quot;id=
 -u&quot; here - doesn&#39;t work on Solaris</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-ID=3D`id`</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ID=3D$(id)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &g=
t;/dev/null; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  :</span><br><span> else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; then</span><br><=
span>         # Check if we have a valid kerberos ticket</span><br><span>  =
       klist -l 1&gt;/dev/null 2&gt;/dev/null</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if [ $? -ne 0 ]; then</span><br><span>         =
    # No kerberos ticket found, skip ksu and fallback to RUN_SUDO</span><br=
><span>             PREFER_KSU=3D0</span><br><span>             echo &quot;=
$0: No Kerberos ticket available=2E  Will not use ksu=2E&quot;</span><br><s=
pan>@@ -90,8 +86,7 @@</span><br><span>         fi</span><br><span>     fi</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><span>         echo &quot=
;$0: this test must run be as root, or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp=
;2</span><br><span>         echo &quot;      must be set correctly in &#39;=
t_client=2Erc&#39;=2E SKIP=2E&quot; &gt;&amp;2</span><br><span>         exi=
t &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span>@@ -99,19 +94,18 @@</span>=
<br><span>         # We have to use sudo=2E Make sure that we (hopefully) d=
o not have</span><br><span>         # to ask the users password during the =
test=2E This is done to</span><br><span>         # prevent timing issues, e=
=2Eg=2E when the waits for openvpn to start</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	if $RUN_SUDO $KILL_EXEC -0 $$</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	    echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=
=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;$0: $RUN_SUD=
O $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	    exit &quot;${TCLIENT_SKIP_R=
C}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if $RUN_SUDO $KILL_EX=
EC -0 $$; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       echo &quot;$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$0: $RUN=
_SUDO $KILL_EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            exit &quot;${T=
CLIENT_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        fi</span><br><span>     fi</span><br><span> fi</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-LOGDIR=3Dt_client-`hos=
tname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-if mkdir $LOGDIR</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-then :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LOGDIR=3Dt_=
client-$(hostname)-$(date +%Y%m%d-%H%M%S)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+if mkdir $LOGDIR; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    :</span><br><span> else</span><br><span>     e=
cho &quot;can&#39;t create log directory &#39;$LOGDIR&#39;=2E FAIL=2E&quot;=
 &gt;&amp;2</span><br><span>     exit 1</span><br><span>@@ -131,22 +125,29 =
@@</span><br><span> output_start()</span><br><span> {</span><br><span>     =
case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) outbuf=
=3D&quot;&quot; ;;			# no per-test output at all</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	1) echo -e &quot;$@&quot;			# compact, details =
only on failure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     outbuf=3D&quot;\n&quot; ;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	*) echo -e &quot;\n$@\n&quot; ;;		# print all, with a bit format=
ting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0) outb=
uf=3D&quot;&quot; ;; # no per-test output at all</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            echo -e &quot;$@&quot; # compact, details o=
nly on failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       outbuf=3D&quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *) echo -e &quot;\n$@\n&quot; ;; # print all, with a bit form=
atting</span><br><span>     esac</span><br><span> }</span><br><span> </span=
><br><span> output()</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    NO_NL=3D&#39;&#39;; if [ &quot;X$1&quot; =3D &quot;X-=
n&quot; ] ; then NO_NL=3D$1 ; shift ; fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    NO_NL=3D&#39;&#39;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if [ &quot;X$1&quot; =3D &quot;X-n&quot; ]; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NO_NL=3D$1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        shift</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>  =
   case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	0) ;;		=
		# no per-test output at all</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	1) outbuf=3D&quot;$outbuf$@&quot; 		# print details only on failur=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   test -z &quot;$N=
O_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           ;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	*) echo -e $NO_NL &quot;$@&quot; ;;	# print everyt=
hing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0) ;; #=
 no per-test output at all</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          outbuf=3D&quot;$outbuf$@&quot; # print details only on failure</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            test -z &q=
uot;$NO_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *) echo -e $NO_NL &quot;$@&quot; =
;; # print everything</span><br><span>     esac</span><br><span> }</span><b=
r><span> </span><br><span>@@ -154,62 +155,61 @@</span><br><span> fail()</sp=
an><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$(( $fail_cou=
nt + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fail_c=
ount=3D$(($fail_count + 1))</span><br><span> }</span><br><span> </span><br>=
<span> # print &quot;all interface IP addresses&quot; + &quot;all routes&qu=
ot;</span><br><span> # this is higly system dependent=2E=2E=2E</span><br><s=
pan> get_ifconfig_route()</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    UNAME=3D`uname -s`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    UNAME=3D$(uname -s)</span><br><span>     case=
 $UNAME in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	Linux)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><b=
r><span>             # linux / iproute2? (-&gt; if configure got a path)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if [ -n &quo=
t;@IPROUTE@&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if [ -n &quot;@IPROUTE@&quot; ]; then</span><br><span>              =
   echo &quot;-- linux iproute2 --&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                @IPROUTE@ addr show     | grep -v valid_=
lft</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
@IPROUTE@ addr show | grep -v valid_lft</span><br><span>                 @I=
PROUTE@ route show</span><br><span>                 @IPROUTE@ -o -6 route s=
how | grep -v &#39; cache&#39; | sed -E -e &#39;s/ expires [0-9]*sec//&#39;=
 -e &#39;s/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g&#39; -e &#39;s/ (rtt|rtt=
var) [0-9]+ms//g&#39;</span><br><span>             else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	        echo &quot;-- linux / ifconfig -=
-&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	        LANG=
=3DC @IFCONFIG@ -a |egrep  &quot;( addr:|encap:)&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	        LANG=3DC @NETSTAT@ -rn -4 -6</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                echo &qu=
ot;-- linux / ifconfig --&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                LANG=3DC @IFCONFIG@ -a | egrep &quot;( addr:|en=
cap:)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             fi</span>=
<br><span>             ;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	FreeBSD|NetBSD|Darwin)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	   echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;=
(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	OpenBSD)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	   echo &quot;-- OpenBSD --&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a | egrep &quot;(flags=3D=
|inet)&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		sed=
 -e &#39;s/pltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
SunOS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;=
-- Solaris --&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 =
  @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ {=
 print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	   ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AIX)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	   echo &quot;-- AIX --&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   @IFCONFIG@ -a =
| egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	   @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6=
 }&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | NetBSD | =
Darwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;=
(flags=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&=
#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OpenBSD)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;=
-- OpenBSD --&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot; |</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sed -e &#39;s/p=
ltime [0-9]*//&#39; -e &#39;s/vltime [0-9]*//&#39;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /=
^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SunOS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            echo &quot;-- Solaris --&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            @IFCONFIG@ -a | egrep &quot;(flags=
=3D|inet)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$6 }&#39;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        AIX)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- AIX --&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            @IF=
CONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL=
/ { print $1,$2,$3,$6 }&#39;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ;;</span><br><span>         *)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           echo &quot;get_ifconfig_route():=
 no idea how to get info on your OS (`uname -s`)=2E  FAIL=2E&quot; &gt;&amp=
;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           exit 20<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-           ;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;get_i=
fconfig_route(): no idea how to get info on your OS ($(uname -s))=2E  FAIL=
=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            exit 20</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ;;</span><br><span>     esac</span><br><span> </span><br><span=
>     # another round of per-platform information gathering, for DNS info</=
span><br><span>     # for most of the platforms &quot;cat /etc/resolv=2Econ=
f&quot; is good enough</span><br><span>     # except Linux and MacOS</span>=
<br><span>     case $UNAME in</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	Linux)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        Linux)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if [ -x /usr/bin/re=
solvectl -a -d /run/systemd/system ]; then</span><br><span>                =
 echo &quot;-- linux resolvectl --&quot;</span><br><span>                 r=
esolvectl status</span><br><span>             else</span><br><span>@@ -217,=
7 +217,7 @@</span><br><span>                 cat /etc/resolv=2Econf</span><=
br><span>             fi</span><br><span>             ;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	Darwin)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        Darwin)</span><br><span>             echo &=
quot;-- MacOS scutil --dns&quot;</span><br><span>             scutil --dns<=
/span><br><span>             ;;</span><br><span>@@ -234,19 +234,19 @@</span=
><br><span> #  arg2: IPv4/IPv6 address that must show up in out of &quot;ge=
t_ifconfig_route&quot;</span><br><span> check_ifconfig()</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    proto=3D$1 ; shif=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    shift</span><br><sp=
an>     expect_list=3D&quot;$@&quot;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$expect_list&quot; ] ; t=
hen return ; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 [ &quot;$expect_list&quot; =3D &quot;-&quot; ] ; then return ; fi</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$expect_li=
st&quot; ]; then return; fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if [ &quot;$expect_list&quot; =3D &quot;-&quot; ]; then return;=
 fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for expect in $expect_list</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if ge=
t_ifconfig_route | fgrep &quot;$expect&quot; &gt;/dev/null</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	then :</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	    fail &quot;check_ifconfig(): expected IPv$proto address &#39;$e=
xpect&#39; not found in ifconfig output=2E&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	fi</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for expect in $expect_list; do</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if get_ifconfig_route | fgrep &quot;$expe=
ct&quot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            :</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        fail &quot;check_ifconfig(): expected IPv$proto address &#39;$expec=
t&#39; not found in ifconfig output=2E&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        fi</span><br><span>     done</span><br><sp=
an> }</span><br><span> </span><br><span>@@ -257,47 +257,48 @@</span><br><sp=
an> #  arg3=2E=2E=2E -&gt; fping arguments (host list)</span><br><span> run=
_ping_tests()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    proto=3D$1 ; want=3D$2 ; shift ; shift</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    proto=3D$1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    want=3D$2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    shift</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    shift</span><br><span>     targetlist=3D&quot;$@&quot;</sp=
an><br><span> </span><br><span>     # &quot;no targets&quot; is fine</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$targetlis=
t&quot; ] ; then return ; fi</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if [ -z &quot;$targetlist&quot; ]; then return; fi</span><br><=
span> </span><br><span>     case $proto in</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	4) cmd=3D&quot;$FPING&quot; ;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	6) cmd=3D&quot;$FPING6&quot; ;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	*) echo &quot;internal error in=
 run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&amp;2</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	   exit 1 ;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        4) cmd=3D&quot;$FPING&quot; ;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        6) cmd=3D&quot;$FPI=
NG6&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo=
 &quot;internal error in run_ping_tests arg 1: &#39;$proto&#39;&quot; &gt;&=
amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ex=
it 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ;;<=
/span><br><span>     esac</span><br><span> </span><br><span>     case $want=
 in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	want_ok)   sizes_=
list=3D&quot;64 1440 3000&quot; ;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        want_ok) sizes_list=3D&quot;64 =
1440 3000&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       want_fail) sizes_list=3D&quot;64&quot; ;;</span><br><span>     esac<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for bytes in $sizes_list</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quo=
t;run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for bytes in $sizes_=
list; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        out=
put &quot;run IPv$proto ping tests ($want), $bytes byte packets=2E=2E=2E&qu=
ot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist&quot; &g=
t;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	$cmd -b $bytes -C 20 -p 250 -q $fping_args $targetlist &gt;&gt;$L=
OGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        echo &quot;$cmd -b $bytes -C 20 -p 250 -q $fping_arg=
s $targetlist&quot; &gt;&gt;$LOGDIR/$SUF:fping=2Eout</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        $cmd -b $bytes -C 20 -p 250 -q $f=
ping_args $targetlist &gt;&gt;$LOGDIR/$SUF:fping=2Eout 2&gt;&amp;1</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# while Ope=
nVPN is running, pings must succeed (want=3D&#39;want_ok&#39;)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	# before OpenVPN is up, pings mus=
t NOT succeed (want=3D&#39;want_fail&#39;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        # while OpenVPN is running, pings must succe=
ed (want=3D&#39;want_ok&#39;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        # before OpenVPN is up, pings must NOT succeed (want=3D&#=
39;want_fail&#39;)</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	if [ $rc =3D 0 ] 				# all ping OK</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	    if [ $want =3D &quot;want_fail&quot; ]		# not what we want</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test succeeded,=
 but needs to *fail*=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else	=
				# ping failed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	   =
 if [ $want =3D &quot;want_ok&quot; ]		# not what we wanted</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	    then</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		fail &quot;IPv$proto ping test ($bytes bytes) f=
ailed, but should succeed=2E&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rc=3D$?</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ $rc =3D =
0 ]; then                 # all ping OK</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if [ $want =3D &quot;want_fail&quot; ]; the=
n # not what we want</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                fail &quot;IPv$proto ping test succeeded, but needs to *fa=
il*=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
                               # ping failed</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if [ $want =3D &quot;want_ok&quot; ]; =
then # not what we wanted</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                fail &quot;IPv$proto ping test ($bytes bytes) failed,=
 but should succeed=2E&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        fi</span><br><span>     done</span><br><span> }</span><br><span=
> </span><br><span>@@ -308,8 +309,7 @@</span><br><span> SUMMARY_SKIP=3D</sp=
an><br><span> SUMMARY_FAIL=3D</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     # get con=
fig variables</span><br><span>     eval test_prep=3D\&quot;\$PREPARE_$SUF\&=
quot;</span><br><span>     eval test_check_skip=3D\&quot;\$CHECK_SKIP_$SUF\=
&quot;</span><br><span>@@ -336,11 +336,13 @@</span><br><span> </span><br><s=
pan>     if [ -n &quot;$test_check_skip&quot; ]; then</span><br><span>     =
    output &quot;check whether we need to skip: &#39;$test_check_skip&#39;&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if eval =
$test_check_skip; then :</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if eval $test_check_skip; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            :</span><br><span>         else</span><=
br><span>             output &quot;skip check failed, SKIP test $SUF=2E&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    SUMMARY_SKIP=
=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	    echo -e &quot;$outbuf&quot; ; continue</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            SUMMARY_SKIP=3D&quot;$SUMMA=
RY_SKIP $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           echo -e &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            continue</span><br><span>         fi</span><=
br><span>     fi</span><br><span> </span><br><span>@@ -355,13 +357,14 @@</s=
pan><br><span>     output &quot;\nrun pre-openvpn ping tests - targets must=
 not be reachable=2E=2E=2E&quot;</span><br><span>     run_ping_tests 4 want=
_fail &quot;$ping4_hosts&quot;</span><br><span>     run_ping_tests 6 want_f=
ail &quot;$ping6_hosts&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ]=
; then</span><br><span>         output &quot;OK=2E\n&quot;</span><br><span>=
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;=
make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=3D&qu=
ot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	exit_code=3D31</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	echo -e &quot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        fail &quot;make sure that ping hosts are ONLY r=
eachable via VPN, SKIP test $SUF=2E&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit_code=
=3D31</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo -=
e &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        continue</span><br><span>     fi</span><br><span> </span><br><spa=
n>     pidfile=3D&quot;${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid&quo=
t;</span><br><span>@@ -376,18 +379,17 @@</span><br><span>     # to $ovpn_in=
it_check times=2E</span><br><span>     ovpn_init_check=3D30</span><br><span=
>     ovpn_init_success=3D0</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    while [ $ovpn_init_check -gt 0 ];</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-       sleep 1  # Wait for OpenVPN to initialize and have had time t=
o write the pid file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
      grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openv=
pn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-       if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-           ovpn_init_check=3D0</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-           ovpn_init_success=3D1</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-       fi</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while [ $ovpn_init_che=
ck -gt 0 ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   sleep 1 # Wait for OpenVPN to initialize and have had time to write the =
pid file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gre=
p &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog =
&gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ovpn_init_success=3D1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ovpn_init_check=3D$(($ovpn_init_check - 1))</s=
pan><br><span>     done</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    opid=3D`cat $pidfile`</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    opid=3D$(cat $pidfile)</span><br><span>     i=
f [ -n &quot;$opid&quot; ]; then</span><br><span>         output &quot;  Op=
enVPN running with PID $opid&quot;</span><br><span>     else</span><br><spa=
n>@@ -398,16 +400,17 @@</span><br><span>     if [ $ovpn_init_success -ne 1 =
-o -z &quot;$opid&quot; ]; then</span><br><span>         output &quot;$0:  =
OpenVPN did not initialize in a reasonable time&quot;</span><br><span>     =
    if [ -n &quot;$opid&quot; ]; then</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-           $RUN_SUDO $KILL_EXEC $opid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $opid</s=
pan><br><span>         fi</span><br><span>         $RUN_SUDO $KILL_EXEC $su=
dopid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot;ta=
il -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	output &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;skip rest of sub-te=
sts for test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	exit_code=3D30</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ; continue</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;tail -5 =
$SUF:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        output &quot;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;skip r=
est of sub-tests for test run $SUF=2E&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        trap - 0 1 2 3 15</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $S=
UF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exi=
t_code=3D30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
echo -e &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        continue</span><br><span>     fi</span><br><span> </span><b=
r><span>     # make sure openvpn client is terminated in case shell exits</=
span><br><span>@@ -418,17 +421,16 @@</span><br><span>     output &quot;save=
 ifconfig+route&quot;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$=
SUF:ifconfig_route=2Etxt</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quo=
t; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [=
 &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br><span>  =
       output &quot;skip ifconfig+route check&quot;</span><br><span>     el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output -n &quot;co=
mpare pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	if diff $LOGDIR/$SUF:ifconfi=
g_route_pre=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
$LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/null</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	    fail &quot;no differences between ifconfig/route before Open=
VPN start and now=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    output=
 &quot; OK!\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	f=
i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        output -n =
&quot;compare pre-openvpn ifconfig+route with current values=2E=2E=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if diff $LO=
GDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            $LOGDIR/$SUF:ifconfig_route=2Etxt &gt;/dev/nul=
l; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
fail &quot;no differences between ifconfig/route before OpenVPN start and n=
ow=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            out=
put &quot; OK!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        fi</span><br><span>     fi</span><br><span> </span><br><span>   =
  # post init script needed?</span><br><span>@@ -449,8 +451,8 @@</span><br>=
<span>     $RUN_SUDO $KILL_EXEC $opid</span><br><span>     wait $!</span><b=
r><span>     rc=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if [ $rc !=3D 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	fail &quot;OpenVPN return code $rc, expect 0&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ $rc !=3D 0 ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        fail &quot;OpenVPN re=
turn code $rc, expect 0&quot;</span><br><span>     fi</span><br><span> </sp=
an><br><span>     output &quot;\nsave post-openvpn ifconfig + route=2E=2E=
=2E&quot;</span><br><span>@@ -458,23 +460,22 @@</span><br><span> </span><br=
><span>     output -n &quot;compare pre- and post-openvpn ifconfig + route=
=2E=2E=2E&quot;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pr=
e=2Etxt \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    $LOGDIR=
/$SUF:ifconfig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	output &quot; OK=2E\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        $LOGDIR/$SUF:ifcon=
fig_route_post=2Etxt &gt;$LOGDIR/$SUF:ifconfig_route_diff=2Etxt; then</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot; OK=
=2E\n&quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	output &quot;\n\n&quot; &quot;`cat $LOGDIR/$SUF:ifconfig_r=
oute_diff=2Etxt`&quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	fail &quot;differences between pre- and post-ifconfig/rout=
e=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
utput &quot;\n\n&quot; &quot;$(cat $LOGDIR/$SUF:ifconfig_route_diff=2Etxt)&=
quot; &quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fail &quot;differences between pre- and post-ifconfig/route=2E&quo=
t;</span><br><span>     fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if [ &quot;$fail_count&quot; =3D 0 ] ; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$fail_count&quot; =3D 0 ];=
 then</span><br><span>         output &quot;test run $SUF: all tests OK=2E\=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_OK=3D=
&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span>=
     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if [ &quot;=
$V&quot; -gt 0 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	    echo -e -n &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	    echo -e &quot;test run $SUF: $fail_count test failures=
=2E FAIL=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if [ &quot;$V&quot; -gt 0 ]; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            echo -e -n &quot;$outbuf&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            echo -e &quot;test=
 run $SUF: $fail_count test failures=2E FAIL=2E\n&quot;</span><br><span>   =
      fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	SUMMARY_FAIL=
=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	exit_code=3D30</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        exit_code=3D30</span><br>=
<span>     fi</span><br><span> </span><br><span>     if [ -n &quot;$test_cl=
eanup&quot; ]; then</span><br><span>@@ -484,9 +485,9 @@</span><br><span> </=
span><br><span> done</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-if [ -z &quot;$SUMMARY_OK&quot; ] ; then SUMMARY_OK=3D&quo=
t; none&quot;; fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [=
 -z &quot;$SUMMARY_SKIP&quot; ] ; then SUMMARY_SKIP=3D&quot; none&quot;; fi=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$SUMMAR=
Y_FAIL&quot; ] ; then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMARY_OK&quot; ]; t=
hen SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if [ -z &quot;$SUMMARY_SKIP&quot; ]; then SUMMARY_SKIP=
=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+if [ -z &quot;$SUMMARY_FAIL&quot; ]; then SUMMARY_FAIL=3D&quot; none&q=
uot;; fi</span><br><span> echo &quot;Test sets succeeded:$SUMMARY_OK=2E&quo=
t;</span><br><span> echo &quot;Test sets skipped:$SUMMARY_SKIP=2E&quot;</sp=
an><br><span> echo &quot;Test sets failed:$SUMMARY_FAIL=2E&quot;</span><br>=
<span>diff --git a/tests/t_cltsrv=2Esh b/tests/t_cltsrv=2Esh</span><br><spa=
n>index 6b7df65=2E=2E03c3845 100755</span><br><span>--- a/tests/t_cltsrv=2E=
sh</span><br><span>+++ b/tests/t_cltsrv=2Esh</span><br><span>@@ -24,50 +24,=
58 @@</span><br><span> trap &quot;rm -f log=2E$$ log=2E$$=2Esignal ; trap 0=
 ; exit 77&quot; 1 2 15</span><br><span> trap &quot;rm -f log=2E$$ log=2E$$=
=2Esignal ; exit 1&quot; 0 3</span><br><span> addopts=3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-case `uname -s` in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+case $(uname -s) in</span><br><span>     =
FreeBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # FreeBSD=
 jails map the outgoing IP to the jail IP - we need to</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    # allow the real IP unless we want the=
 test to run forever=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if test &quot;`sysctl 2&gt;/dev/null -n security=2Ejail=2Ejailed`&quo=
t; =3D 1 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    || ps -=
ostate=3D -p $$ | grep -q J; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	addopts=3D&quot;--float&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	if test &quot;x`ifconfig | grep inet`&quot; =3D x ; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;##=
#&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo &quo=
t;### To run the test in a FreeBSD jail, you MUST add an IP alias for the j=
ail&#39;s IP=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	    echo &quot;###&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	    exit 77</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        # FreeBSD jails map the outgoing IP to the =
jail IP - we need to</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # allow the real IP unless we want the test to run forever=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if test &quot;$(=
sysctl 2&gt;/dev/null -n security=2Ejail=2Ejailed)&quot; =3D 1 ||</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ps -ostate=3D -p =
$$ | grep -q J; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            addopts=3D&quot;--float&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if test &quot;x$(ifconfig | grep inet)&q=
uot; =3D x; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             echo &quot;###&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                echo &quot;### To run the test in a FreeBSD j=
ail, you MUST add an IP alias for the jail&#39;s IP=2E&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                echo &quot;###&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                e=
xit 77</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f=
i</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ;;</span><br><span>=
 esac</span><br><span> </span><br><span> # make sure that the --down script=
 is executable -- fail (rather than</span><br><span> # skip) test if it isn=
&#39;t=2E</span><br><span> downscript=3D&quot;=2E=2E/tests/t_cltsrv-down=2E=
sh&quot;</span><br><span> root=3D&quot;${top_srcdir}/sample&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-test -x &quot;${root}/${downscr=
ipt}&quot; || chmod +x &quot;${root}/${downscript}&quot; || { echo &gt;&amp=
;2 &quot;${root}/${downscript} is not executable, failing=2E&quot; ; exit 1=
 ; }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test -x &quot;$=
{root}/${downscript}&quot; || chmod +x &quot;${root}/${downscript}&quot; ||=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &gt;&amp=
;2 &quot;${root}/${downscript} is not executable, failing=2E&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> echo &quot;The fol=
lowing test will take about two minutes=2E&quot; &gt;&amp;2</span><br><span=
> echo &quot;If the addresses are in use, this test will retry up to two ti=
mes=2E&quot; &gt;&amp;2</span><br><span> </span><br><span> # go</span><br><=
span> success=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for =
i in 1 2 3 ; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  set =
+e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &quot;${openvpn}&quot; --script-sec=
urity 2 --cd &quot;${root}&quot; ${addopts} --setenv role srv --down &quot;=
${downscript}&quot; --tls-exit --ping-exit 180 --config &quot;sample-config=
-files/loopback-server&quot; &amp;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  &quot;${openvpn}&quot; --script-security 2 --cd &quot;${top_=
srcdir}/sample&quot; ${addopts} --setenv role clt --down &quot;${downscript=
}&quot; --tls-exit --ping-exit 180 --config &quot;sample-config-files/loopb=
ack-client&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ) 3=
&gt;log=2E$$=2Esignal &gt;log=2E$$ 2&gt;&amp;1</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  e1=3D$?</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  wait $!</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  e2=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  grep &#39=
;TCP/UDP: Socket bind failed on local address=2E*in use&#39; log=2E$$ &gt;/=
dev/null &amp;&amp; {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    echo &#39;address in use, retrying in 150 s&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    sleep 150</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    continue</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  g=
rep -v &#39;:inactive$&#39; log=2E$$=2Esignal &gt;/dev/null &amp;&amp; { ca=
t log=2E$$=2Esignal ; echo ; cat log=2E$$ ; exit 1 ; }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  success=3D1</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  break</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+for i in 1 2 3; do</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    set +e</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    (</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &qu=
ot;${openvpn}&quot; --script-security 2 --cd &quot;${root}&quot; ${addopts}=
 --setenv role srv --down &quot;${downscript}&quot; --tls-exit --ping-exit =
180 --config &quot;sample-config-files/loopback-server&quot; &amp;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;${openvpn}&quo=
t; --script-security 2 --cd &quot;${top_srcdir}/sample&quot; ${addopts} --s=
etenv role clt --down &quot;${downscript}&quot; --tls-exit --ping-exit 180 =
--config &quot;sample-config-files/loopback-client&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ) 3&gt;log=2E$$=2Esignal &gt;log=
=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  e1=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wait $=
!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e2=3D$?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    grep &#39;TCP/UDP: Soc=
ket bind failed on local address=2E*in use&#39; log=2E$$ &gt;/dev/null &amp=
;&amp; {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ech=
o &#39;address in use, retrying in 150 s&#39;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        sleep 150</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        continue</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    grep -v &#39;:inactive$&#39; log=2E$$=2Esignal &gt;/dev/null &am=
p;&amp; {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
t log=2E$$=2Esignal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        echo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cat log=2E$$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    success=3D1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    break</span><br><span> do=
ne</span><br><span> </span><br><span> set -e</span><br><span>@@ -75,14 +83,=
14 @@</span><br><span> # exit code - defaults to 0, PASS</span><br><span> e=
c=3D0</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-if [ $success !=3D 1 ] ; then</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  # couldn&#39;t run test -- addresses in use, skip test</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  cat log=2E$$</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  ec=3D77</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-elif [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ] ; then</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  # failure -- fail test</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  cat log=2E$$</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  ec=3D1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ $success !=3D 1 ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    # couldn&#39;t run test -- a=
ddresses in use, skip test</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    cat log=2E$$</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ec=3D77</span><br><span style=3D"color: hsl(120, 100%, 40%);">+elif=
 [ $e1 !=3D 0 ] || [ $e2 !=3D 0 ]; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    # failure -- fail test</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    cat log=2E$$</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ec=3D1</span><br><span> fi</span><br><span> </s=
pan><br><span> rm log=2E$$ log=2E$$=2Esignal</span><br><span>diff --git a/t=
ests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><br><span>index 6802506=2E=
=2E058206f 100755</span><br><span>--- a/tests/t_lpback=2Esh</span><br><span=
>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -37,51 +37,56 @@</span><br><s=
pan> test_start()</span><br><span> {</span><br><span>     case $V in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        0) outbuf=3D&quot;&q=
uot; ;;                  # no per-test output at all</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        1) outbuf=3D&quot;$@&quot; ;;      =
          # compact, details only on failure</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        *) printf &quot;$@&quot; ;;                #=
 print all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
) outbuf=3D&quot;&quot; ;;   # no per-test output at all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        1) outbuf=3D&quot;$@&quot; ;; =
# compact, details only on failure</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        *) printf &quot;$@&quot; ;; # print all</span><br><s=
pan>     esac</span><br><span> }</span><br><span> test_end()</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    RC=3D$1 ; LOG=
=3D$2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $RC !=
=3D 0 ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    RC=3D$1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    LOG=3D$2</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if [ $RC !=3D 0 ]; then</span><br><s=
pan>         case $V in</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            0) ;;                                # no per-test output</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            1) echo &quot=
;$outbuf&quot; &quot;FAIL (RC=3D$RC)&quot;; cat $LOG ;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            *) echo &quot;FAIL (RC=3D$RC)=
&quot;; cat $LOG ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            0) ;; # no per-test output</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                echo &quot;$outbuf&quot; &quot;FAIL (RC=3D$RC=
)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    cat $LOG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   echo &quot;FAIL (RC=3D$RC)&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                cat $LOG</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ;;</span><br><span>         esac</span=
><br><span>         e=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        tests_failed=3D$(( $tests_failed + 1 ))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tests_failed=3D$(($tests_failed +=
 1))</span><br><span>     else</span><br><span>         case $V in</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            0|1) ;;           =
                   # no per-test output for &#39;OK&#39;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            *) echo &quot;OK&quot;      =
                   # print all</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            0 | 1) ;;       # no per-test output for &#39;OK&#39=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *) ech=
o &quot;OK&quot; ;; # print all</span><br><span>         esac</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        tests_passed=3D$(( $tests_p=
assed + 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 tests_passed=3D$(($tests_passed + 1))</span><br><span>     fi</span><br><s=
pan> }</span><br><span> </span><br><span> # if running with V=3D1, give an =
indication what test runs now</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-if [ &quot;$V&quot; =3D 1  ] ; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+if [ &quot;$V&quot; =3D 1 ]; then</span><br><span> =
    echo &quot;$0: running with V=3D$V, only printing test fails&quot;</spa=
n><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> # Get list of supported ciphers from openvpn =
--show-ciphers output</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
CIPHERS=3D$(${openvpn} --show-ciphers | \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            sed -e &#39;/The following/,/^$/d&#39; -e s=
&#39;/ =2E*//&#39; -e &#39;/^[[:space:]]*$/d&#39;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+CIPHERS=3D$(${openvpn} --show-ciphers |</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    sed -e &#39;/The fol=
lowing/,/^$/d&#39; -e s&#39;/ =2E*//&#39; -e &#39;/^[[:space:]]*$/d&#39;)</=
span><br><span> </span><br><span> # SK, 2014-06-04: currently the DES-EDE3-=
CFB1 implementation of OpenSSL is</span><br><span> # broken (see http://rt=
=2Eopenssl=2Eorg/Ticket/Display=2Ehtml?id=3D2867), so exclude</span><br><sp=
an> # that cipher from this test=2E</span><br><span> # GD, 2014-07-06 so is=
 DES-CFB1</span><br><span> # GD, 2014-07-06 do not test RC5-* either (fails=
 on NetBSD w/o libcrypto_rc5)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-CIPHERS=3D$(echo &quot;$CIPHERS&quot; | egrep -v &#39;^(DES-EDE3-CF=
B1|DES-CFB1|RC5-)&#39; )</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+CIPHERS=3D$(echo &quot;$CIPHERS&quot; | egrep -v &#39;^(DES-EDE3-CFB1|=
DES-CFB1|RC5-)&#39;)</span><br><span> </span><br><span> e=3D0</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$CIPHERS&quot; ] ; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$CI=
PHERS&quot; ]; then</span><br><span>     echo &quot;&#39;openvpn --show-cip=
hers&#39; FAILED (empty list)&quot;</span><br><span>     e=3D1</span><br><s=
pan> fi</span><br><span>@@ -91,10 +96,9 @@</span><br><span> </span><br><spa=
n> set +e</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-for cipher in ${CIPHERS}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for ciph=
er in ${CIPHERS}; do</span><br><span>     test_start &quot;Testing cipher $=
{cipher}=2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ( &quot;${openvpn}&quot; --test-crypto --cipher ${cipher} ) &gt;log=
=2E$$ 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  (&quot;${openvpn}&quot; --test-crypto --cipher ${cipher}) &gt;log=2E$$ 2&=
gt;&amp;1</span><br><span>     test_end $? log=2E$$</span><br><span> done</=
span><br><span> </span><br><span>@@ -121,7 +125,7 @@</span><br><span>     &=
gt;log=2E$$ 2&gt;&amp;1</span><br><span> test_end $? log=2E$$</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$V&quo=
t; -ge 1  ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f [ &quot;$V&quot; -ge 1 ]; then</span><br><span>     echo &quot;$0: tests =
passed: $tests_passed  failed: $tests_failed&quot;</span><br><span> fi</spa=
n><br><span> </span><br><span>diff --git a/tests/t_net=2Esh b/tests/t_net=
=2Esh</span><br><span>index 8134832=2E=2E17e028e 100755</span><br><span>---=
 a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span><br><span>=
@@ -9,7 +9,6 @@</span><br><span> top_builddir=3D&quot;${top_builddir:-=2E=
=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_builddir}/src/=
openvpn/openvpn}&quot;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> # bail out right away on non-linux=2E =
NetLink (the object of this test) is only</span><br><span> # used on Linux,=
 therefore testing other platform is not needed=2E</span><br><span> #</span=
><br><span>@@ -69,7 +68,6 @@</span><br><span>     done</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> ## execution starts here</span><br><span> </span><br><span> # =
t_client=2Erc required only for RUN_SUDO definition</span><br><span>@@ -89,=
21 +87,18 @@</span><br><span>     exit 77</span><br><span> fi</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 # Ensure PREFER_KSU is in a known state</span><br><span> PREFER_KSU=3D&quo=
t;${PREFER_KSU:-0}&quot;</span><br><span> </span><br><span> # make sure we =
have permissions to run the networking unit-test</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ID=3D`id`</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ID=3D$(id)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot=
; &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    :</span><br><span> else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; then</span=
><br><span>         # Check if we have a valid kerberos ticket</span><br><s=
pan>         klist -l 1&gt;/dev/null 2&gt;/dev/null</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if [ $? -ne 0 ]; then</span><br><span> =
            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO</=
span><br><span>             PREFER_KSU=3D0</span><br><span>             ech=
o &quot;$0: No Kerberos ticket available=2E  Will not use ksu=2E&quot;</spa=
n><br><span>@@ -112,16 +107,14 @@</span><br><span>         fi</span><br><sp=
an>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><span>       =
  echo &quot;$0: no RUN_SUDO=3D=2E=2E=2E in t_client=2Erc or environment, d=
efaulting to &#39;sudo&#39;=2E&quot; &gt;&amp;2</span><br><span>         ec=
ho &quot;      if that does not work, set RUN_SUDO=3D correctly for your sy=
stem=2E&quot; &gt;&amp;2</span><br><span>         RUN_SUDO=3D&quot;sudo&quo=
t;</span><br><span>     fi</span><br><span> </span><br><span>     # check t=
hat we can run the unit-test binary with sudo</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if $RUN_SUDO $UNIT_TEST test</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if $RUN_SUDO $UNIT_TEST test; then</span><br><s=
pan>         echo &quot;$0: $RUN_SUDO $UNIT_TEST succeeded, good=2E&quot;</=
span><br><span>     else</span><br><span>         echo &quot;$0: $RUN_SUDO =
$UNIT_TEST failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span=
>diff --git a/tests/t_server_null=2Esh b/tests/t_server_null=2Esh</span><br=
><span>index 74ffd52=2E=2Ec633614 100755</span><br><span>--- a/tests/t_serv=
er_null=2Esh</span><br><span>+++ b/tests/t_server_null=2Esh</span><br><span=
>@@ -2,7 +2,7 @@</span><br><span> #</span><br><span> TSERVER_NULL_SKIP_RC=
=3D&quot;${TSERVER_NULL_SKIP_RC:-77}&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-if ! [ -r &quot;=2E/t_server_null=2E=
rc&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 ! [ -r &quot;=2E/t_server_null=2Erc&quot; ]; then</span><br><span>     ech=
o &quot;${0}: cannot find &#39;=2E/t_server_null=2Erc=2E SKIPPING TEST=2E&#=
39;&quot; &gt;&amp;2</span><br><span>     exit &quot;${TSERVER_NULL_SKIP_RC=
}&quot;</span><br><span> fi</span><br><span>@@ -22,11 +22,10 @@</span><br><=
span> # make sure we have permissions to run ifconfig/route from OpenVPN</s=
pan><br><span> # can&#39;t use &quot;id -u&quot; here - doesn&#39;t work on=
 Solaris</span><br><span> ID=3D$(id)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &gt;/dev/null<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-then :</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=
=3D0&quot; &gt;/dev/null; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    :</span><br><span> else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if [ &quot;${PREFER_KSU}&quot; -eq 1 ];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; -eq 1 ]; the=
n</span><br><span>         # Check if we have a valid kerberos ticket</span=
><br><span>         if klist -l 1&gt;/dev/null 2&gt;/dev/null; then</span><=
br><span>             RUN_SUDO=3D&quot;ksu -q -e&quot;</span><br><span>@@ -=
37,26 +36,24 @@</span><br><span>         fi</span><br><span>     fi</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z=
 &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [=
 -z &quot;$RUN_SUDO&quot; ]; then</span><br><span>         echo &quot;${0}:=
 this test must run be as root, or RUN_SUDO=3D=2E=2E=2E &quot; &gt;&amp;2</=
span><br><span>         echo &quot;      must be set correctly in &#39;t_se=
rver_null=2Erc&#39;=2E SKIP=2E&quot; &gt;&amp;2</span><br><span>         ex=
it &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span>     else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	# Run a no-op command with priv=
ilege escalation (e=2Eg=2E sudo) so that</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	# we (hopefully) do not have to ask the users password =
during the test=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	if=
 $RUN_SUDO &quot;${KILL_EXEC}&quot; -0 $$</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	    echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	    echo &quot;${0}: $RUN_SUDO $KILL_=
EXEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	    exit &quot;${TSERVER_NULL_SKIP_RC}&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # Run a no-op command wi=
th privilege escalation (e=2Eg=2E sudo) so that</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        # we (hopefully) do not have to ask the=
 users password during the test=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if $RUN_SUDO &quot;${KILL_EXEC}&quot; -0 $$; then</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot=
;${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good=2E&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            echo &quot;${0}: $RUN_SUDO $KILL_E=
XEC -0 failed, cannot go on=2E SKIP=2E&quot; &gt;&amp;2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            exit &quot;${TSERVER_NULL_S=
KIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  fi</span><br><span>     fi</span><br><span> fi</span><br><span> </span><b=
r><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-export t_server_null_logdir=3Dt_server_null-`hostnam=
e`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+export t_server_null_logdir=3Dt_server_null-$(hostname)-$(date +%Y%m%d=
-%H%M%S)</span><br><span> </span><br><span> # Create directory for server a=
nd client logs</span><br><span> mkdir $t_server_null_logdir</span><br><span=
>diff --git a/tests/t_server_null_client=2Esh b/tests/t_server_null_client=
=2Esh</span><br><span>index 1745de5=2E=2E3203cc2 100755</span><br><span>---=
 a/tests/t_server_null_client=2Esh</span><br><span>+++ b/tests/t_server_nul=
l_client=2Esh</span><br><span>@@ -1,9 +1,10 @@</span><br><span> #!/bin/sh</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-shoul=
d_run_test() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shoul=
d_run_test()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span>     test_name=3D&quot;$1&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;$test_name&quot;|g=
rep -q _lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if echo &quot;$test_name&quot; | grep -q _lwip; then</span><br><span>   =
      if [ &quot;$has_lwipovpn&quot; =3D &quot;no&quot; ]; then</span><br><=
span>             return 1</span><br><span>         fi</span><br><span>@@ -=
12,7 +13,8 @@</span><br><span>     return 0</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-launch_client() =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+launch_client()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>    =
 test_name=3D$1</span><br><span>     log=3D&quot;${test_name}=2Elog&quot;</=
span><br><span>     pid=3D&quot;${test_name}=2Epid&quot;</span><br><span>@@=
 -30,7 +32,8 @@</span><br><span>         --log &quot;${t_server_null_logdir=
}/${log}&quot; &amp;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-ping_and_kill() {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ping_and_kill()</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span>     if fping -q -c 5 $1; t=
hen</span><br><span>         echo &quot;PASS: fping lwipovpn client $target=
&quot;</span><br><span>     else</span><br><span>@@ -46,9 +49,10 @@</span><=
br><span>     kill -15 $2</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-ping_lwip_clients() {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ping_lwip_clients()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     if [ &quo=
t;$has_lwipovpn&quot; =3D &quot;yes&quot; ]; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        lwip_client_count=3D$(echo &quot;$lwip_=
test_names&quot;|wc -w|tr -d &quot; &quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        lwip_client_count=3D$(echo &quot;$lwip_test=
_names&quot; | wc -w | tr -d &quot; &quot;)</span><br><span>     else</span=
><br><span>         lwip_client_count=3D0</span><br><span>     fi</span><br=
><span>@@ -60,10 +64,10 @@</span><br><span>     count=3D0</span><br><span> =
    maxcount=3D10</span><br><span>     while [ $count -le $maxcount ]; do</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        lwip_client_ips=
=3D$(cat =2E/*=2Elwip 2&gt;/dev/null|wc -l)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        lwip_client_ips=3D$(cat =2E/*=2Elwip 2&gt;/=
dev/null | wc -l)</span><br><span>         if [ $lwip_client_ips -lt $lwip_=
client_count ]; then</span><br><span>             echo &quot;Waiting for LW=
IP clients to start up ($count/$maxcount)&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            count=3D$(( count + 1))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            count=3D$((count + 1)=
)</span><br><span>             sleep 1</span><br><span>         else</span>=
<br><span>             echo &quot;$lwip_client_ips/$lwip_client_count LWIP =
clients up&quot;</span><br><span>@@ -73,8 +77,8 @@</span><br><span> </span>=
<br><span>     wait_pids=3D&quot;&quot;</span><br><span>     for line in $(=
cat =2E/*=2Elwip 2&gt;/dev/null); do</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        target_ip=3D$(echo $line|cut -d &quot;,&quot; -f 1)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        client_pid=3D$=
(echo $line|cut -d &quot;,&quot; -f 2)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        target_ip=3D$(echo $line | cut -d &quot;,&quot; =
-f 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=
_pid=3D$(echo $line | cut -d &quot;,&quot; -f 2)</span><br><span>         p=
ing_and_kill $target_ip $client_pid &amp;</span><br><span>         wait_pid=
s=3D&quot;$wait_pids $!&quot;</span><br><span>     done</span><br><span>@@ =
-84,7 +88,8 @@</span><br><span>     test -e =2E/lwip_failed &amp;&amp; retu=
rn 1 || return 0</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-wait_for_results() {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+wait_for_results()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span>     tests_running=3D&q=
uot;yes&quot;</span><br><span> </span><br><span>     # Wait a bit to allow =
an OpenVPN client process to create a pidfile to</span><br><span>@@ -106,12=
 +111,13 @@</span><br><span>     done</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_client_test_result=
() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_client_test=
_result()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span>     test_name=3D$1</span><br><span>     should_pass=3D$2</span><br=
><span>     log=3D&quot;${test_name}=2Elog&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quot;Initialization =
Sequence Completed&quot; &quot;${t_server_null_logdir}/${log}&quot; &gt; /d=
ev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    grep &qu=
ot;Initialization Sequence Completed&quot; &quot;${t_server_null_logdir}/${=
log}&quot; &gt;/dev/null</span><br><span>     exit_code=3D$?</span><br><spa=
n> </span><br><span>     if [ $exit_code -eq 0 ] &amp;&amp; [ &quot;${shoul=
d_pass}&quot; =3D &quot;yes&quot; ]; then</span><br><span>@@ -144,7 +150,7 =
@@</span><br><span> server_max_wait=3D15</span><br><span> while [ $count -l=
t $server_max_wait ]; do</span><br><span>     servers_up=3D0</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    server_count=3D$(echo &quot;$TES=
T_SERVER_LIST&quot;|wc -w|tr -d &quot; &quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    server_count=3D$(echo &quot;$TEST_SERVER_LIS=
T&quot; | wc -w | tr -d &quot; &quot;)</span><br><span> </span><br><span>  =
   # We need to trim single-quotes because some shells return quoted values=
</span><br><span>     # and some don&#39;t=2E Using &quot;set -o posix&quot=
; which would resolve this problem is</span><br><span>@@ -152,13 +158,13 @@=
</span><br><span>     #</span><br><span>     # While inactive server config=
urations may get checked they won&#39;t increase</span><br><span>     # the=
 active server count as the processes won&#39;t be running=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for i in $(set|grep &#39;SERVER=
_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&quot;); do</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pid=3D$(ca=
t &quot;$i=2Epid&quot; 2&gt; /dev/null)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if [ -z &quot;$server_pid&quot; ] ; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for i in $(set | grep &#=
39;SERVER_NAME_&#39; | cut -d &quot;=3D&quot; -f 2 | tr -d &quot;[\&#39;]&q=
uot;); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
rver_pid=3D$(cat &quot;$i=2Epid&quot; 2&gt;/dev/null)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;$server_pid&quot; ]=
; then</span><br><span>             continue</span><br><span>         fi</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if $RUN_SUDO kil=
l -0 $server_pid &gt; /dev/null 2&gt;&amp;1; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            servers_up=3D$(( $servers_up + 1 ))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if $RUN_SUD=
O kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            servers_up=3D$(($servers_up +=
 1))</span><br><span>         fi</span><br><span>     done</span><br><span>=
 </span><br><span>@@ -168,7 +174,7 @@</span><br><span>         retval=3D0</=
span><br><span>         break</span><br><span>     else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        count=3D$(( count + 1))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        count=3D$((count + 1)=
)</span><br><span>         sleep 1</span><br><span>     fi</span><br><span>=
 </span><br><span>@@ -199,15 +205,14 @@</span><br><span> # safe to check th=
e test results=2E</span><br><span> test_names=3D&quot;&quot;</span><br><spa=
n> lwip_test_names=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
or SUF in $TEST_RUN_LIST; do</span><br><span>     eval test_name=3D\&quot;\=
$TEST_NAME_$SUF\&quot;</span><br><span>     eval client_exec=3D\&quot;\$CLI=
ENT_EXEC_$SUF\&quot;</span><br><span>     eval client_conf=3D\&quot;\$CLIEN=
T_CONF_$SUF\&quot;</span><br><span> </span><br><span>     test_names=3D&quo=
t;${test_names} ${test_name}&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if echo &quot;$test_name&quot;|grep -q =
_lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if e=
cho &quot;$test_name&quot; | grep -q _lwip; then</span><br><span>         l=
wip_test_names=3D&quot;${lwip_test_names} ${test_name}&quot;</span><br><spa=
n>     fi</span><br><span> </span><br><span>@@ -219,13 +224,11 @@</span><br=
><span> ping_lwip_clients</span><br><span> retval=3D$?</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # Wait=
 until all OpenVPN clients have exited</span><br><span> (wait_for_results)<=
/span><br><span> </span><br><span> # Check test results</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_RUN_LIST</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+for SUF in $TEST_RUN_LIST; do</span><br><span>     eva=
l test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     eval shou=
ld_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</span><br><span> </span><br><spa=
n>diff --git a/tests/t_server_null_server=2Esh b/tests/t_server_null_server=
=2Esh</span><br><span>index 65b7d56=2E=2E0297740 100755</span><br><span>---=
 a/tests/t_server_null_server=2Esh</span><br><span>+++ b/tests/t_server_nul=
l_server=2Esh</span><br><span>@@ -1,6 +1,7 @@</span><br><span> #!/bin/sh</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-launch=
_server() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+launch_s=
erver()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span>     server_name=3D$1</span><br><span>     server_exec=3D$2</span><br=
><span>     server_conf=3D$3</span><br><span>@@ -13,10 +14,10 @@</span><br>=
<span> </span><br><span>     # Try to launch the server</span><br><span>   =
  $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-               $server_conf \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-               --status &quot;${status}&quot; 1 =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               --wri=
tepid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-               --explicit-exit-notify 3 &gt; &quot;$log&quot; 2&gt;&am=
p;1 &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        $s=
erver_conf \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 --status &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        --writepid &quot;${pid}&quot; \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        --explicit-exit-notify 3 &gt;&q=
uot;$log&quot; 2&gt;&amp;1 &amp;</span><br><span> </span><br><span>     sle=
ep 1</span><br><span> </span><br><span>@@ -40,8 +41,7 @@</span><br><span> r=
etval=3D0</span><br><span> </span><br><span> # Launch test servers</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVER_LIST</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do</span><=
br><span>     eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br=
><span>     eval server_exec=3D\&quot;\$SERVER_EXEC_$SUF\&quot;</span><br><=
span>     eval server_conf=3D\&quot;\$SERVER_CONF_$SUF\&quot;</span><br><sp=
an>@@ -53,8 +53,7 @@</span><br><span> # the test run=2E</span><br><span> #<=
/span><br><span> export server_pid_files=3D&quot;&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-for SUF in $TEST_SERVER_LIST</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_LIST; do</span><br><span>  =
   eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span>    =
 server_pid_files=3D&quot;${server_pid_files} =2E/${server_name}=2Epid&quot=
;</span><br><span> done</span><br><span>@@ -65,12 +64,11 @@</span><br><span=
> count=3D0</span><br><span> maxcount=3D4</span><br><span> while [ $count -=
le $maxcount ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if ls t_server_null_client=2Esh*=2Epid &gt; /dev/null 2&gt;&amp;1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if ls t_server_null_client=2Esh*=2Epi=
d &gt;/dev/null 2&gt;&amp;1; then</span><br><span>         count=3D0</span>=
<br><span>         sleep 1</span><br><span>     else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	count=3D$(( count + 1))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        count=3D$((count + 1))</span><=
br><span>         sleep 1</span><br><span>     fi</span><br><span> done</sp=
an><br><span>@@ -81,11 +79,10 @@</span><br><span> # server process does not=
 exit in 15 seconds assume it never will, move on and</span><br><span> # ho=
pe for the best=2E</span><br><span> echo &quot;Waiting for servers to exit&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for PID_FILE in =
$server_pid_files</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+for PID_FILE in $serv=
er_pid_files; do</span><br><span>     SERVER_PID=3D$(cat &quot;${PID_FILE}&=
quot;)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if [ -z &quot;$SERVER_PID&quot; ] ; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if [ -z &quot;$SERVER_PID&quot; ]; then</sp=
an><br><span>         echo &quot;WARNING: could not kill server ${PID_FILE}=
!&quot;</span><br><span>         continue</span><br><span>     fi</span><br=
><span>@@ -95,17 +92,16 @@</span><br><span> </span><br><span>     count=3D0=
</span><br><span>     maxcount=3D75</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    while [ $count -le $maxcount ]</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        $RUN_SUDO kill -0 &quot;${SERVER_PID}&quot; 2&gt; /dev/=
null || break</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
count=3D$(( count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while [ $count -le $maxcount ]; do</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        $RUN_SUDO kill -0 &quot;${SERVER_PID}&quot; =
2&gt;/dev/null || break</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        count=3D$((count + 1))</span><br><span>         sleep 0=2E2</sp=
an><br><span>     done</span><br><span> </span><br><span>     # If server i=
s still up send a SIGKILL</span><br><span>     if [ $count -ge $maxcount ];=
 then</span><br><span>         $RUN_SUDO $KILL_EXEC -9 &quot;${SERVER_PID}&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        SERVER_N=
AME=3D$(basename $PID_FILE|cut -d =2E -f 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        SERVER_NAME=3D$(basename $PID_FILE | cut -d=
 =2E -f 1)</span><br><span>         echo &quot;ERROR: had to send SIGKILL t=
o server ${SERVER_NAME} with pid ${SERVER_PID}!&quot;</span><br><span>     =
    echo &quot;Tail of server log:&quot;</span><br><span>         tail -n 2=
0 &quot;${t_server_null_logdir}/${SERVER_NAME}=2Elog&quot;</span><br><span>=
diff --git a/tests/t_server_null_stress=2Esh b/tests/t_server_null_stress=
=2Esh</span><br><span>index 0bb9452=2E=2E2fc9fde 100755</span><br><span>---=
 a/tests/t_server_null_stress=2Esh</span><br><span>+++ b/tests/t_server_nul=
l_stress=2Esh</span><br><span>@@ -7,8 +7,7 @@</span><br><span> =2E =2E/t_se=
rver_null_default=2Erc</span><br><span> </span><br><span> export pid_files=
=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for SU=
F in $TEST_SERVER_LIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST=
_SERVER_LIST; do</span><br><span>     eval server_name=3D\&quot;\$SERVER_NA=
ME_$SUF\&quot;</span><br><span>     pid_files=3D&quot;${pid_files} =2E/${se=
rver_name}=2Epid&quot;</span><br><span> done</span><br><span>@@ -18,16 +17,=
16 @@</span><br><span> </span><br><span> count=3D0</span><br><span> while [=
 $count -lt $ITERATIONS ]; do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    count=3D$(( count + 1 ))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D &gt; /d=
ev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    count=3D$((count + 1))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    make check TESTS=3Dt_server_null=2Esh SUBDIRS=3D &gt;/dev/null 2=
&gt;&amp;1</span><br><span>     retval=3D$?</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;Iteration ${count}: =
return value ${retval}&quot; &gt;&gt; &quot;${LOG_BASEDIR}/make-check=2Elog=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quo=
t;Iteration ${count}: return value ${retval}&quot; &gt;&gt;&quot;${LOG_BASE=
DIR}/make-check=2Elog&quot;</span><br><span>     if [ $retval -ne 0 ]; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	DIR=3D&quot;${LOG_BA=
SEDIR}/make-check-${count}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        DIR=3D&quot;${LOG_BASEDIR}/make-check-${count}&quot;</=
span><br><span>         mkdir -p &quot;${DIR}&quot;</span><br><span>       =
  cp t_server_null*=2Elog &quot;${DIR}/&quot;</span><br><span>         cp t=
est-suite=2Elog &quot;${DIR}/&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        ps aux|grep openvpn|grep -vE &#39;(suppress|grep)&#39=
; &gt; &quot;${DIR}/psaux&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ps aux | grep openvpn | grep -vE &#39;(suppress|grep)&#=
39; &gt;&quot;${DIR}/psaux&quot;</span><br><span>     fi</span><br><span> d=
one</span><br><span>diff --git a/tests/update_t_client_ips=2Esh b/tests/upd=
ate_t_client_ips=2Esh</span><br><span>index 96e3826=2E=2E777a286 100755</sp=
an><br><span>--- a/tests/update_t_client_ips=2Esh</span><br><span>+++ b/tes=
ts/update_t_client_ips=2Esh</span><br><span>@@ -5,12 +5,12 @@</span><br><sp=
an> </span><br><span> RC=3D&quot;$TOP_BUILDDIR/t_client_ips=2Erc&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-grep EXP=
ECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC =
&gt;/dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG4_=
$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $RC</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    echo &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifcon=
fig_local&quot; &gt;&gt;$RC</span><br><span> fi</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-grep EXPECT_IFCONFIG6_$TESTNUM=
=3D $RC &gt; /dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&am=
p;1</span><br><span> if [ $? -ne 0 ]; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_i=
pv6_local&quot; &gt;&gt; $RC</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    echo &quot;EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local&qu=
ot; &gt;&gt;$RC</span><br><span> fi</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=
=3Demail">change 1793</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1793?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1793 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--JBN86vR/KqM=--


--===============3921460981439108095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3921460981439108095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3921460981439108095==--

