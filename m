Date: Thu, 27 Aug 2015 14:58:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150827125842.GL34798@...1296...>
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
	<55DD7A68.5060603@...1227...> <55DE2D14.7050804@...1490...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L2YZAWjVjAQ1Un1Q"
Content-Disposition: inline
In-Reply-To: <55DE2D14.7050804@...1490...>
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
 Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>
Cc: openvpn-devel@lists.sourceforge.net

--L2YZAWjVjAQ1Un1Q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 27, 2015 at 09:18:12AM +1200, Jason Haar wrote:
> On 26/08/15 20:35, Arne Schwabe wrote:
> > Okay yes. Active FTP is broken by our simple nat implementation. But I
> > think FTP, let alone active FTP is dead. I am not sure if we should
> > support this in our simple NAT implementation.
> I agree. Surely this would be the beginning of a complete beat-up?=20

I *could* argue that someone has been asking for a new DHCP option=20
recently... :-)

I have not looked at the code yet to see how large or invasive it is,
but as it obviously has a fairly reasonable use case ("support old=20
equipment behind state-of-the-art VPN tunnels"), I can see why the
feature make some sort of sense.

OTOH I would do it differently altogether - put an OpenWRT box into
the network in question, OpenVPN on top of it, and use Linux iptables
NAT to do the actualy natting back and forth and whatever is needed,
as it will always be more powerful than what we can build into OpenVPN
(and I'd totally not run important service stuff on windows).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--L2YZAWjVjAQ1Un1Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVd8JgakuBuNlUUl1AQIcvwQAqsAdoGvIH9/E03GbTRPT/k9AaniJpy/E
fFvkg/CtMYzVehPsPe+lGqxlXsBbTVNnqX5AJkBMAL81aIK2XcwLrNAQzpiVH55g
S1QNnwwuSbAfk402xIM+WKlI/8++W/b5KM0lSZqBD5DXQS78MwKXOr4D2qdAgVcQ
qLJW6ZCHCW8=
=lupQ
-----END PGP SIGNATURE-----

--L2YZAWjVjAQ1Un1Q--

