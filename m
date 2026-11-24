Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFA606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YEsAYj0J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XkAezFE+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bQ1AO0eL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ffkcZQXi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Hs2Umf8b628dnDZiBOLHgC+ZZ7e14HkJS/y21SG2wE=; b=YEsAYj0J3QSLIOVdZYxr8Gkym4
	7suk6mFTltb9UbWJOIhYrDV1Mag9CaQQFvofkxiBdsyruPqrOZpfihIHysyV17W/m7pyDkun7YVtZ
	d8t3jZwjHdapiJtAYaXOLKbVJRJLH5XMsp5hs2tO3s8hhZuthSJ6fXMOdUdxsQWghFDc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVovz-000000003zC-27Ph;
	Tue, 24 Nov 2026 11:43:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVovy-000000003z4-0W2u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sXzwdRJNsUqb0aBa4x8SOx8Sa6Kckk5ZP6axt92UzRA=; b=XkAezFE+yO4JZnVqEIDob5M4//
 s7fSLXRlYeruIAPvwOh+D63gKEKcqtq51DTKUCYtZUgP/kBEJMn8a6ou8j9Hu7RUI3uNgWlq8aXu7
 xYd2r0njBVDrJQtzWt1ZYwGdAmowkqqyE5tpxYcXYcozW19/Uih8H+6niUpRvbgddw3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sXzwdRJNsUqb0aBa4x8SOx8Sa6Kckk5ZP6axt92UzRA=; b=bQ1AO0eLFt/q2xE4QBs2sO2344
 Yd6cfth+gW6bbSUqIOn+sDtLEwqYPjJgL5qDcjd73rAtzs0R0qvn48c7j91ybYe9jrUz1bOhHK4sO
 JiCgrDym7BPfhQDiOMxKj5ldCZYSHCXa0M5FY3XITKJhEYWHucLE+QBAoZEmt/gV5lrU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVovw-000000008TA-2roZ for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:38 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so37490185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795520610; x=1796125410; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sXzwdRJNsUqb0aBa4x8SOx8Sa6Kckk5ZP6axt92UzRA=;
 b=ffkcZQXiLqry6jYQMkxVEtBf1SwNknDqPXMNg2HwpWtJTRs5KagJMwM5OWwf5i0QGv
 ZBhAZC9LX/GIz7Wg8f9/xex87ZMLKWtp54OCmZhp1E33q/TA7M6xj09uQ9gERY3tGwFg
 GJ0JvEN+UKO+WotoyEmrs9m8wMGxEh9QrTomZ4EiRtPpM57iJ23XFAGZtjbOPaf0w4ij
 BFpKMbk1Lg8q/AF94OUWqVFlGeBhpzw0lmAXp89PhmgQlxqmwRybOFWEsls1SR8FKgLv
 jE6n+5CsTd6T4r8XgpdxWDDOVffgmMZoiVrun3Vd/m9aUjxUy7i/g7yr4NgHjR4vaf3x
 CltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520610; x=1796125410;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sXzwdRJNsUqb0aBa4x8SOx8Sa6Kckk5ZP6axt92UzRA=;
 b=f8cUbwG3UXMxwxPp0am3ldbfQ7P+iTDHIEpl1GxmWkhV1b/y5YB7+oHeVDsHjKfQ3Z
 4QL6gSvblXI0bN0cxJTdSVTHM6MzoOiIStvxCdJp1iAtWQoltyG2GE/6CZmzdaUx9RvT
 vJ3m9btjN/uYlw50ju7ub0W63WerRDOq9vB1kvohLcC5nYBjmXZn1B2G2eTuSeqisBgX
 WsLQ8XEPqJQuP3RfwfV2bBUir1P9x7SGyOQQQw0CGnpsUYB9u0r0ygNo4uL4hNS77IKX
 ahAclooPLQYdkbUqkoWeSl+W9dgXcUeiGoBifjYTm8boqe8qfynlfTpAs3KgN/QDgk33
 vbtw==
X-Forwarded-Encrypted: i=1;
 AL+hErFNTDRYrG63ekMwwfjvlCxkkbyk3JsbtF4oV5Vif/v6AdA1+ZuaFhJ543wscTNhTEbMHNt89NtIetz7EwZE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8hBBCXd63tXWhYF/3ubWVunUhl858fvBWCVoKkicdUTXqbH7Nl
 yw5D2T5aZHMxlOFr/wW4s42jdcFLQsUBhtThg0BFjLGVllAPLEXkhi8JO1FtaJiy1xm2OYp3iao
 xIRD3KFS7i+1cNr/tZf8yLejofb4sHNnSoaTjucTme6guo+AEmG0cPzb8Siyf+s0VmzF2
