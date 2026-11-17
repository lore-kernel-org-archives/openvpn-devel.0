Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D9606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jloTm3AU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BnpqeDcP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g/kgnO7/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aIkUJFid
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TstVtOGPMxKR2xaRMhOLGM4d8+9roAPxZn8a2lyRHYE=; b=jloTm3AUgG3GMt0mSt4nmqCLbw
	9cTPRvckf/XPydeIo40ytaCMej0AY5eYFVjHyRO+y3leu2smTpjQx1SF9LWWgL2no2qWJyFiIsAgd
	I7yBd4vQtoMJiM9g/LWSbRUeYJue5Gd+U+mxthfe+6OI9ahwGS+sBx4t1Q7T4xTdR5wA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNKz-000000002di-1gV7;
	Tue, 17 Nov 2026 17:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNKy-000000002cQ-03uo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MmLkwd+ftGYjd+tTqHqXnvTolH+4c5vQN2SgIh9UfIk=; b=BnpqeDcPkG2nnWsJ3reywzIPnC
 pkuwEByRjT4d0mCM6H4ur7qEsa050HTDFDYSDfs2AwYHfQumOWAO23TdxlTBhIEEKp7Rf3cCWTZBa
 R5XJjyJ+UoNsg/B12lk2ptLXv8N/yVtHxO/tczXJ4QYXpzfEe7B1Rnr1v8jMs7fRovig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MmLkwd+ftGYjd+tTqHqXnvTolH+4c5vQN2SgIh9UfIk=; b=g/kgnO7/7PLlTMqQFsBigEnqDY
 Ppk9+oJa2Jf+zJBLJHKsbnX/UYh2a5TxrVOBmGtJrpIy8opod4xGkbD5gWRq2cboJBo7lnlSva8Ep
 opLBLP9n9W0WxkDfMpsMsCtje9KlUBxdZbn09B7agvYSu1pB4Y97/cbNLuvMpbC9iW5o=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNKj-000000005Cz-1zZL for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:51:06 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso2082f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794937859; x=1795542659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MmLkwd+ftGYjd+tTqHqXnvTolH+4c5vQN2SgIh9UfIk=;
 b=aIkUJFidO1aeC4WX4QK7gcZlhDx3p2a6PK9v2VDI+KyP6iKxtW4Cdx6p3vZobaEO8J
 ku4RSCtHbDACqb18Di6VuhvQfQTdCS9so4l6MWSV1fhkYPHHJfR2+/fqmfxiuSZiFQVb
 UPj/f4DkC7kEFpbH6ifajTcmMiHOp91awX3YqJkmoDfbZWA7a3tHzikuG1ZDGZZ23+cJ
 ADaSX5K1RIWFCpFu8zjxxdj/ItljYzV0iGFUArqP35cOkjA3iYekfIv0AWoqWUu5s4N5
 60UWGA7c5jI6CyX7boHDSqjS7DaAmMaku7DEm3n63JRYS2PHn18aVU7G0aQMIRIpEFwC
 +P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937859; x=1795542659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MmLkwd+ftGYjd+tTqHqXnvTolH+4c5vQN2SgIh9UfIk=;
 b=GZdUUIuQM/O7f+P786bYnHRRi25YIR5JJI079MOvcxZTeWcnpS2narShCgcoYyvVo4
 Kp16p3CI+t+kkjWLN6pJ/xZSLgDHt2uicTa1D2U/yuAoqGSwKw3ZhZC4qWpVub8GCpn7
 gkIN790Yj+Ehm9z1xUgZdm/mRGUmFlaE7kPpIytXH3hddQxPDunGJ9WWLKmhs5rnDAyf
 WCFBkxx7nypDcBw7yaWRHb/F/Y2aPKwNX5zEn+HXRIE5sD4b+QVmnibI0PWJOEvEtxqm
 oBxCJYl9qyQovMs12+X4s2U0+nMzvrZxnlD/1qPl3TwJzArM5piX0JB/hg9HN9o6iu3n
 xTOg==
X-Gm-Message-State: APuU4Z+anALw595ukhz92LECK+Wh9r+D1drFqFXGncVXZ2RsTuZjTqUM
 SrVIpNQn5anI8kylgyYrHMRILmyFRpd6cAc5CIuGrMPBpdCNNhrk/sX6AbCdMKVwhMMMdRVcaE1
 uwF+AXqLLYkWiTMW7fBAgAYhxHla5pnLkVAKfBEs7KT4fmfNBoJ9OmZpLAIbPXOWJdLtQ
