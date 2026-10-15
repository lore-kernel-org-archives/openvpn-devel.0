Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D431CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Md2TA+HUi6VYpvZmTAE6IY9Z3peQdln8/UCI+OW4JsI=; b=hrjVsefZg2cHbXeNctPnHZCnPu
	mql4FwzXFxmoOOjxTWrLu2vT6Eis416dINB4Pzh9uRJlXyp9WXmi+Q6YNBzL3HplMjTsQr4hWSrE5
	GXKiHh1K2PLXdylg2rk29qh2fFoN0+AYEBX6Cy4OVComwg47WOD66yRGuYca8ftY2BC8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHMvZ-0007X6-2j;
	Thu, 15 Oct 2026 14:59:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHMvX-0007Wz-11
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h7TOoJh+BEM2SN9DwI6FbsgEwBl0mNV/xSJtZnNx8w0=; b=g5EJC9Rnk6U4LrgwUKLxDvmQKP
 vTUtDyjSxm+GRO98V3BB9UfZHnYXE0XXvZUKN8YkhMGhKKZmRIqNLlUuxgES5eF2RnQwLZ6xkzQHs
 Paet9ISYNzKSHniyXzHZlpkhUbuKb2yhCCXCFRPnGjNquqI28b7csscYjdRv3H3ehvjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h7TOoJh+BEM2SN9DwI6FbsgEwBl0mNV/xSJtZnNx8w0=; b=b
 r5Du+E9gL1UGDt6+8sGvekSRU/bP+wmQrfvQmzbLzIeSAUn4cqEGjyIOgAHkyqvUc1QUnvR2AiIFk
 9WICzKI2oqRVRuHhXJZTtYQSgpEay8dyYwMrfIERX5p3pBWqDSTCa7Z3fU4Jgtju+Fk/FQ937PnaZ
 NcKVk4tOvxe0QKJg=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHMvV-0003KI-RZ for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:26 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so27394415e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792076359; x=1792681159; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h7TOoJh+BEM2SN9DwI6FbsgEwBl0mNV/xSJtZnNx8w0=;
 b=CDhGNdx+yzOfOdAvXwxHJDl7mvYRVJqqVWsnxwrtZGPfdKJxOUbD9oF/gvq0Aqu90J
 bMNTVzxtiLktNnX6JgfwM6YHf790DeI6BK6wUiYknTxVhU+akif04/FZZGzFNYgclVCM
 suyLvf/CpyFoM/7VsYj/2D8/ZEhcqzfeo75rSWniVBhck/7R/9PD9bBUg9gOZe7F0XDg
 aR6Af0Appxe2Y0c1iVqZ4WRc0IGLRuwILuPGRc9ez3iOzESvLucn7wsBS79lYr/YwrSB
 VUSR18WOvzkJBK5ho72VzO9WXKCWeWDWSdVJPSKtK0NKFOqICyBuWydW/yELv0mCeUxg
 vFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792076359; x=1792681159;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h7TOoJh+BEM2SN9DwI6FbsgEwBl0mNV/xSJtZnNx8w0=;
 b=w0FUtFGPLAPYCMOa8JNJE8znHWtdsR2xN5BjuyptoHZQJJa+alZ0etrypw9LVZkpJ1
 qPOC89zeRK3A8uQ3X/UCDMF+TNdElDeuqIjAmCNikpV97JzwkhE9HJU5uG3AoMtHbmVs
 k7fX/oR+QxcmBLbX5DBWOlTubsRsgXcVdPW8vI3sZ+nhgaHWcaCJNnZACu5iQLmqSuzU
 2V6OfW1FYrvC1Iofq+ZRSEe3Jmhc9dgYj+8XUSvgf0Md87arSKct/6XPMYpuTR7mzq/A
 th3jLHqiz104g9ZMJO3X/XhDiA3sVX7TSNycKxGFJf6ZGVaj72mPhmHJG49NU9oYulEo
 mrMQ==
X-Gm-Message-State: AFq9FYI05/8PaEiFIdQYdkKZFzRpIccaxei/+jpKQAdv3EXLQf8L/HKI
 5l8249WAs2j8XeAjuxgmne/21bcPYofh93dW3PR4+2ZCSgu4GcAyVYtlJtGjgHeQQ/fexdPVMnS
 nEdG4tn9ewZwJlWsPc/ch29G3ZbZvI5b1EDfNvduiAjyF/YFwVP3rE1OfdZ87DPce9KQS4XaQOm
 Llu5tBYQ==
