Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82428606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mSJby1rK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dm9LPNh+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yr0cZDlk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c4VXhK4h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EE6iYlhO1a54416Fr71zRQ4m+DNTXeF4TGbGW+5bP78=; b=mSJby1rKXf/lr5ThLX6Vrrm16A
	4luoLRZ5ymnR+ZXY39VuIxVnt7SUcEGJbNNI0pOMhJ+bJ0uV/GjWgX2UMlnq+59y2Al7VwVO2Jzlk
	THxsAWgerkqkTBxIIh9ZMnYCBj0q2RgWBtMR8COnuzzsg4TP5WeSF9YVWkMtTcUPwZc4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOIEe-000000001qV-0Jte;
	Tue, 03 Nov 2026 17:23:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOIEb-000000001qL-0oJn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=di+JnXlJbUY/sevHB8KU22yS9sENs/W7+kd1MJ8yePQ=; b=dm9LPNh+F22WcBUMWhVnJsKLwo
 sDCRiIqmm8QGg/p8lEhKMP4URHpKLQbFGW7SLSdUPm8uLdE461AoyKhG9Wt2BlKQWou6NClLPukZ4
 5eaVa/Am7RwsMTDK+E8bapwDp5Cwf36W95FMKFAp14sGQVDdNWdQytbnOLbujOX0ve9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=di+JnXlJbUY/sevHB8KU22yS9sENs/W7+kd1MJ8yePQ=; b=Yr0cZDlktIGgJxiEPADvOl7Pp6
 NvvcLkbBOTn8WC8C9JVP+j0cxBmvYzQCOhjjawj1MfUtwI/fvffGfOSPy4V35GhTeSyH0p1UStYc6
 zNMUN/vEAUEGBqLqByaUJGj/IOYdM5suWBRTiA5y80EFV5GTnxymopLGNB0e0OsDwN6Y=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOIEY-0000000017P-0qpg for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:23:45 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so44161655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793726616; x=1794331416; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=di+JnXlJbUY/sevHB8KU22yS9sENs/W7+kd1MJ8yePQ=;
 b=c4VXhK4hkEbTsT0NB+fp8rfExFxGVfL/JkXPGXVN1PSg8wy7LNzF0EEUKEDWmLmL9q
 MkFUMl5Cu+cEUPch5r2av+AFC/asB5f1Y5i2wp4Aa0kofOWfniWoflMUziTkWmtGDR6t
 hvjUxYdPRoDjk5RWZsuiDPzRRQLCH6/3SfeYjpFdDPINQTa6PDXzuWgrAmybeB7zjAdO
 36/Zqbur22exCWcizOhZDoIMi0AVowtkJjIWLUtdTGI0zqLlAeno+5QVqwUWxxD6bqqV
 KmXkIcHMI23XlTsTgLxDky76U5OOI6cdhznPSP1twITXkV8LdFipIIgPIQfwNXA4AXBq
 Wziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726616; x=1794331416;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=di+JnXlJbUY/sevHB8KU22yS9sENs/W7+kd1MJ8yePQ=;
 b=KtjFAFIoCKsIX3WGLWuO0BZL6mULCukK7HRvsuikUcWGYRHq3FMP5FMRyPvTldaE8D
 g8i02lNBrD0xdoUdh2sm1Lv2UJvkMJ/pjnOhCi7024t4TVIzXLHzZpWWgiZUr8sxWlVW
 EWMwATcI6613mOVt4sV0WArjOxXLQ5equeAMqbH3pNpf6wKNHMWhx3vTzKNsns19qoe5
 9qWYPiBIOQMOivkS5Y5J35oxRU0YVNMq8aCDXxI2l2LiqLrBm/5L98QpkUAsiHyJg88t
 WM0gFdlI4+ly33DwSWdZwxqgOFrJCqs6YxuRBH9Z4myKU0R/6y1DtDjyGwIFoyccdjJh
 PkZQ==
