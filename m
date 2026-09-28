Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D29CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AvVSHY2B2zmT6rmudZGvSDZ3O16lw71/xTSPR3Y4dOc=; b=f1GdNHSM7uN/HP
	RTaed4aG9YcVYsKT/HseotWiAY2A1q7JrCxD0N6ys7+yiV05ODqbyK5dOv8Edsm3A62ApF9MV+vcj
	K88kedULAH0ktfCR8Gjo1amUAcyhHLyJkypd16rgO5/BT/iJ5HPr7tZ7jpOelWDo63UZ7xx/p6pBt
	LHA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDxz-000778-QC;
	Mon, 28 Sep 2026 16:12:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDxv-00076z-OC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S/nkxXMMnRr26q7n8+7imw2jDgdi0wlkVwTsykytj5g=; b=mru7zKOiypdKU+GS5Q+A1SUyul
 eQqSBDZF58wsYRk6uMSbEnRMgpGJgtqDiV76Ov0cHB3/tFnL5jJi0Q+CGvnsX71grs8k31tv5WxH5
 iuYE4q88EI5IEobNCR3v1ohkxWB76Pkoi3FMh4sZ3RQ6B+J1zcWknjh61LEPUNaxcvxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S/nkxXMMnRr26q7n8+7imw2jDgdi0wlkVwTsykytj5g=; b=g
 lMkIVL2DPqHeLTTRlUlXp3JQ/DsnQetOq5dnHAD4mX82J8FcH8Jb0GtKNAJ0DV7tlPaI9wdmk4cb4
 Gft2OKfpTjPYFt7kA2AbjINqtlViwyPbcXe1CO9h7s5VWQIqL6beeDBHJSQC8vedJT610WaDEv9qW
 mps0/rQScieRkpO4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDxq-0000q6-Lz for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 16:12:29 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso23984785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790611940; x=1791216740; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S/nkxXMMnRr26q7n8+7imw2jDgdi0wlkVwTsykytj5g=;
 b=cMZJXMCxpbRP5YjbzsKo9CW6XJ9ycHUTQyedqmOuK9uMDRd3Xf7O73vjOLbhKZL023
 kOqqu7xUd+az5mkADC23QrroXvfJM1FDfNhxVQQS5L7nKBjaTtAWqNVuKuaUZbCcKcXX
 3QFJclOWyiigGHH1sqVPMfRmbiBSHvv5i14bOt7shCEbs4nhazRTrv07BItNE7HIEPMg
 g85YAume3Cpda53tdihTFjqLQUjoJLDNQTHeAxQsIbON458eJdIJBxUrohQTJiuBLiSS
 BOOwU7ya7bzUzA1MKFnO/mxRmi/rXFiSaym7mneVKtari82deq5Wc6bjB3z/X3tzEdyv
 dL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611940; x=1791216740;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S/nkxXMMnRr26q7n8+7imw2jDgdi0wlkVwTsykytj5g=;
 b=xSWv6dNBt1Ok0fnn/wi6GUshoCyVn0w3TwdCBtJz8hoqwl5YEVzg/MyDBVYl/1vy3n
 XkdnhWXbRALhv5278MBThFC+TMZ96Zl0Nr4q1G3FIrsxxszPTe6hv+Gpj3xlUqlROp1f
 tsJRHxzLbsgn8Rii8ud7x3+BFxoF+X3av6NmzBMRpmKv47ktf3uLPrNN3IDknOxImEdj
 TrkLJo5mPZdEdNylBm8XJ0AY9GbLVAUc48WtKrrjxUWwocKc1nZy6XOKDhToHNEzGWXH
 OKSKIqsTzKekv7STTLRaqe4eQjQgOw40zkJE/Vavg5TwJFYVisu8wY2Xy2DKFwyHrvuy
 MN1g==
X-Gm-Message-State: AFuF++mEP1JaBf788cyQS3OmqM3zncD/HHi+twLGE/BN8maG22ssBnyE
 t819eyTl2TcNNZPOH2AVCg9I6Z800juBXXU6PnOC8TgFs629qfIH8qxREmhS5zjAO0/JI3dfBy7
 THO++l2JAQPdqy/rsvuCnsdq8g7UNYFAAdqG5UraiF4or3ST3pGHfnKezLpXqbfPzLCpXQe+hk5
 /IvsF88A==
