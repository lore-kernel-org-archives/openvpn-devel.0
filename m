Date: Fri, 15 Sep 2017 17:40:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170915154011.GM70062@...1296...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7JDdbSaSV851Oucw"
Content-Disposition: inline
In-Reply-To: <1505450463-459-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--7JDdbSaSV851Oucw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 15, 2017 at 12:41:03AM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Eliminate the confusing message that says "explicit-exit-notify is ignore=
d by
> previous <connection> blocks" when the option is pushed.
> Reported by: Eike Lohmann e.lohmann@...1294...
> https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg04052=
.html

Not sure I understand that patch.  If I read it right (and I might not),
won't this just make this option non-pushable, thus suppressing the error
message by disabling the option?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7JDdbSaSV851Oucw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZu/RZAAoJEB2Cnv7KVigSEbwL/1a7zAXk70LD2vfjyZWMhFuA
Qr3yoUGF21P/zWxgDL12QwWTH1VNUbdvxzRnBKj8bERBg7VXJByvWN34Hc5S5yP/
+2EpyyIx52wRxpNuz5zekKecUMaMq38/SDm+9WMW5LuSooH0vx9bJ3E8l2aJYw3+
L9/xv/6XeEDwHc6NY6tOT0Kr2ZPcgu1iT1FuwIQ6tAa2PnuG/FM4DQ+d0/KXAB8h
XuQie3Tvr7R2sy4RLRUcRtF5Zh8vjFQxAeUk3gkMWQ2TbBVKveoOdqY12eP9konU
a/yWBhvl/SUUjOQiRgqDII4pGM9Mx5DOOT6+T4HXFJzMuR2DYKILTmef7eP3kntw
8kyypVi3T5/mtNjXq0oJCU3Z9XY8ggAkkxXZOPzdLX39420rcxf4OL1F2iNnFjji
5h+tZWWbKeEgoRRp7W8CJuHz+GwG8w0EucBnBvyLp9etWIC3yv+oEv9tNMNeATbE
actplbe6C92o6lv1Q73kITDBOoSK8bZCu6oscD7NSg==
=1Fu4
-----END PGP SIGNATURE-----

--7JDdbSaSV851Oucw--

