Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBF8CC6B0F
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=HdBIrkQYQJYBzVoAk7bfCaWWmwuIrrHqvfiGqhLlST0=; b=VacKrwhkeaq7gY
	oDHNXFFrfEbMTOvCbDV3/Azi2fhpoJS9frhzRuGYr4FwPJJrhgAym2mj40KK2ZWejvqa647QSq7EK
	4sUC+upOgs9kAkhADGPRkZNUhyYb0f+7gHDjQrcyczoPqbEbt+L8bnESfW1zTY4aUVN3/a5UBdJ5j
	Jt0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGZNr-0006F1-Hp;
	Tue, 13 Oct 2026 10:05:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGZNk-0006Eo-UA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6C/OtYHgQylY+NUfQ7VhjlhmGCz1IhVaATLtdxNzdX0=; b=hfOM8W3HSHB5+VYLAwP8bzYIDR
 3xLrs7yYqBwsbdHC5Nkxnr6fOSPwHX67hW7b0yxPZ8PXsDxGFs0U11L9A62t02YC6jZgv9yeqAHcI
 soVkx8M/SOHY6Nisoqd6+oF7DdO2dDDNnHa9FaJwv4rxds7IzN/9SuvrzYQYgUerjTHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6C/OtYHgQylY+NUfQ7VhjlhmGCz1IhVaATLtdxNzdX0=; b=G
 PIPlGSTz4+7/JSnmnJhIM6nVhjgpmOC0IA862tXC1l3yCXSowI+i7GVkWvnOX9q/E8qNfAkWc7wB2
 GQSaD29ME0qszm+V2wZqS/C3XruDr8IIWwnV8LXlTSz02+aPzykWrlsbS7WcGsUSEj5YPRFNpl3Xp
 cHtMjqXvMpSWiARo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGZNd-00073H-TR for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:05:14 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso19363305e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791885903; x=1792490703; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6C/OtYHgQylY+NUfQ7VhjlhmGCz1IhVaATLtdxNzdX0=;
 b=WkYDNT+2HRe/Tl6JRJAjEcY2oiYevmu2/w8+JIOaE+QNOg42+wwh+EPbYDs5P1kszx
 q84xJMkNVdnWIpFbaIDacabcxMNvrE4YqqTISV2BGwbHO37DUxpGO0tMO9xR/LR6B5ww
 GfKFTScomIooFkKYahBxrlREIHdb/NXfFdwZSGUshXn8b+OHBHX0yxklsLuO7YM2cIjC
 /ZVhN8D1UWpX2F35cZmWgNGcESzoan8A+oorv9M5Yv7Gfo4b1Z9yoPjyBDTd8vxvmVnp
 lpvrH5gtH/YiQgVJNMxd1s7btzQKZufQg6ktTnI0Rhc0FF2G/cG8cGhUGgXLezV255PD
 rVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791885903; x=1792490703;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6C/OtYHgQylY+NUfQ7VhjlhmGCz1IhVaATLtdxNzdX0=;
 b=YYcRkBBqxXdBRFkk/J2QNsKxPm4aZcPlxKyLNq4j3oG/lDxOpyDMFC25wP+G/9LbkX
 3JPdZPlYGLsS41OuOS1JLN0z++/dyYrbZrzOo4scsl6GIyxVkTFisJ19b9XigVBXcld3
 eLOz8yH6FcDrSpZl8FNfJLLjoGa9Q6TGqlpqpOv1pu22U4DUMcsKewMLRcRoIfYUZvaV
 D6svBqmtJgEXbDiznvfgLKOC5dNpKb46HnRv7jhTu7RkaoNlJaYMUm7+JwhtJCyvqeIA
 kMppdELhuMKekYDUAeBQx2k6nbgifGA7SV9xLv6hbK8GaNWw3cn1ukMEjR/qqgFZOfoy
 MtDg==
X-Gm-Message-State: AFq9FYKlG8zw+c93zO22G97BZAnYYG4yPj4j1rMNw/+c1KYr5n6gaPg0
 dQGmNSwufS/BcRwmxtNsuCimSiesO9Vt8JyRHhNQCriWqqP27sFklpNQ/BqtqliplzaDHTYfcli
 Rh050O56Vh8VrJDHaYwSmbl3xgvx9UOby31+iy+ty70Ngg2734NonJYlA6/udnSk3g6/aHcCh+S
 Mha13XgQ==
