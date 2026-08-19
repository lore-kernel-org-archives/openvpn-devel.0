Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A7FC5DF85
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lj9qpxTt0Hqaz/kMxu2szio68b7MobujuC1xgG4C2ig=; b=PTCtLSTzah/gRxLD2EyWlTMFUQ
	txxv4bmwvs8KiH1rG32OTDuVDzymxMa8BAuWdLNgCVzr9MO4iW4GKp7JtnkzwTvpUuPkDEjF1sOvQ
	LWcnEOccZy4tOuE1GzcHpCA89SspA4NP5VTy257mVm75Mgtj/Ju0d6htCUg0wgjnQrpw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwkCr-0006Ak-20;
	Wed, 19 Aug 2026 17:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwkCn-0006AT-8I
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 17:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=L75/uzx/RBig01J6YZpUjZspH6H8Y0FpitGkX2RRSZY=; b=PzBWlBDh/p/mOASybvzGc/RZbL
 TCafufAbDvzkg034wDhKG1LWxHrU/fZdTIw+woUri2G5mh69x/5xI//+nX5oCU/U6YTRIkjUZjk0d
 PqeFqiV9/qxl2D5tYggY4s7mLyWr/C7R3Q/KKdDRmmbJehhq55Os2GpoQDv6WpbAt1xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L75/uzx/RBig01J6YZpUjZspH6H8Y0FpitGkX2RRSZY=; b=C
 YMSdgEaprverv1kmW7Dhma5aobSOhdK4+xqgRM2u8Rsnef+McTr4ZBhsrRtcP5ksDxf37S6QPXEEy
 vpbs0Hwu9lfTb8stdRGO+P8NhYdW2ze9+CKRkTjjOiMgT9moZBBg9aq2RO9+uxOBFCFfTONUnRTps
 aZ8+9tEM4DlEE+Ss=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwkCk-00064E-2u for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 17:36:00 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so212564266b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787160951; x=1787765751; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L75/uzx/RBig01J6YZpUjZspH6H8Y0FpitGkX2RRSZY=;
 b=gLpPwaGH9SRqnROnddwnTyr6uaJkzbkH2WjhnZK4IEjZY6lbLeNhwNCKl+X9KwPbK/
 B7OVdyWsYg6YAE5rDJBtp9FFUb57DcoZt4MWlvzAbHwjU1TPx0AR1rkwu13G41GJD2Qu
 c/mX+bRAMqMhb+Nv0vbK36Ws243UVYxMFH8WWYIdhD4Tp9ACf3UmIV2PaVwANL1P9siq
 5JNRTelHni4z/NOkxrfxAwR0EJUEXawCRpyiCTJEBMtn7aWq5dSCV5hW6TFAjpqpspOt
 1GyxeDq4HnbihMzt4/vsF/Tp5a35gB0PRHMoUridptJQbcJMDQpsMUKtivhtN/CDlF2y
 cMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787160951; x=1787765751;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L75/uzx/RBig01J6YZpUjZspH6H8Y0FpitGkX2RRSZY=;
 b=FNt2IkurtYcxZkDpp6mLjxl4A41phcImemWslCxO1EjvjA77ul3Vr2wabz2KNcx7bQ
 IT7Z/HeTEdbZz7O/x55Z27q8A41glRqFMxDJ7u50vfavfIPGSanGiGbypjNrVToUEbJ9
 juoK8iOQvIYLJbq6BQKFKE9tPZh8notxV4HkimtjYdQT58GcTaosh4RyE6j5Hw7AMflh
 b6NuSo13etWv4tNuuzJzkKDPf2VXipkY5IetjVBZ87Ne5s6VcW4CuFu5D14uK9LWRnht
 dF5Di5JMkqLXB8rj6u1tnqHgrwVmWCTPG037C5sLDO9WZ8uzbpxms52Yyt7BZnvApeoG
 1Ocw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCXpAgkIU7ZW7Hk5dHS9AQ7/KJTQM9BZpTjglb3ywTbFW4asj5q2P+HKLf1FkPf/1gPXYqgWtzQpT6CjM6@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw5UyddCkdKzhIxEOkKejWYj/s9gttoM23oxSIi2GoyY31f7dS7
 dtbGow+flR+dSJgjvvjHwjTUeqM15nlhfiqo9iHcoa2rKrBIrnrJf5aEzVZxUWDAXr8/3WfUL1G
 q13z8FBKQk/P1W+6h/M3BgPk6/PAaqj0H+r9vQHrS+zhzEpxULA9kaZJSkaJbafHJ7prlmW0wxr
 tJ2k/vaw==
