Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9839606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TIyz2TXP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fYfUh+jQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gXGxGPaw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cA6n9xCT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dc2XxzW/duNs4fSm3yaoIfDnqVxwjCdCD2xOtUVPhFA=; b=TIyz2TXPi5FmW2pN2qj+IUsjno
	5WXkIVEn8okRCmrzvwsOKn0riPmhfQ3418B+2sVT7lpAuJHrIpDyCLBZIrjr/uaYbAo9gFIoPK+w8
	BYvDV0ACf0LStGhSnj5u6rR7awefQtoPBm6gzaAUGQDEAxp7kKJ6vJ3hDbKvr09MAiSA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNDiD-000000005KO-0TiD;
	Sat, 31 Oct 2026 18:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNDiB-000000005KH-42tn
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zrhfEKCBsjuUhYafVlWreEZutJ5YWuCHvDZlvSrkK8s=; b=fYfUh+jQSLn2e+hFNErk9IxLPO
 pWZmdi1IY9WXNuzsF34wKnx1VxRAamglfRu2kY0RvhSQfNf4D/bMtCryOuMPwz13axv+YKqaAL+tL
 zFSzXFBGNkxybIoY3jap143zqObMxBiTxI485ilq+DOEds6BKJyzTIp+M1XMPCRMqwEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zrhfEKCBsjuUhYafVlWreEZutJ5YWuCHvDZlvSrkK8s=; b=gXGxGPawRuLdrMmsJzkktODX7K
 E/Q+rkVNfiiH5g2bNQrlLidhvjIrThsicVAhzDmKZNHZ3M/y37cbKivZchcDmZuUYnJN7VNvb7FkT
 kU3GAwIk8G/OXn6LuqxfviF6iOHgXGovubpt4a+Vc1kss0Q1YH4gQZKUpn/8cqH5tOFk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNDiA-0000000006E-2eHa for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:21:51 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1845726f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793470904; x=1794075704; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zrhfEKCBsjuUhYafVlWreEZutJ5YWuCHvDZlvSrkK8s=;
 b=cA6n9xCTl5b3Y/EMuvAe21pe2AeVsErD/OJgHwJZ0rnOTDqTjY/XtUFOvZrZkFHtYa
 vmRF14g5QI10r9tsXDt7gzybiVJobsQ1vJ5fTxGl8VuhV6gj+mUibgBFuCi2yb65v0bu
 PYiBxf0ggwMaxIrg491m2kiN/XKV70XU40HJIBS2r1GVYS+b+ZkqemYSyHveManZc+kz
 jCs8L1+c4whNmqucUw/F3KLzBvcDCBuvUi9KATwuBHcNCHn7jeda//4HuUmOKmuRklsq
 MGXlnChnE5kEfyCAuIFzdr9+ZqtqTvEbwIpCU3Jo+Otw+6NNR6VHm3k2JQtbDaPxF4CP
 DZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793470904; x=1794075704;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zrhfEKCBsjuUhYafVlWreEZutJ5YWuCHvDZlvSrkK8s=;
 b=AhQP/8kG1Y1PNusTVT8okBRgl0Sr8ZeqpxkdYAv6lx3i1fK1AvorUGgIy4l3YBQXsb
 SI+KQGjrcIIPMCjV9VsB5IHY5loixxT8pkZeVHI8UDiouU1glmnnuaGR1tqy5tzN0C7z
 qrBYN2F6XUT5Wen/eOLQDY1QJ/ca3FaPv8glMwLJcWwkjLcRwjQ+B2bpQAulwkJYFDb3
 NcdM8UZtXaUmAqRVlqu/Ej4SkWAvpcEGkM6FdbeEQLvYXfFCO+EBtWSRvNswSwfCeJer
 6Jze2yOBfc00i/aVSDvPHtw0GOfbK8dtaWcAh0XzHQCnQpiAzjwZfFPoJgo+Dhj4Y6kk
 JH4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRp7X5uIrpnfll7L8e0DCTeOTxBzOI2Y0DWCVCMVOt6wwkulBfgFRx5LdJTH+cLsisurvQwZMnd2hqjDqw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJoI0JEW30Vmu4KuIj7j8QPbIXJDlFi1A788uD4isXLJHpMYfNQ
 xP5cu8nUpWYFJHo1n63GdIofIsnW0TI8six/yxgBsDk7TCnOYq/jStinekXT1qQlBQP2LmZ5OPt
 I0Er2YtDHmXxWjwl43Cqv1VYSD+U/Z0kHhLQQ5rethgOHYJKFhxRVP1nPM9mZKvkM9mrR
