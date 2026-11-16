Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E139606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KOu4zf1q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Upr+z7bX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FCx3Gen2;
	dkim=neutral header.d=eurephia.org header.i=@eurephia.org header.a=rsa-sha256 header.s=MBO0001 header.b=jSQAboty
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:MIME-Version:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cx1qiUtJ8fxs1OVd/tnjBdmn1DhcV+Rp70Dbd+BOdaw=; b=KOu4zf1qq1rvlp9F3lrzR0ILSi
	DgZ7dILwRMhYOsbfyLDW2/4sLydPf9Tm6JB08RBUEUewNbUw/rqc2uxkFWu0nhKlybKCkkwHgrsR0
	crZ/9HZsEaxqzqum/peGVbsxW/bl0oCIdDcvD6dcIdmAxs8WrP9HFe1oolRe8qTEsYFc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvBG-000000000kl-0h2M;
	Mon, 16 Nov 2026 11:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dazo+openvpn@eurephia.org>)
 id 1xSvB9-000000000jy-32yg; Mon, 16 Nov 2026 11:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:To:Subject:
 From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NR+irGc4iG1vI6vjJ289kWAf/VyftScIlv1nGWjmQa8=; b=Upr+z7bXyLjxGRA36IxTnjG1pX
 gMuwqIUYcVuIsG8ErEH/QZ7o2LaTvU2RYoO4asjuwTbqDnkAz3Dx1xnPkbTO+OeJzY9R9AaVaD38W
 NQKGYw44azOPG4p7p+NaPF3UzOs1DAt9JVQsE8OmGi2K7OyzF4XgH9ydkiwul5HX2Ulk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:To:Subject:From:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NR+irGc4iG1vI6vjJ289kWAf/VyftScIlv1nGWjmQa8=; b=FCx3Gen2yvlEie+la4G3X9q2Wp
 6XRN7f67SqHFw+a7YveNj7/ytta+3Tp2/VcSxky1T7SYhcG8JK07UIrAeHHD9PtN/rRoUV+A8CgKg
 JUuadp7t842ldCDDfLbWZFpj5J3pa/YQ53EAk8dic90v1wU+jg7uOG1JRm91hYGszNAw=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSvB7-000000004xr-3sfi; Mon, 16 Nov 2026 11:47:19 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSmLP3Vl4zMlvx;
 Mon, 16 Nov 2026 12:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eurephia.org;
 s=MBO0001; t=1794829629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NR+irGc4iG1vI6vjJ289kWAf/VyftScIlv1nGWjmQa8=;
 b=jSQAbotyAlTg0GZl4aFqgiQFVD4LEzJZtJuYfkDmOo6evbRy5gn1FbqnrW+MeScQSez/1k
 hi0Cl7Q/lBnwFzdlskdpB4e9ObKXF8Av54ctRcOyE8PUpaMl1w8399xTcSOXFBr6Pjind1
 VSS/NgF0yhLHtj588RdIattPOG1Z607w9lLucFYIGZ/WFLbxIywWYxeNffBpnkizvd6tSg
 vhE9ohqXqaWkzC5qZqlCkC2ShQgOLfuN6jayxPD2ctZtQkHHzP9gBkDkVLP1zJ78S6JRiZ
 fleKoDAtSgoUELb5YzU3otv1id9/q4VXXJb+ibZ4r0/X2+9VG8TNL1WraLpDXQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of dazo+openvpn@eurephia.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=dazo+openvpn@eurephia.org
Message-ID: <c34a2c31-7c11-448d-b59c-53682e94b513@eurephia.org>
Date: Mon, 16 Nov 2026 12:47:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "openvpn-users@lists.sourceforge.net"
 <openvpn-users@lists.sourceforge.net>,
 openvpn-devel <Openvpn-devel@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Content-Language: en-GB, en-US
X-Rspamd-Queue-Id: 4jSmLP3Vl4zMlvx
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xSvB7-000000004xr-3sfi
Subject: [Openvpn-devel] OpenVPN 3 Linux v27.2 released
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: David Sommerseth via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: David Sommerseth <dazo+openvpn@eurephia.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

OpenVPN 3 Linux v27.2 (Stable release)

The v27.2 release is a security and minor bugfix release

* FEATURE DEPRECATION: openvpn3-autoload

  ** THIS IS THE LAST STABLE RELEASE SHIPPING THIS UTILITY - MIGRATE NOW **

  The openvpn3-autoload feature was deprecated already in the
  v20 release.  This feature will be removed in the next major
  release.

  The replacement is the openvpn3-session@.service systemd unit.
  Please see the openvpn3-systemd man page [1] for more details.

  If you depend on openvpn3-autoload today, please migrate ASAP
  to the systemd approach.

  [1]
<https://codeberg.org/OpenVPN/openvpn3-linux/src/branch/master/docs/man/openvpn3-systemd.8.rst>