X-Gm-Gg: AYBFou2rq26jS4yZotrNGJ7myCev+TQnjrYXGvmgEhGdYpShmRocf6cbGZIJ6BWvsvf
 MyEOedRVh4JZO8U4IBEKT3Tvs9FLLzP957YtQ45vgGeaqUVlZY+HeOnVcA2BfnRaMu3Xi1NaOm8
 ERTyYPE833f2gYrNkTUAaFq79QyA1GG3P7xZ7EKOB1suGiC8GbzeNGP/IqO/RlCs4PPktKWb0/q
 ghB8LZcN5CHq1wftC/7/kH//sEP105fvP+K8UnwTPZ0e9v5m7/OKJGuh4df76NyA2rlAFz9Zrai
 8eJLqj8AqunkwyQxvDChUM8nNNYaQIS4szhvby9IJ9xVeqdVmqltKgXy5rnlNMMY95AFynK+hH6
 BV3oKGcRYio5QheSyu8UdlJIFWrONosUJ6sLsOHbtGRmBtabmeDtpxQQ4I04lcwockIId2jBidW
 MzK16tb8Gobt0QQj5bsZyY4OVIUB3BfLyiKJW0lnFi2nThYTt9kIUtVgPXDy4Ou2zZOo5rHOqx4
 DNt+xwh45fDm0ghYUu2fX4e32fFgQQYVkiPLtmS0KIphFad2l45it73jNvHhMiXUQ3jfYF3jl0A
 L50/AFoZW/xtX0okt3QCrfQJjIQAH9I/5MOc8wtW0LjNrF1bZxzI25owA4iT
X-Received: by 2002:a05:600c:c0c6:b0:4a1:96cd:2f6b with SMTP id
 5b1f17b1804b1-4a196cd31fbmr135524265e9.2.1791885902934; 
 Tue, 13 Oct 2026 03:05:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de2e2ef2fsm2839654f8f.59.2026.10.13.03.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:05:02 -0700 (PDT)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 10:05:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3462aace1b37c5b37c0106b5fdd2e8d2d2543147-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGZNd-00073H-TR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2782158269154135644=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2782158269154135644==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D+p3SVaBadk="; charset=UTF-8

--D+p3SVaBadk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1991?usp=3Demail

to review the following change=2E
=


Change subject: dco_linux: enable RPS on newly created DCO interfaces
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: enabl=
e RPS on newly created DCO interfaces

When multiple TCP streams share an O=
penVPN tunnel, their ACKs arrive
through the same outer flow and can be pro=
cessed on a single NIC RX CPU=2E
Delivering the decrypted ACKs can also dra=
in TCP transmit queues inline,
concentrating receive processing, transmissi=
on and crypto work on that
CPU despite the parallelism available between in=
ner flows=2E

Enable Receive Packet Steering (RPS) on newly created DCO int=
erfaces to
distribute inner flow processing across CPUs, after decryption=
=2E Build a
mask covering all possible CPU IDs and let the kernel filter ou=
t offline
CPUs=2E

Leave pre-existing interfaces and nonzero RPS masks unch=
anged, including
masks inherited from net=2Ecore=2Erps_default_mask=2E Fail=
ure to configure RPS
is nonfatal=2E

Tested on a Ryzen 9 9950X with Fedora'=
s stock ovpn module from kernel
7=2E2=2E5-200=2Efc44=2Ex86_64 and two Conne=
ctX-4 Lx ports were cabled at 25
Gb/s, The tunnel used IPv4/UDP, AES-256-GC=
M and MTU 1448=2E Values are
medians across three 20 seconds iperf3 runs, a=
fter a 3-second warmup:

flows    RPS off     RPS on      change
  1       =
  9=2E01      12=2E06      +33=2E9%
  4         9=2E41      16=2E90      +7=
9=2E6%

At four streams, the sender NIC IRQ CPU's average softirq utilizati=
on
was 98=2E7-99=2E5% off and 4=2E7-47=2E2% on=2E

