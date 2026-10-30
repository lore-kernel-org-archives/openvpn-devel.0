Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DE606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iTYjhxlE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RQ8QpqTy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m+oTNJgu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eNS7mtAt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GaPtsdVmD1BPwu+vDbmzZp8RB0vngX0MBQ0uQyRC9j8=; b=iTYjhxlEeJdHYwHI/ZWlOMvk5n
	L/AG42nxrxtYLKRyWeMhUFlfuTWoZZRUE6x45pm4XL/Q97UNwM5C5ApFD3PbM382XjALaZEW6sIyL
	oTTa+u8TcK9pgR83pnhCQ/uk2fUKb3t35ROdteQvwNa6DIqT7359NWJ9HkJFIYILmuoA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrEv-000000001Ud-0UMd;
	Fri, 30 Oct 2026 18:22:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrEt-000000001UP-3Fz3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lqr0gV2XBXdmg0qV+09qBngqolJstpZWPjGfInZgB/Q=; b=RQ8QpqTy+gBIJ8K4EP1pFKppof
 YU/5awq28CECePusY2lpzq6lkTQPhr/kPMEXJR1DEOoiXzIf7EfsLRqhHvnZNVRvTejFI0MGCXZ1a
 CuHV68HzL+ZDjd8gcbVef/BEBiXlDZWBllqNXSyan3InhzSrLesh30RAbb2Zw4tCTVfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lqr0gV2XBXdmg0qV+09qBngqolJstpZWPjGfInZgB/Q=; b=m+oTNJgu+++oOK2aPKzFjGJ8fC
 6e7P+Ikj+PNMvM9Wty6z1UopfiFIgbpTmMqcnaT+12Yn3G6wWUr+7mItB6UpqT/kNFO7eG0DkaSJ5
 BTYPm47aeHoz4udwl39/Hj8X1JsbDLch1WxQw6Q+6/WZAGbirr6fg/p90LGmH1dF4lb0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrEs-000000005Pl-0R4e for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:22:07 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so602150f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793384519; x=1793989319; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lqr0gV2XBXdmg0qV+09qBngqolJstpZWPjGfInZgB/Q=;
 b=eNS7mtAtvuCNEv0izLsAUlh7QkcxKaEBKn4uikPEb1he3xAgnWPo+lEhgTfwn96HRi
 OEL+j3AvXpThdx86Xg+FkxHF7bOb5kwUVpcdqw2v09v6BXdX6L158Pee9OcIc3k/PQ82
 ESH14kOGktCGUnlF+qst54lMFuDFtHpO3YK6ZF3ZVyEq27wlGqliHFXRti+PN9iek7t6
 X1ftLk7pkpXg7RRgpOst9/trFq8DY60cQ3yrL9YCEmJWmZSnTwswLUL6NrJv6RFU+vUQ
 DPGZalqygodZLHLtpf6rWvefSaN46eZMNX7Ni/ekssBoGq3OvSdLMznHxn00HU53AZ3T
 oL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384519; x=1793989319;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lqr0gV2XBXdmg0qV+09qBngqolJstpZWPjGfInZgB/Q=;
 b=uCqkwZIBfhtr9MrcoGmfWubn/UG1mLENHGJPKAFuhJMUvnKLrwH9ZwApHajTu75z9r
 844YUP+C02pXzjvdRr0NxEioDUtCFJnknX3U5zg+3id+17khkApKZDm97T/V/Wn8C/Mu
 0Wcomo8phbfAiGea35UoBFLdESZFvaBnO/JtNkOKJwDDC/f1cufiIRv3M6c0zb3hy0DW
 Al8CgjxFm6317NmM9qJ8u+mrO9S2ib2WEE75+A4ONHr914P8tE5LlcNMEeVfFZx2Kvbd
 9gLf085yCtndNfupm0XOPMSpHFFnAGYiTit/DACpImS8z77osPfdWQkQGUWXxtiXPJwh
 LmVw==
X-Gm-Message-State: AFq9FYLxn7OyYYchsyesh/JWblRKzehJ8wn6ttbOrId06eHAOPAMWOi8
 etDnRgnO1w3Kc7VzhDjvdZ9HOZiR+QUWp6afcEFwTBSKZfIn0ZwNOoE0g8C+h5O2es61M4eiVnv
 IWb1NHn+IfDI4MfmfySV6iJsucOe7JLQwCnfupmUMmzzr5kiIYWtZ7gKQDo/wfRNGyvcF
