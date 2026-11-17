Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E046606A883
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UgDjsFoN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QIN/qZkY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jxg8vgrD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BmIsniRZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vmmQe41wWneLkuXgTtUuZYi1yO882BsFo9ODdTWBYVA=; b=UgDjsFoNot+YUf5zeNKylK9LOg
	2j7BmWrqHTQh5roBRZTN/tD8LPKghdSxoXL53JryEUCaBjQEiQv7j7sXexiQg1S8LEvy+o+z0y+J3
	MbOg6e3b8ePgBh41czsa/UFPYYORwyaoWOaxJdlbbm2OFwKmB7i82EIZ8sbBTURdgfPg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJqz-0000000073b-3NnX;
	Tue, 17 Nov 2026 14:08:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTJqw-0000000072w-0pkS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EG3aCSj85aJMMuyaRLUqsrXs2sixXQj4xzjTrQGl510=; b=QIN/qZkYwozlk5tbfYgaRgjZux
 Sb7DCcnkoOFNDZKYzDu6R72YRjnsbZ38r+g++8Xz+aicZrRoYPyPtVCFrQCLQbPRwWahT+rZ2H1Dv
 O02hryrUfJ791fz3kklpKv1IFnjt08sD4bgHW53Yho6ZRhuwtnAcxqq9UKLQsNl3cw2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EG3aCSj85aJMMuyaRLUqsrXs2sixXQj4xzjTrQGl510=; b=Jxg8vgrD2K24bDEog2EpJkM7TR
 vYdi6hrE0ozn0qbeo/ZOC26xFrPvem5xAoPzjn4Gsfw4ALcAV8QS9II9AjqqJmE5yRjsJ8fkxbTKU
 6Rs5BL/5cvL+EJvkvJfYIYTEBBC52pKkm5t61QZ9iRPcdHDIxXJN/iP/VPo5qBZgfj7A=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTJqc-000000007oc-2e4N for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:07:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so15608995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794924460; x=1795529260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EG3aCSj85aJMMuyaRLUqsrXs2sixXQj4xzjTrQGl510=;
 b=BmIsniRZj25LJlxm0pbALfjpJ3KiZhSsEMzRP6Ln/9SCZntsrQ/zU1Xdtn+bsVmgXD
 LEP9xt+GGjDt0RTBm/h4F2sFhnvc06kWQsDRnRyBVoVKlJPl/7Pczp3t8euS2KUKG2Yi
 lF4gTlPBlTh8y5PpgkPGHU+oBqMVIN4tGTD+FWrIbV34PNuTQp1q3Jifvj1udmvOdxDy
 0to0Nrod6+5kbb5rKmyNMo6eBo3CPQ/peaxOjRJOkd69pTe7+KHNujG3XpYusjMjqZsV
 DcuWssPXg8knS1dqx657fHv3WpawiPCzQgllW9P1CftcIC3wx80IkftIuiO0txS5ZRgj
 b+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924460; x=1795529260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EG3aCSj85aJMMuyaRLUqsrXs2sixXQj4xzjTrQGl510=;
 b=iKcOlKj45puO4CbSv4ziwZnt1z8CNDcSnQmVEMTgm1DwR7sVca91HcSX8+G+7SNd1n
 fEO2Sl3zxgNDkU306c3PW/GMPyt7u4hBI5n5w9Dlc2yg0J9yMLjtCNMTHTl5WUOHLV/s
 QIgpXZtint19QA1VnfsKAzvK4hrfvWE1OJV4PM4f8pOOjcuSKY+/5433Cf/d6LDx7WyL
 CR/Ol4Bhl8YMY6cJk5yJNxe2evSpDnulhVBSvrXWEBqKri+nNUOSLmJNEAdpD4ysdJAc
 NsHSSmUDP0IQ6GsM6oI8RJ640M+EPB4aHD+R+G+LQBKSdMVNNXa1V0d2cOKQqjQ4zAVd
 6mXw==