X-Gm-Gg: AR+sD10iG+wz1XJqV2YiEClumdanvspCoihqkcydfNpbTT0J/J4fF4Euvm739TcQpCJ
 ayEtBQfp7OJs6ioYTbqtqUm4jFaz+rWE45X0oOmWGffWTCNL8Dhbz6S8xmHQHa2J4XD2GeyfUca
 ZPEwICauNwKpi3bPmmr8/F2KyOgUai4YmaRo8Rrz80G9KBgNJQ7cdQsX7KWKFHDaDWZzCL6IRq/
 8ZQsi8wDM1LnMHIBuEb7lqBE0LDGoV0vzV7z9vEBDjUuAjMMknzYzLVARPSIOH4pxbUeVd8Jut9
 mCoCIL+6dxFW0XMEEEKmkLjh/rmutwxWowlbl1CT9dk+g2BqM6DnYCWlUZoXjrkDWY5jn4jSK/3
 YL/GdcophGZ766C6lmugjb5Y7yyBbNEbKDszE0RDQrZNQ6LFzEsS/LpFprAWDcXvnsO3KXHaypC
 /q90yHTpKK72d2jhDiPLMzmkYqI9SzIKv0MdNS7+6s5CUv0TAa6FCS0afeBCw1mr4Y07gMWTttu
 VqRW1vxB1We9qRMl6vV8ezyq9crTjHW41Z+h2ddQSJXPnxGAJiUvbiNDh+YjGF/XmwkwkSpR5f2
 4dQIDpRUTd7Gw8Kr8Uzy4sNop41JlvMq+A+quxtzm5fEd8Xfl7Q=
X-Received: by 2002:a05:600c:8b62:b0:499:a6ae:20a1 with SMTP id
 5b1f17b1804b1-499aa1dc5b6mr114294205e9.14.1787151798294; 
 Wed, 19 Aug 2026 08:03:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9aa7e8dsm38807355e9.0.2026.08.19.08.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:03:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:03:17 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 2b3df1ed0f0207a1df6ffa4640457655ab2aa10c
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4abe2600103f23e8a86dde75282fcf68bd5f9db-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwkCk-00064E-2u
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 gen-release-tarballs.sh: Remove
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
Content-Type: multipart/mixed; boundary="===============7064344175411010748=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7064344175411010748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iNqOrNIoGd8="; charset=UTF-8

--iNqOrNIoGd8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1847?usp=3Demail )

Change subject: gen-release-tarballs=2Esh: Remove
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-release-t=
arballs=2Esh: Remove

This is unused (all our releases use code in openvpn-=
build
repository instead) and of doubtful use=2E E=2Eg=2E why would we
need=
 three different tarballs for releases?

It also has small issues like usin=
g a /bin/sh shebang but
containing bashisms=2E

So get rid of the dead code=
=2E

Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847=

Message-Id: <20260819132652=2E24207-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38509=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
D dev-too=
ls/gen-release-tarballs=2Esh
1 file changed, 0 insertions(+), 246 deletions=
(-)




diff --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-re=
lease-tarballs=2Esh
deleted file mode 100755
index 6071b57=2E=2E0000000
---=
 a/dev-tools/gen-release-tarballs=2Esh
+++ /dev/null
@@ -1,246 +0,0 @@
-#!/=
bin/sh
-# gen-release-tarballs=2Esh  -  Generates release tarballs with sig=
natures
-#
-# Copyright (C) 2017-2026 - David Sommerseth <davids@openvpn=2E=
net>
-#
-# This program is free software; you can redistribute it and/or
-#=
 modify it under the terms of the GNU General Public License
-# as publishe=
d by the Free Software Foundation; either version 2
-# of the License=2E
-#=