X-Gm-Gg: AYBFou3fIIFGD78ggHQJUePW82l0hf1rl72L4pa8tHYK8QBJDMK/pq2nwwUcqYIWa0G
 yGm6f9uNlbPe1bUweOG9RVZBLtXplcYlQUSJIt/QJU8wp2ZtwgZ93bPmdgj73ErKxTWAjjluf5I
 oLXqn0V6Dk8zDJLuk7obIGPmp26V5InMOPUDk5Bg0ZAy5atqWWp7aBVm+0qb86nw7SzpveS7DJk
 J7SnR/lu1nOsJSKQbk6/2CPfUAxAxUP3IUnVlcxQ+IsloZXTaX1ei6K5g7GJ+Sbtuhs6QFp+z9l
 hO0YHvHVGIXcXHDU7s3sOE6wlC6MGkx3xZxuYYbKXAM9LmEt3re2u6FSHWdtseK2vJL7R+YFY6x
 b9uR+x6qAgDgQNpFBNu22M7w0kPdcFyporFZGRV2pOPueMSHB4MSQUXgOwg+T0CR/arnw7MUna4
 z3/89Zt/DbjEHgZw4f0EuoyRfD9gp4MPPKZdJEVhLLydFEW+05qMEfl8zKsagvBSwabN709Pc9W
 9nYeF7Z4CvtUxuN4ks1qra+5wLnbd7zG0ZOY5JKB3Zck/QN9LYPFoOb9exxMB3V1KJyrtktIg3s
 hxlSi7ZR3Ke8lTChxu8wDq3B9x/dO5dvAuS2TieIRFkwKAQIX5TjoInmh4CXe4fO2fddR6Iu8U8
 RGohskl3ZHDxnyd12bPCS4zpvMjccmgQ+96cEvf1KjmzZOK/9VHrNjTNJk9j788wECtxC+Glbdg
 zD1sSbAFG8mfpQBJ8=
X-Received: by 2002:a05:6000:29d3:b0:48c:4444:f0a2 with SMTP id
 ffacd0b85a97d-48e6e2c3395mr4903146f8f.7.1793384519227; 
 Fri, 30 Oct 2026 11:21:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm4561655f8f.23.2026.10.30.11.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:21:58 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:21:57 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
X-Gerrit-Change-Number: 2042
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2042?usp=email>
X-Gerrit-Commit: c18ebde866d2985885a0c0d338c7c5d5d7754dae
In-Reply-To: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
References: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk4OTMwMzk3NWRkNTU5ZDdjYzA2NDg0YTk5ZjE1YzcwNjJkM2EzNDM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18460dec27d12bfc8c0db1a04e5cc70e0659a4fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrEs-000000005Pl-0R4e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 tun write functions to multi_io.c
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
Content-Type: multipart/mixed; boundary="===============4717054935548801977=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4717054935548801977==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5RKUDPdUVSA="; charset=UTF-8

--5RKUDPdUVSA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2042?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: multi_io: move th=
e tun write functions to multi_io=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: move the tun write functions to multi_i=
o=2Ec

multi_process_outgoing_tun() lived as a static inline in multi=2Eh a=
nd
multi_process_drop_outgoing_tun() in multi=2Ec, while their only caller
=
is multi_io_dispatch()=2E Move both next to it, as static functions named
m=
ulti_io_write_tun() and multi_io_drop_tun(), so that writing to the
tun dev=
ice is found where the state machine decides to do it=2E

No functional cha=
nge=2E

Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
Signed-off-by:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2042
Message-Id: <20261027102325=2E19448-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg40183=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
=
3 files changed, 59 insertions(+), 61 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2042/2

diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2E2e804ff 100644
-=
-- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3766,27 +3766,6 =
@@
 }
 
 /*
- * Drop a TUN/TAP outgoing packet=2E=2E
- */
-void
-multi_proc=
ess_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags=
)
-{
-    struct multi_instance *mi =3D m->pending;
-
-    ASSERT(mi);
-
- =
   set_prefix(mi);
-
-    msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue fu=
ll, dropped packet len=3D%d",
-        mi->context=2Ec2=2Eto_tun=2Elen);
-
=
-    buf_reset(&mi->context=2Ec2=2Eto_tun);
-
-    multi_process_post(m, mi=
, mpp_flags);
-    clear_prefix();
-}
-
-/*
  * Per-client route quota mana=
gement
  */
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
in=
dex 5db7147=2E=2E2d4983c 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openv=
pn/multi=2Eh
@@ -295,7 +295,7 @@
  * function controls the necessary postpr=
