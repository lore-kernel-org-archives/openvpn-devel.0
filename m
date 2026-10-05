Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54E1CA5FF5
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5tNFgVX4+mVVBXq97Nur4lRSzZodve59g8LJVGrPbhM=; b=SANp/96FtDk0GUBN1hosuYt9sM
	vJdvXExwXHRaIduLceEes6ZcDL+M+YtvztM61aG8gqo2EY8jbyr93IChKGsJLeFzbP1+WQCKK3JOt
	DhDz27HuLk35mSNVjyRnBiClaDW2VQGposldoy/HRoJ+5PYM9nFz0gv6ivSi5bCfilIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDi7B-0000bd-Vw;
	Mon, 05 Oct 2026 12:48:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDi73-0000bQ-Ld
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EuIQjUW32KEyC/dbIHFchKVXD2b4/gZsRY12UaD7knA=; b=JNCLBLpmNisaqsRzMWWCwAqzca
 28S7TGsKNB4/8Kokxb0/3APiSdC/hTkuE8Dg21xtu4HAclHy6yiKRUKduka9IaM9hOEg8H5CjKm/E
 CPkWfA4YXyAlgexIV/WwY3Io5fmFhY+FWub15izGB9gcv0ULPr9BJT4/KtmDoMstemKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EuIQjUW32KEyC/dbIHFchKVXD2b4/gZsRY12UaD7knA=; b=i
 EAMwagqn+tFZupeRbI+SHwncbwzMcOEnVZ86r0c5ItN835Toj83TPSYzUGp+l4tXAzigOrRCxa80V
 IZEGjjj41r3aIS4EtmRBW0NeUE7BJT8Jjv2wdReOzEjKwOtxxSc1CCNIZghT910AMGVSuZvjHL1JD
 1ZpTmb5HxJJQ+rSA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDi72-0007Mi-Pq for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 12:48:14 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a0280d4f56so10548105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791204486; x=1791809286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EuIQjUW32KEyC/dbIHFchKVXD2b4/gZsRY12UaD7knA=;
 b=DFW3uhvoIQMOPF/EaCohRWahbX2eH2Q5A5vJw78gP8ases9+P8aLubuNd2YcbGjDJX
 GcIzdQT/AB6jZdRyMpTBn/6Ou5cIalXHTHj12iZ7WvfcBRPmnq0FVGxjERyeS9+w+iOX
 kC9EKPw6n0xrZr26iZHo+b9Sv+Hf6xNt0CfEpFUBC1aeBUZTIIi7Qt84xwlprsWA5/aS
 GSKA9Kqy7iVlUjj0dq2MsQs8t+Th1NpD8DYRaOhfQ/4PuTcXid1ayrKyAR6sZqSGDScM
 IeJ+oSboF4REjT8rSgaIVGSb1vzJvadGbhHTA4TzwJp5vNdm3KVor2fLdu2Yn2TzwfFn
 9aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791204486; x=1791809286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EuIQjUW32KEyC/dbIHFchKVXD2b4/gZsRY12UaD7knA=;
 b=XUaI3cJgUU+O4hauZJ4rxDoAaZvMybTfoo5T1EYdniCI9OiIfh5vFrDUPOV/yy+poG
 Cug2OsKUQq563ff0tEfUuId102s4HmJgQQ6BlUDQFLbAehiygqCOQQtPkwpRe9fHiWeX
 jKV5/A8vTRAUJ8sVeFZZo3gqEcqY0umMAB7sX22S76kjJZj2VeC5VCjJ3y3UrnfT/eZK
 z2quVK24X1BfbQ0DsYHZhVyEzdSQc5+0ZzMNh1wQ+tOQNYkaz1mtmxK2htsq/Pew7Frg
 wLgsvog++BdY824/NGebnvzTVE2gTLyzO9N/N7CYFbfR6e4b7+69gj5J9xtmRy2wVjfO
 R9sQ==
X-Gm-Message-State: AFuF++mXXojzB2ooq8c51DuyGer5Dm5BMk3Lm1PghjTo6eq/TvNRKvnm
 fjB5LHl1irD8I1BwZgiBRlknDBG2bWio7wFZUI9JUOtz2H8EoptxXkmeEQ+8W97To4KsPI2a1Ih
 OFqyc+9VrNhve/RKwneTMzLTlbSPvcxGj+KodJ+i5o8DDg4Z3Xomt+kUo9LvFI952P3de
