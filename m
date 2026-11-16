Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DD606A333
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nl+EB5cM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Iesju3PB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZEXRyqLU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D4FuulN0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TlPFp+rp7jAYLxNFoctx3EugHKAgMkUtmPzUZYF2PNU=; b=Nl+EB5cMktCKILCvWvo4wDuPY4
	TwVvq3briSF+/NJ1/lFr/fUJdpyrE/DcxB2WrUrKNf2Ntoa0aHgsD6wN6UFX1LWSbeY79xPAbrf2G
	yJs0JuBDmzZ7fa4xlOKKfxYkpcAnLcOhOZFKTjJbYGKtBnARCiZepjRh8rMEjJ7z/fIo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxHE-000000001K5-2SVR;
	Mon, 16 Nov 2026 14:01:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxHC-000000001Jy-3oeK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CeA5dU+NWVo58yvPRDXU4wbB2hsCUozxBex2DsPJIhQ=; b=Iesju3PBepcYXAedrPAAE4fKpQ
 +kbAh9DMGfXQ6iaatnkCFdyANOfl4tk2+Nko8EgWxl11Suk1WmNYt7lR2gO5OBp82r6WmFt6lI2/Z
 l80kEPqyLhW1DdgyAJLFKxkKSv/uhBxpN47FGd4zJeBLOVClODOQYRLc4CEuLY29sG8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CeA5dU+NWVo58yvPRDXU4wbB2hsCUozxBex2DsPJIhQ=; b=ZEXRyqLUpxdiHqz683YVQfmYiW
 lGvKnNIASuOD7puDLwngc5BHry+58o3CAbn9i9Wrh+8ynITO6uAUQ9GkdruhixKeA8Djl7vSCU7lf
 kIiOAl0AAqCRNr0+pmQVxKcuHpsU7t545mssT2/xCgYsnl6tqNZlJbGi6yUeGFwzUV0E=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxH9-000000005Xy-2QCf for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:01:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so9789735e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794837693; x=1795442493; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CeA5dU+NWVo58yvPRDXU4wbB2hsCUozxBex2DsPJIhQ=;
 b=D4FuulN04tJK6ESxtSDIMj0/Ljap3fl+KjjMMxmEprYeYMK0eCJVTuqLC8rCKZDj/D
 0ZzOKIyzhLot/WVnlsvtIHhfwGAaJljUO0D3xjgjXYM7o5G3soLv7Tbqm7HlPgG4SvYw
 UZx7pqxLxnojhstK8PBK6e+hZcCGKzLTY1pGRdLT2VDCNVQZmrmpHGjKCu5OPYrJZ716
 IYpM7RItMciOooVGHCHaHUogSFx8y3AuipX3HgrWzGR9t0Gk61xVC5eWMY0Hy73EsjpV
 YAnodBz3kL9zSTQ1kUD3mBzCeR+TL3vOimK/cqi4oBBBXGsHD8NnkUegBMBj7sBnXvej
 ky1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837693; x=1795442493;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CeA5dU+NWVo58yvPRDXU4wbB2hsCUozxBex2DsPJIhQ=;
 b=DVL82++terFYPMhJZ1H1WloDZkI3jYWkPWx7wbUWdX2fr3A5uiy1Z/BiJdwjsoICpa
 IZZD+bgRdMrQxlitPnG2rL2vU/g3AJjGCIMlQxZ/4+tSrDGNobFadhKsLPsSFZMT0i5/
 9giy37g/nVsXpt3Z8ilfRdHokD6TSdfwLkNG7GjHXvd4lhMVPsAsBugxnp2d6kD6aWGh
 zZ2vZfMViyk2E/n48WN4uQU2EJZm2KJqEq3QHSk2yEXB4kx2jwKCMdwWR4ikRYlQRtuJ
 nhd/W4UpIwUifIEx5bpktOCOxf7gyXgoWPOihlIdCELRNARyuUmJMTQ0eSMlW0TvQbUi
 bPUA==
