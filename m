Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862DDC5DF70
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJr+KoPAClZbVkJSuVMKxQo0KyRBUKMf0ZZmYfujnmk=; b=MLEl9n9YoNM/t78o+N/j0jXICY
	evRVKEezk+3zIJbYHjiMGWYD6XKEQrp7A6epCUZjfkhK+tpMmRxR2eWhO9ie10Wka311N/yIlbIK+
	a+wVaS3C+42wYFsf7p+clhcNlDiqelHGCP0q0WBE9iY5QQfEUSocLWET1LCVxPgVDSK0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww0fc-0007qd-VC;
	Mon, 17 Aug 2026 16:58:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww0fb-0007qU-6n
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cjF8nEQMOIFjjf6PVvkoyGwr7fdYv+B/x/ZgelOxet4=; b=ZhyVUHiQRSjkX1KheK79lwHa3Y
 QZ8jFXSGiYT74zk5d+bMf7PT9wvfXKHBFXEkT6hQDtCf9OClx9O3vkS8Wi5Gplk0jrFFmESzBPgWU
 ttvskxrKEOp9ADyu6uIf5QZJ5WNGvFlOW9DqWQSBMGFqsdDDnHgqD2MZLivY4Zs1DJy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cjF8nEQMOIFjjf6PVvkoyGwr7fdYv+B/x/ZgelOxet4=; b=l
 g5ffPLORi0gbpgwUqRpOX3gDSZ7WaY4QED0tlKDSg+5tek/Y4YiAOJBHSi0Vq+D+1mxrLfNRcG7PB
 2MRuwg8RmreX4ups00+lpkwfETALG5NsZoyzRxn/yWcR/aobSyf6gi1y7TdINvLOdbteLErh3+fX8
 Kc+secYCzSawbgv4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww0fa-0008LP-BX for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:43 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so29775745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786985912; x=1787590712; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cjF8nEQMOIFjjf6PVvkoyGwr7fdYv+B/x/ZgelOxet4=;
 b=FmDcK4bOE926aLNmA6Gs6oaV4zRdMuvBL8TW5dXhh5ZiD7DgRH9XxZgG4uiACRNrcS
 o/0Btc2Zlxlt2sCJ8JjSfKJv9l1fXdlcGZDotDggkseoCCfvtLQ+9SMqrMFy90VdO0iW
 iAZYcVmuE/eqDzQRb0b6WpzCm+jDfG6m9PEnS1CmYT9nsPftoQpMowVpG/Z7yFImn4Pp
 PDGXcSktHWohKuJoGbxeU4NkV2bw6/1oYkg310XtZMxJ5U8He3SZFPgS2XtWOITCBemT
 9w7127B2FohwlFSoOW9nsvediEZ5TzfnoREIfs/qPo0epwBv4Gox7QKBKJAuDpl7RSC+
 BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985912; x=1787590712;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cjF8nEQMOIFjjf6PVvkoyGwr7fdYv+B/x/ZgelOxet4=;
 b=ojw4ffUv1aLfrENwOp9BJckSKHYipJK2QN73XCRtQmwxiVsef/1AZ89PC53SwW9Lxj
 zPEhSISt5TjUUd9GLKgkSpiiMJJjkF6eQWiqEsxN5yhwaPayL/b/z46qRKXQZNN7d6ZN
 44AZSdPFkF5fnMrDFgPnlHdMt81u8e3nThjAyVoHLTUB/Fkev4IlMkby3D1jT3ZbEJdT
 K8bajgRe2QA42OAU/FP/TVvzNWdx9PlfOU5zICX1cUfpfoi109pYEbno7a22zJn37Xt0
 VRbt6BBOowc19LEmDlLHFLxJD0e6A9g1xGFeeTjitC+h9vj4yvmI1cs+SXSZxzXkIoTD
 ZUYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTKLjPlIZHdaTCrVRbpwSE38RbN8ssWRzt3ZviKx5Vv57TBH38Vh7mE7VPQBgInq4sO3Lho4VseavSxkha@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzoq/p/aeLwEg+BJcbve9OqUM9H8XTF7D0iW7VEvvYDKmujX6RF
 9yoIAJA/I8mnNtssv3Xl34cxnej9sPbhO8c40It6hB2fcd/nAdM8BgLuV0idguSljpA2O49Pw3n
 KsHcvxJEsFD6j2FjtTyz1dy8iwY9O4gfctZIofI0hYG7rONFSJeWEQCde3wipv2N8xgL0
