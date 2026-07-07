Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C01C44501
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GdwAaff9G16lc9N9H9D9FUceKAqNocnN+sVKLafUn9c=; b=eQTfzdnlwBTXI12EF0CHIsPcQL
	iV07tmoRj8VcH03pITrLHgcC0edhU6E6vRnSjeN29f0cprCN7OSxb1cA6YSVH1ELxLTQiJcDmO0iw
	x+qXW1hNrWU0Z+GwAbmRU8rVVpw0WFXMBbz4B+IbJ7Yi1QE7pBaUgBnXI/SYEqDB6yD4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh8FS-0005TZ-CV;
	Tue, 07 Jul 2026 16:02:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wh8Eu-0005Sy-4s
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 16:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ruPLVSs+Ke6hKGc0pPjuXGONKjwUCbn8ExINcx80z3U=; b=NfQTE9WHnE9WutGDrzogX90/RX
 SKVU3wfS3oM3uoAI/PQpFha680zjBvTV/Lj+kbYEwO65wmSZEuhBdXV3b1zaLBxiugh+WwRyRG1r8
 UKnqDi5Aj3WucDK0WsXyiW/fM42u8HzgB1wz7CPcK7K7/moL/RYuU2axHxKokeHfuxhA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ruPLVSs+Ke6hKGc0pPjuXGONKjwUCbn8ExINcx80z3U=; b=K
 CZKdnWunwE8mQB1L0Wi7ET6+nj6MLX6HFrR77lS6lMIiQOlhX9PXIcSrbDhrWGB3M6VwfsVF4AhRc
 OSmDtVsT/0KTR026/I31aCi8hLeA94mnxjmlrpWhgEuA+xz4pMQWvRtqAJVfJBW9nhDSenzRABEkU
 oJQNrzMz5fo3d1mE=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wh8Ei-0002W5-EO for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 16:01:32 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47afb758487so600575f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 07 Jul 2026 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783440082; x=1784044882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ruPLVSs+Ke6hKGc0pPjuXGONKjwUCbn8ExINcx80z3U=;
 b=aZLrrBWZW4LooeCJODNJ7pfiWxqWza+4x6WBCGvdrNKEjzLKYjMFyZyhZW/pka+gZ2
 mhU289fk3uQXLt1WN/7ZIE2S6+TTUyUEFfrz930wqhqCtL6roZbtmRrIzfiuep08a4JQ
 SFmsF9zpR0YlI7+SSpTI7erNetzE8ORGroC3DD37BD3DN0YYo4s9U6K8v+Lq37MquG10
 ThxzEumbSm9Owv3Q6Q5jxRnEgmE9MRiPdlEsRKfuDzB7Ks6cPjTl8EB0ybMIIQFb1V/m
 C13CL9IEhCTXmwCKLX0IJptMJmyN7whoQUNQdOcM8do1jysFozwKoMqzhMk17rbflgpL
 hErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783440082; x=1784044882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ruPLVSs+Ke6hKGc0pPjuXGONKjwUCbn8ExINcx80z3U=;
 b=G8npsHSqOjQADHik9hgm4F7aQ/+/OWAP0h+RUxjM/2NJfSdQbxa7+fodHl/lyfkZf3
 Seoq71ATbXD1QQRdAs65HMkwbNWLPzF6eRpKjhpHlLrn3y1xEQ0UlVxmmqDdzSPwRyKr
 TSUI422mwhkuEmy8zqSZ4F5p6b8Fj4H7L7irXtAuFnGC3QfUqZLLVD9RLRmElWa4xThq
 9UfHmk8SH+JRR+bkxvzE4Qi5T/in/R3/ntjxiUwk4gf7mMC5DaUfo+9OvSGkWR8mkndy
 57/6NEiB3IuvNpCq2k3GriUdmdxRSTYF/7v0PnAVglVfhBoMeZmsW/oBVA1fW18/MK79
 rPFA==
X-Gm-Message-State: AOJu0YzGOQ6avXV+hxsdmDo6SgQh0zzsuVNjvi/OtVr9QYRZRBnAe9mJ
 +M2WDGsJyoCiU4dQaSFdTPHbBz98/pEeC3b3HSBfFoSx3I/0OgQJzh+H1uZch88vP9A3gHGGv4L
 oqfy6EsvroNt1lu+OqkMw0AA4thenvsTDB+F5hIFaFt4crjbML8cLFAPtwyteT8MQ5Ag/rJo2XV
 3dfuT7Mw==
