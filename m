Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEB606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ff6UxdVC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lAG/On34;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IAG6K9R6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H27YMiOl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kQQNITjxrx9o90u7KFdssuwjlPotiOmO0sQvjqvrclQ=; b=Ff6UxdVCxgqTURt2XYjbPqsXUM
	R6JjSCAimSrQ6oPdQ57k4KvtvT9sUPnietwJ+BAg/lkw2/SqJkPyKuUeLUrSPoWWqnwY0AhGiNaUK
	SkUyZL+Mh9p4N23/mZVZtssqusnfZB/Kv6eEDegFFg6tarAPj/Ru2zF6gNRQBk/VP328=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVQq-000000006O4-2Zdf;
	Thu, 26 Nov 2026 09:06:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWVQn-000000006Md-2GtN
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N7GCWYxAyC2qhUIP9pdXJbaSG/vrjzVDRavOIDW5daE=; b=lAG/On349wjwbTcqVWlwB6G9wg
 HKfdVcqNdLq7ELjHkfIOtngttU94s+tnZ9qEKvz/p2Fx+hRZ+Hh7jP3EBhUhizDzIJHyMlj2gCGW0
 mVm/dTv+QQodDbuYvQhaJBEK19oxI4RbjRDK1nETMdzh+Zr7ZyXNiUQ82ppw7UpBW2ig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N7GCWYxAyC2qhUIP9pdXJbaSG/vrjzVDRavOIDW5daE=; b=IAG6K9R6V5zVcF3b7AtENZpjgi
 hQ/24j5A/yrefm1MiPnAA1IvxRwRiseGXFrfM59UgMsMRw6/AhD+K0IPFHEMnOpPcK/wsrV+Y6eKl
 44xlDl+CVejwj8Fnw0tW4kfG+JQCxcOf8zP5sF51sPctQvhqh0oZQv0dXgJzFY+EKoL8=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWVQl-000000004PA-0BZJ for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:06:16 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4ac109a8a12so3948003f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795683968; x=1796288768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N7GCWYxAyC2qhUIP9pdXJbaSG/vrjzVDRavOIDW5daE=;
 b=H27YMiOlJ/5nktKucqzHtBkN7OQijo9+BXl72Co0vC5g1EyuqOVA4TWDGLPsG5vGFx
 zawKK7ksJ2/8iZqYS7ggf4k3oeJCvttyU/AuGe6rmdSNzFc2Uu7+cBeTMApEgshK2CIW
 Nvc9AXo3Jd9Op5uDc/jxsGHKp5ZEhVJDkRt/vZ+xNmJtufamP9RlFpQEV1qCIufIB1Wh
 aYFrcs4w+CX7QMya0jCMN9+L3HUsF9xmjX/0+gz4/eiv78GW2KYzdCcLZb08Y4uZGklE
 My5yVp2SFRzTKyTx7Qm69ET06UuplkCm5+XBMQecsYt2PaB5b84g29gaZctURlkkFadG
 SkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795683968; x=1796288768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N7GCWYxAyC2qhUIP9pdXJbaSG/vrjzVDRavOIDW5daE=;
 b=Tnipu0AkmOP2FOqrn+BCVEEJdqtr8WGgOeJq+cQUYSSg2Cglzgijf3ZUEnNvanczTF
 QiPEUJcTJg7e/y/tzu8wc0Zqo/nvy/vJuzBXXq+Xumo6CKOwJ4wsL/2a3Vpw7spMaBmj
 1UdTZxYSBVNPQIQzoWKxFhRetkx59HwnOTfAn6attvpf+5dPvF8pnXbqtg0xziNqlnxp
 DVokqaP/1fvy2Jk+9gjAKLnvJ7yvcPJAr5TWD/Dk2PtbpiJdfDwBERJLhNQ1+fyXVBw2
 S+NWLsyTfQvdju9CiCXptu9K4it+L/hEYFsQ/PHzYXS6IXdx54tE0N2WAa1YZhLfa2iO
 tt/Q==