Change-Id: I97c55e211f91=
13d090808724ab43cb3c94099fb0
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom=
>
---
M README=2Edco=2Emd
M src/openvpn/dco_linux=2Ec
2 files changed, 154 =
insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/91/1991/1

diff --git a/README=2Edco=2Emd b/README=
=2Edco=2Emd
index a93dc94=2E=2E47c4ae3 100644
--- a/README=2Edco=2Emd
+++ b=
/README=2Edco=2Emd
@@ -52,6 +52,11 @@
 
 in your log=2E
 
+On Linux, OpenVP=
N enables Receive Packet Steering (RPS) on DCO interfaces it
+creates, dist=
ributing inner-flow processing across online CPUs=2E Existing
+nonzero RPS =
masks, including masks inherited from `net=2Ecore=2Erps_default_mask`,
+are=
 preserved=2E
+
 
 Getting started (Windows)
 -------------------------
dif=
f --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index e6e12=
b4=2E=2E66543b9 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dc=
o_linux=2Ec
@@ -33,6 +33,7 @@
 #include "buffer=2Eh"
 #include "networking=
=2Eh"
 #include "openvpn=2Eh"
+#include "options_util=2Eh"
 
 #include "soc=
ket=2Eh"
 #include "tun=2Eh"
@@ -553,6 +554,149 @@
     return "unknown";
 =
}
 
