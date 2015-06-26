Date: Fri, 26 Jun 2015 16:36:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626143636.GY382@...1296...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
	<20150626112401.GU382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2y4P1dL7nHeV/f/5"
Content-Disposition: inline
In-Reply-To: <20150626112401.GU382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--2y4P1dL7nHeV/f/5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 26, 2015 at 01:24:02PM +0200, Gert Doering wrote:
> This is more wondering about what we *should* do for persistant tun=20
> interfaces...  (and, now, why your tun ifs behave that way even if they
> are not actually persistant :) ).

Mulling over this for a while, I think I've come to a conclusion on
"what we should do", and "what we should do in the 'persistant tun'
case" (#141)

 - normal case: we do "ip addr add" and "delete" - proper housekeeping,
   and having IPv4 and IPv6 in sync  (so, Holger's patch for Linux,
   and possible similar additional code for all the other OSes)

 - if someone really wants/needs a persistant device (created with
   "openvpn --mktun --dev tun3" on Linux / "ifconfig tun3 create"=20
   on *BSD), and expect it to always keep the addresses on it, they=20
   should call "openvpn --ifconfig-noexec".=20=20

   This will then neither add *nor delete* the IP addresses on the=20
   interface (of course, in that case you need to run the ifconfig /=20
   ip addr statements manually before starting OpenVPN, or from an --up=20
   script which can then choose to just ignore the error if the address is
   already there).  So this would cover the case "I want <daemon x> to
   listen on my tun device, but it cannot rebind if the interface goes
   away".

Simple and pragmatic enough?

(Having OpenVPN check addresses for persistant tun interfaces, and only
add them if needed, and actually *change* them if needed would be a cool
thing to have, but we have no infrastructure yet to do so)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2y4P1dL7nHeV/f/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY1jdKkuBuNlUUl1AQKpTQQAqVTDdofwQU+yAvCJHs6zI/S0lpoYPQnQ
MKIeD1CNUINlg5WE05E6JXtkHKlb5/dtXgKoz/KpRFL2Rk48G8gTyKd8Gdj3ukfw
ePX7JN2nmwdYBNor5+vvtLZLzVrkIDq9WkxAUHn+aODN/V3wqiw/e6CSkbkrHThz
ZWzicSjT/Kw=
=dnUF
-----END PGP SIGNATURE-----

--2y4P1dL7nHeV/f/5--

