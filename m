Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B0606A333
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SL/L4EDo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TEqUoO75;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D0a161pi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A0OCiImf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v7uViS2rYsghcFi/o4BBLBqifaDyyzXdGFJPNf6znTs=; b=SL/L4EDoHAXWT0HoPlNt67ojaj
	gFUQfHyfscFLq7HxkqySTCFChzqwsKs2Es66gYWOT/yRvz8ag24ehcmzhoZMTm3uUdusihj4F7ale
	iomoLkysiov6zcZHxOTaqxQGe3X8znEupVGeNeBM9pZZnhGV58rIQeaKIlzpSTQVt6nA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKGD-000000007g6-1Is5;
	Tue, 03 Nov 2026 19:33:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKGB-000000007fr-3EG7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bli66PsN3svmdHvgJ/mOg0Txu2AQRZllAMlOvlN/fQ0=; b=TEqUoO75u4z23zOURHpt6xszaC
 gFa/BLYG8NxOOHVbDr6EHkXkBgcJcDCbDPX9Sm1xiwE3URmxIWoRIT/K3wACBn2HTbKMSsSLLeK42
 ClLLt/TbUXMEtlYHDSaIK1+YEuqv+rH4Jbfdj1MYxpY6oIzlVlcWPytLVUH0PzYPz4jE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bli66PsN3svmdHvgJ/mOg0Txu2AQRZllAMlOvlN/fQ0=; b=D0a161pi9teN3UzXC/5+tAouMg
 8GOS4DiCGyuuYCGUJav/Xapnk70Dz+wDsN6AIbDVjC7m+NT7q2mVnqQaWzHEnDPfr78Bq+zahotqy
 UCki0OEKRXg2vp0DjulCrrAddVBKtwraTqPI+iDcE6OOrwhVTRU9EYw+srpJ/osgHyfs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKG8-000000004Xq-3xwH for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:33:31 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2813457f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734402; x=1794339202; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bli66PsN3svmdHvgJ/mOg0Txu2AQRZllAMlOvlN/fQ0=;
 b=A0OCiImfrLpcjUyK37Mv9jpgt9XLfaiahYbq3GgLHb4C50zRiDafwhJl8mZeE1D5X/
 ktgmG1h5GPdbFBNSyvHJVHqQsoRgFJPpq408Zy9Dk/fvWoxT0ekwruGhiHF/rrzqCu9H
 BQVK97YHOaHTnA84Jegz/z/cBuO8bLWENctODu9QENPSz2xhetcTmEVCyxRaxjxaRYqu
 qQOIc3meWcM3EL6Hk+t29+ruaDc9EWbHfVW3Ph4VYYlggr9fDXT6eQV9EVCH6ZZB6vkd
 +csS+cF9DFWa9vNqGLsu68s8ThwrAzw1PlARtZWwvyojx2xyic6nvyns0uG0ROEVEX0Q
 UXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734402; x=1794339202;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bli66PsN3svmdHvgJ/mOg0Txu2AQRZllAMlOvlN/fQ0=;
 b=HXCmdbgPtJJjXxpgHGQCQTQANmx1pR+p+G4wa+CW9huGXuJVxdFPUBJLPdOGQ9MViG
 ELNdzDGJfgvTmgMgx5qqEHGTSjQENIGydZQ5Wij+JZtCalMAZJOZuY5GG5HMwtnYpR4L
 xBpD80Dt0qgwOz+11fVRybCP4Y9BPDoXCRT47+DFnJK+wD6HairsKUcvwTGfczf8XQ1e
 Nm1Reu8b/nADNA/gwbcPSvR+TKW/kELHNih8VfBkg2IT7wI7yGOWhRv1VsSTfeNzjl6s
 K7TvIUOhUFEU5j4gbTZZCTk7OTOnBSYobmF9Psrlmk4qmiJRoTkxAR5fevq8B1Srtqqf
 inhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzj96BpyFPBRzSrYFsk3mqHmUEOnQNYd4HTvSLnIYSiPnun/ae+cYTdgAGszGjzH4dxSR5V5P3/yYL/oi/O@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8L+NeJAUogv/dJt+Hvq860HS+JYFPvLBilAMzL5zfdHF/sGFmG
 jKwVL7LKHuvayxt/yn0dwaVBs/hg5RcqCizXgOfXo2hzCKLKOlBR+juoE8ZlkqlbXPiZ4U337Qs
 6ouQFuf9jdC/2ykDZxBTAtcAzcwxI21kIwr82PSVIGpDqFyovf2MXqskm19s9O9cd1VJf
X-Gm-Gg: AYBFou1CmNu+dRae63G7Fol7MouSeYwFqV4lruAOgmMsfkGZEGvRI4uBDcQkBquw5qp
 QDycC6h2v0z4FvvrNzY4i4n9/TwSxN0BHYjTG/zOl/559jN5HNDirbtAJo+1oKrU0Nl2ClwNTzx
 qnC6ybi9bAqhhiXZKlBOhZt3JL5rBMwM0jL/nYS50evTaUyH1mq158eaT+kyx+baEIebemDwYKK
 9ESOS/5IvTmoJWCAL/qi0q+WFIElxzN7NPS3LbcyOahAZ6HqpPD41kBtFQL/Dpj4LRdLCR3g6QW
 opdgujlgwE7mZ97X5nmyYKjlEvXcz/HrfKI3UC/7+PdIhKIDFSRfPPRMAD/eVtTxWlvxJIoyap4
 Hq2/8Iv3NNb5DcsTykz3IpgLw9x57X+h9NQgQheFVmxhGnhb/796IsEjQYlIdn/uXlI/39vo8li
 hGPZ+/EW3C0fOsrHpRdJOvux+9HIm9Ya/gVqreapC4OFxahETISpqor945UatnZlmH99TacxEnz
 u2hHd8EKhCOvZ8ZT3TxhDCGrv2d9zesUh8iTHLtaV4dRCKAd2dWL/wlpNMgkdX+eUKTbZPKHWWR
 wv2DpZSc0EQFOci8NRACyYd79Ketth0Uqb6/podyQ17V1nlAb3vdymCyyW6Xl4ITb+GccT5dKmU
 AnBLgSBiGx8j0IWIOl0TffYucxKOBgG7TpvnKEDlCkUWDP2ukAM7YJfzIjQkFssbuImr/Y6GDfX
 fhfJrEDojtb0/S84fOtrKTon4RnO/0v3LdpZE=
