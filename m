Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEE606A336
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CfqTQOZ1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iNuStOoI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JgFaJM9R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RkWE7YYK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ht0gjL7dMGv+NvsA0rgegefwHpI4tMnC2Td7t2q4GSk=; b=CfqTQOZ1f+auqHr+CbbtOMPQPP
	uaOMzA6uc8HWuHuaCdMFgKF7Cbf3Od9Ibe4FgKOekMgJ4p0kWbtAaCcYxgdO6GSfIxN46dMSUW/hx
	zZyVl719ojerbH1q6JBe3P911tDdTBo1/lud01PpVLolrj+bREGtoNzO2gtcHcm4rLro=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFtG-000000002yF-0OFL;
	Wed, 25 Nov 2026 16:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFtE-000000002y8-2JXW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWirP4FYbYPsWYgnv9bUAYmg7CkddTS2iSfn9ghEcYI=; b=iNuStOoIzTLPKCtHP+EHJQr7eT
 gbKXH2a1KoPKsIteIZS89rhzlr3ISmyPn+k/zAuIwWrBYfN08PntVia08hNjnCtntgSHVEW4OVphv
 w+ivD+ngx9JqzQsLOPCsEILdExOYTeOzRmY8PT256zUMcGZFKN3//ktPSMiR0UnmjdN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWirP4FYbYPsWYgnv9bUAYmg7CkddTS2iSfn9ghEcYI=; b=JgFaJM9R9k9Qjv/3P546t+JpD+
 kSsmZkhokh1kVmmhS/2AWIcKAm8G/maNQ/QNv1Q0pipvYwaAIRK/iBt94Kk3k5zKkI0ui1Ur7t0/+
 oOVq+tjAEhC3G78/3lEZaanBxaO+eMaWZdqgGbUtBhiQidpKw/9xIj5jYYxIYduiplPY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFtC-0000000072E-3TmZ for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:30:36 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so59625615e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795624228; x=1796229028; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tWirP4FYbYPsWYgnv9bUAYmg7CkddTS2iSfn9ghEcYI=;
 b=RkWE7YYKsOM9Kp1pfzDZ5Xvz8Kn5vlVX37IFJKZ/o6Gf9vVOwYU1FUgWOrFgTcjuWi
 lp8Vqcg9E4rW4nRix7bpOg2R+UTe5NY6TqnTnk4tXY0TOXRAuZyNdN+5pt52BesMeMzy
 vvc2QKbIzObVJZ8nxCmNnek/ND1KB94yYVZ49sYrnPSAYK9sWimLdE9uvY1BWbnr9bdZ
 SEPBKLdWN5v18VHdHeCzBv4DnL7UNXfjvdZ4TvO49AqeAHvTUt/4nu5/P8B1CUhGVOuN
 CbqvdPKYFNQMkFzjnijgNGhs+Pd4DKD1miURs1xUflGUcObxj0ofFiJ+Y1w1lCjdczC/
 f4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624228; x=1796229028;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tWirP4FYbYPsWYgnv9bUAYmg7CkddTS2iSfn9ghEcYI=;
 b=skuyZkDY0WiinT28XMqIgR2aFVALwOEX25oAU7HArpo5H1qbPCYlFSFHPlEH1bzw8g
 g0ZRTQ7SsmdPJ1bmth8WDrdei2Z0G5Ka6lMad4bIbOZ34fW7uw9AZ4FxoMQjlp4QG+f4
 82xKk+X/oLufRulwRyPmQrmerCEdzEaTadl1drKBRVUMWdoMy9VOcTp97aQ9L2wsrONt
 VsFBGMG6KFtpXh3zjWHtnEIa2Wl8XhIEucVJA0pyUqUSDXfjhQuHUfsyudizVQyrxLOp
 ciuTCdrAlTGoSZozqpy/fPjywlheIEUBVgcNEnq7GPq09hKyBaaYQxDGkU5QNKSD4y63
 APwA==
X-Gm-Message-State: APuU4Z/bzrUJXL5oDlEX2ckRSFYXITGwu+DjjvzSqmw+QTabCITQa3X0
 lXkppUJiXCOhQSYoZgzhHUeTWNjrE9i84/LUBoqqjdEZoAmFjdSQ1dlzyFUF1yYbnsEi+8OX5TX
 1BVsiEdgbx9jtT2vuK5X6Qc6sG3mcHtJ9xKlXsBMjuJ5GbbTCqyq9Jmg2O9s0hgrSpT3njt9en7
 8S2HFa2A==
