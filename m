Message-ID: <52668B8D.2050908@...1435...>
Date: Tue, 22 Oct 2013 16:28:29 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<526636AA.50402@...1847...>
In-Reply-To: <526636AA.50402@...1847...>
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

Hi Andr=C3=A9,

Thank you for coding and sharing! I marked your original mail for later
processing, just had not gotten to it yet. This is a cool feature, and
it has been proposed before on this list (see
http://thread.gmane.org/gmane.network.openvpn.devel/7384/focus=3D7395).

That patch did not make it in, primarily because we (or at least I) got
distracted by an issue in the crypto code that thread pointed us to,
where a non-constant time memcmp was used to compare HMAC's.
Unfortunately, after fixing that issue the thread never got the
follow-up it deserved.

Returning to your patch, I did not fully review the code, but it at
least has the same problem: you are using a non-constant time memcmp to
compare HMAC's, which would introduce a possible side-channel
vulnerability. The solution is simple: use memcmp_constant_time() from
crypto.c.

While taking a peak at your patch I tried to apply it on my local
codebase, but got conflicts on both the master and release/2.3 branches.
On what commit did you base the patch? It would be nice if it would
apply clean to at least the master branch.

Regards,
-Steffan

On 10/22/2013 10:26 AM, Andr=C3=A9 Valentin wrote:
> Hi,
>=20
> no comments for this patch? It is really cool if you roam from wifi to ed=
ge on mobiles,
> you are immediately reconnected to your vpn after a connection change. No=
 1 minute wait
> for openvpn to complete the openvpn authentication. (cause is the ~1s GSM=
 EDGE roundtrip
> time) If you travel in a train through, this will enhance your experience=
 drastically.
>=20
> I would really appreciate any comments on this, or if you have any hints.
>=20
> With kind regards,
>=20
> Andr=C3=A9
>=20
> On 14.10.2013 23:20, Andr=C3=A9 Valentin wrote:
>> Add support for floating in tls mode using the HMAC of a packet. It costs
>> a roundtrip through the clients. Because it is based on the HMAC, it is
>> secure in ways of cryptography. Before the iteration starts, some sanity
>> checks are done.
>=20
> -------------------------------------------------------------------------=
-----
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most =
from=20
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D60135991&iu=3D/4140/ostg.=
clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


