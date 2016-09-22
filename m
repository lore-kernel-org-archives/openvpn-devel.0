Date: Thu, 22 Sep 2016 13:56:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160922115659.GJ78279@...1296...>
References: <1474538677-23301-1-git-send-email-davids@...515...>
	<fb0dccb2-fbf4-46fa-294f-6db437aa010a@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iiz2wIZyMWY0bhlh"
Content-Disposition: inline
In-Reply-To: <fb0dccb2-fbf4-46fa-294f-6db437aa010a@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--iiz2wIZyMWY0bhlh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 22, 2016 at 01:36:15PM +0200, Steffan Karger wrote:
> > +#define USER_PASS_LEN 4096
> > +
> >  struct user_pass
> >  {
> >    bool defined;
> >    bool nocache;
> >=20=20
> > -/* max length of username/password */
> > -# ifdef ENABLE_PKCS11
> > -#   define USER_PASS_LEN 4096
> > -# else
> > -#   define USER_PASS_LEN 128
> > -# endif
> >    char username[USER_PASS_LEN];
> >    char password[USER_PASS_LEN];
> >  };
>=20
> ACK.
>=20
> I've wondered about this before, but never got to sending a patch.  Good
> that you did get to it.

I'm not exactly happy about this.  struct user_pass is used as a global
instance in quite a few places, and this sucks up 7.5 kbytes extra for
each of them.

As Jonathan wrote, management interface can only handle 256 bytes, so
I think this should be done as part of a larger cleanup.

But it's good that you got involved :-) - what is the reasoning behind
4k for username and password here?  It doesn't really make sense to me,
but since this struct is used in pkcs#11 context, something seems to need
it *there*.


(Will it work at all, to send a 4k username and password in the OpenVPN
handshake?  James tells us the space for --push-peer-info is "limited",
and username+password share the very same space...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iiz2wIZyMWY0bhlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV+PHCqkuBuNlUUl1AQKSlwP+JVq94MR6GXLlJEaiVB70RCUJVxjCVIWm
bZZJC3CzQaC3UaYETTpYsrWNA2Sn5NEGYuQuYUCNyi+jJUCMIuBIN82cFk5bKhmE
B1TQrE6wL8jVtjmodPUtNgUoxwWGe0XjKkjgRGzSyFacIUv1VDTbH57tznAtxxDU
n7HUnBAsM10=
=pO19
-----END PGP SIGNATURE-----

--iiz2wIZyMWY0bhlh--

