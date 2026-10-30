Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D784606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dAoLqhRs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bXgYIJI1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j4lj1CcK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hArvknn+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0R3LPmdp2UV0/G4hJB937LjS57FUh0mY5sASBdPdS1I=; b=dAoLqhRsPdvg5Um8WJKTCi66hy
	hvVSoWLCuECbPdRLrqG0yzCuEDiTniD8q+IyuXhfTB+tjG1rD21GSQbTz8XCsqMQUCvqtnCSyQvLj
	tMLWBRpmlZVa4WmIBuHdNJsAgRJvWUwJPH5CdkMQSfaWv9eniOA4xCqojuyKJXUE19GM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrxT-000000000TD-3wFP;
	Fri, 30 Oct 2026 19:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrxR-000000000Sh-3IV4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UlxZ9FHmD/eQ32h+9x8dddvh6dQxnnF5dcyc/NtB16Q=; b=bXgYIJI1dp2hxHUTjXQQykOa2I
 2Y/I2wgxMohQBf0w2E4Y1YaNSe+7J8gIwqtKEyC4aiZCeqGsI2Upe4ciaU8+rIVEgRcDxRmXZMmiU
 qS2ZZQaSgjleg7g31bzf3B1JC16riOgttB43b46mrCcnii+3Rd+RHZW1g5N/Vy0IWiXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UlxZ9FHmD/eQ32h+9x8dddvh6dQxnnF5dcyc/NtB16Q=; b=j4lj1CcKEoSb3YJ89MshMMHK2S
 QvBOgo85zrDb7nhvmz28YcuVbJqPrlw3tdqNsT3KXrW5Aeg8PHUTZBz3zBahb1A8BXb1Yj3eMOwa+
 aJl46Cb9FrUmqF7sBW06OYxqZncETbTEXaUA899tLAWCd9Lxw8AmJ+Qu7ZGKJfoWifds=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrxF-000000006Qg-1oaw for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:07:58 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso549311f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793387271; x=1793992071; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UlxZ9FHmD/eQ32h+9x8dddvh6dQxnnF5dcyc/NtB16Q=;
 b=hArvknn+dL1uW50zSuyMi6BOSZpo4f6Ze7EvITrn+4BogNoMMQ9SYdrVX96CbR77St
 HivYVy9udW+g03hYBgNe0aNSH9EiL6RdbQSP4uRllnNQhugWDGfUmB3jqMjO9Ompx0Sr
 T9PKiAtXkL9pPW7MlmqF2Au2dRjuZWgfdbEd88BFwhc8pJ/5iJrN+bUcCPa1l/xO47NQ
 hhwH+iWTh9du4dgRlsMT6Tfv+wjMs1uz/yZbwenHomqU4IQK9UJ6HZXS4WJD4dWhmH5u
 3mjPj7ZOp7q2CA4lgrgpEA167x1jmDpnCNtCO0jtw/bSv3ZVADPJZQDhe4J8mlsA8NZh
 OB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793387271; x=1793992071;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UlxZ9FHmD/eQ32h+9x8dddvh6dQxnnF5dcyc/NtB16Q=;
 b=vjfFaEyMBhKfclurVaNDQW5g/ZOCAbWMi4REcJ9HNlSi285fhCMc6cVlrG1fdFx5/D
 L00NCdWpMcF22vvsFujixWo3IpzusUGF/sbSYpkRR2iifkkqnGgtAr/pwT0YmqjFlT8t
 Rdzlexn3/ePtgqe7JrY/Tusok8JVaNCxSFMae4nfF0VHsJ324ivYGmZDPW8AD8XD0BSx
 yNUv5MRdhmCg1mmtIPsM4spMQZRyEOZyMBmzR2kvGVoFEZtfnS6J4ATDFBINGJdswety
 qL1FZXbdgBmtRzh3drB+GLitfEdIacg7NVX/Sa+nGU3jYeFIJMglSLGziBHWJNmBwlNp
 7cWQ==
X-Gm-Message-State: AFq9FYKnGJbaH1VmKRlW7dFGAFKLkJVGsLw4ku4JWKXd8ad7Y76TvWAB
 NIJmargTyR+VGOHdCu2/Zcb/Gb4Nd3gmT7Xzm9E5onJIjwvtEhl/N6FJIQqeTWuLmePofXitug+
 ATlq8hPBaYuAYNBV7+qcxBFA/Cyzk9OUyiER5vLSkzRILKqBYm5MdrUyQERbo/IT2Exza
