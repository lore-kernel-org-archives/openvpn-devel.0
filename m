Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97871C5DF7A
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjpD0+pSAbdXKB0lze4oHIBHEm4tK8WVkms8IJqdrI4=; b=kr8rJVSG7YzKXa9JxDLVAwVuRz
	J/8nTEXe2Nx2OrbqxDvoXtfkRFnq9obmjzcTxi8VurVHzAf9tGhXg5sghvF3AFRP+x2m8Lj8ZqczV
	rmWSqWcUlFFVpdGR5MEiUlWlEBKmt0cB9xtCTKhEmUGzGwPAy/6Ezk9iip8jxGhIIQeY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww0ff-0004g9-E1;
	Mon, 17 Aug 2026 16:58:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1ww0fe-0004g3-7t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0fq4SfRYOyzttOtt+kQ+IZyn2ki/wcBl9DOhmUhgXW8=; b=LajTAQrEBWYjwadmlYwvR4tqc0
 UVqMtN6hXAZhRgIFEzBs5cmSCclvdhv8Zc/2N1Oam0VdY2JXBgkWQmtaHmi+N8ti+xm1EPU7Bnx1f
 jzmLKuQzjPGRP8AV4gd6H2RF6I36IRzKO7WgtJ1UVELuoxKSvdAR7Vpdyi99KT4yxGAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0fq4SfRYOyzttOtt+kQ+IZyn2ki/wcBl9DOhmUhgXW8=; b=N
 OZNhKkymK7bCyWhCSqulUrB5u1AiJfrhFF2j/t4xiYPsDdo7dQbc1j4xF0/j7CgqIFjk4BPs4hMDI
 qoct9CqlTG1Udv+Hbsc1w/yzh0nU8FCyQv6Y0Kh+sb8BpsiFxhidMslzCTS2O7cRLyy0SEbl93DuA
 FJ1fD2ECKtwD0364=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww0fa-0003ON-Fb for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:43 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso46660105e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786985912; x=1787590712; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0fq4SfRYOyzttOtt+kQ+IZyn2ki/wcBl9DOhmUhgXW8=;
 b=M0kZ5IfcD/HREfBiRtyWMMicMgXZ9F04ECOaa150qAUzak/SI0dhlyBfQ+eWI8eRdk
 IQzEWx+74+ZSuS9nVL67ZXfvbbtgbs5dqKgDV4Ubuo07EL8B264FIOQygEAbQd+IakNB
 iTGJH5K5qiHsmXd4Is1NT6mb0gCKzJ2WoN4w6d0eDvXBiJMLFYINx3PuSrVJs/bMgUfv
 uvixfA/QmZrmrYdnDnDDy+KIErdhXeRxNAEESkKoRzX1DTvLWUZqo/txWtamVdHpJdaY
 UiZyjJKSSIUKisQ0A5rPEmDu/b300Pzx2CjWchExeBZgKlFEfRvj+9h8RrAh66FqoBPA
 SD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985912; x=1787590712;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0fq4SfRYOyzttOtt+kQ+IZyn2ki/wcBl9DOhmUhgXW8=;
 b=GsPUqvNBJUyK1Yh0zxLliqDz0D5OYEvMZjDMo4oLi3kBFddZBgcChsMkyoa5QCJqqS
 vd3RMGjJClrqS6bnMi7CskZBLYGgn4xJdGMxoo1j+DvX5IBEe2NjFE3MQIM0RElw+IBY
 6+Myr+c50VgDUcSc6hiMJorcxaIFxbSDKR84In1HFB5Xi2vYnVLiGpcUq2hJPfP8bwZq
 wodSeP7gbVaqfw7Z3dqJWWIvV4vbwTFh/ZvOnxg5A5ukUBjfBZdah9kWKMA+Ox/TEhcp
 U2mNGZezzbJtrpyaj69HvPekhjcpNQq9Srt0Lhgd3txDxff2YTzv7T6Ux/Hig7vfLiwr
 f6fA==
