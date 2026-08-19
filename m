Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7A4C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBr07A267ieYRtmIx45ETZrooTkoloMYp/G9tdCmTe8=; b=Q04vbOGR06W3w0y7b7qtrfBGTK
	FaD64jTvdSAJnhCAvMHln/ZYlXRoV6YdOQ/skSxGWeKJDZIe3iusj2P3TzErI3UQgodEF1KX1ye5m
	BS3XVRFujg3YaU+xCKa54l/f2wb1yf0Vj//9VwVpsdpMLsedAGD+S+cGSqfWLuAC0uo8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwhwS-00032F-5c;
	Wed, 19 Aug 2026 15:11:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwhwA-00031r-6U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=calQpZwvMpoF/0G0pMR4jpan/G0kl83hJ3lQdvfJi38=; b=YM8+smuUE/hIDnBM36dpXydsXz
 oeBmGeHjg0xstgG2wS6ntZTbYaBIVW4Bb+YKuT/2fhG/i2/fdoeuA0tBDSh7XBmwAUat5RI4NDb5T
 I3CWBTD90aSD+FL8cgj+2GApw23QcHTCnd8E88aOtC37CuaGQ5FjYhbMxpcfk2Q3PKr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=calQpZwvMpoF/0G0pMR4jpan/G0kl83hJ3lQdvfJi38=; b=R
 AFQFzRrfwqcW81qQxsohdh6atO5BMNsf7Kdu91qj7cuP0PhjsKOWUf85xeStv6jdpLSGpXKHkuWf9
 jeyDTWGfn77Uzp+iCFWeJsj/vaZO29EtTtugdNGHSnX9e8T3iCDQcKh1+aHWRj9ewReExp088026D
 CNhAeCdfI0jzPiu0=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwhw1-00069A-Eo for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:10:37 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c16794450aeso158141566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787152227; x=1787757027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=calQpZwvMpoF/0G0pMR4jpan/G0kl83hJ3lQdvfJi38=;
 b=MVHAyVoKpFuCK/Dd4XfcQZ09SMK2qNkWkIEO96HnZW2kOYYB49ShYS4uS3l0kxUlSr
 lMbv+DrJnXTSKe99JCVkipv+uSqKSQaBrmqB8JPF8Ak6+raUNIXwlths6R8dT3QDKVZJ
 P+5pk3y7SEJmsi2M6o1uo/IVryIDJDS8UZKYaYEYeSqpj+CwjuOxq+PGjYpcCEciB8mc
 FKWt7aOKBIYnnZEdPUKFjwqzT+irSpdoaIGsO5nuWTN2es1ctBj8Ftzt2qzu4vNF/n7C
 pEkYeuyYFvL6avz5heuZepwBY5QiAl4Ox0PLrW/6UiTomNwcQW2mX2kVBm+4myBDlC0X
 SR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152227; x=1787757027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=calQpZwvMpoF/0G0pMR4jpan/G0kl83hJ3lQdvfJi38=;
 b=AYq6vGflD//QahWDDqC5sueWt+smaaNd027FUrb0RwPu/H8HGpDnJyXC9VK+9AVSx+
 hh0IwAirrlxFC9gqzrvM0uiiG+1Bi+b08a/UKvrNS53cNbFhQ5FBWL0R4mnA5vCnI74O
 qHPSCc6IGJPzgBhqh4Zzpv2m3plvPS3UTfqYAWJOYT/CT6P6sAhv5F59IuFPGMZL6vfE
 dvmMjQcHBWi3GCCm7iPRiY2GWjes5m40hpRdL8A3+m8udKBZIn+xjWRjE49RgHCwkzVd
 X4WSZYBS7JDgYZB+3jUYdc0M51pcrC00iwHaRCokr+ggtqQEJH+kpyksSn3zxxH5a/P1
 XOiQ==
X-Gm-Message-State: AOJu0YxQrDthZGBEUperJif7gYs/MHmb9uDlROgZs7XRHF9ht4fm9EY0
 SpTDvfdQuN/e2vnOIAoJWwIaXnrsHmcmNBW0P10LtK8x73nUn5wIrWLhCYCJDSEPey9t+XELTzt
 2x2G426WbLj7/NYim3MS0leGT4/+etBckbaFDsiPKeHSdJ6/yjrcQz8fH/TVHYDJPUxVnvMapSe
 +2LjxLfQ==
