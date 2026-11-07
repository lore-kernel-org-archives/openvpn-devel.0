Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CA6083602
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fGdjaOyR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iLZ44TN9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F597oUFn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RgwhBr9Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=7XNMiy8gXlXVDRxJltFjjmhryc6w6B8oyTI95Dqi1BY=; b=fGdjaOyRUutBqsxGuOCO6Q4UE6
	e+qKCfmct1Z1pqayAm7Uu/pVta490S2ab8GdT2Aj07/XwcY88jz9T1P2WW5HoDQng80sXHSO+1rPi
	wQSbN4urZzfIS1150VZcLftxlXEDRkUtS3gs5CyRwdKjvTF3N1ypk+s5Po055eQopqmg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPi7T-000000001yE-3oye;
	Sat, 07 Nov 2026 15:14:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPi7J-000000001uL-2CVf
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzmtLBLSqXp8771c9f0h/t/UA+ZAppElRTRLAa7/sSw=; b=iLZ44TN9xdHqiykX4gcSK8c97o
 pHx+e0NZFMT0XdV2XJ/ZV+yBqRMNPc9NlZ1tdiMqWbjmPGFimqjl2CbcvWAZwA4p+wTJgwNIxo8Ni
 X9I8SUTKJxKkWn/oc80QX4K0udbAGAuvVbV/5mYnN4atHwPYkIVDRlcYeatI6zdRomAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzmtLBLSqXp8771c9f0h/t/UA+ZAppElRTRLAa7/sSw=; b=F597oUFnTL1Q+K6w0GNDUymmbY
 /k8wE3ql8N/APWjOMKTEIHirpGU36Lcs4mTR7dW9wCMSvg2YVm8pMu580v8RfbvoopLo+o8P8s7ts
 1Gcm0iBYbQRAo2mCTXOivbixvHEGUHsgiwoJXfVwOcaH5Opk74xP3hppgeGqwDOtBRZI=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPi7H-0000000005b-3luS for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:05 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so966294f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794064437; x=1794669237; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KzmtLBLSqXp8771c9f0h/t/UA+ZAppElRTRLAa7/sSw=;
 b=RgwhBr9Q80SFPFHCECpoqyWbsdPo5Wp5CQV+5mLTNPoJwB1X+Dz/HHRSHDjayi9GIs
 4I7P+DaXYQC/k4zYGTt2wY+7f6OnVpSuqc8x9ONx+7QK6sLgCdYFsEiM9hhMYcezQXfQ
 PZh6aRaEpEwgfTVX7FnBycNvvwDC6YltGgrZHoYzrPWKZn9GCBuF4SaJCpXA2SW68a/F
 yQGAUNl1CbX6DhpEbgnsQcK7OOO41wA0bT4DuizCbXlppEWRzLuND2Jgsacu14pHIE1r
 tGShdC5uy9ItmuxyLqd5BTEfyGg2xnXohGZpk3YBTZFIb2yO92Up5fBUMxFAe8QrjMM9
 Cyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794064437; x=1794669237;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KzmtLBLSqXp8771c9f0h/t/UA+ZAppElRTRLAa7/sSw=;
 b=k0qnzY18gcPjochMw5RzsV12Q5JouTb0lwt9XotklMzmseivJ3o4s4JXRCkPLBE5/h
 OCWvuGInislaJRf3f61UDeC7dxz4Pbueez1yaI/0ntKSm1ETevVpnf799eRhYbX0O+qm
 WN2PQw2RyhSTNzomeVXhF1LDwN/tH8OuxXsRUAjrRXjqHG+Yuf8lcLjzqCaP7Zs7Pfpm
 d2XHeg6bkodSSn13XapXCYKEwrZybFc55dz3vgV4cwpstFmpMMgU2j6ROK2AH02YSeAU
 3R7UBUhlQd2g5JgFjh6wDILSWnoXOv1vAMrxbhOCIoyFzrTWqwPX9n9tP4Zr6/spxX3B
 5IKQ==
