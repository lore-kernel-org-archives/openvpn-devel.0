Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C056606A88B
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E16KbkNT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PSjDJoNX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c9p9mVRr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QietJeKr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=VaDOg/x3XDXoIvIHkr4/igGNBQIRKFF5cFdgy99Id/k=; b=E16KbkNTwrSbzgd8HxnV67Uo2h
	9/Zj7Uf74R6UcTvy4Hy5VQDcbtq55ejwirrHIUKbNZ9Y/f8RKhKX9na2jgDBiR5efnXDgczVrDPaf
	wVmtpuJk04sl1hAKRBHt/rdHXNX/7WiRt9eI3NPpKerYXqJQoQgsaGbsRknBmINv+qJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTEgZ-000000002S4-3Rlw;
	Tue, 17 Nov 2026 08:37:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTEgY-000000002Rw-3aTE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OeS82+fmsoCJb3eDBkOCzs9oglMgdZn8QmM6ksDvSy0=; b=PSjDJoNXOKg9DLoKZV2pERbPbV
 seN9f6EdLjERYezxYfzq775qA1MEAyEbKOs8DcT/ccd+xCjgN6wRiWuBszCpXbDBCo+/qVxf6dyzQ
 FW0iRRS17ca0So+mUkaQlofNxgp9mE7fqIXQ++ht4SqkjA7moxnIOucu9RUbeABmY9t8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OeS82+fmsoCJb3eDBkOCzs9oglMgdZn8QmM6ksDvSy0=; b=c9p9mVRr+VFd3ZZEHjlYFbhUaQ
 djgimdUnsFNE5WPEBj/vxxRKegE1LyugdX1zc0rf4pk7o3dyWaVspBDAhVcgayLh909E0vVDZCMvk
 SW4g0/YUdRSQdNfXIscgyHPLSkGvw2Vc/cSoBljV3N8Zui5m6gZkMCPbuOqM+fJFdhVc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTEgX-000000005o8-05SN for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:37:02 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so68416f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 00:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794904614; x=1795509414; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OeS82+fmsoCJb3eDBkOCzs9oglMgdZn8QmM6ksDvSy0=;
 b=QietJeKrJ3v41YeIEsDJX5GZ1U8qwor+Mhnh+N3V3KSZh5UNU2R4hY6Z1huegeHFNm
 FaYpr2i8Pqf4X11Jg/GR8JnW18mCkS+Vf6RqSkLf0LNCyBExkk7MVVO+T9BUzMzivr9a
 9ATQcNDfy09uD0CYSkoDjgzl4AIj3NDdx7JCJxd6ktlTCBmVAiFD9GAsx4VG1+kKlybn
 FfFza7OvGlGTNQq7wO9tzy8voVjmd2f2IGIykVvMwjyM5PfRfu5/EFYQc6ae9kV7KUs1
 AHHpPP3B/gXIkmSL3E3MbKNXYvkqNoDy+sm+gwjTI3dUF298iqrU/sa6xahhAHismRFA
 5DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794904614; x=1795509414;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OeS82+fmsoCJb3eDBkOCzs9oglMgdZn8QmM6ksDvSy0=;
 b=dlZFKOWYtsiUz76fxP37E3cJR7db0lPWETNvo9oN3TYO6w/FdhJqqZUdeigaEBwvGh
 OW4IWIy7IWpp5HPSJTjd9deXi4AOLOHm5RllMC6AujHPyOOf65uPs4DQg2FO8PAUh1lC
 RhZ+MDSF78NS2cHPMARuMOnV2wrKa1/y0F6cqAwWbiRMxUVbJwxN0dG+0n2ggbsOpt42
 H5eH82TrEF4B9KTerhoMiTxKpJpgI0tI82HPy/WfoosTejK9auSvKMb4MvVbCARneWpC
 zIvPOvIlcBQbhKVSJDrkz5mPPDhmZDuwZJhy2XRFLFRIYfPwUSG43Zwrws7KZAs7I9Ym
 IcrQ==
X-Gm-Message-State: APuU4Z/mjpVw9DpiF3U6py/elqPPWL2sVouVD1cboSwlbFv4S0pqmXiw
 khNEizpJiEK2P33IqaVKS9Jo8NRDt/WXIYjSqrrGkYhWBDMKKonhxPOc978PmGcjVa3h6BrC70q
 ckIksrK6U+lqYnXacTS/J8MZ5ppRzefutVepq1ou/BgdDZW0ZjWi7xlUiRV+JV9sX0YIwgCXNI2
 Umo6NA/g==
