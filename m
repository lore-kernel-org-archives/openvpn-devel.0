Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475DC88E5A
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmbYjwaD9beteUOCSJPNrMBGDoK0gH7EHUaXdmBNG8c=; b=kUFL8ZLKNXLoCQKyiq4zxQdNve
	GWohTbHNFo4F9uZWP9ZFnz0K+SoZ+GJYNy7o3PGYjHPdX7aeydqxO+jjSRlEko4sgnTitYl8RnRDV
	kgYhdilofxVE3RBptG/llo8pOASSaFwoF1a6RdWtWrccGSH9KxBnBW74/c4iWVvqqIA0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536t-0006Vn-I8;
	Fri, 11 Sep 2026 15:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536P-0006Tn-PG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CfhgJPbYy/DP6q4FJavSakkc0c0akXHGrcSJAtuDPvQ=; b=GXuGVlNy4HylVq6IVzmdlHvqme
 FHXf/dAoYkWxlOEXxmxxZTqJYVxJEEq8LWOoHP1E5t433sJP5EgpYFUwj2VqfbMgdZta6M/47mdok
 dKHl3q9PiZ0jQu65kq12PNaGzwnhhUCmboOq3lfEBeupUFipPlT5kM4J2bjbikPogrFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CfhgJPbYy/DP6q4FJavSakkc0c0akXHGrcSJAtuDPvQ=; b=k
 wCmntY/N2tjBtlTb2QEwIzoqiGcPk2tiA79+PMG3jfRL+I2TKGc1uXmLy6hacxWrULQNXyfsg+Exu
 2H8Nk8SVKndkC7JbXtvXTkOt44sq+/d95B0T2v1Y8MPiV822I4HjpqwyQIV53RXMOaZWRneRpzOCU
 gkdAA0B3eUjdqZk4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536M-00019R-3e for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:45 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so150065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140215; x=1789745015; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CfhgJPbYy/DP6q4FJavSakkc0c0akXHGrcSJAtuDPvQ=;
 b=NU1Bs5U94wYsDDBl5wqOJ76pye2JDDzZARE+BNxSWn1O2UdvQLX3ibS9UEICrScxwP
 lfoCZ6CJ5XCC8TYXVdy8dr1Hnzr1jrIgO0CHV4aL/cPpviVSurnp8VHbQOVqPHphlCLV
 WF9EA8DOAUaei44CaDdW3whFMk+ybi6isLkiPixVw7pyKmeBE6R3qEY0z3Jk2pv9zgAP
 +QmJEHKWZACud1k6/C73DKrvcZMWuCfxvGwXo5WGTtWQqTDaSYlyE1w0TWCd0wFiuDXI
 afdxV/cfq12neUJWUqosp6oOBYvSuGdLErC/l1qOrjVaTGrb0TLZFeq0ungwYW9ySVnH
 RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140215; x=1789745015;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CfhgJPbYy/DP6q4FJavSakkc0c0akXHGrcSJAtuDPvQ=;
 b=JpbwpAYCP8y5B9v5scapfjG9OaBAq91RwZlmv08ob0y4cVvEeufOHvtZhn4obCBUrq
 4RrqFBme8utxtqebQDeWgQ9AeWxjamCJnIvAPNq/ga5xG7gmPfvggbgXkd1ZcxHjkNzy
 11ho5O9JhjHCJRiFRYFHGIgf6Ql3GcOqkovsI+EYd/j3OI5VEo+RzduMBwUP65txcOMS
 UrMYAOh0S51PtivPiQQ2WxDmpvI25rtYnvg0QkVS64gByDkTYmprEJsqMcIf4TJZw/8R
 VHQ2aO7vyOERUpTb/3qh+hHm1NJQ69YckUxRtsr+msiR6HEDNTo0mhLZrEfBiSql5mke
 DUMA==
X-Gm-Message-State: AFuF++lAnm02aZ+UKCr9/cE2PVB4OHnugq8AbWF6HPqCtn9lCFVe3rzS
 T5TkR4/uTIWb/SlyiHAJhnSX2g98pE40ButEC6//oKFQjF8aE5iuXeACtI3DnXm2o8oAOV/FYna
 ZY7uxZZFh1UIJEwqZ1iURvSEesRFx1iJe+LMtFZPlW/ZdFIyEVZuP9RwxT5HWhEm59nSrceX7gX
 rLe2HQgA==
