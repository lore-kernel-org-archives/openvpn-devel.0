Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F687C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wIZnAtmAx8qiusRBgFeTnd8xDGG+uub0CGB1N0Wm/7U=; b=DhqnrEB5n7YToUgl8C+CFdTvPF
	tH4VrrxolE08sThqRz0ncbKeWzwaj9j84V4gng+Zr7wEhv4T04KYSRmTbJgZPrpYl7M1rstvCPAIn
	Br3U4ua9zytlCY9T9siWoPUaC3D6u9RZxdoVuF+kMn7FmChJkt/+XqGDA6s3kgSplEx8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws0P8-0000zV-GY;
	Thu, 06 Aug 2026 15:53:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1ws0Ou-0000yy-Km;
 Thu, 06 Aug 2026 15:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dcf+zq9tQkzWMF6Y+ziVbupTiBHpFwNHMAxqe/TI8WU=; b=kH00GkQAS1xw73yMEwp2QfLmxs
 PTcV2GnN9d5YGfN2OoKITdwhuNCTKvXrCzR9jiuBOc9MdW2j+NPUJ+DgjCoSZkmNnkjk6Il4vta0d
 0ttFQ7AncmfbBkI02gXq+EC/qdc2im3/yh/LZuowNbPEQRB+rtuxUrZlSgyDQqr+q4O4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:To
 :From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dcf+zq9tQkzWMF6Y+ziVbupTiBHpFwNHMAxqe/TI8WU=; b=b
 xjfkmhpNxVnfaVIZZeKqN/+27ssvbc95XKVlX9PS16fGeAgneydeI9gXb9JVaFa+LDd0i1gTRl8c1
 VO2F2xOp43v66xiP+6r7MxNvS6CrOM3jPS/3knKqNEspRIrIg5NcnGLU2gHfeK3+08CJrJfcYcV4W
 46rVgCxieWdnSPQ0=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws0Ow-0004Fg-3R; Thu, 06 Aug 2026 15:52:56 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGBct1fvFzMlLJ;
 Thu, 06 Aug 2026 17:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786031566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dcf+zq9tQkzWMF6Y+ziVbupTiBHpFwNHMAxqe/TI8WU=;
 b=cjca0ZCm6IaiiyqTAzB9U6/Sm8Vs322tnVo6MXIA3Pw/iz2+eoCjOdCld57nZPAEkXJBeM
 btPdLjx7qHBeJJ8PYO8wVri8P73VRv67ovjl4+nFBs5Q4V5zfgb2BqlumIQPTVLP+n9gMB
 eNv5jeSTkkCEKBoAGRjcFIwj0mUjbsjV/GYYYMHlhO+ekRgpaFLMhhJoEEvIhE5sCTUQLW
 kP/FToe68XdprkKKD1O5AFS6qjAQCtvJqN9NtfLzhPhungU2EnxC1ywcaBLDWAXwum/a9v
 vQXAP4wtCJuIxy1vSSdimUSu/88zV0cS/YyVqatL73XxO4oCn/vZPfAQhzbIIA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Thu, 6 Aug 2026 17:52:43 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-announce@lists.sourceforge.net,
 openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <anSty3urDxf0uzVA@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4hGBct1fvFzMlLJ
X-Headers-End: 1ws0Ow-0004Fg-3R
Subject: [Openvpn-devel] OpenVPN 2.7.6 released
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