X-Gm-Message-State: APuU4Z/lCk9D2gEKOyShNUa6HXDo6V0oeNi5MLhRxtUFsijwyC+H9YsN
 agKOg+m1GLR6iOR11bA5qKCz+U1yxv9R3YFlT7Fqnwag3SFu2VgWhKzikr+g9Vw6kK6T2/Nz/fG
 HaykrgdTXPwB/uM8aBEzCwxNUAAd/V3houFQA+Y43+Wir0tzY2RMthVp9cGHJD/B6/uch
X-Gm-Gg: AZFdTZcIAJUlQ+qk/mV1STllVJOcPN07Mimh2R/Q3fqaytN9is+kbkeE8KQ7USL/PtZ
 ADNTTfRnUuzFO4ktNfYojy527qRMw8yyOg3KrFlZ9TzHX59zL8AZMW6xP+qsDakOQKIonIwNjL0
 UWaI47gkeDNe1xR4Pil4bSz++L3ZTMlMBjqZw02W7RUJ8PbyChV5sAmsgieVfdVQfFFyndNBrfJ
 k0KvdUIBkdTyMojqt48D+nOh6U6hAXza5HVBp6LQjbKRKOhKt/2mZUuKlAAIpVarUSisukw04fu
 erFQvE3C7Zzlfp0GXU8ZmS0kkqrDSrrfVAYR1YhlAW+HE8+0zFqciZZ1t7mIgDKgRGlYQkbripZ
 sqyrTDJK44T5GBfsYTg6YTBZ345kwt25G9xHW/9R3e+i38le0a7qpjKcaeFkhPzUErHDGZIe4Yk
 +O9Ds1JE1xxb8qrI8+EVIpxK5GvK5/zwNlt0bslVgUyweMlkBk/e5BzTmvziA+dj2EnFQjY4VqM
 AgciKmb7qcf1SMnU7NKaaXE0tjaYnndz/lelN1VK70i/CCTbcpQEpcmK6lNDttCTFIo2OXQEBFW
 QOJls/kGqgBdyIgndgg3RszPpPjxSwn8AQwPV41McZWwa1gBcko2wFqAOnH7EeWNF4DB+8EQ+M3
 ZXGJzdEpxnr6Irj6AKnHy6wLq7+Bym9ahezMqBfIE/Qq1tfcRRdhRz9hc93eIWwGcGON2LxKrMU
 oSViLdZ1VIXgDLTl+7A8IpT+p8hzjlRR0q2fyY
X-Received: by 2002:a5d:64c8:0:b0:493:c0a:507d with SMTP id
 ffacd0b85a97d-4abaab633c7mr44252455f8f.1.1795683967661; 
 Thu, 26 Nov 2026 01:06:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm41233358f8f.29.2026.11.26.01.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:06:07 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:06:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
X-Gerrit-Change-Number: 2206
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2206?usp=email>
X-Gerrit-Commit: f043cea230691f41bb05367b871d3ebd3e17ef19
In-Reply-To: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
References: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzNjcyMDAwLkk5ZDliNjU4YTAwZjk1ZmZkY2QwZGI5YWJkMGQ4OTA3NjE4OTI1NzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38112654fd2fabaed896c829128fc690c9cba083-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWVQl-000000004PA-0BZJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Wipe auth token and
 PEM key copies before freeing them
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
Content-Type: multipart/mixed; boundary="===============8305298462954692406=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8305298462954692406==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Nz8xJcap/8="; charset=UTF-8

--3Nz8xJcap/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2206?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: Wipe auth token and =
PEM key copies before freeing them
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Wipe auth token and PEM key copies before freeing th=
em

generate_auth_token() freed the previous token and its intermediate cop=
ies
without wiping them, unlike wipe_auth_token()=2E crypto_pem_decode() in=
 the
mbed TLS backend freed its copy of the PEM key text the same way=2E

