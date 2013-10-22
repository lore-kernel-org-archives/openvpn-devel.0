Message-ID: <52669036.80805@...1847...>
Date: Tue, 22 Oct 2013 16:48:22 +0200
From: =?UTF-8?B?QW5kcsOpIFZhbGVudGlu?= <avalentin@...1847...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<526636AA.50402@...1847...> <52668B8D.2050908@...1435...>
In-Reply-To: <52668B8D.2050908@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Floating: Add support for floating in
 TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Steffan,

at firsts thanks for taking a review!


On 22.10.2013 16:28, Steffan Karger wrote:
> Thank you for coding and sharing! I marked your original mail for later
> processing, just had not gotten to it yet. This is a cool feature, and
> it has been proposed before on this list (see
> http://thread.gmane.org/gmane.network.openvpn.devel/7384/focus=3D7395).
Yepp, I really wondern when I discovered that it is currently missing.

> Returning to your patch, I did not fully review the code, but it at
> least has the same problem: you are using a non-constant time memcmp to
> compare HMAC's, which would introduce a possible side-channel
> vulnerability. The solution is simple: use memcmp_constant_time() from
> crypto.c.
No problem, I switched to the standard function because I thought it is
not relevant in this scenario where the time "is added".

> While taking a peak at your patch I tried to apply it on my local
> codebase, but got conflicts on both the master and release/2.3 branches.
> On what commit did you base the patch? It would be nice if it would
> apply clean to at least the master branch.
It should, but I will post a fixed patch tonight. Do you want it for master
or release2.3?

Kind regards,

Andr=C3=A9