X-Forwarded-Encrypted: i=1;
 AL+hErFBS6PVYoJi/FjQ74JRaMk26sKoz9XKP8enCmG46rotoExbCVPrNmZ3SaVj/Wv3pWLd8h7loRmHcWrti6hx@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+51dC9zI0slsS8mfKaK52Q6JaXhud13vVh6DPt844u8AFHRGPS
 3iSyjrIekSwRTrKanL9Li5mkcvSvABpEVqPsLFH8duzEEy+b1BJo4hefdO8HxFVrpb/gb58nhlk
 b/J+LCFQ+R5Xe8a6Xi+T0O3BLS2rbgAPTvzl8TV6bKMFZ3dclDdAX2huIoB/GWhhMboem
X-Gm-Gg: AYBFou0HhzFBOdpRm21NaE0HDEE/RnT/Xkr3OIFk6EMhqGGX4lGJz4BeOtDdLSqhLUz
 4No2dYGfSPTd3lBbG1/kTeKDKCwBC1Gj7MXFCDYxYRi2L7FdrGmbVI/RwVlDrkn64q7XleRGXJh
 4B9TC+7ldg8d7zU/TBHT49jRLy0Y1k5CrM3Gia4Kg67+AK3ob1DUHDzQbMJBGTDt2CChKeYU1yh
 HKx3HK+8BMW5JMFH1tdYxc6kpevNa+5eM3zfw/DJv+UyD/4xiNZPW/vTeYWELQXwsbd+Kxa7hgA
 LXXkz9SPq+pKmd8A4nZkjeSnIcNBQFzvtdsvMoBzo8MlPXPaCrhNkUWsnHZX5nNExJEjmIuaXGv
 viwyz7rTv6FeE3Ejb7XY6GP59jHKZxE1FTg8LuZwgupe/yxFtjQ/LgSieWH72De90QiYZCRnxtv
 QoNYn4dKpnc/OfEeHBCBLKrh9PLnNHgu5xsKWfNb0meqO3uCavdkPDvMfplyg91Vw/fP+3pyGZy
 OhFOcAgBBcfK9EKWYRAPtGxcwxM39VlzT/X/aK248EN9O4TGetZvMPh48vwEgYXQmOxlW8P1DSL
 Lo59pTQmhT8R2cUsMkUYMxl+Vunf62jmxOfcgOApOI2cxlkRORvTNzERJeNnwt4dHE/IswdfFCB
 65C23iAmaeYz1qtu0DYXUzXlZ46kfV7zkJwlU4O/h37GGuqqoMvN5hZ8CzAF8TvY+vXPPssPTQN
 nNYLJXN0pYyMIZ7BI=
X-Received: by 2002:a05:600c:3b98:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb55a8c128mr231252915e9.25.1794837692847; 
 Mon, 16 Nov 2026 06:01:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm40639603f8f.7.2026.11.16.06.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:01:31 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
X-Gerrit-Change-Number: 2193
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2193?usp=email>
X-Gerrit-Commit: 38b0d5d07e5b0108bc8ffb789d82fa11c685c5f5
In-Reply-To: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
References: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkk2MDc5ZjQ1NGU1YmIxY2U3YzRlY2M1MzQzY2UyMjMxYzQxN2NhODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <27708121864af843a35801933a70eadb9157695a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxH9-000000005Xy-2QCf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Disable
 -Werror for MinGW 32bit
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4231217182679787809=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4231217182679787809==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x/eUdoFneFA="; charset=UTF-8

--x/eUdoFneFA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2193?usp=3Demail )

Change subject: GHA: Disable -Werror for Mi=
nGW 32bit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

G=
HA: Disable -Werror for MinGW 32bit

There are some build failures related =
to -Wsign-conversion
now that look like clear bugs in MinGW=2E Since we do =
not plan
to support 32bit Windows going forward, let's not worry too
much a=
bout compiler warnings anymore=2E We will still detect if
we break the buil=
d completely, for now=2E

While investigating the issue, remove a wrong com=
ment=2E With
-Wsign-conversion, all builds need the casts=2E

Change-Id: I6=
079f454e5bb1ce7c4ecc5343ce2231c417ca879
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193
Message-Id: <202=
61116132828=2E31945-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41439=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/buil=
d=2Eyaml
M src/openvpn/auth_token=2Ec
2 files changed, 5 insertions(+), 1 d=
eletion(-)




diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/wo=
rkflows/build=2Eyaml
index 27f08df=2E=2Ed50b7ff 100644
--- a/=2Egithub/work=
flows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -81,6 +81,10 @=
@
         arch: [x86, x64]
         build: [Release, Debug]
 
