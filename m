Date: Fri, 24 Jun 2022 13:20:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YrWeCXDXPXR83997@...1296...>
References: <20181206171033.61310-1-gert@...1296...>
 <06dfe01b-95dd-ae08-4b30-96f85ac2bd9d@...1856...>
 <80e6882a-dd00-eeff-151b-1b67d6e61103@...2181...>
 <a83d231f-2f4b-c51f-e71a-94f13b699ee2@...2181...>
 <YrWRSH5di07JxGmW@...1296...>
 <0c27edad-d696-5857-02ee-d2ef8e6286d1@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kC4bRfamNSYlFPCE"
Content-Disposition: inline
In-Reply-To: <0c27edad-d696-5857-02ee-d2ef8e6286d1@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Rate-limit incoming
 P_CONTROL_HARD_RESET_* packets.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--kC4bRfamNSYlFPCE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 01:15:05PM +0200, Arne Schwabe wrote:
> > *This* patch won't apply anymore, but Arne said "we're now much faster
> > in replying to packets than ever before" so we might indeed need a
> > per-source-ip rate-limiter, to something like "10 per 10 seconds" or
> > so (inventing arbitrary number that should be more than enough even
> > for "5 users behind the same NAT reconnect at the same time", while
> > at the same time too low to cause harm as a reflector) for the
> > initial reply.
>=20
> Yeah. Keeping a per IP table is adding a lot of state to manage that.=20
> Maybe instead to a (configurable) overall limit like 100/s?

This would permit an attacker sending 1000 packets/s to an openvpn server
to drown out 90% of all legitimate connection requests from everyone=20
else...

So while I see your argument about "please do not introduce state again,
we just got rid of it", I'm not convinced we can get away so easily ;-)

OTOH, 100/s inside OpenVPN, and good documentation how to offload the
state to iptables...  can we teach iptables to recognize CLIENT_RESET
(or whatever they are) packets - only - and apply per-source rate-limiting
there?   iptables seems to be quite good at doing this for TCP SYNs
already...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kC4bRfamNSYlFPCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJitZ4JAAoJEB2Cnv7KVigSWMQMAJU8IMFYnJvrIdrrKLuX7JxT
m2oHHPaxz4HXFt/j0+mMfTozJ2HrR+8F2c1aMRq7nFRE/dzwTwkujJiGlArFC63r
X3znpKxVHTEzsNHTD1c66/qOsAhzditRdN6t2KWDIJiPA7xxcv+K/HRYL23Lx1py
L3dyFWZBkvW892+3pkHdTg8bNRf0rEYmLDh032ThZ1TlXGp+tyJB6D4nfw/U8llk
zFcMeSF2Oj8jqbHVBStHSrkS1GGKM6vEu8o6mShpcUmr4KAFh+Nx+t/jPVLqTS/a
q79uvqNuusyTzMmnz/vsWLpIfnqf/qBqHb6+ccccJgCRkRWkBxaZ/J1FVY4YMOmT
HEdwRBiH+pDWSzunUrnlxR1x3n7Rok+ptj9PiVKcG2xgyXgPu/cvnbEBAxYZkPTH
ALkr+8g+PKjqFbD1D10T9pZX66leQ8+/QC+LcWtcNtzN32aESE2TzaBn1pF+LniJ
G1v54JXfddWssRNQ/NwUUY/eH2rRewtPlSnYqMqScg==
=6zxr
-----END PGP SIGNATURE-----

--kC4bRfamNSYlFPCE--

