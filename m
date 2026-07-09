Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1546DC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hHRQe8JdSJ5bjnhZTlAwgtDQ8VQ3tVP86AO3yRFYcyM=; b=GiSy2SGoLr8mNv
	vDxUMIJc+Ud0ntYzTiEcGOpYKAPkMrGwg4BBRlBRO5W3gYy4Y5STLSb9xwyLyHTg1PCJGzuU+sVvj
	AJTnExYqiCZUHnul4L1WqIdRRePakJZlu8fyjGepzrLe4JHw9u4h2dWJcZzgHgDXspbhZMH7FKmbp
	o/U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whrK8-0008TL-P9;
	Thu, 09 Jul 2026 16:10:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whrK4-0008SG-Eo
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 16:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SFO0clPCFPdNw42bxxlne7Ar5JG5EBTLosGdlFP5fDg=; b=Neq4na0uoTXB8dpAozCoTb9bcu
 qEluzYEn22W43zHLG37viYvhM7UvHhixvAXNHeCRVQx2hmRj6xnRstI4m+40+yeTQCj465ASMdV9W
 LM4BqPsh6wZ9/aWLGFv0SutSh0zpX53POb6bOqpOH4SgteMmAaB5N7jH62Lx0n4nRn/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SFO0clPCFPdNw42bxxlne7Ar5JG5EBTLosGdlFP5fDg=; b=U
 v3e5r2P9mgGjC1/ktJyPel//qd97rhB6dC+NTzJ8ewCNjeVxPVlILjt+OKueU6BrYivpzV8B+vBwu
 bcvT40EBuoH+LL3a2A/Z2Gi6QyLsCoRj1rQ1K4X0cBFHBrOgwBNRmZkOzWczxi7T0JV1ifjQPsd3R
 lxpQ7JGoxLhlTkUY=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whrK3-0002es-KY for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 16:10:01 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so47606f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783613388; x=1784218188; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SFO0clPCFPdNw42bxxlne7Ar5JG5EBTLosGdlFP5fDg=;
 b=IJ1+LPFml0u3ye5K91nXIvn4Sf8tj/CJKWDWGtYtpzhi7cCUsp6llnEAKSS3gaGNfe
 W/GQZrzax4qXRjpJ2mia/jNCAyW7vtQlpNymkyimE9HXRrKre7s9VejwFoJjU3OePQb6
 vciPWYZ/lq0TzHpKnH94m36AdVsFfIP7AEzAf4uSHwwHUQMr0z5qNrK42+GmjR44e9Ia
 BAPojZSwJAiUKODQdzwftyCt5W4buA+U2+ctA3ZzVzX2zl4W0GxyMZgiv5Qll34bHWTn
 zAwlcMZ7lxySQI8L0diKHPlDVY9npfsW60cv9vX7wVcZr+pbL/k85tVR1D4ES/FJdqaL
 Zusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613388; x=1784218188;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SFO0clPCFPdNw42bxxlne7Ar5JG5EBTLosGdlFP5fDg=;
 b=lIPxLaZs+Qnc/f+AvOEbe7mLQKPorGxXjNJNFjhYwZJ1N7OxVeYhlwreKC14BDUM7b
 gbVKQkQEzln6hte5GsjLaDtmIfqnESspmerwUCimNfjavh/zHg5gxgY1QnlRSDoAMTMx
 pWNlZOU7i5Fh9pQHg/CyhrLSd2mHGJ5hCvoamSwElbiZSYVQ1H6ZIrpczPP8NEkqNMIn
 F2I2M1RezSW/yCsLbiIs32mNOfl3gAAJQrpDSxUSjFtkjUcvarFz3t1X1Lw9fUtJp2HW
 Za1VDiBuT0/R9zYqffBiWv3Wokn9o/ZmejRZ1frbPfdAgqEmSpcPi1HxQvQCPlPxS/XL
 oNpg==
X-Gm-Message-State: AOJu0Yyd7Ymc3dp/4wKX/b4w7owzunmy/SrDO/Se9uMlO2QWP6i4WgwM
 f4ddBiWFQ6CJwH4Ux8st3L/j7KSnofJpefGDPd/hOjo9UjyOGB6PNdCWbwhpl0Ctc3vo0UgIXiO
 TVhH5UFi3rqnRb7570bIhiOCe/LDJ0NYeHL+BhvKDaaFcZMc6EN6RhWNgYWx8pLszR4vMtJr/7a
 MZfZ8oTg==
