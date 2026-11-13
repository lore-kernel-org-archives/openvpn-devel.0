Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126A606A8A2
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=djxOo+oQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WukkUAOt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GOe/9EIj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=EB6qp+o6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TD0Lk6AfgJJn93Lh4o43RyhdBe0rR/IoX6cjbIZyJwY=; b=djxOo+oQLTsG1BSTElzO7cL3tb
	9ogqsKNgN5CLkiT5tM5/MZQHNZOZbGgUHwCrn0WanIh2E6G2BQXVEbcxBQ8oTVr5/gY21DyDHD2Mg
	epEucqTDwlgAt+t986TsdzVGuNKMPl9MLCjhpL4TlXo1hOXslAzAkCFqSYDnBvZxK26Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzmH-000000007JY-1kWX;
	Fri, 13 Nov 2026 22:29:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzmF-000000007JR-3KfM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B5NciSY1fJ3GbPAfipwfoQdUFIKdptSHvHBYJIxb8dg=; b=WukkUAOtuGfH1kyfenjN2lfH3h
 eeISyvSC/N1vVhlNC6f85darZd/9oIyJfQdv8ezTT21VjSBZi51uUngxM8BqlXB0rrFNJoR86hsgi
 ZEwmnyQND9x3pK/XRt52HFoOD0+a1nB3GvNIZl8/G/k019xw7J0A/+hDlO1ieRqLRAZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B5NciSY1fJ3GbPAfipwfoQdUFIKdptSHvHBYJIxb8dg=; b=GOe/9EIjpMQxY1JeyFn7wInxvN
 Uq+gW6/q3hLqG9wnA/GvuP5HQoAMESsKXkT94gTY+Z33jxOq++85fTn+UF5A5kIedPgxMWIIlSXYw
 1UKNUgKhWonQJNcEgGqtdTdr4Z4gVhHgZts7B5VaNTf2a4n2W5/v1uKilXA+axhvBHYg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzmE-000000006Z0-3t73 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:29:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb5f49a61bso2294145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608980; x=1795213780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B5NciSY1fJ3GbPAfipwfoQdUFIKdptSHvHBYJIxb8dg=;
 b=EB6qp+o6li00yhCCl+hZEMv3Lepc0PeTu25nP0vfk02jUnArvcnA3JzIkmnA1LGiqT
 2CR2+vGiPdeo5TUznf1t7iNgMRHRJHhKmPdkWwYF85e6RTkbcQ7C4MAEvkOGRBdXh4SH
 TRbD3JcWkPdN8tm+IL97u+mLDwX+TT81kSuvk7vBSSY15IJkes2PCUIk6CVKYacdDeYF
 S8Zjplx7YzNBxl61LgV/mPJNILjI3uy7ow9l/WnmtJbnkMZTUyqzXVp8dcStdoCPru9b
 5pqGExQ1k1Lmzxiz/04qpGntdm64+b4/qmaH4RmtEFrntb/De6TSosHOFmbh81cOO75K
 yriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608980; x=1795213780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B5NciSY1fJ3GbPAfipwfoQdUFIKdptSHvHBYJIxb8dg=;
 b=IcVMaJWYJenlZed2B8KOCVmJAfMV/LcJCgnUHbz4p8iWrhHfXw34E3z9DbfjqzgC6E
 myryFF/6oBvs8hCKlUj9SOOuvAR3JiSWlwLlS8Ux5t4JTrSCqa4UJ+AoyX0H/6nEFKQf
 wJ7ihd81DReivCvhHbhfNjSXB1hg1s5rzeaBOapy1gED4ggqw9Cqp9GaIjiOQHiNydah
 64aAl20cZUEfdOapF4/obE3YP4JVywTubenmqLc/GcLURK5Rft0Vf9LnZ2oPlibqo2zz
 M10ueA/9gz8V5DPnGsDCub3xLVjq4ZELg+RfMxonrJZUrvFtUZ2NWBs6XQFq0VlR8gqD
 gCCQ==
