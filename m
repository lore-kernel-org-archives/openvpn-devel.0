Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B884EC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kf+1fFz8CdpuePPq6+p4TnDAWGhUnRvGcKc8iApwv8s=; b=iyNwMOEfsYXPzpPq60GV2jh6iw
	oTUy0reQn0avy3ZsuPO1Qi1bV61THULQkUyFyvkvDPesoztmQNf9W014ee3FRXmjarzOJIKYk9Wzk
	Wu0C388OuKy32mnQ/JvzGpF07xUkE+oljDeK/AZM7NpXlSdfu0r1VFJ0VM62V+vYXKUM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww02s-0006zJ-KW;
	Mon, 17 Aug 2026 16:18:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1ww02r-0006zC-PJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=on14vkGtyrkO7I6/fXp+j/tGXraKqtOLD29UmRRQXb0=; b=bd1mTPBuy1VAW5VXe9jNB1o/OH
 kOw9ykmRJqjqdUh3xL+M/D2DVvmCTcT3+cvoUeTLzj63PEzBTSlI9fb8TESs0hAgWHHk3C3UqM+2/
 5SSWEw2Utj5GtKbkjQtDqhWBAdGXdHG38Z3tQLkXe1XB9zH7VkrxAIczx5M9YfWA0U/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=on14vkGtyrkO7I6/fXp+j/tGXraKqtOLD29UmRRQXb0=; b=THTamgc+CnIONu2F/rUszXFN60
 qzrY9fzq6Ri9sD5MjgKrucSebKsBiD8y1RNYyMcUOvNFtxZ+aDSxYEWXWAnPGB2wzNqjKXrEUtHmq
 FcYxF9c1zoLgWqhKYNrcxavqPfUD0RWyVOwBTzfo3WD+v7KhQmFVN39m2/rZxuGrPhIk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ww02s-0005k0-Ps for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:18:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67HGIWLF008339
 for <openvpn-devel@lists.sourceforge.net>; Mon, 17 Aug 2026 18:18:32 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67HGIW3i008337
 for openvpn-devel@lists.sourceforge.net; Mon, 17 Aug 2026 18:18:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 17 Aug 2026 18:18:26 +0200
Message-ID: <20260817161831.8322-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1ww02s-0005k0-Ps
Subject: [Openvpn-devel] [PATCH v3] Start a new document CODE_CHECKLIST
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

This is intended to document in one place all the policies
applicable to submitted changes. This serves multiple
purposes:

* Make it clearer to submitters what is required of them
* Make it clearer what to consider automating when developing
  (be it by writing scripts or by instructing an AI agent)
