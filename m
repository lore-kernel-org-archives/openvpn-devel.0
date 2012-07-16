MIME-Version: 1.0
In-Reply-To: <CAEsd45SSA-Etr00DAuJvfdGL+hbhQPWMR_B2BC0Jyy7RboabpQ@...278...>
References: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
	<CAOazyz3AqvSu05xSDQn=0MX-4QV-mFB1SPNh8SSVL_y3=O5R+g@...278...>
	<CAEsd45Q2VTHKu8aE0adSPCNRsRTCUCUzfPqj_tWsLQe6XHk1TQ@...278...>
	<CAOazyz29f5yG19ygoY4y0yTf2GdYTfKsW_bHTkOib2RCQqgKvQ@...278...>
	<CAEsd45SyHA=ukYxhvSCAmMRYwg6QuaqT_1eW6dFv-p078_EPZQ@...278...>
	<CAOazyz2VF2DYrpqVmE4TWi8TD5Wy1MXdgJ+zaMC9CAjVvfO3QQ@...278...>
	<CAEsd45SSA-Etr00DAuJvfdGL+hbhQPWMR_B2BC0Jyy7RboabpQ@...278...>
Date: Mon, 16 Jul 2012 23:26:32 +0300
Message-ID: <CAOazyz09K1s4uJvOy35v1Ggc_Y2uiDdWMQ+JLtZXhAVv315NKA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 3.3_alpha2 build problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1740...>

On Mon, Jul 16, 2012 at 11:24 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
>> Please try:
>>
>> ./configure CFLAGS="-Ixxx" LDFLAGS="-Lyyy"
>>
>> Should be simpler.
>
>
> Thanks. Although
>
> LDFLAGS="-Lxxx -Lyyy -Lzzz"
>
> builds, but it causes config to output "checking for PKCS11_HELPER... no". I
> assume that if it isn't finding pkcs11-helper, then it might not configure
> the build to support it. (Otherwise, what's the point of checking for it?)

Right. For pkcs11-helper you need the PKCS11_HELPER_{CFLAGS,LIBS}.
But if you build static, you cannot use pkcs11-helper, as PKCS#11 is
shared object.

Alon.