X-Gm-Gg: AR+sD10DztF6I77o7fxQocLvXTo+vXu4YJA8bS2NImEv7xusWzepHiC1fUdBBiseLiu
 1Hb/qv/Ti6lwLS/KcE/Gz2IAHQ+bfSdnruAgwE6HG3tSV4fhoC9vtmkjW3apE0PGcJclGqEG2kc
 Drie/HaPMWUYfYzhF4OVNWUPxFKXs14zJYqrwmEarJA8Q/MFdgTNu8nEwQilfFvyce4c+hUL9RS
 JbHLf+3xuftXlCdsv5GV831/elodoK8I/puECM8p80vFW/Z1624z+n8ghfrUr+tmwOJa/lqCpf/
 427anZb4dHMFVh+QQh2497PAemXsd1RWIKkW/1/kCQ8lDFRLDDMFKE5qN+ml77UmRvqayXY1D9x
 sODrbeuILEPliXT7LLAH+rkLY7EEBNLw7Vxgk/bTKsye/BLLyolwXnMbqx15y+qixhOQbc0ifyC
 /a16FtV3aciFY3153YTa+Jy1YWO5DI/n0szbw47MPGe4gKyk1GkVOevzidUBA1jl2RHqfMk392o
 s6+yu04TksWwWUN/jCnQW615MwwOFtY91sMuJyfRainjzn17aqH7vfi6IfXW0c6nnXK2ova5PpP
 Kd1vlCih27oTlNpR/M2+9OS/visEVfxm46L8m4AM52JKVCPyvU3qcndZAnAqJgU=
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id
 5b1f17b1804b1-49987981e52mr437714855e9.19.1786985912001; 
 Mon, 17 Aug 2026 09:58:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb85csm75305715e9.11.2026.08.17.09.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:58:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 16:58:31 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: cc7950b4188b6776f637a5abc29b45182df682a6
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb7c24813ae48f82c0452fdb6970c58035ae372d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww0fa-0008LP-BX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Start a new document
 CODE_CHECKLIST
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6381938409277159945=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6381938409277159945==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GDiev1nHD4s="; charset=UTF-8

--GDiev1nHD4s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1776?usp=3Demail )

Change subject: Start a new document CODE_CHECKLIST=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Start a ne=
w document CODE_CHECKLIST

This is intended to document in one place all th=
e policies
applicable to submitted changes=2E This serves multiple
purposes=
:

* Make it clearer to submitters what is required of them
* Make it clear=
er what to consider automating when developing
  (be it by writing scripts =
or by instructing an AI agent)
* Reduce the bus factor of the project by re=
ducing the amount
  of things only stored in Gert's head

Change-Id: Ib123b=
7bf58317a1be5af1a1d45decb8f31f2ec68
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776
Message-Id: <2026081=
7161831=2E8322-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38465=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A CODE_CHECKLIST=2Emd
M Makef=
ile=2Eam
2 files changed, 116 insertions(+), 0 deletions(-)




diff --git =
a/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd
new file mode 100644
index 0000=
000=2E=2Ecacb7c9
--- /dev/null
+++ b/CODE_CHECKLIST=2Emd
@@ -0,0 +1,115 @@
=
+# Checklist for Contributions
+
+## Introduction
+
+This documents all pol=
icies applied to any change that should be applied
+in this repository=2E I=
t is separated in two parts=2E The first part describes
+the checklist that=
 any submitter should apply=2E The second part describes