* Security: OpenVPN 3 Core Library update

  The OpenVPN 3 Core Library has been updated to version 3.11.8.
  This fixes CVE-2026-106017, which addressed improper extended
  key usage restrictions in the certificates.


* Various improvements

  The build system has received various updates, correcting minor
  issues.  ASIO has been upgraded to 1.38.2.  There are also
  several documentation enhancements.


Known issues:

  - The openvpn3-service-netcfg service does not differentiate between
    --dns server X resolve-domains and --dns search-domains when using
    the --resolv-conf mode, which is not the intended behaviour.  This
    was discovered in the v24 release and will be fixed in an upcoming
    release.  When this gets fixed, only --dns search-domains will be
    considered as search domains and --dns server X resolve-domains
    will enable split-DNS when using --systemd-resolved and otherwise
    ignored when using --resolv-conf with openvpn3-service-netcfg.


Supported Linux distributions
-----------------------------

  - Debian: 12, 13
  - Fedora: 43, 44, 45
  - Red Hat Enterprise Linux 8, 9, 10[see note below]
  - Ubuntu: 22.04, 24.04, 26.04, 26.10

Installation and getting started instructions can be found here:

  <https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux>

The repositories provided by OpenVPN Inc will be updated in the
coming days. The community provided repositories on Fedora Copr
and openSUSE Build Service are already published.

In addition, other Linux distributions are now providing
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
distributions:

 - openSUSE Factory (x86_64, aarch64)
 - openSUSE Leap 16.0 (x86_64, aarch64)
 - openSUSE Slowroll (x86_64)
 - openSUSE Tumbleweed (x86_64, aarch64)


Source forge hosting
--------------------

OpenVPN 3 Linux and GDBus++ are being pushed to several forge hosting
services: Codeberg (main), GitLab (mirror) and GitHub (mirror).  In
addition, starting from v27, the Radicle Network was added.

Codeberg will for now be the main repository for bug/issue tracking.
For patch ("pull request") submissions, it is preferred to use the
openvpn-devel@lists.sourceforge.net mailing list.  In addition, the
Radicle Network can now be used.

The Radicle Network is a fully distributed network for hosting
projects.  This satisfies one big reason why the mailing list approach
has been the preferred way for submitting patches - it is decentralised
and it does not require a single hosting service to be available at
all times.  In addition, since Radicle is fully decentralised, it
also provides a solid integrity check against any changes in a project,
which also includes changes to the patch submission tracking as well
as the git repository changes (and issue tracking, which we will not
make use of at the moment).

For more information on Radicle, visit <https://radicle.dev/>.

For a quick-start guide to use Radicle, see
<https://radicle.dev/guides/quick-start>.


--
kind regards,

David Sommerseth
OpenVPN Inc


---- Source tarballs ---------------------------------------------------
* OpenVPN 3 Linux v27.2


<https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.2.tar.xz>

<https://swupdate.openvpn.net/community/releases/openvpn3-linux-27.2.tar.xz.asc>

  Radicle Artifact release: e5a9f8384b16cfc13560ac2474fb802d774c30ff

* GDBus++ v3

  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz>
  <https://swupdate.openvpn.net/community/releases/gdbuspp-3.tar.xz.asc>

  Radicle Artifact release: b8ca4b74cbf7bf1ac6ed4dc837fd811bf43e73ca

---- SHA256 Checksums --------------------------------------------------

76640f04df170205325ce32626376fd890ec352bdd305536fbb7c842f0a20a82
openvpn3-linux-27.2.tar.xz
f2dbace5ccffa6315dd12e916f83a99b2d6a0056c52c88f6c27bb0e62d845a3f
openvpn3-linux-27.2.tar.xz.asc
c7a053a13c4eb5811a542b747d5fcdb3a8e58a4a42c7237cc5e2e2ca72e0c94e
gdbuspp-3.tar.xz
b9cf732d7a347f324d6a5532dc48f80c2815dbf6704c169b4ee97a411506a99b
gdbuspp-3.tar.xz.asc

---- git references ----------------------------------------------------

git repositories:

 - OpenVPN 3 Linux

   git tag: v27.2
   git commit: 6dc4bca72773ff1b52c6b7ea2453244dd7b818b2

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


---- Changes from v27.1 to v27.2 -------------------------------------

David Sommerseth (9):
      build: Improve the Python version check
      build: Enforce GDBus++ v3 or older
      docs: Fix minor build instructions
      docs: Update BUILD and QUICK-START to be closer to reality
      events: Fix incorrect and misleading doxygen comments in Events::Log
      cleanup: Remove the m4/ directory
      vendor: Upgrade to ASIO v1.38.2
      tests: Upgrade to gtest v1.18.0
      core: Upgrade to OpenVPN 3 Core Library v3.11.8

Logan Besecker (2):
      docs: correct path to dco-keyconfig.proto
      docs: fix four spelling mistakes

--------------------------------------------------------------------


-- 
--
kind regards,

David Sommerseth
OpenVPN Inc


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