X-Gm-Message-State: APuU4Z/KJm5iFa1RNVoQkSDHX0HPGQ+nuzctczrS3BPO5oVco7E6jBpQ
 G/IdTyfj2MTNbzxzU32LyUYry8pGxumK644ZMpc5SNNtMRZqq9vOtsTPgTHIge/vNWejEXVoPTZ
 +PCvLO9+7fxfF60iGXkl4veGVqGUUittds0ongaNjQxslZK5aJw3mhRAGMPdeMrmTGjRH
X-Gm-Gg: AYBFou07W6DcCy8a4spOwnOeDqds6e3j5hoUxOJ94pMWB7pvi5fji2I1Co0dLiq30rY
 yezfJfaOTr1hfL7sFS4ZSUtdHTH2Ym50zRPnp6wIAvmHP9WD+ZaLwrRxyIny46qIBYM7JgwPV0D
 ahEGa3l7qtS96eoZSFfSnM69ty5S3KO2oNu/pJSkGqdfmHauYuWLN1zQVHDgDEOGONkDwSG6n9R
 xngiD1kJmaGwyGMYQhvhErRYVcH9TtWQtaR9Jo6h1Pv/H4jgDX6QJwPGB4mYK+KgKQaHL0XE2g/
 jPr0hFV0omMFmnKsjjsmTocy/TmMdF/fKAugeNeHGxAkSn5vhgYAtRMVNEqZf0iCUmA+AhBwzy7
 qYfT2/azGUukdJ4Ft8rt+OCiV6GjYbSSwA9df2bh+0HMuZ+mGgZUPY19R7VpzTnlvOSYIkbxiip
 Bms4fWAAJ48tWnmubklCbc7wP+k6rwpM1lE4qE9DTuyCcfr3FzF4MXjP4gFuOr2z6Xo/narFi8U
 yJxwDLvzrP0GxIXXIpPW3QkndouSP42xAIaOrmxGLjN7pZl/BPA0l0Gg9qyKTGSsqOrZQnYFrF+
 KUhoKwtA5nUiqsotiS+IPvc6A6Mwj1pY4A9BPkC0mtpEwE4xJLcEUell5ZodPN7flzkJVVxb5xK
 IVDrHFvqG2bBotZphm0drAEGR+UkgkaVfCEDxuuhiJrWcSFd+ElOoFUZn7BXl5m11zWuVoudA4Q
 bK6Y0LyCsZUStEdBcrty8fzav1hWEpzQ6zJnJK
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4ac1913ef8fmr327836125e9.27.1793726615269; 
 Tue, 03 Nov 2026 09:23:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm79878455e9.4.2026.11.03.09.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:23:34 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:23:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie6c1fa663978eedca2391f1250129bc46738faa0
X-Gerrit-Change-Number: 2098
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2098?usp=email>
X-Gerrit-Commit: 32b071e67433ea69781d5af3023ac65e533171d7
In-Reply-To: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
References: <gerrit.1793686618000.Ie6c1fa663978eedca2391f1250129bc46738faa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2NjE4MDAwLkllNmMxZmE2NjM5NzhlZWRjYTIzOTFmMTI1MDEyOWJjNDY3MzhmYWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4a6813e4f33a726e3cb2d5952f1b283e7e10e5d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOIEY-0000000017P-0qpg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused local
 variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0505918898783404516=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0505918898783404516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sJCvKuz0+cU="; charset=UTF-8

--sJCvKuz0+cU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2098?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: Remove unused local =
variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

R=
emove unused local variables

- tls_session_generate_dynamic_tls_crypt_key(=
): kds
- socks_proxy_recv_char(): reads fd_set
- verify_cert_call_command()=
: gc
- man_dispatch_command(): gc, the unused nparms parameter and the
  do=
ne label, which only served gc_free()