X-Gm-Message-State: APuU4Z9/dXoGYov4Zv6aIsU3upmXjbkvPRQ95UkB3FDbM8L1Ky/lW+cf
 CvagsdCD2L2mhxDdvasf3uWzD7BhcsLUVB1ad4550ZUJzv/tGb76H+3XYWWI93nueNQWIkQOnGr
 m23nVuOVJh56pSH1gwMUlx/Y/ox2AXTpkVQFw3ZZdhfI1NJOzL30Y6r5L+z9Rg4Y8eygGtbgkFw
 SQc2Z+Tw==
X-Gm-Gg: AYBFou2qZRoEG6qe7RTgIVMORXZDKZ7Deu2mExvijAyXZmsLCv0eG0UPrgtDvEUZGJn
 TYp0FcQJPJLWKq6hSJ7C1MXpyT8kwICmvqwDncO3h8FRmnX6WS4n0yioJY3MC2JqtegbnGicVi+
 HVVNziRTnOSZn8CuwkotoOmWrPKZENvxMz7VqTiHRrmeDP7nI4yRKEo1r1hP7j5/iDmQ7VFrcCE
 Ls3dypZxWqRiplsnXCxaqpqRehkZakV23D1P9vG0CoNLw+psgakhVbDKnIP1LP2hoePAYHLKj1u
 ZrgimwLanFyuX/gtNFZBb+TAOX+J0SnUB8GxnzF5JbPfgXspDg+QiEGvWYeskWwHf+/gAVWLK/D
 T+Z4AmrHnn13zoGrxNoa5zoYakZ1MXAeK2nnlsNcYlkYtSGZEB/7Uz/SPxzyCSxy1XQTCoCZSIC
 WRWfUkaZRnk+yvce5hPa3RwQqr9JJl1Grrlcb7R4Rj8AXbULqu5/iBGPaekBWQc7I33WuBMbr1A
 ek9L4sD9aJpx2icpmeFquVusL0FRRaF95FUvqMhk4BJlUyIP2z66BzhcWtQ2WO3jVcbKsz2uOhy
 HDkt5Bs5ZtAvr7Ss3AEzWsWEHiIgpKPIt5GieTbTSK+klpetPFwpJf4ctdG85gpHbJffruUwl6I
 Xezf+/FXNbsy4hr+QfDaoArB4zXxiW+7XOMQe6tEKJqpiapc01xT394zZW9DI4c6CTAEdSV++Wp
 VGJuj5MUdMGY9OPg==
X-Received: by 2002:a05:6000:25f7:b0:491:9fc1:e6c2 with SMTP id
 ffacd0b85a97d-4927807ea39mr10544754f8f.51.1794064437040; 
 Sat, 07 Nov 2026 07:13:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7701b51sm9648770f8f.37.2026.11.07.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:13:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 15:13:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
X-Gerrit-Change-Number: 2149
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2149?usp=email>
X-Gerrit-Commit: fe84554b29b3606dd25dcd6d8adb29cfcef5dcfc
References: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM0MDAwLkllZmNjM2NiOTBmM2U2YjAzNmE1ODRhNzQyNjg2NzhkYmMxN2RhNjlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0e13765cee505c225539e90508b838f39645120-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPi7H-0000000005b-3luS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused
 gc_arena variables
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0934875617526832663=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0934875617526832663==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yyMV6N5Mg/s="; charset=UTF-8

--yyMV6N5Mg/s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2149?usp=3Demail

to review the following change=2E
=


Change subject: Remove unused gc_arena variables
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove unused gc_arena variables

The=
se functions create and free a gc_arena they never allocate from=2E

Change=
-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec
M src/openvpn/manage=
=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn=
/plugin=2Ec
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/=
tun=2Ec
8 files changed, 0 insertions(+), 32 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/2149/1

diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index ff3bfe5=2E=2E3bc4de4 10=
0644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -117,8 +117,6=
 @@
             const char *ifconfig_remote, const char *context, const ch=
ar *signal_text,
             const char *script_type, struct env_set *es)