X-Gm-Gg: AZFdTZcqwK2IgUxIG/NXrw4TpM0xp+U1DaPgWcNAhh5UhUCiVFDJQEWIH6thXPQaIWE
 uSH8569Q5JdqhsRzioYavtUgfg6qML1MKWfC+bs2+w4+RNdr9igAtRAWQPZaMwNmiFdod64Gtnx
 C30uv9P5epLf/0XcJQ+s/pXawveyfefa3/NmTI6R22Q/rilv2ZRLYND2/TK6Q6ow9CUL+bRX0ru
 2wh7HwnSiwAztMw+fo8ibadapKl8k0U/Pg4tSnksGAbpmsyEhYPStcMzifgbXH51XF/mDlo+ebO
 Ic9+2wG0+DXU4789vth72w0vvDaFxwSXowz5IZC4BjkmlC/rlvAaude6990+EzpiejvSu5iQR3o
 8wiOkG5dnnq4fqGMxxpnNsmJhpwZifR0iSWvV3myU/pJXYWUZf73gxnJG9go1nTfyibIE5tZrBO
 h3ZCU1qEaiSV6gF7h3PzPNlgv0qmvnhdmwXdcZnOAStVyrFZtzZ6q/dXAsEKOKAuANhiMrRptSD
 fdmBNh8UMyKIoibSUe2W39aLBf7s76K1eRMKLAj6GgkkWYqjuqaArqe4LdrcJpCqZDo3933Wgpb
 vPbrrc98dtNLtrAYztxx0Jct2h+lox92s7Qrk6vNsWn3TMOXP6hCWc9cxP9kkoSFfCpYLL2TtJU
 piwYHcOCtREgo780Yrm9OoO0SFgXe36LsT4Sh6VwNnwTbeXSYvXJZtu72/FgrxUMyRrPRDmuY5g
 u4fW6YGXA+l+KlsmM=
X-Received: by 2002:a05:6000:402a:b0:491:4e13:fde5 with SMTP id
 ffacd0b85a97d-4a6332bb023mr513683f8f.8.1794937858715; 
 Tue, 17 Nov 2026 09:50:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655db6d45sm9681f8f.33.2026.11.17.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:50:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:50:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
X-Gerrit-Change-Number: 2202
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2202?usp=email>
X-Gerrit-Commit: 18483720191ddd0420de73ca7454296977a28808
In-Reply-To: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
References: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODUzNTA3MDAwLkkzODhhNTJkMTk2MzNkMDYwNGExNjEwZmJmYmEzMWNmZmY3ZjUxOGVmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <038a2a909e1955f7dae2ce3a5c0ad9ad42257cba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNKj-000000005Cz-1zZL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: drop unused
 addr parameter of do_pre_decrypt_check()
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
Content-Type: multipart/mixed; boundary="===============0580806805251899228=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0580806805251899228==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sYnp0IiqrJE="; charset=UTF-8

--sYnp0IiqrJE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2202?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Frank Lichtenheld


Chang=
e subject: mudp: drop unused addr parameter of do_pre_decrypt_check()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp: drop unuse=
d addr parameter of do_pre_decrypt_check()

It was passed by value on every=
 connection attempt and never read=2E

Change-Id: I388a52d19633d0604a1610fb=
fba31cfff7f518ef
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ack=
ed-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2202
Message-Id: <20261117123402=2E12520-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg41526=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/mudp=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2202=
/3

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217b299=
=2E=2E0e1e21d 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -113,7 +113,7 @@
 /** Returns a verdict if this packet should create a n=
ew session */
 static enum pre_decrypt_verdict
 do_pre_decrypt_check(struct=
 multi_context *m, struct tls_pre_decrypt_state *state,
-                  =
   struct mroute_addr addr, struct link_socket *sock)
+                    =
 struct link_socket *sock)
 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalone=
);
 
@@ -259,7 +259,7 @@
     struct tls_pre_decrypt_state state =3D { 0 };=

     struct multi_instance *mi =3D NULL;
 
-    enum pre_decrypt_verdict v=
erdict =3D do_pre_decrypt_check(m, &state, *real, sock);
+    enum pre_decr=
ypt_verdict verdict =3D do_pre_decrypt_check(m, &state, sock);
 
     if (v=
erdict !=3D PRE_DECRYPT_NO_ACTION)
     {

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
Gerrit=
-Change-Number: 2202
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--sYnp0IiqrJE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2202?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Fr=
ank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mudp: drop unused addr parameter of do_pre=
_decrypt_check()<br><br>It was passed by value on every connection attempt =
and never read=2E<br><br>Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518=
ef<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked=
-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2202<br>Message-Id: &lt;20261117123402=2E12520-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41526=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>1 f=
ile changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/2202/3</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><sp=
an>index 217b299=2E=2E0e1e21d 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -113,7 +=
113,7 @@</span><br><span> /** Returns a verdict if this packet should creat=
e a new session */</span><br><span> static enum pre_decrypt_verdict</span><=
br><span> do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decr=
ypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 struct mroute_addr addr, struct link_socket *sock)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     struct=
 link_socket *sock)</span><br><span> {</span><br><span>     ASSERT(m-&gt;to=
p=2Ec2=2Etls_auth_standalone);</span><br><span> </span><br><span>@@ -259,7 =
+259,7 @@</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 }=
;</span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    enum pre_decrypt=
_verdict verdict =3D do_pre_decrypt_check(m, &amp;state, *real, sock);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum pre_decrypt_ver=
dict verdict =3D do_pre_decrypt_check(m, &amp;state, sock);</span><br><span=
> </span><br><span>     if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><=
span>     {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2202?usp=3Demail">change 2202</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I388a52d19633d0604=
a1610fbfba31cfff7f518ef </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2202 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--sYnp0IiqrJE=--


--===============0580806805251899228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0580806805251899228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0580806805251899228==--

