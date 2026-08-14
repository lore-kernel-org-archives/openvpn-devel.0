Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E72BC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=arQNOUuTX8sjh5wBid9bvZuJalLiv7YSxqWzmCsdL2Q=; b=hM/sbBgPoRp+20zxG+e31/6Sjn
	KNxnQMXK4K//6bEQwju63W6aqMkYu2i3d8Q8z5INIEmTcc3rH5y6nXQFG4Gh2FpredadgdQWrF4cE
	rPe/3mygknWgYLdKYsUgTQAvWwaLd58oGZuebNKe3pPY/pVzjcop9PuTQLO7XJUnC928=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupfr-000441-8i;
	Fri, 14 Aug 2026 11:02:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupfq-00043v-Lh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:02:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e4F0nEDBR1NYuLnyHAufEf2883cmw8QHDHZC9hcHRT8=; b=XBB6w9x6mp5UQsMV2AgkJwnyfX
 5834Z7r2SPKI7UQg/aPKZqhjQJXFPkck+FlHqVd4xi/nRt1gZkjJNeP9KVQtB6Wfo8nsmrp5S7U6k
 4+w7/ULjdX04S+qG9ENUk348jLrlRzSvYxuxsQU5G+gz5v4TZy2KIR7py0CBM8mT/OEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e4F0nEDBR1NYuLnyHAufEf2883cmw8QHDHZC9hcHRT8=; b=S
 jP2zHWVlAYtE8eyrYvnMnyIagg107dgeVwfrghsQ4xqdHem8QisCKq1cP23vLKV3jw6JRWBR6WHWR
 0/tmIh+A4MCzZoN5zpEOIHJRpXQ18fPiky9L79TdOIcLDo2OUj6q8qGH17ylNXBbFv+j3Z9uEs07U
 tH4oV7zuWmy1hyBc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupfq-0003yO-Pb for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:02:07 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so8391935e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786705317; x=1787310117; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e4F0nEDBR1NYuLnyHAufEf2883cmw8QHDHZC9hcHRT8=;
 b=L4vPZfaTXp2LHOH7oXeCkrNHVaK2txEm+njdSWip+GVVYyah69pfhCUoohTce7gb7S
 PM4vtcISyV7T0AI0yAxNI7KTbiS4tr+uRk2kVCnSCtJRFVcEFmrXWAVU2I+ZroAnsEWu
 KpwTg3h6gjy0TwNlLC3xvhDCjPxRUTZPBXFaiNM1vVCbHu4egWOKqYAm13IKT1oc/kv5
 Aqm0hpemxVtkbOHiQmnmLH0pCO5upaRhS+X43chTtuRQx3BVxQii6TAsfZnXJ5oEApMI
 O4Ck/xw3vRxWbe27BxkxFy16BqY/E8MYRGSbxAJJ1FGeFoX9mGJbeBxHD28N1B1Z0MAg
 tcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786705317; x=1787310117;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e4F0nEDBR1NYuLnyHAufEf2883cmw8QHDHZC9hcHRT8=;
 b=CfZg3WW5akrjgksdgh5GDeuNkH2KBa/ywmx4FkN46sRCxXSsV5h0NVOz+gZOD4YgEe
 cnP0np1JmxjyxQ4seaHJtVGd8CKfK14VRWw1ffy+kIFh6B8RRnU0JirGoUvqeHcyWMa6
 ckH9o7Gh7oWjkb2lhNg+R4uS0Tmgq19/fyPPN1Q9n0sU4QAhaz1+5AacWR63TZRB1ja6
 Jlz6xFlws2VgFyeO6uRz6cQoSnYkL6KzzJxGKOr2jkf3BtFY79Kk1/dmZJyZ417iF4uf
 YlhGGc5il5IOw+W2ozaEwgXrbLKjruMNSgmRXM26XRG44F00ATrH708kk2zl6QO1eqCK
 izYQ==
X-Gm-Message-State: AOJu0Yyd72UWjYv9jswYYDYcAkDJFZlVqKrjBX80fgGE6o3f8FPEydRx
 6THl7vwmjmuh9LLWRrxwQfKLFjaeaFN8QSy/Jf1Ok7H8ULqiT1XutzZFuyDhi1DKV87qAKmIeFG
 DY0UC9H9fTpJsl35gZUYx7rHBG9jAoSXoaRVNFauroxIDRalZKNREfhYGcchEnAUNMlO8qVL9yy
 wdp+lz7w==