X-Gm-Gg: AfdE7clh1OVuZSDKAGyDNTE/OIzWAf5T33WhsqqxsAYKl0iSSQxU4kmYyD7sx6pg+a/
 f6iD+PGxN7RgOLfhqc95GRAvLBwJyfB17lf/PvQhdIXoRSfyW75JtbQYm6v6/AX9cj/wLqIz3IR
 TYwtOXVpTiwwibjzDO/srimSd6x5Kd6dlDxA9i4YvrXBLiBHKTFaqO0Po5POp7nGgYB4JDX4rEw
 epfbu2qF/1c/mSEqEZr4KnAlqHc2zhRKYrsUZoehg4cCCgLE0tPXuA5BzhdSw3oN9BTI+x/4dTL
 DNHN/mfkw6nkhnNa1e+8/a4IkXpRZI3++94/hOFcr9dEhsE9/6oqjiPaNjA7qWjo1VurIbnTgzt
 xdmj52mqlAkhP3kFMv6f8m3C1W2tUB9ujqobB6DsnpwbsUOWliMsQHr82mGo3QvQeWT4kdC20WP
 9VpJ6P8yiEEscIntMXPdaEcPBjaNL+LFXs6V2F6imHiREozYNgYyT02ioEzIDMPP4/IHv4JcmJm
 LMHzf6vWVY85HBAThqom8Qr2OHy2LuoQ50V35RoPrpfYmmsN/+iCnN10+TzK+8UEDK6wWJiyWbZ
 lvk=
X-Received: by 2002:adf:f705:0:b0:475:613c:c9f2 with SMTP id
 ffacd0b85a97d-47de6697a74mr4975941f8f.5.1783440080962; 
 Tue, 07 Jul 2026 09:01:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm33565391f8f.29.2026.07.07.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:01:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 7 Jul 2026 16:01:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 07bda8636919dade096f3c2c1768a5ab7659c5bd
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff9221c05062a36c1a598639142364ab917b1ea2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wh8Ei-0002W5-EO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7593353528920783685=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7593353528920783685==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HtoQzCPj97A="; charset=UTF-8

--HtoQzCPj97A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail

to look at the new patch set (#9)=2E

=

Change subject: Remove various useless assignments
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove various useless assignments=


The values assigned by these are never actually used
for something=2E

Id=
entified by cppcheck=2E

Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393=
ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/ope=
nvpn/console_builtin=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/error=2Eh
M=
 src/openvpn/forward=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/options=2Ec=

M src/openvpn/pkcs11=2Ec
M src/openvpn/pkcs11_openssl=2Ec
M src/openvpn/pu=
sh_util=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/op=
envpn/win32=2Ec
M src/openvpnmsica/openvpnmsica=2Ec
M src/tapctl/tap=2Ec
M =
tests/unit_tests/openvpn/test_ssl=2Ec
15 files changed, 37 insertions(+), 5=
4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/17/1617/9

diff --git a/src/openvpn/console_builtin=2Ec b/src/open=
vpn/console_builtin=2Ec
index 2a9f3b6=2E=2E9c8d72a 100644
--- a/src/openvpn=
/console_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -192,7 +192,6=
 @@
 static bool
 get_console_input(const char *prompt, const bool echo, ch=
ar *input, const int capacity)
 {
-    bool ret =3D false;
     ASSERT(prom=
pt);
     ASSERT(input);
     ASSERT(capacity > 0);
@@ -200,8 +199,11 @@
 
=
 #if defined(_WIN32)
     return get_console_input_win32(prompt, echo, inpu=
t, capacity);
-#elif defined(HAVE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H=
)
+    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)",=
 prompt);
+#else
     bool restore_tty =3D false;
+    bool ret =3D false;
=
     struct termios tty_tmp, tty_save;
 
     /* did we --daemon'ize before=
 asking for passwords?
@@ -258,10 +260,8 @@
     }
 
     close_tty(fp);
-#=
else  /* if defined(_WIN32) */
-    msg(M_FATAL, "Sorry, but I can't get co=
nsole input on this OS (%s)", prompt);
-#endif /* if defined(_WIN32) */
   =
  return ret;
+#endif /* if defined(_WIN32) */
 }
 
 /**
diff --git a/src/o=
penvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 3d79fe5=2E=2E23273b7 10064=
4
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1204,8 +120=
4,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
    =
 struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
  =
   struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
=
-    struct buffer buf =3D clear_buf();
-    void *buf_p;
 
     /* init wo=
rk */
     ASSERT(buf_init(&work, frame->buf=2Eheadroom));
@@ -1242,8 +1240=
,8 @@
         ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
 
         /* co=
py source to input buf */
-        buf =3D work;
-        buf_p =3D buf_wri=
te_alloc(&buf, BLENZ(&src));
+        struct buffer buf =3D work;
+        =
void *buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);=

         memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
diff --git a/src/openvp=
n/error=2Eh b/src/openvpn/error=2Eh
index 45826a2=2E=2Ea887fc7 100644
--- a=
/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -408,8 +408,8 @@
 ope=
