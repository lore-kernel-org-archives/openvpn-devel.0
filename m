Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91109C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9rThb/bwgv/NWYJIeTJIllS6oZVM1LtFcYKh71VBGz0=; b=ggNdgowT3X2Ozxr7I6GSNlOMo8
	o4eSEZPiWtHMdQCZ4XMbvb1CQiONn6bqEQ+eoUu5JG2LaUtAP1LdtNft2aUav1ZA2CHYLzWjBthjf
	4S+G5GngkNTI4W/sxzs+pVRM+/41iKURtg9yzc/ejJ1u8KOz8u7CQmbYBwpohEtxVZQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvyGW-0004j3-Em;
	Mon, 17 Aug 2026 14:24:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvyGU-0004iw-6k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hOJX+72oa5BgK/luwuvjrEVn1193wxAhJ0Tzh+q3gVk=; b=Xw18XNVS8FWRlrImtHts5dgjF+
 fu37AGXxEwEu7ud126mTDUIQxcMubgV3XpdsHZjYp0fESS+8L2cm6ob6GoQ6hlsu58SZElsXPbCDc
 huOGc6I3i7wISrQY122yeArL8/ZyHZfsKuwwCn3hAthUpVpvC2ilOWhfHQCPza8JYQec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hOJX+72oa5BgK/luwuvjrEVn1193wxAhJ0Tzh+q3gVk=; b=b
 gKicOoZWW2JcuveOgrM80uyzINghmsNEaHhCmyngt7/by0kCe5p8CC4xNWdFNWHxoJQH4kryQhhtD
 pescUcFq0+AO5JsTCN6Hrt7kio/RGF9VD85MPjVkzEUTEulXUdUVbZ+7tpq+WITE12G00QdnKGlS+
 7BkAC9+Plqi2mahM=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvyGV-00007S-GA for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:24:38 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1381695f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786976669; x=1787581469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hOJX+72oa5BgK/luwuvjrEVn1193wxAhJ0Tzh+q3gVk=;
 b=LNHToGZi9TPqzX6J9RWO02Yen2dJ3rBcpURMUdrOSaIQReDem83MDi6AcTI8I391Zi
 wmQu/M7wxV57yhSHqQhfb50qcX86ou9kGsAABBdmmWQR2R4GBDeHZcWgH5wbIIpzxS1o
 Lh84ucuagYdrKKjPMi5se7RJ3CtHHGYaIKRreBQubkwLbmWYllCze7ZSELU1nbmCjzdr
 ATROQ92FsCifgiqYCGCXNScDaZ+Inkw1ZuxL05YggKDTx4zm7Iead67Nc1rEQO9TL5cn
 Lf4oLgzAsLAjTjS9gsEG28QIrZbvvPJ2R1H2hgsNlzhsh7u0TqegUPCIjg7oE9Tu54/h
 QoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976669; x=1787581469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hOJX+72oa5BgK/luwuvjrEVn1193wxAhJ0Tzh+q3gVk=;
 b=dQ1PCWdrieSidBFQWsFYIe0B8h2B0Iwj/lk389iOsIf+xd2yi7eKskP/giUF9kHmOb
 NtBBSqrnlkjuN9JWHCIAXU4Db1C2kiEWhj3yMM92HEVy6kJS7w0DaJxmxOyP2Ah5UR6E
 W2zAvvjn0+VIEpydzgnYepIOLk3zaCcwCmARpKFlXeTWQT6IuQ1HTXDb/gNGhk3rckLa
 YR6spXr3cXirsyPKpISXJvp9kOcv9+uMgDJYzysXJR1JO2Kt0YQrh1wgIphKyWTCEdoS
 hfkahBxhPKkHQ6j/bzwXfD9kzGCN1M1zMcRcyrym6CgWM9GcND5tXenD7E/iLS6f1LYj
 +nKw==
