Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A0606A330
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dnwZQFN1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xp8bAS4N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IBNm/VxY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eoML9Kny
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+Sp+f4aje0P8BlxgYsWw494fw5NBE8ysj2x8Ulqc1fs=; b=dnwZQFN1V9/4Zxk40AzdN3lX9Z
	ih5/6ew/DfQXyOcFosf3XqoKzKhl/DBeSe9E8BAAv7dfM3Xup4Mqqo0ZMa6qt+941b9IHdZ8DYtlt
	AStKK4JwcJIZqN/YPKKPo1FmRAa3mgDHGkQJXD/2KqTnXxJTPl6fY9USSjZ32Yl+Lric=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRo0d-000000001Z6-0ZO5;
	Fri, 13 Nov 2026 09:55:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRo0J-000000001Yl-2wOx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QwrP1LVP0dWhoObhuohJjpy/iqd3r3N5tHaRroSnV1A=; b=Xp8bAS4N5jDntgq9OceqtsvA3m
 C5QALJCWmBG61gYQbshuJOj9vl4Y/f1xR5VAmb0TMGCNo5z3c6q4H5ybeaOpSUGq61po+c7yV/+QG
 VpCXHBxVOdPxDsetPzxmoaCkd2+yoWlDhuRLi2BJlD3F3Ud8F7NtJex0SqvkBArhjhBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QwrP1LVP0dWhoObhuohJjpy/iqd3r3N5tHaRroSnV1A=; b=IBNm/VxY9fEEA2OAxqe1XEebOZ
 KHqjV7FWXU3vWHwlsifxp+m5QYv0cRATkQqulmMv8/BMqgoh3zZFLeyDjB4YoWNHyyMnv+Dmqz5nR
 eqwJ4xFEwI0Tgw8nU7ykRYXgifjX2iLbukquv7BMey2Q65KR3tgSJ8rkFYHiSQw0MggY=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRo0F-000000005Pa-2Yf0 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:55:29 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so261101f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794563721; x=1795168521; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QwrP1LVP0dWhoObhuohJjpy/iqd3r3N5tHaRroSnV1A=;
 b=eoML9Knyji7srzJUUy2QZ/6kIqFcvpwK5jxDPLGPHm40HuoRcsMvW/K29rmkjRLA5Y
 SSIrgWzAcfmA0lMSGrzlEU46wbVzMXPUyp6Qbxl//6y4JJj+ZIktDFxsfhCB2vZrCf4R
 XJgHVzhu2smknZAOn4l65uRlexgqSKxA4/rmIwbh2/UOXfbwYCRgCyfarn0YNOHCqS3S
 NE19ORE8i2vQk73ekwtZJRWYN30M8ly2GMKbY8+YxX0kejS7Wb1M5Yqn8P5Cs/YLpEDb
 tiT6WB4EcE038ilbxM1j9bJvLJKqUAaHpzj32ezwvkE1LM3HJJ7kLyZqdl2MbF36EbEE
 YbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794563721; x=1795168521;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QwrP1LVP0dWhoObhuohJjpy/iqd3r3N5tHaRroSnV1A=;
 b=aR80hoOUPQu9PdTVV/ov+9fKMsXlIvgyyiMN6tE03wdOIzIvVfgUjuWEtN3cISGZ6U
 wnPS4WWC8KEnYrMvnI2hZbj6S4ut8Pzs9Gp1OXkB/sSbqqp2FVxT0nnSlE9+0njQOsLe
 apGfCAhjk+dS+lo61dbjV9sK2U9/uhAWH3JqjKcrzTvWW4sWP73tH/+soIhC+0kFfPdg
 4sGzz624Jq4QWyw9j6lx+yYHj5xIQAd3L9qQRC3XSRNEsTI16Jzi4s6v93AUXtJ7ZIF6
 x+Zqw0rtFeE9x3n2xRp7UFDlEH4ah0yYtgc9sSDAuIyNEc9RG0gslZ2R2Ey0SLfRDQz/
 7gWg==
X-Gm-Message-State: APuU4Z+msk3yrjUSaKSJV7yA0ceTwIhg7jIUPu8r21UC1WxV7uGcrv8h
 dwKqPnw1ud/oacUINQYTZz+46xCabxaMbac1sAGbjNOhh8surP1oBmTv2Nn7bocUDaHAJf1mp9/
 V9DMI29SYMfmLw4AX/vFJogpT++AkKFIKRS5Rf5q5PuFgogPNVEWkNAMRMgUM7MbTP9lm