X-Gm-Gg: AYBFou1MCUM8zIiLSxMBMltys2a3sAxqyZ/RNH0rW5UyQbJxrD2DfUETw7jxPh07HAS
 poLILjysIorfSIg+FTNLCHlUeYceE4d5DQbyWQ1RpJQps9wA6WI6SekIy52uN/3/HZunSZBx8rB
 tBXuiGi83M+vwhB6s3MZJ6pSssFtlM0wqdph3ah/mhOnLDNgxQC/WqxhbtrqJCcSlWzMfkHI7G9
 JjLTW5CggnCqh4/ssiSFohcFvItdW+O+3U7OTCrn3n4LpaENvwADdjWmdixZ37CrFry14uBP7EY
 CPVQGJfA44KVG+ezgprN1epWPVGgA2VFg4OCz8CbaoxXa0886J5UvlMgYHIUCh1spAntF8GKCG+
 fnUCbh3nl03vtIyRnFcRTlIlz/NyxERhOqcDpmJ4Kw943TIWUlGqIbSGDJdx7TBIRV+MAWEPbgC
 f/EaapVz85r1HKPLAPAX2K61cCbLdXWX0YHkPMbafdKAVvT2a6Fedpdibr5bdvaCUy0OhyY+kwm
 GFb5QJbZ4PzEVGD2q54NR9kab/nTCkD6WWN6t7xede/paUCG8LBGtp7iMmbmiYiwXDJBb8Ghgl9
 uJoJArS3+k1CGRzeHY6oxWbMKQqSIKiLxZf19H7xjO5J1GtVf6BnUVV8Nk7Y
X-Received: by 2002:a05:600c:4e08:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49fe66c9f6fmr246026325e9.4.1790611940000; 
 Mon, 28 Sep 2026 09:12:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9dfdbsm4265755e9.1.2026.09.28.09.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 09:12:19 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 16:12:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: 40a2f1f4b5d59defe28d8e9b091f4580c4e3114a
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <23072cbada10205cc57072936a6834ca77f25690-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDxq-0000q6-Lz
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0013016421614511768=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0013016421614511768==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCx/kXXovoY="; charset=UTF-8

--uCx/kXXovoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1962?usp=3Demail

to review the following change=2E


Chang=
e subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

multi_io: drop IOW_MBUF

Before the UDP and TCP serv=
er loops were merged, each drained the
bcast/mcast/client-to-client queue i=
ts own way: UDP armed EVENT_WRITE
through IOW_MBUF, TCP used the flush loop=
 at the end of
multi_io_process_io()=2E  The merge kept both, leaving two c=
onsumers with
different disciplines=2E

Neither checks the protocol of the =
instance it picks up, but only the
TCP side copes: it tests proto_is_dgram(=
) and tcp_link_out_deferred
before writing=2E  The UDP one takes whatever h=
eads the queue, TCP
instances included, and writes straight to that instanc=
e's socket,
bypassing the deferred queue TCP needs for backpressure=2E

Dra=
in the queue from the flush loop alone and drop the UDP consumer=2E
IOW_MBU=
F only existed to arm the socket for it, so it goes as well=2E

Change-Id: =
I165c632da6a837d0cca55bee4c2cc390b91d1e54
Signed-off-by: Gianmarco De Grego=
ri <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/forward=2Ec
M src/openvpn/=
forward=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi_io=2Ec
4 files chang=
ed, 3 insertions(+), 17 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/62/1962/1

diff --git a/src/openvpn/forwa=
rd=2Ec b/src/openvpn/forward=2Ec
index a8a4a07=2E=2E3907845 100644
--- a/sr=
c/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -2105,14 +2105,6 @@
=
     }
 
     /*
-     * outgoing bcast buffer waiting to be sent?
-     */=

-    if (flags & IOW_MBUF)
-    {
-        socket |=3D EVENT_WRITE;
-    }=

-
-    /*
      * Force wait on TUN input, even if also waiting on TCP/UDP=
 output
      */
     if (flags & IOW_READ_TUN_FORCE)
diff --git a/src/open=
vpn/forward=2Eh b/src/openvpn/forward=2Eh
index 324c0b4=2E=2E0309725 100644=

--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -58,7 +58,6=
 @@
 #define IOW_SHAPER         (1 << 4)
 #define IOW_CHECK_RESIDUAL (1 << =
5)
 #define IOW_FRAG           (1 << 6)
-#define IOW_MBUF           (1 << 7=
)
 #define IOW_READ_TUN_FORCE (1 << 8)
 #define IOW_WAIT_SIGNAL    (1 << 9)=

 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 4794b7e=
=2E=2Ee840a2d 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -452,10 +452,9 @@
 static inline void
 multi_process_outgoing_link(struc=
t multi_context *m, const unsigned int mpp_flags)
 {
-    struct multi_inst=
ance *mi =3D multi_process_outgoing_link_pre(m);
-    if (mi)
+    if (m->p=
ending)
     {
-        multi_process_outgoing_link_dowork(m, mi, mpp_flags=
);
+        multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
 =
    }
 }
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec=