X-Gm-Gg: AfdE7cn6vH6zxlxWyEY92fpTiqWhivNdn6j3GpxNvvmzbgVjIhqF0RVM4Mq9DAX6dcI
 fk/1omlp7WiJzO4tgrNM52IdhTWJYw5hoVuWMY12mZl6LOnfCraXZ9+l5pSF/+QCWlkBWIkSrPS
 0JKriHuRZj4wZRafJPoOMEN1IFAq5mai5bEJs6bBIabcKZYJBMDOzv62OGO1/mwvaVctBmwt9t5
 DClQEjD7zmWSp9zCciVQNPkWZWQiWRLYLkz6hw9frZYaGzPsBG3YR2JHj3bGDYz6Br79zEXYqTA
 I7oyfrwpP2ztqLrTl1Z5rIhGnNbEoZgExmkF1eVWkLm0NWMY8PnI5XzIjpM0rEmDOda+wVsakxh
 E5CuxOB1/cpJsExhsYIJqTb3mYVE3DmNs9hpXjphugIZl0dYlzouUmLvbFLRUZi91+UlVHoGXSO
 zj0lNT3UnedZlWGkA9Wp5gGuSrD/Voip54KXPANnYxtm/2DlZFY4lpeYIoocWFkJk6PH4rgw8Vi
 nJoyANQ40350G6H0pVcjFoNSZ3tlyBOztIXA8Ar3ehII05aF57mnkW5Q6Csdg1aIhWh+xc82E9n
 Unw=
X-Received: by 2002:a5d:6f0d:0:b0:47d:ec60:65a0 with SMTP id
 ffacd0b85a97d-47df07ec84amr9149317f8f.29.1783613387764; 
 Thu, 09 Jul 2026 09:09:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm59300182f8f.17.2026.07.09.09.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:09:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 16:09:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: 7485341fb15a6ea437c66608f6760207f348c16e
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e79412d178cda842e1e7cabcd6c5ce697bc2805f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whrK3-0002es-KY
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2354702063457954002=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2354702063457954002==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D5Zrg+8VDqA="; charset=UTF-8

--D5Zrg+8VDqA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1776?usp=3Demail

to review the following change=2E


Chang=
e subject: Start a new document CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Start a new document CODE_CHECKLIST

Thi=
s is intended to document in one place all the policies
applicable to submi=
tted changes=2E This serves multiple
purposes:

* Make it clearer to submit=
ters what is required of them
* Make it clearer what to consider automating=
 when developing
  (be it by writing scripts or by instructing an AI agent)=

* Reduce the bus factor of the project by reducing the amount
  of things =
only stored in Gert's head

Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f=
2ec68
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
A CODE=
_CHECKLIST=2Emd
1 file changed, 112 insertions(+), 0 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1776/1

dif=
f --git a/CODE_CHECKLIST=2Emd b/CODE_CHECKLIST=2Emd
new file mode 100644
in=
dex 0000000=2E=2E3c61ee3
--- /dev/null
+++ b/CODE_CHECKLIST=2Emd
@@ -0,0 +1=
,112 @@
+# Checklist for Contributions
+
+## Introduction
+
+This documents=
 all policies applied to any change that should be applied
+in this reposit=
ory=2E It is separated in two parts=2E The first part describes
+the parts =
of the checklist that any submitter should check=2E The seconds part
+descr=
ibes the parts that integrators need to check before actually merging the
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
ge acurately describe the change?
+* Does it end with the line `Signed-off-=
by: My Name <my@email=2Ecom>` ?
+
+### Automated tests
+
+* Did the change =
pass a local `make` build?
+* Did the change pass a local run of `make chec=
k`?
+* Have you verified the code formatting with clang-format?
+* Is the c=
ode covered by Unit Tests? If not, have you considered adding
+  a new Unit=
 Test?
+
+### Change-specific checks
+
+* Does your change require adaption=
s on both server and client side
+  because it changes the wire-protocol?
+=
  * Did you propose a change to http://github=2Ecom/openvpn-rfc/
+    to ag=
ree on the protocol format changes?
+* Does your change add, remove, or cha=
nge a config option?
+  * Have you adapted the usage text (`openvpn --help`=
)?
+  * Have you adapted the man page text (`man -l =2E/doc/openvpn=2E8`)?
=
+* Have you reviewed all code comments around code you touched to
+  check =
whether they need to be adapted?
+
+## Integrator Checklist
+
+### General
=
+
+* Is the exact code change to be merged available as an email on openvpn=
-devel
+  mailing list (note: this does not apply to the commit message sin=
ce that needs
+  to be massaged anyway)?
+* If not, is the change to merge =
a trivial cherry-pick?
+
+### Commit message
+
+* Does it contain the point=
er to the email on openvpn-devel?
+  This means a line `Message-Id: <actual=
 msg id>` and a line
