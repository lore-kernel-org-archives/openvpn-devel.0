Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1C606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b9wyT10V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XCQ3pCTp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ivc2FtN4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LYEusc7l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=YuM/pUpZqrtq/Wi75vFYiioQ2VxonDKh4v9QRLqwIKg=; b=b9wyT10VFs0Zs8q5O6sABEczv3
	3VSJ5l04p1HWnsMWJj0HVbTCiXJEfpUm+9Bo1dvs5R1Q6+1OwdfmVdUtjUpvQNyfzK89S4SQyrKSP
	//EhNmV+6sCGV/q3aw6Zk8NQwW5fgoqMJ2iDgMYmRf9tGyvGvF+mmlpXYcEDsyJ6dVrg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNKQq-000000005bY-115M;
	Sun, 01 Nov 2026 01:32:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNKQp-000000005bR-0Pox
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VioGLcbqrb99e4WohZsl1lL5VlqKetEQ9Kt38V0sCeA=; b=XCQ3pCTp5XHbJnfdouwSmanigB
 UoTHkMmIL4oN4UQATio8w1yrMWUQSv4yFeJMKkJOFubRhyc8q+k6FlDfBxyGMGZRa1/OQvRTERLz4
 08NL6VtBTC60/3z7beMHYtNRshqxV53crgB2H4NDaIO7pORhtlDHmGP49wyHN6+05spE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VioGLcbqrb99e4WohZsl1lL5VlqKetEQ9Kt38V0sCeA=; b=ivc2FtN4KE8NvQ3AdSY122UWtY
 QVdT71zfJBAKcfqmpQnjd5Qpf3Vqa4D1Q8S+wvxlhTk83YSo06cxJA7+nuGgFatAWYBPagHihDE6C
 ZtglCMOw8+4D6I20YbRU1yu2/CyBq7OKy5vbxU9p0oLpei4u2I9CvxwwJ/xABB/8RraM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNKQn-000000004jK-3zW7 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:32:23 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so14503735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793496735; x=1794101535; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VioGLcbqrb99e4WohZsl1lL5VlqKetEQ9Kt38V0sCeA=;
 b=LYEusc7lswWRbb4sfIb16B30m5dn5/vis0nE/LJuJxgWQG15peS6pybfSMwbZwWNXU
 /1iOIrE7S/MNx6s2W/PLorIxVqOf0pvBy0b+jGd9o0e1/IKOWx35S87fK/eO5zbPKbUt
 kF+fXqmdC5GEm5m8AfOPxSRm53NomUMuEqT7OqpKrisrti1TsgdPMGAQFVfWgufPI3w5
 3r4nHB1jyoefInychJB0/2A92OXgxGvCL0GbeVrm7EUcEIAMQ/qQlwUfmahQk60CPsfy
 SaF8jFRwsEmLZC7MjalsSmZfvsyXUh0yHQlrJls3ztqBjziAZCUfLOkhZLXuLqq+rkEA
 4gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496735; x=1794101535;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VioGLcbqrb99e4WohZsl1lL5VlqKetEQ9Kt38V0sCeA=;
 b=J50Lw16/1r8IW0VklZRwdphvNw6c0KgaENO2OkwzH0XWxfsyikdzR1KZ3DQ2DPB5/s
 v6BzIe6HiZy+lipStDUrQE6BTIQhcrkwRxJQ6p4/DCfynxApXoh7TaMsQZzgU4kW78tA
 7wF/K7fW+mu25DURo4MzuiLFL1j+9FNKv3A79C7qm2zJGMTltHW5z85fu5Buao93JlCz
 wqirgY1CYTVlrt2RKTehM22H4ifFs6bK2JdvckGOnWO3bWqvxdE2WZXicyt4qkDfKBle
 Hjx7I24pN7pu5IiYLwqOMDl295tqYL5NLt6njV7UZttP+hClx3SpjjKNcipB7DeqIjkA
 ih6Q==
X-Gm-Message-State: AFq9FYKBQmvOpcUJjWEKJ7SLQcFWLXcUViqwoHfMVf/FLKpYyp4huUUo
 k/8ls5Dr7duz+/KmivdpjGqI5/hBuG/0fQUsifIWqmIGv9iToMBHchyUdhosFCoWhTVZaJm1GEQ
 YjaRx3FvwqrYbaXhzlibh38Sa5Ran3BbBfhfGOyIrO0MxQswqNVHZuGkczfCjAtE37YzsBGeuDY
 117um8Hw==
