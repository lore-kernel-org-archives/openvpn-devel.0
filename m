Date: Tue, 29 Nov 2016 22:08:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161129210833.GK1013@...1296...>
References: <1480386424-30876-1-git-send-email-selva.nair@...277...>
	<201611290804.uAT84UDN009666@...2054...>
	<CAKuzo_hwb0Ysf-fG-EbZbSdSHNCAfByp9soWcJOxgTCaOqBKxA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hwb0Ysf-fG-EbZbSdSHNCAfByp9soWcJOxgTCaOqBKxA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Map restart signals from
 event loop to SIGTERM during exit-notification wait
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 29, 2016 at 04:01:34PM -0500, Selva Nair wrote:
> Just to be sure, I think the second ctrl-C or SIGTERM during exit-notify
> wait should cause a prompt exit without waiting for exit-notify to
> complete. That was the original behaviour and is supposed to be unchanged=
...

It does :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYPe5QAAoJEB2Cnv7KVigSK7cMAI+G/RwXbxapNRGrBD4TPF3Y
NwvSwXjXr6UV1TK4Tz2V1KwsbBja5fMOQOZ0K2Fs+CC3c27auNWbKIeDCtaP0u8L
u8/avHQ0E8o4GORl+QGXh8N6rS15Y5uIF7BGwUZEL7ig6vP0zCqQ1oXj3EBXvfLo
t80djgX/OKKvLgNQMH7xJLD+SIh4/pgDxHJNZvddGzLxNG1RMHRIWIEJMexFf0RG
a/qtVPGeYpAZs2EFMsLecdVgwHATuuOydfKvoB9KDqFiifk5m5Oryiv/R8cY25SG
635D9pfNFyXFt0/0LOvNih+eKwJ5vfbmoAZ4yiZujajKACuVVPvt4/rqwZlHwHeE
mZBGogIqbE8nSqqjKpcCNrKbO92/m1ZgyAHkqxA2eCOqO0Lwvyt2xlpDteuGZSht
uZvGnXXm9KetpOmCeOF8vyoT6ueMs1QcwiuT60H6P6bL3RfbSFaCFx4nWAYv3CLC
nYdgJr8Mc8wwRKAl7wuxBy/Mh+XZhdl3jxeOAtDghQ==
=FoZy
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