X-Gm-Gg: AYBFou2V5l9fRGB3q3Sr0Ueo19rT6PRql7nS16kPvFzeqsuob9t7hx0R+nM9QEPQrXP
 go/pVQFAijNdZBUuhnrxyX1JjRsVqcjNlvv3PhivsuKK/6OJQCN3pDGkvXOzfjHl2BWBixG6yZC
 cgxD4N/c+4hnXUeNrRUsoUF3EwMyXsUIgPjgnM0+bNHSif3krfPxjzrihJvFokQuJ7O7AGq8/Rp
 cyoHBdKb6Ph2WyxdqJdDwPtJp48BKUZe0kjK8i1ybgG4leQrWAFB2kqQfMvwt8cIcU5ef31oWY4
 pZ53kf02sQeZXmJknIivvAxNp4alZpziMV7RtMqDwof/iPD03nKPBpn+a6MkTVBeB043O5m6XTn
 2Jqu6WC5d/kR5YuEuVK0dAfohUvWoC63CXF5rNl2HPGPi1Mz9uyr1g/ZPsZa3Kl58cASrJ0rNng
 PkksAJENHlRw4BeGBq3QkcDrtbFBIOQ+zlix0E2LX5At68sHquEuECFdpKmZzhAu/dyaT7/e5L6
 YU1gtUreO80Gh5ye9g2Q9eEFlHqywduiMKQNRp2xTBnC+Ez7czUK46JPz/q8k57rYrj+L/6SnZs
 dvU+dBhqJwNnDa44TyQfES+iB7lK8BD+S+1RQcLdQoDVQUIdhOUmSevy0ULPPMNqfAVjzbscpER
 vnSzJHirGHcJVDm4utASuT9ZKYDUBv0Dwl/YEUm8kujAjQYd7stvzRZAQ3H32c/U4y8FFIaGAQD
 IavnI5Ef4cuXKFmjk=
X-Received: by 2002:a05:6000:2610:b0:48c:571a:a1aa with SMTP id
 ffacd0b85a97d-48e6e303bf1mr12178324f8f.19.1793470903789; 
 Sat, 31 Oct 2026 11:21:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm10343462f8f.32.2026.10.31.11.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 11:21:43 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 18:21:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: b0b574c229bb0f4e68b909abda4ce63bf4ce293b
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84ab4563ba43f77e5b0b2f9dd040a2aab743843f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNDiA-0000000006E-2eHa
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Track number of
 assigned peer ids and use it for max-clients check
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9175583004644424104=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9175583004644424104==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hURtT2iL920="; charset=UTF-8

--hURtT2iL920=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2064?usp=3Demail )

Change subject: Track number of assigned pe=
er ids and use it for max-clients check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Track number of assigned peer ids and use it f=
or max-clients check

In the past we used the real address hash as proxy fo=
r the number
of connected clients=2E TCP connections do not really need
thi=
s and we might remove adding them to this hash map in the future=2E
UDP con=
nections only need to be added to this hash map in a later stage
of the con=
nection process and then only for peers that do not support
DATA_V2=2E

Ins=
tead have a simple counter that is kept up to date when a peer id
is assign=
ed and freed=2E This also allows this to be decoupled from
the real address=
es hash=2E

Reported-by: Ar-maan05 https://github=2Ecom/OpenVPN/openvpn/iss=
ues/1127
Github: Closes OpenVPN/openvpn#1127
Change-Id: Iad51b2f31e4215c58e=
160cc6239836015ea4d3cf
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2064
Message-Id: <20261028202838=2E14796-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg40261=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
2 f=
iles changed, 7 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index f211ef3=2E=2Eb69a209 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -621,6 +621,8 @@
       =
      {
                 m->max_peerid--;
             }
+
+            m->=
assigned_peer_ids--;
         }
 
         schedule_remove_entry(m->schedul=
e, (struct schedule_entry *)mi);
@@ -749,7 +751,7 @@
 
     mi->context=2Ec=
2=2Etls_multi->multi_state =3D CAS_NOT_CONNECTED;
 