nvpn_errno_maybe_crt(bool *crt_error)
 {
     int err =3D 0;
-    *crt_erro=
r =3D false;
 #ifdef _WIN32
+    *crt_error =3D false;
     err =3D GetLast=
Error();
     if (err =3D=3D ERROR_SUCCESS)
     {
diff --git a/src/openvpn=
/forward=2Ec b/src/openvpn/forward=2Ec
index ab76b9e=2E=2E2c1ee6e 100644
--=
- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1748,7 +1748,=
6 @@
 process_outgoing_link(struct context *c, struct link_socket *sock)
 {=

     struct gc_arena gc =3D gc_new();
-    int error_code =3D 0;
 
     if=
 (c->c2=2Eto_link=2Elen > 0 && c->c2=2Eto_link=2Elen <=3D c->c2=2Eframe=2Eb=
uf=2Epayload_size)
     {
@@ -1823,7 +1822,7 @@
         }
 
         /* Ch=
eck return status */
-        error_code =3D openvpn_errno();
+        int =
error_code =3D openvpn_errno();
         check_status(size, "write", sock, =
NULL);
 
         if (size > 0)
diff --git a/src/openvpn/manage=2Ec b/src/o=
penvpn/manage=2Ec
index 2a3023c=2E=2Ef1dccc1 100644
--- a/src/openvpn/manag=
e=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -916,10 +916,9 @@
 static void
 man_r=
emote_entry_count(struct management *man)
 {
-    unsigned count =3D 0;
   =
  if (man->persist=2Ecallback=2Eremote_entry_count)
     {
-        count =
=3D (*man->persist=2Ecallback=2Eremote_entry_count)(man->persist=2Ecallback=
=2Earg);
+        unsigned int count =3D (*man->persist=2Ecallback=2Eremote=
_entry_count)(man->persist=2Ecallback=2Earg);
         msg(M_CLIENT, "%u", =
count);
         msg(M_CLIENT, "END");
     }
@@ -3745,7 +3744,6 @@
     st=
ruct gc_arena gc =3D gc_new();
     int ret =3D 0;
     volatile int signal=
_received =3D 0;
-    struct buffer alert_msg =3D clear_buf();
     const b=
ool standalone_disabled_save =3D man->persist=2Estandalone_disabled;
     s=
truct man_connection *mc =3D &man->connection;
 
@@ -3757,6 +3755,7 @@
 
  =
       *state =3D EKS_SOLICIT;
 
+        struct buffer alert_msg;
        =
 if (b64_data)
         {
             alert_msg =3D alloc_buf_gc(strlen(b6=
4_data) + strlen(prompt) + 3, &gc);
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index 87218d4=2E=2E362e39c 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -7110,7 +7110,6 @@
          =
   if (streq(p[1], "FORWARD_COMPATIBLE") && p[2] && streq(p[2], "1"))
     =
        {
                 options->forward_compatible =3D true;
-         =
       msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
    =
         }
             setenv_str(es, p[1], p[2] ? p[2] : "");
         }
=
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index cfcd372=
=2E=2Ed115e0a 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=
=2Ec
@@ -79,6 +79,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs112openvpn(const u=
nsigned flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return M_INFO;
+#e=
lse
     msglvl_t openvpn_flags;
 
     switch (flags)
@@ -108,16 +111,16 @=
@
             break;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-   =
 openvpn_flags =3D M_INFO;
-#endif
-
     return openvpn_flags;
+#endif
 }
=
 
 static unsigned
 _pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)
 {
+#i=
fdef ENABLE_PKCS11_FORCE_DEBUG
+    return PKCS11H_LOG_DEBUG2;
+#else
     =
unsigned pkcs11_flags;
 
     if ((flags & D_PKCS11_DEBUG) !=3D 0)
@@ -145,=
11 +148,8 @@
         pkcs11_flags =3D PKCS11H_LOG_ERROR;
     }
 
-#if def=
ined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;
-=
#endif
-
     return pkcs11_flags;
+#endif
 }
 
 static void
diff --git a/s=
rc/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index b6c162=
4=2E=2E69c5a50 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/openvp=
n/pkcs11_openssl=2Ec
@@ -384,7 +384,6 @@
     if (certificate !=3D NULL)
  =
   {
         pkcs11h_certificate_freeCertificate(certificate);
-        ce=
rtificate =3D NULL;
     }
 
     /*
@@ -400,7 +399,6 @@
     if (openssl_s=
ession !=3D NULL)
     {
         pkcs11h_openssl_freeSession(openssl_sessi=
on);
-        openssl_session =3D NULL;
     }
     return ret;
 #endif    =
                                                      /* ifdef HAVE_XKEY_PR=
OVIDER */
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2E=
c
index f57f54d=2E=2Eaf22af5 100644
--- a/src/openvpn/push_util=2Ec
+++ b/s=
rc/openvpn/push_util=2Ec
@@ -99,7 +99,6 @@
     }
 
     char *str =3D gc_s=
trdup(s, gc);
-    size_t i =3D 0;
 
     while (*str)
     {
@@ -112,11 +1=
11,11 @@
                 /* if no commas were found go to fail, do not sen=
d any message */
                 return false;
             }
+           =
 /* copy from current position to (ci - 1) */
             str[ci] =3D '\0'=
;
-            /* copy from i to (ci -1) */
             struct buffer tmp =
=3D forge_msg(str, ",push-continuation 2", gc);
             buffer_list_pu=
sh(msgs, BSTR(&tmp));
-            i =3D ci + 1;
+            str +=3D ci +=
 1;
         }
         else
         {
@@ -130,9 +129,8 @@
               =
  struct buffer tmp =3D forge_msg(str, NULL, gc);
                 buffer_l=
ist_push(msgs, BSTR(&tmp));
             }