X-Gm-Gg: AR+sD13GME575asOjZJePlFuBJtvgQd0UpDVXO9O2L9AWDQAzDz4wgQPTN2QQr7ScpT
 e74AN3ihZdFCoAPcEkgGd0j0Dkhc7ki0nCuTKVpLLGveC2ot0aeXmGVFEGzmHx3nIEERhQ0CqKt
 SYARQdWUvqzaegTYOEwVzqA3AKRtjI6TqTPbJ7QXdBYiPpxc3MdgveulCQw8MxuatZIAlGv50mW
 hP6751f4UPz5/QB61e42eCwaqRqyq1S2FrzGddOYJolhWATO3BbmTsvsu62mlS6mJ4MSuOEyvKm
 uVrFsE1GBj8Elc4ktuj+gDJZAXS+UggQhGcvMhUp3Jzy0SFY53pzemQX9k2hABiAVZKJoaxUSsk
 2r6B+SL6m/8+HhNi5/IH0YHhDlu6tgSiPO5ZTzUyb+tAO3gqTiDLdc/J1ufT/E525ZiNccNABjY
 ifndRCYY7BpaNPUFrvD8kLWLVkGpope1pIaCTc3G8vdQOCGU2MPqkWQtTbM44aPmzNZx339xWxo
 btRbpbWbGZU1F7GD+CODbCroDVLAzwss3Li8NYjb3xWmTEH7hub9uKphu/Y18Dwa/lWIQv7jPXn
 9bA5+Yhkov/ORCMmMSgu7jWiOdvxY9afmESH0/jFUx3MG2jq7sA=
X-Received: by 2002:a05:600c:3f12:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-499aa0dd282mr103980505e9.0.1787151796986; 
 Wed, 19 Aug 2026 08:03:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9def415sm55317195e9.2.2026.08.19.08.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:03:15 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:03:14 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 2b3df1ed0f0207a1df6ffa4640457655ab2aa10c
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4abe2600103f23e8a86dde75282fcf68bd5f9db-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwhw1-00069A-Eo
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2738963899669880831=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2738963899669880831==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xq66QUTlXIU="; charset=UTF-8

--Xq66QUTlXIU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2, Code-Review+2 by razvanc


Change subject: gen-release-tarballs=
=2Esh: Remove
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


gen-release-tarballs=2Esh: Remove

This is unused (all our releases use c=
ode in openvpn-build
repository instead) and of doubtful use=2E E=2Eg=2E wh=
y would we
need three different tarballs for releases?

It also has small i=
ssues like using a /bin/sh shebang but
containing bashisms=2E

So get rid o=
f the dead code=2E

Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1847
Message-Id: <20260819132652=2E24207-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38509=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
D dev-tools/gen-release-tarballs=2Esh
1 file changed, 0 insertions(+)=
, 246 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/47/1847/4

diff --git a/dev-tools/gen-release-tarballs=2Esh b/=
dev-tools/gen-release-tarballs=2Esh
deleted file mode 100755
index 6071b57=
=2E=2E0000000
--- a/dev-tools/gen-release-tarballs=2Esh
+++ /dev/null
@@ -1=
,246 +0,0 @@
-#!/bin/sh
-# gen-release-tarballs=2Esh  -  Generates release =
tarballs with signatures
-#
-# Copyright (C) 2017-2026 - David Sommerseth <=
davids@openvpn=2Enet>
-#
-# This program is free software; you can redistri=
bute it and/or
-# modify it under the terms of the GNU General Public Licen=
se
-# as published by the Free Software Foundation; either version 2
-# of =
the License=2E
-#
-# This program is distributed in the hope that it will b=
e useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of=

-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
-# GNU =
General Public License for more details=2E
-#
-# You should have received a=
 copy of the GNU General Public License