X-Gm-Gg: AYBFou35DlXKPZISU/vL/HcI1LJPyS8oLDGQil1sQqumG9tTNjxS67yBlzwHrvQp2LV
 LXrd5kuFIin0KEM7fAFRkPSmOadJiGdUg3QDeYkXus+HuK0V8YO/3Jepb3LNIZaNAFj/23slIE2
 th1o18f2evuM0E7PsVHnOflSDiD8gHFn90XAqY0MupMGuHjSR0Px0od0X1t0W6llXW4t9BUPsYg
 jDE/AUJgkFMNzXs8860C+2zA1frh7DJ/s+7hlMhj2IGgtqRHJC/5nlBT5s73dYAYS1LTqPyiaF1
 IiV9Y7NSduSqwWvAxrmY7BDvTfIZS8buzSmMObs/xueIQOoIeKBlciGsT8NBRUdn/h/5DjYDdD1
 5TQm8vDeamOahqawvjiL/vEeFnFz0CzusirmkG5a4EYLNUk/qRbAaIQQR3xe3XYeNSLVvLe5smS
 wzN1kODbu3YLmvYA+Bv4COhfi1AJ+PmDWaZHShhKZkOM4Bk9zqj5pgs4MlKLrDNx0Udvv7z3gqJ
 Ctr2NAu4GgISUkmumdRYcQ2bx9Ul9Db5qnEFTehx2xKrdf625UxuzDg54nfmjM5Rv4A5ykojvDw
 wgoJtABlfwk1jh8al1vj+/D9EXW7KIN/2S0hPOW45J3sLlInaDIRi+uSzY69iyXeowHM6AjjZg=
 =
X-Received: by 2002:a05:600c:3b23:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49e619c2722mr101430725e9.15.1789140215194; 
 Fri, 11 Sep 2026 08:23:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm78880215e9.3.2026.09.11.08.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:34 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: fbf4fdab96d9c306dccbcdfc80457ada2086e5c7
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <365916d961e7e554643b9bd6cbb7345b3715f6fd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536M-00019R-3e
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a probe-started handshake is ignored
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7702683447519100683=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7702683447519100683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S899AaTkYlo="; charset=UTF-8

--S899AaTkYlo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1771?usp=3Demail

to look at the new patch set (#16)=2E


Ch=
ange subject: oob: fall back quickly when a probe-started handshake is igno=
red
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: fa=
ll back quickly when a probe-started handshake is ignored

If the server do=
es not accept the third packet of a handshake started
from a probe reply, t=
he client previously stalled for the full
handshake_window (~60s) before re=
covering=2E

In a normal handshake, no answer could mean the server is down=
, so
waiting is right=2E Here we know it is up, since it answered a probe a=

moment ago -- so no answer means it did not accept the reply as a reset,
a=
nd waiting 60s is pointless=2E That happens when a load balancer sends
the =
probe and the handshake to different instances, when NAT changes the
source=
 port the cookie is bound to, or when the server restarted and
rotated its =
session-id HMAC key=2E

Give such a session a short first-response deadline=

(min(handshake_window, 5s)); once the server answers, tls_pre_decrypt()
re=
stores the full window so a slow-but-working handshake is not cut off=2E
If=
 no response arrives, the session times out quickly and the normal
handshak=
e recovery kicks in, so a rejected reply costs a few seconds
instead of ~60=
=2E

Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_=
common=2Eh
2 files changed, 29 insertions(+), 1 deletion(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1771/16

diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd5fda=2E=2Eb2e6c8a 10=
0644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2569,6 +2569,1=
1 @@
     return session_move_pre_start(session, ks, true);
 }
 
+/* Second=
s to wait for the server's first response to a probe-started handshake
+ * =
before giving up and falling back to a normal handshake=2E A couple of
+ * =
control-channel retransmits; capped at handshake_window by the caller=2E */=

+#define OOB_PROBE_START_FALLBACK_SECS 5
+
 bool
 session_skip_to_pre_star=
t_client(struct tls_session *session, const struct session_id *client_sid,
=
                                  const struct session_id *server_sid,
@@ -=
2619,6 +2624,12 @@
         return false;
     }
     ks->state =3D S_PRE_S=
TART;
+
+    /* Fail fast if the server ignores it: wait seconds, not hands=
hake_window=2E
+     * tls_pre_decrypt() restores the full window once the =
server answers=2E */
+    ks->oob_probe_start =3D true;
+    ks->must_negot=
iate =3D
+        now + min_int(session->opt->handshake_window, OOB_PROBE_S=
TART_FALLBACK_SECS);
     return true;
 }
 
