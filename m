Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB7606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OHVifYUH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hx8ogQ7T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kdxzgvMU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KZhxILFm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fn4SabSvYfqnU0VOIMGuRmvwzx8/Y5aN5q5CK16clMk=; b=OHVifYUHxYF27u9zevSa/80+X4
	IG57LxOcPnA/o+ILGDmq7klqC9E0Veac8Nqc/BBlOoeZxjVc9gKqhfEhpoH7PuhjPv9s+/Kq/MiM+
	pzPRz4CP6roKiYotDdmcb4bhw7FOcE09X9MFRfrhkZ1WK0pgKHqEgISBK9/M2VoInLII=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNDiE-000000004Fy-1KuX;
	Sat, 31 Oct 2026 18:21:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNDiB-000000004Fq-443g
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+KsBDMc6smx5B1nPmCxNXr+uwjbf5uSCy2s4JYO/duA=; b=Hx8ogQ7TloitFwmyL3fB9h1mre
 o3GzouHODyrcOksOys58f9ztwwLrFBL9JWDuDorOOEQ+Qt2TK+v1K2xKmwvo4Rq2iQu5DlE4wrx0L
 8/25Y1TGMDq+t6DZreyXh6zhrvMSbB6dVlLqWX19guVTaVghgqWgap4e9AlAmj0v2naY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+KsBDMc6smx5B1nPmCxNXr+uwjbf5uSCy2s4JYO/duA=; b=kdxzgvMUHD8vfbIN9IGTeENMWr
 Phx29uhz0wdg5UlFpy4fxMqQa6GBEGnaxTtZ7pYzlnCEmI9e82Fy7fnqm71rMF4MlZ0mm2OhYHpaJ
 g8pEgPAd+1xwSaqv0/vJPxi706plERIYihNT+neW7j/T4xKwc2T6aaIm+Atf17V+azTs=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNDiA-000000005o8-0NYu for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 18:21:51 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1460554f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793470903; x=1794075703; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+KsBDMc6smx5B1nPmCxNXr+uwjbf5uSCy2s4JYO/duA=;
 b=KZhxILFmWJN6DrRWyJlo4s5qd/6rNvMc+Wn4fjJGLttBn+02qAIViAdxlF/6YuJHIu
 QbI+dnXthKnCkQHMn8gfr5Mm76duiqSAhOdUNkTLbGxQLEJ1zpfZUUJgMoTpgcNRGox9
 eNApZ/LPrO8JnmMKFRHYfMKvaW3Y/ka8SITLrM0M+vvnjYProdee48+rNP6oYdb3BeFY
 s1lBuiwOxoM05X8xyzG7ysv8ZBgOtGwjTgdaBZlTDh5/JApixb9p+V6qpyka49hrEtdK
 8JsvHYexMuttBvNgflmpc2DtkmscSmZJUA0jl29xRSUSR++wzXgYaegl44FuiW5eW5Lw
 DAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793470903; x=1794075703;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+KsBDMc6smx5B1nPmCxNXr+uwjbf5uSCy2s4JYO/duA=;
 b=FAK8jeWX07lt1cm3/CC7eeBdpxyBoyEK3PHIxOurxZjqkglClVlRlr6/byBFuAfAvG
 /WoQcUrazezbxhuhZ8KaA9AAuGspn2yX518ckKpIAn635q5bWVAn6eeaBbfoxgteeUVs
 Y7JxFHlznWcJf3RNl7X8ikcFQLNDp0yxqquT3w4v9KSGCaGbT8DCxbYyXZ1AL1zQhj5U
 rsp7MjDNkyj90ktwB/2rPgKDM++njCkE4haA8T4ZGJykTfPYoYbiflVLLuLteeLE0PSr
 003qeN6emlAvo4zisd1hfWvn9V6Nn3cVBne2jYuidFeFOX5rQ4NA72vm1ifRN0cN/j7+
 inkQ==
