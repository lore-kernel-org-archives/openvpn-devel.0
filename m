Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C3606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W19Mp0Vm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NtNWA+ff;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B4JP+ogB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gAwaYt9r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1g9KGVxLb5v3HIAf/osJnx/Dsfe+zhM4oPSUC/Fk80=; b=W19Mp0VmSbclvn5ybIW5OAyEmA
	tcoPwM/Gp3A4sHFxrFQUpG4w+loi6fHm2B4H0OsYIt7AnVKzrb+X4bReSofqyghQqceWYPUY3kc7B
	myGsoi1Jm6v1IJu/WSooPEcAQg2Jx+rQo2loE2FrP4tvB44TNcqpD5c1NTeKxAN/SIR8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBQK-0002TU-Pi;
	Tue, 20 Oct 2026 15:06:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBQI-0002TJ-GA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:06:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iKBKYpZzXJ0rOy07amgiTGPW7nY1RLi1XDxmSZMHTvM=; b=NtNWA+ffaDBWgnSTg4/NQyLhSw
 eCUMdXglwNM9Ul6OOlVjF1DLeIuNS6y5xexT88zURv9D4TwJyncn+7WKlxZ9RgM7msEjex20eivM2
 MvL0wacAmo1lnaNRuQZZhoLnFqaHa78HOEMDuXopJWVU6lXeaaz82Mu7B23N6rmDaRCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iKBKYpZzXJ0rOy07amgiTGPW7nY1RLi1XDxmSZMHTvM=; b=B
 4JP+ogB9zvAhH8lEF/xW1Q3EWXzuIOMSBfhzMGOFodcuzZ0/KLiEuxZ+OKgURCWi9u6z6IidpVrk8
 e1tEKn3sTffIe9MDmPfTIF3f5ryOqhG/RBPbKb5Pjj1BGoXDSqdJNROJaXrnzmpUKSJr9+i7tSIuC
 1XtMIEkQQ2eOqbbA=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBQF-0004L1-FW for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:06:43 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso2741813f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792508793; x=1793113593; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iKBKYpZzXJ0rOy07amgiTGPW7nY1RLi1XDxmSZMHTvM=;
 b=gAwaYt9rV9XNVvMUyWC2Ure2lACrn+cjenAKtKdOLfMz+vQW1IADjjxfC+JNfvR4mW
 klDakyXri+DwOReZ3hq1a4uFJHEjHiXMt1N4U/gD7HqzQm8D6JXnh5mWTQb3YvrhDsQz
 pVpz44VhBYvBZzO85BXIGDiP/NHW15/ZazGi2N83A5qPG1n8Pmk/E77Rj5LjNRBHZhNr
 +vLWjMKY4qSsUqjm03TkWEslGh0soKAniz/eZwqM6EaMX8ZlM0pOdyI+E4RMn81n7Atr
 ugERKPQWcoR8MGQL1wsRZchoPluNmyArGtKODGQydEWIV2u6Fr7h5/g8SSFAawxSa06N
 Q3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508793; x=1793113593;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iKBKYpZzXJ0rOy07amgiTGPW7nY1RLi1XDxmSZMHTvM=;
 b=WkOI3U8+o4QWmjXHBDCg0Fxa/EFevAAjTtKBAUOMgmdLO26+is6DJKfgny6FAnREyP
 YQiBjgkPdsolcWH2Z4EsYOH8UFwH8+wMpHteK14R/KxNS+/bZPPbzc41cLmlkyDm4r71
 ARsM/E/agt42VAkBkI+X75WDK7FIU/Jd0qV6bnXkhTuOmf2aqN7nnQhpdJdPIS4qRu6L
 lbB06uXJrakRGTAnrwgnQVJr+sxLHxGmyEfBnQyvOuAQSUcqNOr4LOdsn54/6+XiCGxo
 PzDepzqvpu35byY9TlEsC2MQCb3u9CFvqLsl6R4NAduOdWcHFo9bQNVkkZzCP8AKskP0
 M5Ng==
X-Forwarded-Encrypted: i=1;
 AKwUvByyCmboU+lmqyd8C/k8pasN8DhxClBDc6B8Lppcw7gtyXENOjm5kgxl1Pr2EqqYB910VQoFpiTcq/B8gY+1@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLggygsiDtUZ/+wrTdFNXkFs2VKyHmwdZYGlNDcVuetTJ/HZDVn
 KVhHC5GwIMsgqYqNv59fMSNi0Dsj6RGzgnWBzsaaZficdJp51foTLN/iQwH+lbRcgvce+ZuHNCJ
 8bRu9XtzmTmNoD1+SLAZfxSZuaIuYy1Oi+bV74dPEddjFhpfMvYfuJYJSeUwdyPnSDSsw