* Reduce the bus factor of the project by reducing the amount
  of things only stored in Gert's head

Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1776
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1776
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CODE_CHECKLIST.md b/CODE_CHECKLIST.md
new file mode 100644
index 0000000..cacb7c9
--- /dev/null
+++ b/CODE_CHECKLIST.md
@@ -0,0 +1,115 @@
+# Checklist for Contributions
+
+## Introduction
+
+This documents all policies applied to any change that should be applied
+in this repository. It is separated in two parts. The first part describes
+the checklist that any submitter should apply. The second part describes
+the checklist that integrators need to apply before actually merging the
+change.
+
+In general the Integrator Checklist does imply that all checks from the
+Submitter Checklist have been passed. They are not repeated.
+
+## Submitter Checklist
+
+### Commit message
+
+* Does the commit message accurately describe the change?
+* Does it end with the line `Signed-off-by: My Name <my@email.com>` ?
+
+### Automated tests
+
+* Did the change pass a local `make` build?
+* Did the change pass a local run of `make check`?
+* Have you verified the code formatting with clang-format?
+* Is the code covered by Unit Tests? If not, have you considered adding
+  a new Unit Test?
+
+### Change-specific checks
+
+* Does your change require adaptions on both server and client side
+  because it changes the wire-protocol?
+  * Did you propose a change to http://github.com/openvpn-rfc/
+    to agree on the protocol format changes?
+* Does your change add, remove, or change a config option?
+  * Have you adapted the usage text (`openvpn --help`)?
+  * Have you adapted the man page text (`man -l ./doc/openvpn.8`)?
+* Have you reviewed all code comments around code you touched to
+  check whether they need to be adapted?
+* If your change adds new files, are they added in some Makefile.am
+  statement that will make sure they up in the distributed source
+  tarballs?
+
+## Integrator Checklist
+
+### General
+
+* Is the exact code change to be merged available as an email on openvpn-devel
+  mailing list (note: this does not apply to the commit message since that needs
+  to be massaged anyway)?
+* If not, is the change to merge a trivial cherry-pick?
+
+### Commit message
+
+* Does it contain the pointer to the email on openvpn-devel?
+  This means a line `Message-Id: <actual msg id>` and a line
+  `URL: <url to mail-archive.com copy of the mail>`. If mail-archive.com
+  is not working, alternatively an URL to SourceForge's mail archive
+  is also acceptable.
+* Does it contain at least one `Acked-by` line from a known OpenVPN
+  core developer? Valid sources for `Acked-by` lines are mails on
+  the mailing list or +2 votes in Gerrit.
+* If the change is a security fix, does it contain a `CVE:` line in
+  the format `CVE: <Year>-<Number>`?
+* If the change fixes a Github issue, does it contain a line
+  `Github: OpenVPN/openvpn#<Number>`? (Other repositories might
+  also be referenced if applicable)
+* Have you considered adding a `Reported-by:` line? This is usual
+  for attribution for security issues but might be added for any
+  report where the reporter added significant value by their report.
+* If doing a cherry-pick, have you made sure to use `git cherry-pick -x`
+  to add a reference to the picked commit?
+
+#### Gerrit specific
+
+Additional checks if the change was reviewed and submitted via Gerrit.
+
+* Does it contain a correct `Gerrit URL:` line? (This is generally ensured
+  by using `gerrit-send-email.py`)
+* Is the `Change-Id:` line present and located in the last paragraph of the
+  message? (If not in the last paragraph, Gerrit will ignore it)
+
+### Automated tests
+
+* Has the change passed a full build run in buildbot? (Usually ensured via
+  Gerrit). This ensures the following points (which otherwise might need to
+  be considered separately):
+  * Build passes on multiple platforms (Linux, FreeBSD, Windows, macOS, other BSDs)
+  * Build passes with multiple compilers (GCC, Clang, MSVC, GCC MinGW)
+  * Build passes with multiple configurations (`--enable-small`, `--disable-management`,
+    etc.)
+  * Build passes with multiple versions of multiple SSL libraries (OpenSSL, mbedTLS)
+  * Unit tests pass in all these settings
+  * t\_server\_null, t\_client pass in all these settings
+  * t\_server passes
+  * Verified clang-format code formatting
+* If buildbot ignored the change that usually means that it did not match the
+  file match list (e.g. only changes in `.github/`). Consider whether that seems
+  correct.
+* Has the change passed a GHA run?
+* Do any of the tests actually exercise the code? If not, has someone other than the
+  submitter done any manual verification?
+
+### Backports
+
+* Is it clear to which branches the change should be applied?
+  * If it is a security fix, it should be applied to all branches that are
+    affected and that are not "unsupported"
+    (cf. https://community.openvpn.net/Pages/Supported%20versions)
+  * If it is a bugfix, it should be applied to all branches that are in
+    "Full stable support". Depending on the severity it might also be
+    applied to branches in "Old stable support".
+* Have you checked for all branches whether a trivial cherry-pick is
+  possible or whether a backport is required? If a backport is required
+  have you communicated this to the submitter?
diff --git a/Makefile.am b/Makefile.am
index 2df7eea..feeaabb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -67,6 +67,7 @@
 	.gitignore \
 	.gitattributes \
 	CONTRIBUTING.rst \
+	CODE_CHECKLIST.md \
 	PORTS \
 	README.cmake.md \
 	README.dco.md \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