X-Gm-Message-State: AOJu0YywzC+zEzK/EVxONWzDymEYHE+0W1XyUY66KJddreqcHy4OPcoe
 PT/cYfRWLaWF1ElB9V5Yd3hWATyVHQ761ic2AHiqpTvZZA7j1AXyf1moO1FrypknxK534h6QNYG
 PT6rRBWFIQUK0lR9+c/ZMkBrw5zTlUfcDgPC9ltbRmmLLROfXNHTrHihjrOVg616sgks0
X-Gm-Gg: AR+sD129P2oNxQNe0Ku2JsFNp5r8/GmHNQxRBXjEx+0W0VrVAqkUCHrPAk0M8xYQaFx
 Rbv86t/0l7MxFMO+wdD1w88Hi+L8gkCKtCsVaZrXeWP3xJHfORgEgNYUFKIcbZHjvRLGvg8mnV9
 wh6Ot1Un5leZisP2zZ/GH5io9zl0amPbr7hxNjvXyb6FXhpAvx1Sv/47M3Qx05XujUpDnm0X3Z6
 10OfKES1snKxSVgryOxnyzs1kq4a2xDjarmSjayHE99pIPeKsZuR4vKHdSB3yw6F/W4ETcYSb8/
 74WHxxynDpb11i+lUhhZVaHX4Ive0CrSbO/6iePlr6fLCtuGgwwReLiTqPwndRZJYFcQI10SoZd
 N3lUcCgfqH4Wx16yLZCvBFZeXrYr1rT/BsiV3KcgaUnScAeA0D8vBeF7c39uFzRs1lUp0RKGr3H
 elJAEWvKW342NgSBsFV4pkozC4DH226df/his8DHt4TDY6LuEnyDYgJKVa2yWyT68/L/hKNU6v2
 t1HFoke9PzvNVFwNFgxD7Kb+mP6f1+Fj2igLxUWOpwqvat8R+8hd+xQE9W8DFZZqMcf97cRBabo
 H2PRbnzTjWIHX8f1bWRPp6zJfXjL+Jb9ej6NwYFR9iaifRbklm7nC8k79Yps2g==
X-Received: by 2002:a05:6000:2483:b0:47f:9ac6:ca60 with SMTP id
 ffacd0b85a97d-482a8fd684bmr1043032f8f.0.1786976669132; 
 Mon, 17 Aug 2026 07:24:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81748sm4783680f8f.37.2026.08.17.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:24:28 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:24:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: eb5de4531a82503632d5090558a5844c2fa41ac5
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <04177d08ca009835ab4cd3aaec2acb120b6bf075-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvyGV-00007S-GA
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3522178756263627488=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3522178756263627488==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a6UBoK/x6Q4="; charset=UTF-8

--a6UBoK/x6Q4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail

to loo=
k at the new patch set (#3)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc

The change is no longer submittable: =
Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change sub=
ject: Start a new document CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Start a new document CODE_CHECKLIST

This is i=
ntended to document in one place all the policies
applicable to submitted c=
hanges=2E This serves multiple
purposes:

* Make it clearer to submitters w=
hat is required of them
* Make it clearer what to consider automating when =
developing
  (be it by writing scripts or by instructing an AI agent)
* Red=
uce the bus factor of the project by reducing the amount
  of things only s=
tored in Gert's head

Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
A CODE_CHECK=
LIST=2Emd
M Makefile=2Eam
2 files changed, 116 insertions(+), 0 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1=
776/3

diff --git a/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd
new file mode=
 100644
index 0000000=2E=2Ecacb7c9
--- /dev/null
+++ b/CODE_CHECKLIST=2Emd
=
@@ -0,0 +1,115 @@
+# Checklist for Contributions
+
+## Introduction
+
+This=
 documents all policies applied to any change that should be applied
+in th=
is repository=2E It is separated in two parts=2E The first part describes
+=
the checklist that any submitter should apply=2E The second part describes
=
+the checklist that integrators need to apply before actually merging the
+=
change=2E
+
+In general the Integrator Checklist does imply that all checks=
 from the
+Submitter Checklist have been passed=2E They are not repeated=2E=

+
+## Submitter Checklist
+
+### Commit message
+
+* Does the commit messa=
ge accurately describe the change?
+* Does it end with the line `Signed-off=
-by: My Name <my@email=2Ecom>` ?
+
+### Automated tests
+
+* Did the change=
 pass a local `make` build?
+* Did the change pass a local run of `make che=
ck`?
+* Have you verified the code formatting with clang-format?
+* Is the =
code covered by Unit Tests? If not, have you considered adding
+  a new Uni=
t Test?
+
+### Change-specific checks
+
+* Does your change require adaptio=
ns on both server and client side
+  because it changes the wire-protocol?
=
+  * Did you propose a change to http://github=2Ecom/openvpn-rfc/
+    to a=
gree on the protocol format changes?
+* Does your change add, remove, or ch=
ange a config option?
+  * Have you adapted the usage text (`openvpn --help=
`)?
+  * Have you adapted the man page text (`man -l =2E/doc/openvpn=2E8`)?=

+* Have you reviewed all code comments around code you touched to
+  check=
 whether they need to be adapted?
+* If your change adds new files, are the=
y added in some Makefile=2Eam
+  statement that will make sure they up in t=
he distributed source
+  tarballs?
+
+## Integrator Checklist
+
+### Genera=
l
+
+* Is the exact code change to be merged available as an email on openv=
pn-devel
+  mailing list (note: this does not apply to the commit message s=
ince that needs
+  to be massaged anyway)?
+* If not, is the change to merg=
e a trivial cherry-pick?
+
+### Commit message
+
+* Does it contain the poi=
nter to the email on openvpn-devel?
+  This means a line `Message-Id: <actu=
al msg id>` and a line
+  `URL: <url to mail-archive=2Ecom copy of the mail=
>`=2E If mail-archive=2Ecom
+  is not working, alternatively an URL to Sour=
ceForge's mail archive
+  is also acceptable=2E
+* Does it contain at least=
 one `Acked-by` line from a known OpenVPN
+  core developer? Valid sources =
for `Acked-by` lines are mails on
+  the mailing list or +2 votes in Gerrit=
=2E
+* If the change is a security fix, does it contain a `CVE:` line in
+ =
 the format `CVE: <Year>-<Number>`?
+* If the change fixes a Github issue, =
does it contain a line
+  `Github: OpenVPN/openvpn#<Number>`? (Other reposi=
tories might
+  also be referenced if applicable)
+* Have you considered ad=
ding a `Reported-by:` line? This is usual
+  for attribution for security i=
ssues but might be added for any
+  report where the reporter added signifi=
cant value by their report=2E
+* If doing a cherry-pick, have you made sure=
 to use `git cherry-pick -x`
+  to add a reference to the picked commit?
+
=
+#### Gerrit specific
+
+Additional checks if the change was reviewed and s=
ubmitted via Gerrit=2E
+
+* Does it contain a correct `Gerrit URL:` line? (=
This is generally ensured
+  by using `gerrit-send-email=2Epy`)
+* Is the `=
Change-Id:` line present and located in the last paragraph of the
+  messag=
e? (If not in the last paragraph, Gerrit will ignore it)
+
+### Automated t=
ests
+
+* Has the change passed a full build run in buildbot? (Usually ensu=
red via
+  Gerrit)=2E This ensures the following points (which otherwise mi=
ght need to
+  be considered separately):
+  * Build passes on multiple pla=
tforms (Linux, FreeBSD, Windows, macOS, other BSDs)
+  * Build passes with =
multiple compilers (GCC, Clang, MSVC, GCC MinGW)
+  * Build passes with mul=
tiple configurations (`--enable-small`, `--disable-management`,
+    etc=2E=
)
+  * Build passes with multiple versions of multiple SSL libraries (OpenS=
SL, mbedTLS)
+  * Unit tests pass in all these settings
+  * t\_server\_nul=
l, t\_client pass in all these settings
+  * t\_server passes
+  * Verified=
 clang-format code formatting
+* If buildbot ignored the change that usuall=
y means that it did not match the
+  file match list (e=2Eg=2E only changes=
 in `=2Egithub/`)=2E Consider whether that seems
+  correct=2E
+* Has the c=
hange passed a GHA run?
+* Do any of the tests actually exercise the code? =
If not, has someone other than the
+  submitter done any manual verificatio=
n?
+
+### Backports
+
+* Is it clear to which branches the change should be=
 applied?
+  * If it is a security fix, it should be applied to all branche=
s that are
+    affected and that are not "unsupported"
+    (cf=2E https:/=
/community=2Eopenvpn=2Enet/Pages/Supported%20versions)
+  * If it is a bugf=
ix, it should be applied to all branches that are in
+    "Full stable supp=
ort"=2E Depending on the severity it might also be
+    applied to branches=
 in "Old stable support"=2E
+* Have you checked for all branches whether a =
trivial cherry-pick is
+  possible or whether a backport is required? If a =
backport is required
+  have you communicated this to the submitter?
diff -=
-git a/Makefile=2Eam b/Makefile=2Eam
index 2df7eea=2E=2Efeeaabb 100644
--- =
a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -67,6 +67,7 @@
 	=2Egitignore \
 	=
=2Egitattributes \
 	CONTRIBUTING=2Erst \
+	CODE_CHECKLIST=2Emd \
 	PORTS \=

 	README=2Ecmake=2Emd \
 	README=2Edco=2Emd \

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Ge=
rrit-Change-Number: 1776
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mand=
elbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razva=
nc <razvanc@mailbox=2Eorg>

--a6UBoK/x6Q4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><p>The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">Start a new=
 document CODE_CHECKLIST<br><br>This is intended to document in one place a=
ll the policies<br>applicable to submitted changes=2E This serves multiple<=
br>purposes:<br><br>* Make it clearer to submitters what is required of the=
m<br>* Make it clearer what to consider automating when developing<br>  (be=
 it by writing scripts or by instructing an AI agent)<br>* Reduce the bus f=
actor of the project by reducing the amount<br>  of things only stored in G=
ert&#39;s head<br><br>Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>A CODE_CHECKLIST=2Emd<br>M Makefile=2Eam<br>2 files changed, 116 inserti=
ons(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/76/1776/3</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CODE=
_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Ecacb7c9</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/CODE_CHECKLIST=2Emd</span><br><span>@@ -0,0 +1,115 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Checklist for Contr=
ibutions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+## Introduction</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+This documents all policies applied to any change tha=
t should be applied</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
in this repository=2E It is separated in two parts=2E The first part descri=
bes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the checklist th=
at any submitter should apply=2E The second part describes</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+the checklist that integrators need =
to apply before actually merging the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+change=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In general t=
he Integrator Checklist does imply that all checks from the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Submitter Checklist have been passe=
d=2E They are not repeated=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Submit=
ter Checklist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+### Commit message</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+* Does the commit message accurately describe=
 the change?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does =
it end with the line `Signed-off-by: My Name &lt;my@email=2Ecom&gt;` ?</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+### Automated tests</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* Did the change pass a local `make` build?</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+* Did the change pass a local run of=
 `make check`?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Hav=
e you verified the code formatting with clang-format?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* Is the code covered by Unit Tests? If n=
ot, have you considered adding</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  a new Unit Test?</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Chang=
e-specific checks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does your change re=
quire adaptions on both server and client side</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  because it changes the wire-protocol?</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  * Did you propose a change=
 to http://github=2Ecom/openvpn-rfc/</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    to agree on the protocol format changes?</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+* Does your change add, remove, o=
r change a config option?</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  * Have you adapted the usage text (`openvpn --help`)?</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  * Have you adapted the man page=
 text (`man -l =2E/doc/openvpn=2E8`)?</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+* Have you reviewed all code comments around code you tou=
ched to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  check whet=
her they need to be adapted?</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+* If your change adds new files, are they added in some Makefile=
=2Eam</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  statement th=
at will make sure they up in the distributed source</span><br><span style=
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
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--a6UBoK/x6Q4=--


--===============3522178756263627488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3522178756263627488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3522178756263627488==--