=
 {
-    struct gc_arena gc =3D gc_new();
-
     if (signal_text)
     {
   =
      setenv_str(es, "signal", signal_text);
@@ -174,8 +172,6 @@
         o=
penvpn_run_script(&argv, es, S_FATAL, "--up/--down");
         argv_free(&a=
rgv);
     }
-
-    gc_free(&gc);
 }
 
 /*
diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2E3410253 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2325,9 +2325,7 @@
 
    =
 if (!ignore_sys_error(err, crt_error))
     {
-        struct gc_arena gc =
=3D gc_new();
         msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", pr=
efix, strerror(err));
-        gc_free(&gc);
         return true;
     }
 =
    else
@@ -3151,11 +3149,8 @@
 management_notify_client_cr_response(unsig=
ned mda_key_id, const struct man_def_auth_context *mdac,
                  =
                    const struct env_set *es, const char *response)
 {
-   =
 struct gc_arena gc;
     if (management)
     {
-        gc =3D gc_new();
=
-
         msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s", mdac->cid, mda_ke=
y_id, response);
         man_output_extra_env(management, "CLIENT");
     =
    if (management->connection=2Eenv_filter_level > 0)
@@ -3163,7 +3158,6 @=
@
             man_output_peer_info_env(management, mdac);
         }
     =
    man_output_env(es, true, management->connection=2Eenv_filter_level, "CL=
IENT");
-        gc_free(&gc);
     }
 }
 
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index 3f514d6=2E=2E3e25a6e 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -726,7 +726,6 @@
 multi_crea=
te_instance(struct multi_context *m, const struct mroute_addr *real,
      =
                 struct link_socket *sock)
 {
-    struct gc_arena gc =3D g=
c_new();
     struct multi_instance *mi;
 
     msg(D_MULTI_MEDIUM, "MULTI:=
 multi_create_instance called");
@@ -792,12 +791,10 @@
     mi->ev_arg=2Ety=
pe =3D EVENT_ARG_MULTI_INSTANCE;
     mi->ev_arg=2Eu=2Emi =3D mi;
 
-    gc=
_free(&gc);
     return mi;
 
 err:
     multi_close_instance(m, mi, false)=
;
-    gc_free(&gc);
     return NULL;
 }
 
@@ -2243,7 +2240,6 @@
     if (=
mi->context=2Eoptions=2Eclient_connect_script)
     {
         struct argv =
argv =3D argv_new();
-        struct gc_arena gc =3D gc_new();
 
         s=
etenv_str(mi->context=2Ec2=2Ees, "script_type", "client-connect");
 
@@ -22=
79,7 +2275,6 @@
             ccs_delete_deferred_ret_file(mi);
         }
 =
        argv_free(&argv);
-        gc_free(&gc);
     }
     return ret;
 }=

diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=
=2Ec
index cfc0595=2E=2Eed4d742 100644
--- a/src/openvpn/options_string=2Ec=

+++ b/src/openvpn/options_string=2Ec
@@ -344,7 +344,6 @@
 bool
 options_cm=
p_equal_safe(char *actual, const char *expected, size_t actual_n)
 {
-    s=
truct gc_arena gc =3D gc_new();
     bool ret =3D true;
 
     if (actual_n=
 > 0)
@@ -360,7 +359,6 @@
             ret =3D !strcmp(actual, expected);
 =
        }
     }
-    gc_free(&gc);
     return ret;
 }
 
diff --git a/src/=
openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index 08461b8=2E=2Ed1f228e 1006=
44
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -560,7 +560=
,6 @@
 
     if (p->plugin_handle && (p->plugin_type_mask & OPENVPN_PLUGIN_=
MASK(type)))
     {
-        struct gc_arena gc =3D gc_new();
         stru=
ct argv a =3D argv_insert_head(av, p->so_pathname);
 
         dmsg(D_PLUGI=
N_DEBUG, "PLUGIN_CALL: PRE type=3D%s", plugin_type_name(type));
@@ -609,7 +=
608,6 @@
         }
 
         argv_free(&a);
-        gc_free(&gc);
     }=

     return status;
 }
diff --git a/src/openvpn/route=2Ec b/src/openvpn/ro=
ute=2Ec
index 53550c4=2E=2Ed0d26c6 100644
--- a/src/openvpn/route=2Ec
+++ b=
/src/openvpn/route=2Ec
@@ -3090,7 +3090,6 @@
 void
 get_default_gateway(str=
uct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-  =
  struct gc_arena gc =3D gc_new();
     int sd =3D -1;
     char best_name[=
IFNAMSIZ];
 
@@ -3216,7 +3215,6 @@
     {
         close(sd);
     }
-    g=
c_free(&gc);
 }
 
 /* IPv6 implementation using netlink
diff --git a/src/op=
envpn/socket=2Ec b/src/openvpn/socket=2Ec
index 307b5c6=2E=2E1fbd07b 100644=

--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -499,7 +499,6=
 @@
                      const struct addrinfo *local, bool do_listen,
   =
                   bool nowait, volatile int *signal_received)
 {
-    stru=
ct gc_arena gc =3D gc_new();
     socket_descriptor_t new_sd =3D SOCKET_UND=
EFINED;
 
     CLEAR(*act);
@@ -521,7 +520,6 @@
         get_signal(signal_=
received);
         if (*signal_received)
         {
-            gc_free(&=
gc);
             return sd;
         }
 
@@ -552,7 +550,6 @@
 
     tcp_co=
nnection_established(act);
 
-    gc_free(&gc);
     return new_sd;
 }
 
@@=
 -803,8 +800,6 @@
 static void
 resolve_bind_local(struct link_socket *sock=
)
 {
-    struct gc_arena gc =3D gc_new();
-
     /* resolve local address =
if undefined */
     if (!sock->info=2Elsa->bind_local)
     {
@@ -846,8 +8=
41,6 @@
             sock->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bin=
d_local->ai_family;
         }
     }