X-Gm-Gg: AYBFou27eoQfGYefgiPqY4gjAwUFcKanhvVUuH8P1ov9sw+3WFelaTWv/jJFltW4f9F
 3cK1WKbDvDWDg8Xg9UCGLcaBSf7Kcs2R0mg1LdxSmL5uQUQSLaZWybtc/hWdzej5MMV53/Itu80
 B69ahSdajztXJPaqpHJEnhiBbdtE14Y4Lg0bcI1cymjPBugbuf8zyoeT+YOh6V+jSltOpNfJ7VN
 0W7JAC7S0lwy8Gsi3CNh4jB8HR7GzQfJsmZy7w9asZzxJJtlbwX7ISUbfDHYQOHWL3+GjDlgu3K
 GO9tQKi5W6hiO31NLJ4Ep98CbcIX7H+GuXUBjqvZZ2PqWZmnLK0oRkCeFTOWqlZTkHr0e4CPJr3
 zgi6CbSmwp9TxbtGR+Bqvxw1LbTowva9U8WaysEv77CKBYFFMCWTkUPsqfILl24hNAnv/Lkwq5I
 U0QRBw8QfnC8KyJfTXpqk78sy4c9Q34w0NUpHMS6e/orgjNVZkFkM1GGc5fS7jizHyLDl0HS4c1
 tq7Ni2VMbAyMYuRIXAV3KO0GZezPds2hrJFs+PwPvPmnXfrLPiIklmgwHIChsWoPnTOAH5HOYLN
 XgTlE1DNw9TpTXQj0FeHti/+SAtBO4T/9ID76pkWOL4WMIO2u08ZxzroZVuz
X-Received: by 2002:a5d:534f:0:b0:486:e707:42eb with SMTP id
 ffacd0b85a97d-48e07f9a00emr17750650f8f.33.1792508792624; 
 Tue, 20 Oct 2026 08:06:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6dbd43sm5460834f8f.4.2026.10.20.08.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:06:32 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 15:06:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
X-Gerrit-Change-Number: 2023
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2023?usp=email>
X-Gerrit-Commit: b892decff1ef4d3c4fb8cc9ff7cc761036c2323d
In-Reply-To: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
References: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDI2MjczMDAwLkk3ZjJkYjYwNTY0ZmExNzljZTVmNTY5Nzk5MTJjN2U0ODRkYWQxZTFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d6269cfa6050bd9ca095d5b0af345aa6b68f3219-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xJBQF-0004L1-FW
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix broken
 unit tests after commit 5c6fbd0a11
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9081345482243195055=="
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9081345482243195055==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nw8yaRzHe3o="; charset=UTF-8

--Nw8yaRzHe3o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2023?usp=3Demail )

Change subject: Fix broken unit tests after=
 commit 5c6fbd0a11
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Fix broken unit tests after commit 5c6fbd0a11

Said commit only che=
rry-picked the "actual code change" but not the
required adjustments for th=
e unit tests, leading to an unresolved symbol=2E

Master has all the mock f=
unctions in mock_push_dependencies=2Ec which
does not exist in release/2=2E=
7, so import "uninit_options()" into the
actual unit test source (as are al=
l the other mocked functions in 2=2E7)

Change-Id: I7f2db60564fa179ce5f5697=
9912c7e484dad1e1d
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2023
Message-Id: <20261020145859=2E1457-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg40076=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/test_push_update_msg=2Ec
=
1 file changed, 7 insertions(+), 0 deletions(-)




diff --git a/tests/unit=
_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_pus=
h_update_msg=2Ec
index 9b7978e=2E=2E75b654b 100644
--- a/tests/unit_tests/o=
penvpn/test_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_up=
date_msg=2Ec
@@ -48,6 +48,13 @@
     return;
 }
 
+void
+uninit_options(str=
uct options *options)
+{
+    gc_free(&options->gc);
+    gc_free(&options-=
>dns_options=2Egc);
+}
+
 bool
 options_postprocess_pull(struct options *op=
tions, struct env_set *es)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2023?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
=
Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
Gerrit-Change-N=
umber: 2023
Gerrit-PatchSet: 2
Gerrit-Owner: Gert Doering <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--Nw8yaRzHe3o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2023?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix broken unit tests after commit=
 5c6fbd0a11<br><br>Said commit only cherry-picked the &quot;actual code cha=
nge&quot; but not the<br>required adjustments for the unit tests, leading t=
o an unresolved symbol=2E<br><br>Master has all the mock functions in mock_=
push_dependencies=2Ec which<br>does not exist in release/2=2E7, so import &=
quot;uninit_options()&quot; into the<br>actual unit test source (as are all=
 the other mocked functions in 2=2E7)<br><br>Change-Id: I7f2db60564fa179ce5=
f56979912c7e484dad1e1d<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023<br>Message-Id: &l=
t;20261020145859=2E1457-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40076=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>1 file changed, 7 i=
nsertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests=
/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_upda=
te_msg=2Ec</span><br><span>index 9b7978e=2E=2E75b654b 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@@ -=
48,6 +48,13 @@</span><br><span>     return;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+uninit_options(struct options=
 *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;options-&g=
t;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> bool</span><br><span> options_postprocess_pull(struct option=
s *options, struct env_set *es)</span><br><span> {</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3D=
email">change 2023</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2023?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2023 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--Nw8yaRzHe3o=--


--===============9081345482243195055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9081345482243195055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9081345482243195055==--