+        inc=
lude:
+         - arch: x86
+           configure-args: "['-DUSE_WERROR=3DO=
FF']"
+
     name: "gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }=
} - OSSL"
     runs-on: ubuntu-26=2E04
     env:
@@ -113,6 +117,7 @@
      =
   uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9=

         with:
           configurePreset: mingw-${{ matrix=2Earch }}
+   =
       configurePresetAdditionalArgs: ${{ matrix=2Econfigure-args }}
      =
     buildPreset: mingw-${{ matrix=2Earch }}
           buildPresetAddition=
alArgs: "['--config ${{ matrix=2Ebuild }}']"
 
diff --git a/src/openvpn/aut=
h_token=2Ec b/src/openvpn/auth_token=2Ec
index 703a0b2=2E=2E261c7c2 100644
=
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -364,7=
 +364,6 @@
 
     /* Accept session tokens only if their timestamp is in th=
e acceptable range
      * for renegotiations=2E
-     * Cast is required f=
or systems with 32bit time_t, e=2Eg=2E Windows x86=2E
      */
     const t=
ime_t token_reneg_deadline =3D (time_t)timestamp + 2 * session->opt->auth_t=
oken_renewal;
     bool in_renegotiation_time =3D now >=3D (time_t)timestam=
p && now < token_reneg_deadline;

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2193?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
Gerrit-Change-Number=
: 2193
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--x/eUdoFneFA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2193?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">GHA: Disable -Werror for MinGW 32b=
it<br><br>There are some build failures related to -Wsign-conversion<br>now=
 that look like clear bugs in MinGW=2E Since we do not plan<br>to support 3=
2bit Windows going forward, let&#39;s not worry too<br>much about compiler =
warnings anymore=2E We will still detect if<br>we break the build completel=
y, for now=2E<br><br>While investigating the issue, remove a wrong comment=
=2E With<br>-Wsign-conversion, all builds need the casts=2E<br><br>Change-I=
d: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2193<br>Message-Id: &lt;20261116132828=2E31945-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg41439=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M src/open=
vpn/auth_token=2Ec<br>2 files changed, 5 insertions(+), 1 deletion(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workf=
lows/build=2Eyaml</span><br><span>index 27f08df=2E=2Ed50b7ff 100644</span><=
br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egi=
thub/workflows/build=2Eyaml</span><br><span>@@ -81,6 +81,10 @@</span><br><s=
pan>         arch: [x86, x64]</span><br><span>         build: [Release, Deb=
ug]</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        include:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        - arch: x86</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           configure-args: &quot;[&#39;-DUSE_WERROR=3DOFF&#39;]&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     nam=
e: &quot;gcc-mingw - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&qu=
ot;</span><br><span>     runs-on: ubuntu-26=2E04</span><br><span>     env:<=
/span><br><span>@@ -113,6 +117,7 @@</span><br><span>         uses: lukka/ru=
n-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>=
         with:</span><br><span>           configurePreset: mingw-${{ matrix=
=2Earch }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 configurePresetAdditionalArgs: ${{ matrix=2Econfigure-args }}</span><br><s=
pan>           buildPreset: mingw-${{ matrix=2Earch }}</span><br><span>    =
       buildPresetAdditionalArgs: &quot;[&#39;--config ${{ matrix=2Ebuild }=
}&#39;]&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/au=
th_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 703a0b2=2E=
=2E261c7c2 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><b=
r><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -364,7 +364,6 @=
@</span><br><span> </span><br><span>     /* Accept session tokens only if t=
heir timestamp is in the acceptable range</span><br><span>      * for reneg=
otiations=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Ca=
st is required for systems with 32bit time_t, e=2Eg=2E Windows x86=2E</span=
><br><span>      */</span><br><span>     const time_t token_reneg_deadline =
=3D (time_t)timestamp + 2 * session-&gt;opt-&gt;auth_token_renewal;</span><=
br><span>     bool in_renegotiation_time =3D now &gt;=3D (time_t)timestamp =
&amp;&amp; now &lt; token_reneg_deadline;</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail">ch=
ange 2193</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2193 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--x/eUdoFneFA=--


--===============4231217182679787809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4231217182679787809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4231217182679787809==--