@@ -2867,9 +2878,15 @@
     /* =
Are we timed out on receive? */
     if (now >=3D ks->must_negotiate && ks-=
>state >=3D S_UNDEF && ks->state < S_ACTIVE)
     {
+        /* Report the =
window that actually applied: an unanswered probe-started
+         * hands=
hake times out on the short fallback deadline, not
+         * handshake_wi=
ndow=2E */
+        int window =3D ks->oob_probe_start
+                   =
      ? min_int(session->opt->handshake_window, OOB_PROBE_START_FALLBACK_SE=
CS)
+                         : session->opt->handshake_window;
         ms=
g(D_TLS_ERRORS,
             "TLS Error: TLS key negotiation failed to occu=
r within %d seconds (check your network connectivity)",
-            sessio=
n->opt->handshake_window);
+            window);
         goto error;
     =
}
 
@@ -3950,6 +3967,15 @@
     /* Let our caller know we processed a contr=
ol channel packet */
     ret =3D true;
 
+    /* First valid response to a=
 probe-started handshake: the server accepted it,
+     * so restore the no=
rmal negotiation window (it was shortened to fail fast if
+     * the probe=
 reply had been ignored)=2E */
+    if (ks->oob_probe_start)
+    {
+      =
  ks->oob_probe_start =3D false;
+        ks->must_negotiate =3D now + sess=
ion->opt->handshake_window;
+    }
+
     /*
      * Set our remote address=
 and remote session_id
      */
diff --git a/src/openvpn/ssl_common=2Eh b/s=
rc/openvpn/ssl_common=2Eh
index f6392f9=2E=2E905006c 100644
--- a/src/openv=
pn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -227,6 +227,8 @@
    =
 time_t initial;                        /* when we created this session */
=
     time_t established;                    /* when our state went S_ACTIVE=
 */
     time_t must_negotiate;                 /* key negotiation times ou=
t if not finished before this time */
+    bool oob_probe_start;           =
       /* probe-started handshake: must_negotiate is a short
+             =
                               * first-response deadline, not the full wind=
ow */
     time_t must_die;                       /* this object is destroy=
ed at this time */
     time_t peer_last_packet;               /* Last time=
 we received a packet in this control session */
 

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9=

Gerrit-Change-Number: 1771
Gerrit-PatchSet: 16
Gerrit-Owner: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: stipa <lstipakov@gmail=2Ecom>