+/**
+ * Build an RPS mask covering all possible CPU IDs=2E The kernel =
filters out
+ * offline CPUs when installing the mask, so only the last ID =
in the sorted
+ * sysfs CPU list is needed, even when the list has gaps=2E
=
+ * Removes the trailing newline from cpus before parsing the last ID=2E
+ =
*/
+static bool
+ovpn_rps_mask_full(char *cpus, struct buffer *mask)
+{
+  =
  /* the cpus string contains range formats like "0-31" or "0-15,32-47" */
=
+    size_t len =3D strspn(cpus, "0123456789,-");
+    if (!len || cpus[len=
] !=3D '\n' || cpus[len + 1] !=3D '\0')
+    {
+        return false;
+    =
}
+
+    /* find the last separator (either '-' or ',') */
+    const char =
*last =3D cpus + len;
+    while (last > cpus && last[-1] >=3D '0' && last[=
-1] <=3D '9')
+    {
+        --last;
+    }
+    if (last =3D=3D cpus + le=
n)
+    {
+        return false;
+    }
+
+    cpus[len] =3D '\0';
+    int=
 last_cpu;
+    if (!atoi_constrained(last, &last_cpu, "last possible CPU",=
 0, INT_MAX, M_WARN))
+    {
+        return false;
+    }
+
+    /* the mo=
st significant group may contain fewer than 32 bits */
+    unsigned int wo=
rd =3D UINT32_MAX >> (31 - last_cpu % 32);
+    /* first handle the most si=
gnificant, potentially partial group */
+    if (!buf_printf(mask, "%x", wo=
rd))
+    {
+        return false;
+    }
+    /* then write the other chun=
ks, comma-separated as required by bitmap_parse
+     * in linux/lib/bitmap=
-str=2Ec
+     */
+    for (int i =3D last_cpu / 32; i > 0; --i)
+    {
+  =
      if (!buf_printf(mask, ",ffffffff"))
+        {
+            return fa=
lse;
+        }
+    }
+    return buf_printf(mask, "\n");
+}
+
+static voi=
d
+ovpn_enable_rps(const char *dev)
+{
+    char rps_path[PATH_MAX];
+    /=
* ovpn interfaces have a single RX queue */
+    if (!checked_snprintf(rps_=
path, sizeof(rps_path),
+                          "/sys/class/net/%s/queue=
s/rx-0/rps_cpus", dev))
+    {
+        msg(M_WARN, "DCO: cannot build RPS =
path for %s", dev);
+        return;
+    }
+
+    struct gc_arena gc =3D g=
c_new();
+    struct buffer current =3D buffer_read_from_file(rps_path, &gc=
);
+    /* buffer_read_from_file counts the terminating NUL as content */
+=
    buf_rmtail(&current, '\0');
+    if (!buf_defined(&current) || BLEN(&cu=
rrent) < 2 || *BLAST(&current) !=3D '\n')
+    {
+        /* RPS may be una=
vailable, for example with CONFIG_RPS disabled */
+        msg(D_DCO_DEBUG,=
 "DCO: cannot read RPS mask from %s", rps_path);
+        goto out;
+    }
=
+    if (strspn(BSTR(&current), "0,") !=3D (size_t)BLEN(&current) - 1)
+   =
 {
+        /* new devices can still inherit an administrator's rps_default=
_mask */
+        msg(D_DCO_DEBUG, "DCO: preserving existing RPS mask in %s=
: %=2E*s", rps_path,
+            BLEN(&current) - 1, BSTR(&current));
+   =
     goto out;
+    }
+
+    const char *cpus_path =3D "/sys/devices/system=
/cpu/possible";
+    struct buffer cpus =3D buffer_read_from_file(cpus_path=
, &gc);
+    if (!buf_defined(&cpus))
+    {
+        msg(M_WARN, "DCO: can=
not read possible CPUs from %s", cpus_path);
+        goto out;
+    }
+
+ =
   /* a sysfs attribute must fit in one page and be written in one call
+  =
   * (docs=2Ekernel=2Eorg/filesystems/sysfs=2Ehtml#reading-writing-attribut=
e-data)
+     */
+    long page_size =3D sysconf(_SC_PAGESIZE);
+    if (pa=
ge_size <=3D 0 || page_size > INT_MAX)
+    {
+        msg(M_WARN, "DCO: ca=
nnot determine page size for RPS configuration");
+        goto out;
+    }=

+    struct buffer mask =3D alloc_buf_gc((size_t)page_size, &gc);
+    if =
(!ovpn_rps_mask_full(BSTR(&cpus), &mask))
+    {
+        msg(M_WARN, "DCO:=
 cannot build RPS mask from %s", cpus_path);
+        goto out;
+    }
+
+ =
   int fd =3D open(rps_path, O_WRONLY);
+    if (fd < 0)
+    {
+        ms=
g(M_WARN | M_ERRNO, "DCO: cannot open %s for enabling RPS", rps_path);
+   =
     goto out;
+    }
+    /* submit the complete mask in one write and ret=
ry only on interruption */
+    ssize_t written;
+    do
+    {
+        wr=
itten =3D write(fd, BPTR(&mask), (size_t)BLEN(&mask));
+    } while (writte=
n < 0 && errno =3D=3D EINTR);
+
+    if (written < 0)
+    {
+        msg(M=
_WARN | M_ERRNO, "DCO: cannot enable RPS on %s", dev);
+    }
+    else if =
(written !=3D BLEN(&mask))
+    {
+        msg(M_WARN, "DCO: incomplete RPS=
 mask write to %s", rps_path);
+    }
+    else
+    {
+        msg(D_DCO, =
"DCO: RPS enabled on %s with CPU mask %=2E*s", dev, BLEN(&mask) - 1,
+     =
       BSTR(&mask));
+    }
+    if (close(fd) < 0)
+    {
+        msg(M_W=
ARN | M_ERRNO, "DCO: cannot close %s", rps_path);
+    }
+
+out:
+    gc_fr=
ee(&gc);
+}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx,=
 const char *dev)
 {
@@ -584,6 +728,11 @@
             return -EINVAL;
    =
     }
     }
+    /* configure RPS on the device only if it was not pre-cr=
eated */
+    if (ret =3D=3D 0)
+    {
+        ovpn_enable_rps(dev);
+    =
}
 
     tt->dco=2Eifindex =3D if_nametoindex(dev);
     if (!tt->dco=2Eifi=
ndex)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f=
9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: =
1
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--D+p3SVaBadk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici would like Arne Sch=
wabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">dco_linux: enable RPS on newly created DCO interfaces<br><br>When =
multiple TCP streams share an OpenVPN tunnel, their ACKs arrive<br>through =
the same outer flow and can be processed on a single NIC RX CPU=2E<br>Deliv=
ering the decrypted ACKs can also drain TCP transmit queues inline,<br>conc=
entrating receive processing, transmission and crypto work on that<br>CPU d=
espite the parallelism available between inner flows=2E<br><br>Enable Recei=
ve Packet Steering (RPS) on newly created DCO interfaces to<br>distribute i=
nner flow processing across CPUs, after decryption=2E Build a<br>mask cover=
ing all possible CPU IDs and let the kernel filter out offline<br>CPUs=2E<b=
r><br>Leave pre-existing interfaces and nonzero RPS masks unchanged, includ=
ing<br>masks inherited from net=2Ecore=2Erps_default_mask=2E Failure to con=
figure RPS<br>is nonfatal=2E<br><br>Tested on a Ryzen 9 9950X with Fedora&#=
39;s stock ovpn module from kernel<br>7=2E2=2E5-200=2Efc44=2Ex86_64 and two=
 ConnectX-4 Lx ports were cabled at 25<br>Gb/s, The tunnel used IPv4/UDP, A=
ES-256-GCM and MTU 1448=2E Values are<br>medians across three 20 seconds ip=
erf3 runs, after a 3-second warmup:<br><br>flows    RPS off     RPS on     =
 change<br>  1         9=2E01      12=2E06      +33=2E9%<br>  4         9=
=2E41      16=2E90      +79=2E6%<br><br>At four streams, the sender NIC IRQ=
 CPU&#39;s average softirq utilization<br>was 98=2E7-99=2E5% off and 4=2E7-=
47=2E2% on=2E<br><br>Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0<b=
r>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M README=
=2Edco=2Emd<br>M src/openvpn/dco_linux=2Ec<br>2 files changed, 154 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/91/1991/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/READM=
E=2Edco=2Emd b/README=2Edco=2Emd</span><br><span>index a93dc94=2E=2E47c4ae3=
 100644</span><br><span>--- a/README=2Edco=2Emd</span><br><span>+++ b/READM=
E=2Edco=2Emd</span><br><span>@@ -52,6 +52,11 @@</span><br><span> </span><br=
><span> in your log=2E</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+On Linux, OpenVPN enables Receive Packet Steering (RPS=
) on DCO interfaces it</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+creates, distributing inner-flow processing across online CPUs=2E Existi=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nonzero RPS masks=
, including masks inherited from `net=2Ecore=2Erps_default_mask`,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+are preserved=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><sp=
an> Getting started (Windows)</span><br><span> -------------------------</s=
pan><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linu=
x=2Ec</span><br><span>index e6e12b4=2E=2E66543b9 100644</span><br><span>---=
 a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2E=
c</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span> #include &quot;networking=2Eh&quot;</span><br><=
span> #include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;socket=2Eh&quot;</span><br><span> #include =
&quot;tun=2Eh&quot;</span><br><span>@@ -553,6 +554,149 @@</span><br><span> =
    return &quot;unknown&quot;;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Build an RPS mask covering all possibl=
e CPU IDs=2E The kernel filters out</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * offline CPUs when installing the mask, so only the last =
ID in the sorted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
sysfs CPU list is needed, even when the list has gaps=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Removes the trailing newline from c=
pus before parsing the last ID=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_rps_m=
ask_full(char *cpus, struct buffer *mask)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* the cpus string contains range formats like &quot;0-31&quot; or =
&quot;0-15,32-47&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    size_t len =3D strspn(cpus, &quot;0123456789,-&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!len || cpus[len] !=3D=
 &#39;\n&#39; || cpus[len + 1] !=3D &#39;\0&#39;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* find the=
 last separator (either &#39;-&#39; or &#39;,&#39;) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *last =3D cpus + len;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (last &gt; cp=
us &amp;&amp; last[-1] &gt;=3D &#39;0&#39; &amp;&amp; last[-1] &lt;=3D &#39=
;9&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        --last;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (last =3D=3D cpus + len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    cpus[len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int last_cpu;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!atoi_constrained(last, &amp;last_cpu, &quot;last poss=
ible CPU&quot;, 0, INT_MAX, M_WARN))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* the most significant =
group may contain fewer than 32 bits */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int word =3D UINT32_MAX &gt;&gt; (31 - las=
t_cpu % 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
first handle the most significant, potentially partial group */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_printf(mask, &quot=
;%x&quot;, word))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* then write the other =
chunks, comma-separated as required by bitmap_parse</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * in linux/lib/bitmap-str=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D last_cpu / 32; i &g=
t; 0; --i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!buf_printf=
(mask, &quot;,ffffffff&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_pr=
intf(mask, &quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_enable_rps(const char *dev)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char rps_path[PATH_MAX];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* ovpn interfaces have a si=
ngle RX queue */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!checked_snprintf(rps_path, sizeof(rps_path),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          &quot;/sys/class/n=
et/%s/queues/rx-0/rps_cpus&quot;, dev))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_WARN, &quot;DCO: cannot build RPS path for %s&quot;, de=
v);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer current =3D buffer=
_read_from_file(rps_path, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* buffer_read_from_file counts the terminating NUL as =
content */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_r=
mtail(&amp;current, &#39;\0&#39;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!buf_defined(&amp;current) || BLEN(&amp;current) &lt=
; 2 || *BLAST(&amp;current) !=3D &#39;\n&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* RPS may be unavailable, for example with CONFIG_RPS=
 disabled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_DCO_DEBUG, &quot;DCO: cannot read RPS mask from %s&quot;, rps_path);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (strspn(BSTR(&amp;current), =
&quot;0,&quot;) !=3D (size_t)BLEN(&amp;current) - 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* new devices can still inherit an administrat=
or&#39;s rps_default_mask */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_DCO_DEBUG, &quot;DCO: preserving existing RPS mask i=
n %s: %=2E*s&quot;, rps_path,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            BLEN(&amp;current) - 1, BSTR(&amp;current));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *cpus_path =3D &quot;/sys/devices/system/cpu/pos=
sible&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer cpus =3D buffer_read_from_file(cpus_path, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_defined(&amp;cpus))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DCO: ca=
nnot read possible CPUs from %s&quot;, cpus_path);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* a sysfs attribute must fit in one page and be written in one call</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * (docs=2Ekernel=2Eor=
g/filesystems/sysfs=2Ehtml#reading-writing-attribute-data)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    long page_size =3D sysconf(_SC_PAGESIZE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (page_size &lt;=
=3D 0 || page_size &gt; INT_MAX)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_WARN, &quot;DCO: cannot determine page size for RPS configurat=
ion&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer mask =
=3D alloc_buf_gc((size_t)page_size, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!ovpn_rps_mask_full(BSTR(&amp;cpus), &amp=
;mask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
DCO: cannot build RPS mask from %s&quot;, cpus_path);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int fd =3D open(rps_path, O_WRONLY);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (fd &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_WARN | M_ERRNO, &quot;DCO: cannot open %s for enabling=
 RPS&quot;, rps_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* submit=
 the complete mask in one write and retry only on interruption */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t written;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        written =3D write(fd, BPTR(&amp;mask), (size_t)=
BLEN(&amp;mask));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  } while (written &lt; 0 &amp;&amp; errno =3D=3D EINTR);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (written &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN | M_ERRNO, &quot;DCO: cannot enable RPS on %s&q=
uot;, dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (written !=
=3D BLEN(&amp;mask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;DCO: incomplete RPS mask write to %s&quot;, rps_path);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_DCO, &quot;DCO: RPS enabled on %s with CPU mask %=2E=
*s&quot;, dev, BLEN(&amp;mask) - 1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            BSTR(&amp;mask));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (close(fd) &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_WARN | M_ERRNO, &quot;DCO: cannot close %s&quot;, rps_pat=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> int</span><br><span> open_tun_dco(struct tuntap *tt, openvpn_n=
et_ctx_t *ctx, const char *dev)</span><br><span> {</span><br><span>@@ -584,=
6 +728,11 @@</span><br><span>             return -EINVAL;</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* configure RPS on the device only if it was not pre-crea=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ovpn_enable_rps(=
dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span>     tt-&gt;dco=2Eifindex =3D if_nametoindex(dev)=
;</span><br><span>     if (!tt-&gt;dco=2Eifindex)</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3De=
mail">change 1991</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--D+p3SVaBadk=--


--===============2782158269154135644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2782158269154135644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2782158269154135644==--

