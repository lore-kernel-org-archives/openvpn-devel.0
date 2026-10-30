Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F6606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K4Ksv9Oh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E8agbCAo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bLGS0GyC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TjbgKZKQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=c2jfDVc34zBLXDSxJnNnWwM/omQZgi+UnuchzsBArik=; b=K4Ksv9OhYk1u81Q+HIlmNbQfn+
	Dar1xya+PhsbKyUbDbABt6UOwfI/caVuYlNgef6/zHK5uEhlks+aV3AxI1+1rt4YCMPx4KlKyXv2T
	bkvdEqmOXCG+FM5BBs95UjEJPxJ+ooxri8YzbO1avQvLnBGYlgBOOX/QWrypH+euA40c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrTb-000000007KV-1ZFp;
	Fri, 30 Oct 2026 18:37:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrTZ-000000007KN-0dhr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uJXlfZ8iqG3wYDn/sizGRKXlp5ANXqW4ixpx4adc7vQ=; b=E8agbCAoegTHSby0zP07d7fO67
 tuvFydD6oVJTd4Qtdbc+Sc8zTkGc3PThYwM7tejuoNxSPrn0wSIwxGKN55vuQkAQMrCj3UgAnBhvN
 7aQw38YvEftlsRv4HGlETjoXyynyVV3QPwvJd1hRdWfIBSWWU5dAvaVbPgXL30soaF5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uJXlfZ8iqG3wYDn/sizGRKXlp5ANXqW4ixpx4adc7vQ=; b=bLGS0GyCWTKko0MAq6rIRmL0kW
 7kJ08MquOtIcx1b2qcZm4wc9V6S5DF977lLDcUdK2/g6Qeztrj2a4WnccP51dtdYITNyozxZoHgRg
 VZCmIke3Eb9tEglJoq/cpLAB7LwXe2fXjvisChqkb/f6bGa4vj1wyAJYwyhWHKKR9aXM=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrTW-000000001G1-1FGL for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:37:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so8516345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793385428; x=1793990228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uJXlfZ8iqG3wYDn/sizGRKXlp5ANXqW4ixpx4adc7vQ=;
 b=TjbgKZKQ1Oc4P6fuhiHH9MsYjcQLmsWXoTpaO49Z45A8a5WlwHnSQ7e2bEygC9WL7/
 Rnd+B49gknBbcOkn/euCk5vLcUIjc8OrUTJifC0pBvQEvVGWEpchLe1gMYf8AxYAvxOR
 1TAdKkTHAVdNQhn183XV1X0yMhDpIrWYCwvZp/s9lzpAcifXF4mg/dLOzaLAtNFFD2i1
 loo1xD8EIEGbItaKBhjcUtS2zQ2nOUINUeux/W9oPqo/gzqXrGSsjDeQuV/65pw31T43
 bptE8XylYg5ZQ3DugXFD93VENRIV1r4dSCJUL73a2TsMdh/hUQXeXw4hfZXghFwCphCT
 E89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385428; x=1793990228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uJXlfZ8iqG3wYDn/sizGRKXlp5ANXqW4ixpx4adc7vQ=;
 b=lOYNWLxg2x1aWO2j94B+SFvYx0vSovSIdOOBm39Sj4mGpY6Hs5wh6aRbqk/zxqAePJ
 +olvHNjjoStuIRucvMc6rPUoKQrGR795jRp/1sA77kNId0SL6vOc84qYOFqc3x4Qzqdc
 e6x9MZvqngXgmnwM8Wo1ZTjIns4uRtWL8TD3Ksy1K+5pWXNu3pQ6ga+nInkKHnvZHBHw
 eW4kyIdBS78P3IBFjbqbMIfIZtITw5wyW0Vn/FVG0jcpIS96ZjuiqB1tMB5Hs0NUAyfr
 FRjKuxjvi/gU2ctdbzGfmx/SMZ+j344I8WEjIYsrCcM7idA2NlP+HoQRjVAipq94qxXX
 VmYA==
X-Gm-Message-State: AFq9FYKX1XEc2ryWvcbGq6wG3LZ90uHH3+idli84oxIz9KZK798yS1Ay
 JN8oIfVVZxnncV0aNyQw8Kgt7icoUKwXvpbLQ3RelJMUitKjOlihpZ//sRVGkR4HoV05R/71h07
 6gpSyBf70cgOoUSi9zHU1dPEL9hF2Nz+/SdZRtVeLoLB7kW2QEyHy45kTlegcOYWEHS66