-
-    gc_free(&gc);
 }
 
 static voi=
d
@@ -2673,7 +2666,6 @@
 void
 socket_bind_unix(socket_descriptor_t sd, str=
uct sockaddr_un *local, const char *prefix)
 {
-    struct gc_arena gc =3D =
gc_new();
     const mode_t orig_umask =3D umask(0);
 
     if (bind(sd, (s=
truct sockaddr *)local, sizeof(struct sockaddr_un)))
@@ -2683,7 +2675,6 @@
=
     }
 
     umask(orig_umask);
-    gc_free(&gc);
 }
 
 socket_descriptor=
_t
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 943ad9f=2E=
=2Ebcea331 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -6=
66,7 +666,6 @@
 void
 warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)=

 {
-    struct gc_arena gc =3D gc_new();
     struct route_gateway_info rg=
i;
     const unsigned int needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFIN=
ED);
 
@@ -680,7 +679,6 @@
                 "NOTE: your local LAN uses the =
extremely common subnet address 192=2E168=2E0=2Ex or 192=2E168=2E1=2Ex=2E  =
Be aware that this might create routing conflicts if you connect to the VPN=
 server from public locations such as internet cafes that use the same subn=
et=2E");
         }
     }
-    gc_free(&gc);
 }
 
 /*

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17d=
a69f
Gerrit-Change-Number: 2149
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--yyMV6N5Mg/s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove unused gc_arena variables<br><br>These functions=
 create and free a gc_arena they never allocate from=2E<br><br>Change-Id: I=
efcc3cb90f3e6b036a584a74268678dbc17da69f<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/ope=
nvpn/manage=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options_string=
=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvp=
n/socket=2Ec<br>M src/openvpn/tun=2Ec<br>8 files changed, 0 insertions(+), =
32 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/49/2149/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index ff3bfe5=2E=2E3bc4de=
4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/s=
rc/openvpn/init=2Ec</span><br><span>@@ -117,8 +117,6 @@</span><br><span>   =
          const char *ifconfig_remote, const char *context, const char *sig=
nal_text,</span><br><span>             const char *script_type, struct env_=
set *es)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     if (signal_text)</span><br><span=
>     {</span><br><span>         setenv_str(es, &quot;signal&quot;, signal_=
text);</span><br><span>@@ -174,8 +172,6 @@</span><br><span>         openvpn=
_run_script(&amp;argv, es, S_FATAL, &quot;--up/--down&quot;);</span><br><sp=
an>         argv_free(&amp;argv);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </s=
pan><br><span> /*</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec</span><br><span>index 58f63e6=2E=2E3410253 100644</span=
><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/m=
anage=2Ec</span><br><span>@@ -2325,9 +2325,7 @@</span><br><span> </span><br=
><span>     if (!ignore_sys_error(err, crt_error))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena=
 gc =3D gc_new();</span><br><span>         msg(D_MANAGEMENT, &quot;MANAGEME=
NT: TCP %s error: %s&quot;, prefix, strerror(err));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span> =
        return true;</span><br><span>     }</span><br><span>     else</span=
><br><span>@@ -3151,11 +3149,8 @@</span><br><span> management_notify_client=
_cr_response(unsigned mda_key_id, const struct man_def_auth_context *mdac,<=
/span><br><span>                                      const struct env_set =
*es, const char *response)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct gc_arena gc;</span><br><span>     if (ma=
nagement)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        gc =3D gc_new();</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         msg(M_CLIENT, &quot;&gt;CLIENT:CR_R=
ESPONSE,%lu,%u,%s&quot;, mdac-&gt;cid, mda_key_id, response);</span><br><sp=
an>         man_output_extra_env(management, &quot;CLIENT&quot;);</span><br=
><span>         if (management-&gt;connection=2Eenv_filter_level &gt; 0)</s=
pan><br><span>@@ -3163,7 +3158,6 @@</span><br><span>             man_output=
_peer_info_env(management, mdac);</span><br><span>         }</span><br><spa=
n>         man_output_env(es, true, management-&gt;connection=2Eenv_filter_=
level, &quot;CLIENT&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        gc_free(&amp;gc);</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E3e25a6e 100644</span><b=
r><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -726,7 +726,6 @@</span><br><span> multi_create_inst=
ance(struct multi_context *m, const struct mroute_addr *real,</span><br><sp=
an>                       struct link_socket *sock)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct multi_instance *mi;</span><br><span>=
 </span><br><span>     msg(D_MULTI_MEDIUM, &quot;MULTI: multi_create_instan=
ce called&quot;);</span><br><span>@@ -792,12 +791,10 @@</span><br><span>   =
  mi-&gt;ev_arg=2Etype =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span>     m=
i-&gt;ev_arg=2Eu=2Emi =3D mi;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return=
 mi;</span><br><span> </span><br><span> err:</span><br><span>     multi_clo=
se_instance(m, mi, false);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    gc_free(&amp;gc);</span><br><span>     return NULL;</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -2243,7 +2240,6 @@</span><br><spa=
n>     if (mi-&gt;context=2Eoptions=2Eclient_connect_script)</span><br><spa=
n>     {</span><br><span>         struct argv argv =3D argv_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D=
 gc_new();</span><br><span> </span><br><span>         setenv_str(mi-&gt;con=
text=2Ec2=2Ees, &quot;script_type&quot;, &quot;client-connect&quot;);</span=
><br><span> </span><br><span>@@ -2279,7 +2275,6 @@</span><br><span>        =
     ccs_delete_deferred_ret_file(mi);</span><br><span>         }</span><br=
><span>         argv_free(&amp;argv);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span>     }</span><br>=
<span>     return ret;</span><br><span> }</span><br><span>diff --git a/src/=
openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</span><br><span=
>index cfc0595=2E=2Eed4d742 100644</span><br><span>--- a/src/openvpn/option=
s_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=2Ec</span><br=
><span>@@ -344,7 +344,6 @@</span><br><span> bool</span><br><span> options_c=
mp_equal_safe(char *actual, const char *expected, size_t actual_n)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D true;</span><br=
><span> </span><br><span>     if (actual_n &gt; 0)</span><br><span>@@ -360,=
7 +359,6 @@</span><br><span>             ret =3D !strcmp(actual, expected);=
</span><br><span>         }</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>     ret=
urn ret;</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index 08461=
b8=2E=2Ed1f228e 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><=
br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -560,7 +560,6 @@</=
span><br><span> </span><br><span>     if (p-&gt;plugin_handle &amp;&amp; (p=
-&gt;plugin_type_mask &amp; OPENVPN_PLUGIN_MASK(type)))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_=
arena gc =3D gc_new();</span><br><span>         struct argv a =3D argv_inse=
rt_head(av, p-&gt;so_pathname);</span><br><span> </span><br><span>         =
dmsg(D_PLUGIN_DEBUG, &quot;PLUGIN_CALL: PRE type=3D%s&quot;, plugin_type_na=
me(type));</span><br><span>@@ -609,7 +608,6 @@</span><br><span>         }</=
span><br><span> </span><br><span>         argv_free(&amp;a);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br>=
<span>     }</span><br><span>     return status;</span><br><span> }</span><=
br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><=
br><span>index 53550c4=2E=2Ed0d26c6 100644</span><br><span>--- a/src/openvp=
n/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ =
-3090,7 +3090,6 @@</span><br><span> void</span><br><span> get_default_gatew=
ay(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct gc_arena gc =3D gc_new();</span><br><span>     int sd =3D -1;</span=
><br><span>     char best_name[IFNAMSIZ];</span><br><span> </span><br><span=
>@@ -3216,7 +3215,6 @@</span><br><span>     {</span><br><span>         clos=
e(sd);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><b=
r><span> /* IPv6 implementation using netlink</span><br><span>diff --git a/=
src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 307b5=
c6=2E=2E1fbd07b 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><=
br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -499,7 +499,6 @@</=
span><br><span>                      const struct addrinfo *local, bool do_=
listen,</span><br><span>                      bool nowait, volatile int *si=
gnal_received)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     socke=
t_descriptor_t new_sd =3D SOCKET_UNDEFINED;</span><br><span> </span><br><sp=
an>     CLEAR(*act);</span><br><span>@@ -521,7 +520,6 @@</span><br><span>  =
       get_signal(signal_received);</span><br><span>         if (*signal_re=
ceived)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            gc_free(&amp;gc);</span><br><span>             ret=
urn sd;</span><br><span>         }</span><br><span> </span><br><span>@@ -55=
2,7 +550,6 @@</span><br><span> </span><br><span>     tcp_connection_establi=
shed(act);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    gc_free(&amp;gc);</span><br><span>     return new_sd;</span><br>=
<span> }</span><br><span> </span><br><span>@@ -803,8 +800,6 @@</span><br><s=
pan> static void</span><br><span> resolve_bind_local(struct link_socket *so=
ck)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     /* resolve local address if undefined=
 */</span><br><span>     if (!sock-&gt;info=2Elsa-&gt;bind_local)</span><br=
