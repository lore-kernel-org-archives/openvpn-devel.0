Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EF606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LPYd/3z3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AvEVDZSb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iCFg0dR/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=a9c2v806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=aZuVEWwPjc48rt0BWI6Dp/1cB4phDj3fhewVCLyMMFw=; b=LPYd/3z3RtIVxLvx8maM02tW4V
	EEhmxSRn8fTR4foq2Hhtcw681WyD3I4E6F9njoj3o/GCBr7Eo6Qgbg203j4/b4stXK+qgtGBdQmad
	1FN7eggoszwKHUO44qxere4Qtmjhjpn3/OXqzRx+/gBmrzwDz/V9OWNiMaQJ6ckuy+SE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLdlx-000000006Zd-3TCe;
	Tue, 27 Oct 2026 09:47:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLdlw-000000006ZT-3OPN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4bGCvMknN3/JWif0BE+zAHb3XOCSuxF2FlcFpHZFpw=; b=AvEVDZSbDHcuo4yRGm1u80F8LW
 1cf090gWcb4TF8xB/Ri636uAJImN512R4xxUJh9gGvODMQMqOF/hVqL0FvRYkN02zmt70aAtPZZJs
 w3DXtQuG6VYG/RD4uR9WBOEdh7Bg2rrbfspDlU1lRD5i/oC0Bg+IKG2kxE1TltKk+wtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4bGCvMknN3/JWif0BE+zAHb3XOCSuxF2FlcFpHZFpw=; b=iCFg0dR/CuXVMswMQ0tql+61GX
 0ndNhiVxEo1XSMDtyV2aHNj8RmApj3HX/4TjyWBUDyBI9TqbmpS5b+bTdX9FMvQoMXGQUSGxMpPhn
 q4hIJFrjr/baJAHHfBMrZVLKwAKpOsF7lvL+hxjD1r/07RUFCY15FGjblQE17fyHiKrk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLdlv-000000001EX-0jm9 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:47:12 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so28810385e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793094425; x=1793699225; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h4bGCvMknN3/JWif0BE+zAHb3XOCSuxF2FlcFpHZFpw=;
 b=a9c2v806HDtEaqc92AAh01LdqnWMlpn1D4DNuEGp9ae/obdxV/QNjpZfSMnFbZqOJm
 gmDFrmZkrUSFcStg65SWPUWKOM3KMphFARJzhc3qCUvAyODdLnfv96s0hyAdf8+0jNLP
 wB+Zi18QzvRQ7bGHjlg1IXx1c03HiVmktyARVl9ZdUeO8NCSl7c+/GpO+PXIstVXj8eG
 Q0Lk2SlExVbA52oV5UmTjZIDPH8unaWMS9aJMHe+M7FJ6J5hXJ4g5CidoPXAbnBo/2rf
 s+oxIH14IEYPKgrPFv65wthrDEV4bc4b232QvksqI6S7nToCEUdzomRBpWMkrPJWGTW5
 ohXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793094425; x=1793699225;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h4bGCvMknN3/JWif0BE+zAHb3XOCSuxF2FlcFpHZFpw=;
 b=afEQ0mUkgCcFQFe9IbrE3fxw9MnYzFGSH+QNgh8FfXB163Aq+AO0veFh0zLf5TsFc7
 qdsMO1TdUjfk6tJb2z7ap3rbzlMQvSuZAwp6pGDSyVpbg5QLXSz7gWHCX3rMyPh4XXWu
 4W1LaOc3onoScgGSkbvwsbblVFGMR8socecRD1jXWwKqjnKaBWgBhcWoxk2Lxm3Rr+vC
 fFk8RneqOftTOVpEwXK1LnKLt0w00mto0+9CjNRVaPqmOvLevTpJAHraR7RSC0PIh6Ww
 Wktqj6bEIEBKbRDhXm1nmHPbkrDs4MAj1XDwie00nTYXbp9JHzivY8K44rHhzWGruYWp
 8qDg==
X-Gm-Message-State: AFq9FYKx71hxiI0yThCM5U4THB64myHGZn6svI3lUFWvF5S/Pl4ofarl
 bZm8eSG7G5vxsgHl8UsmA4zCcYvZrPjkFUWHWrCq66UtLXiB9ZJmAitQZsILOpnblh+fqXnMJXP
 eCEGwD4vMfftnqbthax4UF6gdxPFXypclgkixHVDzQOI2z9Ry9gPb5NyiQxvOHjeP3c90oPoA0e
 obq67clA==
