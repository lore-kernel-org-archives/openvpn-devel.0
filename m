Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913D5C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVp0G/RFWVaVCMqh8PgMkKJMv/CPmpeRIFMJjg45AvU=; b=Z+3Nq+toDoxKQSzKp0te4u9E9b
	sSY2kjw+oTThlbuny5+RV6jBb5LvCDW4N8nhxQ3WGbuSdFLSMd6lU8eUJ1GENHoGI/tBxhlweM8fW
	qStoep9dhHuWd/Jp8pffpDCH2wDurhpSM4HFL5QLhw1gO6GMLBrHM9VuAn/mlgU5eCX0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgJq-0001Wg-Ke;
	Wed, 19 Aug 2026 13:27:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwgJo-0001WO-VW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cJiJ9IVlhoOaHYdyrH4v1qRQffcbW92BCOlKVwUA9Rg=; b=biVoja7SApDOKtatW+wj1WcPkl
 0hrO6CKxQKGQv+DV+TPz8q+T1TfmXOMDuEOb++A7iURf4kM3TS+FF6u6mYLOfQB4B924sMeLZvC75
 Q3gYr/flt5mKYZI/KiMCirz7sUczbFLT3iyu8V/ub2RLa04B8OmVOCIBGFjUZ3OaEBhc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cJiJ9IVlhoOaHYdyrH4v1qRQffcbW92BCOlKVwUA9Rg=; b=bshhLPS8zbfX+OLm/zbMlY8j7z
 kwLlkQKzjUcPB/WbA6XX65FO9UgnDGQq8SEdnpOWK+3FjPkaj0HowAoFmQwYsb1fGliUd+D4ZSJxa
 +m2GfpRc/S5KB7J1GLhwIZVw9pmGUZoHsekq6qUlyHt5Wp/GrATlJSLJ9NKwEmjZUtOg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwgJn-0000a1-Um for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:27:01 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67JDQrxk024223
 for <openvpn-devel@lists.sourceforge.net>; Wed, 19 Aug 2026 15:26:53 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JDQrbF024222
 for openvpn-devel@lists.sourceforge.net; Wed, 19 Aug 2026 15:26:53 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 19 Aug 2026 15:26:46 +0200
Message-ID: <20260819132652.24207-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwgJn-0000a1-Um
Subject: [Openvpn-devel] [PATCH v3] gen-release-tarballs.sh: Remove
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

This is unused (all our releases use code in openvpn-build
repository instead) and of doubtful use. E.g. why would we
need three different tarballs for releases?

It also has small issues like using a /bin/sh shebang but
containing bashisms.

