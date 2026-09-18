Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C3C982D7
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/X2gxnG0XMoPpCvQ4m0lCPBlP609tA9FMoTHcL816o=; b=FBFOU54OPikJw04j47zsJAE1Bf
	+8zm8CdZNHy+vs/i5WitgOI2NEP1h+LH/8Sr6oZh9tbEDd+CDEbiz+Cc++881C24fpDX5l9eBa7Tq
	WWeBzlO2VOlFgEy/NxTnufyEHwiE6rsVYkdKMc+zWxVzWHG7lmExTaWyx4JIOkj0uO2c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7g3G-0006qG-To;
	Fri, 18 Sep 2026 21:23:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7g3G-0006qA-19
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BI7zLf6UMvcGBdRzZuOdjQDU1HVn+5h1rm376GmiWi8=; b=IvJBa6nK7xSW9l1+2N++uRKF3s
 iB0LMo+M5vbSzdmbV48scyTfycgTQFq3mluaE8OnUki3iAf6i7nqdpk2FgF4KjvJ3KQgS3mzgQbzV
 pYWYxijaiREDnCvkd6ZHATiPgWBaSbo2jDiaL9O6skQ5aAhwZZN2YXYfar/3p5dYqGx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BI7zLf6UMvcGBdRzZuOdjQDU1HVn+5h1rm376GmiWi8=; b=A
 n3nhRvMHnitmkaeeI2hjlD9+CieY78vAkqfKmq+HOsxarckOPO/gNeA1aF4gtagsSZBhG/MUh0kF4
 Dz8AmCeZPjboXIOE7HW5836LVLK6nw5VsVIsROrhRHwkht+mAzcJ+DgOpGyZzcWNlMPnWRIEc4gaY
 lFWCJ97bCklALXe0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7g3E-0004yx-CC for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 21:23:22 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so6872485e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789766594; x=1790371394; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BI7zLf6UMvcGBdRzZuOdjQDU1HVn+5h1rm376GmiWi8=;
 b=M+T4k/Xpt671kGc8kJrk/10gCI8+uo7MQjkKIZXIXNkMPoeVwMpl2Ekrd8Og3pHDQv
 b5JXFPgi9AtvXSrH+Y8BkDAO71fqdBFtRhfTctOGfIFKv667USlnSBE6oL4GWv29zeaO
 oIDx5q+w9iE8RCkGvfTdjMqlkUCHXe69sVrcTgJ5Ur75U+4oeInFQ9LOtLfbFrVscJlA
 nN2SvbMAxi4vBn/NMy3ytA1VF6oAK9dWMvCN3/HmM4sCcMPn0YxcUKPA6lGMZkpnY4xA
 S1fl7SzSWNpjM3zLCJEbDLuG6hRfv+Qdo01+ILGMAgEiDuez3kwbLFPSlgBU4tIlV/Tz
 kVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789766594; x=1790371394;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BI7zLf6UMvcGBdRzZuOdjQDU1HVn+5h1rm376GmiWi8=;
 b=X4iw9X6GYfVbhXfCstwkXLKD+bg9xy/iUYWSFEFlgcwAQprr7ZxhZK/DwYvcqLAsXq
 ftgE0FStGdTKCPkHiEoR5y3tWSEyqqtMLGh4ng9ry4GaetVyToGgw0NNy26wDfY+c/Q3
 o8gCtlP9+z16G+D8Z3l5z5Wh+kQllPybHKr08uud241KA1lCPAXe+xChdLlCNXJoH/kt
 weoBCVU2OJyVltrtlbpU0aMa4L6H9KCppcadHLvKVi2oACYnSfupvxaxceghj3RdG6Um
 v2gdoI341dyJWYMp/OvNZTU8+Sa82NOblmJw1BbrbhyZvhSC5OaLtvAOJzLV5QgC9OQD
 DTpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCQV67P2ONkZ91pzWzf3cy7LN6okWXxkT4igJIz8LtKxSA2majXVNTd7RrJ8RUn/GUSXFtQO31KtRh+5Q9@lists.sourceforge.net
