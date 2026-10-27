Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47329606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gl4x8PGb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ebjy6V3h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a/FY7/Di;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D+n+nw9Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=X2gX0U8HujkstOyEkddQTu7qBkJ8D2xqvazr8NT+t1I=; b=gl4x8PGbSxfj5k+nTHl+KCpsHT
	zJao/dzSzfAzwXpnJXP7uUYEZqaY4Sa3W/bcURIOIn3NfqY4uM5fnwSG9fEaxqi8IgFrrK3N9g1S3
	smGX8tDeYjHKUbJ7e14Em6GKu1fC2NiVQVLgRv6+DnU3HZB7Fzp3235fxF5SFs0JFGJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdm4-000000006b1-4AiY;
	Tue, 27 Oct 2026 09:47:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdm0-000000006aa-3egi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ui0zwhjJ6d5d6JAIA+25ZotKWCkNEh216womukgPMIQ=; b=Ebjy6V3hRhW8mlC3qApFJWPaYi
 QPv0AJt0Yz766RHeFY+PXSrGdcN1MrC20GL3Ua3y+bWm3PkgNvw50yDV2Fl5MLgiCis3uGq1+5aWJ
 zQtCTA/gAIGiifVbaF3g8Um/WsQ3L1Qk2WLc6TqNv7PMuTdyJakQhCP4mJHQ/T7E60BQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ui0zwhjJ6d5d6JAIA+25ZotKWCkNEh216womukgPMIQ=; b=a/FY7/DiccH+zizBPNN7axgpiy
 qiQl2D490TAn8CuOX612yLhAAJx2mmlRUhopUhxNFarmprxihr9+0EMLb9D3RV6zCkdn9vkjQlDh1
 4/TZIrmKVxISR65sOW6KuINXmE2WDPcnVAaGbzhJhuFLSiuoybbm6HL7xopxbDOBb+FU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlw-000000001EZ-2X66 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:16 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2617720f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094426; x=1793699226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ui0zwhjJ6d5d6JAIA+25ZotKWCkNEh216womukgPMIQ=;
 b=D+n+nw9YmxEDDMmjiQObUXBrzb1jcU2Oh2dIiOSJXhI0TntQ6IH+zb9qvoKlFno8vU
 YwKtzkBq+570ghOwIRymSEth9oqGXGktKJuJwbAIWZT/RY04+BEfXEmSPJWDDqqzQC1g
 V1JVoM7aFoPVP7DZHpDrsfANAQbZ7GMcJxqcLJ0j87zWk5v2uY3eZXxgdEQLpaTpj6rW
 7unADO3TDM8FYi1/rB2tDDIs+AqUCNvnl+z8uZIQ+Ho+9FfjBgwSzpuCDRkb6mVjZNbZ
 Ow3jrlcGnLsAQ626sgaquwO0AQ36hVzswHxGZyEwef4s+KJPmZD1r3AjigSgYmJnprQU
 o7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094426; x=1793699226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ui0zwhjJ6d5d6JAIA+25ZotKWCkNEh216womukgPMIQ=;
 b=gx2ae7ZrjdAFrBXYgU4X/gdDqSOiv1EdNvezABi/nZIZsJsS9VhaMH+AqmUHuh5kMO
 v9//7hk8r3J+2sbr8HBsm0inIRVN9dCTnz1HpZQcozLzOXQUV/ILoLLUuADAdLQPn8+c
 BnwsywEL0KakLU9NAl+J0V1fev1QK3GG9WEGCL6jP83mFIMi3tIAgvSQ0xqNbHjim2nT
 L8wz60F2/LWlDsF2ZRud+LiTdAJC71I3zpCVjbv/GiYbysc7/tugmLcVYfUGo1au37lY
 5rxNWma35982De7Q0J/HYI3pMlItqjoKjlJSaPc8SaJ3/V2qWSflxkglMJofklbuDpFJ
 OEwg==
X-Gm-Message-State: AFq9FYKkFHJ/6PRZWss+dRnRAQhB8BqesqN2vZo8sv9P/nGMLoZv2O3y
 /2p04WDliN/8lp47xcqW1xK+Yp3inejCpTP90A0P8b0VqX29DXZ1Bwn5kHIlO2xxDHSLjotuVda
 J0JG8TpQkeFhttlKeBvQ55Tdhgma3pvClxZFFtNPSzvOnzfeNzSp7wWRAyaP4dqYmu1HQlAb+74
 MjY8VNKA==
X-Gm-Gg: AYBFou3U9jIR5yS57AZGrgcUjnP2KdeBJqw15W9CbZ8A2AApC+gnZ7cccBk/3UuWvkF
 5FmIV8W6xCb0jFjKl/3Ht/OM8iZtsGYMMIIO0wLXRvFaE8/F4dKeotUVjtXsdIUDuC/myYK1nKH
 22YETGUktKRueKWI42bbHCvs/3Tijj/LW379Hk6cLEs0iCRIfi83j3Hz4sb/X0HSXE/AFK8p65n
 czSyIhQnT+XyY56pVjIG5kD9VwVQHn9g4oNIPDpew07KpBdetkoAQjeVp420vjtQ2crM4Tn0O8F
 9k/Z8xpI2x9MSu7+xkFDQ2CFkzM4JKWMVQUgYpuBSB20u0zTga3g5EkcLxbOFnpR6qrGeNr+8lg
 FaXThzFdGBVmoyXEPu5G5fNOSn5zoRy5gmpmoFtmqGmZJkl5ZjQsl7TACaeaISBnJRIqsO5jCWV
 dQ0x0+S5rSzSW5q8LxxlWbKp0oem+7EITMRiK168aGDBDcAVhC5rA9CaSeMNrZsGosZpbXerN7H
 60VCOUCxgLyJymmlSQ/duQAvWHnRMypARPwixqiIeZxm+ZeM1YvKdIZcZOc/V9PANhhaXYfTrYz
 LIRRXLM9846O+rXm5fdZah73OWD8GlBb+AvTXz53qPlgbOXsmazVgikW/em5vukBHg2QHvzbl97
 odvZd/f3akAbB2i9MzKkZmTjySzPwcG0s73IldqMz+w==