VGhlIE9wZW5WUE4gY29tbXVuaXR5IHByb2plY3QgdGVhbSBpcyBwcm91ZCB0byByZWxlYXNlIE9w
ZW5WUE4gMi43LjYuIFRoaXMgaXMgYSAKYnVnZml4IHJlbGVhc2UgZml4aW5nIHNldmVyYWwgc2Vj
dXJpdHkgaXNzdWVzLgoKU2VjdXJpdHkgZml4ZXM6CgoqIG9wZW52cG5zZXJ2ICh3aW5kb3dzKTog
YmV0dGVyIHNjcnV0aW5pemUgY29tbWFuZCBsaW5lIHBhc3NlZCBpbiBmcm9tIHRoZSBjb250cm9s
IAogIHNvY2tldCB0byBvcGVudnBuLiBUaGlzIHdvdWxkIGxlYWQgdG8gY2lyY3VtdmVudGluZyBh
ZG1pbiByZXN0cmljdGlvbnMgb24gYWxsb3dlZCAKICBvcGVudnBuIGNvbmZpZyBkaXJlY3Rvcmll
cyAoYnV0IG5ldmVyIHRvICJyZWFkIGZpbGVzIHRoZSB1c2VyIGhhcyBubyBwZXJtaXNzaW9ucyAK
ICBmb3IiKSAoQ1ZFLTIwMjYtNjM2NDkpCiAgQnVnIGZvdW5kIGJ5IOeroOmxvOWTpSAod3d3LmFp
cHlhaXB5LmNvbSkKKiBkY286IG1ha2Uga2V5IHN0YXRlIGRlc3luYyByZWNvdmVyYWJsZQogIFRo
aXMgd2FzIHJlcG9ydGVkIGFzIGEgIndpdGggc3VpdGFibGUgdGltaW5nLCBhIGtleS11cGRhdGUg
ZGUtc3luYyBiZXR3ZWVuIE9wZW5WUE4gCiAgYW5kIHRoZSBrZXJuZWwgY291bGQgdHJpZ2dlciBh
biBBU1NFUlQoKSIsIGFuZCB3YXMgaW5pdGlhbGx5IGhhbmRsZWQgYXMgc2VjdXJpdHkgCiAgcmVw
b3J0LiBJdCB0dXJuZWQgb3V0IHRvIGJlIG5vdCBleHBsb2l0YWJsZSwgYnV0IHRoZSBzdGF0ZSBt
YWNoaW5lIHdhcyBub3QgdmVyeSAKICByb2J1c3QgYW5kIHNvIHRoZSBvcHBvcnR1bml0eSB3YXMg
dXNlZCB0byBpbXByb3ZlIHRoZSBjb2RlLgogIEJ1ZyBmb3VuZCBieSDnq6Dpsbzlk6UgKHd3dy5h
aXB5YWlweS5jb20pCiogbWFrZSAtLXg1MDktdXNlcm5hbWUtZmllbGQgd29yayB3aXRoIG1iZWRU
TFMuCiAgSW4gdmVyeSBwYXJ0aWN1bGFyIHNldHVwcywgdG9nZXRoZXIgd2l0aCBhIENBIGNyZWF0
aW5nIG1hdGNoaW5nIGNlcnRpZmljYXRlcywgdGhpcyAKICBjb3VsZCBsZWFkIHRvIHVuaW50ZW50
aW9uYWxseSBwZXJtaXR0aW5nIGEgY2VydGlmaWNhdGUgdGhhdCBzaG91bGQgbm90IGhhdmUuIFRo
aXMgCiAgaXMgd2h5IHRoaXMgd2FzIGNvbnNpZGVyZWQgYSAobG93LXByaW8pIHNlY3VyaXR5IGJ1
ZyBhbmQgYSBDVkUgSUQgd2FzIGFzc2lnbmVkIAogIChDVkUtMjAyNi02MzY1MCkKICBCdWcgZm91
bmQgYnkg56ug6bG85ZOlICh3d3cuYWlweWFpcHkuY29tKQoKVXNlci12aXNpYmxlIENoYW5nZXM6
CgoqIGlmIC0tZGV2IGlzIG5vdCBzcGVjaWZpZWQsIGRlZmF1bHQgdG8gLS1kZXYgdHVuIC0gc28g
Zm9yIHRoZSB0dW4gY2FzZSwgdGhpcyBvcHRpb24gCiAgY2FuIG5vdyBiZSBsZWZ0IG91dCBvZiB0
aGUgb3BlbnZwbiBjb25maWcuCiogLS1waW5nIGFuZCAtLWtlZXBhbGl2ZSBzZXR0aW5ncyBhcmUg
bm93IGxpbWl0ZWQgdG8gMjQgaG91cnMgbWF4aW11bSAtIHRoZSBwcmltYXJ5IAogIHJlYXNvbiBm
b3IgdGhhdCBpcyB0byBhdm9pZCBsb3RzIG9mIGV4dHJhIGNvZGUgaW4gdGhlIERDTyBrZXJuZWwg
dG8gaGFuZGxlIAogIGFyYml0cmFyaWx5IGxhcmdlIHZhbHVlcyB3aXRob3V0IG92ZXJmbG93aW5n
IDMyIGJpdCBpbnRlZ2Vycy4gMjRoIGlzIGNvbnNpZGVyZWQgbXVjaCAKICBoaWdoZXIgdGhhbiBh
bnkgcmVhc29uYWJsZSB1c2UuCiogVGhlIFRDUF9OT0RFTEFZIHNvY2tldCBmbGFnIGlzIG5vdyAi
YWx3YXlzIG9uIi4gVGhlIC0tdGNwLW5vZGVsYXkgb3B0aW9uIGlzIGtlcHQsIAogIGJlY2F1c2Ug
c2V0dGluZyBpdCBvbiBhIHAybXAgc2VydmVyIGFsc28gZW5hYmxlcyBwdXNoaW5nIG9mIHNvY2tl
dC1mbGFncyBUQ1BfTk9ERUxBWSAKICB0byBjbGllbnRzLCB3aGljaCBtaWdodCBub3QgaGF2ZSB0
aGlzIGNvZGUgY2hhbmdlIHlldC4KKiBSZW1vdmUgLS1wcm92aWRlcnMgZnJvbSAtLWhlbHAgb3V0
cHV0IG9uIG1iZWRUTFMgYnVpbGRzLgoKQnVnZml4ZXM6CgoqIHJlZnVzZSBpbmNvbWluZyBIQVJE
IFJFU0VUIHBhY2tldHMgd2l0aCBhIHNlcXVlbmNlIElEICE9IDAgKHRoaXMgaXMgYmFzaWNhbGx5
IAogIG1ha2luZyBhbiBPcGVuVlBOIHNlcnZlciBpZ25vcmUgYW5kIGxvZyBhICJzaG91bGQgbmV2
ZXIgaGFwcGVuIiBjbGllbnQtc2lkZSAKICBtaXNiZWhhdmlvdXIsIHdoaWNoIGNvdWxkIGxlYWQg
dG8gVExTIGhhbmRzaGFrZSBlc3RhYmxpc2htZW50IGZhaWx1cmVzIGluIHAycCBUTFMgCiAgc2V0
dXBzKQoqIGNvcnJlY3RseSBjYWxjdWxhdGUgcGFja2V0IGlkIHNpemUgaWYgZXBvY2ggcGFja2V0
IGZvcm1hdCBpcyBpbiB1c2UgLSB0aGlzIHdhcyBvZmYgCiAgYnkgNCwgZm9yIGNvbm5lY3Rpb25z
IG9wZW52cG4gMi43KyB0byBvcGVudnBuIDIuNyssIGV4Y2VlZGluZyAibXNzZml4IG10dSIgaGVh
ZHJvb20gCiAgYnkgdGhvc2UgNCBieXRlcyAoR2l0aHViOiBPcGVuVlBOL29wZW52cG4jMTA3NCkK
KiBjb3JyZWN0IG1pbmltdW0gcGFja2V0IGxlbmd0aCBjaGVjayBmb3IgODAyLjFxIHRhZ2dlZCBw
YWNrZXRzIChHaXRodWI6IAogIE9wZW5WUE4vb3BlbnZwbiMxMDQ0KS4KICBUaGlzIHdhcyBhbHNv
IHJlcG9ydGVkICh0d2ljZSkgYXMgYSBzZWN1cml0eSBidWcsIGFzIHRlY2huaWNhbGx5IE9wZW5W
UE4gd2l0aCAKICAtLWNsaWVudC1uYXQgd291bGQgcmVhZCBhbmQgd3JpdGUgdXAgdG8gNCBieXRl
cyAiYWZ0ZXIgdGhlIGVuZCBvZiB0aGUgcGFja2V0IiAtIAogIGJ1dCBkdWUgdG8gdGhlIE9wZW5W
UE4gcGFja2V0IGJ1ZmZlciBsYXlvdXRzLCB3aGljaCBhcmUgYWx3YXlzIGZ1bGwtZnJhbWUtc2l6
ZWQgCiAgdGhpcyBpcyBmdWxseSBzYWZlIGFuZCBoYXMgbm8gYWR2ZXJzZSBjb25zZXF1ZW5jZXMu
CgpNb3JlIGRldGFpbHMgY2FuIGJlIGZvdW5kIGluIHRoZSBDaGFuZ2VzIGRvY3VtZW50OgoKPGh0
dHBzOi8vZ2l0aHViLmNvbS9PcGVuVlBOL29wZW52cG4vYmxvYi92Mi43LjYvQ2hhbmdlcy5yc3Q+
CgpTb3VyY2UgY29kZSBhbmQgV2luZG93cyBpbnN0YWxsZXJzIGNhbiBiZSBkb3dubG9hZGVkIGZy
b20gb3VyIGRvd25sb2FkIHBhZ2U6Cgo8aHR0cHM6Ly9jb21tdW5pdHkub3BlbnZwbi5uZXQvRG93
bmxvYWRzPgoKUGFja2FnZXMgZm9yIERlYmlhbiwgVWJ1bnR1LCBGZWRvcmEsIFJIRUwsIGFuZCBv
cGVuU1VTRSBhcmUgYXZhaWxhYmxlIGluIHRoZSB2YXJpb3VzCm9mZmljaWFsIENvbW11bml0eSBy
ZXBvc2l0b3JpZXM6Cgo8aHR0cHM6Ly9jb21tdW5pdHkub3BlbnZwbi5uZXQvUGFnZXMvT3BlblZQ
TiUyMHNvZnR3YXJlJTIwcmVwb3M+CgpLaW5kIHJlZ2FyZHMsCi0tIAogIEZyYW5rIExpY2h0ZW5o
ZWxkCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KT3Bl
bnZwbi1kZXZlbCBtYWlsaW5nIGxpc3QKT3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1k
ZXZlbAo=