C=
hange-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
Signed-off-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206
Mess=
age-Id: <20261125213012=2E15799-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41971=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
auth_token=2Ec
M src/openvpn/crypto_mbedtls=2Ec
2 files changed, 9 insertio=
ns(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/06/2206/3

diff --git a/src/openvpn/auth_token=2Ec b/src/ope=
nvpn/auth_token=2Ec
index 261c7c2=2E=2Ed8e599b 100644
--- a/src/openvpn/aut=
h_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -271,10 +271,15 @@
     ASS=
ERT(buf_write(&session_token, b64output, strlen(b64output)));
     ASSERT(b=
uf_write_u8(&session_token, 0));
 
+    secure_memzero(b64output, strlen(b6=
4output));
     free(b64output);
 
     /* free the auth-token if defined, =
we will replace it with a new one */
-    free(multi->auth_token);
+    if =
(multi->auth_token)
+    {
+        secure_memzero(multi->auth_token, strle=
n(multi->auth_token));
+        free(multi->auth_token);
+    }
     multi-=
>auth_token =3D string_alloc((char *)BPTR(&session_token), NULL);
 
     dm=
sg(D_SHOW_KEYS, "Generated token for client: %s (%s)", multi->auth_token, u=
p->username);
@@ -288,6 +293,8 @@
         multi->auth_token_initial =3D st=
ring_alloc(multi->auth_token, NULL);
     }
 
+    buf_clear(&token);
+    =
buf_clear(&session_token);
     gc_free(&gc);
 }
 
diff --git a/src/openvpn=
/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index ceaaad4=2E=2E58c=
1fd2 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_m=
bedtls=2Ec
@@ -1150,6 +1150,7 @@
     }
 
     mbedtls_pem_free(&ctx);
+   =
 buf_clear(&input);
     gc_free(&gc);
     return ret;
 }

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d890=
7618925746
Gerrit-Change-Number: 2206
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--3Nz8xJcap/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2206?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Wipe auth token and PEM key copies before freeing them<br><br>generate_=
auth_token() freed the previous token and its intermediate copies<br>withou=
t wiping them, unlike wipe_auth_token()=2E crypto_pem_decode() in the<br>mb=
ed TLS backend freed its copy of the PEM key text the same way=2E<br><br>Ch=
ange-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2206<br>Message-Id: &lt;20261125213012=2E15799-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41971=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=2Ec<br>M src/op=
envpn/crypto_mbedtls=2Ec<br>2 files changed, 9 insertions(+), 1 deletion(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/06/2206/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token=2Ec=
 b/src/openvpn/auth_token=2Ec</span><br><span>index 261c7c2=2E=2Ed8e599b 10=
0644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b=
/src/openvpn/auth_token=2Ec</span><br><span>@@ -271,10 +271,15 @@</span><br=
><span>     ASSERT(buf_write(&amp;session_token, b64output, strlen(b64outpu=
t)));</span><br><span>     ASSERT(buf_write_u8(&amp;session_token, 0));</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ecure_memzero(b64output, strlen(b64output));</span><br><span>     free(b64o=
utput);</span><br><span> </span><br><span>     /* free the auth-token if de=
fined, we will replace it with a new one */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    free(multi-&gt;auth_token);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;auth_token)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        secure_memzero(multi-&gt;auth_token, =
strlen(multi-&gt;auth_token));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        free(multi-&gt;auth_token);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span>     multi-&gt;auth_token =
=3D string_alloc((char *)BPTR(&amp;session_token), NULL);</span><br><span> =
</span><br><span>     dmsg(D_SHOW_KEYS, &quot;Generated token for client: %=
s (%s)&quot;, multi-&gt;auth_token, up-&gt;username);</span><br><span>@@ -2=
88,6 +293,8 @@</span><br><span>         multi-&gt;auth_token_initial =3D st=
ring_alloc(multi-&gt;auth_token, NULL);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(=
&amp;token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_clear(&amp;session_token);</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/crypt=
o_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index ceaaad=
4=2E=2E58c1fd2 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -11=
50,6 +1150,7 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   mbedtls_pem_free(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_clear(&amp;input);</span><br><span>     gc_free(&amp;gc)=
;</span><br><span>     return ret;</span><br><span> }</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=
=3Demail">change 2206</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2206?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2206 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--3Nz8xJcap/8=--


--===============8305298462954692406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8305298462954692406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8305298462954692406==--