X-Received: by 2002:a05:6000:4308:b0:48e:d88:55f4 with SMTP id
 ffacd0b85a97d-48e3eb455a7mr17207338f8f.2.1793094425561; 
 Tue, 27 Oct 2026 02:47:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3da7sm23134751f8f.20.2026.10.27.02.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:04 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:04 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
X-Gerrit-Change-Number: 2048
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2048?usp=email>
X-Gerrit-Commit: b81e08f05de7470cde113f6d1bf0f3822b43429e
References: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllMzM4NGJhNDYzNDc4MDFhNmRlYTExYjk3Y2RmOWVkYzE3NjMyYzRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f8716bbf14421fd0270d0d3b49520b598cf6b9f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlw-000000001EZ-2X66
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: remove
 m->pending
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
Content-Type: multipart/mixed; boundary="===============6342448631058359012=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6342448631058359012==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zz4TzNs4awg="; charset=UTF-8

--Zz4TzNs4awg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2048?usp=3Demail

to review the following change=2E
=


Change subject: multi: remove m->pending
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: remove m->pending

m->pending pointe=
d to the instance with output still to be written=2E It
was set as a side e=
ffect of multi_process_post() and read back by the
multi_io_action() state =
machine, by p2mp_iow_flags() to arm tun and UDP
sockets for writing across =
event_wait(), and by the incoming functions,
which dropped the packet if it=
 was still set=2E

Now that every event goes through multi_io_action() and =
its output is
written before returning to the main loop, nothing is ever le=
ft pending
across event_wait()=2E Take the instance with output from the on=
e
dispatch touched instead, and pass it explicitly to the write functions=
=2E
Tun and UDP sockets are only armed for reading, so drop p2mp_iow_flags(=
)
and the tun/UDP write event branches=2E

Change-Id: Ie3384ba46347801a6dea=
11b97cdf9edc17632c4d
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn=
/multi_io=2Ec
3 files changed, 66 insertions(+), 136 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2048/1

dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 2841a81=2E=2E=
b1d7713 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -=
575,10 +575,6 @@
     mi->n_clients_delta =3D 0;
 
     /* prevent dangling=
 pointers */
-    if (m->pending =3D=3D mi)
-    {
-        multi_set_pendi=
ng(m, NULL);
-    }
     if (m->earliest_wakeup =3D=3D mi)
     {
         =
m->earliest_wakeup =3D NULL;
@@ -3098,18 +3094,15 @@
             ret =3D f=
alse;
         }
     }
+#ifdef MULTI_DEBUG_EVENT_LOOP
     else
     {
-  =
      /* continue to pend on output? */
-        multi_set_pending(m, ANY_O=
UT(&mi->context) ? mi : NULL);
-
-#ifdef MULTI_DEBUG_EVENT_LOOP
-        pr=
intf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int)(=
mi =3D=3D m->pending),
+        printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D=
%" PRIi64 "/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
                mi-=
>context=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2Eto_link=2Elen,
           =
     mi->context=2Ec2=2Efragment ? mi->context=2Ec2=2Efragment->outgoing=2E=
len : -1,
                (int64_t)mi->context=2Ec2=2Etimeval=2Etv_sec, (lo=
ng)mi->context=2Ec2=2Etimeval=2Etv_usec);
-#endif
     }
+#endif
 
     if =