><span>     {</span><br><span>@@ -846,8 +841,6 @@</span><br><span>         =
    sock-&gt;info=2Eaf =3D (sa_family_t)sock-&gt;info=2Elsa-&gt;bind_local-=
&gt;ai_family;</span><br><span>         }</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span>@@ -2673,7 +2666,6 @@</s=
pan><br><span> void</span><br><span> socket_bind_unix(socket_descriptor_t s=
d, struct sockaddr_un *local, const char *prefix)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span>     const mode_t orig_umask =3D umask(0);</span><=
br><span> </span><br><span>     if (bind(sd, (struct sockaddr *)local, size=
of(struct sockaddr_un)))</span><br><span>@@ -2683,7 +2675,6 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     umask(orig_umask);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span>=
<br><span> }</span><br><span> </span><br><span> socket_descriptor_t</span><=
br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><=
span>index 943ad9f=2E=2Ebcea331 100644</span><br><span>--- a/src/openvpn/tu=
n=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -666,7 +=
666,6 @@</span><br><span> void</span><br><span> warn_on_use_of_common_subne=
ts(openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><spa=
n>     struct route_gateway_info rgi;</span><br><span>     const unsigned i=
nt needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);</span><br><span> </=
span><br><span>@@ -680,7 +679,6 @@</span><br><span>                 &quot;N=
OTE: your local LAN uses the extremely common subnet address 192=2E168=2E0=
=2Ex or 192=2E168=2E1=2Ex=2E  Be aware that this might create routing confl=
icts if you connect to the VPN server from public locations such as interne=
t cafes that use the same subnet=2E&quot;);</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> /*=
</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2149?usp=3Demail">change 2149</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678db=
c17da69f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2149 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--yyMV6N5Mg/s=--


--===============0934875617526832663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0934875617526832663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0934875617526832663==--