X-Gm-Gg: AYBFou24xTDr8vHG++orG0LTpQQLOl19C3jFAQKePWwHileVOU+viclfXLNrhbJBJqZ
 IXppKHo3QiLfSZZx/TZM3wdEdVFZr1PHmAcVp3pmSW0a9gVd3lGLr2mwwV5fHe6jztDcsoK3Apn
 tujX562ZvcUrxdva4bMy4jvm0YtEHo4vTliSQIZa932cB9A4mDNutcooO8d6paEVSuvYuA1Vv6N
 irTYPgpQj3xB6LYtcPNo0SBO1ClMdk0UOKoJA5B9cgLMYj0xUBXHZJY+HsM7MiyRmCQ5EZvJxNj
 bETNt5lcmuyEKOGU3KutxmD0se7atbFElaj9iRHQEgcQm5BFH9cJW4pZG5hUiMkw+xurRpEmwhl
 cZiTd4N/2ZvNRwkiVq/ONidy1dDPmELnWJ6rQUT9aAFFYtcmyHkbIRHOjvn5BhaFBt7MOI/A0ke
 HjXu3/L9i8sZddNNh1b1gzVDf/aZP+QmVVMJfqd5NzI3Cn8AxHZSwcVrDZdFh5lXmULWZ6lOvvr
 SpGyDfkmPhVmXb5CyXAmDuHFkClRSrtRf9g9/ZUschSj+jy78FXavqB5L7bNdFSbIliyommJ2dT
 596ziVtodSc0qt+wAmPi+i22iBemXRXMGZQ8KAQqHSXQUB6ACEHX7fsIY9f9z6fcf7I7d7N66RW
 dSYp5qEq++lgSMT+B2bUJcdDu+YmaaxhSKYqcsibiuVfatcSxM7+FcN81ccBAkDcgFicOHLr4nF
 4unf3k66wr7KfzuQ==
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4ac17ffb30fmr144139215e9.5.1793496735289; 
 Sat, 31 Oct 2026 18:32:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm149654275e9.0.2026.10.31.18.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 18:32:14 -0700 (PDT)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 01:32:14 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
X-Gerrit-Change-Number: 2075
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2075?usp=email>
X-Gerrit-Commit: a5ec84fdb69a6b63ebab56b260bbe231dfeca50e
References: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzMyMDAwLkk0ZDM1ZjU0NDAyNDYwYzU4NjZhZWJhMjYyMTZhYzFiMmQyZjhlYmRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30b1ef925ca75a82a46f6f8562ba6f59408748f6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNKQn-000000004jK-3zW7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: Wipe the key
 source material in key_state_free()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8731357129022411157=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8731357129022411157==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MgH/1NMyLG8="; charset=UTF-8

--MgH/1NMyLG8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2075?usp=3Demail

to review the following change=2E
=


Change subject: ssl: Wipe the key source material in key_state_free()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: Wipe the ke=
y source material in key_state_free()

ks->key_src holds the pre_master and=
 random values that the peers
exchange in key method 2=2E It is wiped after=
 the data channel keys have
been generated and on the error paths of key_me=
thod_2_read() and
key_method_2_write()=2E When a key state is freed before =
the keys are
generated, for example because an --auth-user-pass-verify scri=
pt or a
client-connect script rejects the client, key_state_free() frees it=

with plain free() and the key material stays in freed memory, on the
serve=
r and on the client=2E

Wipe it with secure_memzero() before freeing it=2E
=

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I4d35f54402460c5866aeb=
a26216ac1b2d2f8ebdc
Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
---
M =
src/openvpn/ssl=2Ec
1 file changed, 4 insertions(+), 0 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2075/1

d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2Eee=
f8e7d 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -934,6 =
+934,10 @@
 
     free(ks->rec_ack);
     free(ks->lru_acks);
+    if (ks->=
key_src)
+    {
+        secure_memzero(ks->key_src, sizeof(*ks->key_src));=

+    }
     free(ks->key_src);
 
     packet_id_free(&ks->crypto_options=
=2Epacket_id);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2075?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4=
d35f54402460c5866aeba26216ac1b2d2f8ebdc
Gerrit-Change-Number: 2075
Gerrit-P=
atchSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--MgH/1NMyLG8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Hansaem Wi would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">ssl: Wipe the key source material in key_state_free()<br><br>ks-&=
gt;key_src holds the pre_master and random values that the peers<br>exchang=
e in key method 2=2E It is wiped after the data channel keys have<br>been g=
enerated and on the error paths of key_method_2_read() and<br>key_method_2_=
write()=2E When a key state is freed before the keys are<br>generated, for =
example because an --auth-user-pass-verify script or a<br>client-connect sc=
ript rejects the client, key_state_free() frees it<br>with plain free() and=
 the key material stays in freed memory, on the<br>server and on the client=
=2E<br><br>Wipe it with secure_memzero() before freeing it=2E<br><br>Assist=
ed-by: Claude Code:claude-opus-5-5<br>Change-Id: I4d35f54402460c5866aeba262=
16ac1b2d2f8ebdc<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<b=
r>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 4 insertions(+), 0 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/75/2075/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2Eeef8e7d 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ss=
l=2Ec</span><br><span>@@ -934,6 +934,10 @@</span><br><span> </span><br><spa=
n>     free(ks-&gt;rec_ack);</span><br><span>     free(ks-&gt;lru_acks);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;key_src=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(ks-&gt;ke=
y_src, sizeof(*ks-&gt;key_src));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span>     free(ks-&gt;key_src);</span><br><sp=
an> </span><br><span>     packet_id_free(&amp;ks-&gt;crypto_options=2Epacke=
t_id);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2075?usp=3Demail">change 2075</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2075?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I4d35f54402460c5866aeba26=
216ac1b2d2f8ebdc </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2075 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--MgH/1NMyLG8=--


--===============8731357129022411157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8731357129022411157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8731357129022411157==--