X-Gm-Gg: AZFdTZfLCls28+5r1TNt4axegk+t6QnVg9Z1aR2x5c+N4sTemXjsh3rXlyrvaFusJwt
 P5RlS+/2ztD0azsryIKTi+ag/8CUtBhkmWVZhMFsJDvUnykCiNZwFym86BeOQ3VssmNdBncHxs8
 PU6QgmdBs6iyHSEXvrRX5dUuBhcE8TJZO+zbOX8ByhfwJ+wM4tqhH79LzCzDOOyN+GRb+iytpFW
 9sXoR2eZwFRKE+W0inajTc9eCou//Fgcp87qHGK7L9wTkKC7iuNu+fKBxth/DUCfRBp0eT3sq8K
 d9jYQdm/VK4NMf+T7j2ITRUvzTejszSgP5JH4WYjBQi2mhTf9Mp4CYnp+cIi2Q0xP5lc8Gc+pes
 2sicxyqxtFUmU2W9c5X6NpaI+c7snq8BPiBavz54egbqzCdh5HMAbXk7nciGXPmGtk9l2XPNf9I
 ezdE4AIGEdXY5l1y26OlSvv/qxKcACSoRW3xVmcC32iolGCGQiI0biXrs5VQmA3cQOcaO1BRvR0
 pNx5gzdGf262KJeseV02ceHU9gUcUHOm0ZMnXmmJYLewpfEbtbTlkTBVw3lq6rjWTOczKm0n1SZ
 fiKWYk6oOsRPIzTfK4yTwEdaquXiV13JiSCFhS5z5UzuVVvsfrvp767WKVV+9IVoZ6YC0P3f9Yq
 Tb7h09o3V2p+DRpIkXvvJ6bL+tP37Sjsqx+1XXZWJxg0fiRz5cniVfuijbTLMC8Gjny+En2nd3B
 PiKr32OaEKWp+N56NczHZL8s6c8oRP8s1X1ed/
X-Received: by 2002:a05:6000:200f:b0:49b:f7e8:6f3d with SMTP id
 ffacd0b85a97d-4a374abbff4mr4365652f8f.18.1794904614274; 
 Tue, 17 Nov 2026 00:36:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f78214dsm26826372f8f.25.2026.11.17.00.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:36:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 08:36:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibd316e5c3e6a0fb600ec4817aa079554464fd942
X-Gerrit-Change-Number: 2208
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2208?usp=email>
X-Gerrit-Commit: 7ed989888bbf2b223cac7c153608e78ff8e5ded0
References: <gerrit.1794904611000.Ibd316e5c3e6a0fb600ec4817aa079554464fd942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTA0NjExMDAwLkliZDMxNmU1YzNlNmEwZmI2MDBlYzQ4MTdhYTA3OTU1NDQ2NGZkOTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f5be22842ca8b5059bfb29920d6a6b760686851-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTEgX-000000005o8-05SN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: locate the
 TCP/UDP header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1529156471458445178=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1529156471458445178==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vbUOKl758xw="; charset=UTF-8

--vbUOKl758xw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2208?usp=3Demail

to review the following change=2E
=


Change subject: clinat: locate the TCP/UDP header via the IP header lengt=
h
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clinat: lo=
cate the TCP/UDP header via the IP header length

client_nat_transform() ad=
justed the TCP/UDP checksum at a fixed offset
of 20 bytes=2E With IP option=
s this rewrote the UDP destination port or
the TCP data offset and flags in=
stead, and for non-first fragments it
modified payload bytes=2E Use the hea=
der length from the IP header and
skip the transport checksum for non-first=
 fragments, as mss_fixup_ipv4()
does=2E

Change-Id: Ibd316e5c3e6a0fb600ec48=
17aa079554464fd942
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
-=
--
M src/openvpn/clinat=2Ec
1 file changed, 20 insertions(+), 7 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/08/=
2208/1

diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index =
fc4acef=2E=2Ea046324 100644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/=
clinat=2Ec
@@ -247,32 +247,45 @@
 
         ADJUST_CHECKSUM(accumulate, h->=
ip=2Echeck);
 
+        /* The TCP/UDP header follows any IP options, and o=
nly the first
+         * fragment carries it=2E */
+        const int hlen=
 =3D OPENVPN_IPH_GET_LEN(h->ip=2Eversion_len);
+        struct buffer l4 =
=3D *ipbuf;
+        if ((ntohs(h->ip=2Efrag_off) & OPENVPN_IP_OFFMASK) || =
hlen < (int)sizeof(struct openvpn_iphdr)
+            || !buf_advance(&l4, =
hlen))
+        {
+            return;
+        }
+
         if (h->ip=2Epr=
otocol =3D=3D OPENVPN_IPPROTO_TCP)
         {
-            if (BLENZ(ipbuf)=
 >=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr))