X-Gm-Gg: AR+sD13SHjRlmZd4nCkM1qs3RncO6Bl4y4j38dEQ5qE80Y0h1GMWqhqWNkCTLna9w1l
 iNisu/dDJBk0pp2pbfPb2jqsphkpawqTiCAIDHGOYwm+v3NIh2zNxrxz+qVfBKxGYNWlTdFpG4w
 XDx/enQJ8ahLjgurvVVoiTJH8n9jnn8mE5ijgehOnflejocpwBV9GnVyupsrYCdbco/VSdS6Dec
 B2ocKd/zeRi6ByPlnIc+8hBqwY3PGq5UiekHkIdGWlvJ3xMwEjtkrCwyBjM0q8aKWL+qspSG71H
 V59AdFP196As/c5ifj1fzxepABrUnIuUNbaFsp62orPy+21Niobr0lCWOevczrxqSHdJhzu/1fd
 2UW76urzAGtx/38lwlM4KmwWajfjxX7aINAYBFEOF4KE/e432+n05o8a8+BT7sAxclKHRN4Yrij
 9zsJyS7SIlAxL9pLFbA8FHqAhrJ1cy3EsLQmkJiEKfYuTRsIsUvxLfS3Lj0ednmQxSrQwpsBGQe
 oMma1Kc5XJH2GUNP0c3c3d3UcPUWJkK97P1dQq8spy7fV8SThV8kqNQaTsyYquMgfQKrd+7r0rh
 F84g95mcsufldYi+u9YK/oG30mshLeGpUgddvU6e2O0psqpFxbY=
X-Received: by 2002:a05:600c:8714:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-49987938551mr73658565e9.3.1786705316493; 
 Fri, 14 Aug 2026 04:01:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5ad0sm20588285e9.4.2026.08.14.04.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:01:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:01:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: 7f3f56c1e3ec3751f9f88957701d5eb0c192f93e
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7cd1b9e029076519b2dab864a774a80ca352f4b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupfq-0003yO-Pb
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1381590028361206587=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1381590028361206587==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uIgTsxOfA6Y="; charset=UTF-8

--uIgTsxOfA6Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail

to loo=
k at the new patch set (#2)=2E

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
776/2

diff --git a/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd
new file mode=
 100644
index 0000000=2E=2Edcccf6d
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
the parts of the checklist that any submitter should check=2E The seconds p=
art
+describes the parts that integrators need to check before actually mer=
ging the
+change=2E
+
+In general the Integrator Checklist does imply that =
all checks from the
+Submitter Checklist have been passed=2E They are not r=
epeated=2E
+
+## Submitter Checklist
+
+### Commit message
+
+* Does the co=
mmit message acurately describe the change?
+* Does it end with the line `S=
igned-off-by: My Name <my@email=2Ecom>` ?
+
+### Automated tests
+
+* Did t=
he change pass a local `make` build?
+* Did the change pass a local run of =
`make check`?
+* Have you verified the code formatting with clang-format?
+=
* Is the code covered by Unit Tests? If not, have you considered adding
+  =
a new Unit Test?
+
+### Change-specific checks
+
+* Does your change requir=
e adaptions on both server and client side
+  because it changes the wire-p=
rotocol?
+  * Did you propose a change to http://github=2Ecom/openvpn-rfc/
=
+    to agree on the protocol format changes?
+* Does your change add, remo=
ve, or change a config option?
+  * Have you adapted the usage text (`openv=
pn --help`)?
+  * Have you adapted the man page text (`man -l =2E/doc/openv=
pn=2E8`)?
+* Have you reviewed all code comments around code you touched to=

+  check whether they need to be adapted?
+* If your change adds new files=
, are they added in some Makefile=2Eam
+  statement that will make sure the=
y up in the distributed source
+  tarballs?
+
+## Integrator Checklist
+
+#=
## General
+
+* Is the exact code change to be merged available as an email=
 on openvpn-devel
+  mailing list (note: this does not apply to the commit =
message since that needs
+  to be massaged anyway)?
+* If not, is the chang=
e to merge a trivial cherry-pick?
+
+### Commit message
+
+* Does it contai=
n the pointer to the email on openvpn-devel?
+  This means a line `Message-=
Id: <actual msg id>` and a line
+  `URL: <url to mail-archive=2Ecom copy of=
 the mail>`=2E If mail-archive=2Ecom
+  is not working, alternatively an UR=
L to SourceForge's mail archive
+  is also acceptable=2E
+* Does it contain=
 at least one `Acked-by` line from a known OpenVPN
+  core developer? Valid=
 sources for `Acked-by` lines are mails on
+  the mailing list or +2 votes =
in Gerrit=2E
+* If the change is a security fix, does it contain a `CVE:` l=
ine in
+  the format `CVE: <Year>-<Number>`?
+* If the change fixes a Githu=
b issue, does it contain a line
+  `Github: OpenVPN/openvpn#<Number>`? (Oth=
er repositories might
+  also be referenced if applicable)
+* Have you cons=
idered adding a `Reported-by:` line? This is usual
+  for attribution for s=
ecurity issues but might be added for any
+  report where the reporter adde=
d significant value by his report=2E
+* If doing a cherry-pick, have you ma=
de sure to use `git cherry-pick -x`
+  to add a reference to the picked com=
mit?
+
+#### Gerrit specific
+
+Additional checks if the change was reviewe=
d and submitted via Gerrit=2E
+
+* Does it contain a correct `Gerrit URL:` =
line? (This is generally ensured
+  by using `gerrit-send-email=2Epy`)
+* I=
s the `Change-Id:` line present and located in the last paragraph of the
+ =
 message? (If not in the last paragraph, Gerrit will ignore it)
+
+### Auto=
mated tests
+
+* Has the change passed a full build run in buildbot? (Usual=
ly ensured via
+  Gerrit)=2E This ensures the following points (which other=
wise might need to
+  be considered separately):
+  * Build passes on multi=
ple platforms (Linux, FreeBSD, Windows, macOS, other BSDs)
+  * Build passe=
s with multiple compilers (GCC, Clang, MSVC, GCC MinGW)
+  * Build passes w=
ith multiple configurations (`--enable-small`, `--disable-management`,
+   =
 etc=2E)
+  * Build passes with multiple versions of multiple SSL libraries=
 (OpenSSL, mbedTLS)
+  * Unit tests pass in all these settings
+  * t\_serv=
er\_null, t\_client pass in all these settings
+  * t\_server passes
+  * V=
erified clang-format code formatting
+* If buildbot ignored the change that=
 usually means that it did not match the
+  file match list (e=2Eg=2E only =
changes in `=2Egithub/`)=2E Consider whether that seems
+  correct=2E
+* Ha=
s the change passed a GHA run?
+* Do any of the tests actually excercise th=
e code? If not, has someone other than the
+  submitter done any manual ver=
ification?
+
+### Backports
+
+* Is it clear to which branches the change s=
hould be applied?
+  * If it is a security fix, it should be applied to all=
 branches that are
+    affected and that are not "unsupported"
+    (cf=2E=
 https://community=2Eopenvpn=2Enet/Pages/Supported%20versions)
+  * If it i=
s a bugfix, it should be applied to all branches that are in
+    "Full sta=
ble support"=2E Depending on the severity it might also be
+    applied to =
branches in "Old stable support"=2E
+* Have you checked for all branches wh=
ether a trivial cherry-pick is
+  possible or whether a backport is require=
d? If a backport is required
+  have you communicated this to the submitter=
?
diff --git a/Makefile=2Eam b/Makefile=2Eam
index 2df7eea=2E=2Efeeaabb 100=
644
--- a/Makefile=2Eam
+++ b/Makefile=2Eam
@@ -67,6 +67,7 @@
 	=2Egitignor=
e \
 	=2Egitattributes \
 	CONTRIBUTING=2Erst \
+	CODE_CHECKLIST=2Emd \
 	P=
ORTS \
 	README=2Ecmake=2Emd \
 	README=2Edco=2Emd \

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec=
68
Gerrit-Change-Number: 1776
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--uIgTsxOfA6Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
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
penvpn=2Enet:29418/openvpn refs/changes/76/1776/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CODE=
_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Edcccf6d</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/CODE_CHECKLIST=2Emd</span><br><span>@@ -0,0 +1,115 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Checklist for Contr=
ibutions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+## Introduction</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+This documents all policies applied to any change tha=
t should be applied</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
in this repository=2E It is separated in two parts=2E The first part descri=
bes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the parts of the=
 checklist that any submitter should check=2E The seconds part</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+describes the parts that integra=
tors need to check before actually merging the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+change=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In=
 general the Integrator Checklist does imply that all checks from the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Submitter Checklist have =
been passed=2E They are not repeated=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+## Submitter Checklist</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Commit mess=
age</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+* Does the commit message acurately=
 describe the change?</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* Does it end with the line `Signed-off-by: My Name &lt;my@email=2Ecom&gt=
;` ?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+### Automated tests</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* Did the change pass a local `make` build?</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+* Did the change pass a local=
 run of `make check`?</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+* Have you verified the code formatting with clang-format?</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+* Is the code covered by Unit Test=
s? If not, have you considered adding</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  a new Unit Test?</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+##=
# Change-specific checks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does your ch=
ange require adaptions on both server and client side</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  because it changes the wire-protocol?</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Did you propose a=
 change to http://github=2Ecom/openvpn-rfc/</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    to agree on the protocol format changes?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+* Does your change add, re=
move, or change a config option?</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  * Have you adapted the usage text (`openvpn --help`)?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  * Have you adapted the m=
an page text (`man -l =2E/doc/openvpn=2E8`)?</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+* Have you reviewed all code comments around code =
you touched to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  che=
ck whether they need to be adapted?</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+* If your change adds new files, are they added in some Mak=
efile=2Eam</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  stateme=
nt that will make sure they up in the distributed source</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  tarballs?</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+## Integrator Checklist</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### G=
eneral</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+* Is the exact code change to be=
 merged available as an email on openvpn-devel</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  mailing list (note: this does not apply to the=
 commit message since that needs</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  to be massaged anyway)?</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+* If not, is the change to merge a trivial cherry-pick?<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+### Commit message</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+* Does it contain the pointer to the email on openvpn-devel=
?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This means a lin=
e `Message-Id: &lt;actual msg id&gt;` and a line</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  `URL: &lt;url to mail-archive=2Ecom copy of =
the mail&gt;`=2E If mail-archive=2Ecom</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  is not working, alternatively an URL to SourceForge&#3=
9;s mail archive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  i=
s also acceptable=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+* Does it contain at least one `Acked-by` line from a known OpenVPN</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  core developer? Valid so=
urces for `Acked-by` lines are mails on</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  the mailing list or +2 votes in Gerrit=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+* If the change is a security f=
ix, does it contain a `CVE:` line in</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  the format `CVE: &lt;Year&gt;-&lt;Number&gt;`?</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+* If the change fixes a Githu=
b issue, does it contain a line</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  `Github: OpenVPN/openvpn#&lt;Number&gt;`? (Other repositories=
 might</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  also be ref=
erenced if applicable)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+* Have you considered adding a `Reported-by:` line? This is usual</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  for attribution for secu=
rity issues but might be added for any</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  report where the reporter added significant value by h=
is report=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* If do=
ing a cherry-pick, have you made sure to use `git cherry-pick -x`</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  to add a reference to the p=
icked commit?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#### Gerrit specific</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
le=3D"color: hsl(120, 100%, 40%);">+* Do any of the tests actually excercis=
e the code? If not, has someone other than the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  submitter done any manual verification?</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+### Backports</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* Is it clear to which branches the change should be applied?</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  * If it is a security fix,=
 it should be applied to all branches that are</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    affected and that are not &quot;unsupported&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (cf=2E htt=
ps://community=2Eopenvpn=2Enet/Pages/Supported%20versions)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  * If it is a bugfix, it should be =
applied to all branches that are in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;Full stable support&quot;=2E Depending on the sev=
erity it might also be</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    applied to branches in &quot;Old stable support&quot;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+* Have you checked for all bran=
ches whether a trivial cherry-pick is</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  possible or whether a backport is required? If a backpo=
rt is required</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  hav=
e you communicated this to the submitter?</span><br><span>diff --git a/Make=
file=2Eam b/Makefile=2Eam</span><br><span>index 2df7eea=2E=2Efeeaabb 100644=
</span><br><span>--- a/Makefile=2Eam</span><br><span>+++ b/Makefile=2Eam</s=
pan><br><span>@@ -67,6 +67,7 @@</span><br><span> 	=2Egitignore \</span><br>=
<span> 	=2Egitattributes \</span><br><span> 	CONTRIBUTING=2Erst \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	CODE_CHECKLIST=2Emd \</span>=
<br><span> 	PORTS \</span><br><span> 	README=2Ecmake=2Emd \</span><br><span=
> 	README=2Edco=2Emd \</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">chang=
e 1776</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>

</body></html>
--uIgTsxOfA6Y=--


--===============1381590028361206587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1381590028361206587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1381590028361206587==--