X-Gm-Message-State: AFuF++mJ9gA1N9Y9FiFw2B7MFQAUm4AXKD06u3dWkWuu+0upgHF4Ua27
 AiXaJ6JhKMFCFxDHt3nstENEp2qfXmXnXzURdhB53KiFUZiJ4dfsXKXU3W1FzddvahYqpEWEHlb
 NVxjYNeg6zqfbXlx+xehQlm0v4Tyj+b8VR2nlMuJAOsXldAg0O2bBlthhkdRbC8npuuFmCUqPWY
 v9QoDTBw==
X-Gm-Gg: AYBFou2rkE0s5qitqTaPH7HVlODXjtj1f31zmQXEgbbhRmO/T0x7n2f31k4WnahFkma
 /IFjMovzgTilazx0U+xV02c3gDgaiEEGEHP45VdMxP0LON15J4LYdeP2quqvQaAs/OPmWN9P/tz
 TinpSawjpyXlZoCkSbbm0WStUGw/B0nHHcVnYYv5OhzKYw2BtvZBd3jdS75kB2Am3qiFtQBU2rD
 PcM8QnfDTBAPooQFl3JOIqrzV2+Sc3SYySx0PaADrTOACvhM3Zx1I3G7azCKxVkildxBYWbLTpp
 8pLW0/hjELUyLQ7427pQaavJiw8Uw2Ym16bB0SeEL5TNC0s8v8X2J7adK/aGqd3NquU12He639D
 klwq6ADs4j9giKrkwix7EIZ+LcLG4GXtdBHeYKJTvfN6Eq2neSDGq7OwjjbL4gICyKp8TkmpaN1
 E9qPWdgh7j8asftgGcOo/5bb8T0RSQVwYYmNCymNLVcJYCJ1L2Ev6BtoeJmXuG/tB6C9GZ1IGDz
 qGYh6n0pBg4r1PfL+veGjQZhqqJmsEvWEQ4daSpF09WpC5p+A2NDH6eq2rWloo1JlfTfgeyU0MK
 xy/OUjuCbG3VF2NlNBeD5akWkrgUtw/m5dPOUPri8qelqNXMBFZ2tV12vHkiQ3YFM+YiiSM=
X-Received: by 2002:a05:600c:530f:b0:49d:243a:e4f9 with SMTP id
 5b1f17b1804b1-49fc56cb197mr48883045e9.10.1789766593108; 
 Fri, 18 Sep 2026 14:23:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd074336sm21531225e9.8.2026.09.18.14.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 14:23:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 21:23:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
 ralf_lici <ralf@mandelbit.com>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 6b5f8ff6763307e659b32a4bf47967abf8cb9311
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <455541e98ff933e0ebbed6d5cd86b01bd668412e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7g3E-0004yx-CC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 lstipakov@gmail.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7351573557808395352=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7351573557808395352==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4bWqao2jQtE="; charset=UTF-8

--4bWqao2jQtE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos, Code-Review+2 by ralf_lici, Code-Review+2 by stipa


Change subject:=
 dco: do not exit the process when installing a DCO key fails
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: do not exit the proc=
ess when installing a DCO key fails

When the DCO peer is gone from the ker=
nel while userspace still believes
it exists, dco_new_key() fails with ENOE=
NT and init_key_contexts() calls
msg(M_FATAL, =2E=2E=2E)=2E On a server thi=
s terminates the whole daemon and
disconnects every other client, even thou=
gh only a single peer is
affected=2E

Propagate the failure instead=2E Sinc=
e a DCO desync needs a different
recovery than any other key generation err=
or - the kernel peer has to be
re-created, which only a reconnect can do - =
report it as a distinct
key_gen_status through generate_key_expansion() and=

tls_session_generate_data_channel_keys(), and let tls_multi_process()
turn=
 it into a new TLSMP_RESTART result that check_tls() dispatches as a
SIGUSR=
1=2E On a server this restarts only the affected client instance=2E

The re=
start request is tracked separately from 'active' because it must
not be ov=
erwritten by a later TLSMP_ACTIVE or TLSMP_RECONNECT
assignment, and the re=
turn value now applies an explicit precedence:
killing the session supersed=
es restarting it, which supersedes 'active'=2E

tls_session_update_crypto_p=
arams_do_work() collapses the desync back to
a plain failure, as all of its=
 callers already turn a failure into a
SIGUSR1=2E

Note that commit ea3bb67=
e2b1e ("dco: make key state desync recoverable")
does not cover this case, =
as both of its hunks are conditional on the
key installation having succeed=
ed=2E