X-Received: by 2002:a05:6000:25f4:b0:48d:e5c9:39a4 with SMTP id
 ffacd0b85a97d-48e6e308d87mr34975270f8f.33.1793734402217; 
 Tue, 03 Nov 2026 11:33:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcd03d736sm204164f8f.52.2026.11.03.11.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:33:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:33:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
X-Gerrit-Change-Number: 2083
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2083?usp=email>
X-Gerrit-Commit: e48597a63e7ba1d003f834cf3605b965d64a6e29
In-Reply-To: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NDc5MDAwLkllMGY5MDJhZTVhYThlNTQ5Zjc2ZjJjZjMyZmFjZGE0M2VhYzE4OTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f17c1bde95fb66d1adb1edb1ecb3d03057ea643-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKG8-000000004Xq-3xwH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: append
 cipher final output at buffer end
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
Content-Type: multipart/mixed; boundary="===============0701562691771148428=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0701562691771148428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R040+KZIBZs="; charset=UTF-8

--R040+KZIBZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2083?usp=3Demail )

Change subject: tls_crypt: append cipher fi=
nal output at buffer end
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

tls_crypt: append cipher final output at buffer end

tls_cryp=
t_wrap() and tls_crypt_unwrap() passed BPTR(dst) to
cipher_ctx_final(), whi=
ch would overwrite the start of dst if final
produced output=2E Use BEND(ds=
t), as the tls-crypt-v2 code does=2E
No functional change with AES-256-CTR,=
 whose final produces 0 bytes=2E

Change-Id: Ie0f902ae5aa8e549f76f2cf32facd=
a43eac18915
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2083
Message-Id: <20261102171317=2E113895-1-frank@l=
ichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40536=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/tls_crypt=2Ec
1 file changed, 2 insertion=
s(+), 2 deletions(-)




diff --git a/src/openvpn/tls_crypt=2Ec b/src/openv=
pn/tls_crypt=2Ec
index 447262c=2E=2E99e2411 100644
--- a/src/openvpn/tls_cr=
ypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -188,7 +188,7 @@
         int ou=
tlen =3D 0;
         ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &outl=
en, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_len(dst, outlen));
-  =
      ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen));
+        A=
SSERT(cipher_ctx_final(ctx->cipher, BEND(dst), &outlen));
         ASSERT(b=
uf_inc_len(dst, outlen));
     }
 
@@ -244,7 +244,7 @@
             CRYPT_E=
RROR("cipher update failed");
         }
         ASSERT(buf_inc_len(dst, o=
utlen));
-        if (!cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen))
+=
        if (!cipher_ctx_final(ctx->cipher, BEND(dst), &outlen))
         {
=
             CRYPT_ERROR("cipher final failed");
         }

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43ea=
c18915
Gerrit-Change-Number: 2083
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--R040+KZIBZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2083?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tls_crypt: append cipher final out=
put at buffer end<br><br>tls_crypt_wrap() and tls_crypt_unwrap() passed BPT=
R(dst) to<br>cipher_ctx_final(), which would overwrite the start of dst if =
final<br>produced output=2E Use BEND(dst), as the tls-crypt-v2 code does=2E=
<br>No functional change with AES-256-CTR, whose final produces 0 bytes=2E<=
br><br>Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2083<br>Message-Id: &lt;20261102171317=2E113895-1-frank@=
lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg40536=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<br>1 =
file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>inde=
x 447262c=2E=2E99e2411 100644</span><br><span>--- a/src/openvpn/tls_crypt=
=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -18=
8,7 +188,7 @@</span><br><span>         int outlen =3D 0;</span><br><span>  =
       ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(dst), &amp;outlen, CBP=
TR(src), BLEN(src)));</span><br><span>         ASSERT(buf_inc_len(dst, outl=
en));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(c=
ipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_final(ctx-&=
gt;cipher, BEND(dst), &amp;outlen));</span><br><span>         ASSERT(buf_in=
c_len(dst, outlen));</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -244,7 +244,7 @@</span><br><span>             CRYPT_ERROR(&quot;ciphe=
r update failed&quot;);</span><br><span>         }</span><br><span>        =
 ASSERT(buf_inc_len(dst, outlen));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!cipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;=
outlen))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!cipher_ctx_final(ctx-&gt;cipher, BEND(dst), &amp;outlen))</span><br><span=
>         {</span><br><span>             CRYPT_ERROR(&quot;cipher final fai=
led&quot;);</span><br><span>         }</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail">chang=
e 2083</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ie0f902ae5aa8e549f76f2cf32facda43eac18915 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2083 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--R040+KZIBZs=--


--===============0701562691771148428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0701562691771148428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0701562691771148428==--