X-Gm-Gg: AYBFou3YJ3PA5frMf379EBbY7R/2ndJYj12xKTCySuGqO7V0bxO/FFD7LjcW5m+b4rB
 28nXOen81al+agaptIO6EmHwFCccL8Xeilte4IhLWAlSM0z2/ztzF3G5M6Hzt1GtXKQZDfjRbqB
 cnDwmk6DV7EL5LHBoBcHwoGsbxnweGKAU3FOZBujmhnrDCFgtbGTzmMiTD+GbLo+umEwPnolFJi
 1gv3Coh9k4ADIiOmsWj81bhjUQMiYgfpkPLleMcifwOebcM9RMJV8Jv6LpHNGv1PhwDoRI58MeC
 9f2vuqOJexfMybje71DIJAU+Y7eRir2K8Hp4LJYw8E0CWLpnhbrELtSoSBin3pEToLicJTSUhg9
 mXPge5YOU2sJC058TRHGCOuVl/h9lIGnRDVZLFOs9kZZpJ1r8OyaCP7nsDbiCeWk4BqUUVh4x9/
 EB2/wnjL3PPsrwj5KZ7XK6o4XVSGvn3IoE341rUkKEPXrDPJhCwUMfoNcYmIAsDJiDk608mjbVW
 XbQYV3uiyOAMveeauNLKvWKsjlnkcvfeDdtnylYZKbxxuKurFEtyWupg2Q0h6BVw9K5+JsmRDX5
 Jxv1VZJqcpsv+yRpfjE4Qou97flqECG6V+aXob67+WF4aK4d/hghxzECu1Fwmw==
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a02758653cmr169056395e9.16.1791204486005; 
 Mon, 05 Oct 2026 05:48:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm325738295e9.1.2026.10.05.05.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:48:05 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 12:48:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: ee5a484f5ed3ead1661e14d2f0b009139fd3d6a7
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10d7465da6afe9079d22ead9da032e82ce7a1e1d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDi72-0007Mi-Pq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5104225429177539209=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5104225429177539209==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0fS29wEvk1Q="; charset=UTF-8

--0fS29wEvk1Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru, plaisthos=2E

H=
ello R=C4=83zvan Cojocaru, plaisthos, 

I'd like you to reexamine a change=
=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=
=3Demail

to look at the new patch set (#2)=2E

The following approvals got=
 outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Change =
subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multi_io: drop IOW_MBUF

Before the UDP and TCP server =
loops were merged, each drained the
bcast/mcast/client-to-client queue its =
own way: UDP armed EVENT_WRITE
through IOW_MBUF, TCP used the flush loop at=
 the end of
multi_io_process_io()=2E  The merge kept both, leaving two cons=
umers with
different disciplines=2E

The queue mixes instances of both prot=
ocols and neither consumer gets to
pick: mbuf_peek() and multi_get_queue() =
hand back whatever sits at the
head=2E  The TCP side is prepared for that, =
testing proto_is_dgram() and
tcp_link_out_deferred before writing=2E  The U=
DP side is not: it writes
straight to the instance's own socket, so a TCP i=
nstance reaching it
skips the deferred queue that carries backpressure=2E

=
Drain the queue from the flush loop alone and drop the UDP consumer=2E
IOW_=
MBUF only existed to arm the socket for it, so it goes as well=2E

This lea=
ves the queue drained from one event-driven point: the timeout
branch of tu=
nnel_server_loop() does not reach the flush loop, so what
multi_io_action(T=
A_TIMEOUT) manages to queue there waits for the next
pass that has events=
=2E  Acting on the queue only when there is an event
to act on is the simpl=
er rule, and the delay is bounded by the next
event=2E

Change-Id: I165c632=
da6a837d0cca55bee4c2cc390b91d1e54
Signed-off-by: Gianmarco De Gregori <gian=
marco@mandelbit=2Ecom>
---
M src/openvpn/forward=2Ec
M src/openvpn/forward=
=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi_io=2Ec
4 files changed, 3 i=
nsertions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/62/1962/2

diff --git a/src/openvpn/forward=2Ec b/s=
rc/openvpn/forward=2Ec
index 1604224=2E=2Eb97fb7a 100644
--- a/src/openvpn/=
forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -2122,14 +2122,6 @@
     }
 
 =
    /*
-     * outgoing bcast buffer waiting to be sent?
-     */
-    if (=
flags & IOW_MBUF)
-    {
-        socket |=3D EVENT_WRITE;
-    }
-
-    /*=

      * Force wait on TUN input, even if also waiting on TCP/UDP output
  =
    */
     if (flags & IOW_READ_TUN_FORCE)
diff --git a/src/openvpn/forwar=
d=2Eh b/src/openvpn/forward=2Eh
index 324c0b4=2E=2E0309725 100644
--- a/src=
/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -58,7 +58,6 @@
 #defi=
ne IOW_SHAPER         (1 << 4)
 #define IOW_CHECK_RESIDUAL (1 << 5)
 #defin=
e IOW_FRAG           (1 << 6)
-#define IOW_MBUF           (1 << 7)
 #define=
 IOW_READ_TUN_FORCE (1 << 8)
 #define IOW_WAIT_SIGNAL    (1 << 9)
 
diff --=
git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 2b08ada=2E=2E94e03d=
6 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -451,10 +=
451,9 @@
 static inline void
 multi_process_outgoing_link(struct multi_cont=
ext *m, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi =3D=
 multi_process_outgoing_link_pre(m);
-    if (mi)
+    if (m->pending)
    =
 {
-        multi_process_outgoing_link_dowork(m, mi, mpp_flags);
+        =
multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
     }
 }
 
