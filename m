Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3ACC55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkl8WTBzeFxoEXg3BeUMH0OIfX2JiOS31UnlQ49pBTg=; b=L9FuoiNWom813H3c3Mv7fR4GGA
	Pj4mlDjY0y+DFowhSobxOUi2m46if0eVuikisbmNrWznFm5oRMLjgHAAVbw8olCzp576LbF8WFXc3
	mw//L0Uhh3zg54YypmDfEgr7726yJjAZSRL+1+H66eMNkwLIwtzfEpA8HI/eZyp0olRI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrhB3-0000lS-3p;
	Wed, 05 Aug 2026 19:21:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrhB1-0000lK-D0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=so3l6iQooyxjQCnjJy7+sRkNRT5zh5WrtXX2A+rx4tg=; b=VU0SjHkQrd4uscfa56gvSUGjVm
 GGhTrUbhXnXG+FeWhjXWkDu2jWmkYe8iB9rcoTXYBdSOp/YT/G3espSlhecN0hOQvCV3bOYEcYgEe
 BkiBqSzKZ+rXaplJThvCLSu/Wc+IcyWhmE/oIeFpdpuqMIfsPNy4EXjXNCcWf1st2gi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=so3l6iQooyxjQCnjJy7+sRkNRT5zh5WrtXX2A+rx4tg=; b=I
 dgIQ0tyEnpvmnNLMOFXjSNC8D4bFz5MQDm1H6GgfcvOciQQiy3P7oKWGOwqm3WUYTra6X5SX5tfUC
 MNarpKOmFxgzAHac+mycfpqrY2DmaCXpy8McKIL2dhWwJ7JzZZiSQ9Diyz3bYoNxRuPAdhLhUiekp
 jTNFgDuiSUwqW0c4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrhB3-0001DU-CJ for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:21:19 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso12560065e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785957671; x=1786562471; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=so3l6iQooyxjQCnjJy7+sRkNRT5zh5WrtXX2A+rx4tg=;
 b=WDWKpuTYPUcjXrFOnVSuAYW30SGExUiX82PKoziw6IFURTTlKx6GExGZq2ju1T9tSJ
 9ioSp7VXNLP0+pdqkeFEOQkfQj5QKxO0rI7FsjOUHMytvF7IAaldfh3MHXqqn6u67BCR
 Aek/r3w+qlJyCzMwZNbVNDpFgPY3LjbpkEXFYS/NsmRu04XZJYgGBd7Vcf2wxHC66T0Y
 hrDtfmZb6ADMZamFYJyvNqc1yZUpk3m84kOABuuuSEsmUD8w4U0W5GMsNxaILnyQue7O
 PqmhBDx5EAdxWVW94bLBACy4rhYV+Rx/86jAAuvDJHDVoSi+8zdsTzEEUXCuKeM/XWPE
 OewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957671; x=1786562471;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=so3l6iQooyxjQCnjJy7+sRkNRT5zh5WrtXX2A+rx4tg=;
 b=bYwlNy7Du34mevVOkG5Jq5vkZlecM9vDZBJGg6hOQ14YomoZxB7W3ascCLX+aQlu7N
 unTeLsc02PC4ci8/POBVxvIw4LRHYveQrsBLJ1Ev2lfmLQKomHEiVu/4/6o+QAUVYq6w
 FKK5dfo8G42yBUr3JqcnGzfTzXFt1EeE2R38BY9Hfk4ixq8GiJPHVXyklabOVnLNAnLw
 xs+BLWQg+l3bF/YdSBHRgRzdSa201Y94osnhTZ8wlLe8kM+/bnSKVja3zrBBOHXZnysE
 G2h6VtHFcCJQYUphkMNa+/ZjCunOdqyHVOsnbCrCOvv68lfoOJdsm057nC+uhaWQBxLG
 8yBg==
X-Gm-Message-State: AOJu0YzquKkjXNWTYrqqO97mpORpJNUahfGTAf8ZCBqgcx6Xwh7cMEAC
 p95cQpLsOashh62C5ssk0IneqTG5mdGTvgP+ngcZaCHGE64NyVdq+kd5Psoxa9DNDDnU3YhRZUR
 NyxpIjTBxCas3unVFrosNrharw5FEKi5eV/2xtXbUHeLv/am0JzrwGyRLsegGgUJ8r6OODXz8/0
 Uks/U7xg==
