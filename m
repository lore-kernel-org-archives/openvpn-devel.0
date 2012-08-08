Date: Wed, 8 Aug 2012 12:36:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120808103623.GP2535@...1296...>
References: <1344379513-10871-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Content-Disposition: inline
In-Reply-To: <1344379513-10871-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] management-signal maps disconnect to
	SIGTERM if used with management-client
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

--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 08, 2012 at 12:45:13AM +0200, Arne Schwabe wrote:
> @@ -2478,7 +2478,8 @@ command.
>  .B \-\-management-signal
>  Send SIGUSR1 signal to OpenVPN if management session disconnects.
>  This is useful when you wish to disconnect an OpenVPN session on
> -user logoff.
> +user logoff. When used in conjuction with --management-client SIGTERM
> +will be sent.
>  .\"*********************************************************

OK, for the record and the archive :-) - I've now tried to follow the
twisted maze of manage.c to understand why one or the other signal
is sent.

This is happening inside man_reset_client_socket(), in this bit of code:

  if (!exiting)
    {
...
      if (man->settings.flags & MF_SIGNAL) {
          int mysig =3D man_mod_signal (man, SIGUSR1);
          if (mysig >=3D 0)
            {
              msg (D_MANAGEMENT, "MANAGEMENT: Triggering management signal"=
);
              throw_signal_soft (mysig, "management-disconnect");
            }
      }

      if (man->settings.flags & MF_CONNECT_AS_CLIENT)
        {
          msg (D_MANAGEMENT, "MANAGEMENT: Triggering management exit");
          throw_signal_soft (SIGTERM, "management-exit");
        }
      else
        man_listen (man);
    }

MF_CONNECT_AS_CLIENT is set by options.c if --management-client is
used, MF_SIGNAL is set by options.c if --management-signal is used - but
note that the "if (... MF_SIGNAL)" clause doesn't apply to the SIGTERM
signalling.


So, if I read this right

 - SIGTERM will *always* be sent upon management-disconnect if
   --management-client has been used, even if --management-signal
   is not set

 - SIGUSR1 will be sent upon disconnect *if* requested by --management-sign=
al
   (subject to remapping, but not automatically remapped)

if that analysis is correct, I'd re-word the proposed new text in the manpa=
ge
somewhat.  Suggested wording:

 .B \-\-management-signal
 Send SIGUSR1 signal to OpenVPN if management session disconnects
 (subject to remapping by \-\-remap-usr1).
 This is useful when you wish to disconnect an OpenVPN session on
 user logoff.  If \-\-management-client is used, a SIGTERM signal
 will always be sent on disconnect, even if \-\-management-signal is=20
 not set.
 .\"*********************************************************

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCJBJ6kuBuNlUUl1AQJuBwQAiObhwOXni9KIysyXY+eDloSVetgSDK17
qi595fLkIfYMRuw1kSJMjvsEvvV8PJ+aYB53kwtfKZcFezcNUxO6804XD94Ygk8L
QymSoRZw++VYW0K5wQuzT2JpW3JDTIXe+I6ZqbT9gH/mTiGTb4EGNdVZl6a2Y5cR
DNa3XhcQh+g=
=szyN
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--

