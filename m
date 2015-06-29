Date: Mon, 29 Jun 2015 20:22:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150629182224.GN382@...1296...>
References: <1435581995-11820-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dwDKNx4nQiBp4HDk"
Content-Disposition: inline
In-Reply-To: <1435581995-11820-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Report missing endtags of inline files
	as warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--dwDKNx4nQiBp4HDk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 29, 2015 at 02:46:35PM +0200, Arne Schwabe wrote:
>  	}
>        buf_printf (&buf, "%s", line);
>      }
> +  if (!endtagfound)
> +    msg (M_WARN, "WARNING: Endtag %s missing", close_tag);

Generally speaking, ACK.  I wonder whether this should be M_WARN or
M_FATAL, though?

Tested, nicely reports the missing </key> in my test case, but then
proceeds to "not do what the user intended"...

(Can't commit it anyway, as mid.gmane.org is not giving me URLs right now..=
.)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dwDKNx4nQiBp4HDk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZGM4KkuBuNlUUl1AQIsTQP+MGISfCioQSkFk6ZNUURJ2ol2xY3ycJBs
TIFR9SOJ6iuuZxYV4tMzfIfrcf/PAjgi64fmhhoKC5BotWN5ouNOoAErLmRhAGKR
D70x0vNAaBt4YPq/enzL1DekArw7DcolRvr3Do6fOzaoWTT/FD/Pyf67Bh6I0rja
6ricqY1th+Y=
=ZPbO
-----END PGP SIGNATURE-----

--dwDKNx4nQiBp4HDk--

