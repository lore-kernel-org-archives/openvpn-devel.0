Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D4606A31F
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hDqSMAep;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YpqTY7i8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d1SuUnPx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C+aznbBF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=J41Aar0p4iev+bUHPZcqNYBFP460nj4pYmMoo27h7J0=; b=hDqSMAepRdNiMcmsegR8bdn4S9
	7i5sJXqwCs6MtFO3nBJ91MW8R6gaQMrqgEB0E2Tm/v5tF2uQkULrtuDmL+fqI+uYHVYFECf36SQIt
	36f1onHQ8W98rQKAoTwibNIPGJ0/IfNTqEKMtQ1CySInuuwBSU0NmkSU5qWl4wlCu+Vs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdly-000000004vD-2yWO;
	Tue, 27 Oct 2026 09:47:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlx-000000004v2-01hY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gwx/g/Fwari+Ym1h73uThXXRRhfmhNEnNklL0Q0Ufdo=; b=YpqTY7i8Rynu/s+NWYxFe0hoSI
 GXu7megkr718K322wX+9vuww5fTJjpvHmTwX5jPPS15A+l3EQs7cUxWiYpQV5tQds9Xzi60F058Ll
 hOeU0xiVmsg+2ydzJSe/nmulHazzt6k77IasP19fakVYJUG6FKCefDAUhGNlBqUZGXvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gwx/g/Fwari+Ym1h73uThXXRRhfmhNEnNklL0Q0Ufdo=; b=d1SuUnPxp1d55kOgHnzNx92UdY
 OGDRnNG9nTNZqVnzYhRmSBHOuVbzNmR6FyYUCJvPwrMTPFLAQCB8//FfIeW5lLYAk5m5QlH2FN2qB
 wqqi0hGkT+1NJdlk599qVV5G+b/JZJ/Kn9RwJneY2chwfkrjJ05gs2B57G4nowYw3vNs=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlu-0000000021g-2bST for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:12 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so711838f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094424; x=1793699224; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gwx/g/Fwari+Ym1h73uThXXRRhfmhNEnNklL0Q0Ufdo=;
 b=C+aznbBFH+VowRhPdNyDZgV6Xg/hwzJVD+dfrIg1xqggAQ/3eEz2OZ72RKNkRnLtmm
 Tjz4uFIgqF/uB9l+h38UfD/uVRZFdb5rJRgde08ZtfrAtS+pPoGQpjwaHSJAyxw2yLLK
 rmb/MPZGn4g3vqp6SKHL9ykKGokBiyBGnlvBHrzfiIXQ33dPhLUUpMZSzpv9Sh5LdrHP
 IpU+1C/fPZ7SAsvEhiYpWazVZh9GVpWFhNDNmzHE9+vYpXXweokCzPUIXQIaLSh6AKzQ
 SMPixfhf0Z+3/UWMV/0ssgF6Ydcajdqe2MQ9CfI9h3goR9nDUWn5eZuJDtbSKDlmdiHP
 STQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094424; x=1793699224;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gwx/g/Fwari+Ym1h73uThXXRRhfmhNEnNklL0Q0Ufdo=;
 b=Ahn7nPsx7gjxJApDGiB6yUI5dUIMF28XKhuCl+DXYihVdA9J6ToqiMr7nAloYrvYzC
 Wv4tiLhf15pLdu48mVoFjlNVRA7hgeGFLrZgIB4bOiPXiLUqXOGjBqSKlK0WHXbn1suS
 xP99l1obfmlSrW1d0YwLeClSRYhR7nMOt+sHmCspg7CM1cy8QYbPcbnkb55p9+lh3ICJ
 IoV/FCus/uFQgIyxXI0++y2o4mKyqM15wfxqeuoR5i4CHkrI1lpErzcj6SQID+O5Z+r2
 BbUvI9Hb21dLvFmy3+H66yeCKR58GmQ3YV5vT4lyUQQs7ROyjyo9+dK/hZR4ApDSSEfX
 p67A==