X-Gm-Gg: AYBFou2jwjVDrUtz0jO9No7FbbWzz9CKBSyhU1WsuoJLFCYs6oXbMOxIhbLDTKWjKoy
 espvgwRi4qg1ZFhjpkomF9b2iVUSsFPbkpb276G7BUeFRy+N8ITVQ6VDFpTudh1KPsp6S3DYvxd
 zl/4Uq0Kh0kq6ATwI1yPcPBThDRCaVgTeJrz1ArDCMx2YkkfS1xtbE3pnHmHGlUrZQe57VzxVRR
 qHei613kg/FiarPknPTBuvd9JvogVTIKow316+TL6spzEdsWjAVGZ0IgjjA2m1w6CNaDrNWGC/V
 nU87r/IGtZ+dwWEbpBv8i1oark8NQO9UXGKQAMM/ULRL55QySJyUCw3lsbDZeuF1uleDGNkfSqH
 nm91PfEBB9JOeTCZs60r9luSf6yD+W3GbuIEy8q8V1aw9QMh288qWg6ri1R+KeNIol0Ee7WUALW
 G7Izo0mMvQuk5pFkLJwQY/6lvTS9IBK5TuAKv9Ex41dWoj6x4kjahE7Ia3c5sIjj3qopbMjISRn
 7/bOolbibErOB+oZUdkRaGrE6Nl16S4er+ePzZTofDWwTTS0QgcZiQ1jAYApcwiK3bRo4nUS3U7
 rb2lbstvMvlAak0NU1+BWC+V1G/iCx3hCziYGUyXXLLv50eD5M14nO1eSiTp6dSog3LGFttYSfQ
 zoYZdQM3hYxyVa81iMwkn5UqftLdqOnomangc+TnuG6zDJETeomQsu6ZYAdW2zgCaAlE+UOU8+S
 deFWw/iUAdkg6nDIc=
X-Received: by 2002:a05:600c:46d1:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4ac18993780mr72328955e9.18.1793385427556; 
 Fri, 30 Oct 2026 11:37:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0b4df257sm42556415e9.4.2026.10.30.11.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:37:07 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:37:05 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
X-Gerrit-Change-Number: 2044
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2044?usp=email>
X-Gerrit-Commit: 2f76edfe75953313a1af503ae85c68409ec840e5
In-Reply-To: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
References: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkxYWJiMTA1MTU2NjVlMWQ2MzUxNjg5ZDJjMmRkOWQ0YWJhOGJiOThlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <054a0880e66ca52cdcffc38178a30b415fe59e4c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrTW-000000001G1-1FGL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop the
 read cases from multi_io_wait_lite()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0789908554423929888=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0789908554423929888==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r8KaC/Y/RF0="; charset=UTF-8

--r8KaC/Y/RF0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2044?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: multi_io: drop th=
e read cases from multi_io_wait_lite()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: drop the read cases from multi_io_wait_=
lite()

multi_io_action() only polls before writes: reads are dispatched wi=
th
poll false, both from the event loop and when chaining a tun read
after =
a write=2E The TA_TUN_READ and TA_SOCKET_READ cases of
multi_io_wait_lite()=
 are never reached=2E

Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e=

Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2044
Message-Id: <20261027124408=2E526-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40196=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/multi_io=2Ec
1 file changed, 0 insertions(+)=
, 12 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/44/2044/2

diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/=
multi_io=2Ec
index ac730b4=2E=2E56216d4 100644
--- a/src/openvpn/multi_io=
=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -235,18 +235,6 @@
 
     switch (act=
ion)
     {
-        case TA_TUN_READ:
-            looking_for =3D TUN_REA=
D;
-            tun_input_pending =3D NULL;
-            io_wait(c, IOW_REA=
D_TUN);
-            break;
-
-        case TA_SOCKET_READ:
-            lo=
oking_for =3D SOCKET_READ;
-            tun_input_pending =3D NULL;
-      =
      io_wait(c, IOW_READ_LINK);
-            break;
-
         case TA_TUN=
_WRITE:
             looking_for =3D TUN_WRITE;
             tun_input_pend=
ing =3D NULL;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2044?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
1abb10515665e1d6351689d2c2dd9d4aba8bb98e
Gerrit-Change-Number: 2044
Gerrit-=
PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--r8KaC/Y/RF0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2044?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi_io: drop the read cases from multi_io_wait_lite()<br><br>multi_i=
o_action() only polls before writes: reads are dispatched with<br>poll fals=
e, both from the event loop and when chaining a tun read<br>after a write=
=2E The TA_TUN_READ and TA_SOCKET_READ cases of<br>multi_io_wait_lite() are=
 never reached=2E<br><br>Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb9=
8e<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;=
<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044<br>Message-Id: &lt;20261027=
124408=2E526-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40196=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
n/multi_io=2Ec<br>1 file changed, 0 insertions(+), 12 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/44/2044/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/multi_io=2Ec b/src/open=
vpn/multi_io=2Ec</span><br><span>index ac730b4=2E=2E56216d4 100644</span><b=
r><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti_io=2Ec</span><br><span>@@ -235,18 +235,6 @@</span><br><span> </span><br=
><span>     switch (action)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D TUN_READ;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_input_pend=
ing =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    io_wait(c, IOW_READ_TUN);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_=
SOCKET_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   looking_for =3D SOCKET_READ;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            tun_input_pending =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_READ_LINK);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         case TA=
_TUN_WRITE:</span><br><span>             looking_for =3D TUN_WRITE;</span><=
br><span>             tun_input_pending =3D NULL;</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=3De=
mail">change 2044</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2044?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2044 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--r8KaC/Y/RF0=--


--===============0789908554423929888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0789908554423929888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0789908554423929888==--

