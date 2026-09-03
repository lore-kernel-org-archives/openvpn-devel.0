Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F0BC79F81
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6NPg3vF+fyAeOQ/rHGLDJaBBW3PfPLdbOEYhm3nafA=; b=VUooe3dtNRdz2DvfeCiWVARgoM
	UxFpY9oeitlCa108iAG0HxEMQG5/3MOGzuUwiPXwJws/xn2DYeeTCPipVovieCmN9Og/tgnVozYjQ
	NsZV7s4SasfKSm4CBVFPwSEIIdH7YBpIkfOBG39fdVOM1vXFkW+V2MDvEGSuqhKVXqb0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2FgK-0005kV-CR;
	Thu, 03 Sep 2026 22:13:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arne@rfc2549.org>) id 1x2Fg3-0005if-4p
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 22:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2RND8E3k+iVw+eK2iyoiKvPu1rPWTal+0oseTJf5vI=; b=F1A/wBe+Bp7gyCC3fhswuRu+W+
 16Kg8qkqP5WwvtVuv9ogV9Dc89w4p4BBz0oFzDvTdWnPnB/guUdsj5mhRVVEpoQIKizHMi7CzXFHJ
 HuX08ekWelFS4EZmrlS9mpdPtC/RW4OtPa+BvO0dxL4avtxVo7VjaBa5J4gS4yX6bTqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x2RND8E3k+iVw+eK2iyoiKvPu1rPWTal+0oseTJf5vI=; b=comBB96og+1m8S9fNhMLpg129d
 1z/caULaEzrcuqlQ8h5HRx8OOAAnRjAnaevWfk0F989fVVjdgJNTv9AoCg4E2mVellhKPFBl9XnDf
 chn1wJ+k8Gp6crEuGLJkl87dY0q1r200fLn3j+YMhpq4EZtN+DuiAeqKSj6OWve6hoao=;