X-Gm-Gg: AR+sD13Xo4vqY+3W8bqVnSAD7FrAspFgx2HMBbx5gGmMeP1tdnpOSbD33tuQln77Y07
 FvS/xUsQ6T1Ulqo61zTll/eBduX3gC1nwozZclJTa9RgzwQotxoB+R2Oz7lVcHVcmjwI8wUFiSW
 UY5U76w1pbUIhq+va/bkp5f5/f4M1XjYANPenbSO4m3OhjjRDw35NNpNGfZSNTSr1l39QT4KToE
 4VFEFo4si21t69QU+pNu8lO3ScR31ulX8Nnm670RL0ze7b7K/PnIzwWT9UTs3qPZxXtaIn1zTKJ
 JDqg7KbzCPK53xwSzWQmEUhC20/TWtDhWA5MTdBM5f3ASWA4FrO1OiT4hkhUY9H8tsRS3lQeC53
 6G6nGKIjJ0nZhzhRlpe3ahSmUKteYI83A554jUwuytCjWo84QbNfazQEM0AvqsmU+yIP/wgQ4Yq
 Aa6px+1QPz4Jj+Gyuqb+mFZ/oyPfcSBLvz8WRnvQTjFSn0f2OLup/Ed9KLmE9G3fla7dgkQSoHT
 V7Unnr0Z/hau/hhiCjg0MpODsB18Szetr8t6IZfsMZP2UdTqpj8g786Z8umUDOnPgFQD21XlMUi
 TMb7dHLN69LF50rme6mQ+0azNXxnmOuchJbeOn3bCG+YmmFlXPA=
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id
 5b1f17b1804b1-49952aba5b3mr25804955e9.1.1785957671054; 
 Wed, 05 Aug 2026 12:21:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49954221f32sm2046825e9.9.2026.08.05.12.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:21:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 19:21:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 81952cc7465f285a3a5d3552d78f70b963ea66ec
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2a4864258a09179bc2ea3db70363746226d72d7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrhB3-0001DU-CJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0614584086199295178=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0614584086199295178==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i9PliBJcRdQ="; charset=UTF-8

--i9PliBJcRdQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1826?usp=3Demail

to look at the new patch set (#5=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Make required action returned from pre_de=
crypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Make required action returned from pre_decrypt_verdict mor=
e explicit

The current code relies on the condition if state=2Eserver_sess=
ion_id
is defined to decided if session_skip_to_pre_start should be used=2E=


Instead explicitly return the intent and use that to decide if
session_sk=
ip_to_pre_start should be called=2E

Change-Id: Iccdd4cfad090c565aac27e16cd=
aa9871106c2f89
---
M src/openvpn/mudp=2Ec
1 file changed, 34 insertions(+),=
 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/26/1826/5

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec
index f176655=2E=2E31d43a4 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src=
/openvpn/mudp=2Ec
@@ -73,9 +73,24 @@
     msg_set_prefix(NULL);
 }
 
+/**
+=
 * Verdict if this packet should create a new session=2E If a packet is inv=
alid
+ * or we send out an HMAC based challenge, we do not want to create a=
 new
+ * session=2E
+ */
+enum pre_decrypt_verdict
+{
+    /** This packet =
should not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+    /** Thi=
s packet creates a new session normally */
+    PRE_DECRYPT_CREATE_SESSION,=

+    /** Create a new session but skip the first two packets of
+     * th=
e three way handshake */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Ret=
urns true if this packet should create a new session */
-static bool
+/** R=
eturns a verdict if this packet should create a new session */
+static enum=
 pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_context *m, struct =
tls_pre_decrypt_state *state,
                      struct mroute_addr addr=
, struct link_socket *sock)
 {
@@ -97,7 +112,7 @@
          * responses */
=
         if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
   =
      {
-            return false;
+            return PRE_DECRYPT_NO_ACTIO=
N;
         }
     }
 