X-Gm-Message-State: AFq9FYKGiFFsJqZEmPK8yReznbbaHRBtoEGjgh9WbgsYFqXUT6+p+OAe
 0JD93ZUZqECHoPANysphUfnpcLeANz67QPNPFOqzn/bop5HW1jeoolM4RJFHBvw+jY9CKOTbnM+
 s/hc+yGlv0ki8IxaNs65e+Iz8BdTrnrfImIJbIOlvyQF7aDvQ7fXAiNt/Akb5eXY4gQas/0UJkY
 RKP6y4uQ==
X-Gm-Gg: AYBFou00XuictXlT47EC6XWwbnQKasFkjkzwaqBibM58QrnNRWrR0W4DnGTTjYIXE6t
 qq/wA+oJE7/sC4npFA08YbH+59lMEOogBI/7GMWhjY+hAJazWyFXZZwjjzTJWKQTjp30tNSfrgJ
 BKA0BcH8m4+lTWIWGsFuEYO6hJ0RT73l0IAeX3BMAnQZGAdr1WU/iFVkMsEsOzA6/wFqhWFC+hJ
 IcOSc9UeB3gpHmDHSV6lxJwXam9zzq9/uH6FK2l+ZNK50jJNp5wIQM1DP3xKj8HzRvF6hcFIAhl
 Fwa3dbhI7xX389LoyPj/LJ6yjw/ThT5zheNSKkH0+UUqJQePylBVnmDoQU0g8LiHYkEDbRZJc1n
 jQ8Z0vtMW3bpMGalERkTOSe+mC4+U8mGFMsrGm2iDrkMJ6LbCRyZZOSf6fHSVimsa+HV6ztzaNt
 ZZnMnZ/KDeAv3VVi1QGWS98v6r/v0nnIVLyUYVJHnMe5dhnu0pu8lEUrPcoh9y8CWuPGYhmCtMG
 cbv1TtmMy4lJKag+OjlxLjclIjzI9xD6TI5QVD76NLOUXEiB1EfjihPL5H5NRvuSblzMkfwswE6
 Gc2r6Nl5rHD9u7ees0vrk+YqlZHc7XrneyBtilj1tmtlLm4Yl+s3MFBmwWIDgv62XIcPcsrt/PW
 gOVI4gVdcYhRmGugpgztsvn/hlYxAbT2Jv28UCP2TU5s=
X-Received: by 2002:adf:e00e:0:20b0:48e:3c5f:a24e with SMTP id
 ffacd0b85a97d-48e55a3ec85mr3410072f8f.11.1793094423686; 
 Tue, 27 Oct 2026 02:47:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm21750086f8f.30.2026.10.27.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:03 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: 5219cd07ee23243dbc5ed986ad78aab34458435b
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff5823d42f0a22ec163eca9c4d34c64879871f4e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlu-0000000021g-2bST
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5417584391202924623=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5417584391202924623==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dvlo+2A8giE="; charset=UTF-8

--Dvlo+2A8giE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2046?usp=3Demail

to review the following change=2E
=


Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_S=
OCKET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
ulti_io: dispatch UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE

UDP so=
cket events were handled by multi_process_io_udp() outside the
multi_io_act=
ion() state machine and re-entered it via TA_INITIAL,
running multi_process=
_post() twice=2E

Dispatch them as TA_SOCKET_READ, with mi =3D=3D NULL and =
the socket passed
explicitly, and TA_SOCKET_WRITE, so that pending output i=
s flushed
within the same event=2E Drop multi_process_io_udp(); multi_io_se=
nd_link()
has no caller left outside multi_io=2Ec and becomes static=2E

Ch=
ange-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Signed-off-by: Gianmarco=
 De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/mudp=2Ec
M src/op=
envpn/mudp=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/ope=
nvpn/multi_io=2Eh
5 files changed, 42 insertions(+), 70 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/2046/1

=
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217b299=2E=
=2E70ce458 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-29,7 +29,6 @@
 #include "multi=2Eh"
 #include <inttypes=2Eh>
 #include "fo=