-# This program is distributed in the hope that it will be useful,
-# but =
WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
-# GNU General Public Li=
cense for more details=2E
-#
-# You should have received a copy of the GNU =
General Public License
-# along with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
-#
-set -u
-
-if [ $# -ne 4 ]; then
-    echo "U=
sage: $0 <remote-name> <tag-name> <sign-key> <dest-dir>"
-    echo ""
-    =
echo "   remote-name  -- valid remotes: `git remote | tr \\\n ' '`"
-    ec=
ho "   tag-name     -- An existing release tag"
-    echo "   sign-key     =
-- PGP key used to sign all files"
-    echo "   dest-dir     -- Where to p=
ut the complete set of release tarballs"
-    echo ""
-    echo "   Example=
: $0 origin v2=2E4=2E2 /tmp/openvpn-release"
-    echo
-    exit 1
-fi
-
-a=
rg_remote_name=3D"$1"
-arg_tag_name=3D"$2"
-arg_sign_key=3D"$3"
-arg_dest_d=
ir=3D"$4"
-
-#
-# Sanity checks
-#
-
-# Check that the tag exists
-git tag =
| grep "$arg_tag_name" 1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERR=
OR **  The tag '$arg_tag_name' does not exist"
-    exit 2
-fi
-
-# Extract=
 the git URL
-giturl=3D"`git remote get-url $arg_remote_name 2>/dev/null`"
=
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Invalid git remote name: $arg=
_remote_name"
-    exit 2
-fi
-
-# Check we have the needed signing key
-ec=
ho "test" | gpg -a --clearsign -u "$arg_sign_key" 2>/dev/null 1>/dev/null
-=
if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed when testing the PGP si=
gning=2E  Wrong signing key?"
-    exit 2;
-fi
-
-
-#
-# Helper functions
-=
#
-
-get_filename()
-{
-    local wildcard=3D"$1"
-
-    res=3D"`find =2E -=
maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-`"
-    if =
[ $? -ne 0 ]; then
-        echo "-- 'find' failed=2E"
-        exit 5
-   =
 fi
-    if [ -z "$res" ]; then
-        echo "-- Could not find a file wit=
h the wildcard: $wildcard"
-        exit 4
-    fi
-    echo "$res"
-}
-
-c=
opy_files()
-{
-    local fileext=3D"$1"
-    local dest=3D"$2"
-
-    file=
=3D"`get_filename openvpn-*=2E*=2E*=2E$fileext`"
-    if [ -z "$file" ]; th=
en
-        echo "** ERROR Failed to find source file"
-        exit 5
-   =
 fi
-    echo "-- Copying $file"
-    cp "$file" "$dest"
-    if [ $? -ne 0=
 ]; then
-        echo "** ERROR ** Failed to copy $file to $destdir"
-    =
    exit 3;
-    fi
-}
-
-sign_file()
-{
-    local signkey=3D"$1"
-    loc=
al srchfile=3D"$2"
-    local signtype=3D"$3"
-    local file=3D"`get_filen=
ame $srchfile`"
-
-    echo "-- Signing $file =2E=2E=2E"
-    case "$signty=
pe" in
-        inline)
-            # Have the signature in the same file =
as the data
-            gpg -a --clearsign -u "$signkey" "$file" 2>/dev/nu=
ll
-            res=3D$?
-            if [ $res -eq 0 ]; then
-            =
    rm -f "$file"
-            fi
-            ;;
-
-        detached)
-   =
         # Have the signature in a separate file
-            gpg -a --deta=
ch-sign -u "$signkey" "$file" 2>/dev/null
-            res=3D$?
-          =
  ;;
-
-        *)
-            echo "** ERROR **  Unknown signing type \"$=
signtype\"=2E"
-            exit 4;
-    esac
-
-    if [ $res -ne 0 ]; the=
n
-        echo "** ERROR **  Failed to sign the file $PWD/$file"
-        =
exit 4;
-    fi
-}
-
-
-#
-# Preparations
-#
-
-# Create the destination di=
rectory, using a sub-dir with the tag-name
-destdir=3D""
-case "$arg_dest_d=
ir" in
-    /*) # Absolute path
-        destdir=3D"$arg_dest_dir/$arg_tag_=
name"
-        ;;
-    *)  # Make absolute path from relative path
-       =
 destdir=3D"$PWD/$arg_dest_dir/$arg_tag_name"
-        ;;
-esac
-echo "-- D=
estination directory: $destdir"
-if [ -e "$destdir" ]; then
-    echo "** E=
RROR ** Destination directory already exists=2E  "
-    echo "            P=
lease check your command line carefully=2E"
-    exit 2
-fi
-
-mkdir -p "$d=
estdir"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed to create dest=
ination directory"
-    exit 2
-fi
-
-#
-# Start the release process
-#
-
-=
# Clone the remote repository
-workdir=3D"`mktemp -d -p /var/tmp openvpn-bu=
ild-release-XXXXXX`"
-cd $workdir
-echo "-- Working directory: $workdir"
-e=
cho "-- git clone $giturl"
-git clone $giturl openvpn-gen-tarball 2> "$work=
dir/git-clone=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  gi=
t clone failed=2E  See $workdir/git-clone=2Elog for details"
-    exit 3;
-=
fi
-cd openvpn-gen-tarball
-
-# Check out the proper release tag
-echo "-- =
Checking out tag $arg_tag_name =2E=2E=2E "
-git checkout -b mkrelease "$arg=
_tag_name" 2> "$workdir/git-checkout-tag=2Elog" 1>&2
-if [ $? -ne 0 ]; then=

-    echo "** ERROR **  git checkout failed=2E  See $workdir/git-checkout-=
tag=2Elog for details"
-    exit 3;
-fi
-
-# Prepare the source tree
-echo =
"-- Running autoreconf + a simple configure =2E=2E=2E "
-(autoreconf -vi &&=
 =2E/configure) 2> "$workdir/autotools-prep=2Elog" 1>&2
-if [ $? -ne 0 ]; t=
hen
-    echo "** ERROR **  Failed running autotools=2E  See $workdir/autot=
ools-prep=2Elog for details"
-    exit 3;
-fi
-
-# Generate the tar/zip fil=
es
-echo "-- Running make distcheck (generates =2Etar=2Egz) =2E=2E=2E "
-(m=
ake distcheck) 2> "$workdir/make-distcheck=2Elog" 1>&2
-if [ $? -ne 0 ]; th=
en
-    echo "** ERROR **  make distcheck failed=2E  See $workdir/make-dist=
check=2Elog for details"
-    exit 3;
-fi
-copy_files tar=2Egz "$destdir"
-=

-echo "-- Running make dist-xz (generates =2Etar=2Exz) =2E=2E=2E "
-(make =
dist-xz) 2> "$workdir/make-dist-xz=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    =
echo "** ERROR **  make dist-xz failed=2E  See $workdir/make-dist-xz=2Elog =
for details"
-    exit 3;
-fi
-copy_files tar=2Exz "$destdir"
-
-echo "-- R=
unning make dist-zip (generates =2Ezip) =2E=2E=2E "
-(make dist-zip) 2> "$w=
orkdir/make-dist-zip=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR=
 **  make dist-zip failed=2E  See $workdir/make-dist-zip=2Elog for details"=

-    exit 3;
-fi
-copy_files zip "$destdir"
-
-# Generate SHA256 checksums=

-cd "$destdir"
-sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip > "ope=
nvpn-$arg_tag_name=2Esha256sum"
-
-# Sign all the files
-echo "-- Signing f=
iles =2E=2E=2E "
-sign_file "$arg_sign_key" "openvpn-$arg_tag_name=2Esha256=
sum" inline
-sign_file "$arg_sign_key" "openvpn-*=2Etar=2Egz" detached
-sig=
n_file "$arg_sign_key" "openvpn-*=2Etar=2Exz" detached
-sign_file "$arg_sig=
n_key" "openvpn-*=2Ezip" detached
-
-# Create a tar-bundle with everything
=
-echo "-- Creating final tarbundle with everything =2E=2E=2E"
-tar cf "open=
vpn-$arg_tag_name=2Etar" openvpn-*=2E{tar=2Egz,tar=2Exz,zip}{,=2Easc} openv=
pn-*=2Esha256sum=2Easc
-
-echo "-- Cleaning up =2E=2E=2E"
-# Save the log f=
iles
-mkdir -p "$destdir/logs"
-mv $workdir/*=2Elog "$destdir/logs"
-
-# Fi=
nally, done!
-rm -rf "$workdir"
-echo "-- Done"
-exit 0

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879=

Gerrit-Change-Number: 1847
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: raz=
vanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--iNqOrNIoGd8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1847?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">gen-release-tarballs=2Esh: Remove<br><br>T=
his is unused (all our releases use code in openvpn-build<br>repository ins=
tead) and of doubtful use=2E E=2Eg=2E why would we<br>need three different =
tarballs for releases?<br><br>It also has small issues like using a /bin/sh=
 shebang but<br>containing bashisms=2E<br><br>So get rid of the dead code=
=2E<br><br>Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1847<br>Message-Id: &lt;20260819132652=2E24207-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg38509=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D dev-tools/gen-release-tarbal=
ls=2Esh<br>1 file changed, 0 insertions(+), 246 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release=
-tarballs=2Esh</span><br><span>deleted file mode 100755</span><br><span>ind=
ex 6071b57=2E=2E0000000</span><br><span>--- a/dev-tools/gen-release-tarball=
s=2Esh</span><br><span>+++ /dev/null</span><br><span>@@ -1,246 +0,0 @@</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# gen-release-tarballs=2Esh  -  Genera=
tes release tarballs with signatures</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Cop=
yright (C) 2017-2026 - David Sommerseth &lt;davids@openvpn=2Enet&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# This program is free software; you can redistr=
ibute it and/or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# modi=
fy it under the terms of the GNU General Public License</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# as published by the Free Software Found=
ation; either version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# of the License=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# GNU General Public License for more d=
etails=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# You should have received a cop=
y of the GNU General Public License</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# along with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set -u</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-if [ $# -ne 4 ]; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;Usage: $0 &lt;remote-name&gt; &lt;tag-n=
ame&gt; &lt;sign-key&gt; &lt;dest-dir&gt;&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    echo &quot;   remote-name  -- valid remotes: =
`git remote | tr \\\n &#39; &#39;`&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    echo &quot;   tag-name     -- An existing release ta=
g&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot=
;   sign-key     -- PGP key used to sign all files&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   dest-dir     -- Where =
to put the complete set of release tarballs&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    echo &quot;   Example: $0 origin v2=2E4=2E2=
 /tmp/openvpn-release&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exi=
t 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-arg_remote_name=3D&quot;$1&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-arg_tag_name=3D&quot;$2&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-arg_sign_key=3D&quot;$3&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-arg_dest_dir=3D&quot;$4&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# Sanity checks</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# Check that the tag exists</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-git tag | grep &quot;$arg_tag=
_name&quot; 1&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    echo &quot;** ERROR **  The tag &#39;$arg_tag_name&#39; does not e=
xist&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# Extract the git URL</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-giturl=3D&quot;`git remote get-url $arg_remote_name 2&gt;/dev/=
null`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -n=
e 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &=
quot;** ERROR ** Invalid git remote name: $arg_remote_name&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Check =
we have the needed signing key</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-echo &quot;test&quot; | gpg -a --clearsign -u &quot;$arg_sign_key&=
quot; 2&gt;/dev/null 1&gt;/dev/null</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &quot;** ERROR ** Failed when testing the PGP signin=
g=2E  Wrong signing key?&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    exit 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-f=
i</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Helpe=
r functions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-get_filename()</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 local wildcard=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res=3D=
&quot;`find =2E -maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n=
1 | cut -d/ -f2-`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        echo &quot;-- &#39;find&#39; failed=2E&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        exit 5</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if [ -z &quot;$res&quot; ]; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        echo &quot;-- Could not find a file=
 with the wildcard: $wildcard&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        exit 4</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo=
 &quot;$res&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-copy_files()</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    local fileext=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    local dest=3D&quot;$2&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    file=3D&quot;`get_filename openvpn-*=2E*=2E*=2E$fileext`&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$file&q=
uot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
cho &quot;** ERROR Failed to find source file&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        exit 5</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    echo &quot;-- Copying $file&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    cp &quot;$file&quot; &quot;$dest&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $? -ne 0 ]; then</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;** ER=
ROR ** Failed to copy $file to $destdir&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        exit 3;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-sign_file()</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    local signkey=3D&quot;$1&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    local srchfile=3D&quot;$2&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    local signtype=3D&quot;$3&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    local file=3D&quot;`get=
_filename $srchfile`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;-=
- Signing $file =2E=2E=2E&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    case &quot;$signtype&quot; in</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        inline)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            # Have the signature in the same file as the da=
ta</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gpg -a =
--clearsign -u &quot;$signkey&quot; &quot;$file&quot; 2&gt;/dev/null</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            res=3D$?</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if [ $res -eq 0 ]=
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 rm -f &quot;$file&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        detached)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            # Have the signature in =
a separate file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      gpg -a --detach-sign -u &quot;$signkey&quot; &quot;$file&quot; 2&gt;/=
dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
es=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        *)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            echo &quot;** ERROR **  Unknown signing t=
ype \&quot;$signtype\&quot;=2E&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            exit 4;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $res -ne 0 ]=
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &q=
uot;** ERROR **  Failed to sign the file $PWD/$file&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        exit 4;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# Preparations</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Create the destination directory, =
using a sub-dir with the tag-name</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-destdir=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-case &quot;$arg_dest_dir&quot; in</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /*) # Absolute path</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        destdir=3D&quot;$arg_dest_dir/$arg_tag_n=
ame&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *)  # Make absolute=
 path from relative path</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        destdir=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-esac</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-echo &quot;-- Destination directory: $destdir&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -e &quot;$destdir&quot; =
]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot=
;** ERROR ** Destination directory already exists=2E  &quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;            Please ch=
eck your command line carefully=2E&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    exit 2</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-mkdir -p &quot;$destdir&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR =
** Failed to create destination directory&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# Start the release process</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# C=
lone the remote repository</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-workdir=3D&quot;`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd $workdir</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Working direc=
tory: $workdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-e=
cho &quot;-- git clone $giturl&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-git clone $giturl openvpn-gen-tarball 2&gt; &quot;$workdir/g=
it-clone=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    echo &quot;** ERROR **  git clone failed=2E  See $workdir/gi=
t-clone=2Elog for details&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    exit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd openvpn-gen-tarb=
all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# Check out the proper release tag</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Checking out=
 tag $arg_tag_name =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-git checkout -b mkrelease &quot;$arg_tag_name&quot; 2&gt; &qu=
ot;$workdir/git-checkout-tag=2Elog&quot; 1&gt;&amp;2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  git checkout fa=
iled=2E  See $workdir/git-checkout-tag=2Elog for details&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Prepar=
e the source tree</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo=
 &quot;-- Running autoreconf + a simple configure =2E=2E=2E &quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-(autoreconf -vi &amp;&amp; =2E=
/configure) 2&gt; &quot;$workdir/autotools-prep=2Elog&quot; 1&gt;&amp;2</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR *=
*  Failed running autotools=2E  See $workdir/autotools-prep=2Elog for detai=
ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# Generate the tar/zip files</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-echo &quot;-- Running make distcheck (generates =2Etar=
=2Egz) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-(make distcheck) 2&gt; &quot;$workdir/make-distcheck=2Elog&quot; 1&gt;&am=
p;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** =
ERROR **  make distcheck failed=2E  See $workdir/make-distcheck=2Elog for d=
etails&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit =
3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-copy_files tar=2Egz &quot;$destdir&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Running make dist-xz (gene=
rates =2Etar=2Exz) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-(make dist-xz) 2&gt; &quot;$workdir/make-dist-xz=2Elog&quot; =
1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -n=
e 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &=
quot;** ERROR **  make dist-xz failed=2E  See $workdir/make-dist-xz=2Elog f=
or details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
xit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-copy_files tar=2Exz &quot;$destdir=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Running make dist-zip =
(generates =2Ezip) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-(make dist-zip) 2&gt; &quot;$workdir/make-dist-zip=2Elog&quot=
; 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? =
-ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo=
 &quot;** ERROR **  make dist-zip failed=2E  See $workdir/make-dist-zip=2El=
og for details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   exit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-copy_files zip &quot;$destdir&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# Generate SHA256 checksums</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-cd &quot;$destdir&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-sha256sum openvpn-*=2Etar=2E{=
gz,xz} openvpn-*=2Ezip &gt; &quot;openvpn-$arg_tag_name=2Esha256sum&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# Sign all the files</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Signing files =2E=2E=2E &quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$arg=
_sign_key&quot; &quot;openvpn-$arg_tag_name=2Esha256sum&quot; inline</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_ke=
y&quot; &quot;openvpn-*=2Etar=2Egz&quot; detached</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;openv=
pn-*=2Etar=2Exz&quot; detached</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;openvpn-*=2Ezip&quot; de=
tached</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Create a tar-bundle with everythin=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Creati=
ng final tarbundle with everything =2E=2E=2E&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-tar cf &quot;openvpn-$arg_tag_name=2Etar&quot;=
 openvpn-*=2E{tar=2Egz,tar=2Exz,zip}{,=2Easc} openvpn-*=2Esha256sum=2Easc</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Cleaning up =2E=2E=2E&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Save the log files</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-mkdir -p &quot;$destdir/=
logs&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mv $workdir=
/*=2Elog &quot;$destdir/logs&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Finall=
y, done!</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm -rf &quot;=
$workdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &q=
uot;-- Done&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-exit=
 0</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">change 1847</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10b912bad3bb0b97e2=
b47eae20d2dd7ffb0c6879 </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--iNqOrNIoGd8=--


--===============7064344175411010748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7064344175411010748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7064344175411010748==--