-            i =3D strlen(str);
=
+            break;
         }
-        str =3D &str[i];
     }
     return=
 true;
 }
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
inde=
x 3450e5d=2E=2Ef5fc715 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvp=
n/socket=2Ec
@@ -789,7 +789,7 @@
      */
     socklen_t remote_len_af =3D =
af_addr_size(act->dest=2Eaddr=2Esa=2Esa_family);
     socklen_t remote_len =
=3D sizeof(act->dest=2Eaddr);
-    socket_descriptor_t new_sd =3D SOCKET_UN=
DEFINED;
+    socket_descriptor_t new_sd;
 
     CLEAR(*act);
 
diff --git =
a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 579bdce=
=2E=2E9c92a7b 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ss=
l_openssl=2Ec
@@ -2354,13 +2354,13 @@
     }
 
     int typeid =3D EVP_PKEY=
_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_NUMBER < 0x3000000=
0L
     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;
 #else
     bool is_ec =
=3D EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_NO_EC
     char g=
roupname[64];
     if (is_ec)
     {
@@ -2668,15 +2668,13 @@
            "b=
uiltin EC curves=2E It does not list additional curves nor X448 or X25519\n=
");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves =3D NULL;
-    siz=
e_t crv_len =3D 0;
-    size_t n =3D 0;
 
-    crv_len =3D EC_get_builtin_c=
urves(NULL, 0);
+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0);
   =
  ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_c=
