Date: Wed, 25 Apr 2018 19:09:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425170913.GG69387@...1296...>
References: <CAJ_FkANDLWH0Azus9S=OcK79Udwzsny8fQOA7Fza=CB+mcUh9g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kATYhdbhnsgsRzfj"
Content-Disposition: inline
In-Reply-To: <CAJ_FkANDLWH0Azus9S=OcK79Udwzsny8fQOA7Fza=CB+mcUh9g@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN memory usage stats
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yury Shefer <shefys@...277...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--kATYhdbhnsgsRzfj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

came across an old posting today, by chance - cc'ing openvpn-devel,
because that's really more of a -devel question...

On Thu, May 18, 2017 at 02:47:37PM -0700, Yury Shefer wrote:
> Here is what I noticed:
> 1) when I hit max-sessions and the daemon no longer accepts new
> connections (by logging "new incoming connection would exceed maximum
> number of clients (16200)"), the memory usage by the process
> continuously increases (by ~30 MB per minute). For 16K connections
> OpenVPN will consume around 3-3.2Gb of RAM and then, in a period of
> ~2-3 hours, it will consume the rest of VM RAM (8 GB total) and gets
> killed by the kernel.

This looks like we do not properly clean up memory when refusing a
new session (every new session needs memory, which is expected, but
if we do not actually accept the session, memory needs to be returned).

I guess that you see quite a number of incoming connections on top of
the allowed limit, and thus the "continuous increase".

[..]
> 2) run the process with valgrind (valgrind --leak-check=3Dyes) but it
> reported no errors. Logging with verb 9 with such amount of sessions
> is a bit unrealistic.

Valgrind might not notice because our memory management is... quite
a bit advanced...

Can you reproduce this with a much lower limit, like "max-sessions 5"?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kATYhdbhnsgsRzfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4LY4AAoJEB2Cnv7KVigSZt4L/j4b2k5gXBiS5ZyqJVfcs3/8
kukz96PKlVY4whwUJ5CiuWYPL1n6Tg/AeucEFhJtst+hrJJ7Z9g3zi5puEjen7ng
vdeegHb+ACZB0gQZMcUa2OUAoK1pQyGm++5boj5G9a7+LZ6DO4zBHpY3lAUQEC2s
ki8o48oEMuYDWNrTDusGx51yQSWykelR9I18N456MdtwTOwJZQQJfoKgC+V4KhJ5
AslTOVmQjWEiT/nmCa9rG6LGJ7S1j8evfsByJ2jMe7LVPPATKspkt5hng2vIP13p
6PWtFNnAHjOFbc5ws9OYtR1DRYXuC8+HrWElqs6VNLTIE85EgxTDdfTFZsGg74Fy
WEQIMoD0r6LL5hybv4LN1ignYQJOcSE0uXlBB0KTzogt+T9b30KVr/jnB0AdyRPO
fUQjKSRwDw1ex96Rv1SzUf25C1pFBoNZxUIteDA+Tco3rnn4F3QH39t2PNaazetb
kefF4b/I1Or2aa1+R6oKIo742AwvgPFyGCRkrrgbfw==
=M3xi
-----END PGP SIGNATURE-----

--kATYhdbhnsgsRzfj--