+the checklist tha=
t integrators need to apply before actually merging the
+change=2E
+
+In ge=
neral the Integrator Checklist does imply that all checks from the
+Submitt=
er Checklist have been passed=2E They are not repeated=2E
+
+## Submitter C=
hecklist
+
+### Commit message
+
+* Does the commit message accurately desc=
ribe the change?
+* Does it end with the line `Signed-off-by: My Name <my@e=
mail=2Ecom>` ?
+
+### Automated tests
+
+* Did the change pass a local `mak=
e` build?
+* Did the change pass a local run of `make check`?
+* Have you v=
erified the code formatting with clang-format?
+* Is the code covered by Un=
it Tests? If not, have you considered adding
+  a new Unit Test?
+
+### Cha=
nge-specific checks
+
+* Does your change require adaptions on both server =
and client side
+  because it changes the wire-protocol?
+  * Did you propo=
se a change to http://github=2Ecom/openvpn-rfc/
+    to agree on the protoc=
ol format changes?
+* Does your change add, remove, or change a config opti=
on?
+  * Have you adapted the usage text (`openvpn --help`)?
+  * Have you =
adapted the man page text (`man -l =2E/doc/openvpn=2E8`)?
+* Have you revie=
wed all code comments around code you touched to
+  check whether they need=
 to be adapted?
+* If your change adds new files, are they added in some Ma=
kefile=2Eam
+  statement that will make sure they up in the distributed sou=
rce
+  tarballs?
+
+## Integrator Checklist
+
+### General
+
+* Is the exac=
t code change to be merged available as an email on openvpn-devel
+  mailin=
g list (note: this does not apply to the commit message since that needs
+ =
 to be massaged anyway)?
+* If not, is the change to merge a trivial cherry=
-pick?
+
+### Commit message
+
+* Does it contain the pointer to the email =
on openvpn-devel?
+  This means a line `Message-Id: <actual msg id>` and a =
line
+  `URL: <url to mail-archive=2Ecom copy of the mail>`=2E If mail-arch=
ive=2Ecom
+  is not working, alternatively an URL to SourceForge's mail arc=
hive
+  is also acceptable=2E
+* Does it contain at least one `Acked-by` li=
ne from a known OpenVPN
+  core developer? Valid sources for `Acked-by` lin=
es are mails on
+  the mailing list or +2 votes in Gerrit=2E
+* If the chan=
ge is a security fix, does it contain a `CVE:` line in
+  the format `CVE: =
<Year>-<Number>`?
+* If the change fixes a Github issue, does it contain a =
line
+  `Github: OpenVPN/openvpn#<Number>`? (Other repositories might
+  al=
so be referenced if applicable)
+* Have you considered adding a `Reported-b=
y:` line? This is usual
+  for attribution for security issues but might be=
 added for any
+  report where the reporter added significant value by thei=
r report=2E
+* If doing a cherry-pick, have you made sure to use `git cherr=
y-pick -x`
+  to add a reference to the picked commit?
+
+#### Gerrit speci=
fic
+
+Additional checks if the change was reviewed and submitted via Gerri=
t=2E
+
+* Does it contain a correct `Gerrit URL:` line? (This is generally =
ensured
+  by using `gerrit-send-email=2Epy`)
+* Is the `Change-Id:` line p=
resent and located in the last paragraph of the
+  message? (If not in the =
last paragraph, Gerrit will ignore it)
+
+### Automated tests
+
+* Has the =
change passed a full build run in buildbot? (Usually ensured via
+  Gerrit)=
=2E This ensures the following points (which otherwise might need to
+  be =
considered separately):
+  * Build passes on multiple platforms (Linux, Fre=
eBSD, Windows, macOS, other BSDs)
+  * Build passes with multiple compilers=
 (GCC, Clang, MSVC, GCC MinGW)
+  * Build passes with multiple configuratio=
ns (`--enable-small`, `--disable-management`,
+    etc=2E)
+  * Build passe=
s with multiple versions of multiple SSL libraries (OpenSSL, mbedTLS)
+  * =
Unit tests pass in all these settings
+  * t\_server\_null, t\_client pass =
in all these settings
+  * t\_server passes
+  * Verified clang-format code=
 formatting
+* If buildbot ignored the change that usually means that it di=
d not match the
+  file match list (e=2Eg=2E only changes in `=2Egithub/`)=
=2E Consider whether that seems
+  correct=2E
+* Has the change passed a GH=
A run?
+* Do any of the tests actually exercise the code? If not, has someo=
ne other than the
+  submitter done any manual verification?
+
+### Backpor=
ts
+
+* Is it clear to which branches the change should be applied?
+  * If=
 it is a security fix, it should be applied to all branches that are