rward=2Eh"
-#include "multi_io=2Eh"
 
 #include "memdbg=2Eh"
 #include "ssl=
_pkt=2Eh"
@@ -462,39 +461,3 @@
     ASSERT(!(mi && mi->halt));
     return =
mi;
 }
-
-/*
- * Send a packet to UDP socket=2E
- */
-static inline void
-m=
ulti_process_outgoing_link(struct multi_context *m, const unsigned int mpp_=
flags)
-{
-    if (m->pending)
-    {
-        multi_io_send_link(m, m->pen=
ding, mpp_flags);
-    }
-}
-
-/*
- * Process a UDP socket event=2E
- */
-v=
oid
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock=
, unsigned int rwflags)
-{
-    const unsigned int mpp_flags =3D (MPP_PRE_S=
ELECT | MPP_CLOSE_ON_SIGNAL);
-
-    /* UDP port ready to accept write */
-=
    if (rwflags & SOCKET_WRITE)
-    {
-        multi_process_outgoing_link=
(m, mpp_flags);
-    }
-    /* Incoming data on UDP port */
-    else if (r=
wflags & SOCKET_READ)
-    {
-        read_incoming_link(&m->top, sock);
- =
       if (!IS_SIG(&m->top))
-        {
-            multi_process_incoming=
_link(m, NULL, mpp_flags, sock);
-        }
-    }
-}
diff --git a/src/open=
vpn/mudp=2Eh b/src/openvpn/mudp=2Eh
index 6567539=2E=2Ec38d9e5 100644
--- a=
/src/openvpn/mudp=2Eh
+++ b/src/openvpn/mudp=2Eh
@@ -30,7 +30,6 @@
 struct =
context;
 struct multi_context;
 
-void multi_process_io_udp(struct multi_c=
ontext *m, struct link_socket *sock, unsigned int rwflags);
 /*************=
*************************************************************/
 /**
  * Get=
, and if necessary create, the multi_instance associated with a
diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 2e804ff=2E=2Ecf6a584 =
100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4251,7 +=
4251,7 @@
         }
         else if (status =3D=3D 0)
         {
-       =
     multi_io_action(multi, NULL, TA_TIMEOUT, false);
+            multi_io=
_action(multi, NULL, NULL, TA_TIMEOUT, false);
         }
 
         MULTI_=
CHECK_SIG(multi);
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi=
_io=2Ec
index fb4810b=2E=2Ed1b7bf4 100644
--- a/src/openvpn/multi_io=2Ec
++=
+ b/src/openvpn/multi_io=2Ec
@@ -345,7 +345,7 @@
     return mi;
 }
 
-bool=

+static bool
 multi_io_send_link(struct multi_context *m, struct multi_ins=
tance *mi, const unsigned int mpp_flags)
 {
     bool ret =3D true;
@@ -423=
,7 +423,8 @@
 }
 
 static struct multi_instance *
-multi_io_dispatch(struct=
 multi_context *m, struct multi_instance *mi, const int action)
+multi_io_d=
ispatch(struct multi_context *m, struct multi_instance *mi, struct link_soc=
ket *sock,
+                  const int action)
 {
     const unsigned int =
mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance=
 *touched =3D mi;
@@ -445,21 +446,28 @@
 
         case TA_SOCKET_READ:
   =
      case TA_SOCKET_READ_RESIDUAL:
-            ASSERT(mi);
-            A=
SSERT(mi->context=2Ec2=2Elink_sockets);
-            ASSERT(mi->context=2Ec=
2=2Elink_sockets[0]);
-            set_prefix(mi);
-            read_incomi=
ng_link(&mi->context, mi->context=2Ec2=2Elink_sockets[0]);
-            cle=
ar_prefix();
-            if (!IS_SIG(&mi->context))
+        {
+          =
  struct context *c =3D multi_get_context(m, mi);
+
+            if (mi)
  =
           {
-                multi_process_incoming_link(m, mi, mpp_flags,=
 mi->context=2Ec2=2Elink_sockets[0]);
-                if (!IS_SIG(&mi->con=
text))
+                ASSERT(mi->context=2Ec2=2Elink_sockets);
+         =
       sock =3D mi->context=2Ec2=2Elink_sockets[0];
+                set_pr=
efix(mi);
+            }
+            ASSERT(sock);
+            read_incom=
ing_link(c, sock);
+            clear_prefix();
+            if (!IS_SIG(c)=
)
+            {
+                multi_process_incoming_link(m, mi, mpp_fl=
ags, sock);
+                if (!IS_SIG(c))
                 {
-          =
          stream_buf_read_setup(mi->context=2Ec2=2Elink_sockets[0]);
+     =
               stream_buf_read_setup(sock);
                 }
            =
 }
             break;
+        }
 
         case TA_TIMEOUT:
             =
multi_process_timeout(m, mpp_flags);
@@ -586,11 +594,11 @@
                =
     mi =3D ev_arg->u=2Emi;
                     if (e->rwflags & EVENT_WRI=
TE)
                     {
-                        multi_io_action(m, mi, =
TA_SOCKET_WRITE_READY, false);
+                        multi_io_action(m, =
mi, NULL, TA_SOCKET_WRITE_READY, false);
                     }
           =
          else if (e->rwflags & EVENT_READ)
                     {
-       =
                 multi_io_action(m, mi, TA_SOCKET_READ, false);
+          =
              multi_io_action(m, mi, NULL, TA_SOCKET_READ, false);
        =
             }
                     break;
 
@@ -605,18 +613,21 @@
        =
             {
                         socket_reset_listen_persistent(ev_a=
rg->u=2Esock);
                         mi =3D multi_create_instance_tcp(m,=
 ev_arg->u=2Esock);
+                        /* monitor and/or handle event=
s that are
+                         * triggered in succession by the first=
 one
+                         * before returning to the main loop=2E */
+ =
                       if (mi)
