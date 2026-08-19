Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B0C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0hcRmXZecOMzxm6FGkRrOHN7arp4PY6h1ldyQgsas4=; b=dIYpkzCWfwMzOaSAdWr2KTeFw9
	7+2f+MEWkyaRmHRzIC2CXXiBlkKQDaXAR93IjtUx1EQWPQy5axmjLTzXAFsFsmk1QVAkiWA/gmgGm
	JpnVyiPCP1RdpUjWjFOkXHWpaYfw59NpmNWreyRIz7buM4YO3vkYxZ3ydUR5igpM4ok4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgEt-0000rc-Sx;
	Wed, 19 Aug 2026 13:21:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgEq-0000r7-SJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WajVH/oIELNNDkwbZhfFsWQWrKT74k/j9wXdCha/YBc=; b=afpfRQSIbGKUBPWwiPS5I0Ec2f
 LI4DOYxR52IVP7nIjubOQMLI0g2e07DoB/2BPmGdqMy8fI6Hh3+2Mz/hLt/889Z2t8rd1yUsK35sd
 r7WdNv2wTzYsuhp5O9jB3+G6iqwTkg5OoDcyr6UD8l6FVvt06+E0VjiLsl8aY/HHTciY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WajVH/oIELNNDkwbZhfFsWQWrKT74k/j9wXdCha/YBc=; b=N
 eHW4IBYToaEQ54ezEYpEkGHK4CW+AUVvoH/n4c5hQsgRfOUvF3jnrHOEA2lLzJtANHJ1kBNcSBOd0
 EkCrOfImzxWHs60Su1cioAGzWpKTFJtBlsR6Pszcuar5WOy892DT8OFsBSpPn5ENI2IWkvdOvR+zh
 t3lOui4ahzJ8kZ94=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgEU-0003CR-1g for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:21:28 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so142502066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787145680; x=1787750480; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WajVH/oIELNNDkwbZhfFsWQWrKT74k/j9wXdCha/YBc=;
 b=UYuuZDm8lVZVl0GhyxjGC4NeqS0bcLTitUnBAVdeHaIK7O4PJMcYGnJIRvdl9ikS4H
 Fm24F2URkMqeZVdxMChMzO7gguRBUzuxMlq+7Ig2z2F+Jw9jgUVprsLiZkQYO6/8vWFs
 GK3h+l6/r+VL7bHISjHWBX3q9qF7S5/5UaFObM5mqMEHBqp2+hPp3wmypoXdX63/fKKn
 sYUOK/znNRdnfTR+2CuO9WFXA9yaqB7qFUkr50TyFGd0ztG7uG/kx7wtaFubLlMjuyZs
 rJ9rXKrzUnyYqIbMA4BhQZugUQuOVdsYnAY54yVZi5Smizel0LYDS6kmP80Z/GC1jdQP
 cybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145680; x=1787750480;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WajVH/oIELNNDkwbZhfFsWQWrKT74k/j9wXdCha/YBc=;
 b=ovNEr3ZsEKu6jLZo25digEjIQ8hyEebQJIo2ZsXxEtZrHgunca989r1wlKsrCzBhXd
 fW8kfYSU3QqHqrtIH5asOEFB/eiZUVft4gq4c+4D6AwzVbQMghthTgQa82rZf2u0rKAs
 Noojm6cFwxSXMU3hNqeu6SvKh95G8wgOlppR8rpc9jcbfOG+aqY2GnYcSvqFXAE/zryR
 Retx3c3VZix7RRcsHn3ItZkS5jmr6HnnK4P9ArKDy63QcFke3W6Q5ywpnkLRCdS5W0+S
 QkTSa5InN3RWJr26GNhYEVIxuUmlEPQxaCzZKJ/FLmBt53JliQXwU0TrP3G3eD7FV4fN
 io/A==
X-Gm-Message-State: AOJu0Yw7eJ7zVMVGgp114MWzQkI1jV3QDSWTWXDB43d5YHDtAsLxs1Z2
 m9kmM826oxqmDeCqimks4xNO91VsWc0IDAAAsTYFduuT+pXwW9G4G6YmD5h0fbUkJXeb/8GstiF
 9kes240D0y3UUmaWytQ+wrPL1mGWa9oWeA0IO1TSxzU8O3tmJb8DMc3h3y8euNYIOdUGB