+      =
      if (BLENZ(&l4) >=3D sizeof(struct openvpn_tcphdr))
             {
-  =
              ADJUST_CHECKSUM(accumulate, h->u=2Etcp=2Echeck);
+           =
     struct openvpn_tcphdr *tcp =3D (struct openvpn_tcphdr *)BPTR(&l4);
+  =
              ADJUST_CHECKSUM(accumulate, tcp->check);
             }
     =
    }
         else if (h->ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_UDP)
      =
   {
-            if (BLENZ(ipbuf) >=3D sizeof(struct openvpn_iphdr) + size=
of(struct openvpn_udphdr))
+            if (BLENZ(&l4) >=3D sizeof(struct o=
penvpn_udphdr))
             {
+                struct openvpn_udphdr *udp =
=3D (struct openvpn_udphdr *)BPTR(&l4);
+
                 /* RFC 768: a UD=
P checksum of 0 means "no checksum computed"=2E
                  * Do not =
run the incremental adjustment over a non-checksum,
                  * or =
we will write a bogus non-zero value into the field=2E
                  */=

-                if (h->u=2Eudp=2Echeck)
+                if (udp->check)
=
                 {
-                    ADJUST_CHECKSUM(accumulate, h->u=2E=
udp=2Echeck);
+                    ADJUST_CHECKSUM(accumulate, udp->check);=

 
-                    if (!h->u=2Eudp=2Echeck)
+                    if (!=
udp->check)
                     {
                         /* RFC 768: a c=
omputed checksum of 0 must be transmitted
                          * as 0x=
FFFF (one-complement), because 0 is reserved for
                          =
* "no checksum computed"
                          */
-                    =
    h->u=2Eudp=2Echeck =3D 0xFFFF;
+                        udp->check =3D =
0xFFFF;
                     }
                 }
             }

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2208?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibd316e5c3e6a0fb600ec4817aa=
079554464fd942
Gerrit-Change-Number: 2208
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--vbUOKl758xw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2208?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">clinat: locate the TCP/UDP header via the IP header len=
gth<br><br>client_nat_transform() adjusted the TCP/UDP checksum at a fixed =
offset<br>of 20 bytes=2E With IP options this rewrote the UDP destination p=
ort or<br>the TCP data offset and flags instead, and for non-first fragment=
s it<br>modified payload bytes=2E Use the header length from the IP header =
and<br>skip the transport checksum for non-first fragments, as mss_fixup_ip=
v4()<br>does=2E<br><br>Change-Id: Ibd316e5c3e6a0fb600ec4817aa079554464fd942=
<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>=
M src/openvpn/clinat=2Ec<br>1 file changed, 20 insertions(+), 7 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/08/2208/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/clinat=2Ec b/=
src/openvpn/clinat=2Ec</span><br><span>index fc4acef=2E=2Ea046324 100644</s=
pan><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b/src/openvp=
n/clinat=2Ec</span><br><span>@@ -247,32 +247,45 @@</span><br><span> </span>=
<br><span>         ADJUST_CHECKSUM(accumulate, h-&gt;ip=2Echeck);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
The TCP/UDP header follows any IP options, and only the first</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * fragment carries it=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const in=
t hlen =3D OPENVPN_IPH_GET_LEN(h-&gt;ip=2Eversion_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct buffer l4 =3D *ipbuf;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((ntohs(h-&=
gt;ip=2Efrag_off) &amp; OPENVPN_IP_OFFMASK) || hlen &lt; (int)sizeof(struct=
 openvpn_iphdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        || !buf_advance(&amp;l4, hlen))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>         if (h-&gt;ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_TC=
P)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (BLENZ(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) +=
 sizeof(struct openvpn_tcphdr))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (BLENZ(&amp;l4) &gt;=3D sizeof(struct openvpn_tc=
phdr))</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                ADJUST_CHECKSUM(accumulate, h-&gt;u=2Etcp=
=2Echeck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       struct openvpn_tcphdr *tcp =3D (struct openvpn_tcphdr *)BPTR(&amp;l4=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                A=
DJUST_CHECKSUM(accumulate, tcp-&gt;check);</span><br><span>             }</=
span><br><span>         }</span><br><span>         else if (h-&gt;ip=2Eprot=
ocol =3D=3D OPENVPN_IPPROTO_UDP)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (BLENZ(ipbuf) &gt;=3D =
sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(&amp;l4) &g=
t;=3D sizeof(struct openvpn_udphdr))</span><br><span>             {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                struct open=
vpn_udphdr *udp =3D (struct openvpn_udphdr *)BPTR(&amp;l4);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                 /=
* RFC 768: a UDP checksum of 0 means &quot;no checksum computed&quot;=2E</s=
pan><br><span>                  * Do not run the incremental adjustment ove=
r a non-checksum,</span><br><span>                  * or we will write a bo=
gus non-zero value into the field=2E</span><br><span>                  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (h-&=
gt;u=2Eudp=2Echeck)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (udp-&gt;check)</span><br><span>                 {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ADJUST_=
CHECKSUM(accumulate, h-&gt;u=2Eudp=2Echeck);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    ADJUST_CHECKSUM(accumulate, ud=
p-&gt;check);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    if (!h-&gt;u=2Eudp=2Echeck)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    if (!udp-&gt;chec=
k)</span><br><span>                     {</span><br><span>                 =
        /* RFC 768: a computed checksum of 0 must be transmitted</span><br>=
<span>                          * as 0xFFFF (one-complement), because 0 is =
reserved for</span><br><span>                          * &quot;no checksum =
computed&quot;</span><br><span>                          */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        h-&gt;u=2Eudp=
=2Echeck =3D 0xFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        udp-&gt;check =3D 0xFFFF;</span><br><span>        =
             }</span><br><span>                 }</span><br><span>         =
    }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2208?usp=3Demail">change 2208</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2208?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Ibd316e5c3e6a0fb600ec4817aa=
079554464fd942 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 22=
08 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--vbUOKl758xw=--


--===============1529156471458445178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1529156471458445178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1529156471458445178==--

