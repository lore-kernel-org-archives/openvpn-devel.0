Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC06606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LohJ5soC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SYgpGa02;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VnZ1+Bvy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dIsL+I/t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j/XFoOUkXaZ2/XqveEsbttq4jiAyY0LSQ5XX982v4KI=; b=LohJ5soCapfdWkoc0SqbxELikV
	DR3Md3cLxurMzU9NIk20jYKjl5ccUvSlbk3aA1pvMbq5fuMRlQtjfaH9fYXepILUCOkjGlSnmgWhQ
	K3ckq1m73Hztw9gQJuR4psbgDR84ZZesCFgN126Go6A8B7zO4vnWGVD2bC8fggICqvR8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1sO-000000004a7-13MD;
	Mon, 16 Nov 2026 18:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1sM-000000004Zu-3r1s
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/LfqxnnfRGTaBmJKRsbW2D24XHT/4spiXyJOm5dwwIY=; b=SYgpGa02qDFzYjozOUmVTIaO6I
 eYLV457gHLRfFIubMJubhfN1nMfaqudKthFQry+W+ZXwgvadOAcmwwEwmBuZryo/1ZupFAjYQZtPY
 //tIT8E2fIfRL+ayKzp6ikbKebVArI+wiSkPsLQBSo3XDeueqnzVeYeKEG7UDKp2bGs4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/LfqxnnfRGTaBmJKRsbW2D24XHT/4spiXyJOm5dwwIY=; b=VnZ1+Bvy1De157pYWGVh4CuedL
 DOMl6t/M9v7/AozcI7nGADjz5hdeZldYksWYm4gbYGmO8tvc5TEdvRFcr4Ty7+kR+JmQpsYRUhltt
 AlALMmacYrAAxIWnIyYzb38Vd1LqJOXmt0+Pcw8NNBIiXuFmKYVFYvmdkcgi1vAsSRgE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1sL-000000003ju-3F1X for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:56:22 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so30285465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794855375; x=1795460175; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/LfqxnnfRGTaBmJKRsbW2D24XHT/4spiXyJOm5dwwIY=;
 b=dIsL+I/tt70Igpi0/2ZeSFLSYBVfQcYKCs8yFdX15UfQYf7eDOaA+TZCHHzd2Tibtz
 /9SeABVBXmVXcOwTjh0dvU6dH/mOjr0HAR6VrnTgYLKRcAuUdS9+pn5GlGDSRYFt+0kJ
 hwfvo1dXx+85apbpR3UidI7KBOkcIec4+W5dJXl5dt1xkz8biJ4Kn2HAzyQGHS5oTaPE
 wHWS+Yicmcc5ce0LIoDdW1uno9TjfqwQzIoT89xnOzf6gd55OjaVfBVhvPgy+yEgvVZL
 Xvwp6fc1v1ONJig6qdYfbY9seET2wZV9kKNzhbQnUb03qAlQD7f4TPGDhZnGl166qjsT
 L6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855375; x=1795460175;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/LfqxnnfRGTaBmJKRsbW2D24XHT/4spiXyJOm5dwwIY=;
 b=bFOiKxXvUczGqkXPXKtf8bZSW6gYSv1mSV2kRI/nCNtM47CzBlcMd5XqpT6sZGCpJ2
 N47MR+d6fwEcga7+3cp8tArbWfpoevvyB6uoTmSbPvcolV/osyqGe7rP2FKIiwT6PeLm
 hs1ji5oLN4ozz1dTypXj3qYCPpLrkXNwhmOgqZs+WkPrbNRFUbsWlMHN+KZ7Rtz3apUd
 mKd2Tn3ZkI6Z1JhD68uOX4shLLb0rFeIeYHqmvszorAnoHCOe3jJ6bjR/XNRtTC5Pg3i
 tdSFQA3shblUkB+ATco0+RIPs5aVJtoIg1ZzSlUK1IlgUTDLJ45QP8/HsEzeVo7cfh8H
 2EFg==
X-Forwarded-Encrypted: i=1;
 AL+hErHQevj1/QBwaY79vnFm2kpK7ScxSTEjVgiryVL3KOIMbFpdrskgmJm06ATareQ9n1kG66UIgcEan1M1Yf3P@lists.sourceforge.net
X-Gm-Message-State: APuU4Z81fHDktj8/E+FD6E73OtcMb70C/v0ewe7KDR30PNF9FH/bYYm0
 ER9lA4yZKe6tBhS/EKr2GEYFJmiZHESSEvVPqn8IhBaaWFcBjwuXXmm43HaNFhpW0ArsVwWekuO
 l5yz5tAyNl9zvg4BjLVKiLiW29aaDverc1GyKbeHr96vF/TRNfXadPdCh7bvKL1RGI83O