Github: fixes OpenVPN/openvpn#542
Change-Id: I564edc6e0cc179c2b8b5dd=
ef5e80838949fe9fcd
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835
Message-Id: <20260806120220=2E3806-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38176=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/openvpn/ssl=2E=
c
M src/openvpn/ssl=2Eh
3 files changed, 73 insertions(+), 22 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/183=
5/4

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 8=
3cd113=2E=2E6fe5849 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/=
forward=2Ec
@@ -206,6 +206,12 @@
                 register_signal(c->sig, S=
IGTERM, "auth-control-exit");
             }
         }
+        else if (t=
mp_status =3D=3D TLSMP_RESTART)
+        {
+            /* The session cann=
ot recover on its own=2E Kill the connection so
+             * that it is =
set up again from scratch */
+            register_signal(c->sig, SIGUSR1, =
"dco key state desync");
+        }
 
         interval_future_trigger(&c->=
c2=2Etmp_int, wakeup);
     }
diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index ddbf067=2E=2E2a115d4 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -1401,7 +1401,22 @@
     secure_memzero(&e1_recv, s=
izeof(e1_recv));
 }
 
-static void
+/**
+ * Outcome of generating the data =
channel keys of a session=2E
+ *
+ * \c KEY_GEN_DCO_DESYNC is kept distinct=
 from \c KEY_GEN_FAILED because it
+ * means userspace and kernel disagree =
about the DCO peer: the session cannot
+ * recover on its own and the conne=
ction has to be restarted, while any other
+ * failure only invalidates the=
 affected key state=2E
+ */
+enum key_gen_status
+{
+    KEY_GEN_OK,       =
  /**< keys were generated and installed */
+    KEY_GEN_FAILED,     /**< g=
eneration failed, invalidate the key state */
+    KEY_GEN_DCO_DESYNC, /**<=
 the DCO peer is gone from the kernel */
+};
+
+static enum key_gen_status
=
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
                   bool server, const struct key2 *=
key2, bool dco)
 {
@@ -1420,7 +1435,16 @@
         int ret =3D init_key_dco=
_bi(multi, ks, key2, key_direction, key_type->cipher, server);
         if =
(ret < 0)
         {
-            msg(M_FATAL, "Impossible to install key m=
aterial in DCO: %s", strerror(-ret));
+            /* This normally means t=
he DCO peer is gone from the kernel while
+             * userspace still b=
elieves it exists=2E Do not take the whole
+             * process down ove=
r a single peer: report the desync so that the
+             * connection i=
s restarted and the peer re-created from scratch */
+            msg(M_WARN=
,
+                "Impossible to install key material in DCO: %s=2E The un=
derlying "
+                "DCO peer may have been deleted from the kernel=
 without "
+                "notifying userspace=2E Restarting the session=
=2E",
+                strerror(-ret));
+            return KEY_GEN_DCO_DES=
YNC;
         }
 
         /* encrypt/decrypt context are unused with DCO *=
/
@@ -1443,6 +1467,8 @@
     {
         init_key_ctx_bi(key, key2, key_dire=
ction, key_type, "Data Channel");
     }
+
+    return KEY_GEN_OK;
 }
 
 st=
atic bool
@@ -1503,11 +1529,11 @@
  * Using source entropy from local and r=
emote hosts, mix into
  * master key=2E
  */
-static bool
+static enum key_=
gen_status
 generate_key_expansion(struct tls_multi *multi, struct key_stat=
e *ks, struct tls_session *session)
 {
     const struct key_ctx_bi *key =
=3D &ks->crypto_options=2Ekey_ctx_bi;
-    bool ret =3D false;
+    enum ke=
y_gen_status ret =3D KEY_GEN_FAILED;
     struct key2 key2;
 
     if (key-=
>initialized)
@@ -1552,8 +1578,8 @@
         }
     }
 
-    init_key_conte=
xts(ks, multi, &session->opt->key_type, server, &key2, session->opt->dco_en=
abled);
-    ret =3D true;
+    ret =3D init_key_contexts(ks, multi, &sessi=
on->opt->key_type, server, &key2,
+                            session->opt=
->dco_enabled);
 
 exit:
     secure_memzero(&key2, sizeof(key2));
@@ -1567=
,10 +1593,10 @@
  * This erases the source material used to generate the da=
ta channel keys, and
  * can thus be called only once per session=2E
  */
-=
bool
+static enum key_gen_status
 tls_session_generate_data_channel_keys(st=
ruct tls_multi *multi, struct tls_session *session)
 {
-    bool ret =3D fa=
lse;
+    enum key_gen_status ret =3D KEY_GEN_FAILED;
     struct key_state=
 *ks =3D &session->key[KS_PRIMARY]; /* primary key */
 
     if (ks->authen=
ticated <=3D KS_AUTH_FALSE)
@@ -1581,7 +1607,8 @@
 
     ks->crypto_options=
=2Eflags =3D session->opt->crypto_flags;
 
-    if (!generate_key_expansion=
(multi, ks, session))
+    ret =3D generate_key_expansion(multi, ks, sessio=
n);
+    if (ret !=3D KEY_GEN_OK)
     {
         msg(D_TLS_ERRORS, "TLS Er=
ror: generate_key_expansion failed");
         goto cleanup;
@@ -1593,7 +16=
20,6 @@
     /* set the state of the keys for the session to generated */
 =
    ks->state =3D S_GENERATED_KEYS;
 
-    ret =3D true;
 cleanup:
     sec=
ure_memzero(ks->key_src, sizeof(*ks->key_src));
     return ret;
@@ -1665,7=
 +1691,10 @@
             }
         }
     }
-    return tls_session_gener=
ate_data_channel_keys(multi, session);
+    /* A DCO desync is reported as =
a plain failure here: every caller of this
+     * function already turns a=
 failure into a SIGUSR1, which is exactly the
+     * recovery a desync nee=
ds */
+    return tls_session_generate_data_channel_keys(multi, session) =
=3D=3D KEY_GEN_OK;
 }
 
 bool