X-Gm-Gg: AYBFou1EpfwZlSayUetX+OP1W7KRUUPLk9sA6OR8tgDmJy7uPcmOMwHAPDYpiWG1GSk
 OOHsylOPKkgBvpeVgFqecomS4l4dnMaOvszfBH+TgIbHFanmmOEcqnmBlzY//FDrPCHcA0SNICz
 7axNKP5n0v/00bQLt8ImLe6sqrLPfKX4epzgBypuDwQ5RNk0MyjF2UV1bEaIyulkFSBW72fLlQV
 /pU4vy+IvUuIlGpQVUBzhW0KFzZhHHqCNidzmPGjsD7/EXSgMjoKiWoNfVvAaxKlDg30/iVFLW8
 UhzfkgOSADuTAllPKVB73sOe+UwYiJMDRvclUv6YwbCbMJvdFLZ7mHA9JyHQa8Pg4q31QZ/PuB0
 A9j8smLWsRCBrQQ2k2vQz5bBz5tO38yzcgmH0/nO66lY6QgOBOTzIFvgT3ynLEFIlccGjZbTmio
 EpLEmoy30CSwYjptPdgt5TrJODoldmc6Gox4PfNTW6QjKlWd3Mi+hDEWQijnn6qKdhSJD5ytjgm
 k0JnPMkmYzAVKFXC4BMb4OzI4L2IqEuQt60jb8YS+ENKI0UyDAv2cEdtnNU3D08DYDU/+krlHEx
 p3WUfU9hQiimiYApguo/D2Cjq+jg11ADMJl7Nw0YVHc94ttJmI5SI2PM8bFAAwCFXrqE5KBIt6Q
 y4z6Uzap6trPL94dYbvZ/DPZLXHMpYgTN9O/Xrt/IXYvOiraGlAVaQ9OHdK9gbUeUJXdAc1IerT
 O0juVzlOkPzZnQZRU=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4ac17ffb2ffmr73100355e9.9.1793387270755; 
 Fri, 30 Oct 2026 12:07:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm4462733f8f.18.2026.10.30.12.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:07:50 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:07:49 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
X-Gerrit-Change-Number: 2070
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2070?usp=email>
X-Gerrit-Commit: 90872ff897ad16bd493713965fdf2246d31a05b2
In-Reply-To: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
References: <gerrit.1793281941000.If33596abef4e97aa9b58f12cd866a5cded17fd4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjgxOTQxMDAwLklmMzM1OTZhYmVmNGU5N2FhOWI1OGYxMmNkODY2YTVjZGVkMTdmZDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60e309849c13c7bcd26c69ad617c7b49bb92eeac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrxF-000000006Qg-1oaw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_provider: Fix
 compiler warning with clang 23
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5456008188964440468=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5456008188964440468==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oI560NmYsyw="; charset=UTF-8

--oI560NmYsyw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
070?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: test_provider: Fix c=
ompiler warning with clang 23
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

test_provider: Fix compiler warning with clang 23

With --=
disable-management it complains
"variable 'mgmt_callback_called' set but no=
t used
[-Werror,-Wunused-but-set-global]"=2E

Change-Id: If33596abef4e97aa9=
b58f12cd866a5cded17fd4f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070
Message-Id: <20261029143143=2E19=
636-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg40307=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/test_provider=
=2Ec
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/2070/2

diff --git a/tests=
/unit_tests/openvpn/test_provider=2Ec b/tests/unit_tests/openvpn/test_provi=
der=2Ec
index e5562ee=2E=2E5d31da3 100644
--- a/tests/unit_tests/openvpn/te=
st_provider=2Ec
+++ b/tests/unit_tests/openvpn/test_provider=2Ec
@@ -42,7 +=
42,9 @@
 #include "test_common=2Eh"
 
 struct management *management; /* gl=
obal */
+#ifdef ENABLE_MANAGEMENT
 static int mgmt_callback_called;
+#endif=

 
 #ifndef _countof
 #define _countof(x) sizeof((x)) / sizeof(*(x))
@@ -15=
6,8 +158,9 @@
     char *out =3D NULL;
 
     /* indicate entry to the call=
back */
+#ifdef ENABLE_MANAGEMENT
     mgmt_callback_called =3D 1;
-
+#endi=
f
     const char *expected_tbs =3D test_digest_b64;
     if (strstr(algori=
thm, "data=3Dmessage"))
     {

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2070?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f
Gerrit-Change-Num=
ber: 2070
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--oI560NmYsyw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2070?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">test_provider: Fix compiler warning with clang 23<br><br>With --disable=
-management it complains<br>&quot;variable &#39;mgmt_callback_called&#39; s=
et but not used<br>[-Werror,-Wunused-but-set-global]&quot;=2E<br><br>Change=
-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2070<br>Message-Id: &lt;20261029143143=2E19636-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40307=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/test_provider=2Ec<=
br>1 file changed, 4 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/207=
0/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/tests/unit_tests/openvpn/test_provider=2Ec b/tests=
/unit_tests/openvpn/test_provider=2Ec</span><br><span>index e5562ee=2E=2E5d=
31da3 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_provider=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_provider=2Ec</span=
><br><span>@@ -42,7 +42,9 @@</span><br><span> #include &quot;test_common=2E=
h&quot;</span><br><span> </span><br><span> struct management *management; /=
* global */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_MANAGEMENT</span><br><span> static int mgmt_callback_called;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> #ifndef _countof</span><br><span> #define _countof(x) sizeof(=
(x)) / sizeof(*(x))</span><br><span>@@ -156,8 +158,9 @@</span><br><span>   =
  char *out =3D NULL;</span><br><span> </span><br><span>     /* indicate en=
try to the callback */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef ENABLE_MANAGEMENT</span><br><span>     mgmt_callback_called =3D 1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     const char =
*expected_tbs =3D test_digest_b64;</span><br><span>     if (strstr(algorith=
m, &quot;data=3Dmessage&quot;))</span><br><span>     {</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2070?us=
p=3Demail">change 2070</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2070?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: If33596abef4e97aa9b58f12cd866a5cded17fd4f </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 2070 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--oI560NmYsyw=--


--===============5456008188964440468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5456008188964440468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5456008188964440468==--

