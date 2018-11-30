Date: Fri, 30 Nov 2018 16:38:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20181130153802.GW962@...1296...>
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SIa6NwWvRsr2U8xx"
Content-Disposition: inline
In-Reply-To: <20181029172040.17034-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--SIa6NwWvRsr2U8xx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 29, 2018 at 06:20:40PM +0100, Arne Schwabe wrote:
> This can be used to redirect all IPv6 traffic to the tun interface,
> effectively black holing the IPv6 traffic. Without ICMPv6 error
> messages this will result in timeouts when the server does not send
> error codes.  block-ipv6 allows client side only blocking on all
> platforms that OpenVPN supports IPv6. On Android it is only way to do
> sensible IPv6 blocking on Android < 5.0 and broken devices (Samsung).

Generally I agree with the need for this, so feature-ACK.

Functionally, I've tested this on Linux, and it does what it says
on the lid (I've only tested client, but if that works, I expect server
to work as well).

Style-wise, there is, unfortunately, still way to go - missing brackets,
non-pretty alignment, etc. -> so please run uncrustify, then send us
a v6.

Besides the uncrustify things, please leave af_addr_size() in socket.h -=20
its only callers are in socket.c, so the move to proto.h does not make
any sense anymore (I assume you wanted to call it from ip_checksum(),
but since that one does a local decision for 4/16 byte address size,
moving the other function is no longer needed).

Lastly, the context of the hunk in options.c has no=20
 #ifdef ENABLE_PUSH_PEER_INFO
anymore, but "master" still has that - so please send the patch that
removes this #ifdef to the list as well :-)


So, "changes requested" :-) - thanks.

As a side note, how did you test the "without ifconfig-ipv6" variant?

When I tried this it refused to install the IPv6 routes...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SIa6NwWvRsr2U8xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcAVlaAAoJEB2Cnv7KVigSt04L/RJ1fNVdYE77bU0v2V+GSSKe
PfFbrrTsaG2ilgedUadDdM+PXFmCBE6ogf8HCs+eOEBm3LZhfi11KodD7O2vjE9S
WgPosks9ruU87p3NIz9pVSd5iFfR8FidFHlY9qeArwef0rHhkHL8rm2qg6lym7mz
E2/oouDjrkpjko/tgA2+HGnmeAjQE3iyD7c/xUgeKwNlg/oLDTzsZbmwBh33gVb3
F+vqHFufITFx/ZNiHZ47JCQrMRUdIhAGLyPCORlSIW4Yki4m/UtrqSWoXViCcHjK
Gv1/bxvMm5MnHY4GSmNzbhpLDFmysGyyerjFWi0o3UD07veLxU2RjyEh5UgV6F7f
FGK4sgXXwuhcYbaMvSX7JbSGMMaINgObc+PmfJybgGHoh3CSjBzlaH1xme2Nz8Tk
FSYWmeXsoG0qW4VgKAIC1/Mh1P2CmO7cirGKJlq6yCHTtYrPflWvjCYpACWh5Hf7
iVS+mMuKcGmSjKQ43pzDvrJ3YYLIStfC0ZYBSuOwAg==
=x5e9
-----END PGP SIGNATURE-----

--SIa6NwWvRsr2U8xx--