X-Gm-Gg: AYBFou2cUoNl6UqWC9klE2YDP55KlSPFKgMQNogDwuY3PivbdWDjPvLSQc2cqMwsUGt
 R5+QIJZIp+PE8ZDu9nFs1dlT2o0IDtzsD/E0vhW4b82iUnph8WsOMy2SbkRIqR35i+I8fOZjMU6
 TTsZph6e6WmG96gIl85h0doZADwLhFjr8AV9l9Bhe5ZCWuoUZXTMuIszyI8HN/BB2w357m/h9LK
 +beJGIiHeSArsb9W7JnBQdhOrq1SHur4VJJVEl4jQiYWoxEaXSl4e9aN3VMZWOXUOBcIpxATOGL
 8sMNLk4wg1nIcjfYnnduWJpucJEzmp1/ffH1/nlcYgUHOFnno55Sj44gqluesZKGoeIeRj/ISU0
 fj+RM8epc1k3kWjRtC7OzGTAthZxDOmRVC4BbUFYlgY/HdVm9a5KMQCC3/urGQUHN1XG0KuK4zA
 LJ9LWcHHxMd1TGHey1P8uUjkTTk2fWCrGr7/IKbxuutBWsaIdjvx/taYKtoR72AeH8iF8O+CJ5H
 t372TeilGc5T9OuagJUqXK404YN/LbrHoKhWxLtuwoMkZGimKYYy4Uo6m8JnZzcjmLHNzdCrOXd
 Ooc5aXg3BxNLidPQCqd/Kv65jA2DoOxaF2/OfCedrPd/MUiYNtdJpI6sfjC6
X-Received: by 2002:a05:600c:524a:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-4a18e4a4f2amr391671255e9.6.1792076359064; 
 Thu, 15 Oct 2026 07:59:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfaf1acd7sm361811f8f.1.2026.10.15.07.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 07:59:18 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 14:59:16 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
X-Gerrit-Change-Number: 1999
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1999?usp=email>
X-Gerrit-Commit: cc54693fce1229731291ca3e79656034b212c900
In-Reply-To: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDYyNDIxMDAwLkk2Mjk0NjY1ZTM5ZGRmMDEyZjBhMzk0M2QwZTM1NjU3NmY0ZmUwMmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <654e94797631df42d2c1e149e62c39a82f91eb8a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHMvV-0003KI-RZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clang-format: Enable
 InsertNewlineAtEOF
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8901059995378711071=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8901059995378711071==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NK1b/7Equh8="; charset=UTF-8

--NK1b/7Equh8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
999?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Arne Schwabe, Code-Review+2 by Gert Doering


Change subjec=
t: clang-format: Enable InsertNewlineAtEOF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clang-format: Enable InsertNewlineAtEOF

We=
 had some patches recently that committed files
without newline at EOF=2E E=
nforce consistency=2E

Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999
Mess=
age-Id: <20261015111030=2E22570-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39893=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Eclang-for=
mat
M src/compat/compat-strtok_r=2Ec
M src/openvpn/schedule=2Ec
M src/openv=
pn/siphash=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Eh
M tests/unit_=
tests/openvpn/test_schedule=2Eh
6 files changed, 6 insertions(+), 5 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
99/1999/2

diff --git a/=2Eclang-format b/=2Eclang-format
index 0823739=2E=
=2E23d224b 100644
--- a/=2Eclang-format
+++ b/=2Eclang-format
@@ -32,6 +32,=
7 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
 InsertBraces: tr=
ue
+InsertNewlineAtEOF: true
 KeepEmptyLines:
   AtEndOfFile: false
   AtSt=
artOfBlock: false
diff --git a/src/compat/compat-strtok_r=2Ec b/src/compat/=
compat-strtok_r=2Ec
index debcdd3=2E=2E4240458 100644
--- a/src/compat/comp=
at-strtok_r=2Ec
+++ b/src/compat/compat-strtok_r=2Ec
@@ -98,4 +98,4 @@
    =
 }
     /* NOTREACHED */
 }
-#endif
\ No newline at end of file
+#endif
dif=
f --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6c60dc2=
=2E=2Eff243dc 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/sched=
ule=2Ec
@@ -389,4 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalid=
ate cache */
     schedule_remove_node(s, e);
-}
\ No newline at end of fil=
e
+}
diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
index e=
31b708=2E=2Eb9fc5e3 100644
--- a/src/openvpn/siphash=2Ec
+++ b/src/openvpn/=
siphash=2Ec
@@ -46,4 +46,4 @@
     } ret;
     siphash(k, length, hash_key,=
 ret=2Eout, sizeof(ret=2Eout));
     return ret=2Ehash;
