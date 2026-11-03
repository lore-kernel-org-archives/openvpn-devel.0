Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024D606C567
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BQ3v3QWP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T5Xl06Te;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PGTQpf9Q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NP0gjgfz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OwHsKqNldDRm4XQ3FGgfK2fsYmW4hGQuuIVHCkwp5qA=; b=BQ3v3QWP9p1+q7jfhCnRhec/Uf
	9Pqq0WNmvZtAvh2Yl0UTHM/PrFK6Md+dSNg6HoNIBcwH4XXQkraPC6TV5SaCtHRRQ2SqowFX4mgLN
	kV+mYq5WowH71WvO7BSzOjmSgL/qycc0L9DSHCfReYpLqWn/guE1WFpfg/cWLuEKTKmU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCK1-000000001WQ-238S;
	Tue, 03 Nov 2026 11:04:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCJz-000000001WG-1Jbb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PZad6MGjkE6xXOKZA87PrfmkcdzoBioXTzo6gJgwkmk=; b=T5Xl06TeGMaF0xwAtJNz2ej5YP
 6LhlldViyjCjorffyFQHecDbIjrgvMXXnJ5TZ4+TYJlJ4QsSYZ/FiWp88Y4watMXcWGk3P3abuAjQ
 4xg0zdp3+dbTaOTKxLPjq0ren8Fly+OJ9JQumhYyMsTlYYev71q/LZ9BLk8Hu+q93xUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PZad6MGjkE6xXOKZA87PrfmkcdzoBioXTzo6gJgwkmk=; b=PGTQpf9Qn0jHYOFVtViQLAsV4z
 35nn+3cay3fsE6sEV7p9yTvKkwOx92XpHlsEtw5gpEgIQuO7h/i/HA++i5OzD/nvbd1/ziPT6ApTF
 AAvadZQi9+y0Q76foM1DqADDWP0dZQj42Ot8PC+ya3dQzrtvsgD1p+K9F42ZlwVjKaWk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCJv-000000001gY-3fkI for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:55 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1984619f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793703885; x=1794308685; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PZad6MGjkE6xXOKZA87PrfmkcdzoBioXTzo6gJgwkmk=;
 b=NP0gjgfzFveoCZ2J0q44/CqP/eI5pcUhAAzIdZQsvFAziMy+PiHv8cBEC9Lgecyz2F
 rqQgq0TnVnxmLL8fnyRX3Jb9nft96v/JA5YWMH1e1ZmhgE+j6g9K0tDXGcV8d/rmNvjD
 SPq5cH39PIzeoyJ+RpLJIw8tm7AlC1a1+iC7ceFv0xG5Ayr1vM3hP19tkiNhdNVRVR89
 g1TQf2SB1dmSxidpg2emuaoAKPcBx4U4wWaG9fSS3PccSxHIQAD3EEcn0N7oR3bIBzzG
 fbrK0RIwgWBftttd0Z/RZXSIQM6WW6MOAWq3vcVJEQfUj67s6AnsxouGYuqE7x7SCaAX
 Rf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703885; x=1794308685;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PZad6MGjkE6xXOKZA87PrfmkcdzoBioXTzo6gJgwkmk=;
 b=d+1lpgIkFpfap/GV13TXCjK2DCoTRcp8OZZCZjPlZ9qyU8hCSreKzneY2vbscOYa3R
 i7u6V1rEKSrdlSM5Gb3oU1a8qAgFiRTSJieBrncUWS5ywp9Fm51KlLexuZoFc/ZLRrEq
 Kn1qG4dFCfmGkZWcjeu9a7G+rfpsjBrmLwBBjxt2wdKLZXFBiE+RyAUy27zUxBxXIuDZ
 GkTdXLKJ+VZRlwNw2t5QI4gZ/aFqacY2KxV5dUaKPVrplEuHZGd+gZqspHaimsEtH3xp
 hb6s5mWxMrOdBJCfO43Mwq4wkg6BPt69cKOwKRf6HglATcAogjzeUtXbVyqKmcYrgU+Z
 /r2Q==
X-Gm-Message-State: APuU4Z9VIJLnFLUQZhQWkKs4r43HyhI+CA6QBleg9zNV/YNwOqvSCiw5
 PNgukHXWa3xdIg328KTUVn4dgbPVoXDiwc4q/wn+sSBbYGAm9UFZ+U3q/8Dj07rzcviljfsS4zS
 qKCOnlIpKauEntz0X/KkjlVj0jyaOsiP8S8HJTDBTMUy3JdkH2YXECCf5KzoEWPHEu6Uk
X-Gm-Gg: AYBFou0SzS1bRNcAgfr/EjQOg2ppIPfQh8aDUcdRJO5aoiWuIW/7SOeDs6amIKivWu3
 OtTHbbgC0Y4k5iccrNTV+/EXQXzC0u+qLWQ6wIV4PAQ9/y8i3bHB0nc0LX4WO2Jr8eyzvDQx0U2
 J8VPg0wNEe8bv7iG+uMU50lmqkb+EckuX6PcV2DOgZDn4ut1y3FGbE/Ek20g/pCk9IKT4AXi2O0
 HeFS203cD6zvgmEDuA6k7pFL/2WF/V/5ZAZ6WTLV0GLEtHLBgw72l2N+Erq1xAOoq7xdzSk0nLq
 ZDE4Ov3oUaPSTFKRvR4OWCV04xkOSR39MBZRVHtNGYGmg+pJXKxPdSIba92o65epqvPA3bQwG2a
 QnKw7hpUl7o5+W2mqWQFTj6d/bKU/aAYTy254zVI1gzvbzuUJWABbvaaJIZtWzhEWzS4Cw8vkA1
 VxskWydjjoxm+Wt9SndRoGAWDYEZoIHR750wsU+GnhGdWR/EQyUqIksCHuBWIF4zjlAVW6sdCAC
 OrKf3XQeclniExm9bR5EC9wDEwU7pp/SFuA5pyVVuiGnPAsGupVgP/x2AIb5XGj/Y2iFt6aRexX
 L2+k+QbXubpuD0dR7HZCxR3FFmi4mvpYGXkhfO7Vg2Wkg2rXRfiNvCA+YMi07zFM6uy2sAL0rE0
 4C56ObEQsqKBarOhc1zZFfqR6uCwm7BEEz+ekYVRbgLsFYxbeO8XifOn+g0CtrU6Ww5AjELe3cl
 jHXtoe6vv38Rw7jQ==