X-Gm-Gg: AYBFou2sK7ZugkzR/TvBZyroLGPoHwPIpz5Hk6Ak4MR4RHQqojTIPB093NXWeEQVjcn
 5Fn08UC8Vg/6en4/3PowNijEjgExNF/3yQzKtgSjbLY5lKCL78okIaJDP8y6zT7OqQHrTbyZWmw
 qieF5tU6fhpaFNFL/blGww5FRae43LNuuN57M7nvzjCcmQpy6wUNU1xD131w+kUgrihgw2bu9Cx
 Nr6n2fgf56e4t1xKDr5Z23b2BeLiMr3LVJKumk29wG8nJvR/85tW5hYlcCHSsQEjyu6j1Vfb/tT
 KKoi9fHFjV0JLm4CPMq6aZKQzB3OB4jd+vhUH4Zd48UckJDKdhV/jDufBIFYkpFKI4wPxAm+QX5
 mgor5Coz4GFtS+VH83AYk3rk3WbEADqyfrcGwnkoDGgHsXheICnfuvkU4SV77LdJwtamVfGeYT0
 /HpLu3+nlGY8GmHdL/jAjvFLfb+q49gwyPPz2zTDgohJevmzsEI4PXOAfdC9MEFTmJ4o+Fe6RqM
 pamLxodcFY9yfpjYuSdYl4IG0KXUO5NYdOhVEP1su9GoEN/w8TvMF+7Nrzt1WNY9oTACliKkpZK
 kUhSsHzHmU6+HnHXpJ4kPtubLT065vU1tcz0HebRWdikn5L9K5FoCxQlNBco0nRMBcgMtJRTUks
 4ZTWrm5KOiu7j8oGsbZtMUOR1zioHKvbX2O3hKnHUfA==
X-Received: by 2002:a05:600c:4e87:b0:4a1:a2c0:7b73 with SMTP id
 5b1f17b1804b1-4a35acaa6c3mr179741255e9.30.1793094424536; 
 Tue, 27 Oct 2026 02:47:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm265215345e9.11.2026.10.27.02.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:47:04 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 09:47:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
X-Gerrit-Change-Number: 2047
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2047?usp=email>
X-Gerrit-Commit: 740862ff438dcf2898ec976f567ab2a55c74faad
References: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0OTc3NzkwMjk1MWQzYTA1YzQ4Y2RkZDBkMzNjMTRlMDI4ZTVkNzA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3f5ab87dae3d1ae586f71826aa9950d9ce93507-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdlv-000000001EX-0jm9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: resume
 deferred auth through multi_io_action()
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
Content-Type: multipart/mixed; boundary="===============6416695017522755579=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6416695017522755579==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qC6lncyaKCk="; charset=UTF-8

--qC6lncyaKCk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2047?usp=3Demail

to review the following change=2E
=


Change subject: multi: resume deferred auth through multi_io_action()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: resume de=
ferred auth through multi_io_action()

multi_process_file_closed() is the l=
ast place where multi_process_post()
runs without a multi_io_action() follo=
wing it, so any output it produces
stays in m->pending across event_wait()=
=2E

Add TA_INSTANCE_POST, which only runs multi_process_post() on the give=
n
instance, and use it so pending output is flushed as for every other
even=
t=2E Likewise, an instance signalled during this post-processing is
now clo=
sed right away instead of on its next event=2E This is needed
before m->pen=
ding can be removed=2E

Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d70=
6
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src=
/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src=
/openvpn/multi_io=2Eh
4 files changed, 13 insertions(+), 5 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/2047/=
1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index cf6a584=
=2E=2E2841a81 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -2829,7 +2829,7 @@
  * (or be deferred again by client-connect)
  */
 =
void
-multi_process_file_closed(struct multi_context *m, const unsigned int=
 mpp_flags)