X-Gm-Gg: AR+sD13JCMoZfiCV+60wR399E5pqnf50hNxLNkBvKBeCZCQ1G+XGNsmTv3IlpLRwTQb
 fZhN6QvkN/NhnoTZr1E8bxMO+5bH4COctYTyPVokbsA2e8qYOM3GIvSIkGKhwtqcXwYW5TcSe1O
 MdVt1mI9HzN15nz1nATNKpujhvIAjSG+RdI3QQT7QonELbH0IUzJALWfVDtP29MncHXNbuf1vbw
 XSmtZE5dChbf9SHnvH1LXo/dsV1L0WFTG81k67ekQGYyqcteU6Qd3rfaOyoRzM2k6IhZYaH7dYq
 6wQX2LWjpoKTluAGvxrOYdO6hkQYPPK/oD8nNKUbL8moousN2vkUSII1slzK1VCnmUlsY3Dqwe2
 esBDMZiYdgAMCuc305T/VuRdftdGYc/ywGJg6OeNeNGVp5xMdq7gsitA041MHQMCOCjyZ+6Lbwa
 QKSh6Ix+fGm27sAni2kI0lLuw5/dRUQnzyAnB4edwWp0WQiQU6Eeb7aWvs+uBRIK8XfgjezAIuU
 x0shAuvI/StJycPRNjdIguNPW6Yg9NEvQOnMSCm6pxDGFmRMfKLOLbpdDblxiHCxWIRFl+ke3n+
 SLw7KVqWoo+vd/Mb3KuewBYrYPkBrfG7AE0P80ZAcIDbC/L5jMY=
X-Received: by 2002:a17:907:c80f:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c23f9766ad3mr361335766b.9.1787145679611; 
 Wed, 19 Aug 2026 06:21:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm5951448f8f.8.2026.08.19.06.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:21:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:21:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 1fb0b5f4ecbdacdf2ccf0596d57363adc405c1d7
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03232582edcaf935e8f231867f5db52ca59fed09-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgEU-0003CR-1g
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
Content-Type: multipart/mixed; boundary="===============0701601667655085988=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0701601667655085988==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8u9/3WwyF6o="; charset=UTF-8

--8u9/3WwyF6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, razvanc, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail

to look at the new p=
atch set (#3)=2E


Change subject: gen-release-tarballs=2Esh: Remove
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-release-tarball=
s=2Esh: Remove

This is unused (all our releases use code in openvpn-build
=
repository instead) and of doubtful use=2E E=2Eg=2E why would we
need three=
 different tarballs for releases?

It also has small issues like using a /b=
in/sh shebang but
containing bashisms=2E

So get rid of the dead code=2E

C=
hange-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
---
D dev-tools/gen-release-tarballs=2E=
sh
1 file changed, 0 insertions(+), 246 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1847/3

diff --git a/dev-=
tools/gen-release-tarballs=2Esh b/dev-tools/gen-release-tarballs=2Esh
delet=
ed file mode 100755
index 6071b57=2E=2E0000000
--- a/dev-tools/gen-release-=
tarballs=2Esh
+++ /dev/null
@@ -1,246 +0,0 @@
-#!/bin/sh
-# gen-release-tar=
balls=2Esh  -  Generates release tarballs with signatures
-#
-# Copyright (=
C) 2017-2026 - David Sommerseth <davids@openvpn=2Enet>
-#
-# This program i=
s free software; you can redistribute it and/or
-# modify it under the term=
s of the GNU General Public License
-# as published by the Free Software Fo=
undation; either version 2
-# of the License=2E
-#
-# This program is distr=
ibuted in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; wit=
hout even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=2E  See the
-# GNU General Public License for more details=2E=

-#
-# You should have received a copy of the GNU General Public License
-#=
 along with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