@@ -122,7 +137,7 @@
                 calculate_sessi=
on_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
        =
     send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
-          =
  return false;
+            return PRE_DECRYPT_NO_ACTION;
         }
     =
    else
         {
@@ -139,11 +154,11 @@
                     "ignoring co=
nnection attempt from old client (%s)",
                     peer);
       =
          gc_free(&gc);
-                return false;
+                ret=
urn PRE_DECRYPT_NO_ACTION;
             }
             else
             {
=
-                return true;
+                return PRE_DECRYPT_CREATE_SE=
SSION;
             }
         }
     }
@@ -156,7 +171,7 @@
         send_h=
mac_reset_packet(m, state, tas, &sid, false, sock);
 
         /* We have a=
 reply do not create a new session */
-        return false;
+        retur=
n PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict =3D=3D VERDICT_VALID_=
CONTROL_V1 || verdict =3D=3D VERDICT_VALID_ACK_V1
              || verdict =
=3D=3D VERDICT_VALID_WKC_V1)
@@ -187,11 +202,11 @@
         }
         gc_f=
ree(&gc);
 
-        return ret;
+        return PRE_DECRYPT_CREATE_SESSION=
_SKIP;
     }
 
     /* VERDICT_INVALID */
-    return false;
+    return P=
RE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -217,8 +232,11 @@
             "MULTI: C=
onnection attempt from %s ignored while server is "
             "shutting =
down",
             mroute_addr_print(real, &gc));
+        return NULL;
  =
   }
-    else if (do_pre_decrypt_check(m, &state, *real, sock))
+    enum =
pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state, *real, sock=
);
+
+    if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {
         /* This i=
s an unknown session but with valid tls-auth/tls-crypt
          * (or no a=
uth at all)=2E  If this is the initial packet of a
@@ -243,13 +261,16 @@
 
=
                 /* If we have a session id already, ensure that the
      =
            * state is using the same */
-                if (session_id_de=
fined(&state=2Eserver_session_id)
-                    && session_id_define=
d((&state=2Epeer_session_id)))
+                if (session_id_defined((&st=
ate=2Epeer_session_id)))
                 {
                     mi->contex=
t=2Ec2=2Etls_multi->n_sessions++;
                     struct tls_session *=
session =3D
                         &mi->context=2Ec2=2Etls_multi->session=
[TM_INITIAL];
-                    session_skip_to_pre_start(session, &stat=
e, &m->top=2Ec2=2Efrom);
+
+                    if (verdict =3D=3D PRE_DECR=
YPT_CREATE_SESSION_SKIP)
+                    {
+                        se=
ssion_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+           =
         }
                 }
             }
         }

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106=
c2f89
Gerrit-Change-Number: 1826
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--i9PliBJcRdQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Make required action returned from pre_decrypt_verdict more e=
xplicit<br><br>The current code relies on the condition if state=2Eserver_s=
ession_id<br>is defined to decided if session_skip_to_pre_start should be u=
sed=2E<br><br>Instead explicitly return the intent and use that to decide i=
f<br>session_skip_to_pre_start should be called=2E<br><br>Change-Id: Iccdd4=
cfad090c565aac27e16cdaa9871106c2f89<br>---<br>M src/openvpn/mudp=2Ec<br>1 f=
ile changed, 34 insertions(+), 13 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/1826/5</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><=
span>index f176655=2E=2E31d43a4 100644</span><br><span>--- a/src/openvpn/mu=
dp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -73,9 =
+73,24 @@</span><br><span>     msg_set_prefix(NULL);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verdict if this pa=
cket should create a new session=2E If a packet is invalid</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * or we send out an HMAC based chal=
lenge, we do not want to create a new</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * session=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum=
 pre_decrypt_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This pack=
et should not create a new session */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    PRE_DECRYPT_NO_ACTION,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /** This packet creates a new session normally=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_=
CREATE_SESSION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** Create a new session but skip the first two packets of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * the three way handshake */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    PRE_DECRYPT_CREATE=
_SESSION_SKIP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Retu=
rns true if this packet should create a new session */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/** Returns a verdict if this packet should create=
 a new session */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic enum pre_decrypt_verdict</span><br><span> do_pre_decrypt_check(struct =
multi_context *m, struct tls_pre_decrypt_state *state,</span><br><span>    =
                  struct mroute_addr addr, struct link_socket *sock)</span>=