X-Gm-Gg: AZFdTZdIbkeyKOyD5wX1362oSKn2ZpdgoDnDdjMR3AwETg4tUxA9Ff/P2jzg6xoynbv
 alu3M6VDZQIhSGzwE0DGIZ5Ap2QL7tS7DSSWRHB8Nnc+t9ZyMJX9K3x3EDaCReNGn2eJRNhveb+
 t19QvV1UTPF7T+3frZSXuBA2fHOHWi6TMvt4Hx/jkZqy4Aiw+CRhwHD1dZfIo/SYWYfWkxQORmL
 fm0X8inrBPX0rDLGLZIkDRJUv9XNvruNdUFBbqfuB16OuM36K9AzMAeRWwDHrcKa2tb0pUXxoN1
 lW8kv7abYrfvn6kwfjdqzA0AZ/NidkdFClL4d6CjueSHdYl/lCpqu5fN9nU8nKYkhN0mvccePX5
 sBFzrl2Ktr2Qf2Ue4EaDec6LVlvdPRAcfAkOXCdD+b+3IrFbQYJCp28YhLU1vAp3FDRwExDcc8M
 zeUVhvX95CbaG+o6dvpuYunnQqK/ux6GkN2drj0M3LSl3PbA7o2lk1dwnrN8Lls0ogr20UHgS3E
 hxcjTKI/5e6uGr6E24XzcaZ/9udRcXXe77fvDKojg5vsMrusgDAw6OyTay8PgpaN7JASSEoDtAQ
 sHs2kBd9MF5hiEKsgPvBchtqXiL9g+dlGYlPiq3weFPAcV4ktT0DcYSFPUEW/GW5ogu8cwYMo/A
 UCfxMY07YGBFzLv2Rcwf7wTz7xlwupRoAT/Jt5ftfSyPoAKKD2HF9oPq1gnyYTGCs5LWRSLIy/5
 DY3z2XngvzG53Z5uQ=
X-Received: by 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4bb88820436mr379080875e9.35.1795624228113; 
 Wed, 25 Nov 2026 08:30:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm976357865e9.4.2026.11.25.08.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:30:27 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:30:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: b0f51c0b37e03b487dd6138c1d4781c2db138ea5
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30ba9553afae521bf7a498791a6529e22fe304bd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWFtC-0000000072E-3TmZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: remove dead
 code
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2632194279411926426=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2632194279411926426==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+S9l2R7kZBs="; charset=UTF-8

--+S9l2R7kZBs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit
=

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail

to look a=
t the new patch set (#2)=2E


Change subject: push: remove dead code
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: remove dead c=
ode

- push_option_ex(): drop the "enable" parameter; it was ignored and
  =
every caller passed true=2E
- push_remove_option(): drop the NULL check on =
o, already dereferenced
  by the ifconfig/ifconfig-ipv6 checks above it=2E
=
- receive_auth_failed(): drop a repeated no_advance =3D true and a BLEN()
 =
 check implied by the preceding "CRV1:" prefix match, and the blank
  line =
hiding that the auth-token check is an else-if of the TEMP one=2E

Change-I=
d: I0f659eb20441edd411ec13f4d09f434141b2da32
Signed-off-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
---
M src/openvpn/push=2Ec
1 file changed, 6 inser=
tions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/44/2344/2

diff --git a/src/openvpn/push=2Ec b/src/openv=
pn/push=2Ec
index eb11107=2E=2E274f652 100644
--- a/src/openvpn/push=2Ec
++=
+ b/src/openvpn/push=2Ec
@@ -75,7 +75,6 @@
         parse_auth_failed_temp(=
&c->options, reason + strlen("TEMP"));
         register_signal(c->sig, SIG=
USR1, "auth-temp-failure (server temporary reject)");
     }
-
     /* Befo=
re checking how to react on AUTH_FAILED, first check if the
      * failed =
auth might be the result of an expired auth-token=2E
      * Note that a se=
rver restart will trigger a generic AUTH_FAILED
@@ -85,7 +84,6 @@
     {
  =
       /* SOFT-SIGUSR1 -- Auth failure error */
         register_signal(c-=
>sig, SIGUSR1, "auth-failure (auth-token)");
-        c->options=2Eno_advan=
ce =3D true;
     }
     else
     {
@@ -117,7 +115,7 @@
     /*
      * Sa=
ve the dynamic-challenge text even when management is defined
      */
-   =
 if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:") && BLEN(=
&buf))
+    if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:=
"))
     {
         ssl_put_auth_challenge(CBSTR(&buf));
     }
@@ -931,7 +=
929,7 @@
 }
 
 static void
-push_option_ex(struct gc_arena *gc, struct push=
_list *push_list, const char *opt, bool enable,
+push_option_ex(struct gc_a=
rena *gc, struct push_list *push_list, const char *opt,
                msg=
lvl_t msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
@@ -962,7=
 +960,7 @@
 void
 push_option(struct options *o, const char *opt, msglvl_t =
msglevel)
 {
-    push_option_ex(&o->gc, &o->push_list, opt, true, msglevel=
);
+    push_option_ex(&o->gc, &o->push_list, opt, msglevel);
 }
 
 void
@@=
 -974,7 +972,7 @@
         push_reset(o);
         while (e)
         {
-  =
          push_option_ex(&o->gc, &o->push_list, string_alloc(e->option, &o-=
>gc), true, M_FATAL);
+            push_option_ex(&o->gc, &o->push_list, st=
ring_alloc(e->option, &o->gc), M_FATAL);
             e =3D e->next;
      =
   }
     }
@@ -1002,7 +1000,7 @@
     {
         return false;
     }
-   =
 push_option_ex(gc, push_list, string_alloc(tmp, gc), true, msglevel);
+   =
 push_option_ex(gc, push_list, string_alloc(tmp, gc), msglevel);
     retur=
n true;
 }
 