X-Gm-Message-State: APuU4Z8bNZtk3J6yg1SfoTQSVQN+DdfgNZ3hSgYzQLu+KibkEao+p0KM
 r91KPLSj9HWD6L57LE1NqDlmSxizvEWw7qrzPjvWRwbu5qHv8rIxlBD38APesn1mKLwzQxSsYeq
 d+VVKHa047Ufjg7qBEliE0+gVpx/2LLtDXZOIRP72O00Hk/5ZgkmNQKLOVjeZ8aqUrf39GoELAL
 aMEUjtZA==
X-Gm-Gg: AYBFou1ROCy2b5JxgTMQ+jS6Ow2sHcDW2BmHnilSgoMaTVmqzgqESvWlctd+accwxIH
 cAd3izVUjLA+w68rrNY/+siYtFgmdYQL1884zpv54oHEK6qrEbxciF2LujrAaSKDuyw6nXgm2dQ
 Fnvr1BGq3tHy1DJ0fqbekTyLwNzCHlR44IrQTCVKWPSPRXp367GSRWcr1U+INLxIDeZOFpu/1fx
 5kDLpw88T9dw1urYECtFxZQo+ZqyXJ1sVoGNzHvb6UHoojs2XXSsLo6rZsNzLgimavualIv/8Nc
 RorUn7G983TaENbpegG3XILsO9yW5TSx1jqEtzJugQqoG03y8LV4QPECgfAsj/CkB4QIyaf1BGt
 hjP+FkgkTF/wOrOm8X9cgLaxuIwwnJLzcFhv/yDVYV15YAWKRTiRvvOAK+kiWD1WxolGhmAZRSC
 qorTvxujDmiYb+EmSyoklTEyUczNRwDwJY4OTvov5uoZMzdWKRrpeeSDyaqtwee0bRCQB0SInae
 WJsLqxoeJyKb7mfR4Y0ci4rwkXOircsCaXYzK4WUKDcuyPPFY9/opaYvA/isxI0qUowJqEZUZ0g
 LixFis3cEUcqDuIMgDBWlmvu511cyXFBSIV+P/7WaXiRTtDjceJSWQPXRURgLQ1tWEI9vwg6ic2
 QyaHdvTuMr7OMgpKr6z6okqskmfCzdPdnNPi7wdxgxUZcT5nUTDRna7ga5o33ZQocTK3Nkvegea
 IYSx5OnDuCTRPj2EPZ8LkaBZmFw9wjSrfUqSUe
X-Received: by 2002:a05:600c:3486:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4bb55a6a828mr305446975e9.10.1794924459854; 
 Tue, 17 Nov 2026 06:07:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783854cesm107847075e9.1.2026.11.17.06.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:07:39 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:07:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: 1dd934d1f4a8823fe06f12f3b677c26d5a366dbb
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c99d43cf23b72cb84c7ce35d2433a8cba1e3982-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTJqc-000000007oc-2e4N
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: raise the
 open files limit for --max-clients
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
Content-Type: multipart/mixed; boundary="===============8372038457379673130=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8372038457379673130==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cUy0+xceCwk="; charset=UTF-8

--cUy0+xceCwk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2211?usp=3Demail

to review the following change=2E
=


Change subject: multi: raise the open files limit for --max-clients
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: raise the=
 open files limit for --max-clients

Every TCP client takes a file descript=
or and accept() happens before the
--max-clients check, so with the default=
 limits (soft limit 1024,
--max-clients 1024) the server runs out of descri=
ptors before it can
refuse a client=2E

When the server has a TCP listener,=
 raise the soft limit to
--max-clients plus some room for the other descrip=
tors, up to the hard
limit, and warn if that is not enough=2E Processes sta=
rted by OpenVPN
inherit the new limit=2E

Not on macOS, where the event loo=
p uses select() and cannot watch
descriptors >=3D FD_SETSIZE=2E

GitHub: cl=
oses OpenVPN/openvpn#1148
Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343f=
ad2
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M d=
oc/man-sections/server-options=2Erst
M src/openvpn/multi=2Ec
2 files change=
d, 62 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/11/2211/1

diff --git a/doc/man-sections/ser=
ver-options=2Erst b/doc/man-sections/server-options=2Erst
index 7a09809=2E=
=2E5c1b129 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man=
-sections/server-options=2Erst
@@ -418,6 +418,9 @@
 --max-clients n
   Limi=
