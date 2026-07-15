Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD3C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xZq6DjM1p3zk9Na/mAhPqlKa9Rqjrp/aCV5sL+5CMuo=; b=YQM5Se2ZSnqSLBt/kVvmS6Wkiz
	po2jMB+NNgQkapzGoNv0L8bQxtOkE9zhVCb7ZaiPtbPeXCEXM0o5Kj23eCdWlz9tojuVwHXhSOnuX
	4XPtX2114s57msRRajGz0Wqyp4yGzXOWbO4bekkQMsAYDAkuSh0NSnpFOjbSGvsSNeMo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1oG-0000XX-6v;
	Wed, 15 Jul 2026 15:46:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wk1oD-0000XJ-Cz;
 Wed, 15 Jul 2026 15:46:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tMKXa9fi57oZFewA+5UpVqsgrUlr94c4lmAw18lDmYE=; b=ZGPqtvQBd8MYOXyv/jmEM7uhRi
 E2aZMIYlMIApXjVHq3kqrez0Gnn99LIzJOWRR7eEFOF9KmLkVXP9KKt85nUBxTof1I1Xlv7SNcN0n
 h3TY/p60crprK4VbAFMMcOqTXN6jcuhNpDtc36qKuOKW5OsabIzfmmTBsA0wOgdofLZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tMKXa9fi57oZFewA+5UpVqsgrUlr94c4lmAw18lDmYE=; b=P
 CBdxigcNih3SUASK/UNwts3NHQkAKwisjh7w6/UYRwqVNRrFfHqgDWx3P/Ypq4eO/I7tTCGyvOEa9
 rWNZC+PIp14K5zoEddnuzX5oJJaaW4LF7AtumV0WqZfoWUHdNcTmz0JqLhOV1biqiDWcY6Tv95Xc1
 APFok9fQR1LY2d7g=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wk1oC-00012z-53; Wed, 15 Jul 2026 15:46:06 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h0gW24sT5z8txk;
 Wed, 15 Jul 2026 17:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1784130350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=tMKXa9fi57oZFewA+5UpVqsgrUlr94c4lmAw18lDmYE=;
 b=e6z5r1GJ9uc1LNNQxnWqfCQjLlnoaQpbT6I9wfOscmcIhRID5RSi0Z1k5U/aCO8vWXE01b
 hPUJknCeJPrE1uw3rx0tJnhAJ4UxRuQOqVODB4P/5u9T2qgOAAafW1XnCp7bBG8VFQdTAQ
 sk4KC1UP5Qxl8S0IxwZ7r8BtROhYWlLs7lhyVxPK5JlZZ0avXfkusMjMowjAw/gICbU+tB
 SxNzSho7dGRNRopBPhmUHImLBhDxK1Pski1gJLD3hmawpKOmuexILvVC02Tzk1LWrHdlze
 9Gbuaya4knU3Xt3FxuC18LOtjoShpCqGUhuMNDVQ3jqjQ8FTeh43Zh42ON5+Tg==
Date: Wed, 15 Jul 2026 17:45:47 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-users@lists.sourceforge.net,
 openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net
Message-ID: <alerK-Jp_er1T3fW@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1wk1oC-00012z-53
Subject: [Openvpn-devel] OpenVPN 3 Linux v27.1 released
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

OpenVPN 3 Linux v27.1 (Stable release)

The v27.1 release is purely a bug fix release

* FEATURE DEPRECATION: openvpn3-autoload

  ** THIS IS THE LAST RELEASE SHIPPING THIS UTILITY - MIGRATE NOW **

  The openvpn3-autoload feature was deprecated already in the
  v20 release.  This feature will be removed in the next major
  release.

  The replacement is the openvpn3-session@.service systemd unit.
  Please see the openvpn3-systemd man page [1] for more details.

  If you depend on openvpn3-autoload today, please migrate ASAP
  to the systemd approach.

  [1] <https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master/docs/man/openvpn3-systemd.8.rst>