+                        {
+                =
            multi_io_action(m, mi, NULL, TA_INITIAL, false);
+             =
           }
                     }
-                    else
+            =
        else if (e->rwflags & EVENT_WRITE)
                     {
-        =
                multi_process_io_udp(m, ev_arg->u=2Esock, e->rwflags);
-   =
                     mi =3D m->pending;
+                        multi_io_a=
ction(m, NULL, NULL, TA_SOCKET_WRITE, false);
                     }
-     =
               /* monitor and/or handle events that are
-                  =
   * triggered in succession by the first one
-                     * befor=
e returning to the main loop=2E */
-                    if (mi)
+          =
          else if (e->rwflags & EVENT_READ)
                     {
-       =
                 multi_io_action(m, mi, TA_INITIAL, false);
+              =
          multi_io_action(m, NULL, ev_arg->u=2Esock, TA_SOCKET_READ, false)=
;
                     }
                     break;
             }
@@ -636=
,11 +647,11 @@
                 {
                     if (e->rwflags & EVE=
NT_WRITE)
                     {
-                        multi_io_action(m=
, NULL, TA_TUN_WRITE, false);
+                        multi_io_action(m, N=
ULL, NULL, TA_TUN_WRITE, false);
                     }
                   =
  else if (e->rwflags & EVENT_READ)
                     {
-               =
         multi_io_action(m, NULL, TA_TUN_READ, false);
+                   =
     multi_io_action(m, NULL, NULL, TA_TUN_READ, false);
                  =
   }
                 }
 
@@ -677,13 +688,14 @@
         struct multi_insta=
nce *mi;
         while (!IS_SIG(&m->top) && (mi =3D mbuf_peek(m->mbuf)) !=
=3D NULL)
         {
-            multi_io_action(m, mi, TA_SOCKET_WRITE, t=
rue);
+            multi_io_action(m, mi, NULL, TA_SOCKET_WRITE, true);
   =
      }
     }
 }
 
 void