urves(curves, crv_len))
     {
         printf("\nAvailable Elliptic curves=
/groups:\n");
-        for (n =3D 0; n < crv_len; n++)
+        for (size_t=
 n =3D 0; n < crv_len; n++)
         {
             const char *sname;
    =
         sname =3D OBJ_nid2sn(curves[n]=2Enid);
diff --git a/src/openvpn/wi=
n32=2Ec b/src/openvpn/win32=2Ec
index ca08ead=2E=2Eade7ec0 100644
--- a/src=
/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1293,9 +1293,6 @@
     i=
s_wow64_process2_t is_wow64_process2 =3D
         (is_wow64_process2_t)GetP=
rocAddress(GetModuleHandle("Kernel32=2Edll"), "IsWow64Process2");
 
-    US=
HORT process_machine =3D 0;
-    USHORT native_machine =3D 0;
-
 #ifdef _AR=
M64_
     *process_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
@@ -1303,6 +=
1300,8 @@
     if (is_wow64_process2)
     {
         /* this could be amd6=
4 on arm64 */
+        USHORT process_machine =3D 0;
+        USHORT native=
_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProc=
ess(), &process_machine, &native_machine);
         if (is_wow64 && native_=
machine =3D=3D IMAGE_FILE_MACHINE_ARM64)
         {
@@ -1315,6 +1314,8 @@
 =
    if (is_wow64_process2)
     {
         /* check if we're running on arm=
64 or amd64 machine */
+        USHORT process_machine =3D 0;
+        USHO=
RT native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCu=
rrentProcess(), &process_machine, &native_machine);
         if (is_wow64)
=
         {
diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsic=
a/openvpnmsica=2Ec
index 9d12963=2E=2E95e457c 100644
--- a/src/openvpnmsica=
/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -711,7 +711,6 =
@@
         uiResult =3D MsiViewFetch(hViewST, &hRecord);
         if (uiRe=
sult =3D=3D ERROR_NO_MORE_ITEMS)
         {
-            uiResult =3D ERROR=
_SUCCESS;
             break;
         }
         else if (uiResult !=3D ER=
ROR_SUCCESS)
diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec
index 1d9=
4988=2E=2Ecccc0e1 100644
--- a/src/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec
=
@@ -473,7 +473,7 @@
                         return ERROR_OUTOFMEMORY;
    =
                 }
 
-                    dwCountExpResult =3D ExpandEnviro=
nmentStrings(szValue, szValueExp, dwCountExp);
+                    ExpandE=
nvironmentStrings(szValue, szValueExp, dwCountExp);
                     fr=
ee(szValue);
                     *pszValue =3D szValueExp;
               =
      return ERROR_SUCCESS;
@@ -601,8 +601,6 @@
                         _I=
n_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,
            =
             _Out_ LPVOID *ppData)
 {
-    DWORD dwResult =3D ERROR_BAD_ARG=
UMENTS;
-
     if (ppData =3D=3D NULL)
     {
         return ERROR_BAD_ARG=
UMENTS;
@@ -628,7 +626,7 @@
     }
     else
     {
-        dwResult =3D G=
etLastError();
+        DWORD dwResult =3D GetLastError();
         if (dwR=
esult =3D=3D ERROR_INSUFFICIENT_BUFFER)
         {
             /* Allocate=
 on heap and retry=2E */
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec=
 b/tests/unit_tests/openvpn/test_ssl=2Ec
index 0e9cecf=2E=2Ec40845a 100644
=
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/=
test_ssl=2Ec
@@ -303,8 +303,6 @@
     struct buffer work =3D alloc_buf_gc(B=
UF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_g=
c(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace =3D alloc_bu=
f_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
-    v=
oid *buf_p;
 
     /* init work */
     ASSERT(buf_init(&work, frame=2Ebuf=
=2Eheadroom));
@@ -325,8 +323,8 @@
         ASSERT(rand_bytes(BPTR(&src), B=
LEN(&src)));
 
         /* copy source to input buf */
-        buf =3D wor=
k;
-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        struct b=
uffer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ(&s=
rc));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src=
));
 
@@ -356,7 +354,6 @@
     struct buffer encrypt_workspace =3D alloc_bu=
f_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace =3D alloc=
_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer work =3D alloc_buf_gc(BU=
F_SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
     struct b=
uffer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_size, &gc);
     void *buf=
_p;
 
@@ -371,7 +368,7 @@
     ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
=
 
     /* copy source to input buf */
-    buf =3D work;
+    struct buffer=
 buf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSE=
RT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));
@@ -652,7 +649,6 @@=

     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     stru=
ct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     s=
truct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-  =
  struct buffer buf =3D clear_buf();
     void *buf_p;
 
     /* init work =
*/
@@ -669,7 +665,7 @@
     ASSERT(buf_write(&src, plaintext, strlen(plaint=
ext)));
 
     /* copy source to input buf */
-    buf =3D work;
+    struc=
t buffer buf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
 =
    ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332=
f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 9
Gerrit-Owner: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--HtoQzCPj97A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
move various useless assignments<br><br>The values assigned by these are ne=
ver actually used<br>for something=2E<br><br>Identified by cppcheck=2E<br><=
br>Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/co=
nsole_builtin=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/error=2Eh<br=
>M src/openvpn/forward=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/opt=
ions=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/pkcs11_openssl=2Ec<br=
>M src/openvpn/push_util=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/s=
sl_openssl=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnmsica/openvpnmsic=
a=2Ec<br>M src/tapctl/tap=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br=
>15 files changed, 37 insertions(+), 54 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/16=
17/9</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/con=
sole_builtin=2Ec</span><br><span>index 2a9f3b6=2E=2E9c8d72a 100644</span><b=
r><span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/ope=
nvpn/console_builtin=2Ec</span><br><span>@@ -192,7 +192,6 @@</span><br><spa=
n> static bool</span><br><span> get_console_input(const char *prompt, const=
 bool echo, char *input, const int capacity)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br=
><span>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span><br><=
span>     ASSERT(capacity &gt; 0);</span><br><span>@@ -200,8 +199,11 @@</sp=
an><br><span> </span><br><span> #if defined(_WIN32)</span><br><span>     re=
turn get_console_input_win32(prompt, echo, input, capacity);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_TERMIOS_H)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(HAVE_TERMIO=
S_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL=
, &quot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;, pro=
mpt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><b=
r><span>     bool restore_tty =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool ret =3D false;</span><br><span>     struct te=
rmios tty_tmp, tty_save;</span><br><span> </span><br><span>     /* did we -=
-daemon&#39;ize before asking for passwords?</span><br><span>@@ -258,10 +26=
0,8 @@</span><br><span>     }</span><br><span> </span><br><span>     close_=
tty(fp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if =
defined(_WIN32) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 msg(M_FATAL, &quot;Sorry, but I can&#39;t get console input on this OS (%s=
)&quot;, prompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if defined(_WIN32) */</span><br><span>     return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) */</s=
pan><br><span> }</span><br><span> </span><br><span> /**</span><br><span>dif=
f --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>i=
ndex 3d79fe5=2E=2E23273b7 100644</span><br><span>--- a/src/openvpn/crypto=
=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1204,=
8 +1204,6 @@</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_S=
IZE(frame), &amp;gc);</span><br><span>     struct buffer encrypt_workspace =
=3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct buf=
fer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear=
_buf();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_=
p;</span><br><span> </span><br><span>     /* init work */</span><br><span> =
    ASSERT(buf_init(&amp;work, frame-&gt;buf=2Eheadroom));</span><br><span>=
@@ -1242,8 +1240,8 @@</span><br><span>         ASSERT(rand_bytes(BPTR(&amp;=
src), BLEN(&amp;src)));</span><br><span> </span><br><span>         /* copy =
source to input buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D wo=
rk;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        void *bu=
f_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>       =
  ASSERT(buf_p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLE=
NZ(&amp;src));</span><br><span> </span><br><span>diff --git a/src/openvpn/e=
rror=2Eh b/src/openvpn/error=2Eh</span><br><span>index 45826a2=2E=2Ea887fc7=
 100644</span><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/s=
rc/openvpn/error=2Eh</span><br><span>@@ -408,8 +408,8 @@</span><br><span> o=
penvpn_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br><span>=
     int err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  *crt_error =3D false;</span><br><span> #ifdef _WIN32</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *crt_error =3D false;</span><br><spa=
n>     err =3D GetLastError();</span><br><span>     if (err =3D=3D ERROR_SU=
CCESS)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/forw=
ard=2Ec b/src/openvpn/forward=2Ec</span><br><span>index ab76b9e=2E=2E2c1ee6=
e 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ =
b/src/openvpn/forward=2Ec</span><br><span>@@ -1748,7 +1748,6 @@</span><br><=
span> process_outgoing_link(struct context *c, struct link_socket *sock)</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int error_code =3D 0;<=
/span><br><span> </span><br><span>     if (c-&gt;c2=2Eto_link=2Elen &gt; 0 =
&amp;&amp; c-&gt;c2=2Eto_link=2Elen &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayloa=
d_size)</span><br><span>     {</span><br><span>@@ -1823,7 +1822,7 @@</span>=
<br><span>         }</span><br><span> </span><br><span>         /* Check re=
turn status */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 error_code =3D openvpn_errno();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int error_code =3D openvpn_errno();</span><br><span>  =
       check_status(size, &quot;write&quot;, sock, NULL);</span><br><span> =
</span><br><span>         if (size &gt; 0)</span><br><span>diff --git a/src=
/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2a3023c=
=2E=2Ef1dccc1 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br=
><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -916,10 +916,9 @@</s=
pan><br><span> static void</span><br><span> man_remote_entry_count(struct m=
anagement *man)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    unsigned count =3D 0;</span><br><span>     if (man-&gt;per=
sist=2Ecallback=2Eremote_entry_count)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        count =3D (*man-&gt;persist=
=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ecallback=2Earg);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int count=
 =3D (*man-&gt;persist=2Ecallback=2Eremote_entry_count)(man-&gt;persist=2Ec=
allback=2Earg);</span><br><span>         msg(M_CLIENT, &quot;%u&quot;, coun=
t);</span><br><span>         msg(M_CLIENT, &quot;END&quot;);</span><br><spa=
n>     }</span><br><span>@@ -3745,7 +3744,6 @@</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     int ret =3D 0;</span><br><sp=
an>     volatile int signal_received =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct buffer alert_msg =3D clear_buf();</span><b=
r><span>     const bool standalone_disabled_save =3D man-&gt;persist=2Estan=
dalone_disabled;</span><br><span>     struct man_connection *mc =3D &amp;ma=
n-&gt;connection;</span><br><span> </span><br><span>@@ -3757,6 +3755,7 @@</=
span><br><span> </span><br><span>         *state =3D EKS_SOLICIT;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct buffer alert_msg;</span><br><span>         if (b64_data)</span><br><spa=
n>         {</span><br><span>             alert_msg =3D alloc_buf_gc(strlen=
(b64_data) + strlen(prompt) + 3, &amp;gc);</span><br><span>diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 87218d=
4=2E=2E362e39c 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><=
br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -7110,7 +7110,6 @=
@</span><br><span>             if (streq(p[1], &quot;FORWARD_COMPATIBLE&quo=
t;) &amp;&amp; p[2] &amp;&amp; streq(p[2], &quot;1&quot;))</span><br><span>=
             {</span><br><span>                 options-&gt;forward_compati=
ble =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</sp=
an><br><span>             }</span><br><span>             setenv_str(es, p[1=
], p[2] ? p[2] : &quot;&quot;);</span><br><span>         }</span><br><span>=
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec</span><br><spa=
n>index cfcd372=2E=2Ed115e0a 100644</span><br><span>--- a/src/openvpn/pkcs1=
1=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</span><br><span>@@ -79,6=
 +79,9 @@</span><br><span> static msglvl_t</span><br><span> _pkcs11_msg_pkc=