X-Gm-Gg: AZFdTZeV9HYaB9/woPeZois7fwexWhjE0Wx3y43SW36Y3Vktf5n3J5/83OSGzvHKx8Q
 ZLfTq+Rhma8QpdZFwTUwaE/8NT/F1B1Zqf1y/6g/EviBDb3dobLuR9twNzBhABZu5c/tvYfHrKM
 Idpzfw9DRtbqTaOQTjnCTNwj7O/h+jKCafIBp9oRq8wJ6uqKezXiEwriAA64vGYTXGz8r9+BiPg
 f8fulpGA/wtIw0jdJEz4TCbHWkimeiQmfVMYvFzudUqszF5JewUBBxgyxg/Y/vPQN75Ffi7dX+C
 kebLmQ/q1xkoL1XcrfpOLc7QU+smt190ENTMYanR9HMsOOIqG6OU37FfbK9myrHZUN4cslnVz8d
 k1t/W6jnGNu7vqlOLMQ9ZmOHlLOrpKWlDrJb3AnDH+2pG2vzD5fRcnXaA+cZaJWXcu67qTX1XFE
 fm81fIiVsoj0A0W7eppZHY+B/wOlGEEP8jWWAms+Evr7LzeVPeRqbnc9ICo5FBoyBgo22JmrPVI
 NrRYxa305pzKjuzjcv6PmhrjLPGtY0DTSw6yH2ek50XAeikAjY60Lx5MA7jRqilxp5M1DTBd61U
 YJojOAa4YN1cTEc7W2ubmdRR4WYq6Chz6/tFwIEmiWoz6Oo0dPM/nht2VJh3pi/sWAtc94EgUji
 +s91oxmt3YWfs93PNwuBsXEYN+FNoZMQuophm06clgKhadR5DsfSkUOZ5J0medfYSwNS3CaVvCG
 NmkiBULhWvi8Nhp+0=
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id
 5b1f17b1804b1-4bb8881a2bbmr263405785e9.17.1795520609938; 
 Tue, 24 Nov 2026 03:43:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm344554565e9.0.2026.11.24.03.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:43:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 11:43:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
X-Gerrit-Change-Number: 2240
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2240?usp=email>
X-Gerrit-Commit: f195766e8196bca6deccc1d157b4fb458aa4a399
In-Reply-To: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
References: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc5MjE4MDAwLkk3NGVjYTIzNjQ2NTE5MGFiNTVkYjI4OWI5OGU0MzI3NTdjNjFhNGEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f104272a6140627f947c03bad57e0004b92d5fb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVovw-000000008TA-2roZ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: drop duplicate
 remote address check in tls_pre_decrypt()
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8722468328299816697=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8722468328299816697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pVMk3wzgO6k="; charset=UTF-8

--pVMk3wzgO6k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2240?usp=3Demail )

Change subject: ssl: drop duplicate remote =
address check in tls_pre_decrypt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

ssl: drop duplicate remote address check in tls_pre_=
decrypt()

The existing-session branch already rejects a packet whose sourc=
e
doesn't match ks->remote_addr, and key_state_soft_reset() keeps that
addr=
ess, so the later check never fails=2E new_link is always false in
that bra=
nch=2E

Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@=
gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240
Me=
ssage-Id: <20261123103742=2E10589-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41806=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/ssl=2Ec
1 file changed, 1 insertion(+), 8 deletions(-)




diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index eb6b86f=2E=2Eca5958f 100644
=
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -4002,7 +4002,7 @@
 =
        /*
          * Verify remote IP address
          */
-        if (!=
new_link && !link_socket_actual_match(&ks->remote_addr, from))
+        if =
(!link_socket_actual_match(&ks->remote_addr, from))
         {
            =
 msg(D_TLS_ERRORS, "TLS Error: Received control packet from unexpected IP a=
ddr: %s",
                 print_link_socket_actual(from, &gc));
@@ -4104,1=
3 +4104,6 @@
         ks->remote_addr =3D *from;
         ++multi->n_sessio=
ns;
     }
-    else if (!link_socket_actual_match(&ks->remote_addr, from))=

-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: Existing sessio=
n control channel packet from unknown IP address: %s",
-            print_l=
ink_socket_actual(from, &gc));
-        goto error;
-    }
 
     /*
      =
* Should we do a retransmit of all unacknowledged packets in

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I74eca236465190ab55db289b98e432757=
c61a4a3
Gerrit-Change-Number: 2240
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--pVMk3wzgO6k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2240?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: drop duplicate remote address=
 check in tls_pre_decrypt()<br><br>The existing-session branch already reje=
cts a packet whose source<br>doesn&#39;t match ks-&gt;remote_addr, and key_=
state_soft_reset() keeps that<br>address, so the later check never fails=2E=
 new_link is always false in<br>that branch=2E<br><br>Change-Id: I74eca2364=
65190ab55db289b98e432757c61a4a3<br>Signed-off-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2240<br>Message=
-Id: &lt;20261123103742=2E10589-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4180=
6=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 1 insertion(+), 8 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=
</span><br><span>index eb6b86f=2E=2Eca5958f 100644</span><br><span>--- a/sr=
c/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span=
>@@ -4002,7 +4002,7 @@</span><br><span>         /*</span><br><span>        =
  * Verify remote IP address</span><br><span>          */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!new_link &amp;&amp; !link_=
socket_actual_match(&amp;ks-&gt;remote_addr, from))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!link_socket_actual_match(&am=
p;ks-&gt;remote_addr, from))</span><br><span>         {</span><br><span>   =
          msg(D_TLS_ERRORS, &quot;TLS Error: Received control packet from u=
nexpected IP addr: %s&quot;,</span><br><span>                 print_link_so=
cket_actual(from, &amp;gc));</span><br><span>@@ -4104,13 +4104,6 @@</span><=
br><span>         ks-&gt;remote_addr =3D *from;</span><br><span>         ++=
multi-&gt;n_sessions;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (!link_socket_actual_match(&amp;ks-&gt;r=
emote_addr, from))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_E=
RRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &qu=
ot;TLS Error: Existing session control channel packet from unknown IP addre=
ss: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        goto error;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     /*</span=
><br><span>      * Should we do a retransmit of all unacknowledged packets =
in</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2240?usp=3Demail">change 2240</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2240?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I74eca236465190ab55db289b98e432757=
c61a4a3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2240 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--pVMk3wzgO6k=--


--===============8722468328299816697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8722468328299816697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8722468328299816697==--