<br><span> {</span><br><span>@@ -97,7 +112,7 @@</span><br><span>          *=
 responses */</span><br><span>         if (!reflect_filter_rate_limit_check=
(m-&gt;initial_rate_limiter))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_=
ACTION;</span><br><span>         }</span><br><span>     }</span><br><span> =
</span><br><span>@@ -122,7 +137,7 @@</span><br><span>                 calcu=
late_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow,=
 0);</span><br><span>             send_hmac_reset_packet(m, state, tas, &am=
p;sid, true, sock);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return PRE_DECRYPT_NO_ACTION;</span><br><=
span>         }</span><br><span>         else</span><br><span>         {</s=
pan><br><span>@@ -139,11 +154,11 @@</span><br><span>                     &q=
uot;ignoring connection attempt from old client (%s)&quot;,</span><br><span=
>                     peer);</span><br><span>                 gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         return PRE_DECRYPT_NO_ACTION;</span><br><span>             }</span=
><br><span>             else</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                return PRE_D=
ECRYPT_CREATE_SESSION;</span><br><span>             }</span><br><span>     =
    }</span><br><span>     }</span><br><span>@@ -156,7 +171,7 @@</span><br>=
<span>         send_hmac_reset_packet(m, state, tas, &amp;sid, false, sock)=
;</span><br><span> </span><br><span>         /* We have a reply do not crea=
te a new session */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return PRE_DECRYPT_NO_ACTION;</span><br><span>     }</span><br><spa=
n>     else if (verdict =3D=3D VERDICT_VALID_CONTROL_V1 || verdict =3D=3D V=
ERDICT_VALID_ACK_V1</span><br><span>              || verdict =3D=3D VERDICT=
_VALID_WKC_V1)</span><br><span>@@ -187,11 +202,11 @@</span><br><span>      =
   }</span><br><span>         gc_free(&amp;gc);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return PRE_DECRYPT_CREA=
TE_SESSION_SKIP;</span><br><span>     }</span><br><span> </span><br><span> =
    /* VERDICT_INVALID */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return PRE_DECRYPT_NO_ACTION;</span><br><span> }</span><br><span> </s=
pan><br><span> /**</span><br><span>@@ -217,8 +232,11 @@</span><br><span>   =
          &quot;MULTI: Connection attempt from %s ignored while server is &=
quot;</span><br><span>             &quot;shutting down&quot;,</span><br><sp=
an>             mroute_addr_print(real, &amp;gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (do_pre_de=
crypt_check(m, &amp;state, *real, sock))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    enum pre_decrypt_verdict verdict =3D do_pre_decryp=
t_check(m, &amp;state, *real, sock);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>     {</span><br>=
<span>         /* This is an unknown session but with valid tls-auth/tls-cr=
ypt</span><br><span>          * (or no auth at all)=2E  If this is the init=
ial packet of a</span><br><span>@@ -243,13 +261,16 @@</span><br><span> </sp=
an><br><span>                 /* If we have a session id already, ensure th=
at the</span><br><span>                  * state is using the same */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (session=
_id_defined(&amp;state=2Eserver_session_id)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    &amp;&amp; session_id_defined((&a=
mp;state=2Epeer_session_id)))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (session_id_defined((&amp;state=2Epeer_session=
_id)))</span><br><span>                 {</span><br><span>                 =
    mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span>     =
                struct tls_session *session =3D</span><br><span>           =
              &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    s=
ession_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    if (verdict =3D=3D =
PRE_DECRYPT_CREATE_SESSION_SKIP)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        session_skip_to_pre_start(session, &=
amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    }</span><br><span>                 =
}</span><br><span>             }</span><br><span>         }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa98=
71106c2f89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1826 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--i9PliBJcRdQ=--


--===============0614584086199295178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0614584086199295178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0614584086199295178==--

