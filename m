Message-ID: <4EE0EDA4.2090704@...1338...>
Date: Thu, 08 Dec 2011 18:02:28 +0100
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <d3f7c10b2411aa41afce3788970ca839@...1528...>	<4EE08E3A.7010209@...1114...>
	<CAOazyz1MCx8x42YK6-fQs0iAzDS0kRLvZ1sw4hvmcZ4gikJrUA@...278...>
In-Reply-To: <CAOazyz1MCx8x42YK6-fQs0iAzDS0kRLvZ1sw4hvmcZ4gikJrUA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------enigB428A667417C37D944C62498"
Subject: Re: [Openvpn-devel] [PATCH] Add option to disable priority tagged
 packets (VID=0)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: michael-dev@...1528..., alon.barlev@...277..., davids@...1347...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB428A667417C37D944C62498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael, Hi David, Hi Alon,

On 08/12/11 09:33, michael-dev wrote:
> This patch adds an option to disable the creation of tagged priority
> packets with VID=3D0. This is for the feature_vlan_tagging
> openvpn-testing head.

Great to know that other people are using the patch-set too.  Your patch
is quite similar to a patch [0] we've been using for a year, but which
never got pushed into the upstream branch because it was missing
documentation.  So I fully agree that it's necessary and I'm very sorry
that you had to duplicate the work just because I got massively
side-tracked.

> I tested the vlan feature and it works fine for me (no dhcp tested).
> Therefore I bridged my eth0 (LAN) and tap0 (OpenVPN) but as my switch
> flags arp replys with priority, the client ended up with 802.1q
> tagged (VID=3D0) priority packets. These were not expected on the client
> (Ubuntu 10.04 lts) and I found a linux kernel discussion from summer
> 2010 about supporting VID=3D0 priority packets, so I expect more linux
> clients (windows untested) to not support this kind of packets. This
> option prevents the creating of these packets by ignoring the
> priority information.

We're currently using the VLAN patches at three locations at our
University and all of them have the strip-priority option activated, so
I'd say that it should be the default mode.

I'd even go so far as to say that this doesn't even need to be
configurable. Vlan-tagged packets should never remain tagged (neither
vlan nor priority tagged) when forwarded to an untagged network.  Only
when the packet is priority-tagged without vlan-tagging can we assume
that the sender knew full well that some clients might not know what to
do with them.  The reworked patch [1] does precisely that, but it's
currently only compile tested, because I ran out of time again.  (The
reworked patch is part of the VLAN patch-set [2] that was rebased to
master.)

To fully test the rebased patch-set in our setups I will also need to
port another patch-set (regarding deferred client-connect scripts) ...
which is part of the reason why I ran out of time again.

As I've been getting some friendly pressure from the people using the
VLAN patch-set (and the other patch-set) at our Uni, this hopefully
provides enough motivation to get me working on this stuff again... :)

On Thu, Dec 8, 2011 at 12:15 PM, David Sommerseth wrote:
> Adding Fabian to Cc, he knows more about the VLAN code.

Thanks for the nudge.

> With this feedback, I'm willing merge in the feat_vlan_tagging branch
> into master.  I'm not sure if this should happen now in the v2.3 time
> frame (which is getting more and more ready for alpha/beta releases), or
> if we will take it in the next round with v2.4.  But I will bring that up
> for discussion soonish.

What I was meaning to ask: Did you guys come up with some kind of test
framework in the last year?  I was looking at creating something like
that for the VLAN patchset, but it was far too time intensive for my
extremely limited OpenVPN time budget ...

So would manual testing reports suffice?  And Michael, would you be
willing to review and test the full, rebased patch-set (as soon as I'm
confident again that it actually works)?

Am 08.12.2011 11:27, schrieb Alon Bar-Lev:
> Missing usage, man.

There are probably not *that* many users, agreed.  It's probably more of
a "large enterprise" feature, as only people with VLAN tagged networks
would be interested.  For example, our university is very fond of layer
2 networking and therefore uses VLAN tagging extensively.  OpenVPN with
VLAN tagging provides a perfect match, allowing a single VPN entry point
for access to all the different layer2 networks.  I imagine that other
large organisations could make use of this feature too.

So the number of deployments using the feature will probably never be
high.  But the number of users depending on it, might not be as
insignificant.  The two main deployments at our Uni (currently both in
public beta) currently have about 100 unique users with several thousand
potential users.

Cheers
Fabian

0:
http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=3Dopenvpn.git;a=3Dcommit;=
h=3Da642faabff003e8f199341b8af407e91c66e568e
1:
http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=3Dopenvpn.git;a=3Dcommit;=
h=3Df420df8521b5821fd7ddbbd742b515ecdac9c6c1
2:
http://opensource.fsmi.uni-karlsruhe.de/gitweb/?p=3Dopenvpn.git;a=3Dshortlo=
g;h=3Drefs/heads/feat_vlan


--------------enigB428A667417C37D944C62498
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJO4O20AAoJEPGZx5Q4PJrzC1YQAIzWo8nDvmnQiJUeIDVpLbl/
C4VBr0L1sqg48xYBOCVOFFLMc+wuIbo32KtsDgoRac4hRbeh0MqhfNWqD1DIT0Bm
IRZyDib6osl0ygHJLEgB99DePPJ8GGh5XZw5KQ1HUrYBAoCgNXQrTtqF6575PM/l
sGf09xaXo0sUBYiYJFBmEL+C2e1Gb9yAYdpYBJ3cG+I7GWS0npodzqjFQXJQQY8C
4TB/of/ZI0FrWLUwTO8s2vH8SYdHGf+tQJWzQnuCBDplnVMkponikfHBOKjZH1hO
UClaDXKY9Nw6WmitxYcD93YB1GtsSUN9/DbWAbzLz+y7soIjIlkGGRlS/FY5ErjI
MNdSYXqW1eeuVKHGxMwFX4fnPQltpJJzgRWlUMfAerQFGTXYU3+r005wrfKKhgBv
kzVYJ4T7Q3mLlzA+jdcEY91qBjaKVdQgAK97O3QUDD93NuCXXT1997htfFGaBt65
MfM72SvSZH/aBCyyBYR1Tgb45OsACtFTcqofCa+CsPYGTqlDI1D5I4lYoxbyyOmm
mwytWJvLY5nduqxCclRVeJLoablfWsw4juZ8txQDFQ5/5fH00F4aQ7u6IxuOSwGQ
e9+W/mLvP+YcdLiuL0bmHA8QD3cfZfbycnnYrs4KmwEWlx7sncN1Ewr0yxNjUNyv
gHB+zNf4DhifEmbrRq1t
=KhuF
-----END PGP SIGNATURE-----

--------------enigB428A667417C37D944C62498--