@@ -3336,6 +3365,9 @@
     struct gc_arena gc=
 =3D gc_new();
     int active =3D TLSMP_INACTIVE;
     bool error =3D fals=
e;
+    /* kept separate from 'active' on purpose: a restart request must n=
ot be
+     * overwritten by a later TLSMP_ACTIVE/TLSMP_RECONNECT assignmen=
t */
+    bool restart =3D false;
 
     tls_clear_error();
 
@@ -3436,12 +=
3468,22 @@
             /* Session is now fully authenticated=2E
          =
    * tls_session_generate_data_channel_keys will move ks->state
          =
    * from S_ACTIVE to S_GENERATED_KEYS */
-            if (!tls_session_ge=
nerate_data_channel_keys(multi, session))
+            enum key_gen_status =
status =3D tls_session_generate_data_channel_keys(multi, session);
+       =
     if (status !=3D KEY_GEN_OK)
             {
                 msg(D_TLS_=
ERRORS, "TLS Error: generate_key_expansion failed");
                 ks->a=
uthenticated =3D KS_AUTH_FALSE;
                 key_state_ssl_shutdown(&ks=
->ks_ssl);
                 ks->state =3D S_ERROR_PRE;
+
+                /=
* Invalidating the key state is not enough to recover from a
+             =
    * DCO desync: the kernel peer has to be re-created, and the
+          =
       * key state we just invalidated will never be retried, so ask
+     =
            * for a restart right away */
+                if (status =3D=
=3D KEY_GEN_DCO_DESYNC)
+                {
+                    restart =3D=
 true;
+                }
             }
 
             /* Update auth toke=
n on the client if needed on renegotiation
@@ -3529,7 +3571,17 @@
 
     gc=
_free(&gc);
 
-    return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_KI=
LL : active;
+    /* strongest outcome wins: killing the session supersedes=
 restarting it,
+     * and restarting supersedes whatever 'active' ended u=
p being */
+    if (tas =3D=3D TLS_AUTHENTICATION_FAILED)
+    {
+        r=
eturn TLSMP_KILL;
+    }
+    if (restart)
+    {
+        return TLSMP_RES=
TART;
+    }
+    return active;
 }
 
 /**
diff --git a/src/openvpn/ssl=2Eh=
 b/src/openvpn/ssl=2Eh
index 7ddf965=2E=2E5483fbb 100644
--- a/src/openvpn/=
ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -231,6 +231,8 @@
 #define TLSMP_ACTIVE=
    1
 #define TLSMP_KILL      2
 #define TLSMP_RECONNECT 3
+/** the sessio=
n cannot recover on its own and has to be restarted */
+#define TLSMP_RESTA=
RT   4
 
 /*
  * Called by the top-level event loop=2E
@@ -554,15 +556,6 @@=

 void show_available_tls_ciphers(const char *cipher_list, const char *ciph=
er_list_tls13,
                                 const char *tls_cert_profil=
e);
 
-
-/**
- * Generate data channel keys for the supplied TLS session=2E=

- *
- * This erases the source material used to generate the data channel =
keys, and
- * can thus be called only once per session=2E
- */
-bool tls_se=
ssion_generate_data_channel_keys(struct tls_multi *multi, struct tls_sessio=
n *session);
-
 void tls_session_soft_reset(struct tls_multi *multi);
 
 /*=
*

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179=
c2b8b5ddef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 4
Ge=
rrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
=
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--4bWqao2jQtE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos, Code-Review+2 by ralf_lici, Code-Review+2 by =
stipa</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: do not exit the process when installing a DCO k=
ey fails<br><br>When the DCO peer is gone from the kernel while userspace s=
till believes<br>it exists, dco_new_key() fails with ENOENT and init_key_co=
ntexts() calls<br>msg(M_FATAL, =2E=2E=2E)=2E On a server this terminates th=
e whole daemon and<br>disconnects every other client, even though only a si=
ngle peer is<br>affected=2E<br><br>Propagate the failure instead=2E Since a=
 DCO desync needs a different<br>recovery than any other key generation err=
or - the kernel peer has to be<br>re-created, which only a reconnect can do=
 - report it as a distinct<br>key_gen_status through generate_key_expansion=
() and<br>tls_session_generate_data_channel_keys(), and let tls_multi_proce=
ss()<br>turn it into a new TLSMP_RESTART result that check_tls() dispatches=
 as a<br>SIGUSR1=2E On a server this restarts only the affected client inst=
ance=2E<br><br>The restart request is tracked separately from &#39;active&#=
39; because it must<br>not be overwritten by a later TLSMP_ACTIVE or TLSMP_=
RECONNECT<br>assignment, and the return value now applies an explicit prece=
dence:<br>killing the session supersedes restarting it, which supersedes &#=
39;active&#39;=2E<br><br>tls_session_update_crypto_params_do_work() collaps=
es the desync back to<br>a plain failure, as all of its callers already tur=
n a failure into a<br>SIGUSR1=2E<br><br>Note that commit ea3bb67e2b1e (&quo=
t;dco: make key state desync recoverable&quot;)<br>does not cover this case=
, as both of its hunks are conditional on the<br>key installation having su=
cceeded=2E<br><br>Github: fixes OpenVPN/openvpn#542<br>Change-Id: I564edc6e=
0cc179c2b8b5ddef5e80838949fe9fcd<br>Signed-off-by: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835<=
br>Message-Id: &lt;20260806120220=2E3806-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg38176=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/ssl=2Ec<br>M src=
/openvpn/ssl=2Eh<br>3 files changed, 73 insertions(+), 22 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/35/1835/4</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/o=
penvpn/forward=2Ec</span><br><span>index 83cd113=2E=2E6fe5849 100644</span>=
<br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/f=
orward=2Ec</span><br><span>@@ -206,6 +206,12 @@</span><br><span>           =
      register_signal(c-&gt;sig, SIGTERM, &quot;auth-control-exit&quot;);</=
span><br><span>             }</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else if (tmp_status =3D=3D TLS=
MP_RESTART)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* The=
 session cannot recover on its own=2E Kill the connection so</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * that it is set up a=
gain from scratch */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            register_signal(c-&gt;sig, SIGUSR1, &quot;dco key state desync=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span> </span><br><span>         interval_future_trigger(&amp;c-&g=
t;c2=2Etmp_int, wakeup);</span><br><span>     }</span><br><span>diff --git =
a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index ddbf067=
=2E=2E2a115d4 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1401,7 +1401,22 @@</span>=
<br><span>     secure_memzero(&amp;e1_recv, sizeof(e1_recv));</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Outcome of generati=
ng the data channel keys of a session=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * \c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED becaus=
e it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * means usersp=
ace and kernel disagree about the DCO peer: the session cannot</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * recover on its own and the co=
nnection has to be restarted, while any other</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * failure only invalidates the affected key stat=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+enum key_gen_status</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    KEY_GEN_OK,         /**&lt; keys were generat=
ed and installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    KEY_GEN_FAILED,     /**&lt; generation failed, invalidate the key state=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    KEY_GEN_DCO_=
DESYNC, /**&lt; the DCO peer is gone from the kernel */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static enum key_gen_status</span><br><span> init_key_contexts(struct key_st=
ate *ks, struct tls_multi *multi, const struct key_type *key_type,</span><b=
r><span>                   bool server, const struct key2 *key2, bool dco)<=
/span><br><span> {</span><br><span>@@ -1420,7 +1435,16 @@</span><br><span> =
        int ret =3D init_key_dco_bi(multi, ks, key2, key_direction, key_typ=
e-&gt;cipher, server);</span><br><span>         if (ret &lt; 0)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(M_FATAL, &quot;Impossible to install key material in DCO: %s&quot=
;, strerror(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* This normally means the DCO peer is gone from the kernel whi=
le</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * us=
erspace still believes it exists=2E Do not take the whole</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             * process down over a si=
ngle peer: report the desync so that the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * connection is restarted and the peer re=
-created from scratch */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                &quot;Impossible to install key material in DCO: %=
s=2E The underlying &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                &quot;DCO peer may have been deleted from the kernel=
 without &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            &quot;notifying userspace=2E Restarting the session=2E&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                strer=
ror(-ret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return KEY_GEN_DCO_DESYNC;</span><br><span>         }</span><br><span> =
</span><br><span>         /* encrypt/decrypt context are unused with DCO */=
</span><br><span>@@ -1443,6 +1467,8 @@</span><br><span>     {</span><br><sp=
an>         init_key_ctx_bi(key, key2, key_direction, key_type, &quot;Data =
Channel&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return KEY_GEN_OK;</span><br><span> }</span><br><span> </span><br><span=
> static bool</span><br><span>@@ -1503,11 +1529,11 @@</span><br><span>  * U=
sing source entropy from local and remote hosts, mix into</span><br><span> =
 * master key=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static enum key_gen_status</span><br><span> generate_key_expansion(=
struct tls_multi *multi, struct key_state *ks, struct tls_session *session)=
</span><br><span> {</span><br><span>     const struct key_ctx_bi *key =3D &=
amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN_FAILED;</span=
><br><span>     struct key2 key2;</span><br><span> </span><br><span>     if=
 (key-&gt;initialized)</span><br><span>@@ -1552,8 +1578,8 @@</span><br><spa=
n>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_key_contexts(ks, multi, &amp;sessi=
on-&gt;opt-&gt;key_type, server, &amp;key2, session-&gt;opt-&gt;dco_enabled=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D init_key_=
contexts(ks, multi, &amp;session-&gt;opt-&gt;key_type, server, &amp;key2,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       session-&gt;opt-&gt;dco_enabled);</span><br><span> </span><br><span>=
 exit:</span><br><span>     secure_memzero(&amp;key2, sizeof(key2));</span>=
<br><span>@@ -1567,10 +1593,10 @@</span><br><span>  * This erases the sourc=
e material used to generate the data channel keys, and</span><br><span>  * =
can thus be called only once per session=2E</span><br><span>  */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static enum key_gen_status</span><br><span> tls=
_session_generate_data_channel_keys(struct tls_multi *multi, struct tls_ses=
sion *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    enum key_gen_status ret =3D KEY_GEN_FAILED;</span><br><=
span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* pri=
mary key */</span><br><span> </span><br><span>     if (ks-&gt;authenticated=
 &lt;=3D KS_AUTH_FALSE)</span><br><span>@@ -1581,7 +1607,8 @@</span><br><sp=
an> </span><br><span>     ks-&gt;crypto_options=2Eflags =3D session-&gt;opt=
-&gt;crypto_flags;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!generate_key_expansion(multi, ks, session))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D generate_key_ex=
pansion(multi, ks, session);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (ret !=3D KEY_GEN_OK)</span><br><span>     {</span><br><spa=
n>         msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansion failed=
&quot;);</span><br><span>         goto cleanup;</span><br><span>@@ -1593,7 =
+1620,6 @@</span><br><span>     /* set the state of the keys for the sessio=
n to generated */</span><br><span>     ks-&gt;state =3D S_GENERATED_KEYS;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
et =3D true;</span><br><span> cleanup:</span><br><span>     secure_memzero(=
ks-&gt;key_src, sizeof(*ks-&gt;key_src));</span><br><span>     return ret;<=
/span><br><span>@@ -1665,7 +1691,10 @@</span><br><span>             }</span=
><br><span>         }</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return tls_session_generate_data_channel_keys(mu=
lti, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* A DCO desync is reported as a plain failure here: every caller of this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * function alread=
y turns a failure into a SIGUSR1, which is exactly the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * recovery a desync needs */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return tls_session_gen=
erate_data_channel_keys(multi, session) =3D=3D KEY_GEN_OK;</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span>@@ -3336,6 +3365=
,9 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     int active =3D TLSMP_INACTIVE;</span><br><span>     bool error =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* kept sep=
arate from &#39;active&#39; on purpose: a restart request must not be</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * overwritten by a l=
ater TLSMP_ACTIVE/TLSMP_RECONNECT assignment */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool restart =3D false;</span><br><span> </=
span><br><span>     tls_clear_error();</span><br><span> </span><br><span>@@=
 -3436,12 +3468,22 @@</span><br><span>             /* Session is now fully =
authenticated=2E</span><br><span>              * tls_session_generate_data_=
channel_keys will move ks-&gt;state</span><br><span>              * from S_=
ACTIVE to S_GENERATED_KEYS */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (!tls_session_generate_data_channel_keys(multi, sess=
ion))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            en=
um key_gen_status status =3D tls_session_generate_data_channel_keys(multi, =
session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (status !=3D KEY_GEN_OK)</span><br><span>             {</span><br><spa=
n>                 msg(D_TLS_ERRORS, &quot;TLS Error: generate_key_expansio=
n failed&quot;);</span><br><span>                 ks-&gt;authenticated =3D =
KS_AUTH_FALSE;</span><br><span>                 key_state_ssl_shutdown(&amp=
;ks-&gt;ks_ssl);</span><br><span>                 ks-&gt;state =3D S_ERROR_=
PRE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* Invalidating th=
e key state is not enough to recover from a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 * DCO desync: the kernel peer has =
to be re-created, and the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 * key state we just invalidated will never be retrie=
d, so ask</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       * for a restart right away */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (status =3D=3D KEY_GEN_DCO_DESYNC)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    restar=
t =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span>             }</span><br><span> </span><br><span>=
             /* Update auth token on the client if needed on renegotiation<=
/span><br><span>@@ -3529,7 +3571,17 @@</span><br><span> </span><br><span>  =
   gc_free(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_=
KILL : active;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* strongest outcome wins: killing the session supersedes restarting it,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and restarting s=
upersedes whatever &#39;active&#39; ended up being */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tas =3D=3D TLS_AUTHENTICATION_FAI=
LED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return TLSMP_KILL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (restart)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return TLSMP_RESTART;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return active;</span><br><span> }</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/sr=
c/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2E5483fbb 100644</span><=
br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2E=
h</span><br><span>@@ -231,6 +231,8 @@</span><br><span> #define TLSMP_ACTIVE=
    1</span><br><span> #define TLSMP_KILL      2</span><br><span> #define T=
LSMP_RECONNECT 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
 the session cannot recover on its own and has to be restarted */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define TLSMP_RESTART   4</sp=
an><br><span> </span><br><span> /*</span><br><span>  * Called by the top-le=
vel event loop=2E</span><br><span>@@ -554,15 +556,6 @@</span><br><span> voi=
d show_available_tls_ciphers(const char *cipher_list, const char *cipher_li=
st_tls13,</span><br><span>                                 const char *tls_=
cert_profile);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Generate data channel key=
s for the supplied TLS session=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This=
 erases the source material used to generate the data channel keys, and</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * can thus be called onl=
y once per session=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool tls_session_g=
enerate_data_channel_keys(struct tls_multi *multi, struct tls_session *sess=
ion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void tls_session_soft_reset(struct tls_multi *multi);</span><br><span> </=
span><br><span> /**</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1=
835</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--4bWqao2jQtE=--


--===============7351573557808395352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7351573557808395352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7351573557808395352==--