t server to a maximum of ``n`` concurrent clients=2E Defaults to 1024=2E
 
=
+  With a TCP listener, the soft limit on open files is raised up to the ha=
rd
+  limit if needed to accept ``n`` clients (not on Windows and macOS)=2E=

+
 --max-routes-per-client n
   Allow a maximum of ``n`` internal routes p=
er client (default
   :code:`256`)=2E This is designed to help contain DoS =
attacks where an
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=

index ad9f9f4=2E=2Edacda86 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/op=
envpn/multi=2Ec
@@ -270,6 +270,64 @@
 #endif
 
 /*
+ * Every TCP client tak=
es a file descriptor, and accept() happens before the
+ * --max-clients che=
ck: raise the soft limit so that --max-clients is reached
+ * first, or war=
n if the hard limit does not allow it=2E
+ */
+static void
+multi_check_nof=
ile_limit(const struct context *t)
+{
+#if defined(HAVE_GETRLIMIT) && defin=
ed(RLIMIT_NOFILE) && !defined(TARGET_DARWIN)
+    bool tcp =3D false;
+    =
for (int i =3D 0; i < t->c1=2Elink_sockets_num; i++)
+    {
+        if (!p=
roto_is_dgram(t->c2=2Elink_sockets[i]->info=2Eproto))
+        {
+         =
   tcp =3D true;
+            break;
+        }
+    }
+    if (!tcp)
+    =
{
+        return;
+    }
+
+    /* room for the tun device, the listeners,=
 log, management, scripts=2E=2E=2E */
+    const rlim_t needed =3D (rlim_t)=
t->options=2Emax_clients + 64;
+
+    struct rlimit rl;
+    if (getrlimit(=
RLIMIT_NOFILE, &rl) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "WARNING: ge=
trlimit(RLIMIT_NOFILE) failed");
+        return;
+    }
+    if (rl=2Erlim=
_cur >=3D needed)
+    {
+        return;
+    }
+
+    const rlim_t old =
=3D rl=2Erlim_cur;
+    rl=2Erlim_cur =3D rl=2Erlim_max < needed ? rl=2Erli=
m_max : needed;
+    if (rl=2Erlim_cur > old && setrlimit(RLIMIT_NOFILE, &r=
l) =3D=3D 0)
+    {
+        msg(M_INFO, "Raised the open files limit from =
%lu to %lu", (unsigned long)old,
+            (unsigned long)rl=2Erlim_cur)=
;
+    }
+    else
+    {
+        rl=2Erlim_cur =3D old;
+    }
+    if (r=
l=2Erlim_cur < needed)
+    {
+        msg(M_WARN,
+            "WARNING: t=
he open files limit (%lu) is too low for --max-clients %" PRIu32
+         =
   ", TCP clients may be refused before --max-clients is reached",
+       =
     (unsigned long)rl=2Erlim_cur, t->options=2Emax_clients);
+    }
+#endi=
f /* if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !defined(TARGE=
T_DARWIN) */
+}
+
+/*
  * Main initialization function, init multi_context =
object=2E
  */
 static void
@@ -398,6 +456,7 @@
      * Per-client limits
 =
     */
     m->max_clients =3D t->options=2Emax_clients;
+    multi_check_=
nofile_limit(t);
 
     m->instances =3D calloc(m->max_clients, sizeof(stru=
ct multi_instance *));
     check_malloc_return(m->instances);

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c=
85b0d19343fad2
Gerrit-Change-Number: 2211
Gerrit-PatchSet: 1
Gerrit-Owner: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--cUy0+xceCwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">multi: raise the open files limit for --max-clients<br>=
<br>Every TCP client takes a file descriptor and accept() happens before th=
e<br>--max-clients check, so with the default limits (soft limit 1024,<br>-=
-max-clients 1024) the server runs out of descriptors before it can<br>refu=
se a client=2E<br><br>When the server has a TCP listener, raise the soft li=
mit to<br>--max-clients plus some room for the other descriptors, up to the=
 hard<br>limit, and warn if that is not enough=2E Processes started by Open=