index bce5018=2E=2E595afe2 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src=
/openvpn/multi_io=2Ec
@@ -177,10 +177,6 @@
             flags |=3D IOW_TO_L=
INK;
         }
     }
-    else if (mbuf_defined(m->mbuf))
-    {
-       =
 flags |=3D IOW_MBUF;
-    }
     else
     {
         flags |=3D IOW_READ;=

@@ -565,7 +561,7 @@
     multi_io->n_esr =3D 0;
 
     /*
-     * Process =
queued mbuf packets destined for TCP socket
+     * Drain the queued mbuf p=
ackets, datagram and TCP instances alike
      */
     {
         struct mu=
lti_instance *mi;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1962?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
165c632da6a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-=
PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--uCx/kXXovoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>its_Giaan would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1962?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">multi_io: drop IOW_MBUF<br><br>Before the UDP and TCP server loops were=
 merged, each drained the<br>bcast/mcast/client-to-client queue its own way=
: UDP armed EVENT_WRITE<br>through IOW_MBUF, TCP used the flush loop at the=
 end of<br>multi_io_process_io()=2E  The merge kept both, leaving two consu=
mers with<br>different disciplines=2E<br><br>Neither checks the protocol of=
 the instance it picks up, but only the<br>TCP side copes: it tests proto_i=
s_dgram() and tcp_link_out_deferred<br>before writing=2E  The UDP one takes=
 whatever heads the queue, TCP<br>instances included, and writes straight t=
o that instance&#39;s socket,<br>bypassing the deferred queue TCP needs for=
 backpressure=2E<br><br>Drain the queue from the flush loop alone and drop =
the UDP consumer=2E<br>IOW_MBUF only existed to arm the socket for it, so i=
t goes as well=2E<br><br>Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e=
54<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;=
<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/=
openvpn/mudp=2Ec<br>M src/openvpn/multi_io=2Ec<br>4 files changed, 3 insert=
ions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/1962/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index a8a=
4a07=2E=2E3907845 100644</span><br><span>--- a/src/openvpn/forward=2Ec</spa=
n><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2105,14 +2105=
,6 @@</span><br><span>     }</span><br><span> </span><br><span>     /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * outgoing bcast buff=
er waiting to be sent?</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags=
 &amp; IOW_MBUF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket |=3D E=
VENT_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /*</span><br><span>      * Force wait on TU=
N input, even if also waiting on TCP/UDP output</span><br><span>      */</s=
pan><br><span>     if (flags &amp; IOW_READ_TUN_FORCE)</span><br><span>diff=
 --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>=
index 324c0b4=2E=2E0309725 100644</span><br><span>--- a/src/openvpn/forward=
=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -58,7=
 +58,6 @@</span><br><span> #define IOW_SHAPER         (1 &lt;&lt; 4)</span>=
<br><span> #define IOW_CHECK_RESIDUAL (1 &lt;&lt; 5)</span><br><span> #defi=
ne IOW_FRAG           (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define IOW_MBUF           (1 &lt;&lt; 7)</span><br><span> #=
define IOW_READ_TUN_FORCE (1 &lt;&lt; 8)</span><br><span> #define IOW_WAIT_=
SIGNAL    (1 &lt;&lt; 9)</span><br><span> </span><br><span>diff --git a/src=
/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 4794b7e=2E=
=2Ee840a2d 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -452,10 +452,9 @@</span><br=
><span> static inline void</span><br><span> multi_process_outgoing_link(str=
uct multi_context *m, const unsigned int mpp_flags)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance =
*mi =3D multi_process_outgoing_link_pre(m);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (m-&gt;pending)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        multi_process_outgoing_link_d=
owork(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_process_outgoing_link_dowork(m, m-&gt;pending, mpp_flags=
);</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span>=
<br><span>index bce5018=2E=2E595afe2 100644</span><br><span>--- a/src/openv=
pn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><s=
pan>@@ -177,10 +177,6 @@</span><br><span>             flags |=3D IOW_TO_LIN=
K;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</sp=
an><br><span>     {</span><br><span>         flags |=3D IOW_READ;</span><br=
><span>@@ -565,7 +561,7 @@</span><br><span>     multi_io-&gt;n_esr =3D 0;</=
span><br><span> </span><br><span>     /*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * Process queued mbuf packets destined for TCP sock=
et</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Drain the =
queued mbuf packets, datagram and TCP instances alike</span><br><span>     =
 */</span><br><span>     {</span><br><span>         struct multi_instance *=
mi;</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390=
b91d1e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1962 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--uCx/kXXovoY=--


--===============0013016421614511768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0013016421614511768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0013016421614511768==--