-# along with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
-#
-set -u
-
-if [ $# -ne 4 ]; =
then
-    echo "Usage: $0 <remote-name> <tag-name> <sign-key> <dest-dir>"
-=
    echo ""
-    echo "   remote-name  -- valid remotes: `git remote | tr \=
\\n ' '`"
-    echo "   tag-name     -- An existing release tag"
-    echo =
"   sign-key     -- PGP key used to sign all files"
-    echo "   dest-dir =
    -- Where to put the complete set of release tarballs"
-    echo ""
-   =
 echo "   Example: $0 origin v2=2E4=2E2 /tmp/openvpn-release"
-    echo
-  =
  exit 1
-fi
-
-arg_remote_name=3D"$1"
-arg_tag_name=3D"$2"
-arg_sign_key=
=3D"$3"
-arg_dest_dir=3D"$4"
-
-#
-# Sanity checks
-#
-
-# Check that the t=
ag exists
-git tag | grep "$arg_tag_name" 1>/dev/null
-if [ $? -ne 0 ]; the=
n
-    echo "** ERROR **  The tag '$arg_tag_name' does not exist"
-    exit=
 2
-fi
-
-# Extract the git URL
-giturl=3D"`git remote get-url $arg_remote_=
name 2>/dev/null`"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Invalid gi=
t remote name: $arg_remote_name"
-    exit 2
-fi
-
-# Check we have the nee=
ded signing key
-echo "test" | gpg -a --clearsign -u "$arg_sign_key" 2>/dev=
/null 1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed when=
 testing the PGP signing=2E  Wrong signing key?"
-    exit 2;
-fi
-
-
-#
-#=
 Helper functions
-#
-
-get_filename()
-{
-    local wildcard=3D"$1"
-
-   =
 res=3D"`find =2E -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut =
-d/ -f2-`"
-    if [ $? -ne 0 ]; then
-        echo "-- 'find' failed=2E"
-=
        exit 5
-    fi
-    if [ -z "$res" ]; then
-        echo "-- Could =
not find a file with the wildcard: $wildcard"
-        exit 4
-    fi
-    =
echo "$res"
-}
-
-copy_files()
-{
-    local fileext=3D"$1"
-    local dest=
=3D"$2"
-
-    file=3D"`get_filename openvpn-*=2E*=2E*=2E$fileext`"
-    if=
 [ -z "$file" ]; then
-        echo "** ERROR Failed to find source file"
-=
        exit 5
-    fi
-    echo "-- Copying $file"
-    cp "$file" "$dest"=

-    if [ $? -ne 0 ]; then
-        echo "** ERROR ** Failed to copy $file=
 to $destdir"
-        exit 3;
-    fi
-}
-
-sign_file()
-{
-    local sign=
key=3D"$1"
-    local srchfile=3D"$2"
-    local signtype=3D"$3"
-    local=
 file=3D"`get_filename $srchfile`"
-
-    echo "-- Signing $file =2E=2E=2E"=

-    case "$signtype" in
-        inline)
-            # Have the signatur=
e in the same file as the data
-            gpg -a --clearsign -u "$signkey=
" "$file" 2>/dev/null
-            res=3D$?
-            if [ $res -eq 0 ];=
 then
-                rm -f "$file"
-            fi
-            ;;
-
-   =
     detached)
-            # Have the signature in a separate file
-      =
      gpg -a --detach-sign -u "$signkey" "$file" 2>/dev/null
-            r=
es=3D$?
-            ;;
-
-        *)
-            echo "** ERROR **  Unkno=
wn signing type \"$signtype\"=2E"
-            exit 4;
-    esac
-
-    if =
[ $res -ne 0 ]; then
-        echo "** ERROR **  Failed to sign the file $P=
WD/$file"
-        exit 4;
-    fi
-}
-
-
-#
-# Preparations
-#
-
-# Create=
 the destination directory, using a sub-dir with the tag-name
-destdir=3D""=

-case "$arg_dest_dir" in
-    /*) # Absolute path
-        destdir=3D"$arg=
_dest_dir/$arg_tag_name"
-        ;;
-    *)  # Make absolute path from rel=
ative path
-        destdir=3D"$PWD/$arg_dest_dir/$arg_tag_name"
-        ;=
;
-esac
-echo "-- Destination directory: $destdir"
-if [ -e "$destdir" ]; t=
hen
-    echo "** ERROR ** Destination directory already exists=2E  "
-    =
echo "            Please check your command line carefully=2E"
-    exit 2
=
-fi
-
-mkdir -p "$destdir"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Fa=
iled to create destination directory"
-    exit 2
-fi
-
-#
-# Start the rel=
ease process
-#
-
-# Clone the remote repository
-workdir=3D"`mktemp -d -p =
/var/tmp openvpn-build-release-XXXXXX`"
-cd $workdir
-echo "-- Working dire=
ctory: $workdir"
-echo "-- git clone $giturl"
-git clone $giturl openvpn-ge=
n-tarball 2> "$workdir/git-clone=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    ec=
ho "** ERROR **  git clone failed=2E  See $workdir/git-clone=2Elog for deta=
ils"
-    exit 3;
-fi
-cd openvpn-gen-tarball
-
-# Check out the proper rel=
ease tag
-echo "-- Checking out tag $arg_tag_name =2E=2E=2E "
-git checkout=
 -b mkrelease "$arg_tag_name" 2> "$workdir/git-checkout-tag=2Elog" 1>&2
-if=
 [ $? -ne 0 ]; then
-    echo "** ERROR **  git checkout failed=2E  See $wo=
rkdir/git-checkout-tag=2Elog for details"
-    exit 3;
-fi
-
-# Prepare the=
 source tree
-echo "-- Running autoreconf + a simple configure =2E=2E=2E "
=
-(autoreconf -vi && =2E/configure) 2> "$workdir/autotools-prep=2Elog" 1>&2
=
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  Failed running autotools=2E =
 See $workdir/autotools-prep=2Elog for details"
-    exit 3;
-fi
-
-# Gener=
ate the tar/zip files
-echo "-- Running make distcheck (generates =2Etar=2E=
gz) =2E=2E=2E "
-(make distcheck) 2> "$workdir/make-distcheck=2Elog" 1>&2
-=
if [ $? -ne 0 ]; then
-    echo "** ERROR **  make distcheck failed=2E  See=
 $workdir/make-distcheck=2Elog for details"
-    exit 3;
-fi
-copy_files ta=
r=2Egz "$destdir"
-
-echo "-- Running make dist-xz (generates =2Etar=2Exz) =
=2E=2E=2E "
-(make dist-xz) 2> "$workdir/make-dist-xz=2Elog" 1>&2
-if [ $? =
-ne 0 ]; then
-    echo "** ERROR **  make dist-xz failed=2E  See $workdir/=
make-dist-xz=2Elog for details"
-    exit 3;
-fi
-copy_files tar=2Exz "$des=
tdir"
-
-echo "-- Running make dist-zip (generates =2Ezip) =2E=2E=2E "
-(ma=
ke dist-zip) 2> "$workdir/make-dist-zip=2Elog" 1>&2
-if [ $? -ne 0 ]; then
=
-    echo "** ERROR **  make dist-zip failed=2E  See $workdir/make-dist-zip=
=2Elog for details"
-    exit 3;
-fi
-copy_files zip "$destdir"
-
-# Genera=
te SHA256 checksums
-cd "$destdir"
-sha256sum openvpn-*=2Etar=2E{gz,xz} ope=
nvpn-*=2Ezip > "openvpn-$arg_tag_name=2Esha256sum"
-
-# Sign all the files
=
-echo "-- Signing files =2E=2E=2E "
-sign_file "$arg_sign_key" "openvpn-$ar=
g_tag_name=2Esha256sum" inline
-sign_file "$arg_sign_key" "openvpn-*=2Etar=
=2Egz" detached
-sign_file "$arg_sign_key" "openvpn-*=2Etar=2Exz" detached
=
-sign_file "$arg_sign_key" "openvpn-*=2Ezip" detached
-
-# Create a tar-bun=
dle with everything
-echo "-- Creating final tarbundle with everything =2E=
=2E=2E"
-tar cf "openvpn-$arg_tag_name=2Etar" openvpn-*=2E{tar=2Egz,tar=2Ex=
z,zip}{,=2Easc} openvpn-*=2Esha256sum=2Easc
-
-echo "-- Cleaning up =2E=2E=
=2E"
-# Save the log files
-mkdir -p "$destdir/logs"
-mv $workdir/*=2Elog "=
$destdir/logs"
-
-# Finally, done!
-rm -rf "$workdir"
-echo "-- Done"
-exit=
 0

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I10b912bad3b=
b0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Number: 1847
Gerrit-PatchSet: 4=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Xq66QUTlXIU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2, Code-Review+2 by razvanc</p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
gen-release-tarballs=2Esh: Remove<br><br>This is unused (all our releases u=
se code in openvpn-build<br>repository instead) and of doubtful use=2E E=2E=
g=2E why would we<br>need three different tarballs for releases?<br><br>It =
also has small issues like using a /bin/sh shebang but<br>containing bashis=
ms=2E<br><br>So get rid of the dead code=2E<br><br>Change-Id: I10b912bad3bb=
0b97e2b47eae20d2dd7ffb0c6879<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847<br>Mess=
age-Id: &lt;20260819132652=2E24207-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
8509=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>D dev-tools/gen-release-tarballs=2Esh<br>1 file changed, 0 insert=
ions(+), 246 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1847/4</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release-tarballs=2Esh</=
span><br><span>deleted file mode 100755</span><br><span>index 6071b57=2E=2E=
0000000</span><br><span>--- a/dev-tools/gen-release-tarballs=2Esh</span><br=
><span>+++ /dev/null</span><br><span>@@ -1,246 +0,0 @@</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# gen-release-tarballs=2Esh  -  Generates release tarb=
alls with signatures</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (C) 2017-=
2026 - David Sommerseth &lt;davids@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# This program is free software; you can redistribute it and/or=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# modify it under the=
 terms of the GNU General Public License</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# as published by the Free Software Foundation; either v=
ersion 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# of the Lice=
nse=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# You should have received a copy of the GNU Ge=
neral Public License</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 along with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/=
&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-set -u</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-if [ $# -ne 4 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    echo &quot;Usage: $0 &lt;remote-name&gt; &lt;tag-name&gt; &lt;sign=
-key&gt; &lt;dest-dir&gt;&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    echo &quot;&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    echo &quot;   remote-name  -- valid remotes: `git remote | tr=
 \\\n &#39; &#39;`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    echo &quot;   tag-name     -- An existing release tag&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   sign-key    =
 -- PGP key used to sign all files&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    echo &quot;   dest-dir     -- Where to put the compl=
ete set of release tarballs&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    echo &quot;&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    echo &quot;   Example: $0 origin v2=2E4=2E2 /tmp/openvpn-re=
lease&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 1</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-arg_remote_name=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-arg_tag_name=3D&quot;$2&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-arg_sign_key=3D&quot;$3&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-arg_dest_dir=3D&quot;$4&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# San=
ity checks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# Check that the tag exists</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-git tag | grep &quot;$arg_tag_name&quot; 1&gt;=
/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne =
0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &qu=
ot;** ERROR **  The tag &#39;$arg_tag_name&#39; does not exist&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 2</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Ex=
tract the git URL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gitu=
rl=3D&quot;`git remote get-url $arg_remote_name 2&gt;/dev/null`&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR ** =
Invalid git remote name: $arg_remote_name&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# Check we have the neede=
d signing key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &qu=
ot;test&quot; | gpg -a --clearsign -u &quot;$arg_sign_key&quot; 2&gt;/dev/n=
ull 1&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if =
[ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 echo &quot;** ERROR ** Failed when testing the PGP signing=2E  Wrong signi=
ng key?&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit=
 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# Helper functions</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-get_filename()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local wildcard=
=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    res=3D&quot;`find =2E=
 -maxdepth 1 -type f -name \&quot;$wildcard\&quot; | head -n1 | cut -d/ -f2=
-`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $? -=
ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
cho &quot;-- &#39;find&#39; failed=2E&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        exit 5</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if [ -z &quot;$res&quot; ]; then</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        echo &quot;-- Could not find a file with the wildcar=
d: $wildcard&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     exit 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;$res&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-copy_files()</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local fileex=
t=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 local dest=3D&quot;$2&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    file=3D&qu=
ot;`get_filename openvpn-*=2E*=2E*=2E$fileext`&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$file&quot; ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;** ERROR=
 Failed to find source file&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        exit 5</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &=
quot;-- Copying $file&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    cp &quot;$file&quot; &quot;$dest&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if [ $? -ne 0 ]; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        echo &quot;** ERROR ** Failed to co=
py $file to $destdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        exit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-sign_file()</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local si=
gnkey=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    local srchfile=3D&quot;$2&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    local signtype=3D&quot;$3&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    local file=3D&quot;`get_filename $srchfile=
`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;-- Signing $file =2E=
=2E=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    case =
&quot;$signtype&quot; in</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        inline)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         # Have the signature in the same file as the data</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            gpg -a --clearsign -u &quo=
t;$signkey&quot; &quot;$file&quot; 2&gt;/dev/null</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            res=3D$?</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if [ $res -eq 0 ]; then</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                rm -f &quot;$file&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fi</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        detached)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            # Have the signature in a separate file</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            gpg -a --deta=
ch-sign -u &quot;$signkey&quot; &quot;$file&quot; 2&gt;/dev/null</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            res=3D$?</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            ;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        *)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            echo &quot;** ERROR **  Unknown signing type \&quot;$signtyp=
e\&quot;=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        exit 4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    es=
ac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if [ $res -ne 0 ]; then</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;** ERROR **  Fa=
iled to sign the file $PWD/$file&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        exit 4;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Prepara=
tions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# Create the destination directory, using a sub-dir with =
the tag-name</span><br><span style=3D"color: hsl(0, 100%, 40%);">-destdir=
=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-case &=
quot;$arg_dest_dir&quot; in</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /*) # Absolute path</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        destdir=3D&quot;$arg_dest_dir/$arg_tag_name&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    *)  # Make absolute path from relative=
 path</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        destdir=
=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ec=
ho &quot;-- Destination directory: $destdir&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ -e &quot;$destdir&quot; ]; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR ** Desti=
nation directory already exists=2E  &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;            Please check your command l=
ine carefully=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    exit 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-mkdir -p &quot;$destdir&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR ** Failed to creat=
e destination directory&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    exit 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# Start the release process</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Clone the remote repo=
sitory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-workdir=3D&quot=
;`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-cd $workdir</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-echo &quot;-- Working directory: $workdir&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- git clo=
ne $giturl&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-git c=
lone $giturl openvpn-gen-tarball 2&gt; &quot;$workdir/git-clone=2Elog&quot;=
 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -=
ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo =
&quot;** ERROR **  git clone failed=2E  See $workdir/git-clone=2Elog for de=
tails&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-cd openvpn-gen-tarball</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Check out the proper release tag</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-echo &quot;-- Checking out tag $arg_tag_name =
=2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-git c=
heckout -b mkrelease &quot;$arg_tag_name&quot; 2&gt; &quot;$workdir/git-che=
ckout-tag=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    echo &quot;** ERROR **  git checkout failed=2E  See $workdi=
r/git-checkout-tag=2Elog for details&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    exit 3;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# Prepare the source tree</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Running aut=
oreconf + a simple configure =2E=2E=2E &quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-(autoreconf -vi &amp;&amp; =2E/configure) 2&gt; &qu=
ot;$workdir/autotools-prep=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  Failed running aut=
otools=2E  See $workdir/autotools-prep=2Elog for details&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Genera=
te the tar/zip files</span><br><span style=3D"color: hsl(0, 100%, 40%);">-e=
cho &quot;-- Running make distcheck (generates =2Etar=2Egz) =2E=2E=2E &quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(make distcheck) 2&g=
t; &quot;$workdir/make-distcheck=2Elog&quot; 1&gt;&amp;2</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  make distche=
ck failed=2E  See $workdir/make-distcheck=2Elog for details&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-copy_files tar=2Egz &quot;$destdir&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-echo &quot;-- Running make dist-xz (generates =2Etar=2Exz) =2E=
=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(make di=
st-xz) 2&gt; &quot;$workdir/make-dist-xz=2Elog&quot; 1&gt;&amp;2</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  make=
 dist-xz failed=2E  See $workdir/make-dist-xz=2Elog for details&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-copy_files tar=2Exz &quot;$destdir&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-echo &quot;-- Running make dist-zip (generates =2Ezip) =2E=
=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-(make di=
st-zip) 2&gt; &quot;$workdir/make-dist-zip=2Elog&quot; 1&gt;&amp;2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  ma=
ke dist-zip failed=2E  See $workdir/make-dist-zip=2Elog for details&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-copy_files zip &quot;$destdir&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Generate SHA256 checksums</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-cd &quot;$destdir&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-sha256sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip=
 &gt; &quot;openvpn-$arg_tag_name=2Esha256sum&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# Sign all the files</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-echo &quot;-- Signing files =2E=2E=2E &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;=
openvpn-$arg_tag_name=2Esha256sum&quot; inline</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;openvpn-=
*=2Etar=2Egz&quot; detached</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-sign_file &quot;$arg_sign_key&quot; &quot;openvpn-*=2Etar=2Exz&quot; =
detached</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file &qu=
ot;$arg_sign_key&quot; &quot;openvpn-*=2Ezip&quot; detached</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# Create a tar-bundle with everything</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Creating final tarbundle wit=
h everything =2E=2E=2E&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-tar cf &quot;openvpn-$arg_tag_name=2Etar&quot; openvpn-*=2E{tar=2Egz=
,tar=2Exz,zip}{,=2Easc} openvpn-*=2Esha256sum=2Easc</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-echo &quot;-- Cleaning up =2E=2E=2E&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# Save the log files</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-mkdir -p &quot;$destdir/logs&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-mv $workdir/*=2Elog &quot;$des=
tdir/logs&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# Finally, done!</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-rm -rf &quot;$workdir&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Done&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-exit 0</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1847?usp=3Demail">change 1847</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1847?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ff=
b0c6879 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1847 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--Xq66QUTlXIU=--


--===============2738963899669880831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738963899669880831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2738963899669880831==--

