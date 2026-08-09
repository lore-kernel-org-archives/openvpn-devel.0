Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9B8C5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7YuN7pApunoqUPbgj77nyisK4JtNfKXlQwO5aa8sDU=; b=eUiUrxHMJr76TSAIMdvuhQE95Y
	TCdiY/mG75vxah7W255Pz5xFWyD9vA0wJbPefK3HyiiZOBJCz07/BHMTA2Lcz4U2SAGYxcV0YugLI
	U5YzxGs+Zl34TW6Po41vn9QNmYkAyZwTi1o/5q6AA6Mdz30lNOTNwlLAA6NaOFT5BiXc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt5UJ-0002YT-Lk;
	Sun, 09 Aug 2026 15:30:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wt5UH-0002YN-S7
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Enfv94r59x7iVZ8g0CprMEtLpByqMoMaBLbfae9kGdo=; b=mOyutxIs47v1O31CkXWXGM8xd5
 ne9vZTBw+084hMCq1HXQGM3OZVbzkxz5H8LDhtQPjIozZ4FXGtFCxEtOnJm8Sc7df3o5IIOytSqRX
 9Vu5zNcLHMRtm8AxK14eipYwBW/k5GwlKx8Uks6VQR2JtpTKh7CGo95YkcDY4beiqdSE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Enfv94r59x7iVZ8g0CprMEtLpByqMoMaBLbfae9kGdo=; b=D4RYgeYwvf8KItGQTnaMBXqYAM
 p3je1q++IlrfH6UzDlsHupjOSXDWB7bsjff3JZMte9IcGplXgEJ6CGPXCdypRhJ6E9vLJbxezMiw2
 NNO1/TWq8vWOnpATZE3G6EXFnjC+uRxmBK3rADQkkKZP7vMNF6KngTlIS6+KsedWXbKI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wt5UE-00053g-FD for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:30:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 679FUl6r014752
 for <openvpn-devel@lists.sourceforge.net>; Sun, 9 Aug 2026 17:30:47 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 679FUlMF014750
 for openvpn-devel@lists.sourceforge.net; Sun, 9 Aug 2026 17:30:47 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  9 Aug 2026 17:30:41 +0200
Message-ID: <20260809153046.14738-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wt5UE-00053g-FD
Subject: [Openvpn-devel] [PATCH v3] t_client.sh.in: Use printf instead of
 echo -e
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

In some shells the echo builtin doesn't interpret -e as
an argument, it just outputs it as a string.

Examples for shells I have observed this with are dash on
Ubuntu and /bin/sh on macOS.

Use printf instead which should have better consistency
across shells and operating systems.

Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1753
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1753
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7233187..0254c0c3 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -132,21 +132,20 @@
 {
     case $V in
 	0) outbuf="" ;;			# no per-test output at all
-	1) echo -e "$@"			# compact, details only on failure
+	1) printf "$@\n"			# compact, details only on failure
            outbuf="\n" ;;
-	*) echo -e "\n$@\n" ;;		# print all, with a bit formatting
+	*) printf "\n$@\n" ;;		# print all, with a bit formatting
     esac
 }
 
 output()
 {
-    NO_NL=''; if [ "X$1" = "X-n" ] ; then NO_NL=$1 ; shift ; fi
+    END_NL="\n"; if [ "X$1" = "X-n" ] ; then END_NL="" ; shift ; fi
     case $V in
 	0) ;;				# no per-test output at all
-	1) outbuf="$outbuf$@" 		# print details only on failure
-	   test -z "$NO_NL" && outbuf="$outbuf\n"
+	1) outbuf="$outbuf$@${END_NL}"	# print details only on failure
            ;;
-	*) echo -e $NO_NL "$@" ;;	# print everything
+	*) printf "$@${END_NL}" ;;	# print everything
     esac
 }
 
@@ -340,7 +339,7 @@
         else
             output "skip check failed, SKIP test $SUF."
 	    SUMMARY_SKIP="$SUMMARY_SKIP $SUF"
-	    echo -e "$outbuf" ; continue
+	    printf "$outbuf" ; continue
         fi
     fi
 
@@ -361,7 +360,7 @@
 	fail "make sure that ping hosts are ONLY reachable via VPN, SKIP test $SUF."
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=31
-	echo -e "$outbuf" ; continue
+	printf "$outbuf" ; continue
     fi
 
     pidfile="${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
@@ -407,7 +406,7 @@
 	trap - 0 1 2 3 15
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=30
-	echo -e "$outbuf" ; continue
+	printf "$outbuf" ; continue
     fi
 
     # make sure openvpn client is terminated in case shell exits
@@ -470,15 +469,15 @@
 	SUMMARY_OK="$SUMMARY_OK $SUF"
     else
 	if [ "$V" -gt 0 ] ; then
-	    echo -e -n "$outbuf"
-	    echo -e "test run $SUF: $fail_count test failures. FAIL.\n"
+	    printf "$outbuf"
+	    echo "test run $SUF: $fail_count test failures. FAIL."
         fi
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=30
     fi
 
     if [ -n "$test_cleanup" ]; then
-        echo -e "cleaning up: '$test_cleanup'"
+        echo "cleaning up: '$test_cleanup'"
         eval $test_cleanup
     fi
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
