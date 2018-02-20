Date: Tue, 20 Feb 2018 17:14:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220161429.GB69696@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1511026858-23281-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
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

--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

well, today is the day that I get to break things, it seems...

On Sat, Nov 18, 2017 at 12:40:58PM -0500, selva.nair@...277... wrote:
> +    /* The default value of REG_KEY is the install path */
> +    if (GetRegString(key, NULL, install_path, sizeof(install_path), NULL=
) !=3D ERROR_SUCCESS)
> +    {
> +        goto out;
> +    }

This seems to break on Win7/64 for me.

Trying to start the latest iservice from Samuli's snapshot builds (master,=
=20
but I assume release/2.4 is also affected) returns a non-useful error=20
message.

Looking into the event viewer, it tells me:

	openvpnserv error: Falscher Parameter. (0x57)
	Error querying registry value: HKLM\SOFTWARE\OpenVPN\(null)

("Falscher Parameter" =3D "invalid argument")


... so maybe this is not the right way to query the default path?

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajElkAAoJEB2Cnv7KVigSjxkL/AhPouxoXYXYSFScn0QZfDMC
59pLUxomZE/EnOgXv4BajlAyo4+G++88MNgXwbwuQyPIYlZcXAUM9Z+8QJsQSR0A
h3nzF5Ecq60MIwsvKB4AajpBn37fLlfHdvM38LbtUATd1A13xXMdMMBmJmGE+cU3
89LaCNfvzd8Ri68qMywmdaIF9e5eaJb0GDzJEzZ/Vv2FPTIBLtMTZRdfg2wK/BUk
k2mBk5VOtZPIdxEXyfvN8Pxiuopm/w71/EDTOR+08aooN88+ASTjPE2XAHOLKXrC
0n37If8Y/p/f5sCxXB5F75L6YXxTy8NpBipXmXygkLle+YhSW6Lw5YVFtivO9gxA
0RNvrRt8AGzWhD0IBf3o4BpNUnvRRcrZoCOxFEctWyUw2jH42BKJ3amjCPsmCXCQ
Wit79RPcjIjYYEILXdmvTMVVUrp3sB77ZlIOo0jzscKMb+aivFVVCkeIg4HeTNUV
fxX1gGIme0bB6nYlh8p6LwFGd9GctBZfaGT57pZEbw==
=1MUw
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