+multi_process_file_closed(struct multi_context *m)
 {
     cha=
r buffer[INOTIFY_EVENT_BUFFER_SIZE];
     ssize_t buffer_i =3D 0;
@@ -2857,=
7 +2857,7 @@
             if (mi)
             {
                 /* contin=
ue authentication, perform NCP negotiation and send push_reply */
-        =
        multi_process_post(m, mi, mpp_flags);
+                multi_io_act=
ion(m, mi, NULL, TA_INSTANCE_POST, false);
             }
             else=

             {
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
=
index 5aed191=2E=2E31635ba 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/ope=
nvpn/multi=2Eh
@@ -380,9 +380,8 @@
  * Continues authentication and sends p=
ush_repl
  *
  * @param m multi_context
- * @param mpp_flags
  */
-void mul=
ti_process_file_closed(struct multi_context *m, const unsigned int mpp_flag=
s);
+void multi_process_file_closed(struct multi_context *m);
 
 #endif
 
d=
iff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index d1b7b=
f4=2E=2E24a6918 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/mul=
ti_io=2Ec
@@ -85,6 +85,9 @@
         case TA_TUN_WRITE_TIMEOUT:
           =
  return "TA_TUN_WRITE_TIMEOUT";
 
+        case TA_INSTANCE_POST:
+       =
     return "TA_INSTANCE_POST";
+
         default:
             return "?"=
;
     }
@@ -500,6 +503,11 @@
             multi_process_post(m, mi, mpp_fl=
ags);
             break;
 
+        case TA_INSTANCE_POST:
+            AS=
SERT(mi);
+            multi_process_post(m, mi, mpp_flags);
+            b=
reak;
+
         default:
             msg(M_FATAL, "MULTI IO: multi_io_dis=
patch, unhandled action=3D%d", action);
     }
@@ -670,7 +678,7 @@
 #ifdef =
ENABLE_ASYNC_PUSH
                 else if (e->arg =3D=3D MULTI_IO_FILE_CLO=
SE_WRITE)
                 {
-                    multi_process_file_closed=
(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
+                    multi_process_=
file_closed(m);
                 }
 #endif
         }
diff --git a/src/open=
vpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 7ae25c6=2E=2E591225c 1006=
44
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -44,6 +=
44,7 @@
 #define TA_INITIAL               8
 #define TA_TIMEOUT            =
   9
 #define TA_TUN_WRITE_TIMEOUT     10
+#define TA_INSTANCE_POST        =
 11
 
 /*
  * I/O state and events tracker

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
Gerrit-=
Change-Number: 2047
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--qC6lncyaKCk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi: resume deferred auth through multi_io_action()<b=
r><br>multi_process_file_closed() is the last place where multi_process_pos=
t()<br>runs without a multi_io_action() following it, so any output it prod=
uces<br>stays in m-&gt;pending across event_wait()=2E<br><br>Add TA_INSTANC=
E_POST, which only runs multi_process_post() on the given<br>instance, and =
use it so pending output is flushed as for every other<br>event=2E Likewise=
, an instance signalled during this post-processing is<br>now closed right =
away instead of on its next event=2E This is needed<br>before m-&gt;pending=
 can be removed=2E<br><br>Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d=
706<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt=
;<br>---<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/ope=
nvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>4 files changed, 13 inse=
rtions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/2047/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index cf6a584=
=2E=2E2841a81 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -2829,7 +2829,7 @@</sp=
an><br><span>  * (or be deferred again by client-connect)</span><br><span> =
 */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_process_file_closed(struct multi_context *m, const unsigned int m=
pp_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proc=
ess_file_closed(struct multi_context *m)</span><br><span> {</span><br><span=
>     char buffer[INOTIFY_EVENT_BUFFER_SIZE];</span><br><span>     ssize_t =
buffer_i =3D 0;</span><br><span>@@ -2857,7 +2857,7 @@</span><br><span>     =
        if (mi)</span><br><span>             {</span><br><span>            =
     /* continue authentication, perform NCP negotiation and send push_repl=
y */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
ulti_process_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                multi_io_action(m, mi, NULL, TA_INSTANCE_P=
OST, false);</span><br><span>             }</span><br><span>             el=
se</span><br><span>             {</span><br><span>diff --git a/src/openvpn/=
multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5aed191=2E=2E31635b=
a 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/=
src/openvpn/multi=2Eh</span><br><span>@@ -380,9 +380,8 @@</span><br><span> =
 * Continues authentication and sends push_repl</span><br><span>  *</span><=
br><span>  * @param m multi_context</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param mpp_flags</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void multi_process_file_closed(struct mult=
i_context *m, const unsigned int mpp_flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void multi_process_file_closed(struct multi_contex=
t *m);</span><br><span> </span><br><span> #endif</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</s=
pan><br><span>index d1b7bf4=2E=2E24a6918 100644</span><br><span>--- a/src/o=
penvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><b=
r><span>@@ -85,6 +85,9 @@</span><br><span>         case TA_TUN_WRITE_TIMEOU=
T:</span><br><span>             return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case TA_INSTANCE_POST:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return &quot;TA_INSTANCE_POST&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         default:</spa=
n><br><span>             return &quot;?&quot;;</span><br><span>     }</span=
><br><span>@@ -500,6 +503,11 @@</span><br><span>             multi_process_=
post(m, mi, mpp_flags);</span><br><span>             break;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_I=
NSTANCE_POST:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>         default:</span><br><sp=
an>             msg(M_FATAL, &quot;MULTI IO: multi_io_dispatch, unhandled a=
ction=3D%d&quot;, action);</span><br><span>     }</span><br><span>@@ -670,7=
 +678,7 @@</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>      =
           else if (e-&gt;arg =3D=3D MULTI_IO_FILE_CLOSE_WRITE)</span><br><=
span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    multi_process_file_closed(m, MPP_PRE_SELECT | MPP_REC=
ORD_TOUCH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            multi_process_file_closed(m);</span><br><span>                 =
}</span><br><span> #endif</span><br><span>         }</span><br><span>diff -=
-git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>=
index 7ae25c6=2E=2E591225c 100644</span><br><span>--- a/src/openvpn/multi_i=
o=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -44=
,6 +44,7 @@</span><br><span> #define TA_INITIAL               8</span><br><=
span> #define TA_TIMEOUT               9</span><br><span> #define TA_TUN_WR=
ITE_TIMEOUT     10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define TA_INSTANCE_POST         11</span><br><span> </span><br><span> /*</s=
pan><br><span>  * I/O state and events tracker</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demai=
l">change 2047</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2047?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2047 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gi=
anmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--qC6lncyaKCk=--


--===============6416695017522755579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6416695017522755579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6416695017522755579==--