+    a=
ffected and that are not "unsupported"
+    (cf=2E https://community=2Eopen=
vpn=2Enet/Pages/Supported%20versions)
+  * If it is a bugfix, it should be =
applied to all branches that are in
+    "Full stable support"=2E Depending=
 on the severity it might also be
+    applied to branches in "Old stable s=
upport"=2E
+* Have you checked for all branches whether a trivial cherry-pi=
ck is
+  possible or whether a backport is required? If a backport is requi=
red
+  have you communicated this to the submitter?
diff --git a/Makefile=
=2Eam b/Makefile=2Eam
index 2df7eea=2E=2Efeeaabb 100644
--- a/Makefile=2Eam=

+++ b/Makefile=2Eam
@@ -67,6 +67,7 @@
 	=2Egitignore \
 	=2Egitattributes =
\
 	CONTRIBUTING=2Erst \
+	CODE_CHECKLIST=2Emd \
 	PORTS \
 	README=2Ecmake=
=2Emd \
 	README=2Edco=2Emd \

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit-Change-Number: 1=
776
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>

--GDiev1nHD4s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1776?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Start a new document CODE_CHECKLIST<br><br=
>This is intended to document in one place all the policies<br>applicable t=
o submitted changes=2E This serves multiple<br>purposes:<br><br>* Make it c=
learer to submitters what is required of them<br>* Make it clearer what to =
consider automating when developing<br>  (be it by writing scripts or by in=
structing an AI agent)<br>* Reduce the bus factor of the project by reducin=
g the amount<br>  of things only stored in Gert&#39;s head<br><br>Change-Id=
: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1776<br>Message-Id: &lt;20260817161831=2E8322-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38465=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>A CODE_CHECKLIST=2Emd<br>M Makefile=2Eam<br>2 fil=
es changed, 116 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2Ecacb7c9</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/CODE_CHECKLIST=2Emd</span><br><span>@@ -0,0 +1,115=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Checklist for =
Contributions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+## Introduction</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+This documents all policies applied to any chang=
e that should be applied</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+in this repository=2E It is separated in two parts=2E The first part d=
escribes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the checkli=
st that any submitter should apply=2E The second part describes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+the checklist that integrators =
need to apply before actually merging the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+change=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In gene=
ral the Integrator Checklist does imply that all checks from the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+Submitter Checklist have been =
passed=2E They are not repeated=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## S=
ubmitter Checklist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Commit message</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+* Does the commit message accurately des=
cribe the change?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* =
Does it end with the line `Signed-off-by: My Name &lt;my@email=2Ecom&gt;` ?=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+### Automated tests</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+* Did the change pass a local `make` build?</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+* Did the change pass a local run=
 of `make check`?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* =
Have you verified the code formatting with clang-format?</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+* Is the code covered by Unit Tests? I=
f not, have you considered adding</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  a new Unit Test?</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Ch=
ange-specific checks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does your change=
 require adaptions on both server and client side</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  because it changes the wire-protocol?</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Did you propose a cha=
nge to http://github=2Ecom/openvpn-rfc/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    to agree on the protocol format changes?</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+* Does your change add, remove=
, or change a config option?</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  * Have you adapted the usage text (`openvpn --help`)?</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  * Have you adapted the man p=
age text (`man -l =2E/doc/openvpn=2E8`)?</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+* Have you reviewed all code comments around code you =
touched to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  check w=
hether they need to be adapted?</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+* If your change adds new files, are they added in some Makefil=
e=2Eam</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  statement t=
hat will make sure they up in the distributed source</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  tarballs?</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+## Integrator Checklist</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Gene=
ral</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+* Is the exact code change to be me=
rged available as an email on openvpn-devel</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  mailing list (note: this does not apply to the co=
mmit message since that needs</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  to be massaged anyway)?</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+* If not, is the change to merge a trivial cherry-pick?</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+### Commit message</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* Does it contain the pointer to the email on openvpn-devel?=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This means a line=
 `Message-Id: &lt;actual msg id&gt;` and a line</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  `URL: &lt;url to mail-archive=2Ecom copy of t=
he mail&gt;`=2E If mail-archive=2Ecom</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  is not working, alternatively an URL to SourceForge&#39=
;s mail archive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is=
 also acceptable=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* Does it contain at least one `Acked-by` line from a known OpenVPN</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  core developer? Valid sou=