X-Gm-Message-State: AFq9FYKdSD7eZGsnwttFQBZ/UoTLq+PtpzxgxqUkBC0/s/7E5JlUKi9g
 nJqOfPiTI9q4d58KoWItmWu5aembXUDhOE5qCkO1SECUwcrGj1bI9TGn3aEaDgjrMISF3wACQ8r
 jZ5lbn4bHiUTLDvM6aeRTqKRF4h/C2HmxqR+bLDQ3WcRD4gdwCdhbtRrMlnzroklrTbl1
X-Gm-Gg: AYBFou2moDGrlmAEpokabQywpoQppd+u3BzKnfjuB/8CBgO2w0578uHAyrrVmXtRCAv
 yNjl61K0qbGToFkOm1L7j18WmOE3xxFeIQgV4XM46tBocVmtmOufJ4lnk2L29sn7R0EgiaIZtq7
 6eV36gT0ThBIiIWHzkGGQH5+HrIrRdnhiXDPj9w34FY/5yWrzbuHSYjGWy95f53ZO5tOYFD31gR
 ya9Uns7/q5dINZ4l41W/5v5wggsZW1zKXvdAEcKk/Dd6+mVH11EC4Tqh5F7yytaM6ZglypPYz+z
 oulvZJnDNgAwmXq9WODnZlgE9HvA59HEoOEBNB+UYQ4nZBtaOZj3vTwx22yBsgFJU9n8AXpvlD3
 qjxmvId/HcZPaRlhhkLX1MEI3r8BMMJTDMLIG4uKIeG7FcXkK84rowafuswTuGao1qJvnxarAwr
 B3JFeTqFllt/xw4MOaw4jby5hgZclZ7C4WcsEjowO0vY5fu3Jp74bdsn7uofHF2ipYPXh+d6Qkp
 hVuSNGm1Mzg1pZFpo+XkU0s4MJHeG1IQu/+VhuZTPUtf1DdUHoBAholfbLrMfFNXocgZepBK3wE
 0wAMn6fYmUlU6n98U7J+SpooCVzgrogBcnb+RBfkCpDs0ioEvUVoX51HNRwsQt5VwlUgsdkT8VF
 jEHtC3IkA3LvkjUgdxDyHkRmQJzY/u9oEoPmiUUowDB28Im1N0r0y8keJdbXVtMdbjd1uq6RvTM
 ZXa8/Efu8YdR6IZaVq
X-Received: by 2002:a05:6000:188f:b0:487:1575:ebe2 with SMTP id
 ffacd0b85a97d-48e6e3024e7mr12907617f8f.44.1793470902894; 
 Sat, 31 Oct 2026 11:21:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8c0b6sm9480792f8f.41.2026.10.31.11.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 11:21:42 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 18:21:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: b0b574c229bb0f4e68b909abda4ce63bf4ce293b
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84ab4563ba43f77e5b0b2f9dd040a2aab743843f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNDiA-000000005o8-0NYu
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
Content-Type: multipart/mixed; boundary="===============2058381132102155694=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2058381132102155694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ozr3JFw0924="; charset=UTF-8

--ozr3JFw0924=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Track number of assigned =
peer ids and use it for max-clients check
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


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/64/2064/3

diff --git a/src/openvpn/=
multi=2Ec b/src/openvpn/multi=2Ec
index f211ef3=2E=2Eb69a209 100644
--- a/s=
rc/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -621,6 +621,8 @@
      =
       {
                 m->max_peerid--;
             }
+
+            m-=
>assigned_peer_ids--;
         }
 
         schedule_remove_entry(m->schedu=
le, (struct schedule_entry *)mi);
@@ -749,7 +751,7 @@
 
     mi->context=2E=
c2=2Etls_multi->multi_state =3D CAS_NOT_CONNECTED;
 