-}
\ No newline at =
end of file
+}
diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/=
tests/unit_tests/openvpn/siphash_openssl=2Eh
index 0f1d329=2E=2E49c6a9d 100=
644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh
+++ b/tests/unit_tes=
ts/openvpn/siphash_openssl=2Eh
@@ -61,4 +61,4 @@
  */
 bool
 siphash_openss=
l_available(void *sip_context);
-#endif /* ifndef SIPHASH_OPENSSL_H */
\ No=
 newline at end of file
+#endif /* ifndef SIPHASH_OPENSSL_H */
diff --git a=
/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test=
_schedule=2Eh
index 55dc591=2E=2E3705af9 100644
--- a/tests/unit_tests/open=
vpn/test_schedule=2Eh
+++ b/tests/unit_tests/openvpn/test_schedule=2Eh
@@ -=
24,4 +24,4 @@
 /** Runs the schedule test */
 void
 schedule_test(void **st=
ate);
-#endif
\ No newline at end of file
+#endif

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e=
1
Gerrit-Change-Number: 1999
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--NK1b/7Equh8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1999?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Gert =
Doering</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">clang-format: Enable InsertNewlineAtEOF<br><br>We =
had some patches recently that committed files<br>without newline at EOF=2E=
 Enforce consistency=2E<br><br>Change-Id: I6294665e39ddf012f0a3943d0e356576=
f4fe02e1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1999<br>Message-Id: &lt;20261015111030=2E22570=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39893=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Eclang-format<br>M s=
rc/compat/compat-strtok_r=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/openvp=
n/siphash=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=2Eh<br>M tests/=
unit_tests/openvpn/test_schedule=2Eh<br>6 files changed, 6 insertions(+), 5=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/99/1999/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Eclang-form=
at b/=2Eclang-format</span><br><span>index 0823739=2E=2E23d224b 100644</spa=
n><br><span>--- a/=2Eclang-format</span><br><span>+++ b/=2Eclang-format</sp=
an><br><span>@@ -32,6 +32,7 @@</span><br><span> IndentWidth: &#39;4&#39;</s=
pan><br><span> IndentWrappedFunctionNames: false</span><br><span> InsertBra=
ces: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+InsertNewl=
ineAtEOF: true</span><br><span> KeepEmptyLines:</span><br><span>   AtEndOfF=
ile: false</span><br><span>   AtStartOfBlock: false</span><br><span>diff --=
git a/src/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec</span=
><br><span>index debcdd3=2E=2E4240458 100644</span><br><span>--- a/src/comp=
at/compat-strtok_r=2Ec</span><br><span>+++ b/src/compat/compat-strtok_r=2Ec=
</span><br><span>@@ -98,4 +98,4 @@</span><br><span>     }</span><br><span> =
    /* NOTREACHED */</span><br><span> }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span>\ No newline at end of file</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>dif=
f --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><sp=
an>index 6c60dc2=2E=2Eff243dc 100644</span><br><span>--- a/src/openvpn/sche=
dule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ =
-389,4 +389,4 @@</span><br><span> {</span><br><span>     s-&gt;earliest_wak=
eup =3D NULL; /* invalidate cache */</span><br><span>     schedule_remove_n=
ode(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span>\ No newline at end of file</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/src=
/openvpn/siphash=2Ec</span><br><span>index e31b708=2E=2Eb9fc5e3 100644</spa=
n><br><span>--- a/src/openvpn/siphash=2Ec</span><br><span>+++ b/src/openvpn=
/siphash=2Ec</span><br><span>@@ -46,4 +46,4 @@</span><br><span>     } ret;<=
/span><br><span>     siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eo=
ut));</span><br><span>     return ret=2Ehash;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --=
git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openv=
pn/siphash_openssl=2Eh</span><br><span>index 0f1d329=2E=2E49c6a9d 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br>=
<span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>@@=
 -61,4 +61,4 @@</span><br><span>  */</span><br><span> bool</span><br><span>=
 siphash_openssl_available(void *sip_context);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><s=
pan>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/t=
est_schedule=2Eh</span><br><span>index 55dc591=2E=2E3705af9 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>@@ -24,4 +24=
,4 @@</span><br><span> /** Runs the schedule test */</span><br><span> void<=
/span><br><span> schedule_test(void **state);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span>\ No newline at end of file<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1999?usp=3Demail">change 1999</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1999?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1999 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--NK1b/7Equh8=--


--===============8901059995378711071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8901059995378711071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8901059995378711071==--