rces for `Acked-by` lines are mails on</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  the mailing list or +2 votes in Gerrit=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+* If the change is a security fi=
x, does it contain a `CVE:` line in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  the format `CVE: &lt;Year&gt;-&lt;Number&gt;`?</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+* If the change fixes a Github=
 issue, does it contain a line</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  `Github: OpenVPN/openvpn#&lt;Number&gt;`? (Other repositories =
might</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  also be refe=
renced if applicable)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* Have you considered adding a `Reported-by:` line? This is usual</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  for attribution for secur=
ity issues but might be added for any</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  report where the reporter added significant value by th=
eir report=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* If d=
oing a cherry-pick, have you made sure to use `git cherry-pick -x`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  to add a reference to the =
picked commit?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#### Gerrit specific</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Additional checks if the change was revie=
wed and submitted via Gerrit=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does =
it contain a correct `Gerrit URL:` line? (This is generally ensured</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  by using `gerrit-send-ema=
il=2Epy`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Is the `=
Change-Id:` line present and located in the last paragraph of the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  message? (If not in the las=
t paragraph, Gerrit will ignore it)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+###=
 Automated tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+* Has the change passe=
d a full build run in buildbot? (Usually ensured via</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Gerrit)=2E This ensures the following p=
oints (which otherwise might need to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  be considered separately):</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  * Build passes on multiple platforms (Linux, Fr=
eeBSD, Windows, macOS, other BSDs)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  * Build passes with multiple compilers (GCC, Clang, MSVC, =
GCC MinGW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Build=
 passes with multiple configurations (`--enable-small`, `--disable-manageme=
nt`,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    etc=2E)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Build passes with m=
ultiple versions of multiple SSL libraries (OpenSSL, mbedTLS)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  * Unit tests pass in all these =
settings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * t\_serv=
er\_null, t\_client pass in all these settings</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  * t\_server passes</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  * Verified clang-format code formatting</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+* If buildbot ignored the=
 change that usually means that it did not match the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  file match list (e=2Eg=2E only changes =
in `=2Egithub/`)=2E Consider whether that seems</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  correct=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+* Has the change passed a GHA run?</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* Do any of the tests actually exercise=
 the code? If not, has someone other than the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  submitter done any manual verification?</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+### Backports</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+* Is it clear to which branches the change should be applied?</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  * If it is a security fix, =
it should be applied to all branches that are</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    affected and that are not &quot;unsupported&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (cf=2E http=
s://community=2Eopenvpn=2Enet/Pages/Supported%20versions)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  * If it is a bugfix, it should be a=
pplied to all branches that are in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;Full stable support&quot;=2E Depending on the seve=
rity it might also be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    applied to branches in &quot;Old stable support&quot;=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+* Have you checked for all branc=
hes whether a trivial cherry-pick is</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  possible or whether a backport is required? If a backpor=
t is required</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  have=
 you communicated this to the submitter?</span><br><span>diff --git a/Makef=
ile=2Eam b/Makefile=2Eam</span><br><span>index 2df7eea=2E=2Efeeaabb 100644<=
/span><br><span>--- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</sp=
an><br><span>@@ -67,6 +67,7 @@</span><br><span> 	=2Egitignore \</span><br><=
span> 	=2Egitattributes \</span><br><span> 	CONTRIBUTING=2Erst \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	CODE_CHECKLIST=2Emd \</span><=
br><span> 	PORTS \</span><br><span> 	README=2Ecmake=2Emd \</span><br><span>=
 	README=2Edco=2Emd \</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">change=
 1776</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
b123b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--GDiev1nHD4s=--


--===============6381938409277159945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6381938409277159945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6381938409277159945==--