--S899AaTkYlo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #16=
</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1771?usp=3Demail">View Change</a></p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: fall ba=
ck quickly when a probe-started handshake is ignored<br><br>If the server d=
oes not accept the third packet of a handshake started<br>from a probe repl=
y, the client previously stalled for the full<br>handshake_window (~60s) be=
fore recovering=2E<br><br>In a normal handshake, no answer could mean the s=
erver is down, so<br>waiting is right=2E Here we know it is up, since it an=
swered a probe a<br>moment ago -- so no answer means it did not accept the =
reply as a reset,<br>and waiting 60s is pointless=2E That happens when a lo=
ad balancer sends<br>the probe and the handshake to different instances, wh=
en NAT changes the<br>source port the cookie is bound to, or when the serve=
r restarted and<br>rotated its session-id HMAC key=2E<br><br>Give such a se=
ssion a short first-response deadline<br>(min(handshake_window, 5s)); once =
the server answers, tls_pre_decrypt()<br>restores the full window so a slow=
-but-working handshake is not cut off=2E<br>If no response arrives, the ses=
sion times out quickly and the normal<br>handshake recovery kicks in, so a =
rejected reply costs a few seconds<br>instead of ~60=2E<br><br>Change-Id: I=
cec4696ff263ab39ebab06e8d478395a5ddfaab9<br>Signed-off-by: Lev Stipakov &lt=
;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=
_common=2Eh<br>2 files changed, 29 insertions(+), 1 deletion(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/71/1771/16</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index ccd5fda=2E=2Eb2e6c8a 100644</span><br><span>--- =
a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><=
span>@@ -2569,6 +2569,11 @@</span><br><span>     return session_move_pre_st=
art(session, ks, true);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Seconds to wait for the server&=
#39;s first response to a probe-started handshake</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * before giving up and falling back to a nor=
mal handshake=2E A couple of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * control-channel retransmits; capped at handshake_window by the =
caller=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 OOB_PROBE_START_FALLBACK_SECS 5</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> bool</span><br><span> session_skip_to_pre_st=
art_client(struct tls_session *session, const struct session_id *client_sid=
,</span><br><span>                                  const struct session_id=
 *server_sid,</span><br><span>@@ -2619,6 +2624,12 @@</span><br><span>      =
   return false;</span><br><span>     }</span><br><span>     ks-&gt;state =
=3D S_PRE_START;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fail fast if th=
e server ignores it: wait seconds, not handshake_window=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * tls_pre_decrypt() restores th=
e full window once the server answers=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ks-&gt;oob_probe_start =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;must_negotiate =3D</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        now + min_int(se=
ssion-&gt;opt-&gt;handshake_window, OOB_PROBE_START_FALLBACK_SECS);</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span>@@ -2867,9 +2878,15 @@</span><br><span>     /* Are we timed out on rec=
eive? */</span><br><span>     if (now &gt;=3D ks-&gt;must_negotiate &amp;&a=
mp; ks-&gt;state &gt;=3D S_UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Report the window that actually applied: an unanswered probe-sta=
rted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * hand=
shake times out on the short fallback deadline, not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * handshake_window=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int window =3D ks-&=
gt;oob_probe_start</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        ? min_int(session-&gt;opt-&gt;handshake_window, OOB=
_PROBE_START_FALLBACK_SECS)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         : session-&gt;opt-&gt;handshake_window;</s=
pan><br><span>         msg(D_TLS_ERRORS,</span><br><span>             &quot=
;TLS Error: TLS key negotiation failed to occur within %d seconds (check yo=
ur network connectivity)&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            session-&gt;opt-&gt;handshake_window);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            window);</span><br><sp=
an>         goto error;</span><br><span>     }</span><br><span> </span><br>=
<span>@@ -3950,6 +3967,15 @@</span><br><span>     /* Let our caller know we=
 processed a control channel packet */</span><br><span>     ret =3D true;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* First valid response to a probe-started handshake: the server accepted =
it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so restor=
e the normal negotiation window (it was shortened to fail fast if</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * the probe reply had be=
en ignored)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (ks-&gt;oob_probe_start)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ks-&gt;oob_probe_start =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ks-&gt;must_negotiate =3D now + session-&gt;opt-&=
gt;handshake_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     /*</span><br><span>      * Set our remote address and remote sessi=
on_id</span><br><span>      */</span><br><span>diff --git a/src/openvpn/ssl=
_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=
=2E905006c 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -227,6 +227,8 @=
@</span><br><span>     time_t initial;                        /* when we cr=
eated this session */</span><br><span>     time_t established;             =
       /* when our state went S_ACTIVE */</span><br><span>     time_t must_=
negotiate;                 /* key negotiation times out if not finished bef=
ore this time */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool oob_probe_start;                  /* probe-started handshake: must_ne=
gotiate is a short</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                           * first-response deadline, not t=
he full window */</span><br><span>     time_t must_die;                    =
   /* this object is destroyed at this time */</span><br><span>     time_t =
peer_last_packet;               /* Last time we received a packet in this c=
ontrol session */</span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=
=3Demail">change 1771</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1771?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1771 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--S899AaTkYlo=--


--===============7702683447519100683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7702683447519100683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7702683447519100683==--