So get rid of the dead code.

Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1847
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1847
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
deleted file mode 100755
index 6071b57..0000000
--- a/dev-tools/gen-release-tarballs.sh
+++ /dev/null
@@ -1,246 +0,0 @@
-#!/bin/sh
-# gen-release-tarballs.sh  -  Generates release tarballs with signatures
-#
-# Copyright (C) 2017-2026 - David Sommerseth <davids@openvpn.net>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; either version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <https://www.gnu.org/licenses/>.
-#
-set -u
-
-if [ $# -ne 4 ]; then
-    echo "Usage: $0 <remote-name> <tag-name> <sign-key> <dest-dir>"
-    echo ""
-    echo "   remote-name  -- valid remotes: `git remote | tr \\\n ' '`"
-    echo "   tag-name     -- An existing release tag"
-    echo "   sign-key     -- PGP key used to sign all files"
-    echo "   dest-dir     -- Where to put the complete set of release tarballs"
-    echo ""
-    echo "   Example: $0 origin v2.4.2 /tmp/openvpn-release"
-    echo
-    exit 1
-fi
-
-arg_remote_name="$1"
-arg_tag_name="$2"
-arg_sign_key="$3"
-arg_dest_dir="$4"
-
-#
-# Sanity checks
-#
-
-# Check that the tag exists
-git tag | grep "$arg_tag_name" 1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  The tag '$arg_tag_name' does not exist"
-    exit 2
-fi
-
-# Extract the git URL
-giturl="`git remote get-url $arg_remote_name 2>/dev/null`"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Invalid git remote name: $arg_remote_name"
-    exit 2
-fi
-
-# Check we have the needed signing key
-echo "test" | gpg -a --clearsign -u "$arg_sign_key" 2>/dev/null 1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed when testing the PGP signing.  Wrong signing key?"
-    exit 2;
-fi
-
-
-#
-# Helper functions
-#
-
-get_filename()
-{
-    local wildcard="$1"
-
-    res="`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-`"
-    if [ $? -ne 0 ]; then
-        echo "-- 'find' failed."
-        exit 5
-    fi
-    if [ -z "$res" ]; then
-        echo "-- Could not find a file with the wildcard: $wildcard"
-        exit 4
-    fi
-    echo "$res"
-}
-
-copy_files()
-{
-    local fileext="$1"
-    local dest="$2"
-
-    file="`get_filename openvpn-*.*.*.$fileext`"
-    if [ -z "$file" ]; then
-        echo "** ERROR Failed to find source file"
-        exit 5
-    fi
-    echo "-- Copying $file"
-    cp "$file" "$dest"
-    if [ $? -ne 0 ]; then
-        echo "** ERROR ** Failed to copy $file to $destdir"
-        exit 3;
-    fi
-}
-
-sign_file()
-{
-    local signkey="$1"
-    local srchfile="$2"
-    local signtype="$3"
-    local file="`get_filename $srchfile`"
-
-    echo "-- Signing $file ..."
-    case "$signtype" in
-        inline)
-            # Have the signature in the same file as the data
-            gpg -a --clearsign -u "$signkey" "$file" 2>/dev/null
-            res=$?
-            if [ $res -eq 0 ]; then
-                rm -f "$file"
-            fi
-            ;;
-
-        detached)
-            # Have the signature in a separate file
-            gpg -a --detach-sign -u "$signkey" "$file" 2>/dev/null
-            res=$?
-            ;;
-
-        *)
-            echo "** ERROR **  Unknown signing type \"$signtype\"."
-            exit 4;
-    esac
-
-    if [ $res -ne 0 ]; then
-        echo "** ERROR **  Failed to sign the file $PWD/$file"
-        exit 4;
-    fi
-}
-
-
-#
-# Preparations
-#
-
-# Create the destination directory, using a sub-dir with the tag-name
-destdir=""
-case "$arg_dest_dir" in
-    /*) # Absolute path
-        destdir="$arg_dest_dir/$arg_tag_name"
-        ;;
-    *)  # Make absolute path from relative path
-        destdir="$PWD/$arg_dest_dir/$arg_tag_name"
-        ;;
-esac
-echo "-- Destination directory: $destdir"
-if [ -e "$destdir" ]; then
-    echo "** ERROR ** Destination directory already exists.  "
-    echo "            Please check your command line carefully."
-    exit 2
-fi
-
-mkdir -p "$destdir"
-if [ $? -ne 0 ]; then
-    echo "** ERROR ** Failed to create destination directory"
-    exit 2
-fi
-
-#
-# Start the release process
-#
-
-# Clone the remote repository
-workdir="`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
-cd $workdir
-echo "-- Working directory: $workdir"
-echo "-- git clone $giturl"
-git clone $giturl openvpn-gen-tarball 2> "$workdir/git-clone.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  git clone failed.  See $workdir/git-clone.log for details"
-    exit 3;
-fi
-cd openvpn-gen-tarball
-
-# Check out the proper release tag
-echo "-- Checking out tag $arg_tag_name ... "
-git checkout -b mkrelease "$arg_tag_name" 2> "$workdir/git-checkout-tag.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  git checkout failed.  See $workdir/git-checkout-tag.log for details"
-    exit 3;
-fi
-
-# Prepare the source tree
-echo "-- Running autoreconf + a simple configure ... "
-(autoreconf -vi && ./configure) 2> "$workdir/autotools-prep.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  Failed running autotools.  See $workdir/autotools-prep.log for details"
-    exit 3;
-fi
-
-# Generate the tar/zip files
-echo "-- Running make distcheck (generates .tar.gz) ... "
-(make distcheck) 2> "$workdir/make-distcheck.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make distcheck failed.  See $workdir/make-distcheck.log for details"
-    exit 3;
-fi
-copy_files tar.gz "$destdir"
-
-echo "-- Running make dist-xz (generates .tar.xz) ... "
-(make dist-xz) 2> "$workdir/make-dist-xz.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make dist-xz failed.  See $workdir/make-dist-xz.log for details"
-    exit 3;
-fi
-copy_files tar.xz "$destdir"
-
-echo "-- Running make dist-zip (generates .zip) ... "
-(make dist-zip) 2> "$workdir/make-dist-zip.log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make dist-zip failed.  See $workdir/make-dist-zip.log for details"
-    exit 3;
-fi
-copy_files zip "$destdir"
-
-# Generate SHA256 checksums
-cd "$destdir"
-sha256sum openvpn-*.tar.{gz,xz} openvpn-*.zip > "openvpn-$arg_tag_name.sha256sum"
-
-# Sign all the files
-echo "-- Signing files ... "
-sign_file "$arg_sign_key" "openvpn-$arg_tag_name.sha256sum" inline
-sign_file "$arg_sign_key" "openvpn-*.tar.gz" detached
-sign_file "$arg_sign_key" "openvpn-*.tar.xz" detached
-sign_file "$arg_sign_key" "openvpn-*.zip" detached
-
-# Create a tar-bundle with everything
-echo "-- Creating final tarbundle with everything ..."
-tar cf "openvpn-$arg_tag_name.tar" openvpn-*.{tar.gz,tar.xz,zip}{,.asc} openvpn-*.sha256sum.asc
-
-echo "-- Cleaning up ..."
-# Save the log files
-mkdir -p "$destdir/logs"
-mv $workdir/*.log "$destdir/logs"
-
-# Finally, done!
-rm -rf "$workdir"
-echo "-- Done"
-exit 0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