X-Gm-Message-State: AOJu0Yw+6745+bjJ9RN7rdzC1Tmw9yrotfDGHFyT7jEPM1c5s5HUYfIw
 MECGZVukrg55Qwl81SwWVqa9yRJJMj2u9ekxfyfd1EpYP0H4m+v8A8i5raUQcKIxKUwMd1fqccT
 BxXQNZBq7+XJgaEMI+YYs38vvvHi+4+B8SDDNVcSvJbln5jAsC5RN6xbrBNtNzfMeSAN9
X-Gm-Gg: AR+sD114a0/sDshKBRjZufKi7XoDx1FbJxTlykHn6oyWXnskkOYJ49KzyZQp6V+6xn8
 6dAKoe82WnTExZj7t18gXUlvMVlgr3u/Gk+DSiwNgVQyclwL0yeYKxSlBxmXmA/YEqim2+3bLxy
 NMERmdcJLHUENwyNriaGxDS5oXrEfAcK5yV4jokQcvYGNhHzooBXRK3NKWkbhP7uqZqcRZGWRl2
 D8aZF+V8XKFd9YVfK78D5EK8gkZdWVCPHl6vq1gCXZ7NClOYJ1RucT097yam5+hdMeZh03WHM7l
 LP5KceV7/v7fUiZXfR/rdtEeU+YuAOuFZrXA/AwCg3LXR54TwHtVjW4w7w/IeunrsHp9Tiz1WpQ
 Dpsh5doyY3gx4+b2EUwt1bRD1j9Iyx3bj1MK4x+meP24xzyBAwEtFtmDQIcnLj6HJFm441rIX2a
 GK9TphvmfV0wCkO+9tBuzzDaoE6mBPkRENkc1p/4uIG/b9/XnENHKI7DwxcVcjmc4rzJ6yCRIi9
 ZZdmGWH86iuqAQnng/15YD++AcKAnJWuwcqP+xp0EwgGjqkDpE4tkZwEPhXUcrLFQ7q7lTZb2+V
 WJa8zygxAITS7ZY5yBRUTRp+G+fhzBeYMTsuzPjBcad/XNZDgnU=
X-Received: by 2002:a05:600c:5253:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-4999eb8b71emr51595475e9.9.1786985911043; 
 Mon, 17 Aug 2026 09:58:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm219314425e9.2.2026.08.17.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:58:30 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 16:58:28 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: cc7950b4188b6776f637a5abc29b45182df682a6
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb7c24813ae48f82c0452fdb6970c58035ae372d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1ww0fa-0003ON-Fb
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1010577777531324757=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1010577777531324757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pJedoevUzZM="; charset=UTF-8

--pJedoevUzZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: Start a new document CODE_CHECKLIST
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Start a new document C=
ODE_CHECKLIST

This is intended to document in one place all the policies
a=
pplicable to submitted changes=2E This serves multiple
purposes:

* Make it=
 clearer to submitters what is required of them
* Make it clearer what to c=
onsider automating when developing
  (be it by writing scripts or by instru=
cting an AI agent)
* Reduce the bus factor of the project by reducing the a=
mount
  of things only stored in Gert's head

Change-Id: Ib123b7bf58317a1be=
5af1a1d45decb8f31f2ec68
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776
Message-Id: <20260817161831=2E83=
22-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg38465=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
A CODE_CHECKLIST=2Emd
M Makefile=2Eam
2 fil=
es changed, 116 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/76/1776/4

diff --git a/CODE_CHECKL=
IST=2Emd b/CODE_CHECKLIST=2Emd
new file mode 100644
index 0000000=2E=2Ecacb=
7c9
--- /dev/null
+++ b/CODE_CHECKLIST=2Emd
@@ -0,0 +1,115 @@
+# Checklist =
for Contributions
+
+## Introduction
+
+This documents all policies applied=
 to any change that should be applied
+in this repository=2E It is separate=
d in two parts=2E The first part describes
+the checklist that any submitte=
r should apply=2E The second part describes
+the checklist that integrators=
 need to apply before actually merging the