ocessing=2E  It is called by many
  * other functions that handle VPN tunne=
l related activity, such as \c
  * multi_process_incoming_link(), \c multi_=
process_outgoing_link(), \c
- * multi_process_incoming_tun(), \c multi_proc=
ess_outgoing_tun(), and \c
+ * multi_process_incoming_tun(), \c multi_io_wr=
ite_tun(), and \c
  * multi_process_timeout(), among others=2E
  *
  * @par=
am m            - The single \c multi_context structure=2E
@@ -364,8 +364,6=
 @@
 bool multi_process_incoming_tun(struct multi_context *m, const unsigne=
d int mpp_flags);
 
 
-void multi_process_drop_outgoing_tun(struct multi_co=
ntext *m, const unsigned int mpp_flags);
-
 struct multi_instance *multi_ge=
t_queue(struct mbuf_set *ms);
 
 void multi_ifconfig_pool_persist(struct mu=
lti_context *m, bool force);
@@ -627,41 +625,6 @@
 }
 
 
-/**
- * Send a pa=
cket over the virtual tun/tap network interface to its locally
- * reachabl=
e destination=2E
- * @ingroup internal_multiplexer
- *
- * This function ca=
lls \c process_outgoing_tun() to perform the actual
- * sending of the pack=
et=2E  Afterwards, it calls \c multi_process_post() to
- * perform server-m=
ode postprocessing=2E
- *
- * @param m            - The single \c multi_con=
text structure=2E
- * @param mpp_flags    - Fast I/O optimization flags=2E
=
- *
- * @return
- *  - True, if the \c multi_instance associated with the p=
acket sent was
- *    not closed due to a signal during processing=2E
- *  =
- Falls, if the \c multi_instance was closed=2E
- */
-static inline bool
-m=
ulti_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_f=
lags)
-{
-    struct multi_instance *mi =3D m->pending;
-    bool ret =3D t=
rue;
-
-    ASSERT(mi);
-#ifdef MULTI_DEBUG_EVENT_LOOP
-    printf("%s -> T=
UN len=3D%d\n", id(mi), mi->context=2Ec2=2Eto_tun=2Elen);
-#endif
-    set_=
prefix(mi);
-    vlan_process_outgoing_tun(m, mi);
-    process_outgoing_tu=
n(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
-    ret =3D multi_pro=
cess_post(m, mi, mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 #d=
efine CLIENT_CONNECT_OPT_MASK                                              =
              \
     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_T=
IMER | OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_P_COMP | OPT_P_SOCKFLAGS)
di=
ff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index ebee86=
c=2E=2E164b214 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/mult=
i_io=2Ec
@@ -290,6 +290,62 @@
     }
 }
 
+/**
+ * Send a packet over the v=
irtual tun/tap network interface to its locally
+ * reachable destination=
=2E
+ * @ingroup internal_multiplexer
+ *
+ * This function calls \c proces=
s_outgoing_tun() to perform the actual
+ * sending of the packet=2E  Afterw=
ards, it calls \c multi_process_post() to
+ * perform server-mode postproce=
ssing=2E
+ *
+ * @param m            - The single \c multi_context structur=
e=2E
+ * @param mpp_flags    - Fast I/O optimization flags=2E
+ *
+ * @retu=
rn
+ *  - True, if the \c multi_instance associated with the packet sent wa=
s
+ *    not closed due to a signal during processing=2E
+ *  - Falls, if t=
he \c multi_instance was closed=2E
+ */
+static bool
+multi_io_write_tun(st=
ruct multi_context *m, const unsigned int mpp_flags)
+{
+    struct multi_i=
nstance *mi =3D m->pending;
+    bool ret =3D true;
+
+    ASSERT(mi);
+#if=
def MULTI_DEBUG_EVENT_LOOP
+    printf("%s -> TUN len=3D%d\n", id(mi), mi->=
context=2Ec2=2Eto_tun=2Elen);
+#endif
+    set_prefix(mi);
+    vlan_proces=
s_outgoing_tun(m, mi);
+    process_outgoing_tun(&mi->context, mi->context=
=2Ec2=2Elink_sockets[0]);
+    ret =3D multi_process_post(m, mi, mpp_flags)=
;
+    clear_prefix();
+    return ret;
+}
+
+/*
+ * Drop a TUN/TAP outgoin=
g packet=2E=2E
+ */
+static void
+multi_io_drop_tun(struct multi_context *m=
, const unsigned int mpp_flags)
+{
+    struct multi_instance *mi =3D m->pe=
nding;
+
+    ASSERT(mi);
+
+    set_prefix(mi);
+
+    msg(D_MULTI_ERRORS,=
 "MULTI: Outgoing TUN queue full, dropped packet len=3D%d",
+        mi->co=
ntext=2Ec2=2Eto_tun=2Elen);
+
+    buf_reset(&mi->context=2Ec2=2Eto_tun);
+=

+    multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+}
+
 stat=
ic struct multi_instance *
 multi_io_dispatch(struct multi_context *m, stru=
ct multi_instance *mi, const int action)
 {
@@ -334,11 +390,11 @@
         =
    break;
 
         case TA_TUN_WRITE:
-            multi_process_outgoin=
g_tun(m, mpp_flags);
+            multi_io_write_tun(m, mpp_flags);
       =
      break;
 
         case TA_TUN_WRITE_TIMEOUT:
-            multi_proce=
ss_drop_outgoing_tun(m, mpp_flags);
+            multi_io_drop_tun(m, mpp_f=
lags);
             break;
 
         case TA_SOCKET_WRITE_READY:

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89303975dd559d7cc06484a=
99f15c7062d3a3437
Gerrit-Change-Number: 2042
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--5RKUDPdUVSA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2042?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi_io: move the tun write functions to multi_io=2Ec<br><br>multi_pr=
ocess_outgoing_tun() lived as a static inline in multi=2Eh and<br>multi_pro=
cess_drop_outgoing_tun() in multi=2Ec, while their only caller<br>is multi_=
io_dispatch()=2E Move both next to it, as static functions named<br>multi_i=
o_write_tun() and multi_io_drop_tun(), so that writing to the<br>tun device=
 is found where the state machine decides to do it=2E<br><br>No functional =
change=2E<br><br>Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437<br>Si=
gned-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042<br>Message-Id: &lt;20261027102325=
=2E19448-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40183=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br>3 fil=
es changed, 59 insertions(+), 61 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2042/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br>=
<span>index e302a81=2E=2E2e804ff 100644</span><br><span>--- a/src/openvpn/m=
ulti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -37=
66,27 +3766,6 @@</span><br><span> }</span><br><span> </span><br><span> /*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Drop a TUN/TAP outgo=
ing packet=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-multi_process_drop_outgoing_tun(struct m=
ulti_context *m, const unsigned int mpp_flags)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct multi_instance *mi =3D m-&gt;pending;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_prefix(m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_ERRORS, &quot;MULTI: Ou=
tgoing TUN queue full, dropped packet len=3D%d&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Eto_tun=2Elen)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    buf_reset(&amp;mi-&gt;context=2Ec2=2E=
to_tun);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    multi_process_post(m, mi, mpp_=
flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clear_pref=
ix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span>  * Per-client route quota management<=
/span><br><span>  */</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5db7147=2E=2E2=
d4983c 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+=
++ b/src/openvpn/multi=2Eh</span><br><span>@@ -295,7 +295,7 @@</span><br><s=
pan>  * function controls the necessary postprocessing=2E  It is called by =
many</span><br><span>  * other functions that handle VPN tunnel related act=
ivity, such as \c</span><br><span>  * multi_process_incoming_link(), \c mul=
ti_process_outgoing_link(), \c</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * multi_process_incoming_tun(), \c multi_process_outgoing_tun(), =
and \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi_proc=
ess_incoming_tun(), \c multi_io_write_tun(), and \c</span><br><span>  * mul=
ti_process_timeout(), among others=2E</span><br><span>  *</span><br><span> =
 * @param m            - The single \c multi_context structure=2E</span><br=
><span>@@ -364,8 +364,6 @@</span><br><span> bool multi_process_incoming_tun=
(struct multi_context *m, const unsigned int mpp_flags);</span><br><span> <=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 multi_process_drop_outgoing_tun(struct multi_context *m, const unsigned in=
t mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> struct multi_instance *multi_get_queue(struct mbuf_set *ms);</spa=
n><br><span> </span><br><span> void multi_ifconfig_pool_persist(struct mult=
i_context *m, bool force);</span><br><span>@@ -627,41 +625,6 @@</span><br><=
span> }</span><br><span> </span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Send a packet over the virtual tun/tap network interface to its loca=
lly</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * reachable desti=
nation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup =
internal_multiplexer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function cal=
ls \c process_outgoing_tun() to perform the actual</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * sending of the packet=2E  Afterwards, it ca=
lls \c multi_process_post() to</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * perform server-mode postprocessing=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param m            - The single \c multi_context structure=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mpp_flags   =
 - Fast I/O optimization flags=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ret=
urn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - True, if the=
 \c multi_instance associated with the packet sent was</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *    not closed due to a signal during pr=
ocessing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - Fall=
s, if the \c multi_instance was closed=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
ulti_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_f=
lags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-=
&gt;pending;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef MULTI_DEBUG_EVENT_LOOP</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;%s -&gt; T=
UN len=3D%d\n&quot;, id(mi), mi-&gt;context=2Ec2=2Eto_tun=2Elen);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    set_prefix(mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    vlan_process_outgoing_tun(m, mi);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_tun(&amp;mi=
-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D multi_process_post(m, mi, mpp_f=
lags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clear_prefi=
x();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define CLIENT_CONNECT_OP=
T_MASK                                                            \</span><=
br><span>     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | =
OPT_P_CONFIG | OPT_P_ECHO \</span><br><span>      | OPT_P_COMP | OPT_P_SOCK=
FLAGS)</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/=
multi_io=2Ec</span><br><span>index ebee86c=2E=2E164b214 100644</span><br><s=
pan>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_=
io=2Ec</span><br><span>@@ -290,6 +290,62 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Send=
 a packet over the virtual tun/tap network interface to its locally</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * reachable destination=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ingroup interna=
l_multiplexer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function calls =
\c process_outgoing_tun() to perform the actual</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * sending of the packet=2E  Afterwards, it cal=
ls \c multi_process_post() to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * perform server-mode postprocessing=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param m            - The single \c multi_context structur=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param mpp_f=
lags    - Fast I/O optimization flags=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  -=
 True, if the \c multi_instance associated with the packet sent was</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *    not closed due to a s=
ignal during processing=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  - Falls, if the \c multi_instance was closed=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_io_write_tun(struct multi_context *m, const unsigned i=
nt mpp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instanc=
e *mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool ret =3D true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef MULTI_DE=
BUG_EVENT_LOOP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
rintf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;context=2Ec2=2Eto=
_tun=2Elen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_prefix(mi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    vlan_process_out=
going_tun(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  process_outgoing_tun(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sock=
ets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D=
 multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    clear_prefix();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Drop a TUN/TAP outgoing packet=2E=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_drop_tun(struct multi_context *m=
, const unsigned int mpp_flags)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct multi_instance *mi =3D m-&gt;pending;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_prefix(mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_ERRORS, &quot;MULTI: O=
utgoing TUN queue full, dropped packet len=3D%d&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Eto_tun=2El=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_reset(&amp;mi-&gt;context=
=2Ec2=2Eto_tun);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_process_post=
(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    clear_prefix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static struct multi_instance *</span><br><span> multi_io_dispatch(struct mu=
lti_context *m, struct multi_instance *mi, const int action)</span><br><spa=
n> {</span><br><span>@@ -334,11 +390,11 @@</span><br><span>             bre=
ak;</span><br><span> </span><br><span>         case TA_TUN_WRITE:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_outgo=
ing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi_io_write_tun(m, mpp_flags);</span><br><span>          =
   break;</span><br><span> </span><br><span>         case TA_TUN_WRITE_TIME=
OUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi=
_process_drop_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_io_drop_tun(m, mpp_flags);</span><b=
r><span>             break;</span><br><span> </span><br><span>         case=
 TA_SOCKET_WRITE_READY:</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail">change 2042</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:n=
one"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Br=
anch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8930397=
5dd559d7cc06484a99f15c7062d3a3437 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 2042 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &l=
t;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--5RKUDPdUVSA=--


--===============4717054935548801977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4717054935548801977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4717054935548801977==--