X-Received: by 2002:a5d:4d82:0:b0:48b:a21:87f7 with SMTP id
 ffacd0b85a97d-48e6e4f4ff5mr21780951f8f.44.1793703884793; 
 Tue, 03 Nov 2026 03:04:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e86a06078sm8378607f8f.54.2026.11.03.03.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:04:44 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:04:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
X-Gerrit-Change-Number: 2048
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2048?usp=email>
X-Gerrit-Commit: a2423fc78b86cca9e8247194e2922537670cf2cf
In-Reply-To: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkllMzM4NGJhNDYzNDc4MDFhNmRlYTExYjk3Y2RmOWVkYzE3NjMyYzRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f63ab008c20c74eaa7c68c455319e3baddfb6ac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCJv-000000001gY-3fkI
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0706749374496243485=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0706749374496243485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ahlhu9cDphg="; charset=UTF-8

--ahlhu9cDphg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?=
usp=3Demail

to look at the new patch set (#3)=2E

The change is no longer =
submittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject=
: multi: remove m->pending
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

multi: remove m->pending

m->pending pointed to the instance =
with output still to be written=2E It
was set as a side effect of multi_pro=
cess_post() and read back by the
multi_io_action() state machine, by p2mp_i=
ow_flags() to arm tun and UDP
sockets for writing across event_wait(), and =
by the incoming functions,
which dropped the packet if it was still set=2E
=

Now that every event goes through multi_io_action() and its output is
writ=
ten before returning to the main loop, nothing is ever left pending
across =
event_wait()=2E Take the instance with output from the one
dispatch touched=
 instead, and pass it explicitly to the write functions=2E
multi_io_write_l=
ink_pre(), which only chose between m->pending and mi,
goes away=2E Tun and=
 UDP sockets are only armed for reading, so drop
p2mp_iow_flags() and the t=
un/UDP write event branches=2E

Change-Id: Ie3384ba46347801a6dea11b97cdf9ed=
c17632c4d
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
-=
--
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=
=2Ec
3 files changed, 53 insertions(+), 141 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/2048/3

diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index c41905b=2E=2E2a4f78b 10=
0644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -575,10 +57=
5,6 @@
     mi->n_clients_delta =3D 0;
 
     /* prevent dangling pointers =
*/
-    if (m->pending =3D=3D mi)
-    {
-        multi_set_pending(m, NULL=
);
-    }
     if (m->earliest_wakeup =3D=3D mi)
     {
         m->earlies=
t_wakeup =3D NULL;
@@ -3110,18 +3106,15 @@
             ret =3D false;
    =
     }
     }
+#ifdef MULTI_DEBUG_EVENT_LOOP
     else
     {
-        /* c=
ontinue to pend on output? */
-        multi_set_pending(m, ANY_OUT(&mi->co=
ntext) ? mi : NULL);
-
-#ifdef MULTI_DEBUG_EVENT_LOOP
-        printf("POST=
 %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int)(mi =3D=3D =
m->pending),
+        printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 =
"/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
                mi->context=
=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2Eto_link=2Elen,
                mi-=
>context=2Ec2=2Efragment ? mi->context=2Ec2=2Efragment->outgoing=2Elen : -1=
,
                (int64_t)mi->context=2Ec2=2Etimeval=2Etv_sec, (long)mi->c=
ontext=2Ec2=2Etimeval=2Etv_usec);
-#endif
     }