VPN<br>inherit the new limit=2E<br><br>Not on macOS, where the event loop u=
ses select() and cannot watch<br>descriptors &gt;=3D FD_SETSIZE=2E<br><br>G=
itHub: closes OpenVPN/openvpn#1148<br>Change-Id: I17fafbe65fd3ff510a72ed809=
c85b0d19343fad2<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandel=
bit=2Ecom&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>M src/op=
envpn/multi=2Ec<br>2 files changed, 62 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/11/2211/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index 7a0980=
9=2E=2E5c1b129 100644</span><br><span>--- a/doc/man-sections/server-options=
=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><b=
r><span>@@ -418,6 +418,9 @@</span><br><span> --max-clients n</span><br><spa=
n>   Limit server to a maximum of ``n`` concurrent clients=2E Defaults to 1=
024=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  With a TCP listener, the soft limit on open files is raised up to th=
e hard</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  limit if ne=
eded to accept ``n`` clients (not on Windows and macOS)=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --max-routes-per-c=
lient n</span><br><span>   Allow a maximum of ``n`` internal routes per cli=
ent (default</span><br><span>   :code:`256`)=2E This is designed to help co=
ntain DoS attacks where an</span><br><span>diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec</span><br><span>index ad9f9f4=2E=2Edacda86 100=
644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/o=
penvpn/multi=2Ec</span><br><span>@@ -270,6 +270,64 @@</span><br><span> #end=
if</span><br><span> </span><br><span> /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Every TCP client takes a file descriptor, and accep=
t() happens before the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * --max-clients check: raise the soft limit so that --max-clients is re=
ached</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first, or w=
arn if the hard limit does not allow it=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ulti_check_nofile_limit(const struct context *t)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(HAVE_GETRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &a=
mp;&amp; !defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool tcp =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (int i =3D 0; i &lt; t-&gt;c1=2Elink_sockets_num; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_dgram(t=
-&gt;c2=2Elink_sockets[i]-&gt;info=2Eproto))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            tcp =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!tcp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* room for the tun device, the listeners, log, manageme=
nt, scripts=2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const rlim_t needed =3D (rlim_t)t-&gt;options=2Emax_clients + 64;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct rlimit rl;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (getrlimit(RLIMIT_NOFILE, &amp;=
rl) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M=
_ERRNO, &quot;WARNING: getrlimit(RLIMIT_NOFILE) failed&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &gt;=3D needed)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t rlim_t old =3D rl=2Erlim_cur;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rl=2Erlim_cur =3D rl=2Erlim_max &lt; needed ? rl=2Erlim_max=
 : needed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r=
l=2Erlim_cur &gt; old &amp;&amp; setrlimit(RLIMIT_NOFILE, &amp;rl) =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Raised=
 the open files limit from %lu to %lu&quot;, (unsigned long)old,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            (unsigned long)rl=
=2Erlim_cur);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        rl=2Erlim_cur =3D old;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (rl=2Erlim_cur &lt; needed)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;WARNING: the open files limit=
 (%lu) is too low for --max-clients %&quot; PRIu32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;, TCP clients may be refus=
ed before --max-clients is reached&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            (unsigned long)rl=2Erlim_cur, t-&gt;optio=
ns=2Emax_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if de=
fined(HAVE_GETRLIMIT) &amp;&amp; defined(RLIMIT_NOFILE) &amp;&amp; !defined=
(TARGET_DARWIN) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Main initializa=
tion function, init multi_context object=2E</span><br><span>  */</span><br>=
<span> static void</span><br><span>@@ -398,6 +456,7 @@</span><br><span>    =
  * Per-client limits</span><br><span>      */</span><br><span>     m-&gt;m=
ax_clients =3D t-&gt;options=2Emax_clients;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi_check_nofile_limit(t);</span><br><span> <=
/span><br><span>     m-&gt;instances =3D calloc(m-&gt;max_clients, sizeof(s=
truct multi_instance *));</span><br><span>     check_malloc_return(m-&gt;in=
stances);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd3ff510a72ed8=
09c85b0d19343fad2 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2211 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--cUy0+xceCwk=--


--===============8372038457379673130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8372038457379673130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8372038457379673130==--