@@ -1031,7 +1029,7 @@
         return;
     }
 
-    if (o && =
o->push_list=2Ehead)
+    if (o->push_list=2Ehead)
     {
         struct p=
ush_entry *e =3D o->push_list=2Ehead;
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
Gerrit-=
Change-Number: 2344
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>

--+S9l2R7kZBs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #2</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push: remove dead code<br><br>- push_option=
_ex(): drop the &quot;enable&quot; parameter; it was ignored and<br>  every=
 caller passed true=2E<br>- push_remove_option(): drop the NULL check on o,=
 already dereferenced<br>  by the ifconfig/ifconfig-ipv6 checks above it=2E=
<br>- receive_auth_failed(): drop a repeated no_advance =3D true and a BLEN=
()<br>  check implied by the preceding &quot;CRV1:&quot; prefix match, and =
the blank<br>  line hiding that the auth-token check is an else-if of the T=
EMP one=2E<br><br>Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src=
/openvpn/push=2Ec<br>1 file changed, 6 insertions(+), 8 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/44/2344/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/push=2Ec b/src/openvp=
n/push=2Ec</span><br><span>index eb11107=2E=2E274f652 100644</span><br><spa=
n>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</sp=
an><br><span>@@ -75,7 +75,6 @@</span><br><span>         parse_auth_failed_t=
emp(&amp;c-&gt;options, reason + strlen(&quot;TEMP&quot;));</span><br><span=
>         register_signal(c-&gt;sig, SIGUSR1, &quot;auth-temp-failure (serv=
er temporary reject)&quot;);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Before checking ho=
w to react on AUTH_FAILED, first check if the</span><br><span>      * faile=
d auth might be the result of an expired auth-token=2E</span><br><span>    =
  * Note that a server restart will trigger a generic AUTH_FAILED</span><br=
><span>@@ -85,7 +84,6 @@</span><br><span>     {</span><br><span>         /*=
 SOFT-SIGUSR1 -- Auth failure error */</span><br><span>         register_si=
gnal(c-&gt;sig, SIGUSR1, &quot;auth-failure (auth-token)&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;options=2Eno_advan=
ce =3D true;</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span>@@ -117,7 +115,7 @@</span><br><span>     /*</span=
><br><span>      * Save the dynamic-challenge text even when management is =
defined</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (authfail_extended &amp;&amp; buf_string_match_head_str(&=
amp;buf, &quot;CRV1:&quot;) &amp;&amp; BLEN(&amp;buf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (authfail_extended &amp;&amp; buf=
_string_match_head_str(&amp;buf, &quot;CRV1:&quot;))</span><br><span>     {=
</span><br><span>         ssl_put_auth_challenge(CBSTR(&amp;buf));</span><b=
r><span>     }</span><br><span>@@ -931,7 +929,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-push_option_ex(struct gc_arena *gc, struct push_list *p=
ush_list, const char *opt, bool enable,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+push_option_ex(struct gc_arena *gc, struct push_list *p=
ush_list, const char *opt,</span><br><span>                msglvl_t msgleve=
l)</span><br><span> {</span><br><span>     if (!string_class(opt, CC_ANY, C=
C_COMMA))</span><br><span>@@ -962,7 +960,7 @@</span><br><span> void</span><=
br><span> push_option(struct options *o, const char *opt, msglvl_t msglevel=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   push_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, opt, true, msglevel)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    push_option_ex=
(&amp;o-&gt;gc, &amp;o-&gt;push_list, opt, msglevel);</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span>@@ -974,7 +972,7 @@</=
span><br><span>         push_reset(o);</span><br><span>         while (e)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            push_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, string_=
alloc(e-&gt;option, &amp;o-&gt;gc), true, M_FATAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            push_option_ex(&amp;o-&gt;gc,=
 &amp;o-&gt;push_list, string_alloc(e-&gt;option, &amp;o-&gt;gc), M_FATAL);=
</span><br><span>             e =3D e-&gt;next;</span><br><span>         }<=
/span><br><span>     }</span><br><span>@@ -1002,7 +1000,7 @@</span><br><spa=
n>     {</span><br><span>         return false;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    push_option_ex(gc, pus=
h_list, string_alloc(tmp, gc), true, msglevel);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    push_option_ex(gc, push_list, string_alloc(=
tmp, gc), msglevel);</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span>@@ -1031,7 +1029,7 @@</span><br><span>    =
     return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o &amp;&amp; o-&gt;push_list=2Ehead=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;push=
_list=2Ehead)</span><br><span>     {</span><br><span>         struct push_e=
ntry *e =3D o-&gt;push_list=2Ehead;</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail">change 2=
344</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I0f659eb20441edd411ec13f4d09f434141b2da32 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2344 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--+S9l2R7kZBs=--


--===============2632194279411926426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2632194279411926426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2632194279411926426==--