X-Gm-Message-State: APuU4Z+0gf9myb0dxge6zjAefiQZEtlYDHYF5Mp/8mx8ON0XCJ69F3Cf
 9BldmFmJeZO7wsdKfLJwvktVm9rIxKyoeyqN0rd8iwgA6V5p84E6wMvOGuShRsXlkUuCxwRBVi7
 /vftiJEcAaQ9cdTo0jVCCG9yS/MEDrYZ7rFgMz04sNQMzi/m9bix1XYbDj2s/LhuAmBnF
X-Gm-Gg: AYBFou3W4Rqpz7KPPmR4iFjvMYUAdGyAv681VzAiNhoH3k7w6LwFPVNqU7bCkrHrU0C
 u//GQ3RSzXFJPPa6/9Js8IB6l1J+7y9eSuuWcYOkCzX4nDEGRxaYKY+mEI/fbplyphe+2yYJjiZ
 ZA0+8893oPKBYWnOkmakM1nXOJwJYnOq2g4ikmyEIdgQg/JA9bojFeFKo5gtQBleSrG4fIUwS0n
 OqONB88yxEzU/Oa6AqLyNAPP+sKTQkJjSORVYlxZxeWs2SFftALMM+EwN2OLTsG7oay3uMXBwtP
 XuwhS8k8iNrnHJg1kDuEkkTF9gvKEm7SNnVQD1jIabFbCOSNkidgy93BsVliO2z1+ROhXhzRsvU
 P5fp0UafYmTfAQWHvYZMB/j77buRIja6jlx/te2GKKxK33/onGyyqbJOg8e5mYTslGHG0GU9LCs
 XgRz+ZJKRhFiZpE+PU4YrtaRR63TtX3nvAfMHLIpkdkAXGnEzTF56ZH4HVe1zNks9K/6fEogvYz
 31+dhQS/yki2c1AmbatC77L9iV1wSf+nhIkFIlnUPxvbtV1DelTZBERDOHYMh7c1/QH0XuOczyl
 qUWuFwRC6mZzULCK66qsOWwg1kq3nfnurlQrkPfsj8r3+6y1x2poCrBurLffxcGn0RwQrjsOaiv
 sqvsL32KtxWvVcUyMxY8wW6cSBiaAlZKSo9qtTEwjz/eN4h0eUR9G35u2cEEq0dUlKY+7CB7pOZ
 h1KXGR+W1GiPgHQp8=
X-Received: by 2002:a05:600c:4684:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4bb55abc6a5mr85289325e9.32.1794608980171; 
 Fri, 13 Nov 2026 14:29:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb62d5ec30sm11673225e9.15.2026.11.13.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:29:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:29:38 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088
X-Gerrit-Change-Number: 2176
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2176?usp=email>
X-Gerrit-Commit: 9e9f76c872fc67fe5ed9a11853509cf965c30d79
In-Reply-To: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
References: <gerrit.1794417322000.Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkllNzIyOGVlOTVjMmI0M2Y5YmUyYmY0YzZhOWE5NTlhZjJmNzI5MDg4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30d1204dda0c495c457557ccb96e06a414933250-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzmE-000000006Z0-3t73
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Make
 error_flags unsigned consistently
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
Content-Type: multipart/mixed; boundary="===============3482350291300827506=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3482350291300827506==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dnaC0vz6r4c="; charset=UTF-8

--dnaC0vz6r4c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
176?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: tun: Make error_flag=
s unsigned consistently
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

tun: Make error_flags unsigned consistently

Previously both int=
 and unsigned int was used=2E

Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af=
2f729088
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2176
Message-Id: <20261111183203=2E18722-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41174=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 4 insertions(+),=
 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/76/2176/3

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index ea77f16=2E=2Ecb89627 100644
--- a/src/openvpn/init=2Ec
+++ b/src=
/openvpn/init=2Ec
@@ -1801,7 +1801,7 @@
 
 
 static bool