d=
iff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 51c7d=
31=2E=2E348e424 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/mul=
ti_io=2Ec
@@ -177,10 +177,6 @@
             flags |=3D IOW_TO_LINK;
       =
  }
     }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D =
IOW_MBUF;
-    }
     else
     {
         flags |=3D IOW_READ;
@@ -565,7 +=
561,7 @@
     multi_io->n_esr =3D 0;
 
     /*
-     * Process queued mbuf =
packets destined for TCP socket
+     * Drain the queued mbuf packets, data=
gram and TCP instances alike
      */
     {
         struct multi_instance=
 *mi;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I165c632d=
a6a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-PatchSet=
: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--0fS29wEvk1Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru, plaisthos=2E </p>
<p>Gianmarco =
De Gregori <strong>uploaded patch set #2</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail">View=
 Change</a></p><p>The following approvals got outdated and were removed:
Co=
de-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">multi_io: drop IOW_MBU=
F<br><br>Before the UDP and TCP server loops were merged, each drained the<=
br>bcast/mcast/client-to-client queue its own way: UDP armed EVENT_WRITE<br=
>through IOW_MBUF, TCP used the flush loop at the end of<br>multi_io_proces=
s_io()=2E  The merge kept both, leaving two consumers with<br>different dis=
ciplines=2E<br><br>The queue mixes instances of both protocols and neither =
consumer gets to<br>pick: mbuf_peek() and multi_get_queue() hand back whate=
ver sits at the<br>head=2E  The TCP side is prepared for that, testing prot=
o_is_dgram() and<br>tcp_link_out_deferred before writing=2E  The UDP side i=
s not: it writes<br>straight to the instance&#39;s own socket, so a TCP ins=
tance reaching it<br>skips the deferred queue that carries backpressure=2E<=
br><br>Drain the queue from the flush loop alone and drop the UDP consumer=
=2E<br>IOW_MBUF only existed to arm the socket for it, so it goes as well=
=2E<br><br>This leaves the queue drained from one event-driven point: the t=
imeout<br>branch of tunnel_server_loop() does not reach the flush loop, so =
what<br>multi_io_action(TA_TIMEOUT) manages to queue there waits for the ne=
xt<br>pass that has events=2E  Acting on the queue only when there is an ev=
ent<br>to act on is the simpler rule, and the delay is bounded by the next<=
br>event=2E<br><br>Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54<br>=
Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>--=
-<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvp=
n/mudp=2Ec<br>M src/openvpn/multi_io=2Ec<br>4 files changed, 3 insertions(+=
), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/62/1962/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 1604224=2E=
=2Eb97fb7a 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><=
span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2122,14 +2122,6 @@</=
span><br><span>     }</span><br><span> </span><br><span>     /*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * outgoing bcast buffer wait=
ing to be sent?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; =
IOW_MBUF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        socket |=3D EVENT_WR=
ITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /*</span><br><span>      * Force wait on TUN input=
, even if also waiting on TCP/UDP output</span><br><span>      */</span><br=
><span>     if (flags &amp; IOW_READ_TUN_FORCE)</span><br><span>diff --git =
a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 3=
24c0b4=2E=2E0309725 100644</span><br><span>--- a/src/openvpn/forward=2Eh</s=
pan><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -58,7 +58,6 =
@@</span><br><span> #define IOW_SHAPER         (1 &lt;&lt; 4)</span><br><sp=
an> #define IOW_CHECK_RESIDUAL (1 &lt;&lt; 5)</span><br><span> #define IOW_=
FRAG           (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define IOW_MBUF           (1 &lt;&lt; 7)</span><br><span> #define =
IOW_READ_TUN_FORCE (1 &lt;&lt; 8)</span><br><span> #define IOW_WAIT_SIGNAL =
   (1 &lt;&lt; 9)</span><br><span> </span><br><span>diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 2b08ada=2E=2E94e03d=
6 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/s=
rc/openvpn/mudp=2Ec</span><br><span>@@ -451,10 +451,9 @@</span><br><span> s=
tatic inline void</span><br><span> multi_process_outgoing_link(struct multi=
_context *m, const unsigned int mpp_flags)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi =3D m=
ulti_process_outgoing_link_pre(m);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (m-&gt;pending)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        multi_process_outgoing_link_dowork(m, =
mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    multi_process_outgoing_link_dowork(m, m-&gt;pending, mpp_flags);</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span=
>index 51c7d31=2E=2E348e424 100644</span><br><span>--- a/src/openvpn/multi_=
io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -1=
77,10 +177,6 @@</span><br><span>             flags |=3D IOW_TO_LINK;</span>=
<br><span>         }</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</span><br><=
span>     {</span><br><span>         flags |=3D IOW_READ;</span><br><span>@=
@ -565,7 +561,7 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</span><br=
><span> </span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * Process queued mbuf packets destined for TCP socket</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Drain the queued m=
buf packets, datagram and TCP instances alike</span><br><span>      */</spa=
n><br><span>     {</span><br><span>         struct multi_instance *mi;</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b9=
1d1e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1962 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--0fS29wEvk1Q=--


--===============5104225429177539209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5104225429177539209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5104225429177539209==--