-#
-set -u
-
-if [ $# -ne 4 ]; then
-    echo "Usage: $0 <remote-name> =
<tag-name> <sign-key> <dest-dir>"
-    echo ""
-    echo "   remote-name  -=
- valid remotes: `git remote | tr \\\n ' '`"
-    echo "   tag-name     -- =
An existing release tag"
-    echo "   sign-key     -- PGP key used to sign=
 all files"
-    echo "   dest-dir     -- Where to put the complete set of =
release tarballs"
-    echo ""
-    echo "   Example: $0 origin v2=2E4=2E2 =
/tmp/openvpn-release"
-    echo
-    exit 1
-fi
-
-arg_remote_name=3D"$1"
-=
arg_tag_name=3D"$2"
-arg_sign_key=3D"$3"
-arg_dest_dir=3D"$4"
-
-#
-# Sanit=
y checks
-#
-
-# Check that the tag exists
-git tag | grep "$arg_tag_name" =
1>/dev/null
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  The tag '$arg_ta=
g_name' does not exist"
-    exit 2
-fi
-
-# Extract the git URL
-giturl=3D=
"`git remote get-url $arg_remote_name 2>/dev/null`"
-if [ $? -ne 0 ]; then
=
-    echo "** ERROR ** Invalid git remote name: $arg_remote_name"
-    exit=
 2
-fi
-
-# Check we have the needed signing key
-echo "test" | gpg -a --cl=
earsign -u "$arg_sign_key" 2>/dev/null 1>/dev/null
-if [ $? -ne 0 ]; then
-=
    echo "** ERROR ** Failed when testing the PGP signing=2E  Wrong signing=
 key?"
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
=
-    local wildcard=3D"$1"
-
-    res=3D"`find =2E -maxdepth 1 -type f -nam=
e \"$wildcard\" | head -n1 | cut -d/ -f2-`"
-    if [ $? -ne 0 ]; then
-   =
     echo "-- 'find' failed=2E"
-        exit 5
-    fi
-    if [ -z "$res"=
 ]; then
-        echo "-- Could not find a file with the wildcard: $wildca=
rd"
-        exit 4
-    fi
-    echo "$res"
-}
-
-copy_files()
-{
-    loc=
al fileext=3D"$1"
-    local dest=3D"$2"
-
-    file=3D"`get_filename openv=
pn-*=2E*=2E*=2E$fileext`"
-    if [ -z "$file" ]; then
-        echo "** ER=
ROR Failed to find source file"
-        exit 5
-    fi
-    echo "-- Copyi=
ng $file"
-    cp "$file" "$dest"
-    if [ $? -ne 0 ]; then
-        echo =
"** ERROR ** Failed to copy $file to $destdir"
-        exit 3;
-    fi
-}
=
-
-sign_file()
-{
-    local signkey=3D"$1"
-    local srchfile=3D"$2"
-   =
 local signtype=3D"$3"
-    local file=3D"`get_filename $srchfile`"
-
-    =
echo "-- Signing $file =2E=2E=2E"
-    case "$signtype" in
-        inline)=

-            # Have the signature in the same file as the data
-          =
  gpg -a --clearsign -u "$signkey" "$file" 2>/dev/null
-            res=3D$=
?
-            if [ $res -eq 0 ]; then
-                rm -f "$file"
-    =
        fi
-            ;;
-
-        detached)
-            # Have the sig=
nature in a separate file
-            gpg -a --detach-sign -u "$signkey" "=
$file" 2>/dev/null
-            res=3D$?
-            ;;
-
-        *)
-   =
         echo "** ERROR **  Unknown signing type \"$signtype\"=2E"
-       =
     exit 4;
-    esac
-
-    if [ $res -ne 0 ]; then
-        echo "** ERR=
OR **  Failed to sign the file $PWD/$file"
-        exit 4;
-    fi
-}
-
-
=
-#
-# Preparations
-#
-
-# Create the destination directory, using a sub-di=
r with the tag-name
-destdir=3D""
-case "$arg_dest_dir" in
-    /*) # Absol=
ute path
-        destdir=3D"$arg_dest_dir/$arg_tag_name"
-        ;;
-    =
*)  # Make absolute path from relative path
-        destdir=3D"$PWD/$arg_d=
est_dir/$arg_tag_name"
-        ;;
-esac
-echo "-- Destination directory: $=
destdir"
-if [ -e "$destdir" ]; then
-    echo "** ERROR ** Destination dir=
ectory already exists=2E  "
-    echo "            Please check your comman=
d line carefully=2E"
-    exit 2
-fi
-
-mkdir -p "$destdir"
-if [ $? -ne 0 =
]; then
-    echo "** ERROR ** Failed to create destination directory"
-   =
 exit 2
-fi
-
-#
-# Start the release process
-#
-
-# Clone the remote repo=
sitory
-workdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
-c=
d $workdir
-echo "-- Working directory: $workdir"
-echo "-- git clone $gitu=
rl"
-git clone $giturl openvpn-gen-tarball 2> "$workdir/git-clone=2Elog" 1>=
&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  git clone failed=2E  See =
$workdir/git-clone=2Elog for details"
-    exit 3;
-fi
-cd openvpn-gen-tarb=
all
-
-# Check out the proper release tag
-echo "-- Checking out tag $arg_t=
ag_name =2E=2E=2E "
-git checkout -b mkrelease "$arg_tag_name" 2> "$workdir=
/git-checkout-tag=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **=
  git checkout failed=2E  See $workdir/git-checkout-tag=2Elog for details"
=
-    exit 3;
-fi
-
-# Prepare the source tree
-echo "-- Running autoreconf =
+ a simple configure =2E=2E=2E "
-(autoreconf -vi && =2E/configure) 2> "$wo=
rkdir/autotools-prep=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR=
 **  Failed running autotools=2E  See $workdir/autotools-prep=2Elog for det=
ails"
-    exit 3;
-fi
-
-# Generate the tar/zip files
-echo "-- Running ma=
ke distcheck (generates =2Etar=2Egz) =2E=2E=2E "
-(make distcheck) 2> "$wor=
kdir/make-distcheck=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR =
**  make distcheck failed=2E  See $workdir/make-distcheck=2Elog for details=
"
-    exit 3;
-fi
-copy_files tar=2Egz "$destdir"
-
-echo "-- Running make=
 dist-xz (generates =2Etar=2Exz) =2E=2E=2E "
-(make dist-xz) 2> "$workdir/m=
ake-dist-xz=2Elog" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make=
 dist-xz failed=2E  See $workdir/make-dist-xz=2Elog for details"
-    exit =
3;
-fi
-copy_files tar=2Exz "$destdir"
-
-echo "-- Running make dist-zip (g=
enerates =2Ezip) =2E=2E=2E "
-(make dist-zip) 2> "$workdir/make-dist-zip=2E=
log" 1>&2
-if [ $? -ne 0 ]; then
-    echo "** ERROR **  make dist-zip fail=
ed=2E  See $workdir/make-dist-zip=2Elog for details"
-    exit 3;
-fi
-copy=
_files zip "$destdir"
-
-# Generate SHA256 checksums
-cd "$destdir"
-sha256=
sum openvpn-*=2Etar=2E{gz,xz} openvpn-*=2Ezip > "openvpn-$arg_tag_name=2Esh=
a256sum"
-
-# Sign all the files
-echo "-- Signing files =2E=2E=2E "
-sign_=
file "$arg_sign_key" "openvpn-$arg_tag_name=2Esha256sum" inline
-sign_file =
"$arg_sign_key" "openvpn-*=2Etar=2Egz" detached
-sign_file "$arg_sign_key" =
"openvpn-*=2Etar=2Exz" detached
-sign_file "$arg_sign_key" "openvpn-*=2Ezip=
" detached
-
-# Create a tar-bundle with everything
-echo "-- Creating fina=
l tarbundle with everything =2E=2E=2E"
-tar cf "openvpn-$arg_tag_name=2Etar=
" openvpn-*=2E{tar=2Egz,tar=2Exz,zip}{,=2Easc} openvpn-*=2Esha256sum=2Easc
=
-
-echo "-- Cleaning up =2E=2E=2E"
-# Save the log files
-mkdir -p "$destdi=
r/logs"
-mv $workdir/*=2Elog "$destdir/logs"
-
-# Finally, done!
-rm -rf "$=
workdir"
-echo "-- Done"
-exit 0

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1847?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Num=
ber: 1847
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--8u9/3WwyF6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">gen-release-tarballs=2Esh: Remove<br><br>This is unused (all our rel=
eases use code in openvpn-build<br>repository instead) and of doubtful use=
=2E E=2Eg=2E why would we<br>need three different tarballs for releases?<br=
><br>It also has small issues like using a /bin/sh shebang but<br>containin=
g bashisms=2E<br><br>So get rid of the dead code=2E<br><br>Change-Id: I10b9=
12bad3bb0b97e2b47eae20d2dd7ffb0c6879<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt;<br>---<br>D dev-tools/gen-release-tarballs=2E=
sh<br>1 file changed, 0 insertions(+), 246 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47=
/1847/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/dev-tools/gen-release-tarballs=2Esh b/dev-tool=
s/gen-release-tarballs=2Esh</span><br><span>deleted file mode 100755</span>=
<br><span>index 6071b57=2E=2E0000000</span><br><span>--- a/dev-tools/gen-re=
lease-tarballs=2Esh</span><br><span>+++ /dev/null</span><br><span>@@ -1,246=
 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# gen-release-tarballs=2E=
sh  -  Generates release tarballs with signatures</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# Copyright (C) 2017-2026 - David Sommerseth &lt;davids@openvpn=2En=
et&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# This program is free software; yo=
u can redistribute it and/or</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# modify it under the terms of the GNU General Public License</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# as published by the Free S=
oftware Foundation; either version 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# of the License=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This =
program is distributed in the hope that it will be useful,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# You should have r=
eceived a copy of the GNU General Public License</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# along with this program; if not, see &lt;https=
://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set -u=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-if [ $# -ne 4 ]; then</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    echo &quot;Usage: $0 &lt;remote-name&g=
t; &lt;tag-name&gt; &lt;sign-key&gt; &lt;dest-dir&gt;&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   remote-name  -- val=
id remotes: `git remote | tr \\\n &#39; &#39;`&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   tag-name     -- An existi=
ng release tag&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   echo &quot;   sign-key     -- PGP key used to sign all files&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   dest-dir =
    -- Where to put the complete set of release tarballs&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;   Example: $0 orig=
in v2=2E4=2E2 /tmp/openvpn-release&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    exit 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-arg_remote_name=3D&quot;$1&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-arg_tag_name=3D&quot;$2&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-arg_sign_key=3D&quot;$3&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-arg_dest_dir=3D&=
quot;$4&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-# Sanity checks</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Check that the tag =
exists</span><br><span style=3D"color: hsl(0, 100%, 40%);">-git tag | grep =
&quot;$arg_tag_name&quot; 1&gt;/dev/null</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    echo &quot;** ERROR **  The tag &#39;$arg_tag_name&#=
39; does not exist&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    exit 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# Extract the git URL</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-giturl=3D&quot;`git remote get-url $arg_remote_n=
ame 2&gt;/dev/null`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    echo &quot;** ERROR ** Invalid git remote name: $arg_remote_name&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 2</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# Check we have the needed signing key</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-echo &quot;test&quot; | gpg -a --clearsign -u &quot;=
$arg_sign_key&quot; 2&gt;/dev/null 1&gt;/dev/null</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR ** Failed when testing =
the PGP signing=2E  Wrong signing key?&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    exit 2;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# Helper functions</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-get_filename()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    local wildcard=3D&quot;$1&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    res=3D&quot;`find =2E -maxdepth 1 -type f -name \&quot;$wildcard\&=
quot; | head -n1 | cut -d/ -f2-`&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if [ $? -ne 0 ]; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        echo &quot;-- &#39;find&#39; failed=2E&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        exit 5</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$res&quot; ]; then</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;-- Could =
not find a file with the wildcard: $wildcard&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        exit 4</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    echo &quot;$res&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-copy_files()</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    local fileext=3D&quot;$1&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    local dest=3D&quot;$2&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    file=3D&quot;`get_filename openvpn-*=2E*=2E*=2E$filee=
xt`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z =
&quot;$file&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        echo &quot;** ERROR Failed to find source file&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        exit 5</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    echo &quot;-- Copying $file&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    cp &quot;$file&quot; &quot;$dest&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ $? -ne 0=
 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo =
&quot;** ERROR ** Failed to copy $file to $destdir&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        exit 3;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file()</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    local signkey=3D&quot;$1&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    local srchfile=3D&quot;$2&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    local signtype=3D&quot;$3=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local file=
=3D&quot;`get_filename $srchfile`&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 echo &quot;-- Signing $file =2E=2E=2E&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    case &quot;$signtype&quot; in</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        inline)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            # Have the signature in the same f=
ile as the data</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      gpg -a --clearsign -u &quot;$signkey&quot; &quot;$file&quot; 2&gt;/de=
v/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            res=
=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if [=
 $res -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              rm -f &quot;$file&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            fi</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        detached)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            # Have the =
signature in a separate file</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            gpg -a --detach-sign -u &quot;$signkey&quot; &quot;$file=
&quot; 2&gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            res=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        *)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            echo &quot;** ERROR **  Unkn=
own signing type \&quot;$signtype\&quot;=2E&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            exit 4;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    esac</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [=
 $res -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      echo &quot;** ERROR **  Failed to sign the file $PWD/$file&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        exit 4;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# Preparations</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# Create the destination di=
rectory, using a sub-dir with the tag-name</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-destdir=3D&quot;&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-case &quot;$arg_dest_dir&quot; in</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /*) # Absolute path</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        destdir=3D&quot;$arg_dest_dir/$=
arg_tag_name&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *)  # Make=
 absolute path from relative path</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        destdir=3D&quot;$PWD/$arg_dest_dir/$arg_tag_name&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-esac</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-echo &quot;-- Destination directory: $destdir&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -e &quot;$destd=
ir&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
cho &quot;** ERROR ** Destination directory already exists=2E  &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;            =
Please check your command line carefully=2E&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-mkdir -p &quot;$destdir=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]=
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;=
** ERROR ** Failed to create destination directory&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    exit 2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Start the release process</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# Clone the remote repository</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-workdir=3D&quot;`mktemp -d -p /var/tmp openvpn-build-release-XX=
XXXX`&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd $workdi=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Workin=
g directory: $workdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-echo &quot;-- git clone $giturl&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-git clone $giturl openvpn-gen-tarball 2&gt; &quot;$wo=
rkdir/git-clone=2Elog&quot; 1&gt;&amp;2</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    echo &quot;** ERROR **  git clone failed=2E  See $wor=
kdir/git-clone=2Elog for details&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    exit 3;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd openvpn-g=
en-tarball</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# Check out the proper release t=
ag</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Check=
ing out tag $arg_tag_name =2E=2E=2E &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-git checkout -b mkrelease &quot;$arg_tag_name&quot; 2&=
gt; &quot;$workdir/git-checkout-tag=2Elog&quot; 1&gt;&amp;2</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ERROR **  git check=
out failed=2E  See $workdir/git-checkout-tag=2Elog for details&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 3;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# P=
repare the source tree</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-echo &quot;-- Running autoreconf + a simple configure =2E=2E=2E &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-(autoreconf -vi &amp;&amp=
; =2E/configure) 2&gt; &quot;$workdir/autotools-prep=2Elog&quot; 1&gt;&amp;=
2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]; the=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** ER=
ROR **  Failed running autotools=2E  See $workdir/autotools-prep=2Elog for =
details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit=
 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# Generate the tar/zip files</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-echo &quot;-- Running make distcheck (generates =2E=
tar=2Egz) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-(make distcheck) 2&gt; &quot;$workdir/make-distcheck=2Elog&quot; 1&gt;=
&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $? -ne 0 ]=
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;=
** ERROR **  make distcheck failed=2E  See $workdir/make-distcheck=2Elog fo=
r details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ex=
it 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-copy_files tar=2Egz &quot;$destdir&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Running make dist-xz (g=
enerates =2Etar=2Exz) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-(make dist-xz) 2&gt; &quot;$workdir/make-dist-xz=2Elog&quo=
t; 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $?=
 -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ech=
o &quot;** ERROR **  make dist-xz failed=2E  See $workdir/make-dist-xz=2Elo=
g for details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  exit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-copy_files tar=2Exz &quot;$dest=
dir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Running make dist-z=
ip (generates =2Ezip) =2E=2E=2E &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-(make dist-zip) 2&gt; &quot;$workdir/make-dist-zip=2Elog&q=
uot; 1&gt;&amp;2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ =
$? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
cho &quot;** ERROR **  make dist-zip failed=2E  See $workdir/make-dist-zip=
=2Elog for details&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    exit 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-copy_files zip &quot;$dest=
dir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# Generate SHA256 checksums</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cd &quot;$destdir&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-sha256sum openvpn-*=2Etar=
=2E{gz,xz} openvpn-*=2Ezip &gt; &quot;openvpn-$arg_tag_name=2Esha256sum&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# Sign all the files</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Signing files =2E=2E=2E &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$a=
rg_sign_key&quot; &quot;openvpn-$arg_tag_name=2Esha256sum&quot; inline</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_=
key&quot; &quot;openvpn-*=2Etar=2Egz&quot; detached</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;o=
penvpn-*=2Etar=2Exz&quot; detached</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-sign_file &quot;$arg_sign_key&quot; &quot;openvpn-*=2Ezip&quot=
; detached</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# Create a tar-bundle with every=
thing</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Cr=
eating final tarbundle with everything =2E=2E=2E&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-tar cf &quot;openvpn-$arg_tag_name=2Etar&q=
uot; openvpn-*=2E{tar=2Egz,tar=2Exz,zip}{,=2Easc} openvpn-*=2Esha256sum=2Ea=
sc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-echo &quot;-- Cleaning up =2E=2E=2E&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Save the log files=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mkdir -p &quot;$destd=
ir/logs&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mv $work=
dir/*=2Elog &quot;$destdir/logs&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Fin=
ally, done!</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm -rf &qu=
ot;$workdir&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo=
 &quot;-- Done&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-e=
xit 0</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">change 1847</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10b912bad3b=
b0b97e2b47eae20d2dd7ffb0c6879 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></=
html>
--8u9/3WwyF6o=--


--===============0701601667655085988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0701601667655085988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0701601667655085988==--

