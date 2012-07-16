MIME-Version: 1.0
In-Reply-To: <CAEsd45SyHA=ukYxhvSCAmMRYwg6QuaqT_1eW6dFv-p078_EPZQ@...278...>
References: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
	<CAOazyz3AqvSu05xSDQn=0MX-4QV-mFB1SPNh8SSVL_y3=O5R+g@...278...>
	<CAEsd45Q2VTHKu8aE0adSPCNRsRTCUCUzfPqj_tWsLQe6XHk1TQ@...278...>
	<CAOazyz29f5yG19ygoY4y0yTf2GdYTfKsW_bHTkOib2RCQqgKvQ@...278...>
	<CAEsd45SyHA=ukYxhvSCAmMRYwg6QuaqT_1eW6dFv-p078_EPZQ@...278...>
Date: Mon, 16 Jul 2012 19:35:47 +0300
Message-ID: <CAOazyz2VF2DYrpqVmE4TWi8TD5Wy1MXdgJ+zaMC9CAjVvfO3QQ@...278...>
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

Please try:

./configure CFLAGS="-Ixxx" LDFLAGS="-Lyyy"

Should be simpler.

Alon.

On Mon, Jul 16, 2012 at 7:24 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> Thank you, Arne and Alon -- I finally managed to get Tunnelblick
> more-or-less built using the new build system in 2.3_alpha2.
>
> For the record, I had to use xxx_LIBS="-Lyyy" (not xxx_LDFLAGS) before
> ./configure, to get it working.
>