X-Gm-Gg: AYBFou3SgFnttNnH7yUPMCj/766wdyXavY1YdwxFcnMiP9EgFswzhkLVoO1Sz1ur+54
 izv2Otr0J5SqXSyy4iSUHjEhHZNEDTJslppxgN50fsKt/NMDrZW6cPbY8EKBZI9jPqCdaP/WMpc
 aNRAxYTRjYRgzWA9ulUEYSaU1g52P14NRHGID1XGjwFq3qd7Fjx2cvi410wggyf2Pf/kehUqd18
 rIHujZeqoBTK7/BX3rdXOUothji6j7O2mzYqPMibQI0CzuHTmzr4nAjgUyuNBmrzfoQCiczWbPy
 bkZopK1tUcbWy62bnnaUfP9ZV85KohFdqy9Hxu7pCNbtvTm5AisGsBPqu1De/Qr+pGItatR0POw
 CgAPmMUO1eYSdQI0GOC0rF1wZSaQUCa8ze4v6wsSf2fcoW2XnL10Ius0QLBV/AjhWjxFJRhVs5D
 nvX1zdfcr5Q5vXbmk3Ga9yugXju8DfX0luxSr0fKoYo4GM4JOX4j7wmsJYZHB2v9yh9lh5J7zA9
 hF8JB368eTw9JL2f4qoePaoUdfewX6Z13w5GBJ2tlw9peYVsoSNfva4Vc5iY2/O/HTl7gcOUdXF
 1ki8MXaC7mkzJ8wcrIRD3fVH+lHLX9LbqP2FR3x4RYGp5Ph1pcch/gFK4/lazUx2uOkrPPuaBhZ
 hUxhJfnvA+SOPM/yUIQmzvmfo1BxdntRJRMVAKY5eAdFbMdLWFmTEGJ88X0xgh+bnBoar70Our9
 DUSaYdDZZ2NK2LVcNDUIkqNRE7/sFVl+5X+f67
X-Received: by 2002:a05:600c:840c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb5599bda8mr255991275e9.0.1794855375041; 
 Mon, 16 Nov 2026 10:56:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8220sm7368255e9.5.2026.11.16.10.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:56:14 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:56:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
X-Gerrit-Change-Number: 2101
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2101?usp=email>
X-Gerrit-Commit: bbc14868ef99a16eda987396b890ec8df6427dcf
In-Reply-To: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
References: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjkzMDQ3MDAwLklkYjNjNTIxNzRlNTg4MDE2MjQwZTljOTE2MmExNjc2ZTE1MzFjNTUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f59428322a645a2d8cdbc6a7721cbc806b27c653-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1sL-000000003ju-3F1X
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: check
 ovpn_dco_nlmsg_create() result in new/get peer
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7816859464305902810=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7816859464305902810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hmZKihPnx+E="; charset=UTF-8

--hmZKihPnx+E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2101?usp=3Demail )

Change subject: dco_linux: check ovpn_dco_n=
lmsg_create() result in new/get peer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: check ovpn_dco_nlmsg_create() result i=
n new/get peer

dco_new_peer() and dco_get_peer() passed the result straigh=
t to
nla_nest_start() without checking for NULL=2E Return -ENOMEM like the
=
other callers=2E

dco_new_peer() unchecked since e34437c2 ("dco: introduce =
low-level code
for handling ovpn-dco in the Linux kernel"), dco_get_peer() =
since
5a8fb55a ("dco-linux: implement dco_get_peer_stats{, multi} API")=2E
=

Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
Signed-off-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2101
Me=
ssage-Id: <20261116102516=2E14493-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41409=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/dco_linux=2Ec
1 file changed, 11 insertions(+), 0 deletions(-)




diff -=
-git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 60107c4=
=2E=2E3a55b6e 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_=
linux=2Ec
@@ -239,6 +239,12 @@
     msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d=
, remote addr: %s", __func__, peerid, sd, remotestr);
 
     struct nl_msg =
*nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
+    if (!nl_msg=
)
+    {
+        gc_free(&gc);
+        return -ENOMEM;
+    }
+
     stru=
ct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret =3D -=
EMSGSIZE;
 
@@ -1234,6 +1240,11 @@
     msg(D_DCO_DEBUG | M_NOIPREFIX, "%s:=
 peer-id %d", __func__, peer_id);
 
     struct nl_msg *nl_msg =3D ovpn_dco=
_nlmsg_create(dco, OVPN_CMD_PEER_GET);
+    if (!nl_msg)
+    {
+        re=
turn -ENOMEM;
+    }
+
     struct nlattr *attr =3D nla_nest_start(nl_msg, =
OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2101?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
Gerrit-=
Change-Number: 2101
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--hmZKihPnx+E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2101?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dco_linux: check ovpn_dco_nlmsg_cr=
eate() result in new/get peer<br><br>dco_new_peer() and dco_get_peer() pass=
ed the result straight to<br>nla_nest_start() without checking for NULL=2E =
Return -ENOMEM like the<br>other callers=2E<br><br>dco_new_peer() unchecked=
 since e34437c2 (&quot;dco: introduce low-level code<br>for handling ovpn-d=
co in the Linux kernel&quot;), dco_get_peer() since<br>5a8fb55a (&quot;dco-=
linux: implement dco_get_peer_stats{, multi} API&quot;)=2E<br><br>Change-Id=
: Idb3c52174e588016240e9c9162a1676e1531c551<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2101<br>Message-Id: &lt;20261116102516=2E14493-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg41409=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linux=2Ec<br>1 file changed, 11=
 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dc=
o_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 60107c4=2E=2E=
3a55b6e 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><s=
pan>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -239,6 +239,12 @@</s=
pan><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d, remote add=
r: %s&quot;, __func__, peerid, sd, remotestr);</span><br><span> </span><br>=
<span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PE=
ER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl=
_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct nla=
ttr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>     int=
 ret =3D -EMSGSIZE;</span><br><span> </span><br><span>@@ -1234,6 +1240,11 @=
@</span><br><span>     msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %d&=
quot;, __func__, peer_id);</span><br><span> </span><br><span>     struct nl=
_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     struct nlattr *attr =3D nla_nest_sta=
rt(nl_msg, OVPN_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2101?usp=3Demail">change 2101</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2101?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Idb3c52174e588016240e9c9162a1676e1531c=
551 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2101 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--hmZKihPnx+E=--


--===============7816859464305902810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7816859464305902810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7816859464305902810==--

