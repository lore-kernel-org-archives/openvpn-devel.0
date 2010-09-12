Date: Sun, 12 Sep 2010 19:47:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100912174719.GP10703@...1296...>
References: <1284075134535506500@...1315...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cycRQitB/3DOnQyb"
Content-Disposition: inline
In-Reply-To: <1284075134535506500@...1315...>
Subject: Re: [Openvpn-devel] TCP Window Size - Impact on Data Throughput
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net

--cycRQitB/3DOnQyb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 09, 2010 at 06:32:14PM -0500, openvpn@...1315... wrote:
> I can't explain the information below, but hopefully someone a whole=20
> bunch smarter than me understands it - as it seems to help with=20
> TCP throughput in OpenVPN (the holy grail??? ... :-)).

Did you change TCP window size on the client, or on the OpenVPN process?

If changing the TCP window size on the client helps, this is somewhat
unsurprising - OpenVPN adds delay, and TCP with a too-small window size
breaks down miserably if the delay goes up.

What's the "default" TCP window size here?

Given that you can even see an effect in the "direct" case, I suspect that
your machines' TCP window sizes are *way* too small - and this has not much
to do with TCP-over-TCP, but you would see the same effect for UDP-based
OpenVPN as well.

Simple example, to clarify the effect of round trip time (delay) on
TCP throughput:

TCP uses a sliding window, that is, the sender can send as many packets
as the "window size" permits before the sender has to wait for an acknowled=
ge
from the receiver.  Now, if the link has a noticeable delay AND lots of
bandwidth, the bandwidth * time product adds up to the minimum window size
you need to use:

 1000 Mbit/s link
 1 ms delay (1/1000s)

1000 Mbit/s * 1ms =3D 1 Mbit =3D 100 Kbyte "in flight" - that is, if the se=
nder=20
keeps sending packets back to back, with no pause in between, it needs to
send out 100 kbyte before the first ACK packet comes back.

If the sender only sends 10 kbyte because the TCP window size doesn't permit
sending more, these 10 kbyte are sent in ~ 0.1 ms, and then it has to=20
wait for 0.9 ms for the ACKs to come in - send again for 0.1 ms, wait 0.9 ms
(roughly).  So it's only using 10% of the available sending capacity, and
the performance sucks.


So, in your examples, my guess is that the TCP window size is "barely large
enough" for the "direct" case (but the link is not fully saturated unless
you increase the window size) - and since OpenVPN adds some noticeable
delay, the bandwidth * delay product goes up, and so needs the window size
to be able to fully saturate the link...


Try with UDP... :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cycRQitB/3DOnQyb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTI0SJqkuBuNlUUl1AQLxGgQAjJr7Zc8UJj3YzugzfNwz2q24ADRk9YNg
Cvv0W/KAeWd5JlW+nqEL1H0/LUE+qlHP2BwgN7P2biNN6rHGk4b8TeF8l7aMpV8M
8x3jmawl2P6ZFnlGyuk5dq+egqlwT2zx6rgGkfPrTuNnJFrdTYgIvOfuqwjsriEX
2COkx8t+Xbg=
=4Myr
-----END PGP SIGNATURE-----

--cycRQitB/3DOnQyb--