-    if (hash_n_elemen=
ts(m->hash) >=3D m->max_clients)
+    if (m->assigned_peer_ids >=3D m->max_=
clients)
     {
         msg(D_MULTI_ERRORS,
             "MULTI: new incom=
ing connection would exceed maximum number of clients (%u)",
@@ -4199,6 +42=
01,8 @@
     {
         m->max_peerid =3D mi->context=2Ec2=2Etls_multi->rx_=
peer_id;
     }
+
+    m->assigned_peer_ids++;
 }
 
 /**
diff --git a/src/o=
penvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5aed191=2E=2E3d2e932 100644
=
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -174,6 +174,8 @@=

     uint32_t max_peerid;               /**< highest currently allocated p=
eer-id
                                         * and maximum allocated/val=
id index in
                                         * instances */
+    ui=
nt32_t assigned_peer_ids;        /**< Number of peer-ids that are
+        =
                                *   currently assigned */
     struct hash =
*hash;                 /**< VPN tunnel instances indexed by real
          =
                               *   address of the remote peer=2E */
     st=
ruct hash *vhash;                /**< VPN tunnel instances indexed by

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad51b2f31e4215c58e1=
60cc6239836015ea4d3cf
Gerrit-Change-Number: 2064
Gerrit-PatchSet: 3
Gerrit-=
Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--ozr3JFw0924=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
4?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Tra=
ck number of assigned peer ids and use it for max-clients check<br><br>In t=
he past we used the real address hash as proxy for the number<br>of connect=
ed clients=2E TCP connections do not really need<br>this and we might remov=
e adding them to this hash map in the future=2E<br>UDP connections only nee=
d to be added to this hash map in a later stage<br>of the connection proces=
s and then only for peers that do not support<br>DATA_V2=2E<br><br>Instead =
have a simple counter that is kept up to date when a peer id<br>is assigned=
 and freed=2E This also allows this to be decoupled from<br>the real addres=
ses hash=2E<br><br>Reported-by: Ar-maan05 https://github=2Ecom/OpenVPN/open=
vpn/issues/1127<br>Github: Closes OpenVPN/openvpn#1127<br>Change-Id: Iad51b=
2f31e4215c58e160cc6239836015ea4d3cf<br>Signed-off-by: Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064<br>Messag=
e-Id: &lt;20261028202838=2E14796-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg402=
61=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>2 files chang=
ed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/2064/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index=
 f211ef3=2E=2Eb69a209 100644</span><br><span>--- a/src/openvpn/multi=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -621,6 +621,8 =
@@</span><br><span>             {</span><br><span>                 m-&gt;ma=
x_peerid--;</span><br><span>             }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            m-&gt;assigned_peer_ids--;</span><br><span>         }</span=
><br><span> </span><br><span>         schedule_remove_entry(m-&gt;schedule,=
 (struct schedule_entry *)mi);</span><br><span>@@ -749,7 +751,7 @@</span><b=
r><span> </span><br><span>     mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_st=
ate =3D CAS_NOT_CONNECTED;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (hash_n_elements(m-&gt;hash) &gt;=3D m-&gt;ma=
x_clients)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
-&gt;assigned_peer_ids &gt;=3D m-&gt;max_clients)</span><br><span>     {</s=
pan><br><span>         msg(D_MULTI_ERRORS,</span><br><span>             &qu=
ot;MULTI: new incoming connection would exceed maximum number of clients (%=
u)&quot;,</span><br><span>@@ -4199,6 +4201,8 @@</span><br><span>     {</spa=
n><br><span>         m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_multi-&=
gt;rx_peer_id;</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   m-&gt;assigned_peer_ids++;</span><br><span> }</span><br><span> </span><b=
r><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openv=
pn/multi=2Eh</span><br><span>index 5aed191=2E=2E3d2e932 100644</span><br><s=
pan>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh=
</span><br><span>@@ -174,6 +174,8 @@</span><br><span>     uint32_t max_peer=
id;               /**&lt; highest currently allocated peer-id</span><br><sp=
an>                                         * and maximum allocated/valid i=
ndex in</span><br><span>                                         * instance=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t as=
signed_peer_ids;        /**&lt; Number of peer-ids that are</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
     *   currently assigned */</span><br><span>     struct hash *hash;     =
            /**&lt; VPN tunnel instances indexed by real</span><br><span>  =
                                       *   address of the remote peer=2E */=
</span><br><span>     struct hash *vhash;                /**&lt; VPN tunnel=
 instances indexed by</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">change 2064</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad51b2f31=
e4215c58e160cc6239836015ea4d3cf </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2064 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--ozr3JFw0924=--


--===============2058381132102155694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2058381132102155694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2058381132102155694==--