-multi_io_action(struct multi_context *m, struct =
multi_instance *mi, int action, bool poll)
+multi_io_action(struct multi_co=
ntext *m, struct multi_instance *mi, struct link_socket *sock,
+           =
     int action, bool poll)
 {
     bool tun_input_pending =3D false;
 
@@ =
-716,7 +728,7 @@
         /*
          * Dispatch the action
          */
-=
        struct multi_instance *touched =3D multi_io_dispatch(m, mi, action)=
;
+        struct multi_instance *touched =3D multi_io_dispatch(m, mi, sock=
, action);
 
         /*
          * Signal received or connection
diff --g=
it a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index c7f8f89=2E=
=2E7ae25c6 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=
=2Eh
@@ -68,11 +68,9 @@
 
 void multi_io_process_io(struct multi_context *m=
);
 
-void multi_io_action(struct multi_context *m, struct multi_instance *=
mi, int action, bool poll);
+void multi_io_action(struct multi_context *m, =
struct multi_instance *mi, struct link_socket *sock,
+                     =
int action, bool poll);
 
 void multi_io_delete_event(struct multi_io *mult=
i_io, event_t event);
 
-bool multi_io_send_link(struct multi_context *m, s=
truct multi_instance *mi,
-                        const unsigned int mpp_f=
lags);
-
 #endif /* ifndef MULTI_IO_H */

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Gerrit-Ch=
ange-Number: 2046
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--Dvlo+2A8giE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi_io: dispatch UDP events through TA_SOCKET_READ/TA=
_SOCKET_WRITE<br><br>UDP socket events were handled by multi_process_io_udp=
() outside the<br>multi_io_action() state machine and re-entered it via TA_=
INITIAL,<br>running multi_process_post() twice=2E<br><br>Dispatch them as T=
A_SOCKET_READ, with mi =3D=3D NULL and the socket passed<br>explicitly, and=
 TA_SOCKET_WRITE, so that pending output is flushed<br>within the same even=
t=2E Drop multi_process_io_udp(); multi_io_send_link()<br>has no caller lef=
t outside multi_io=2Ec and becomes static=2E<br><br>Change-Id: Ia7a31ff1c37=
92104101cb2e828be3b7fd8f44156<br>Signed-off-by: Gianmarco De Gregori &lt;gi=
anmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openv=
pn/mudp=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M s=
rc/openvpn/multi_io=2Eh<br>5 files changed, 42 insertions(+), 70 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/46/2046/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec</span><br><span>index 217b299=2E=2E70ce458 100644</span=
><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mud=
p=2Ec</span><br><span>@@ -29,7 +29,6 @@</span><br><span> #include &quot;mul=
ti=2Eh&quot;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span=
> #include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;multi_io=2Eh&quot;</span><br><span> </span><br>=
<span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_=
pkt=2Eh&quot;</span><br><span>@@ -462,39 +461,3 @@</span><br><span>     ASS=
ERT(!(mi &amp;&amp; mi-&gt;halt));</span><br><span>     return mi;</span><b=
r><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Send a packet to UDP socket=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_process_outgoing_link(struct multi_context *m, const u=
nsigned int mpp_flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pendi=
ng)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi_io_send_link(m, m-&g=
t;pending, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Process a UDP socket event=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_io_udp(str=
uct multi_context *m, struct link_socket *sock, unsigned int rwflags)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    const unsigned int mpp_flags =3D (MPP_PRE_S=
ELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* UDP po=
rt ready to accept write */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (rwflags &amp; SOCKET_WRITE)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        multi_process_outgoing_link(m, mpp_flags);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* Incoming data on UDP port */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (rwflags &amp; SOCKET_READ)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        read_incoming_link(&amp;m-&gt;top=
, sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!=
IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  multi_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span>diff --git a/src/openvpn/mudp=2Eh b/src/openvpn/mu=
dp=2Eh</span><br><span>index 6567539=2E=2Ec38d9e5 100644</span><br><span>--=
- a/src/openvpn/mudp=2Eh</span><br><span>+++ b/src/openvpn/mudp=2Eh</span><=
br><span>@@ -30,7 +30,6 @@</span><br><span> struct context;</span><br><span=
> struct multi_context;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void multi_process_io_udp(struct multi_context *m, stru=
ct link_socket *sock, unsigned int rwflags);</span><br><span> /************=
**************************************************************/</span><br><=
span> /**</span><br><span>  * Get, and if necessary create, the multi_insta=
nce associated with a</span><br><span>diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec</span><br><span>index 2e804ff=2E=2Ecf6a584 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/=
multi=2Ec</span><br><span>@@ -4251,7 +4251,7 @@</span><br><span>         }<=
/span><br><span>         else if (status =3D=3D 0)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_i=
o_action(multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_io_action(multi, NULL, NULL, TA_TIM=
EOUT, false);</span><br><span>         }</span><br><span> </span><br><span>=
         MULTI_CHECK_SIG(multi);</span><br><span>diff --git a/src/openvpn/m=
ulti_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index fb4810b=2E=2Ed=
1b7bf4 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><spa=
n>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -345,7 +345,7 @@</span>=
<br><span>     return mi;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span> multi_io_send_link(s=
truct multi_context *m, struct multi_instance *mi, const unsigned int mpp_f=
lags)</span><br><span> {</span><br><span>     bool ret =3D true;</span><br>=
<span>@@ -423,7 +423,8 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static struct multi_instance *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_io_dispatch(struct multi_context *m, struct multi_insta=
nce *mi, const int action)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+multi_io_dispatch(struct multi_context *m, struct multi_instance *mi=
, struct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                  const int action)</span><br><span> {</span><br><s=
pan>     const unsigned int mpp_flags =3D MPP_PRE_SELECT | MPP_RECORD_TOUCH=
;</span><br><span>     struct multi_instance *touched =3D mi;</span><br><sp=
an>@@ -445,21 +446,28 @@</span><br><span> </span><br><span>         case TA=
_SOCKET_READ:</span><br><span>         case TA_SOCKET_READ_RESIDUAL:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;=
context=2Ec2=2Elink_sockets);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ASSERT(mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            set_prefix(mi);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_incomin=
g_link(&amp;mi-&gt;context, mi-&gt;context=2Ec2=2Elink_sockets[0]);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            clear_prefix();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SIG=
(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     struct context *c =3D multi_get_context(m, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (mi)</span><br><span>             {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                multi_process_i=
ncoming_link(m, mi, mpp_flags, mi-&gt;context=2Ec2=2Elink_sockets[0]);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!IS_SI=
G(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                ASSERT(mi-&gt;context=2Ec2=2Elink_sockets);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sock =3D mi-&gt=
;context=2Ec2=2Elink_sockets[0];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                set_prefix(mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            ASSERT(sock);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            read_incoming_link(c, sock);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            clear_prefix();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!IS_S=
IG(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mul=
ti_process_incoming_link(m, mi, mpp_flags, sock);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (!IS_SIG(c))</span><br><sp=
an>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    stream_buf_read_setup(mi-&gt;context=2Ec2=2Elink_socket=
s[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       stream_buf_read_setup(sock);</span><br><span>                 }</spa=
n><br><span>             }</span><br><span>             break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </spa=
n><br><span>         case TA_TIMEOUT:</span><br><span>             multi_pr=
ocess_timeout(m, mpp_flags);</span><br><span>@@ -586,11 +594,11 @@</span><b=
r><span>                     mi =3D ev_arg-&gt;u=2Emi;</span><br><span>    =
                 if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span>     =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    multi_io_action(m, mi, TA_SOCKET_WRITE_READY, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   multi_io_action(m, mi, NULL, TA_SOCKET_WRITE_READY, false);</span><br><s=
pan>                     }</span><br><span>                     else if (e-=
&gt;rwflags &amp; EVENT_READ)</span><br><span>                     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        mult=
i_io_action(m, mi, TA_SOCKET_READ, false);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        multi_io_action(m, mi, NULL,=
 TA_SOCKET_READ, false);</span><br><span>                     }</span><br><=
span>                     break;</span><br><span> </span><br><span>@@ -605,=
18 +613,21 @@</span><br><span>                     {</span><br><span>      =
                   socket_reset_listen_persistent(ev_arg-&gt;u=2Esock);</sp=
an><br><span>                         mi =3D multi_create_instance_tcp(m, e=
v_arg-&gt;u=2Esock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        /* monitor and/or handle events that are</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                         * tr=
iggered in succession by the first one</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         * before returning to the main =
loop=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                            multi_io_action(m, mi, NULL, TA_INITIA=
L, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               }</span><br><span>                     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    else if (e-&gt;r=
wflags &amp; EVENT_WRITE)</span><br><span>                     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        multi_pr=
ocess_io_udp(m, ev_arg-&gt;u=2Esock, e-&gt;rwflags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        mi =3D m-&gt;pendin=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, false);</span><br><s=
pan>                     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    /* monitor and/or handle events that are</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                     * triggere=
d in succession by the first one</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                     * before returning to the main loop=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if =
(mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span>             =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            multi_io_action(m, mi, TA_INITIAL, false);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        multi_io_action(=
m, NULL, ev_arg-&gt;u=2Esock, TA_SOCKET_READ, false);</span><br><span>     =
                }</span><br><span>                     break;</span><br><sp=
an>             }</span><br><span>@@ -636,11 +647,11 @@</span><br><span>   =
              {</span><br><span>                     if (e-&gt;rwflags &amp=
; EVENT_WRITE)</span><br><span>                     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        multi_io_action(m, =
NULL, TA_TUN_WRITE, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        multi_io_action(m, NULL, NULL, TA_TUN_WRITE=
, false);</span><br><span>                     }</span><br><span>          =
           else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span>       =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  multi_io_action(m, NULL, TA_TUN_READ, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        multi_i=
o_action(m, NULL, NULL, TA_TUN_READ, false);</span><br><span>              =
       }</span><br><span>                 }</span><br><span> </span><br><sp=
an>@@ -677,13 +688,14 @@</span><br><span>         struct multi_instance *mi=
;</span><br><span>         while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =
=3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            multi_io_action(m, m=
i, TA_SOCKET_WRITE, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_io_action(m, mi, NULL, TA_SOCKET_WRITE, true);</sp=
an><br><span>         }</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-multi_io_action(struct multi_context *m, struct multi_instance *mi=
, int action, bool poll)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+multi_io_action(struct multi_context *m, struct multi_instance *mi, st=
ruct link_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                int action, bool poll)</span><br><span> {</span><br><sp=
an>     bool tun_input_pending =3D false;</span><br><span> </span><br><span=
>@@ -716,7 +728,7 @@</span><br><span>         /*</span><br><span>          =
* Dispatch the action</span><br><span>          */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        struct multi_instance *touched =3D mul=
ti_io_dispatch(m, mi, action);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct multi_instance *touched =3D multi_io_dispatch(m, =
mi, sock, action);</span><br><span> </span><br><span>         /*</span><br>=
<span>          * Signal received or connection</span><br><span>diff --git =
a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index=
 c7f8f89=2E=2E7ae25c6 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh=
</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -68,11 +=
68,9 @@</span><br><span> </span><br><span> void multi_io_process_io(struct =
multi_context *m);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void multi_io_action(struct multi_context *m, struct multi_i=
nstance *mi, int action, bool poll);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void multi_io_action(struct multi_context *m, struct multi=
_instance *mi, struct link_socket *sock,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     int action, bool poll);</span><br=
><span> </span><br><span> void multi_io_delete_event(struct multi_io *multi=
_io, event_t event);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool multi_io_send_link(struct multi_context *m, struct mu=
lti_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    const unsigned int mpp_flags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* ifndef MULTI_IO_H =
*/</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b=
7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2046 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Dvlo+2A8giE=--


--===============5417584391202924623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5417584391202924623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5417584391202924623==--

