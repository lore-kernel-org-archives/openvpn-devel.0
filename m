Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67A606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a+o9npiS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QO+DmwM2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kNZx0HRk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DnvYCr+v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jXh58HFKY19ve4JqA2r7AseqT8myoHK5Vo4qyZfosb8=; b=a+o9npiSed6c2fqvtL+blszagT
	usLWLhgZ+2i52jO+vGLk/cKR2m/5VGFyb47Vlx7Q2t2rddOFlP/5mBPaSW/m2gvqTMIKFBwLy9Xvc
	7YH2PDW47nZ8VeTkM36oa+H5aZqZ7U8aedejmhd9S7WTU1r9wJwfU3RdXJVDc/bbZ5yc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjuV-000000005Or-2sFM;
	Tue, 10 Nov 2026 11:21:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjuH-000000005Bl-1AMA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y9e6yF2zx9a5Fs/4py+T8ZMdbO3y11S/WHybEhfSy5Y=; b=QO+DmwM2VrB1iTAXDJOLlItN1+
 LkMmBzPcvISqBf99uFrL13Xq6/LZg7FDN5UKPDeaWHtXoMqvBKpKBczi7FlhadKoDvJvYY+jR7MNX
 DZntUdnD3pD/lyoaaO4jJsmj7LNtA+Iq8drv8uCXJiaPeXNVor/waBFwgKca+Xm+HSQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y9e6yF2zx9a5Fs/4py+T8ZMdbO3y11S/WHybEhfSy5Y=; b=kNZx0HRk/Wuui5ORL1U6dfKYT6
 C2pPL1A/R7cZKZ7eOUFKY66AyrjFcb/fsQLURB754iDBOR/fsYP9IErkU5ATYC9G/RPDwUTXnNgz8
 s43UCZxh8diuqWYnfu7E++FHXIUn3LOYNkgnHC9KmdDxC9v0Q3qkIx7QWRu/jPlUm2ts=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjuE-000000004BV-0zQp for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:20:53 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so19677775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794309644; x=1794914444; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y9e6yF2zx9a5Fs/4py+T8ZMdbO3y11S/WHybEhfSy5Y=;
 b=DnvYCr+vkxXSJ/PTN44NyQF4PFLC+BCSYgpeNQ8wyKK5NZvlTmuTYl2YNWtjFDv1xx
 ULEno+CreIxK1mYYy3eevUtzRFPpuCI58zHuG13ZOEZQcHuaaCRSYiktk0q5X/GqXKhZ
 FM8QsbKy3w4iT06XCPtprGOdO0mlyALse8+euG8uYCFKqSnAyJBwnHzv4Rjabzh8lfPh
 13RpUur7nG+14G/9J0L1lgeSi8pnoXjHVVDwLzg19l+j132YoYwikYjQ5G14xdsTRBYS
 vdCAguzmiCMVg4Mkmte6kDG02gB3Mayc1/BUDKIQo3DDE6xbKGZwNOzj7fTarAqkERfD
 mXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309644; x=1794914444;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y9e6yF2zx9a5Fs/4py+T8ZMdbO3y11S/WHybEhfSy5Y=;
 b=ibw2EEuW2UJ50W0rD4/q/MY0VIFVFY1Fb9itTly3VGhXyO/KfjKZYwiSPTHnX+oUeb
 S0gYJr8oCBIeylKpN9B2XrYx54xsHhXQdR9FSviRYwvfh4Dw16aTfrn7KFb7is/UzzRx
 BNFW0uVILpAS3KiTfh32ZtKk4oIQ3KizhuAiAh2RtkKQlTtwYwsea6kb60dhU7J7RM0k
 JT5a15eZ8fd0jYu8tYabwVn3HGpsUTqjS4/YstD2q3hurQTTLCs1u2N0IgNaITmuWAyy
 xxIOJpfoaGz39h6GbgOZVLMDuPuCTMGk4shPaUaLoO0GZRLamnxiZNbv0FOFI1WOeHDs
 Lb3w==