Change-Id: Ie6c1fa663978eedca2391f12=
50129bc46738faa0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ack=
ed-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2098
Message-Id: <20261103123306=2E3866-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261=
103123306=2E3866-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
M src/openvpn/socks=2Ec
=
M src/openvpn/ssl_verify=2Ec
M src/openvpn/tls_crypt=2Ec
4 files changed, 2=
 insertions(+), 18 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/98/2098/3

diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index 987af2da=2E=2E58f63e6 100644
--- a/src/openvpn=
/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -1532,16 +1532,12 @@
 }
 
 stat=
ic void
-man_dispatch_command(struct management *man, struct status_output =
*so, const char **p,
-                     const int nparms)
+man_dispatch_=
command(struct management *man, struct status_output *so, const char **p)
 =
{
-    struct gc_arena gc =3D gc_new();
-
     ASSERT(p[0]);
     if (streq=
(p[0], "exit") || streq(p[0], "quit"))
     {
         man->connection=2Eha=
lt =3D true;
-        goto done;
     }
     else if (streq(p[0], "help"))
=
     {
@@ -1906,9 +1902,6 @@
     {
         msg(M_CLIENT, "ERROR: unknown =
command [%s], enter 'help' for more options", p[0]);
     }
-
-done:
-    g=
c_free(&gc);
 }
 
 #ifdef _WIN32
@@ -2315,7 +2308,7 @@
 
         if (nparm=
s > 0)
         {
-            man_dispatch_command(man, so, (const char **=
)parms, nparms);
+            man_dispatch_command(man, so, (const char **)=
parms);
         }
     }
 
diff --git a/src/openvpn/socks=2Ec b/src/openvp=
n/socks=2Ec
index cab9af6=2E=2Ea8c9fd3 100644
--- a/src/openvpn/socks=2Ec
+=
++ b/src/openvpn/socks=2Ec
@@ -86,10 +86,6 @@
                       const =
struct event_timeout *server_poll_timeout,
                       volatile =
int *signal_received)
 {
-    fd_set reads;
-    FD_ZERO(&reads);
-    open=
vpn_fd_set(sd, &reads);
-
     struct timeval tv;
     tv=2Etv_sec =3D get_=
server_poll_remaining_time(server_poll_timeout);
     tv=2Etv_usec =3D 0;
d=
iff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 7=
baa4fc=2E=2E0cdec1e 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openv=
pn/ssl_verify=2Ec
@@ -515,7 +515,6 @@
                          char *subje=
ct)
 {
     int ret;
-    struct gc_arena gc =3D gc_new();
     struct argv=
 argv =3D argv_new();
 
     setenv_str(es, "script_type", "tls-verify");
@=
@ -526,7 +525,6 @@
     argv_msg_prefix(D_TLS_DEBUG, &argv, "TLS: executing=
 verify command");
     ret =3D openvpn_run_script(&argv, es, 0, "--tls-ver=
ify script");
 
-    gc_free(&gc);
     argv_free(&argv);
 
     if (ret)
d=
iff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c=
7975=2E=2E447262c 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/=
tls_crypt=2Ec
@@ -121,9 +121,6 @@
 
     const int key_direction =3D sessio=
n->opt->server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
-    struc=
t key_direction_state kds;
-    key_direction_state_init(&kds, key_directio=
n);
-
     struct key_type kt =3D tls_crypt_kt();
 
     init_key_ctx_bi(&s=
ession->tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &rengokeys, key_direction, &kt,
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie6c1fa663978ee=
dca2391f1250129bc46738faa0
Gerrit-Change-Number: 2098
Gerrit-PatchSet: 3
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--sJCvKuz0+cU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2098?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Remove unused local variables<br><br>- tls_session_generate_dynamic_tls=
_crypt_key(): kds<br>- socks_proxy_recv_char(): reads fd_set<br>- verify_ce=
rt_call_command(): gc<br>- man_dispatch_command(): gc, the unused nparms pa=
rameter and the<br>  done label, which only served gc_free()<br><br>Change-=
Id: Ie6c1fa663978eedca2391f1250129bc46738faa0<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2098<br>Message-Id: &lt;20261103123306=2E3866-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261103123306=2E3=
866-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/socks=
=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>4 fi=
les changed, 2 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/2098/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><b=
r><span>index 987af2da=2E=2E58f63e6 100644</span><br><span>--- a/src/openvp=
n/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@=
@ -1532,16 +1532,12 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_disp=
atch_command(struct management *man, struct status_output *so, const char *=
*p,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
   const int nparms)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+man_dispatch_command(struct management *man, struct status_output *so, con=
st char **p)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(p[0]);</span><br><spa=
n>     if (streq(p[0], &quot;exit&quot;) || streq(p[0], &quot;quit&quot;))<=
/span><br><span>     {</span><br><span>         man-&gt;connection=2Ehalt =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto=
 done;</span><br><span>     }</span><br><span>     else if (streq(p[0], &qu=
ot;help&quot;))</span><br><span>     {</span><br><span>@@ -1906,9 +1902,6 @=
@</span><br><span>     {</span><br><span>         msg(M_CLIENT, &quot;ERROR=
: unknown command [%s], enter &#39;help&#39; for more options&quot;, p[0]);=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>@@ -=
2315,7 +2308,7 @@</span><br><span> </span><br><span>         if (nparms &gt=
; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            man_dispatch_command(man, so, (const char **)parms, n=
parms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
man_dispatch_command(man, so, (const char **)parms);</span><br><span>      =
   }</span><br><span>     }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index cab9af6=
=2E=2Ea8c9fd3 100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br>=
<span>+++ b/src/openvpn/socks=2Ec</span><br><span>@@ -86,10 +86,6 @@</span>=
<br><span>                       const struct event_timeout *server_poll_ti=
meout,</span><br><span>                       volatile int *signal_received=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   fd_set reads;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    F=
D_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     struct timeval tv;</span><br><span>     t=
v=2Etv_sec =3D get_server_poll_remaining_time(server_poll_timeout);</span><=
br><span>     tv=2Etv_usec =3D 0;</span><br><span>diff --git a/src/openvpn/=
ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 7baa4fc=
=2E=2E0cdec1e 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -515,7 +515,=
6 @@</span><br><span>                          char *subject)</span><br><sp=
an> {</span><br><span>     int ret;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     str=
uct argv argv =3D argv_new();</span><br><span> </span><br><span>     setenv=
_str(es, &quot;script_type&quot;, &quot;tls-verify&quot;);</span><br><span>=
@@ -526,7 +525,6 @@</span><br><span>     argv_msg_prefix(D_TLS_DEBUG, &amp;=
argv, &quot;TLS: executing verify command&quot;);</span><br><span>     ret =
=3D openvpn_run_script(&amp;argv, es, 0, &quot;--tls-verify script&quot;);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span>     argv_free(&amp;argv);</span><br><spa=
n> </span><br><span>     if (ret)</span><br><span>diff --git a/src/openvpn/=
tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 23c7975=2E=
=2E447262c 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br=
><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -121,9 +121,6 @@<=
/span><br><span> </span><br><span>     const int key_direction =3D session-=
&gt;opt-&gt;server ? KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct k=
ey_direction_state kds;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    key_direction_state_init(&amp;kds, key_direction);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct key_type kt=
 =3D tls_crypt_kt();</span><br><span> </span><br><span>     init_key_ctx_bi=
(&amp;session-&gt;tls_wrap_reneg=2Eopt=2Ekey_ctx_bi, &amp;rengokeys, key_di=
rection, &amp;kt,</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail">change 2098</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2098?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie6c1fa663978=
eedca2391f1250129bc46738faa0 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2098 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--sJCvKuz0+cU=--


--===============0505918898783404516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0505918898783404516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0505918898783404516==--