+change=2E
+
+In general the Int=
egrator Checklist does imply that all checks from the
+Submitter Checklist =
have been passed=2E They are not repeated=2E
+
+## Submitter Checklist
+
+#=
## Commit message
+
+* Does the commit message accurately describe the chan=
ge?
+* Does it end with the line `Signed-off-by: My Name <my@email=2Ecom>` =
?
+
+### Automated tests
+
+* Did the change pass a local `make` build?
+* =
Did the change pass a local run of `make check`?
+* Have you verified the c=
ode formatting with clang-format?
+* Is the code covered by Unit Tests? If =
not, have you considered adding
+  a new Unit Test?
+
+### Change-specific =
checks
+
+* Does your change require adaptions on both server and client si=
de
+  because it changes the wire-protocol?
+  * Did you propose a change t=
o http://github=2Ecom/openvpn-rfc/
+    to agree on the protocol format cha=
nges?
+* Does your change add, remove, or change a config option?
+  * Have=
 you adapted the usage text (`openvpn --help`)?
+  * Have you adapted the m=
an page text (`man -l =2E/doc/openvpn=2E8`)?
+* Have you reviewed all code =
comments around code you touched to
+  check whether they need to be adapte=
d?
+* If your change adds new files, are they added in some Makefile=2Eam
+=
  statement that will make sure they up in the distributed source
+  tarbal=
ls?
+
+## Integrator Checklist
+
+### General
+
+* Is the exact code change=
 to be merged available as an email on openvpn-devel
+  mailing list (note:=
 this does not apply to the commit message since that needs
+  to be massag=
ed anyway)?
+* If not, is the change to merge a trivial cherry-pick?
+
+###=
 Commit message
+
+* Does it contain the pointer to the email on openvpn-de=
vel?
+  This means a line `Message-Id: <actual msg id>` and a line
+  `URL:=
 <url to mail-archive=2Ecom copy of the mail>`=2E If mail-archive=2Ecom
+  =
is not working, alternatively an URL to SourceForge's mail archive
+  is al=
so acceptable=2E
+* Does it contain at least one `Acked-by` line from a kno=
wn OpenVPN
+  core developer? Valid sources for `Acked-by` lines are mails =
on
+  the mailing list or +2 votes in Gerrit=2E
+* If the change is a secur=
ity fix, does it contain a `CVE:` line in
+  the format `CVE: <Year>-<Numbe=
r>`?
+* If the change fixes a Github issue, does it contain a line
+  `Gith=
ub: OpenVPN/openvpn#<Number>`? (Other repositories might
+  also be referen=
ced if applicable)
+* Have you considered adding a `Reported-by:` line? Thi=
s is usual
+  for attribution for security issues but might be added for an=
y
+  report where the reporter added significant value by their report=2E
+=
* If doing a cherry-pick, have you made sure to use `git cherry-pick -x`
+ =
 to add a reference to the picked commit?
+
+#### Gerrit specific
+
+Additi=
onal checks if the change was reviewed and submitted via Gerrit=2E
+
+* Doe=
s it contain a correct `Gerrit URL:` line? (This is generally ensured
+  by=
 using `gerrit-send-email=2Epy`)
+* Is the `Change-Id:` line present and lo=
cated in the last paragraph of the
+  message? (If not in the last paragrap=
h, Gerrit will ignore it)
+
+### Automated tests
+
+* Has the change passed=
 a full build run in buildbot? (Usually ensured via
+  Gerrit)=2E This ensu=
res the following points (which otherwise might need to
+  be considered se=
parately):
+  * Build passes on multiple platforms (Linux, FreeBSD, Windows=
, macOS, other BSDs)
+  * Build passes with multiple compilers (GCC, Clang,=
 MSVC, GCC MinGW)
+  * Build passes with multiple configurations (`--enable=
-small`, `--disable-management`,
+    etc=2E)
+  * Build passes with multip=
le versions of multiple SSL libraries (OpenSSL, mbedTLS)
+  * Unit tests pa=
ss in all these settings
+  * t\_server\_null, t\_client pass in all these =
settings
+  * t\_server passes
+  * Verified clang-format code formatting
+=
* If buildbot ignored the change that usually means that it did not match t=
he
+  file match list (e=2Eg=2E only changes in `=2Egithub/`)=2E Consider w=
hether that seems
+  correct=2E
+* Has the change passed a GHA run?
+* Do a=
ny of the tests actually exercise the code? If not, has someone other than =
the
+  submitter done any manual verification?
+
+### Backports
+
+* Is it =
clear to which branches the change should be applied?
+  * If it is a secur=
ity fix, it should be applied to all branches that are
+    affected and th=
at are not "unsupported"
+    (cf=2E https://community=2Eopenvpn=2Enet/Page=
s/Supported%20versions)
+  * If it is a bugfix, it should be applied to all=
 branches that are in