+#endif
 
     if ((flags =
& MPP_RECORD_TOUCH) && m->mpp_touched)
     {
@@ -3413,13 +3406,14 @@
  * d=
ata packets=2E
  */
 static void
-multi_process_incoming_link_data(struct m=
ulti_context *m, bool floated, struct link_socket *sock)
+multi_process_inc=
oming_link_data(struct multi_context *m, struct multi_instance *mi, bool fl=
oated,
+                                 struct link_socket *sock)
 {
     =
struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *orig_buf;=

 
     /* decrypt in instance context */
-    struct context *c =3D &m->pe=
nding->context;
+    struct context *c =3D &mi->context;
 
     orig_buf =
=3D c->c2=2Ebuf=2Edata;
     if (process_incoming_link_part1(c, lsi, floate=
d))
@@ -3427,7 +3421,7 @@
         /* nonzero length means that we have a v=
alid, decrypted packed */
         if (floated && c->c2=2Ebuf=2Elen > 0)
  =
       {
-            multi_process_float(m, m->pending, sock);
+          =
  multi_process_float(m, mi, sock);
         }
 
         process_incoming_=
link_part2(c, lsi, orig_buf);
@@ -3446,7 +3440,7 @@
             c->c2=2Eto=
_tun=2Elen =3D 0;
         }
         /* make sure that source address is a=
ssociated with this client */
-        else if (multi_get_instance_by_virtu=
al_addr(m, &src, true) !=3D m->pending)
+        else if (multi_get_instanc=
e_by_virtual_addr(m, &src, true) !=3D mi)
         {
             /* IPv6 l=
ink-local address (fe80::xxx)? */
             if ((src=2Etype & MR_ADDR_MA=
SK) =3D=3D MR_ADDR_IPV6
@@ -3471,18 +3465,18 @@
             if (mroute_fla=
gs & MROUTE_EXTRACT_MCAST)
             {
                 /* for now, trea=
t multicast as broadcast */
-                multi_bcast(m, &c->c2=2Eto_tun=
, m->pending, 0);
+                multi_bcast(m, &c->c2=2Eto_tun, mi, 0);
=
             }
             else /* possible client to client routing */
  =
           {
                 ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST)=
);
-                struct multi_instance *mi =3D multi_get_instance_by_vir=
tual_addr(m, &dest, true);
+                struct multi_instance *dest_mi =
=3D multi_get_instance_by_virtual_addr(m, &dest, true);
 
                 =
/* if dest addr is a known client, route to it */
-                if (mi)
=
+                if (dest_mi)
                 {
                     {
-  =
                      multi_unicast(m, &c->c2=2Eto_tun, mi);
+             =
           multi_unicast(m, &c->c2=2Eto_tun, dest_mi);
                    =
     register_activity(c, BLEN(&c->c2=2Eto_tun));
                     }
  =
                   c->c2=2Eto_tun=2Elen =3D 0;
@@ -3515,23 +3509,24 @@
 
  =
       if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
         {
-           =
 if (multi_learn_addr(m, m->pending, &src, 0) =3D=3D m->pending)
+         =
   if (multi_learn_addr(m, mi, &src, 0) =3D=3D mi)
             {
         =
        /* check for broadcast */
                 if (m->enable_c2c)
     =
            {
                     if (mroute_flags & (MROUTE_EXTRACT_BCAST=
 | MROUTE_EXTRACT_MCAST))
                     {
-                        m=
ulti_bcast(m, &c->c2=2Eto_tun, m->pending, vid);
+                        m=
ulti_bcast(m, &c->c2=2Eto_tun, mi, vid);
                     }
           =
          else /* try client-to-client routing */
                     {
- =
                       struct multi_instance *mi =3D multi_get_instance_by_=
virtual_addr(m, &dest, false);
+                        struct multi_instan=
ce *dest_mi =3D
+                            multi_get_instance_by_virtual_=
addr(m, &dest, false);
 
                         /* if dest addr is a know=
n client, route to it */
-                        if (mi)
+                =
        if (dest_mi)
                         {
-                          =
  multi_unicast(m, &c->c2=2Eto_tun, mi);
+                            multi=
_unicast(m, &c->c2=2Eto_tun, dest_mi);
                             registe=
r_activity(c, BLEN(&c->c2=2Eto_tun));
                             c->c2=2E=
to_tun=2Elen =3D 0;
                         }
@@ -3563,35 +3558,27 @@
 mul=
ti_process_incoming_link(struct multi_context *m, struct multi_instance *in=
stance,
                             const unsigned int mpp_flags, struct l=
ink_socket *sock)
 {
+    struct multi_instance *mi =3D instance;
     stru=
ct context *c;
     bool ret =3D true;
     bool floated =3D false;
 
-    =
if (m->pending)
-    {
-        return true;
-    }
-
-    if (!instance)
+=
    if (!mi)
     {
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP=
 -> TUN [%d]\n", BLEN(&m->top=2Ec2=2Ebuf));
 #endif
-        multi_set_pend=
ing(m, multi_get_create_instance_udp(m, &floated, sock));
-    }
-    else
=
-    {
-        multi_set_pending(m, instance);
+        mi =3D multi_get_c=
reate_instance_udp(m, &floated, sock);
     }
 
-    if (!m->pending)
+    =
if (!mi)
     {
         return true;
     }
-    set_prefix(m->pending);
+=
    set_prefix(mi);
 
     /* get instance context */
-    c =3D &m->pendin=
g->context;
+    c =3D &mi->context;
 
     if (!instance)
     {
@@ -3607,=
11 +3594,11 @@
 
     if (BLEN(&c->c2=2Ebuf) > 0)
     {
-        multi_pro=
cess_incoming_link_data(m, floated, sock);
+        multi_process_incoming_=
link_data(m, mi, floated, sock);
     }
 
     /* postprocess and set wakeu=
p */
-    ret =3D multi_process_post(m, m->pending, mpp_flags);
+    ret =
=3D multi_process_post(m, mi, mpp_flags);
 
     clear_prefix();
 
@@ -3638=
,11 +3625,6 @@
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top=2Ec2=
=2Ebuf));
 #endif
 
-        if (m->pending)
-        {
-            return=
 true;
-        }
-
         if (dev_type =3D=3D DEV_TYPE_TAP && m->top=2Eo=
ptions=2Evlan_tagging)
         {
             vid =3D vlan_decapsulate(&m-=
>top, &m->top=2Ec2=2Ebuf);
@@ -3670,18 +3652,18 @@
             }
         =
    else
             {
-                multi_set_pending(
-              =
      m, multi_get_instance_by_virtual_addr(m, &dest, dev_type =3D=3D DEV_T=
YPE_TUN));
+                struct multi_instance *mi =3D
+                =
    multi_get_instance_by_virtual_addr(m, &dest, dev_type =3D=3D DEV_TYPE_T=
UN);
 
-                if (m->pending)
+                if (mi)
          =
       {
                     /* get instance context */
-                 =
   c =3D &m->pending->context;
+                    c =3D &mi->context;
 
-=
                    set_prefix(m->pending);
+                    set_prefix=
(mi);
 
                     {
-                        if (multi_output_qu=
eue_ready(m, m->pending))
+                        if (multi_output_queue_r=
eady(m, mi))
                         {
                             /* tra=
nsfer packet pointer from top-level context buffer to instance */
         =
                    c->c2=2Ebuf =3D m->top=2Ec2=2Ebuf;
@@ -3699,7 +3681,7 @=
@
                     process_incoming_tun(c, c->c2=2Elink_sockets[0]);
 
=
                     /* postprocess and set wakeup */
-                    =
ret =3D multi_process_post(m, m->pending, mpp_flags);
+                    =
ret =3D multi_process_post(m, mi, mpp_flags);
 
                     clear_=
prefix();
                 }
diff --git a/src/openvpn/multi=2Eh b/src/openv=
pn/multi=2Eh
index 4a93971=2E=2E305208a 100644
--- a/src/openvpn/multi=2Eh
=
+++ b/src/openvpn/multi=2Eh
@@ -208,8 +208,11 @@
     unsigned long cid_cou=
nter;
 #endif
 
-    struct multi_instance *pending;
     struct multi_inst=
ance *earliest_wakeup;
+    /* While multi_io_dispatch() runs an action, po=
ints to its local where
+     * multi_process_post() with MPP_RECORD_TOUCH =
stores the instance it
+     * processed=2E  An action post-processes at mo=
st one instance, which
+     * multi_io_action() then closes on signal or w=
rites the output of=2E */
     struct multi_instance **mpp_touched;
     st=
ruct context_buffers *context_buffers;
     time_t per_second_trigger;
@@ -=
640,11 +643,6 @@
  */
 #define MULTI_CHECK_SIG(m) EVENT_LOOP_CHECK_SIGNAL(&=
(m)->top, multi_process_signal, (m))
 
-static inline void
-multi_set_pendi=
ng(struct multi_context *m, struct multi_instance *mi)
-{
-    m->pending =
=3D mi;
-}
 /**
  * Assigns a peer-id to a a client and adds the instance t=
o the
  * the instances array of the \c multi_context structure=2E
diff --g=
it a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 83233d2=2E=
=2Ea6ce1d4 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=
=2Ec
@@ -135,36 +135,6 @@
     }
 }
 
-/*
- * Return the io flags appropria=
te for
- * a point-to-multipoint tunnel=2E
- */
-static unsigned int
-p2mp_=
iow_flags(const struct multi_context *m, const struct link_socket *sock)
-{=

-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-
-    if (m->pending)
-    {=

-        if (TUN_OUT(&m->pending->context))
-        {
-            flags =
|=3D IOW_TO_TUN;
-        }
-
-        /* If the to be processed socket hap=
pens to be the same one on the pending
-         * UDP client instance, we =
set that socket ready for write */
-        if (LINK_OUT(&m->pending->conte=
xt) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
-        {
-=
            flags |=3D IOW_TO_LINK;
-        }
-    }
-    else
-    {
-   =
     flags |=3D IOW_READ;
-    }
-    return flags;
-}
-
 int
 multi_io_wai=
t(struct multi_context *m)
 {
@@ -177,7 +147,7 @@
 
         if (proto_is_d=
gram(sock->info=2Eproto))
         {
-            multi_io_process_flags(&m=
->top, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
+            multi_=
io_process_flags(&m->top, m->multi_io->es, sock, IOW_READ | IOW_WAIT_SIGNAL=
);
         }
         else if (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
 =
        {
@@ -281,6 +251,7 @@
  * perform server-mode postprocessing=2E
  *=

  * @param m            - The single \c multi_context structure=2E
+ * @pa=
ram mi           - The \c multi_instance with the packet to send=2E
  * @pa=
ram mpp_flags    - Fast I/O optimization flags=2E
  *
  * @return
@@ -289,1=
2 +260,10 @@
  *  - Falls, if the \c multi_instance was closed=2E
  */
 sta=
tic bool
-multi_io_write_tun(struct multi_context *m, const unsigned int mp=
p_flags)
+multi_io_write_tun(struct multi_context *m, struct multi_instance=
 *mi, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi =3D m=
->pending;
     bool ret =3D true;
 
-    ASSERT(mi);
 #ifdef MULTI_DEBUG_E=
VENT_LOOP
     printf("%s -> TUN len=3D%d\n", id(mi), mi->context=2Ec2=2Eto=
_tun=2Elen);
 #endif
@@ -310,12 +279,8 @@
  * Drop a TUN/TAP outgoing packe=
t=2E=2E
  */
 static void
-multi_io_drop_tun(struct multi_context *m, const=
 unsigned int mpp_flags)
+multi_io_drop_tun(struct multi_context *m, struct=
 multi_instance *mi, const unsigned int mpp_flags)
 {
-    struct multi_ins=
tance *mi =3D m->pending;
-
-    ASSERT(mi);
-
     set_prefix(mi);
 
     =
msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet len=3D%=
d",
@@ -327,24 +292,6 @@
     clear_prefix();
 }
 
-/*
- * Determine which =
instance has output for the
- * link: the pending instance, or else mi itse=
lf=2E
- */
-static struct multi_instance *
-multi_io_write_link_pre(struct =
multi_context *m, struct multi_instance *mi)
-{
-    if (m->pending)
-    {=

-        return m->pending;
-    }
-    if (mi && LINK_OUT(&mi->context))
=
-    {
-        return mi;
-    }
-    return NULL;
-}
-
 static bool
 mult=
i_io_send_link(struct multi_context *m, struct multi_instance *mi, const un=
signed int mpp_flags)
 {
@@ -383,8 +330,7 @@
 {
     bool ret =3D true;
 
-=
    mi =3D multi_io_write_link_pre(m, mi);
-    if (mi)
+    if (mi && LINK=
_OUT(&mi->context))
     {
         if ((defer && !proto_is_dgram(mi->conte=
xt=2Ec2=2Elink_sockets[0]->info=2Eproto))
             || mbuf_defined(mi->=
tcp_link_out_deferred))
@@ -404,20 +350,12 @@
                 mbuf_free_bu=
f(mb);
                 buf_reset(buf);
                 ret =3D multi_proc=
ess_post(m, mi, mpp_flags);
-                if (!ret)
-                {
-=
                    mi =3D NULL;
-                }
                 clear_=
prefix();
             }
         }
         else
         {
             r=
et =3D multi_io_send_link(m, mi, mpp_flags);
-            if (!ret)
-      =
      {
-                mi =3D NULL;
-            }
         }
     }
    =
 return ret;
@@ -475,11 +413,13 @@
             break;
 
         case TA_T=
UN_WRITE:
-            multi_io_write_tun(m, mpp_flags);
+            ASSER=
T(mi);
+            multi_io_write_tun(m, mi, mpp_flags);
             brea=
k;
 
         case TA_TUN_WRITE_TIMEOUT:
-            multi_io_drop_tun(m, =
mpp_flags);
+            ASSERT(mi);
+            multi_io_drop_tun(m, mi, =
mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_READY:
@@ -=
627,10 +567,6 @@
                             multi_io_action(m, mi, NULL, =
TA_INITIAL, false);
                         }
                     }
-    =
                else if (e->rwflags & EVENT_WRITE)
-                    {
-=
                        multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, fal=
se);
-                    }
                     else if (e->rwflags & EVEN=
T_READ)
                     {
                         multi_io_action(m, =
NULL, ev_arg->u=2Esock, TA_SOCKET_READ, false);
@@ -651,11 +587,7 @@
      =
           /* incoming data on TUN? */
                 if (e->arg =3D=3D M=
ULTI_IO_TUN)
                 {
-                    if (e->rwflags & EVENT=
_WRITE)
-                    {
-                        multi_io_action(m, =
NULL, NULL, TA_TUN_WRITE, false);
-                    }
-                 =
   else if (e->rwflags & EVENT_READ)
+                    if (e->rwflags & =
EVENT_READ)
                     {
                         multi_io_action=
(m, NULL, NULL, TA_TUN_READ, false);
                     }
@@ -749,17 +681=
,17 @@
                 mi =3D NULL;
             }
             multi_clos=
e_instance_on_signal(m, touched);
+            touched =3D NULL;
         }=

 
-
         /*
-         * If dispatch produced any pending output
-     =
    * for a particular instance, point to
-         * that instance=2E
+   =
      * touched is the only instance this action
+         * post-processed=
: having closed it above if
+         * it was signalled, write its output =
if any=2E
          */
-        if (m->pending)
+        if (touched && ANY=
_OUT(&touched->context))
         {
-            mi =3D m->pending;
+      =
      mi =3D touched;
         }
 
         /*

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
G=
errit-Change-Number: 2048
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gre=
gori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: G=
ianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--ahlhu9cDphg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gianmar=
co De Gregori <strong>uploaded patch set #3</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Demail">V=
iew Change</a></p><p>The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">multi: remove m-&gt;pending<b=
r><br>m-&gt;pending pointed to the instance with output still to be written=
=2E It<br>was set as a side effect of multi_process_post() and read back by=
 the<br>multi_io_action() state machine, by p2mp_iow_flags() to arm tun and=
 UDP<br>sockets for writing across event_wait(), and by the incoming functi=
ons,<br>which dropped the packet if it was still set=2E<br><br>Now that eve=
ry event goes through multi_io_action() and its output is<br>written before=
 returning to the main loop, nothing is ever left pending<br>across event_w=
ait()=2E Take the instance with output from the one<br>dispatch touched ins=
tead, and pass it explicitly to the write functions=2E<br>multi_io_write_li=
nk_pre(), which only chose between m-&gt;pending and mi,<br>goes away=2E Tu=
n and UDP sockets are only armed for reading, so drop<br>p2mp_iow_flags() a=
nd the tun/UDP write event branches=2E<br><br>Change-Id: Ie3384ba46347801a6=
dea11b97cdf9edc17632c4d<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/mu=
lti=2Eh<br>M src/openvpn/multi_io=2Ec<br>3 files changed, 53 insertions(+),=
 141 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/48/2048/3</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index c41905b=2E=2E2a4=
f78b 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++=
 b/src/openvpn/multi=2Ec</span><br><span>@@ -575,10 +575,6 @@</span><br><sp=
an>     mi-&gt;n_clients_delta =3D 0;</span><br><span> </span><br><span>   =
  /* prevent dangling pointers */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (m-&gt;pending =3D=3D mi)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        multi_set_pending(m, NULL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span>     if (m-&gt;earliest_wakeup =
=3D=3D mi)</span><br><span>     {</span><br><span>         m-&gt;earliest_w=
akeup =3D NULL;</span><br><span>@@ -3110,18 +3106,15 @@</span><br><span>   =
          ret =3D false;</span><br><span>         }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef MULTI_DEBUG_E=
VENT_LOOP</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* continue to pend on output?=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_=
pending(m, ANY_OUT(&amp;mi-&gt;context) ? mi : NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        printf(&quot;POST %s[%d] to=3D%d lo=3D%d/%d w=3D=
%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)(mi =3D=3D m-&gt;pending),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot=
;POST %s[%d] to=3D%d lo=3D%d/%d w=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(m=
i), (int)ANY_OUT(&amp;mi-&gt;context),</span><br><span>                mi-&=
gt;context=2Ec2=2Eto_tun=2Elen, mi-&gt;context=2Ec2=2Eto_link=2Elen,</span>=
<br><span>                mi-&gt;context=2Ec2=2Efragment ? mi-&gt;context=
=2Ec2=2Efragment-&gt;outgoing=2Elen : -1,</span><br><span>                (=
int64_t)mi-&gt;context=2Ec2=2Etimeval=2Etv_sec, (long)mi-&gt;context=2Ec2=
=2Etimeval=2Etv_usec);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span> </span><br><span>     if ((flags &amp; M=
PP_RECORD_TOUCH) &amp;&amp; m-&gt;mpp_touched)</span><br><span>     {</span=
><br><span>@@ -3413,13 +3406,14 @@</span><br><span>  * data packets=2E</spa=
n><br><span>  */</span><br><span> static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_process_incoming_link_data(struct multi_conte=
xt *m, bool floated, struct link_socket *sock)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_process_incoming_link_data(struct multi_co=
ntext *m, struct multi_instance *mi, bool floated,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 struct link=
_socket *sock)</span><br><span> {</span><br><span>     struct link_socket_i=
nfo *lsi =3D &amp;sock-&gt;info;</span><br><span>     const uint8_t *orig_b=
uf;</span><br><span> </span><br><span>     /* decrypt in instance context *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *=
c =3D &amp;m-&gt;pending-&gt;context;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;</span><br>=
<span> </span><br><span>     orig_buf =3D c-&gt;c2=2Ebuf=2Edata;</span><br>=
<span>     if (process_incoming_link_part1(c, lsi, floated))</span><br><spa=
n>@@ -3427,7 +3421,7 @@</span><br><span>         /* nonzero length means th=
at we have a valid, decrypted packed */</span><br><span>         if (floate=
d &amp;&amp; c-&gt;c2=2Ebuf=2Elen &gt; 0)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_fl=
oat(m, m-&gt;pending, sock);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            multi_process_float(m, mi, sock);</span><br><span>    =
     }</span><br><span> </span><br><span>         process_incoming_link_par=
t2(c, lsi, orig_buf);</span><br><span>@@ -3446,7 +3440,7 @@</span><br><span=
>             c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span>         }</sp=
an><br><span>         /* make sure that source address is associated with t=
his client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
else if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D m-&gt;p=
ending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (multi_get_instance_by_virtual_addr(m, &amp;src, true) !=3D mi)</span><=
br><span>         {</span><br><span>             /* IPv6 link-local address=
 (fe80::xxx)? */</span><br><span>             if ((src=2Etype &amp; MR_ADDR=
_MASK) =3D=3D MR_ADDR_IPV6</span><br><span>@@ -3471,18 +3465,18 @@</span><b=
r><span>             if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br=
><span>             {</span><br><span>                 /* for now, treat mu=
lticast as broadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mul=
ti_bcast(m, &amp;c-&gt;c2=2Eto_tun, mi, 0);</span><br><span>             }<=
/span><br><span>             else /* possible client to client routing */</=
span><br><span>             {</span><br><span>                 ASSERT(!(mro=
ute_flags &amp; MROUTE_EXTRACT_BCAST));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                struct multi_instance *mi =3D multi_get_i=
nstance_by_virtual_addr(m, &amp;dest, true);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                struct multi_instance *dest_mi =3D=
 multi_get_instance_by_virtual_addr(m, &amp;dest, true);</span><br><span> <=
/span><br><span>                 /* if dest addr is a known client, route t=
o it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      if (dest_mi)</span><br><span>                 {</span><br><span>     =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    multi_unicast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        multi=
_unicast(m, &amp;c-&gt;c2=2Eto_tun, dest_mi);</span><br><span>             =
            register_activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><=
span>                     }</span><br><span>                     c-&gt;c2=
=2Eto_tun=2Elen =3D 0;</span><br><span>@@ -3515,23 +3509,24 @@</span><br><s=
pan> </span><br><span>         if (mroute_flags &amp; MROUTE_EXTRACT_SUCCEE=
DED)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (multi_learn_addr(m, m-&gt;pending, &amp;src, 0) =
=3D=3D m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (multi_learn_addr(m, mi, &amp;src, 0) =3D=3D mi)</span><br=
><span>             {</span><br><span>                 /* check for broadca=
st */</span><br><span>                 if (m-&gt;enable_c2c)</span><br><spa=
n>                 {</span><br><span>                     if (mroute_flags =
&amp; (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))</span><br><span>      =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, m-&gt;pending, vi=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        multi_bcast(m, &amp;c-&gt;c2=2Eto_tun, mi, vid);</span><br><span>  =
                   }</span><br><span>                     else /* try clien=
t-to-client routing */</span><br><span>                     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        struct mult=
i_instance *mi =3D multi_get_instance_by_virtual_addr(m, &amp;dest, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     struct multi_instance *dest_mi =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                            multi_get_instance_by_virtu=
al_addr(m, &amp;dest, false);</span><br><span> </span><br><span>           =
              /* if dest addr is a known client, route to it */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        if (mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   if (dest_mi)</span><br><span>                         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                            multi_unic=
ast(m, &amp;c-&gt;c2=2Eto_tun, mi);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            multi_unicast(m, &amp;c-&gt;c2=
=2Eto_tun, dest_mi);</span><br><span>                             register_=
activity(c, BLEN(&amp;c-&gt;c2=2Eto_tun));</span><br><span>                =
             c-&gt;c2=2Eto_tun=2Elen =3D 0;</span><br><span>               =
          }</span><br><span>@@ -3563,35 +3558,27 @@</span><br><span> multi_=
process_incoming_link(struct multi_context *m, struct multi_instance *insta=
nce,</span><br><span>                             const unsigned int mpp_fl=
ags, struct link_socket *sock)</span><br><span> {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =3D instance;</=
span><br><span>     struct context *c;</span><br><span>     bool ret =3D tr=
ue;</span><br><span>     bool floated =3D false;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!instance)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!mi)</span><br><span>     {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOO=
P</span><br><span>         printf(&quot;TCP/UDP -&gt; TUN [%d]\n&quot;, BLE=
N(&amp;m-&gt;top=2Ec2=2Ebuf));</span><br><span> #endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending(m, multi_get_cre=
ate_instance_udp(m, &amp;floated, sock));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending=
(m, instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mi =3D multi_get_create_instance_udp(m, &amp;floated, sock);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!m-&gt;pending)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!mi)</span><br><span>     {</span><br><span>         re=
turn true;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    set_prefix(m-&gt;pending);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    set_prefix(mi);</span><br><span> </span><br><spa=
n>     /* get instance context */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    c =3D &amp;m-&gt;pending-&gt;context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c =3D &amp;mi-&gt;context;</span><br>=
<span> </span><br><span>     if (!instance)</span><br><span>     {</span><b=
r><span>@@ -3607,11 +3594,11 @@</span><br><span> </span><br><span>     if (=
BLEN(&amp;c-&gt;c2=2Ebuf) &gt; 0)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        multi_process_incoming_link_data=
(m, floated, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        multi_process_incoming_link_data(m, mi, floated, sock);</span><br><=
span>     }</span><br><span> </span><br><span>     /* postprocess and set w=
akeup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D m=
ulti_process_post(m, m-&gt;pending, mpp_flags);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ret =3D multi_process_post(m, mi, mpp_flags=
);</span><br><span> </span><br><span>     clear_prefix();</span><br><span> =
</span><br><span>@@ -3638,11 +3625,6 @@</span><br><span>         printf(&qu=
ot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top=2Ec2=2Ebuf));</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (m-&gt;pending)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return true;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         if (dev_type =3D=3D DEV_TYPE_TAP &amp;&amp; m-&gt;t=
op=2Eoptions=2Evlan_tagging)</span><br><span>         {</span><br><span>   =
          vid =3D vlan_decapsulate(&amp;m-&gt;top, &amp;m-&gt;top=2Ec2=2Ebu=
f);</span><br><span>@@ -3670,18 +3652,18 @@</span><br><span>             }<=
/span><br><span>             else</span><br><span>             {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                multi_set_pendin=
g(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 m, multi_get_instance_by_virtual_addr(m, &amp;dest, dev_type =3D=3D DEV_TY=
PE_TUN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      struct multi_instance *mi =3D</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    multi_get_instance_by_virtual_addr(m, &=
amp;dest, dev_type =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                if (m-&gt;pending)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (mi)=
</span><br><span>                 {</span><br><span>                     /*=
 get instance context */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    c =3D &amp;m-&gt;pending-&gt;context;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    c =3D &amp;mi-=
&gt;context;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    set_prefix(m-&gt;pending);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    set_prefix(mi);</sp=
an><br><span> </span><br><span>                     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        if (multi_output_qu=
eue_ready(m, m-&gt;pending))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        if (multi_output_queue_ready(m, mi))</span=
><br><span>                         {</span><br><span>                     =
        /* transfer packet pointer from top-level context buffer to instanc=
e */</span><br><span>                             c-&gt;c2=2Ebuf =3D m-&gt;=
top=2Ec2=2Ebuf;</span><br><span>@@ -3699,7 +3681,7 @@</span><br><span>     =
                process_incoming_tun(c, c-&gt;c2=2Elink_sockets[0]);</span>=
<br><span> </span><br><span>                     /* postprocess and set wak=
eup */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     ret =3D multi_process_post(m, m-&gt;pending, mpp_flags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    ret =3D multi=
_process_post(m, mi, mpp_flags);</span><br><span> </span><br><span>        =
             clear_prefix();</span><br><span>                 }</span><br><=
span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><=
span>index 4a93971=2E=2E305208a 100644</span><br><span>--- a/src/openvpn/mu=
lti=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -208=
,8 +208,11 @@</span><br><span>     unsigned long cid_counter;</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct multi_instance *pending;</span><br><span>     struct mult=
i_instance *earliest_wakeup;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* While multi_io_dispatch() runs an action, points to its loc=
al where</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * mult=
i_process_post() with MPP_RECORD_TOUCH stores the instance it</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * processed=2E  An action po=
st-processes at most one instance, which</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * multi_io_action() then closes on signal or writ=
es the output of=2E */</span><br><span>     struct multi_instance **mpp_tou=
ched;</span><br><span>     struct context_buffers *context_buffers;</span><=
br><span>     time_t per_second_trigger;</span><br><span>@@ -640,11 +643,6 =
@@</span><br><span>  */</span><br><span> #define MULTI_CHECK_SIG(m) EVENT_L=
OOP_CHECK_SIGNAL(&amp;(m)-&gt;top, multi_process_signal, (m))</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_set_pending(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    m-&gt;pending =3D mi;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span> /**</span><br><span>  * Assigns a peer-id to=
 a a client and adds the instance to the</span><br><span>  * the instances =
array of the \c multi_context structure=2E</span><br><span>diff --git a/src=
/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 8323=
3d2=2E=2Ea6ce1d4 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -135,36 +135,=
6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Return the io flags appropriate for</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * a point-to-multipoint tunnel=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static unsigned int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_context=
 *m, const struct link_socket *sock)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TUN_OUT=
(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* If the to=
 be processed socket happens to be the same one on the pending</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * UDP client instance, we=
 set that socket ready for write */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;context) &amp;&am=
p; m-&gt;pending-&gt;context=2Ec2=2Elink_sockets[0] =3D=3D sock)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_LINK;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fla=
gs |=3D IOW_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return flags;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> mult=
i_io_wait(struct multi_context *m)</span><br><span> {</span><br><span>@@ -1=
77,7 +147,7 @@</span><br><span> </span><br><span>         if (proto_is_dgra=
m(sock-&gt;info=2Eproto))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_io_process_flags(&amp;m-&=
gt;top, m-&gt;multi_io-&gt;es, sock, p2mp_iow_flags(m, sock));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi_io_process_fla=
gs(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, IOW_READ | IOW_WAIT_SIGNAL)=
;</span><br><span>         }</span><br><span>         else if (!tuntap_is_d=
co_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {</span><br><span=
>@@ -281,6 +251,7 @@</span><br><span>  * perform server-mode postprocessing=
=2E</span><br><span>  *</span><br><span>  * @param m            - The singl=
e \c multi_context structure=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param mi           - The \c multi_instance with the packet =
to send=2E</span><br><span>  * @param mpp_flags    - Fast I/O optimization =
flags=2E</span><br><span>  *</span><br><span>  * @return</span><br><span>@@=
 -289,12 +260,10 @@</span><br><span>  *  - Falls, if the \c multi_instance =
was closed=2E</span><br><span>  */</span><br><span> static bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-multi_io_write_tun(struct multi_c=
ontext *m, const unsigned int mpp_flags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_io_write_tun(struct multi_context *m, struct mul=
ti_instance *mi, const unsigned int mpp_flags)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =
=3D m-&gt;pending;</span><br><span>     bool ret =3D true;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi);</spa=
n><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     printf(&quo=
t;%s -&gt; TUN len=3D%d\n&quot;, id(mi), mi-&gt;context=2Ec2=2Eto_tun=2Elen=
);</span><br><span> #endif</span><br><span>@@ -310,12 +279,8 @@</span><br><=
span>  * Drop a TUN/TAP outgoing packet=2E=2E</span><br><span>  */</span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
ulti_io_drop_tun(struct multi_context *m, const unsigned int mpp_flags)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_drop_tun(struc=
t multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct multi_instance *mi =3D m-&gt;pending;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     set_prefix(mi);</span><br><span> </span><br><span>    =
 msg(D_MULTI_ERRORS, &quot;MULTI: Outgoing TUN queue full, dropped packet l=
en=3D%d&quot;,</span><br><span>@@ -327,24 +292,6 @@</span><br><span>     cl=
ear_prefix();</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Determine which instance has output for the</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * link: the pending instance, or else m=
i itself=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_write_link=
_pre(struct multi_context *m, struct multi_instance *mi)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return m-&gt;pending;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
mi &amp;&amp; LINK_OUT(&amp;mi-&gt;context))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return mi;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><=
br><span> multi_io_send_link(struct multi_context *m, struct multi_instance=
 *mi, const unsigned int mpp_flags)</span><br><span> {</span><br><span>@@ -=
383,8 +330,7 @@</span><br><span> {</span><br><span>     bool ret =3D true;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
mi =3D multi_io_write_link_pre(m, mi);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (mi &amp;&amp; LINK_OUT(&amp;mi-&gt;context))</span><br><sp=
an>     {</span><br><span>         if ((defer &amp;&amp; !proto_is_dgram(mi=
-&gt;context=2Ec2=2Elink_sockets[0]-&gt;info=2Eproto))</span><br><span>    =
         || mbuf_defined(mi-&gt;tcp_link_out_deferred))</span><br><span>@@ =
-404,20 +350,12 @@</span><br><span>                 mbuf_free_buf(mb);</spa=
n><br><span>                 buf_reset(buf);</span><br><span>              =
   ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (!ret)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    mi =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span>  =
               clear_prefix();</span><br><span>             }</span><br><sp=
an>         }</span><br><span>         else</span><br><span>         {</spa=
n><br><span>             ret =3D multi_io_send_link(m, mi, mpp_flags);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!ret)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                mi =3D NULL;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an>         }</span><br><span>     }</span><br><span>     return ret;</span=
><br><span>@@ -475,11 +413,13 @@</span><br><span>             break;</span>=
<br><span> </span><br><span>         case TA_TUN_WRITE:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            multi_io_write_tun(m, mpp_fla=
gs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASS=
ERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 multi_io_write_tun(m, mi, mpp_flags);</span><br><span>             break;<=
/span><br><span> </span><br><span>         case TA_TUN_WRITE_TIMEOUT:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_io_drop_t=
un(m, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            multi_io_drop_tun(m, mi, mpp_flags);</span><br><span>        =
     break;</span><br><span> </span><br><span>         case TA_SOCKET_WRITE=
_READY:</span><br><span>@@ -627,10 +567,6 @@</span><br><span>              =
               multi_io_action(m, mi, NULL, TA_INITIAL, false);</span><br><=
span>                         }</span><br><span>                     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    else i=
f (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        multi_io_action(m, NULL, NULL, TA_SOC=
KET_WRITE, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 }</span><br><span>                     else if (e-&gt;rwfl=
ags &amp; EVENT_READ)</span><br><span>                     {</span><br><spa=
n>                         multi_io_action(m, NULL, ev_arg-&gt;u=2Esock, TA=
_SOCKET_READ, false);</span><br><span>@@ -651,11 +587,7 @@</span><br><span>=
                 /* incoming data on TUN? */</span><br><span>              =
   if (e-&gt;arg =3D=3D MULTI_IO_TUN)</span><br><span>                 {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (=
e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        multi_io_action(m, NULL, NULL, TA_TUN_WR=
ITE, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (e-&gt;rwflags &am=
p; EVENT_READ)</span><br><span>                     {</span><br><span>     =
                    multi_io_action(m, NULL, NULL, TA_TUN_READ, false);</sp=
an><br><span>                     }</span><br><span>@@ -749,17 +681,17 @@</=
span><br><span>                 mi =3D NULL;</span><br><span>             }=
</span><br><span>             multi_close_instance_on_signal(m, touched);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            touched =
=3D NULL;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * If dispatch produced any=
 pending output</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * for a particular instance, point to</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         * that instance=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * touched is the only instance this act=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * post-=
processed: having closed it above if</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * it was signalled, write its output if any=2E</s=
pan><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (touched &amp;&amp; ANY_OUT(&amp;touched-&gt;context=
))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            mi =3D m-&gt;pending;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            mi =3D touched;</span><br><span>         =
}</span><br><span> </span><br><span>         /*</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2048?usp=3Dema=
il">change 2048</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2048?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2048 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</body>=
</html>
--ahlhu9cDphg=--


--===============0706749374496243485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0706749374496243485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0706749374496243485==--

