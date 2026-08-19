Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC0EC5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hp3nw9naNRAYjcmA/o8dJINe52AC8lwTt4SwLWjTmwc=; b=IeeFqvd1ZT4LhSvTUx9BdvgcYq
	18es0CmT75kcr9dpDyqTtluOp7U7JhPNiSzgqcb9IkYOoDZas1WS45yXkCXRAlukrp/kxbrXUN7c5
	jYOTr3YO6XQKcKj57IfyI/hBWwWdzYRnrliLvHcxDdBKhvNzFX/pNKrI1cZhUK3v2UJY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgCc-0000l3-AV;
	Wed, 19 Aug 2026 13:19:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgCL-0000km-Lq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5gIWOoFy32Ogh+3fEWJQ2/GWipkusEvFkRDbGU6UzOA=; b=LOU+tx6Fv846wssxwVRXYzAPI4
 IJ4WCxrm+JVwtBFoIEJTzm33AJCL41KdBYi747UI01KUrXPJ6jRUWhQzkWkwhuuoern5yOncdz9OY
 7Sn76XOoStKzS84iHS2+hTkLDEbnUooVT01Rov9gkDsMmGnCTAnz0RUR0BuuZilRZQ+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5gIWOoFy32Ogh+3fEWJQ2/GWipkusEvFkRDbGU6UzOA=; b=T
 LW0KEnsHPdKHtw6H+cP50r+GnPaH1O1esdXDA+gYB1Nb/u+YAsSvpDmOC8/j3VyojoW2AJXlv0tPn
 CsUuAGhrNSfHNsRDNgaYV1OBmJy65aI1QA25xCtT6sfLv0h9vID9gwqKKeicU2Pzv49yluXZ6Yktf
 thOjRJwCszExyma0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgCE-00006i-40 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:19:12 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso15697075e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787145543; x=1787750343; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5gIWOoFy32Ogh+3fEWJQ2/GWipkusEvFkRDbGU6UzOA=;
 b=LuTtRl70YXFi9LXtOJ8JdAVOcon7xaA8l9oOytmQMbBV0fjE87d6M6atstOzDLtHKn
 o6jTZbGBeR/wpKK1zXYGkXNhU0TGfthPQJi698hewK9sX2bDoOt/NfIPAchTuu5/XwtI
 dPR4UBM4c/afdI5M3s77CSbOE7sAzvl3WQ66Mtd3bYYLMMdyLO8KqFn5KBJDfpoiRtXI
 PKva9+ZghwI/NmuPSoRgRhem01zeIoIB5dOjsIsXYuBDRYG5mLEr1M/vf+trf3TKknOA
 NGjLqvl4JLWUYP4iPBp5QuFj3B+2R/92bFPHwrBBE2VTYUOW78gj0gY9KKsPlxmXD2Ar
 dTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145543; x=1787750343;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5gIWOoFy32Ogh+3fEWJQ2/GWipkusEvFkRDbGU6UzOA=;
 b=SwnMTyaS+qHqOiR97Y5tlNQe/z/cahAH4IyLdgtPi02JKExoeoMG5jVCPm/gQUBbYd
 ml4AypZURMdZpXqAM+TtCsbIlPmk0tzyIqfD4PsZ6UBUIzwheZgaQyhh9qCyzwfNPv7V
 iOh0T8DIlqwe0Ej21vKghnMhdCP7pN0kBse/tIVpnwHk/UiDB+UoWUuas6OJtQaQh3A9
 blgl33zhr3liOViG3AHMy+lrdzyMLfuOjzZPxmSGp4xSDIA051fWneiYv54bX6bIuCh5
 JyVMn0IttjIJQw9OIjPkhZQV2EFH9oa62+f44Bu9t2hEelxKdPH7MUmRfOY0NVVmnhpP
 LCVg==