+    "Full stable support"=2E Depending on the severi=
ty it might also be
+    applied to branches in "Old stable support"=2E
+* =
Have you checked for all branches whether a trivial cherry-pick is
+  possi=
ble or whether a backport is required? If a backport is required
+  have yo=
u communicated this to the submitter?
diff --git a/Makefile=2Eam b/Makefile=
=2Eam
index 2df7eea=2E=2Efeeaabb 100644
--- a/Makefile=2Eam
+++ b/Makefile=
=2Eam
@@ -67,6 +67,7 @@
 	=2Egitignore \
 	=2Egitattributes \
 	CONTRIBUTIN=
G=2Erst \
+	CODE_CHECKLIST=2Emd \
 	PORTS \
 	README=2Ecmake=2Emd \
 	READM=
E=2Edco=2Emd \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1776?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib=
123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit-Change-Number: 1776
Gerrit-P=
atchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>

--pJedoevUzZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">Start a new document COD=
E_CHECKLIST<br><br>This is intended to document in one place all the polici=
es<br>applicable to submitted changes=2E This serves multiple<br>purposes:<=
br><br>* Make it clearer to submitters what is required of them<br>* Make i=
t clearer what to consider automating when developing<br>  (be it by writin=
g scripts or by instructing an AI agent)<br>* Reduce the bus factor of the =
project by reducing the amount<br>  of things only stored in Gert&#39;s hea=
d<br><br>Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1776<br>Message-Id: &lt;20260817161831=2E8322-1-gert@=
greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg38465=2Ehtml<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A CODE_CHECKLIST=2Emd<br>M Makef=
ile=2Eam<br>2 files changed, 116 insertions(+), 0 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/76/1776/4</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2E=
md</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E=
cacb7c9</span><br><span>--- /dev/null</span><br><span>+++ b/CODE_CHECKLIST=
=2Emd</span><br><span>@@ -0,0 +1,115 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# Checklist for Contributions</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+## Introduction</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This documen=
ts all policies applied to any change that should be applied</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+in this repository=2E It is separa=
ted in two parts=2E The first part describes</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+the checklist that any submitter should apply=2E T=
he second part describes</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+the checklist that integrators need to apply before actually merging t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+change=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+In general the Integrator Checklist does imply=
 that all checks from the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+Submitter Checklist have been passed=2E They are not repeated=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+## Submitter Checklist</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+### Commit message</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* =
Does the commit message accurately describe the change?</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* Does it end with the line `Signed-off=
-by: My Name &lt;my@email=2Ecom&gt;` ?</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
### Automated tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Did the change pa=
ss a local `make` build?</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* Did the change pass a local run of `make check`?</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* Have you verified the code formatting=
 with clang-format?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* Is the code covered by Unit Tests? If not, have you considered adding</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  a new Unit Test?</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+### Change-specific checks</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* Does your change require adaptions on both server a=
nd client side</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  bec=
ause it changes the wire-protocol?</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  * Did you propose a change to http://github=2Ecom/openvpn-=
rfc/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to agree on=
 the protocol format changes?</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+* Does your change add, remove, or change a config option?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  * Have you adapted the u=
sage text (`openvpn --help`)?</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  * Have you adapted the man page text (`man -l =2E/doc/openvpn=
=2E8`)?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Have you r=
eviewed all code comments around code you touched to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  check whether they need to be adapted?<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+* If your change add=
s new files, are they added in some Makefile=2Eam</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  statement that will make sure they up in th=
e distributed source</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  tarballs?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+## Integrator Checklist</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+### General</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+* Is the exact code change to be merged available as an email on ope=
nvpn-devel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  mailing=
 list (note: this does not apply to the commit message since that needs</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  to be massaged anyway=
)?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* If not, is the =
change to merge a trivial cherry-pick?</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
### Commit message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does it contain th=
e pointer to the email on openvpn-devel?</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  This means a line `Message-Id: &lt;actual msg id&gt;=
` and a line</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `URL:=
 &lt;url to mail-archive=2Ecom copy of the mail&gt;`=2E If mail-archive=2Ec=