X-Gm-Message-State: APuU4Z81hppUshObIZWWj4nj7rnMVU3eGGYMbei3M/8PXOyD1B05hqbD
 b/2wrgAG+Q4VFVFBJShPtkpqAXOP02/b9Mv4iGEG0RLHiWThVJZsS1spJDbwHuJryLIKuRusPYP
 SG/LCk+jAKTR4ducuxPkh3luBE7L8dfbF/nYb6Hn0Qx21iZPHiGyG7zpL4OgniLOXTGxLyyksZH
 hls9JRvQ==
X-Gm-Gg: AYBFou0L45P1OIgdFwRlbpwAOFiH0oQftOBnaWZKS/ffMhqyB0qzmPKlq5V02SWDa2F
 aeTU8r33u1FeK63AGn01jSdgOzu/xgYJ6JksMp8YnHg9TKgaOtYdW9V3r3fVWWagR4khBEOqajf
 za0CjvmJAY9TRN2ksUZsoAjcivQwAjvVnRYgsv/wSJ7nJea4DpqgYTBYS3Sz4048/asTPuX7Cke
 futqnA9P1oRpV21v9r/TGEhkl2UKgXubg/onzSx8juIHoc3B/UNqSLufoZzI0DytnvzwZBO6D28
 kFZFdlgwDcH9gCd4JZCtzbh58Uf+aJErnQIy3HrOQYzATsE3YxdFC6a9dbi8RondLLNsNdHPX97
 qhTGyGvWMJlc7mTNxqy8Mmd6F1njdqc+ZnNdCaBeMssF5XcOj44aUMUk/ZfDyijtMHNJVg0Dnrc
 sQg6JDHs39FwRC7coEpyH79Zh9G40zuLosPT6N3k9zaEyIXKkDPKx1BFpMh0I3XUfYmUxIRGAX7
 pDnhYlG33kgfdRGhFE8teBCyK25UZqFw2QfyqwniILViBOxlVdwumz209a6zJirM/7WXcCnctJ7
 nlrd0l5x+qKGnJmKafE2hlDFW/4RCPp7TmLXGjVIkVOff4pIKCA8TR9QeBVV82vLKOirm24425Y
 +90SH2yqThFHki0nYbbtg1Sfhw6xP2/DrXJQGBl2DjzOx+nmTp9L3sjespA6doSCFYrutExiZEG
 Q4yBXAjnOyZA8U8ZBrPqGdW/uDCtWh9vi7ciPx
X-Received: by 2002:a05:600c:468f:b0:4a3:12fb:1ee7 with SMTP id
 5b1f17b1804b1-4ba0234cd58mr38609845e9.25.1794309643516; 
 Tue, 10 Nov 2026 03:20:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bd6esm4210197f8f.28.2026.11.10.03.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:20:43 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:20:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: f2168737871a31ecb94fcc24798e5c4d1e12fd9c
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <20170920ae3aa41979b0b4c098913f3fcc2b88bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjuE-000000004BV-0zQp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2524955158497924524=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2524955158497924524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nt+SjV6qNpA="; charset=UTF-8

--nt+SjV6qNpA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

H=
ello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit

  =
  https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail

to look at t=
he new patch set (#6)=2E


Change subject: tls: reject incoming reneg reque=
st if primary key is not fully valid
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

tls: reject incoming reneg request if primary key=
 is not fully valid

Incoming P_CONTROL_SOFT_RESET_V1 can arrive while the =
active key is not
yet fully valid for renegotiation=2E This includes the wi=
ndow where we are
still waiting for auth_deferred_expire (derived from hand=
shake/reneg
timing), as well as cases where deferred or mid-session auth la=
ter
leaves the key non-authenticated even though state is S_GENERATED_KEYS=
=2E

This patch keeps read_control_auth as the first gate, then rejects the=

incoming renegotiation requests unless the primary key is KS_AUTH_TRUE
and=
 auth_deferred_expire has passed=2E

The rejected request is not counted as=
 a TLS error, since soft TLS
errors trigger an instance restart in TCP mode=
=2E

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: Ra=
lf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/ssl=2Ec
1 file changed, 15=
 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/78/1478/6

diff --git a/src/openvpn/ssl=2Ec b/src/=
openvpn/ssl=2Ec
index 420daef=2E=2E54223da 100644
--- a/src/openvpn/ssl=2Ec=

+++ b/src/openvpn/ssl=2Ec
@@ -3951,6 +3951,21 @@
                 goto err=
or;
             }
 
+            /*
+             * Do not allow incoming =
renegotiation unless our primary key is
+             * fully authenticated=
 and past the deferred-auth/transition gate=2E
+             */
+          =
  time_t auth_deferred_left =3D ks->auth_deferred_expire - now;
+          =
  if (ks->authenticated !=3D KS_AUTH_TRUE || auth_deferred_left > 0)
+     =
       {
+                msg(D_TLS_ERRORS,
+                    "TLS: refu=
sing premature incoming renegotiation request for key-id %d: "
+           =
         "auth=3D%s, auth_deferred_expire in %d seconds",
+                =
    ks->key_id, ks_auth_name(ks->authenticated),
+                    auth_=
deferred_left > 0 ? (int)auth_deferred_left : 0);
+                goto don=
e;
+            }
+
             key_state_soft_reset(session, NULL);
 
   =
          dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d s=
id=3D%s", i,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
04c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-P=
atchSet: 6
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--nt+SjV6qNpA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
<strong>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a>=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">tls: reject incoming reneg request if primary key is not =
fully valid<br><br>Incoming P_CONTROL_SOFT_RESET_V1 can arrive while the ac=
tive key is not<br>yet fully valid for renegotiation=2E This includes the w=
indow where we are<br>still waiting for auth_deferred_expire (derived from =
handshake/reneg<br>timing), as well as cases where deferred or mid-session =
auth later<br>leaves the key non-authenticated even though state is S_GENER=
ATED_KEYS=2E<br><br>This patch keeps read_control_auth as the first gate, t=
hen rejects the<br>incoming renegotiation requests unless the primary key i=
s KS_AUTH_TRUE<br>and auth_deferred_expire has passed=2E<br><br>The rejecte=
d request is not counted as a TLS error, since soft TLS<br>errors trigger a=
n instance restart in TCP mode=2E<br><br>Change-Id: I704c560fa23c03237d0f8a=
dc30908a617265a5a1<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;=
<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 15 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/78/1478/6</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 420daef=2E=2E54223da 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -3951,6 +3951,21 @@</span><br><span>         =
        goto error;</span><br><span>             }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * Do not allow inc=
oming renegotiation unless our primary key is</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * fully authenticated and past the d=
eferred-auth/transition gate=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            time_t auth_deferred_left =3D ks-&gt;auth_deferred_expi=
re - now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (ks-&gt;authenticated !=3D KS_AUTH_TRUE || auth_deferred_left &gt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_TLS_=
ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        &quot;TLS: refusing premature incoming renegotiation request for ke=
y-id %d: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                &quot;auth=3D%s, auth_deferred_expire in %d seconds&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
ks-&gt;key_id, ks_auth_name(ks-&gt;authenticated),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    auth_deferred_left &gt; =
0 ? (int)auth_deferred_left : 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                goto done;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>             key_state_soft_reset(session, =
NULL);</span><br><span> </span><br><span>             dmsg(D_TLS_DEBUG, &qu=
ot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=3D%s&quot;, i,</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1478?usp=3Demail">change 1478</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a=
5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--nt+SjV6qNpA=--


--===============2524955158497924524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2524955158497924524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2524955158497924524==--