X-Gm-Message-State: AOJu0YwvwqisEVlyj0x1oTwqqjWFJ1n1SW+QM29BLukHtCR99zX69X3P
 YOTOu6YLgUOkxSC5rOcfm/4GTnCBxrbWT4/Pshhu5tlsFkwxwYM0Lp8CWIUjHLo0eIjSWfhcqic
 zh0WWZc50HHUtH+OuFC4LyOJ/CwOLM2W4Gc+tl0ll/1sl0wp4GbyyiBmDw1UDaXnLnLguzE1J69
 QDBHwn6A==
X-Gm-Gg: AR+sD10B1pxLRYYF6eXNk+41kM2gOyK3ReSryKPjXLSYb/yGE6NyZXkeMp/STZuijYr
 tJ4U6T8PyadO3sQ1KEla0l0OB8Byl8RaWx2od2pD2u9COkWicA5P/e0CZWSk7YLGuUjMxsm4tt3
 RmD3vc6TRurSacT/RtZ0wopz/+gSjms7o3dl+2T5Nfc/wZK0FrGH+irRelQlyDZ5CZKa+HXPgNT
 0peSjThiUySUnx18mKTuW3S7DNCN1urWWG/D9+TlGD6Htpfn4i8qmxVf8hpPzdU23jQyWhAf67B
 MrmWBK/77YSRdjcff39xR9ROSPo3tQWFcZpTDYbaTo/iYM93MZY36CkO9LCCbPewXyUziCfRU8h
 yFnJExP1xm0CsYA/I3KB0lGFekAi6uKCh2lnkYuL7qMl6QYQoai/YWcMP35l9cPUOT5tC2aM0Il
 ds67lKm9TWk77Tj5KCYv3EXswPVRt2xc0OOONmPxZ8wAH2X56qs9k0+kvhlK6S6HcvEg9lrGR8S
 CHXzhG0quohDK4PDyKDay2kfxREx0TRKgtUZT9nZ+Juba43G9oUjSImbtuG4YEqUO5VE1IklJgA
 rti210mEmJ1jydN/U3LpXxUr0U9oSyeOizeg2Sfk0E/gPf5I1A0=
X-Received: by 2002:a05:600c:4852:b0:499:a7ac:e1f0 with SMTP id
 5b1f17b1804b1-499aa10af6fmr51331925e9.7.1787145543253; 
 Wed, 19 Aug 2026 06:19:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm5823952f8f.0.2026.08.19.06.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:19:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:18:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 3eedb5f7320dd04d6e03d3bd276844115724f1c5
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a7518fb39af8b4567e51490707506ea48360997-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgCE-00006i-40
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0232201787088570353=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0232201787088570353==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ca9QuZ3tVZQ="; charset=UTF-8

--Ca9QuZ3tVZQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail

to loo=
k at the new patch set (#2)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc

The change is no longer submittable: =
Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change sub=
ject: gen-release-tarballs=2Esh: Remove
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-release-tarballs=2Esh: Remove

This is unu=
sed (all our releases use code in openvpn-build
repository insted) and of d=
oubtful use=2E E=2Eg=2E why would we
need three different tarballs for rele=
ases?

It also has small issues like using a /bin/sh shebang but
containing=
 bashisms=2E

So get rid of the dead code=2E

Change-Id: I10b912bad3bb0b97e=
2b47eae20d2dd7ffb0c6879
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
D dev-tools/gen-release-tarballs=2Esh
1 file changed, 0 inserti=
ons(+), 246 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/47/1847/2

diff --git a/dev-tools/gen-release-tarballs=
=2Esh b/dev-tools/gen-release-tarballs=2Esh
deleted file mode 100755
index =
6071b57=2E=2E0000000
--- a/dev-tools/gen-release-tarballs=2Esh
+++ /dev/nul=
l
@@ -1,246 +0,0 @@
-#!/bin/sh
-# gen-release-tarballs=2Esh  -  Generates r=
elease tarballs with signatures
-#
-# Copyright (C) 2017-2026 - David Somme=
rseth <davids@openvpn=2Enet>
-#
-# This program is free software; you can r=
edistribute it and/or
-# modify it under the terms of the GNU General Publi=
c License
-# as published by the Free Software Foundation; either version 2=

-# of the License=2E
-#
-# This program is distributed in the hope that it=
 will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
-# GNU General Public License for more details=2E
-#
-# You should have rec=
eived a copy of the GNU General Public License
-# along with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
-#
-set -u
-
-if [ $# -n=
e 4 ]; then
-    echo "Usage: $0 <remote-name> <tag-name> <sign-key> <dest-=
dir>"
-    echo ""
-    echo "   remote-name  -- valid remotes: `git remote=
 | tr \\\n ' '`"
-    echo "   tag-name     -- An existing release tag"
-  =
  echo "   sign-key     -- PGP key used to sign all files"
-    echo "   de=
st-dir     -- Where to put the complete set of release tarballs"
-    echo =
""
-    echo "   Example: $0 origin v2=2E4=2E2 /tmp/openvpn-release"
-    e=
cho
-    exit 1
-fi
-
-arg_remote_name=3D"$1"
-arg_tag_name=3D"$2"
-arg_sig=
n_key=3D"$3"
-arg_dest_dir=3D"$4"
-
-#
-# Sanity checks
-#
-
-# Check that =
the tag exists
-git tag | grep "$arg_tag_name" 1>/dev/null
-if [ $? -ne 0 ]=
; then
-    echo "** ERROR **  The tag '$arg_tag_name' does not exist"
-   =
 exit 2
-fi
-
-# Extract the git URL
-giturl=3D"`git remote get-url $arg_re=
mote_name 2>/dev/null`"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Inval=
id git remote name: $arg_remote_name"
-    exit 2
-fi
-
-# Check we have th=
e needed signing key
-echo "test" | gpg -a --clearsign -u "$arg_sign_key" 2=
>/dev/null 1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed=
 when testing the PGP signing=2E  Wrong signing key?"
-    exit 2;
-fi
-
-
=
-#
-# Helper functions
-#
-
-get_filename()
-{
-    local wildcard=3D"$1"
-=

-    res=3D"`find =2E -maxdepth 1 -type f -name \"$wildcard\" | head -n1 |=
 cut -d/ -f2-`"
-    if [ $? -ne 0 ]; then
-        echo "-- 'find' failed=
=2E"
-        exit 5
-    fi
-    if [ -z "$res" ]; then
-        echo "-- =
Could not find a file with the wildcard: $wildcard"
-        exit 4
-    fi=

-    echo "$res"
-}
-
-copy_files()
-{
-    local fileext=3D"$1"
-    loca=
l dest=3D"$2"
-
-    file=3D"`get_filename openvpn-*=2E*=2E*=2E$fileext`"
-=
    if [ -z "$file" ]; then
-        echo "** ERROR Failed to find source f=
ile"
-        exit 5
-    fi
-    echo "-- Copying $file"
-    cp "$file" "=
$dest"
-    if [ $? -ne 0 ]; then
-        echo "** ERROR ** Failed to copy=
 $file to $destdir"
-        exit 3;
-    fi
-}
-
-sign_file()
-{
-    loca=
l signkey=3D"$1"
-    local srchfile=3D"$2"
-    local signtype=3D"$3"
-   =
 local file=3D"`get_filename $srchfile`"
-
-    echo "-- Signing $file =2E=
=2E=2E"
-    case "$signtype" in
-        inline)
-            # Have the s=
ignature in the same file as the data
-            gpg -a --clearsign -u "$=
signkey" "$file" 2>/dev/null
-            res=3D$?
-            if [ $res -=
eq 0 ]; then
-                rm -f "$file"
-            fi
-            ;;=

-
-        detached)
-            # Have the signature in a separate file
=
-            gpg -a --detach-sign -u "$signkey" "$file" 2>/dev/null
-      =
      res=3D$?
-            ;;
-
-        *)
-            echo "** ERROR **=
  Unknown signing type \"$signtype\"=2E"
-            exit 4;
-    esac
-
-=
    if [ $res -ne 0 ]; then
-        echo "** ERROR **  Failed to sign the =
file $PWD/$file"
-        exit 4;
-    fi
-}
-
-
-#
-# Preparations
-#
-
-#=
 Create the destination directory, using a sub-dir with the tag-name
-destd=
ir=3D""
-case "$arg_dest_dir" in
-    /*) # Absolute path
-        destdir=
=3D"$arg_dest_dir/$arg_tag_name"
-        ;;
-    *)  # Make absolute path =
from relative path
-        destdir=3D"$PWD/$arg_dest_dir/$arg_tag_name"
- =
       ;;
-esac
-echo "-- Destination directory: $destdir"
-if [ -e "$destd=
ir" ]; then
-    echo "** ERROR ** Destination directory already exists=2E =
 "
-    echo "            Please check your command line carefully=2E"
-   =
 exit 2
-fi
-
-mkdir -p "$destdir"
-if [ $? -ne 0 ]; then
-    echo "** ERR=
OR ** Failed to create destination directory"
-    exit 2
-fi
-
-#
-# Start=
 the release process
-#
-
-# Clone the remote repository
-workdir=3D"`mktem=
p -d -p /var/tmp openvpn-build-release-XXXXXX`"
-cd $workdir
-echo "-- Work=
ing directory: $workdir"
-echo "-- git clone $giturl"
-git clone $giturl op=
envpn-gen-tarball 2> "$workdir/git-clone=2Elog" 1>&2
-if [ $? -ne 0 ]; then=

-    echo "** ERROR **  git clone failed=2E  See $workdir/git-clone=2Elog =
for details"
-    exit 3;
-fi
-cd openvpn-gen-tarball
-
-# Check out the pr=
oper release tag
-echo "-- Checking out tag $arg_tag_name =2E=2E=2E "
-git =
checkout -b mkrelease "$arg_tag_name" 2> "$workdir/git-checkout-tag=2Elog" =
1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  git checkout failed=2E =
 See $workdir/git-checkout-tag=2Elog for details"
-    exit 3;
-fi
-
-# Pre=
pare the source tree
-echo "-- Running autoreconf + a simple configure =2E=
=2E=2E "
-(autoreconf -vi && =2E/configure) 2> "$workdir/autotools-prep=2El=
og" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  Failed running auto=
tools=2E  See $workdir/autotools-prep=2Elog for details"
-    exit 3;
-fi
-=

-# Generate the tar/zip files
-echo "-- Running make distcheck (generates =
=2Etar=2Egz) =2E=2E=2E "
-(make distcheck) 2> "$workdir/make-distcheck=2Elo=
g" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make distcheck faile=
d=2E  See $workdir/make-distcheck=2Elog for details"
-    exit 3;
-fi
-copy=
_files tar=2Egz "$destdir"
-
-echo "-- Running make dist-xz (generates =2Et=
ar=2Exz) =2E=2E=2E "
-(make dist-xz) 2> "$workdir/make-dist-xz=2Elog" 1>&2
=
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make dist-xz failed=2E  See =
$workdir/make-dist-xz=2Elog for details"
-    exit 3;
-fi
-copy_files tar=
=2Exz "$destdir"
-
-echo "-- Running make dist-zip (generates =2Ezip) =2E=
=2E=2E "
-(make dist-zip) 2> "$workdir/make-dist-zip=2Elog" 1>&2
-if [ $? -=
ne 0 ]; then
-    echo "** ERROR **  make dist-zip failed=2E  See $workdir/=
make-dist-zip=2Elog for details"
-    exit 3;
-fi
-copy_files zip "$destdir=
"
-
-# Generate SHA256 checksums
-cd "$destdir"
-sha256sum openvpn-*=2Etar=
=2E{gz,xz} openvpn-*=2Ezip > "openvpn-$arg_tag_name=2Esha256sum"
-
-# Sign =
all the files
-echo "-- Signing files =2E=2E=2E "
-sign_file "$arg_sign_key=
" "openvpn-$arg_tag_name=2Esha256sum" inline
-sign_file "$arg_sign_key" "op=
envpn-*=2Etar=2Egz" detached
-sign_file "$arg_sign_key" "openvpn-*=2Etar=2E=
xz" detached
-sign_file "$arg_sign_key" "openvpn-*=2Ezip" detached
-
-# Cre=
ate a tar-bundle with everything
-echo "-- Creating final tarbundle with ev=
erything =2E=2E=2E"
-tar cf "openvpn-$arg_tag_name=2Etar" openvpn-*=2E{tar=
=2Egz,tar=2Exz,zip}{,=2Easc} openvpn-*=2Esha256sum=2Easc
-
-echo "-- Cleani=
ng up =2E=2E=2E"
-# Save the log files
-mkdir -p "$destdir/logs"
-mv $workd=
ir/*=2Elog "$destdir/logs"
-
-# Finally, done!
-rm -rf "$workdir"
-echo "--=
 Done"
-exit 0

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1847?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1=
0b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Number: 1847
Gerrit-P=
atchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc=
 <razvanc@mailbox=2Eorg>

--Ca9QuZ3tVZQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><p>The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">gen-release=
-tarballs=2Esh: Remove<br><br>This is unused (all our releases use code in =
openvpn-build<br>repository insted) and of doubtful use=2E E=2Eg=2E why wou=
ld we<br>need three different tarballs for releases?<br><br>It also has sma=
ll issues like using a /bin/sh shebang but<br>containing bashisms=2E<br><br=
>So get rid of the dead code=2E<br><br>Change-Id: I10b912bad3bb0b97e2b47eae=
20d2dd7ffb0c6879<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>D dev-tools/gen-release-tarballs=2Esh<br>1 file change=
d, 0 insertions(+), 246 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1847/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release-tarba=
lls=2Esh</span><br><span>deleted file mode 100755</span><br><span>index 607=
1b57=2E=2E0000000</span><br><span>--- a/dev-tools/gen-release-tarballs=2Esh=
</span><br><span>+++ /dev/null</span><br><span>@@ -1,246 +0,0 @@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# gen-release-tarballs=2Esh  -  Generates r=
elease tarballs with signatures</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyrigh=
t (C) 2017-2026 - David Sommerseth &lt;davids@openvpn=2Enet&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# This program is free software; you can redistribute=
 it and/or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# modify it=
 under the terms of the GNU General Public License</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# as published by the Free Software Foundation=
; either version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# o=
f the License=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# This program is distrib=
uted in the hope that it will be useful,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# GNU General Public License for more detai=
ls=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# You should have received a copy of=
 the GNU General Public License</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# along with this program; if not, see &lt;https://www=2Egnu=2Eor=
g/licenses/&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-set -u</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-if [ $# -ne 4 ]; then</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    echo &quot;Usage: $0 &lt;remote-name&gt; &lt;tag-name&g=
t; &lt;sign-key&gt; &lt;dest-dir&gt;&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;   remote-name  -- valid remotes: `git =
remote | tr \\\n &#39; &#39;`&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &quot;   tag-name     -- An existing release tag&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   s=
ign-key     -- PGP key used to sign all files&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   dest-dir     -- Where to =
put the complete set of release tarballs&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    echo &quot;   Example: $0 origin v2=2E4=2E2 /t=
mp/openvpn-release&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-arg_remote_name=3D&quot;$1&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-arg_tag_name=3D&quot;$2&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-arg_sign_key=3D&quot;$3&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-arg_dest_dir=3D&quot;$4&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# Sanity checks</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# Check that the tag exists</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-git tag | grep &quot;$arg_tag_nam=
e&quot; 1&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    echo &quot;** ERROR **  The tag &#39;$arg_tag_name&#39; does not exist=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 2</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# Extract the git URL</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-giturl=3D&quot;`git remote get-url $arg_remote_name 2&gt;/dev/nu=
ll`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne =
0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &qu=
ot;** ERROR ** Invalid git remote name: $arg_remote_name&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=
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
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10b912bad3bb0=
b97e2b47eae20d2dd7ffb0c6879 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>

</body></html>
--Ca9QuZ3tVZQ=--


--===============0232201787088570353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0232201787088570353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0232201787088570353==--