+  `URL: <url to mail-archive=2Ecom copy of the mail>`=
=2E If mail-archive=2Ecom
+  is not working, alternatively an URL to Source=
Forge's mail archive
+  is also acceptable=2E
+* Does it contain at least o=
ne `Acked-by` line from a known OpenVPN
+  core developer? Valid sources fo=
r `Acked-by` lines are mails on
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
cant value by his report=2E
+* If doing a cherry-pick, have you made sure t=
o use `git cherry-pick -x`
+  to add a reference to the picked commit?
+
+#=
### Gerrit specific
+
+Additional checks if the change was reviewed and sub=
mitted via Gerrit=2E
+
+* Does it contain a correct `Gerrit URL:` line? (Th=
is is generally ensured
+  by using `gerrit-send-email=2Epy`)
+* Is the `Ch=
ange-Id:` line present and located in the last paragraph of the
+  message?=
 (If not in the last paragraph, Gerrit will ignore it)
+
+### Automated tes=
ts
+
+* Has the change passed a full build run in buildbot? (Usually ensure=
d via
+  Gerrit)=2E This ensures the following points (which otherwise migh=
t need to
+  be considered separately):
+  * Build passes on multiple platf=
orms (Linux, FreeBSD, Windows, macOS, other BSDs)
+  * Build passes with mu=
ltiple compilers (GCC, Clang, MSVC, GCC MinGW)
+  * Build passes with multi=
ple configurations (--enable-small, --disable-management,
+    etc=2E)
+  *=
 Build passes with multiple versions of multiple SSL libraries (OpenSSL, mb=
edTLS)
+  * Unit tests pass in all these settings
+  * t\_server\_null, t_c=
lient pass in all these settings
+  * t_server passes
+  * Verified clang-f=
ormat code formatting
+* If buildbot ignored the change that usually means =
that it did not match the
+  file match list (e=2Eg=2E only changes in `=2E=
github/`)=2E Consider whether that seems
+  correct=2E
+* Has the change pa=
ssed a GHA run?
+* Do any of the tests actually excercise the code? If not,=
 has someone other than the
+  submitter done any manual verification?
+
+#=
## Backports
+
+* Is it clear to which branches the change should be applie=
d?
+  * If it is a security fix, it should be applied to all branches that =
are
+    affected and that are not "unsupported"
+    (cf=2E https://commun=
ity=2Eopenvpn=2Enet/Pages/Supported%20versions)
+  * If it is a bugfix, it =
should be applied to all branches that are in
+    "Full stable support"=2E=
 Depending on the severity it might also be
+    applied to branches in "Ol=
d stable support"=2E
+* Have you checked for all branches whether a trivial=
 cherry-pick is
+  possible or whether a backport is required? If a backpor=
t is required
+  have you communicated this to the submitter?

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8=
f31f2ec68
Gerrit-Change-Number: 1776
Gerrit-PatchSet: 1
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--D5Zrg+8VDqA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Start a new document CODE_CHECKLIST<br><br>This is intended to documen=
t in one place all the policies<br>applicable to submitted changes=2E This =
serves multiple<br>purposes:<br><br>* Make it clearer to submitters what is=
 required of them<br>* Make it clearer what to consider automating when dev=
eloping<br>  (be it by writing scripts or by instructing an AI agent)<br>* =
Reduce the bus factor of the project by reducing the amount<br>  of things =
only stored in Gert&#39;s head<br><br>Change-Id: Ib123b7bf58317a1be5af1a1d4=
5decb8f31f2ec68<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>A CODE_CHECKLIST=2Emd<br>1 file changed, 112 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/76/1776/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CODE_C=
HECKLIST=2Emd b/CODE_CHECKLIST=2Emd</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000=2E=2E3c61ee3</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/CODE_CHECKLIST=2Emd</span><br><span>@@ -0,0 +1,112 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Checklist for Contrib=
utions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+## Introduction</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+This documents all policies applied to any change that =
should be applied</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
 this repository=2E It is separated in two parts=2E The first part describe=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the parts of the c=