s112openvpn(const unsigned flags)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return M_INFO;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     ms=
glvl_t openvpn_flags;</span><br><span> </span><br><span>     switch (flags)=
</span><br><span>@@ -108,16 +111,16 @@</span><br><span>             break;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    openvpn_flags =3D M_INFO;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     return openvpn_flags;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> }</span><br><span> </span><br><span> static unsigned</span><br><span> _pk=
cs11_msg_openvpn2pkcs11(const msglvl_t flags)</span><br><span> {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PKCS11_FORCE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return PKCS11=
H_LOG_DEBUG2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span>     unsigned pkcs11_flags;</span><br><span> </span><br><sp=
an>     if ((flags &amp; D_PKCS11_DEBUG) !=3D 0)</span><br><span>@@ -145,11=
 +148,8 @@</span><br><span>         pkcs11_flags =3D PKCS11H_LOG_ERROR;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(ENABLE_PKCS11_FORCE_DEBUG)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return pkcs11_fl=
ags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> }</span><br><span> </span><br><span> static void</span><br><span>d=
iff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec=
</span><br><span>index b6c1624=2E=2E69c5a50 100644</span><br><span>--- a/sr=
c/openvpn/pkcs11_openssl=2Ec</span><br><span>+++ b/src/openvpn/pkcs11_opens=
sl=2Ec</span><br><span>@@ -384,7 +384,6 @@</span><br><span>     if (certifi=
cate !=3D NULL)</span><br><span>     {</span><br><span>         pkcs11h_cer=
tificate_freeCertificate(certificate);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        certificate =3D NULL;</span><br><span>     }</span=
><br><span> </span><br><span>     /*</span><br><span>@@ -400,7 +399,6 @@</s=
pan><br><span>     if (openssl_session !=3D NULL)</span><br><span>     {</s=
pan><br><span>         pkcs11h_openssl_freeSession(openssl_session);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        openssl_session =3D =
NULL;</span><br><span>     }</span><br><span>     return ret;</span><br><sp=
an> #endif                                                          /* ifde=
f HAVE_XKEY_PROVIDER */</span><br><span>diff --git a/src/openvpn/push_util=
=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index f57f54d=2E=2Eaf22af5=
 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++=
 b/src/openvpn/push_util=2Ec</span><br><span>@@ -99,7 +99,6 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     char *str =3D gc_strdup(s=
, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =
=3D 0;</span><br><span> </span><br><span>     while (*str)</span><br><span>=
     {</span><br><span>@@ -112,11 +111,11 @@</span><br><span>              =
   /* if no commas were found go to fail, do not send any message */</span>=
<br><span>                 return false;</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* copy fro=
m current position to (ci - 1) */</span><br><span>             str[ci] =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /* copy from i to (ci -1) */</span><br><span>             struct buffer=
 tmp =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</span><br><s=
pan>             buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            i =3D ci + 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            str +=3D ci + 1;</span=
><br><span>         }</span><br><span>         else</span><br><span>       =
  {</span><br><span>@@ -130,9 +129,8 @@</span><br><span>                 st=
ruct buffer tmp =3D forge_msg(str, NULL, gc);</span><br><span>             =
    buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>             }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i =3D strl=
en(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        str =3D &amp;str[i];</span><br><span>     }</span><br>=
<span>     return true;</span><br><span> }</span><br><span>diff --git a/src=
/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 3450e5d=
=2E=2Ef5fc715 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -789,7 +789,7 @@</sp=
an><br><span>      */</span><br><span>     socklen_t remote_len_af =3D af_a=
ddr_size(act-&gt;dest=2Eaddr=2Esa=2Esa_family);</span><br><span>     sockle=
n_t remote_len =3D sizeof(act-&gt;dest=2Eaddr);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    socket_descriptor_t new_sd =3D SOCKET_UNDEFIN=
ED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_descr=
iptor_t new_sd;</span><br><span> </span><br><span>     CLEAR(*act);</span><=
br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>index 579bdce=2E=2E9c92a7b 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_openssl=2Ec</span><br><span>@@ -2354,13 +2354,13 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     int typeid =3D EVP_PKEY_i=
d(pkey);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_NO_EC</span><b=
r><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span>     b=
ool is_ec =3D typeid =3D=3D EVP_PKEY_EC;</span><br><span> #else</span><br><=
span>     bool is_ec =3D EVP_PKEY_is_a(pkey, &quot;EC&quot;);</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENSSL_NO_EC</span><br>=
<span>     char groupname[64];</span><br><span>     if (is_ec)</span><br><s=
pan>     {</span><br><span>@@ -2668,15 +2668,13 @@</span><br><span>        =
    &quot;builtin EC curves=2E It does not list additional curves nor X448 =
or X25519\n&quot;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><span>=
     EC_builtin_curve *curves =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t crv_len =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t n =3D 0;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    crv_len =3D EC_get_builtin_curves=
(NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t crv_len =3D EC_get_builtin_curves(NULL, 0);</span><br><span>     ALLOC_AR=
RAY(curves, EC_builtin_curve, crv_len);</span><br><span>     if (EC_get_bui=
ltin_curves(curves, crv_len))</span><br><span>     {</span><br><span>      =
   printf(&quot;\nAvailable Elliptic curves/groups:\n&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (n =3D 0; n &lt; crv_le=
n; n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(size_t n =3D 0; n &lt; crv_len; n++)</span><br><span>         {</span><br>=
<span>             const char *sname;</span><br><span>             sname =
=3D OBJ_nid2sn(curves[n]=2Enid);</span><br><span>diff --git a/src/openvpn/w=
in32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index ca08ead=2E=2Eade7ec0=
 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/s=
rc/openvpn/win32=2Ec</span><br><span>@@ -1293,9 +1293,6 @@</span><br><span>=
     is_wow64_process2_t is_wow64_process2 =3D</span><br><span>         (is=
_wow64_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=2Edll&quot;=
), &quot;IsWow64Process2&quot;);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    USHORT process_machine =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    USHORT native_machine =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifde=
f _ARM64_</span><br><span>     *process_arch =3D ARCH_ARM64;</span><br><spa=
n> #elif defined(_WIN64)</span><br><span>@@ -1303,6 +1300,8 @@</span><br><s=
pan>     if (is_wow64_process2)</span><br><span>     {</span><br><span>    =
     /* this could be amd64 on arm64 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        USHORT process_machine =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        USHORT native_machine =3D 0;<=
/span><br><span>         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProc=
ess(), &amp;process_machine, &amp;native_machine);</span><br><span>        =
 if (is_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)</s=
pan><br><span>         {</span><br><span>@@ -1315,6 +1314,8 @@</span><br><s=
pan>     if (is_wow64_process2)</span><br><span>     {</span><br><span>    =
     /* check if we&#39;re running on arm64 or amd64 machine */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        USHORT process_machine =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        USHOR=
T native_machine =3D 0;</span><br><span>         BOOL is_wow64 =3D is_wow64=
_process2(GetCurrentProcess(), &amp;process_machine, &amp;native_machine);<=
/span><br><span>         if (is_wow64)</span><br><span>         {</span><br=
><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/op=
envpnmsica=2Ec</span><br><span>index 9d12963=2E=2E95e457c 100644</span><br>=
<span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/ope=
nvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -711,7 +711,6 @@</span><br><s=
pan>         uiResult =3D MsiViewFetch(hViewST, &amp;hRecord);</span><br><s=
pan>         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uiRe=
sult =3D ERROR_SUCCESS;</span><br><span>             break;</span><br><span=
>         }</span><br><span>         else if (uiResult !=3D ERROR_SUCCESS)<=
/span><br><span>diff --git a/src/tapctl/tap=2Ec b/src/tapctl/tap=2Ec</span>=
<br><span>index 1d94988=2E=2Ecccc0e1 100644</span><br><span>--- a/src/tapct=
l/tap=2Ec</span><br><span>+++ b/src/tapctl/tap=2Ec</span><br><span>@@ -473,=
7 +473,7 @@</span><br><span>                         return ERROR_OUTOFMEMO=
RY;</span><br><span>                     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    dwCountExpResult=
 =3D ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    ExpandEnvir=
onmentStrings(szValue, szValueExp, dwCountExp);</span><br><span>           =
          free(szValue);</span><br><span>                     *pszValue =3D=
 szValueExp;</span><br><span>                     return ERROR_SUCCESS;</sp=
an><br><span>@@ -601,8 +601,6 @@</span><br><span>                         _=
In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,</span><br><=
span>                         _Out_ LPVOID *ppData)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D ERR=
OR_BAD_ARGUMENTS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (ppData =3D=3D NULL)</span><br><span>     {</span><br>=
<span>         return ERROR_BAD_ARGUMENTS;</span><br><span>@@ -628,7 +626,7=
 @@</span><br><span>     }</span><br><span>     else</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D =
GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    DWORD dwResult =3D GetLastError();</span><br><span>         if (dwResul=
t =3D=3D ERROR_INSUFFICIENT_BUFFER)</span><br><span>         {</span><br><s=
pan>             /* Allocate on heap and retry=2E */</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/tes=
t_ssl=2Ec</span><br><span>index 0e9cecf=2E=2Ec40845a 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -303,8 +303,6 @@</span><br=
><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;=
gc);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_gc(=
BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decrypt_=
workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</spa=
n><br><span> </span><br><span>     /* init work */</span><br><span>     ASS=
ERT(buf_init(&amp;work, frame=2Ebuf=2Eheadroom));</span><br><span>@@ -325,8=
 +323,8 @@</span><br><span>         ASSERT(rand_bytes(BPTR(&amp;src), BLEN(=
&amp;src)));</span><br><span> </span><br><span>         /* copy source to i=
nput buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D b=
uf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(=
buf_p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;s=
rc));</span><br><span> </span><br><span>@@ -356,7 +354,6 @@</span><br><span=
>     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame)=
, &amp;gc);</span><br><span>     struct buffer decrypt_workspace =3D alloc_=
buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer w=
ork =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</spa=
n><br><span>     struct buffer src =3D alloc_buf_gc(frame=2Ebuf=2Epayload_s=
ize, &amp;gc);</span><br><span>     void *buf_p;</span><br><span> </span><b=
r><span>@@ -371,7 +368,7 @@</span><br><span>     ASSERT(rand_bytes(BPTR(&am=
p;src), BLEN(&amp;src)));</span><br><span> </span><br><span>     /* copy so=
urce to input buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf =3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer buf =3D work;</span><br><span>     buf_p =3D buf_write_alloc=
(&amp;buf, BLENZ(&amp;src));</span><br><span>     ASSERT(buf_p);</span><br>=
<span>     memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span>=
@@ -652,7 +649,6 @@</span><br><span>     struct buffer work =3D alloc_buf_g=
c(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer encryp=
t_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><spa=
n>     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame=
), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t buffer buf =3D clear_buf();</span><br><span>     void *buf_p;</span><br><=
span> </span><br><span>     /* init work */</span><br><span>@@ -669,7 +665,=
7 @@</span><br><span>     ASSERT(buf_write(&amp;src, plaintext, strlen(plai=
ntext)));</span><br><span> </span><br><span>     /* copy source to input bu=
f */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D work;</span><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ=
(&amp;src));</span><br><span>     ASSERT(buf_p);</span><br><span>     memcp=
y(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
7?usp=3Demail">change 1617</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerr=
it-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--HtoQzCPj97A=--


--===============7593353528920783685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7593353528920783685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7593353528920783685==--