X-Gm-Gg: AYBFou36INRTL9WJB2trMD5z4bms3bAnhQtwy+9WbzOBd6ksKERfEFOL9ppyJuLGg3u
 GnzoeMEv3Mj2o/zMyVjj+gK1w1FBrnn93DD37ZXnZBdB0X1dHWSBkvWGj5cLgYIEe12/gAbqIXu
 /LlKFa/TsMN353gjAeeuT3nHtYodfXHLMR2USgtuANTVyv0dIJuZ2ASHZvwJBMdk6IutMZFkbsZ
 a4hRLJj3h+wxwZFp0pUEvgKhTcYEoHE3lThEUyUEqzREUyND2eGjgNMjCmnHRWftua9Ex7Fa2Yo
 yGJ4MYDr4o94xYKYQq2I+dSNrqLsxM6CePyPwOsFlB+WdYApJRdLnR6r8Narf4u/sesQPmXwNrO
 DD4/DJ99jQ+cPjpffP9OT+Ok1PuYDfEYz3k01cPqVUKBkVVrSXXxfeZ28OShsDu4A4ppSwLfQ3r
 tCsoE807LDiVjDDTQpeQy/o90In6DdPpbQHXciVRnIdfUd1ouatrVNVEzHXfKAbqEsqxZPl1JxE
 UwOMcIjf+ogYAYPfbJc0iVt7dHHpKG6Iat+GHMoBa5qUMeMsx42lzKAdoGaoFvb+VtWMBS5XF+H
 FM/uZK2P/J1fI8VwKE75A0ERCNpFpZjcFkGz8zPdXcPbd/ZOPr/tUgP9zWX8sgSlnHI0wj0PEQf
 wiRnk4N2JMHM/39hie+BzRPgdyX/98HH9bUw09UqCx1f6lYXkUTxX+z6oMEjckDUJ6tvZYuMoBg
 Y89WPuFJLh9a85nypK
X-Received: by 2002:a05:6000:1a8f:b0:491:3fdd:af37 with SMTP id
 ffacd0b85a97d-49c71d490famr4411531f8f.28.1794563720874; 
 Fri, 13 Nov 2026 01:55:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c651esm4274699f8f.47.2026.11.13.01.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:55:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 09:55:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Max Fillinger <max@max-fillinger.net>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
X-Gerrit-Change-Number: 2152
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2152?usp=email>
X-Gerrit-Commit: 11da41d10b9a772df0dec1862e25f3e303a56ce0
In-Reply-To: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
References: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY3NTA2MDAwLkliYzllYjE1NzE0ZjE0YTlmNDkzNjZmYzg0MDcyMDg3ZmMzZjAxM2M5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1bc597608ae7f78b72c0e231ec6297bbb4909f8a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRo0F-000000005Pa-2Yf0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: reject
 an empty certificate fingerprint
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8827374470494937456=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8827374470494937456==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ESIQGD9ZRfE="; charset=UTF-8

--ESIQGD9ZRfE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2152?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Steffan Karger


Change subject: ssl_verify: reject an e=
mpty certificate fingerprint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_verify: reject an empty certificate fingerprint

verif=
y_cert() compares the configured hashes over the length of the
computed fin=
gerprint=2E With mbedTLS built without SHA-1 the SHA-1
fingerprint is empty=
, so the zero-length compare matched the first
entry and --verify-hash <has=
h> SHA1 accepted any CA certificate at
depth 1=2E Reject an empty fingerpri=
nt instead=2E

The compare length has come from the computed fingerprint si=
nce
2193d7c0 ("crypto: Enable SHA256 fingerprint checking in --verify-hash"=
)=2E

Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Steffan Karger <steffan@ka=
rger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152
Mess=
age-Id: <20261110143703=2E15137-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41110=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
ssl_verify=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/2152/2

diff --=
git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1e=
=2E=2Ea5b57a5 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -697,6 +697,13 @@
                 goto cleanup;
         }
=
 
+        if (BLEN(&cert_fp) =3D=3D 0)
+        {
+            msg(D_TLS_E=
RRORS, "TLS Error: cannot compute the certificate fingerprint for "
+      =
                        "--verify-hash/--peer-fingerprint");
+            g=
oto cleanup;
+        }
+
         const struct verify_hash_list *current_h=
ash =3D opt->verify_hash;
 
         while (current_hash)

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087=
fc3f013c9
Gerrit-Change-Number: 2152
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Max Fillinger <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--ESIQGD9ZRfE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2152?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">s=
sl_verify: reject an empty certificate fingerprint<br><br>verify_cert() com=
pares the configured hashes over the length of the<br>computed fingerprint=
=2E With mbedTLS built without SHA-1 the SHA-1<br>fingerprint is empty, so =
the zero-length compare matched the first<br>entry and --verify-hash &lt;ha=
sh&gt; SHA1 accepted any CA certificate at<br>depth 1=2E Reject an empty fi=
ngerprint instead=2E<br><br>The compare length has come from the computed f=
ingerprint since<br>2193d7c0 (&quot;crypto: Enable SHA256 fingerprint check=
ing in --verify-hash&quot;)=2E<br><br>Change-Id: Ibc9eb15714f14a9f49366fc84=
072087fc3f013c9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152<br>Message-Id: &lt;2026111=
0143703=2E15137-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41110=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpn/ssl_verify=2Ec<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/52/2152/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>index 0cdec1e=2E=2Ea5b57a5 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_verify=2Ec</span><br><span>@@ -697,6 +697,13 @@</span><br><span=
>                 goto cleanup;</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(&=
amp;cert_fp) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_TLS_ERRORS, &quot;TLS Error: cannot compute the certificate fing=
erprint for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                             &quot;--verify-hash/--peer-fingerprint&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto cl=
eanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
   const struct verify_hash_list *current_hash =3D opt-&gt;verify_hash;</sp=
an><br><span> </span><br><span>         while (current_hash)</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
152?usp=3Demail">change 2152</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2152?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2152 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Max Fi=
llinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ESIQGD9ZRfE=--


--===============8827374470494937456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8827374470494937456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8827374470494937456==--