-do_open_tun(struc=
t context *c, int *error_flags)
+do_open_tun(struct context *c, unsigned in=
t *error_flags)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D =
false;
@@ -2303,7 +2303,7 @@
 bool
 do_up(struct context *c, bool pulled_op=
tions, uint64_t option_types_found)
 {
-    int error_flags =3D 0;
+    uns=
igned int error_flags =3D 0;
     if (!c->c2=2Edo_up_ran)
     {
         r=
eset_coarse_timers(c);
@@ -2462,7 +2462,7 @@
     do_close_tun(c, true);
 
=
     management_sleep(1);
-    int error_flags =3D 0;
+    unsigned int err=
or_flags =3D 0;
     c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);=

     update_time();
 
@@ -4530,7 +4530,7 @@
      * open tun/tap device, i=
fconfig, run up script, etc=2E */
     if (!(options->up_delay || PULL_DEFI=
NED(options)) && (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP))
     {
-=
        int error_flags =3D 0;
+        unsigned int error_flags =3D 0;
   =
      c->c2=2Edid_open_tun =3D do_open_tun(c, &error_flags);
     }
 

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7228ee95c2b43f9be2=
bf4c6a9a959af2f729088
Gerrit-Change-Number: 2176
Gerrit-PatchSet: 3
Gerrit-=
Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--dnaC0vz6r4c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2176?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">tun: Make error_flags unsigned consistently<br><br>Previously both int =
and unsigned int was used=2E<br><br>Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a=
959af2f729088<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176<br>Message-Id: &lt;20=
261111183203=2E18722-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41174=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sr=
c/openvpn/init=2Ec<br>1 file changed, 4 insertions(+), 4 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/76/2176/3</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec</span><br><span>index ea77f16=2E=2Ecb89627 100644</span><br><sp=
an>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</s=
pan><br><span>@@ -1801,7 +1801,7 @@</span><br><span> </span><br><span> </sp=
an><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-do_open_tun(struct context *c, int *error_flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_open_tun(struct context *c, unsigned i=
nt *error_flags)</span><br><span> {</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span>@@ =
-2303,7 +2303,7 @@</span><br><span> bool</span><br><span> do_up(struct cont=
ext *c, bool pulled_options, uint64_t option_types_found)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int error_flags =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned =
int error_flags =3D 0;</span><br><span>     if (!c-&gt;c2=2Edo_up_ran)</spa=
n><br><span>     {</span><br><span>         reset_coarse_timers(c);</span><=
br><span>@@ -2462,7 +2462,7 @@</span><br><span>     do_close_tun(c, true);<=
/span><br><span> </span><br><span>     management_sleep(1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int error_flags =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int error_flags =
=3D 0;</span><br><span>     c-&gt;c2=2Edid_open_tun =3D do_open_tun(c, &amp=
;error_flags);</span><br><span>     update_time();</span><br><span> </span>=
<br><span>@@ -4530,7 +4530,7 @@</span><br><span>      * open tun/tap device=
, ifconfig, run up script, etc=2E */</span><br><span>     if (!(options-&gt=
;up_delay || PULL_DEFINED(options)) &amp;&amp; (c-&gt;mode =3D=3D CM_P2P ||=
 c-&gt;mode =3D=3D CM_TOP))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int error_flags =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        unsigned int error_flags =
=3D 0;</span><br><span>         c-&gt;c2=2Edid_open_tun =3D do_open_tun(c, =
&amp;error_flags);</span><br><span>     }</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176?usp=3Demail">ch=
ange 2176</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2176=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ie7228ee95c2b43f9be2bf4c6a9a959af2f729088 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2176 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--dnaC0vz6r4c=--


--===============3482350291300827506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3482350291300827506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3482350291300827506==--