((flags & MPP_RECORD_TOUCH) && m->mpp_touched)
     {
@@ -3400,13 +3393,14 =
@@
  * data packets=2E
  */
 static void
-multi_process_incoming_link_data(=
struct multi_context *m, bool floated, struct link_socket *sock)
+multi_pro=
cess_incoming_link_data(struct multi_context *m, struct multi_instance *mi,=
 bool floated,
+                                 struct link_socket *sock)
=
 {
     struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *o=
rig_buf;
 
     /* decrypt in instance context */
-    struct context *c =
=3D &m->pending->context;
+    struct context *c =3D &mi->context;
 
     o=
rig_buf =3D c->c2=2Ebuf=2Edata;
     if (process_incoming_link_part1(c, lsi=
, floated))
@@ -3414,7 +3408,7 @@
         /* nonzero length means that we =
have a valid, decrypted packed */
         if (floated && c->c2=2Ebuf=2Elen=
 > 0)
         {
-            multi_process_float(m, m->pending, sock);
+  =
          multi_process_float(m, mi, sock);
         }
 
         process_i=
ncoming_link_part2(c, lsi, orig_buf);
@@ -3433,7 +3427,7 @@
             c-=
>c2=2Eto_tun=2Elen =3D 0;
         }
         /* make sure that source addr=
ess is associated with this client */
-        else if (multi_get_instance_=
by_virtual_addr(m, &src, true) !=3D m->pending)
+        else if (multi_get=
_instance_by_virtual_addr(m, &src, true) !=3D mi)
         {
             /=
* IPv6 link-local address (fe80::xxx)? */
             if ((src=2Etype & MR=
_ADDR_MASK) =3D=3D MR_ADDR_IPV6
@@ -3458,18 +3452,18 @@
             if (mr=
oute_flags & MROUTE_EXTRACT_MCAST)
             {
                 /* for n=
ow, treat multicast as broadcast */
-                multi_bcast(m, &c->c2=
=2Eto_tun, m->pending, 0);
+                multi_bcast(m, &c->c2=2Eto_tun,=
 mi, 0);
             }
             else /* possible client to client rout=
ing */
             {
                 ASSERT(!(mroute_flags & MROUTE_EXTRA=
CT_BCAST));
-                struct multi_instance *mi =3D multi_get_instan=
ce_by_virtual_addr(m, &dest, true);
+                struct multi_instance =
*dest_mi =3D multi_get_instance_by_virtual_addr(m, &dest, true);
 
        =
         /* if dest addr is a known client, route to it */
-               =
 if (mi)
+                if (dest_mi)
                 {
                 =
    {
-                        multi_unicast(m, &c->c2=2Eto_tun, mi);
+    =
                    multi_unicast(m, &c->c2=2Eto_tun, dest_mi);
           =
              register_activity(c, BLEN(&c->c2=2Eto_tun));
                =
     }
                     c->c2=2Eto_tun=2Elen =3D 0;
@@ -3502,23 +3496,2=
4 @@
 
         if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
         {
-  =
          if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
+=
            if (multi_learn_addr(m, mi, &src, 0) =3D=3D mi)
             {
=
                 /* check for broadcast */
                 if (m->enable_c=
2c)
                 {
                     if (mroute_flags & (MROUTE_EXTR=
ACT_BCAST | MROUTE_EXTRACT_MCAST))
                     {
-                =
        multi_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
+                =
        multi_bcast(m, &c->c2=2Eto_tun, mi, vid);
                     }
  =
                   else /* try client-to-client routing */
                =
     {
-                        struct multi_instance *mi =3D multi_get_ins=
tance_by_virtual_addr(m, &dest, false);
+                        struct mul=
ti_instance *dest_mi =3D
+                            multi_get_instance_by=
_virtual_addr(m, &dest, false);
 
                         /* if dest addr =
is a known client, route to it */
-                        if (mi)
+       =
                 if (dest_mi)
                         {
-                 =
           multi_unicast(m, &c->c2=2Eto_tun, mi);
+                        =
    multi_unicast(m, &c->c2=2Eto_tun, dest_mi);
                           =
  register_activity(c, BLEN(&c->c2=2Eto_tun));
                            =
 c->c2=2Eto_tun=2Elen =3D 0;
                         }
@@ -3550,35 +3545,2=
7 @@
 multi_process_incoming_link(struct multi_context *m, struct multi_ins=
tance *instance,
                             const unsigned int mpp_flags,=
 struct link_socket *sock)
 {
+    struct multi_instance *mi =3D instance;
=
     struct context *c;
     bool ret =3D true;
     bool floated =3D false=
;
 
-    if (m->pending)
-    {
-        return true;
-    }
-
-    if (!in=
stance)
+    if (!mi)
     {
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf=
("TCP/UDP -> TUN [%d]\n", BLEN(&m->top=2Ec2=2Ebuf));
 #endif
-        multi=
_set_pending(m, multi_get_create_instance_udp(m, &floated, sock));
-    }
-=
    else
-    {
-        multi_set_pending(m, instance);
+        mi =3D mu=
lti_get_create_instance_udp(m, &floated, sock);
     }
 
-    if (!m->pendi=
ng)
+    if (!mi)
     {
         return true;
     }
-    set_prefix(m->pe=
nding);
+    set_prefix(mi);
 
     /* get instance context */
-    c =3D &=
m->pending->context;
+    c =3D &mi->context;
 
     if (!instance)
     {
=
@@ -3594,11 +3581,11 @@
 
     if (BLEN(&c->c2=2Ebuf) > 0)
     {
-        =
multi_process_incoming_link_data(m, floated, sock);
+        multi_process_=
incoming_link_data(m, mi, floated, sock);
     }
 
     /* postprocess and =
set wakeup */
-    ret =3D multi_process_post(m, m->pending, mpp_flags);
+ =
   ret =3D multi_process_post(m, mi, mpp_flags);
 
     clear_prefix();
 
@=
@ -3625,11 +3612,6 @@
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top=
=2Ec2=2Ebuf));
 #endif
 
-        if (m->pending)
-        {
-            r=
eturn true;
-        }
-
         if (dev_type =3D=3D DEV_TYPE_TAP && m->to=
p=2Eoptions=2Evlan_tagging)
         {
             vid =3D vlan_decapsulat=
e(&m->top, &m->top=2Ec2=2Ebuf);
@@ -3657,18 +3639,18 @@
             }
    =
         else
             {
-                multi_set_pending(
-         =
           m, multi_get_instance_by_virtual_addr(m, &dest, dev_type =3D=3D =
DEV_TYPE_TUN));
+                struct multi_instance *mi =3D
+           =
         multi_get_instance_by_virtual_addr(m, &dest, dev_type =3D=3D DEV_T=
YPE_TUN);
 
-                if (m->pending)
+                if (mi)
     =
            {
                     /* get instance context */
-            =
        c =3D &m->pending->context;
+                    c =3D &mi->context=
;
 
-                    set_prefix(m->pending);
+                    set_p=
refix(mi);
 
                     {
-                        if (multi_outp=
ut_queue_ready(m, m->pending))
+                        if (multi_output_qu=
eue_ready(m, mi))
                         {
                             /=
* transfer packet pointer from top-level context buffer to instance */
    =
                         c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
@@ -3686,7 +366=
8,7 @@
                     process_incoming_tun(c, c->c2=2Elink_sockets[0]=
);
 
                     /* postprocess and set wakeup */
-               =
     ret =3D multi_process_post(m, m->pending, mpp_flags);
+               =
     ret =3D multi_process_post(m, mi, mpp_flags);
 
                     c=
lear_prefix();
                 }
diff --git a/src/openvpn/multi=2Eh b/src/=
openvpn/multi=2Eh
index 31635ba=2E=2E02841af 100644
--- a/src/openvpn/multi=
=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -206,8 +206,11 @@
     unsigned long ci=
d_counter;
 #endif
 
-    struct multi_instance *pending;
     struct multi=
_instance *earliest_wakeup;
+    /* While multi_io_dispatch() runs an actio=
n, points to its local where
+     * multi_process_post() with MPP_RECORD_T=
OUCH stores the instance it
+     * processed=2E  An action post-processes =
at most one instance, which
+     * multi_io_action() then closes on signal=
 or writes the output of=2E */
     struct multi_instance **mpp_touched;
  =
   struct context_buffers *context_buffers;
     time_t per_second_trigger;=

@@ -638,11 +641,6 @@
  */
 #define MULTI_CHECK_SIG(m) EVENT_LOOP_CHECK_SIG=
NAL(&(m)->top, multi_process_signal, (m))
 
-static inline void
-multi_set_=
pending(struct multi_context *m, struct multi_instance *mi)
-{
-    m->pend=
ing =3D mi;
-}
 /**
  * Assigns a peer-id to a a client and adds the instan=
ce to the
  * the instances array of the \c multi_context structure=2E
diff=
 --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 24a6918=
=2E=2Ea14978b 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi=
_io=2Ec
@@ -135,36 +135,6 @@
     }
 }
 
-/*
- * Return the io flags approp=
riate for
- * a point-to-multipoint tunnel=2E
- */
-static unsigned int
-p2=
mp_iow_flags(const struct multi_context *m, const struct link_socket *sock)=

-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-
-    if (m->pending)
-  =
  {
-        if (TUN_OUT(&m->pending->context))
-        {
-            fla=
gs |=3D IOW_TO_TUN;
-        }
-
-        /* If the to be processed socket =
happens to be the same one on the pending
-         * UDP client instance, =
we set that socket ready for write */
-        if (LINK_OUT(&m->pending->co=
ntext) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
-        =
{
-            flags |=3D IOW_TO_LINK;
-        }
-    }
-    else
-    {
-=
        flags |=3D IOW_READ;
-    }
-    return flags;
-}
-
 int
 multi_io_=
wait(struct multi_context *m)
 {
@@ -177,7 +147,7 @@
 
         if (proto_i=
s_dgram(sock->info=2Eproto))
         {
-            multi_io_process_flags=
(&m->top, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
+            mul=
ti_io_process_flags(&m->top, m->multi_io->es, sock, IOW_READ | IOW_WAIT_SIG=
NAL);
         }
         else if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap)=
)
         {
@@ -281,6 +251,7 @@
  * perform server-mode postprocessing=2E
=
  *
  * @param m            - The single \c multi_context structure=2E
+ * =
@param mi           - The \c multi_instance with the packet to send=2E
  * =
@param mpp_flags    - Fast I/O optimization flags=2E
  *
  * @return
@@ -28=
9,12 +260,10 @@
  *  - Falls, if the \c multi_instance was closed=2E
  */
 =
static bool
-multi_io_write_tun(struct multi_context *m, const unsigned int=
 mpp_flags)
+multi_io_write_tun(struct multi_context *m, struct multi_insta=
nce *mi, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi =
=3D m->pending;
     bool ret =3D true;
 
-    ASSERT(mi);
 #ifdef MULTI_DE=
BUG_EVENT_LOOP
     printf("%s -> TUN len=3D%d\n", id(mi), mi->context=2Ec2=
=2Eto_tun=2Elen);
 #endif
@@ -310,12 +279,8 @@
  * Drop a TUN/TAP outgoing =
packet=2E=2E
  */
 static void
-multi_io_drop_tun(struct multi_context *m, =
const unsigned int mpp_flags)
+multi_io_drop_tun(struct multi_context *m, s=
truct multi_instance *mi, const unsigned int mpp_flags)
 {
-    struct mult=
i_instance *mi =3D m->pending;
-
-    ASSERT(mi);
-
     set_prefix(mi);
 
=
     msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet le=
n=3D%d",
@@ -328,24 +293,22 @@
 }
 
 /*
- * Determine which instance has pe=
nding output
- * and prepare the output for sending in
- * the to_link buff=
er=2E
+ * Determine which instance has output for the
+ * link: mi itself, =
or else the next queued
+ * bcast/c2c packet, prepared in its to_link buffe=
r=2E
  */
 static struct multi_instance *
-multi_io_write_link_pre(struct m=
ulti_context *m)
+multi_io_write_link_pre(struct multi_context *m, struct m=
ulti_instance *mi)
 {
-    struct multi_instance *mi =3D NULL;
-
-    if (m=
->pending)
+    if (mi && LINK_OUT(&mi->context))
     {
-        mi =3D m-=
>pending;
+        return mi;
     }
-    else if (mbuf_defined(m->mbuf))
+=
    if (mbuf_defined(m->mbuf))
     {
-        mi =3D multi_get_queue(m->mb=
uf);
+        return multi_get_queue(m->mbuf);
     }
-    return mi;
+    =
return NULL;
 }
 
 static bool
@@ -381,11 +344,12 @@
 }
 
 static bool
-mul=
ti_io_write_link(struct multi_context *m, bool defer, const unsigned int mp=
p_flags)
+multi_io_write_link(struct multi_context *m, struct multi_instanc=
e *mi, bool defer,
+                    const unsigned int mpp_flags)
 {
- =
   struct multi_instance *mi =3D multi_io_write_link_pre(m);
     bool ret =
=3D true;
 
+    mi =3D multi_io_write_link_pre(m, mi);
     if (mi)
     {=

         if ((defer && !proto_is_dgram(mi->context=2Ec2=2Elink_sockets[0]-=
>info=2Eproto))
@@ -406,20 +370,12 @@
                 mbuf_free_buf(mb);
 =
                buf_reset(buf);
                 ret =3D multi_process_post=
(m, mi, mpp_flags);
-                if (!ret)
-                {
-        =
            mi =3D NULL;
-                }
                 clear_prefix()=
;
             }
         }
         else
         {
             ret =3D m=
ulti_io_send_link(m, mi, mpp_flags);
-            if (!ret)
-            {
=
-                mi =3D NULL;
-            }
         }
     }
     return =
ret;
@@ -477,11 +433,13 @@
             break;
 
         case TA_TUN_WRITE=
:
-            multi_io_write_tun(m, mpp_flags);
+            ASSERT(mi);
+=
            multi_io_write_tun(m, mi, mpp_flags);
             break;
 
   =
      case TA_TUN_WRITE_TIMEOUT:
-            multi_io_drop_tun(m, mpp_flag=
s);
+            ASSERT(mi);
+            multi_io_drop_tun(m, mi, mpp_flag=
s);
             break;
 
         case TA_SOCKET_WRITE_READY:
@@ -490,11 +=
448,11 @@
             break;
 
         case TA_SOCKET_WRITE:
-           =
 multi_io_write_link(m, false, mpp_flags);
+            multi_io_write_link=
(m, mi, false, mpp_flags);
             break;
 
         case TA_SOCKET_WR=
ITE_DEFERRED:
-            multi_io_write_link(m, true, mpp_flags);
+      =
      multi_io_write_link(m, mi, true, mpp_flags);
             break;
 
  =
       case TA_INITIAL:
@@ -629,10 +587,6 @@
                             m=
ulti_io_action(m, mi, NULL, TA_INITIAL, false);
                         }
=
                     }
-                    else if (e->rwflags & EVENT_WRI=
TE)
-                    {
-                        multi_io_action(m, NULL=
, NULL, TA_SOCKET_WRITE, false);
-                    }
                   =
  else if (e->rwflags & EVENT_READ)
                     {
                =
         multi_io_action(m, NULL, ev_arg->u=2Esock, TA_SOCKET_READ, false);=

@@ -653,11 +607,7 @@
                 /* incoming data on TUN? */
        =
         if (e->arg =3D=3D MULTI_IO_TUN)
                 {
-              =
      if (e->rwflags & EVENT_WRITE)
-                    {
-               =
         multi_io_action(m, NULL, NULL, TA_TUN_WRITE, false);
-            =
        }
-                    else if (e->rwflags & EVENT_READ)
+         =
           if (e->rwflags & EVENT_READ)
                     {
            =
             multi_io_action(m, NULL, NULL, TA_TUN_READ, false);
          =
           }
@@ -749,17 +699,17 @@
                 mi =3D NULL;
          =
   }
             multi_close_instance_on_signal(m, touched);
+            =
touched =3D NULL;
         }
 
-
         /*
-         * If dispatch produc=
ed any pending output
-         * for a particular instance, point to
-    =
     * that instance=2E
+         * touched is the only instance this actio=
n
+         * post-processed: having closed it above if
+         * it was =
signalled, write its output if any=2E
          */
-        if (m->pending)=

+        if (touched && ANY_OUT(&touched->context))
         {
-          =
  mi =3D m->pending;
+            mi =3D touched;
         }
 
         /*
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3384ba46347801a=
6dea11b97cdf9edc17632c4d
Gerrit-Change-Number: 2048
Gerrit-PatchSet: 1
Gerr=
it-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--Zz4TzNs4awg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi: remove m-&gt;pending<br><br>m-&gt;pending pointe=
d to the instance with output still to be written=2E It<br>was set as a sid=
e effect of multi_process_post() and read back by the<br>multi_io_action() =
state machine, by p2mp_iow_flags() to arm tun and UDP<br>sockets for writin=
g across event_wait(), and by the incoming functions,<br>which dropped the =
packet if it was still set=2E<br><br>Now that every event goes through mult=
i_io_action() and its output is<br>written before returning to the main loo=
p, nothing is ever left pending<br>across event_wait()=2E Take the instance=
 with output from the one<br>dispatch touched instead, and pass it explicit=
ly to the write functions=2E<br>Tun and UDP sockets are only armed for read=
ing, so drop p2mp_iow_flags()<br>and the tun/UDP write event branches=2E<br=
><br>Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d<br>Signed-off-by:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/ope=
nvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br>=
3 files changed, 66 insertions(+), 136 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/204=
8/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</spa=
n><br><span>index 2841a81=2E=2Eb1d7713 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>=
@@ -575,10 +575,6 @@</span><br><span>     mi-&gt;n_clients_delta =3D 0;</sp=
an><br><span> </span><br><span>     /* prevent dangling pointers */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending =3D=3D =
mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending(m, NULL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n>     if (m-&gt;earliest_wakeup =3D=3D mi)</span><br><span>     {</span><b=
r><span>         m-&gt;earliest_wakeup =3D NULL;</span><br><span>@@ -3098,1=
8 +3094,15 @@</span><br><span>             ret =3D false;</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     else</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* continue to pend on output? */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        multi_set_pending(m, ANY_OUT(&amp;mi-&gt;context) ? =
mi : NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MULTI_DEBUG_EVENT_LOOP</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;PO=
ST %s[%d] to=3D%d lo=3D%d/%d w=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi),=
 (int)(mi =3D=3D m-&gt;pending),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        printf(&quot;POST %s[%d] to=3D%d lo=3D%d/%d w=3D%&quot=
; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)ANY_OUT(&amp;mi-&gt;context),</sp=
an><br><span>                mi-&gt;context=2Ec2=2Eto_tun=2Elen, mi-&gt;con=
text=2Ec2=2Eto_link=2Elen,</span><br><span>                mi-&gt;context=
=2Ec2=2Efragment ? mi-&gt;context=2Ec2=2Efragment-&gt;outgoing=2Elen : -1,<=
/span><br><span>                (int64_t)mi-&gt;context=2Ec2=2Etimeval=2Etv=
_sec, (long)mi-&gt;context=2Ec2=2Etimeval=2Etv_usec);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><b=
r><span>     if ((flags &amp; MPP_RECORD_TOUCH) &amp;&amp; m-&gt;mpp_touche=
d)</span><br><span>     {</span><br><span>@@ -3400,13 +3393,14 @@</span><br=
><span>  * data packets=2E</span><br><span>  */</span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_incomi=
ng_link_data(struct multi_context *m, bool floated, struct link_socket *soc=
k)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_inc=
oming_link_data(struct multi_context *m, struct multi_instance *mi, bool fl=
oated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                    struct link_socket *sock)</span><br><span> {</span><br>=
<span>     struct link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br><=
span>     const uint8_t *orig_buf;</span><br><span> </span><br><span>     /=
* decrypt in instance context */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct context *c =3D &amp;m-&gt;pending-&gt;context;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D =
&amp;mi-&gt;context;</span><br><span> </span><br><span>     orig_buf =3D c-=
&gt;c2=2Ebuf=2Edata;</span><br><span>     if (process_incoming_link_part1(c=
, lsi, floated))</span><br><span>@@ -3414,7 +3408,7 @@</span><br><span>    =
     /* nonzero length means that we have a valid, decrypted packed */</spa=
n><br><span>         if (floated &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            multi_process_float(m, m-&gt;pending, sock);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi_process_float(m, =
mi, sock);</span><br><span>         }</span><br><span> </span><br><span>   =
      process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>@@ -34=
33,7 +3427,7 @@</span><br><span>             c-&gt;c2=2Eto_tun=2Elen =3D 0;=
</span><br><span>         }</span><br><span>         /* make sure that sour=
ce address is associated with this client */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        else if (multi_get_instance_by_virtual_addr(=
m, &amp;src, true) !=3D m-&gt;pending)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if (multi_get_instance_by_virtual_addr(m, &=
amp;src, true) !=3D mi)</span><br><span>         {</span><br><span>        =
     /* IPv6 link-local address (fe80::xxx)? */</span><br><span>           =
  if ((src=2Etype &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV6</span><br><span>@=
@ -3458,18 +3452,18 @@</span><br><span>             if (mroute_flags &amp; =
MROUTE_EXTRACT_MCAST)</span><br><span>             {</span><br><span>      =
           /* for now, treat multicast as broadcast */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                multi_bcast(m, &amp;c-&gt;=
c2=2Eto_tun, m-&gt;pending, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, mi, 0);<=
/span><br><span>             }</span><br><span>             else /* possibl=
e client to client routing */</span><br><span>             {</span><br><spa=
n>                 ASSERT(!(mroute_flags &amp; MROUTE_EXTRACT_BCAST));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct mul=
ti_instance *mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, true);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                str=
uct multi_instance *dest_mi =3D multi_get_instance_by_virtual_addr(m, &amp;=
dest, true);</span><br><span> </span><br><span>                 /* if dest =
addr is a known client, route to it */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if (mi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (dest_mi)</span><br><span>         =
        {</span><br><span>                     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        multi_unicast(m, &amp;c-=
&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, dest_mi)=
;</span><br><span>                         register_activity(c, BLEN(&amp;c=
-&gt;c2=2Eto_tun));</span><br><span>                     }</span><br><span>=
                     c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span>@@ -350=
2,23 +3496,24 @@</span><br><span> </span><br><span>         if (mroute_flag=
s &amp; MROUTE_EXTRACT_SUCCEEDED)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (multi_learn_addr(m, =
m-&gt;pending, &amp;src, 0) =3D=3D m-&gt;pending)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (multi_learn_addr(m, mi, &amp;=
src, 0) =3D=3D mi)</span><br><span>             {</span><br><span>         =
        /* check for broadcast */</span><br><span>                 if (m-&g=
t;enable_c2c)</span><br><span>                 {</span><br><span>          =
           if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MC=
AST))</span><br><span>                     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        multi_bcast(m, &amp;c-&gt;c2=
=2Eto_tun, m-&gt;pending, vid);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, =
mi, vid);</span><br><span>                     }</span><br><span>          =
           else /* try client-to-client routing */</span><br><span>        =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 struct multi_instance *mi =3D multi_get_instance_by_virtua=
l_addr(m, &amp;dest, false);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        struct multi_instance *dest_mi =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 multi_get_instance_by_virtual_addr(m, &amp;dest, false);</span><br><span> =
</span><br><span>                         /* if dest addr is a known client=
, route to it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   if (mi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        if (dest_mi)</span><br><span>               =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            mul=
ti_unicast(m, &amp;c-&gt;c2=2Eto_tun, dest_mi);</span><br><span>           =
                  register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span=
><br><span>                             c-&gt;c2=2Eto_tun=2Elen =3D 0;</spa=
n><br><span>                         }</span><br><span>@@ -3550,35 +3545,27=
 @@</span><br><span> multi_process_incoming_link(struct multi_context *m, s=
truct multi_instance *instance,</span><br><span>                           =
  const unsigned int mpp_flags, struct link_socket *sock)</span><br><span> =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_i=
nstance *mi =3D instance;</span><br><span>     struct context *c;</span><br=
><span>     bool ret =3D true;</span><br><span>     bool floated =3D false;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return tru=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!instance)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!mi)</span><br><span>     {</span><br><span> #ifd=
ef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;TCP/UDP -&g=
t; TUN [%d]\n&quot;, BLEN(&amp;m-&gt;top=2Ec2=2Ebuf));</span><br><span> #en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_=
pending(m, multi_get_create_instance_udp(m, &amp;floated, sock));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       multi_set_pending(m, instance);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mi =3D multi_get_create_instance_udp(m, &amp;flo=
ated, sock);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!m-&gt;pending)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!mi)</span><br><span>     {</sp=
an><br><span>         return true;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    set_prefix(m-&gt;pending);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    set_prefix(mi);</span><b=
r><span> </span><br><span>     /* get instance context */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    c =3D &amp;m-&gt;pending-&gt;contex=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c =3D &amp;mi=
-&gt;context;</span><br><span> </span><br><span>     if (!instance)</span><=
br><span>     {</span><br><span>@@ -3594,11 +3581,11 @@</span><br><span> </=
span><br><span>     if (BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_pr=
ocess_incoming_link_data(m, floated, sock);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        multi_process_incoming_link_data(m, mi, flo=
ated, sock);</span><br><span>     }</span><br><span> </span><br><span>     =
/* postprocess and set wakeup */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D multi_proce=
ss_post(m, mi, mpp_flags);</span><br><span> </span><br><span>     clear_pre=
fix();</span><br><span> </span><br><span>@@ -3625,11 +3612,6 @@</span><br><=
span>         printf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;=
top=2Ec2=2Ebuf));</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;pending)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>         if (dev_type =3D=3D DEV_TY=
PE_TAP &amp;&amp; m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><span>     =
    {</span><br><span>             vid =3D vlan_decapsulate(&amp;m-&gt;top,=
 &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>@@ -3657,18 +3639,18 @@</span>=
<br><span>             }</span><br><span>             else</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         multi_set_pending(</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    m, multi_get_instance_by_virtual_addr(m, &amp;des=
t, dev_type =3D=3D DEV_TYPE_TUN));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                struct multi_instance *mi =3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    multi_get_inst=
ance_by_virtual_addr(m, &amp;dest, dev_type =3D=3D DEV_TYPE_TUN);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (mi)</span><br><span>                 {</span><br><spa=
n>                     /* get instance context */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    c =3D &amp;m-&gt;pending-&g=
t;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    set_prefix(m-&gt;pend=
ing);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      set_prefix(mi);</span><br><span> </span><br><span>                   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      if (multi_output_queue_ready(m, m-&gt;pending))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        if (multi_output_=
queue_ready(m, mi))</span><br><span>                         {</span><br><s=
pan>                             /* transfer packet pointer from top-level =
context buffer to instance */</span><br><span>                             =
c-&gt;c2=2Ebuf =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span>@@ -3686,7 +3668,7=
 @@</span><br><span>                     process_incoming_tun(c, c-&gt;c2=
=2Elink_sockets[0]);</span><br><span> </span><br><span>                    =
 /* postprocess and set wakeup */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    ret =3D multi_process_post(m, m-&gt;pending=
, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span=
> </span><br><span>                     clear_prefix();</span><br><span>   =
              }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/op=
envpn/multi=2Eh</span><br><span>index 31635ba=2E=2E02841af 100644</span><br=
><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -206,8 +206,11 @@</span><br><span>     unsigned lon=
g cid_counter;</span><br><span> #endif</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *pending;</spa=
n><br><span>     struct multi_instance *earliest_wakeup;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* While multi_io_dispatch() runs =
an action, points to its local where</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * multi_process_post() with MPP_RECORD_TOUCH stores t=
he instance it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* processed=2E  An action post-processes at most one instance, which</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * multi_io_action() t=
hen closes on signal or writes the output of=2E */</span><br><span>     str=
uct multi_instance **mpp_touched;</span><br><span>     struct context_buffe=
rs *context_buffers;</span><br><span>     time_t per_second_trigger;</span>=
<br><span>@@ -638,11 +641,6 @@</span><br><span>  */</span><br><span> #defin=
e MULTI_CHECK_SIG(m) EVENT_LOOP_CHECK_SIGNAL(&amp;(m)-&gt;top, multi_proces=
s_signal, (m))</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-multi_set_pending(struct multi_context *m, struct multi_instance *m=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    m-&gt;pending =3D mi;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> /**</span><br><s=
pan>  * Assigns a peer-id to a a client and adds the instance to the</span>=
<br><span>  * the instances array of the \c multi_context structure=2E</spa=
n><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2E=
c</span><br><span>index 24a6918=2E=2Ea14978b 100644</span><br><span>--- a/s=
rc/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</spa=
n><br><span>@@ -135,36 +135,6 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return the io flags =
appropriate for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a p=
oint-to-multipoint tunnel=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static unsi=
gned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flag=
s(const struct multi_context *m, const struct link_socket *sock)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned int flags =3D IOW_WAIT_SIGNAL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_TUN;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        /* If the to be processed socket happens to be the same one=
 on the pending</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * UDP client instance, we set that socket ready for write */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (LINK_OUT(&amp;m-&gt;p=
ending-&gt;context) &amp;&amp; m-&gt;pending-&gt;context=2Ec2=2Elink_socket=
s[0] =3D=3D sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            flag=
s |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        flags |=3D IOW_READ;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 int</span><br><span> multi_io_wait(struct multi_context *m)</span><br><spa=
n> {</span><br><span>@@ -177,7 +147,7 @@</span><br><span> </span><br><span>=
         if (proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_=
io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, p2mp_iow_flag=
s(m, sock));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, IO=
W_READ | IOW_WAIT_SIGNAL);</span><br><span>         }</span><br><span>     =
    else if (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span> =
        {</span><br><span>@@ -281,6 +251,7 @@</span><br><span>  * perform s=
erver-mode postprocessing=2E</span><br><span>  *</span><br><span>  * @param=
 m            - The single \c multi_context structure=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param mi           - The \c multi_=
instance with the packet to send=2E</span><br><span>  * @param mpp_flags   =
 - Fast I/O optimization flags=2E</span><br><span>  *</span><br><span>  * @=
return</span><br><span>@@ -289,12 +260,10 @@</span><br><span>  *  - Falls, =
if the \c multi_instance was closed=2E</span><br><span>  */</span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io=
_write_tun(struct multi_context *m, const unsigned int mpp_flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_tun(struct mul=
ti_context *m, struct multi_instance *mi, const unsigned int mpp_flags)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct multi_instance *mi =3D m-&gt;pending;</span><br><span>     bool ret =
=3D true;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(mi);</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span>=
<br><span>     printf(&quot;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;c=
ontext=2Ec2=2Eto_tun=2Elen);</span><br><span> #endif</span><br><span>@@ -31=
0,12 +279,8 @@</span><br><span>  * Drop a TUN/TAP outgoing packet=2E=2E</sp=
an><br><span>  */</span><br><span> static void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-multi_io_drop_tun(struct multi_context *m, const u=
nsigned int mpp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_io_drop_tun(struct multi_context *m, struct multi_instance *mi, co=
nst unsigned int mpp_flags)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m-&gt;pending;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     set_prefix(mi);</span><br><=
span> </span><br><span>     msg(D_MULTI_ERRORS, &quot;MULTI: Outgoing TUN q=
ueue full, dropped packet len=3D%d&quot;,</span><br><span>@@ -328,24 +293,2=
2 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Determine which instance has pen=
ding output</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * and pre=
pare the output for sending in</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * the to_link buffer=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Determine which instance has output for the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * link: mi itself, or else the ne=
xt queued</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * bcast/c=
2c packet, prepared in its to_link buffer=2E</span><br><span>  */</span><br=
><span> static struct multi_instance *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_io_write_link_pre(struct multi_context *m)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_write_link_pre(struc=
t multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; LINK_OUT=
(&amp;mi-&gt;context))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        mi =3D m-&gt;pending;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return mi;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf_def=
ined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (mbuf_defined(m-&gt;mbuf))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        mi =3D multi_get_queue(m-&gt;mbuf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return mul=
ti_get_queue(m-&gt;mbuf);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return mi;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return NULL;</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span>@@ -381,11 +344,12 @@</span><=
br><span> }</span><br><span> </span><br><span> static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-multi_io_write_link(struct multi_conte=
xt *m, bool defer, const unsigned int mpp_flags)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_io_write_link(struct multi_context *m, s=
truct multi_instance *mi, bool defer,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    const unsigned int mpp_flags)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 multi_instance *mi =3D multi_io_write_link_pre(m);</span><br><span>     bo=
ol ret =3D true;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mi =3D multi_io_write_link_pre(m, mi);</span><br><span> =
    if (mi)</span><br><span>     {</span><br><span>         if ((defer &amp=
;&amp; !proto_is_dgram(mi-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Epro=
to))</span><br><span>@@ -406,20 +370,12 @@</span><br><span>                =
 mbuf_free_buf(mb);</span><br><span>                 buf_reset(buf);</span>=
<br><span>                 ret =3D multi_process_post(m, mi, mpp_flags);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!ret=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    }</span><br><span>                 clear_prefix();</span><br><span>    =
         }</span><br><span>         }</span><br><span>         else</span><=
br><span>         {</span><br><span>             ret =3D multi_io_send_link=
(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (!ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     return ret;</span><br><span>@@ -477,11 +433,13 @@</span><br><span>  =
           break;</span><br><span> </span><br><span>         case TA_TUN_WR=
ITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi=
_io_write_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ASSERT(mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi_io_write_tun(m, mi, mpp_flags);</span><br><s=
pan>             break;</span><br><span> </span><br><span>         case TA_=
TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         multi_io_drop_tun(m, mpp_flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ASSERT(mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            multi_io_drop_tun(m, mi, mpp_flags);<=
/span><br><span>             break;</span><br><span> </span><br><span>     =
    case TA_SOCKET_WRITE_READY:</span><br><span>@@ -490,11 +448,11 @@</span=
><br><span>             break;</span><br><span> </span><br><span>         c=
ase TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_io_write_link(m, false, mpp_flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_io_write_link(m, mi, fa=
lse, mpp_flags);</span><br><span>             break;</span><br><span> </spa=
n><br><span>         case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_io_write_link(m, true, mp=
p_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi_io_write_link(m, mi, true, mpp_flags);</span><br><span>            =
 break;</span><br><span> </span><br><span>         case TA_INITIAL:</span><=
br><span>@@ -629,10 +587,6 @@</span><br><span>                             =
multi_io_action(m, mi, NULL, TA_INITIAL, false);</span><br><span>          =
               }</span><br><span>                     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    else if (e-&gt;rwflag=
s &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, fals=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  }</span><br><span>                     else if (e-&gt;rwflags &amp; EVENT=
_READ)</span><br><span>                     {</span><br><span>             =
            multi_io_action(m, NULL, ev_arg-&gt;u=2Esock, TA_SOCKET_READ, f=
alse);</span><br><span>@@ -653,11 +607,7 @@</span><br><span>               =
  /* incoming data on TUN? */</span><br><span>                 if (e-&gt;ar=
g =3D=3D MULTI_IO_TUN)</span><br><span>                 {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    if (e-&gt;rwflags &=
amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    multi_io_action(m, NULL, NULL, TA_TUN_WRITE, false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    else=
 if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EVENT_READ)</s=
pan><br><span>                     {</span><br><span>                      =
   multi_io_action(m, NULL, NULL, TA_TUN_READ, false);</span><br><span>    =
                 }</span><br><span>@@ -749,17 +699,17 @@</span><br><span>  =
               mi =3D NULL;</span><br><span>             }</span><br><span>=
             multi_close_instance_on_signal(m, touched);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            touched =3D NULL;</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>         /*</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * If dispatch produced any pending output</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * for a particu=
lar instance, point to</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * that instance=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * touched is the only instance this action</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * post-processed: having =
closed it above if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * it was signalled, write its output if any=2E</span><br><span>    =
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m=
-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (touched &amp;&amp; ANY_OUT(&amp;touched-&gt;context))</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            mi =3D touched;</span><br><span>         }</span><br><span>=
 </span><br><span>         /*</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail">change 2048</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie=
3384ba46347801a6dea11b97cdf9edc17632c4d </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2048 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Greg=
ori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Zz4TzNs4awg=--


--===============6342448631058359012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6342448631058359012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6342448631058359012==--