* Regression: File descriptor leaks with reconnects

  The v27 release attempted to fix a file descriptor leak which
  happens when the VPN session is triggered to do a full reconnect
  to the server.   It turned out that this change caused a lot more
  issues and resulted in a large regression when the server-side
  sent a PUSH_UPDATE event to update routing tables.

  This file descriptor leak fix has been reverted in the v27.1
  release, as the investigation revealed that this requires a more
  careful change inside the OpenVPN 3 Core Library in addition.

  The file descriptor leak can be an issue for users on unstable
  Internet connections, where the client is triggered to do a full
  in-session restart.

  The only workaround is to stop the session completely before
  starting it again.  Using the openvpn3-session@.service unit file,
  this is done with a single

      # systemctl restart openvpn3-session@CONFIG_NAME.service

  command.  This is planned to be fixed in the next major release,
  where it will upgrade to OpenVPN 3 Core Library v3.12.


* Bugfix: VPN sessions using DCO interfaces misbehave with PUSH_UPDATE

  When the server pushed a PUSH_UPDATE event to the client with updates
  to the network configuration, this would cause the DCO-based VPN tunnel
  to freeze and become dysfunctional.  This has been resolved and the
  DCO interface is fully capable of reconfiguring the network when
  requested by the server.


* Bugfix: Retrieve tunnel statistics for DCO interfaces

  It has been a long outstanding bug where the session traffic details
  were not updated when DCO interfaces were used.  This is now fixed and
  the openvpn3 session-stats command will now report up-to-date
  statistics.


* Build: Fixed issues building with GCC-16.1

  Several new compiler warnings appeared, especially in environments
  enabling hardened builds, when the GCC compiler was upgraded to
  version 16.1.  This should be resolved.

  Fixing these issues was a requirement to make Fedora 44 builds
  available.


* OpenVPN 3 Core Library update

  The OpenVPN 3 Core Library has been updated to version 3.11.7. This
  resolves several bugs related to the ovpn-dco-v2 kernel module
  integration, fixes issues with large wire packets when the
  --tls-crypt-v2 feature is used and provides additional fixes for
  GCC-16.1 related compiler warnings.


Known issues:

  - The openvpn3-service-netcfg service does not differentiate between
    --dns server X resolve-domains and --dns search-domains when using
    the --resolv-conf mode, which is not the intended behaviour.  This
    was discovered in the v24 release and is scheduled to be
    fixed in the next releases.  When this gets fixed, only
    --dns search-domains will be considered as search domains and
    --dns server X resolve-domains will enable split-DNS when using
    --systemd-resolved and otherwise ignored when using
    --resolv-conf with openvpn3-service-netcfg.


Supported Linux distributions
-----------------------------

  - Debian: 12, 13
  - Fedora: 43, 44
  - Red Hat Enterprise Linux 8, 9, 10[*]
  - Ubuntu: 22.04, 24.04, 26.04

Installation and getting started instructions can be found here:

  <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

The OpenVPN Inc. provided repositories will be updated in the coming
days.  The community provided repositories on Fedora Copr and
openSUSE Build Service are already published.

There are in addition other Linux distributions now providing
OpenVPN 3 Linux packages.  These distributions are primarily
supported by their respective distribution communities.  We will
naturally review and apply fixes deemed needed for any
distributions as they occur.

NOTE: Red Hat Enterprise Linux 10
  It is necessary to use the 'rhel+epel-10-x86_64' chroot when running
  the 'dnf copr enable' command on RHEL-10.

      # dnf copr enable dsommers/openvpn3 rhel+epel-10-x86_64

  The stable repositories provided by OpenVPN Inc should not
  have this issue.


Experimental Builds
-------------------

With this release we have enabled building packages via the
openSUSE Build Service for the following SUSE/openSUSE
distributions

 - openSUSE Factory (x86_64, aarch64)
 - openSUSE Leap 16.0 (x86_64, aarch64)
 - openSUSE Tumbleweed (x86_64, aarch64)


Source forge hosting
--------------------

OpenVPN 3 Linux and GDBus++ are being pushed to several forge hosting
services: Codeberg (main), GitLab (mirror) and GitHub (mirror).  In
addition from v27, the Radicle Network was added.