-    if (hash_n_element=
s(m->hash) >=3D m->max_clients)
+    if (m->assigned_peer_ids >=3D m->max_c=
lients)
     {
         msg(D_MULTI_ERRORS,
             "MULTI: new incomi=
ng connection would exceed maximum number of clients (%u)",
@@ -4199,6 +420=
1,8 @@
     {
         m->max_peerid =3D mi->context=2Ec2=2Etls_multi->rx_p=
eer_id;
     }
+
+    m->assigned_peer_ids++;
 }
 
 /**
diff --git a/src/op=
envpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5aed191=2E=2E3d2e932 100644
-=
-- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -174,6 +174,8 @@
=
     uint32_t max_peerid;               /**< highest currently allocated pe=
er-id
                                         * and maximum allocated/vali=
d index in
                                         * instances */
+    uin=
t32_t assigned_peer_ids;        /**< Number of peer-ids that are
+         =
                               *   currently assigned */
     struct hash *=
hash;                 /**< VPN tunnel instances indexed by real
           =
                              *   address of the remote peer=2E */
     str=
uct hash *vhash;                /**< VPN tunnel instances indexed by

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad51b2f31e4215c58e160cc62=
39836015ea4d3cf
Gerrit-Change-Number: 2064
Gerrit-PatchSet: 3
Gerrit-Owner:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--hURtT2iL920=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Track number of assigned peer ids =
and use it for max-clients check<br><br>In the past we used the real addres=
s hash as proxy for the number<br>of connected clients=2E TCP connections d=
o not really need<br>this and we might remove adding them to this hash map =
in the future=2E<br>UDP connections only need to be added to this hash map =
in a later stage<br>of the connection process and then only for peers that =
do not support<br>DATA_V2=2E<br><br>Instead have a simple counter that is k=
ept up to date when a peer id<br>is assigned and freed=2E This also allows =
this to be decoupled from<br>the real addresses hash=2E<br><br>Reported-by:=
 Ar-maan05 https://github=2Ecom/OpenVPN/openvpn/issues/1127<br>Github: Clos=
es OpenVPN/openvpn#1127<br>Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4=
d3cf<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2064<br>Message-Id: &lt;20261028202838=2E1479=
6-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg40261=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec=
<br>M src/openvpn/multi=2Eh<br>2 files changed, 7 insertions(+), 1 deletion=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index f211ef3=2E=2Eb69a209 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -621,6 +621,8 @@</span><br><span>             {</span><br><span=
>                 m-&gt;max_peerid--;</span><br><span>             }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            m-&gt;assigned_peer_ids--;</span>=
<br><span>         }</span><br><span> </span><br><span>         schedule_re=
move_entry(m-&gt;schedule, (struct schedule_entry *)mi);</span><br><span>@@=
 -749,7 +751,7 @@</span><br><span> </span><br><span>     mi-&gt;context=2Ec=
2=2Etls_multi-&gt;multi_state =3D CAS_NOT_CONNECTED;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (hash_n_elements(m-=
&gt;hash) &gt;=3D m-&gt;max_clients)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (m-&gt;assigned_peer_ids &gt;=3D m-&gt;max_clients)=
</span><br><span>     {</span><br><span>         msg(D_MULTI_ERRORS,</span>=
<br><span>             &quot;MULTI: new incoming connection would exceed ma=
ximum number of clients (%u)&quot;,</span><br><span>@@ -4199,6 +4201,8 @@</=
span><br><span>     {</span><br><span>         m-&gt;max_peerid =3D mi-&gt;=
context=2Ec2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    m-&gt;assigned_peer_ids++;</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/ope=
nvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5aed191=2E=2E3=
d2e932 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+=
++ b/src/openvpn/multi=2Eh</span><br><span>@@ -174,6 +174,8 @@</span><br><s=
pan>     uint32_t max_peerid;               /**&lt; highest currently alloc=
ated peer-id</span><br><span>                                         * and=
 maximum allocated/valid index in</span><br><span>                         =
                * instances */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint32_t assigned_peer_ids;        /**&lt; Number of peer-id=
s that are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                               *   currently assigned */</span><br><span>  =
   struct hash *hash;                 /**&lt; VPN tunnel instances indexed =
by real</span><br><span>                                         *   addres=
s of the remote peer=2E */</span><br><span>     struct hash *vhash;        =
        /**&lt; VPN tunnel instances indexed by</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Dema=
il">change 2064</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2064?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2064 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--hURtT2iL920=--


--===============9175583004644424104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9175583004644424104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9175583004644424104==--