Received: from mail.blinkt.de ([192.26.174.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2Ffs-0005h7-Bu for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 22:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rfc2549.org
 ; s=rsa-green;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender:Reply-To;
 bh=x2RND8E3k+iVw+eK2iyoiKvPu1rPWTal+0oseTJf5vI=; b=A6fcuXKEekoPZrvoXMhbq6+ZqI
 Oq4SXI7ixpnCa8xfnbloxWJkMTgo+PyPatmSmHO1ldd822uzXjBSIhAC3bGAEcd1xHNmWCS32NShD
 AbL+zKcfH/0oQrz3P++EOtn9qX1oDrLMIdwwpWfqfoXfftAtIpaAO0ZuyPBlvAWP26PLtV6sLkQZp
 Uar6Ii/XIJLbQm7btUmdgP37wzdBz/m5o/YQsQ8vXvv1EyOnc/7fbxoug9pISstQUANkx8fcw8mLT
 0ft0u25qNlaYlsCX2KYFzPJmzb4kQV/T4ZolLvWG3yxH6r4bXxtnImdyFOGPIvWJyyRIQ2NxJEPFz
 z/qDf5hA==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=rfc2549.org; s=ed-green; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Cc:Sender
 :Reply-To; bh=x2RND8E3k+iVw+eK2iyoiKvPu1rPWTal+0oseTJf5vI=; b=E/FVmzcJSiY6Cb7
 bsj+ZB78YMuJNYHUnH90KLZdUc5TLKqW/joNXTT5K5JVRawADsuKIKUnF6Hbmz+fqqJNlCg==;
Received: from [194.11.199.51] (helo=[10.231.169.221])
 by mail.blinkt.de with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3 (FreeBSD)) (envelope-from <arne@rfc2549.org>)
 id 1x2Ffk-00000000F50-1KsC; Fri, 04 Sep 2026 00:12:40 +0200
Message-ID: <f9d9c8f8-c198-45b7-8825-747e9ce54fff@rfc2549.org>
Date: Fri, 4 Sep 2026 00:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jon Chiappetta <root@fossjon.com>, openvpn-devel@lists.sourceforge.net
References: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
Content-Language: en-GB
From: Arne Schwabe <arne@rfc2549.org>
Autocrypt: addr=arne@rfc2549.org; keydata=
 xsFNBFusyrsBEAC2Re1MmQjPiutRC8w4vzmHBiPCIRpCPd97rP+ZNdf4DMWlqvSl+Kw+8urP
 lbh6dQKVpdcUGu9iNcLyPDI4xjatvYXo7VKvI1zVri6qboZ2EypezpyekZXHFS5tv3Dnbf55
 S0/MUBQVraIsc3kedeZGizv9alokgGAq3NTACuqFe6plm/+bFLpA51Qfex5FUrSz6bB59tgU
 LptPLVa10W6mSAL4pusdhUvHEeqxF1+fYsQ3KKEbry8Rnc6F2wExmSyicHOBjRstw7cIqWGG
 OdsSz68LXEtvXwEzuxv/YlSABTrs2AhouKRedRJx7XbEK+H9GboTRofqX4Ph4uZoJbU5cilV
 KWen0goCOzR6CohYC/fyjqSEGvhwfmtm3slqj4ZXLpdNrcsgwxmT1Az9S35Vm1Kxcn+RoG+R
 bHhFvv+gL+cuoiwnhWCozh/Ooy1SlSxqQtWl57WULEr9Pu/JyMwUG82xjQhgu2KhuBz2tvs9
 WmQHT/N3ADEbHhtNLB/cXlY8LDwJ6D5diVBix2kaXRj9Ux5ERNDcbGGL5ztrOGyvbDIf2ZSQ
 4DQyCYzvv6YMB/08R0tm/C7XCzTawcF0mdRYEkOQmP2H96NV167WxvxZxF6uLRJKQ7B0IxcW
 riayxsWe4jUmoso7cxB6M5sMtpPN8FoWgmcjacEDM7FCaVd+LQARAQABzR9Bcm5lIFNjaHdh
 YmUgPGFybmVAcmZjMjU0OS5vcmc+wsGOBBMBCAA4FiEE88wmPb+Azu8xbws3FRhsZwKxRFQF
 AlusyrsCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQFRhsZwKxRFSc1BAAsILrcC2B
 B8nC38cI8syth8eX3C1fBcPMN0HfxOc8EuTxb/JTSlkaE+m/EJk4swnDZlQcK1iiadvycZt/
 mA6zx5vj9E4uM3IwQfuWNP/Y3HVE4qPImXTgzjJTRBG6w+iACgvgJP/xFfA7gt6/PWnRNDMf
 FCA7mdgmnATFrj4+DPcJT6/7IhtO4IQ52Xmd1ef0/+fS1pk9NBaEL6Ujf8JhdCjEwcuZ0sU4
 QAcA2h98NeDW8WGRL8MdpULVkcpfcW06IReKZGxXy/Qzjh7HIppWqlm5G7u7kktdGWCetzpz
 4QD5MSdGDeYO2nCK20N5KnAwPhu4mrWnPFtFnuq3R3fWvFQ8u1qtPsL8+ylXYLaQiOTV3FRV
 xUGK8qjal/nEX3ZcsDNpFb0o7eQPPnPatJlUl9ntMU/rDzO2xbq/ZBwBU9Y+6oJUMUgxaxZY
 6SLe1giNPuFdMGxK5SoODzYVvZIBQkQe+pK74T4mmXtkCxy0Czqq8D+kCu/Ki4mTBXe3tzQm
 asPHqC4vJ0+MlVDJppBvMzu3PaEKJjVjm+37ck1AdrIVSywbz63oDdoAP4UMfO8hYngo7uhY
 wc7c3keWrfhpc6R+MLgMb2Jmnv07tIsswLUrN7MOHUrTAiyxW9BJTSpgE7jLw7Qv7204C7n9
 1SxQepSkUj2bewoYzUBrCWs0RNbOwU0EW6zK3QEQAN1LZ11oc6mAIw1Rh7wdG2eBzv/ifbdS
 1g0j6wzZ/dIktvfYnkU5QvYwOn7j/dmYw1mlp3sh7Eumwmu4LDEAn93qQPE8hRJePLFThZx9
 LP9RrY4D2BS7IAfNxIpoiTkxovIrLOzQqebm3qxzAJk0JTRtYIjneZff0MrYGP/Wnhnb9qIU
 dmT0UA5K1mynBpHfa31DjWWNSUWohS5245KedzmrrHoBRURcNFZmofk5L5I+Fw7gp22cSIOc
 4lDYQI/KFXFdR1EhxZBUX3ITd81gINSzypTFdfmzyvhaFJaz5cHReUvFAG9TEBxpTFgPiXGE
 3I+ORzpm8WJK76NTLFicJZ/B90T4p6HXLtoPixhCxY0c/xVta4B1r/sBnOnE0IkNgNMhJh6G
 1VqKsXDrWyd96tvONw5cd3xq+SQp0CoXT5A7ExQGg7Lynel/pCJ5JWEWKLWvkKxLFXTUkSJh
 g5YU9i1uodWsvm0mQltTMooE+/yifhymKp/7tLZuguzQ+vto1jnc96V48DR6yIXB+c9CgMVq
 DYYk5o+XM5pcxAcyqVxAKQ7DGd/nriiZRUlvdGGgyjR0sJWMhWsWatNycVfruX7Zfz51PlEi
 59nlNj5/ZDoXu0EYEhl4hrDLn8RUKjve+1mx6/YA8ixGE+RPOZ5PUNAouw/pXWD2ucRISe+s
 8nbtABEBAAHCwXYEGAEIACAWIQTzzCY9v4DO7zFvCzcVGGxnArFEVAUCW6zK3QIbDAAKCRAV
 GGxnArFEVDUnD/wIkxMssF3u1GHcD+a8A1Iaa477dbMRgPUrsz2k0S601dwK8eJRuQWXOk+e
 SiwSwXRn3feAfYR2uRaE4lB+wsapkFZU+ZO9VVh1R2qWcetF8JJk/gEpPFYltT9bkdDmCRRx
 URePkpqlZMYOJSJWI6ZmqCteloV9ed/4XJVgknGISot7u4Umdl3RdNLMGACU3HvodUq6F8T8
 n0x6XMvguG0t1G4br0DTL+fabBh50xFxpf5hII5K8Iw1r14GTYgxIMzIfcGWVQ+O2lq5UKsU
 Dm9o/z11QfxuukCqZWWGoteaW90Z8SynN3RhDr3d3Q/VyZ/xXCQhQ5VprMOyiNmm2EMXPFPr
 RKOz2ZdTcKIFO1Xj+7GmElnwlIrO2wrGre2fXHeaWbGLiTNlcyWnuEGI56OivfZne1uiY/GV
 k2W5FlpfJPeBVUKiKhCmp4hOb9mC7ICBSYS1UmCjguR8QSUuKQFiwZ4qi9hnko8b+OT7q8s7
 NaYmgD04Jjgth0YKGZxd3Mf3ngg+hSU+B6ngLd0wkLsjzDwU9OJpuW9kTPrx0iwNZfnTU87k
 YuJAJRfZmG36ySM8JSPXjnkLiHTGc4vtwbS+FGrS6D7nV69+40JbvkKFfHWTyXLjE6+jkOvw
 ThNCJSdPKjl0MMk2QmY6TGjjrlR+yewhQ2VZfzflJwuAQ2SVog==
In-Reply-To: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
X-Headers-End: 1x2Ffs-0005h7-Bu
Subject: Re: [Openvpn-devel] It's been some time since I've looked at the
 OVPN source code but I found some cool TUN interface flags recently!
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Am 03.09.26 um 23:37 schrieb Jon Chiappetta via Openvpn-devel:
> Hey all,
> 
> I've been busy in life and I haven't had much time to keep up with the development of the OVPN source code and all the commits and everything (it's been a little while since I last posted). I ended up creating a custom framework for my own personal use that is based on the original modifications I did for OpenVPN (multi-threaded, bulk-reads, TCP-only, standard-MTU). I was able to get over a gigabit speeds on my wifi client with this network-wide VPN solution I have now.
> 
> I found these 2 new-to-me parameters for TUN interfaces which are really cool and I didn't know existed (I also didn't see them last time I checked the source code here) - IFF_MULTI_QUEUE | IFF_VNET_HDR. Obviously the multi-queue flag wouldn't work by default here (since it's not multi-threaded) however this other one is pretty nice if you adjust your buffer sizes to be much bigger :)
> 
> For example, I was able to read thousands of bytes of data in one call from TUN if you set the below parameters in C:
> 
> ifrq.ifr_flags = (IFF_TUN | IFF_NO_PI | IFF_MULTI_QUEUE | IFF_VNET_HDR);
> TUNF[z] = open("/dev/net/tun", O_RDWR);
> ...
> erro = ioctl(TUNF[z], TUNSETIFF, &ifrq);
> if (erro < 0) { printf("%s ERRO TUNSETIFF [%d]\n", date(), z); }
> ...
> int leng = sizeof(struct virtio_net_hdr);
> erro = ioctl(TUNF[z], TUNSETVNETHDRSZ, &leng);
> ...
> if (erro < 0) { printf("%s ERRO TUNSETVNETHDRSZ [%d]\n", date(), z); }
> unsigned int offl = (TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6);
> ...
> erro = ioctl(TUNF[z], TUNSETOFFLOAD, offl);
> if (erro < 0) { printf("%s ERRO TUNSETOFFLOAD [%d]\n", date(), z); }
> 
> I don't know the full history here yet and am still learning but was this option ever considered to be implemented for OpenVPN?

I had a quick look into what IFF_VNET_HDR does. And it seem that
IFF_VNET_HDR does GSO/GRO and basically merging multiple packets into 
one on receive and send. This works probably well on a client as that 
does not forward IP packets. For an OpenVPN server, this will probably 
really mess with the packets as it changes the segmentation of the 
packets traversing the OpenVPN server. This will probably work for 95% 
of traffic and cause extremely hard to debug problems on the rest of them.

Soe this needs a lot more careful consideration when we could use this 
flag as MTU related problem are already often present on connection and
this flag has the potential to cause more of them.

Arne


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