Codeberg will for now be the main repository for bug/issue tracking.
For patch ("pull request") submissions, it is preferred to use the
openvpn-devel@lists.sourceforge.net mailing list.  In addition the
Radicle Network can now be used.

The Radicle Network is a fully distributed network for hosting
projects.  This satisfies one big reason why the mailing list approach
has been the preferred way for submitting patches - it is decentralised
and it does not require a single hosting service to be available at
all times.  In addition to Radicle being fully decentralised, it also
provides a pretty solid integrity check to any changes in a project,
which also includes changes to the patch submission tracking as well
as the git repository changes (and issue tracking, which we will not
make use of at the moment).

For more information on Radicle, visit <https://radicle.dev/>

For a quick-start guide to use Radicle, see <https://radicle.dev/guides/quick-start>


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v27.1

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.1.tar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.1.tar.xz.asc>

* GDBus++ v3

  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz>
  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz.asc>

---- SHA256 Checksums --------------------------------------------------

842162e48f7fc756a517b9f5807fb993152e210e996df4a267c3ff2ab40142d6  openvpn3-linux-27.1.tar.xz
960bd3d315a07953b354e9c398c9c97ebaf3cab70f5a4c6442e259800e675b42  openvpn3-linux-27.1.tar.xz.asc
c7a053a13c4eb5811a542b747d5fcdb3a8e58a4a42c7237cc5e2e2ca72e0c94e  gdbuspp-3.tar.xz
b9cf732d7a347f324d6a5532dc48f80c2815dbf6704c169b4ee97a411506a99b  gdbuspp-3.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

 - OpenVPN 3 Linux

   git tag: v27.1
   git commit: 4aff60fe2bfd2fd41b0d373228f746905fbe76d4

   Radicle (PRIMARY, code + patches): rad:zN58oopqzrAkTregNZaRQpgg7x3c
   <https://radicle.network/nodes/bndcrepos.radicle.garden/rad:zN58oopqzrAkTregNZaRQpgg7x3c>

   Codeberg (PRIMARY, code + issue/bugs reports)
   <https://codeberg.org/OpenVPN/openvpn3-linux>

   Code mirrors:
   <https://gitlab.com/openvpn/openvpn3-linux>
   <https://github.com/OpenVPN/openvpn3-linux>

 - GDBus++

   git tag: v3
   git commit: 96f7fb688ed2dea3f192c63c5fe283dbe4900f16

   Radicle (PRIMARY, code + patches): rad:z2Tpg8xVSDgTpoU4Q5FN1aPGqf6mG
   <https://radicle.network/nodes/bndcrepos.radicle.garden/rad:z2Tpg8xVSDgTpoU4Q5FN1aPGqf6mG>

   Codeberg (PRIMARY, code + issue/bugs reports)
   <https://codeberg.org/OpenVPN/gdbuspp/>

   Code mirrors:
   <https://gitlab.com/openvpn/gdbuspp/>
   <https://github.com/openvpn/gdbuspp/>


---- Changes from v27 to v27.1 -------------------------------------

Antonio Quartulli (2):
      dco: retrieve peer stats from kernel module
      netcfg: Make tun_builder_new() DCO-aware for PUSH_UPDATE reconfiguration

David Sommerseth (11):
      common: Fix dhcp-option and dns handling of multiple occurrences
      Revert "client: Plug a file descriptor leak with virtual tun interfaces"
      ovpn3cli/init-config: Show the compiled-in username for the openvpn user
      build/selinux: Refactor the building setup for SELinux policies
      common: Fix missing static declarations in ExclusiveOptionError and ConfigFileException
      policy: Add needed D-Bus policy to access net.openvpn.v3.netcfg.GetPeer
      docs: Remove the "tech-preview" label from DCO functionality
      scripts: Fix get-version extracting wrong git commit for openvpn3-core
      vendor: Upgrade to ASIO 1.38.0
      build: Fix the systemd requirement dependecy again
      core: Update to OpenVPN 3 Core Library v3.11.7

--------------------------------------------------------------------

-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