hecklist that any submitter should check=2E The seconds part</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+describes the parts that integrato=
rs need to check before actually merging the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+change=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In g=
eneral the Integrator Checklist does imply that all checks from the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Submitter Checklist have be=
en passed=2E They are not repeated=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
# Submitter Checklist</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Commit messag=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+* Does the commit message acurately d=
escribe the change?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* Does it end with the line `Signed-off-by: My Name &lt;my@email=2Ecom&gt;`=
 ?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+### Automated tests</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+* Did the change pass a local `make` build?</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+* Did the change pass a local r=
un of `make check`?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
* Have you verified the code formatting with clang-format?</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+* Is the code covered by Unit Tests?=
 If not, have you considered adding</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  a new Unit Test?</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### =
Change-specific checks</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does your chan=
ge require adaptions on both server and client side</span><br><span style=
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
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+## =
Integrator Checklist</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### General</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+* Is the exact code change to be merged avail=
able as an email on openvpn-devel</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  mailing list (note: this does not apply to the commit messa=
ge since that needs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  to be massaged anyway)?</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+* If not, is the change to merge a trivial cherry-pick?</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+### Commit message</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+* Does it contain the pointer to the email on openvpn-devel?</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  This means a line `Message-Id=
: &lt;actual msg id&gt;` and a line</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  `URL: &lt;url to mail-archive=2Ecom copy of the mail&gt;`=
=2E If mail-archive=2Ecom</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  is not working, alternatively an URL to SourceForge&#39;s mail arch=
ive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is also accept=
able=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does it co=
ntain at least one `Acked-by` line from a known OpenVPN</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  core developer? Valid sources for `Ac=
ked-by` lines are mails on</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  the mailing list or +2 votes in Gerrit=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* If the change is a security fix, does it c=
ontain a `CVE:` line in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  the format `CVE: &lt;Year&gt;-&lt;Number&gt;`?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* If the change fixes a Github issue, doe=
s it contain a line</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  `Github: OpenVPN/openvpn#&lt;Number&gt;`? (Other repositories might</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  also be referenced if a=
pplicable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Have yo=
u considered adding a `Reported-by:` line? This is usual</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  for attribution for security issues =
but might be added for any</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  report where the reporter added significant value by his report=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* If doing a cherry=
-pick, have you made sure to use `git cherry-pick -x`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  to add a reference to the picked commit=
?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#### Gerrit specific</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Additional checks if the change was reviewed and submit=
ted via Gerrit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Does it contain a c=
orrect `Gerrit URL:` line? (This is generally ensured</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  by using `gerrit-send-email=2Epy`)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+* Is the `Change-Id:` li=
ne present and located in the last paragraph of the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  message? (If not in the last paragraph,=
 Gerrit will ignore it)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+### Automated t=
ests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+* Has the change passed a full bui=
ld run in buildbot? (Usually ensured via</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Gerrit)=2E This ensures the following points (which =
otherwise might need to</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  be considered separately):</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  * Build passes on multiple platforms (Linux, FreeBSD, Window=
s, macOS, other BSDs)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  * Build passes with multiple compilers (GCC, Clang, MSVC, GCC MinGW)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Build passes with =
multiple configurations (--enable-small, --disable-management,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    etc=2E)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  * Build passes with multiple versions =
of multiple SSL libraries (OpenSSL, mbedTLS)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  * Unit tests pass in all these settings</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  * t\_server\_null, t_clien=
t pass in all these settings</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  * t_server passes</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  * Verified clang-format code formatting</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* If buildbot ignored the change that usuall=
y means that it did not match the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  file match list (e=2Eg=2E only changes in `=2Egithub/`)=2E =
Consider whether that seems</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  correct=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+* Has the change passed a GHA run?</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+* Do any of the tests actually excercise the code? If not, =
has someone other than the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  submitter done any manual verification?</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+### Backports</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Is it clear t=
o which branches the change should be applied?</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  * If it is a security fix, it should be applie=
d to all branches that are</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    affected and that are not &quot;unsupported&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    (cf=2E https://community=2Eope=
nvpn=2Enet/Pages/Supported%20versions)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  * If it is a bugfix, it should be applied to all branc=
hes that are in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;Full stable support&quot;=2E Depending on the severity it might also =
be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    applied to br=
anches in &quot;Old stable support&quot;=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+* Have you checked for all branches whether a trivi=
al cherry-pick is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
possible or whether a backport is required? If a backport is required</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  have you communicated t=
his to the submitter?</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">change=
 1776</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--D5Zrg+8VDqA=--


--===============2354702063457954002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2354702063457954002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2354702063457954002==--