om</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is not working,=
 alternatively an URL to SourceForge&#39;s mail archive</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  is also acceptable=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+* Does it contain at least one `Ack=
ed-by` line from a known OpenVPN</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  core developer? Valid sources for `Acked-by` lines are mails=
 on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the mailing li=
st or +2 votes in Gerrit=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+* If the change is a security fix, does it contain a `CVE:` line in=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the format `CVE: =
&lt;Year&gt;-&lt;Number&gt;`?</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+* If the change fixes a Github issue, does it contain a line</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  `Github: OpenVPN/openv=
pn#&lt;Number&gt;`? (Other repositories might</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  also be referenced if applicable)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+* Have you considered adding a `R=
eported-by:` line? This is usual</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  for attribution for security issues but might be added for a=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  report where th=
e reporter added significant value by their report=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* If doing a cherry-pick, have you made s=
ure to use `git cherry-pick -x`</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  to add a reference to the picked commit?</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#### Gerrit specific</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ad=
ditional checks if the change was reviewed and submitted via Gerrit=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* Does it contain a correct `Gerrit URL:`=
 line? (This is generally ensured</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  by using `gerrit-send-email=2Epy`)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* Is the `Change-Id:` line present and locat=
ed in the last paragraph of the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  message? (If not in the last paragraph, Gerrit will ignore it=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+### Automated tests</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+* Has the change passed a full build run in buildbot? (U=
sually ensured via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Gerrit)=2E This ensures the following points (which otherwise might need t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  be considered se=
parately):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Build=
 passes on multiple platforms (Linux, FreeBSD, Windows, macOS, other BSDs)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Build passes wit=
h multiple compilers (GCC, Clang, MSVC, GCC MinGW)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  * Build passes with multiple configuration=
s (`--enable-small`, `--disable-management`,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    etc=2E)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  * Build passes with multiple versions of multiple SSL li=
braries (OpenSSL, mbedTLS)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  * Unit tests pass in all these settings</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  * t\_server\_null, t\_client pass in all the=
se settings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * t\_s=
erver passes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Ver=
ified clang-format code formatting</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* If buildbot ignored the change that usually means that it =
did not match the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
file match list (e=2Eg=2E only changes in `=2Egithub/`)=2E Consider whether=
 that seems</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  correc=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Has the chang=
e passed a GHA run?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* Do any of the tests actually exercise the code? If not, has someone other=
 than the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  submitte=
r done any manual verification?</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Bac=
kports</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+* Is it clear to which branches =
the change should be applied?</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  * If it is a security fix, it should be applied to all branches=
 that are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    affect=
ed and that are not &quot;unsupported&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    (cf=2E https://community=2Eopenvpn=2Enet/Pages/=
Supported%20versions)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  * If it is a bugfix, it should be applied to all branches that are in</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Full stable=
 support&quot;=2E Depending on the severity it might also be</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    applied to branches in &quot;O=
ld stable support&quot;=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+* Have you checked for all branches whether a trivial cherry-pick is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  possible or wheth=
er a backport is required? If a backport is required</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  have you communicated this to the submi=
tter?</span><br><span>diff --git a/Makefile=2Eam b/Makefile=2Eam</span><br>=
<span>index 2df7eea=2E=2Efeeaabb 100644</span><br><span>--- a/Makefile=2Eam=
</span><br><span>+++ b/Makefile=2Eam</span><br><span>@@ -67,6 +67,7 @@</spa=
n><br><span> 	=2Egitignore \</span><br><span> 	=2Egitattributes \</span><br=
><span> 	CONTRIBUTING=2Erst \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	CODE_CHECKLIST=2Emd \</span><br><span> 	PORTS \</span><br><span>=
 	README=2Ecmake=2Emd \</span><br><span> 	README=2Edco=2Emd \</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1776?usp=3Demail">change 1776</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb=
8f31f2ec68 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1776 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2E=
com&gt; </div>

</body></html>
--pJedoevUzZM=--


--===============1010577777531324757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1010577777531324757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1010577777531324757==--

