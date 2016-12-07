Date: Wed, 7 Dec 2016 09:19:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161207081907.GS78624@...1296...>
References: <1481067951-28917-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKmnPmKxJBqIz68t"
Content-Disposition: inline
In-Reply-To: <1481067951-28917-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Arm inotify only in server mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--yKmnPmKxJBqIz68t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 07, 2016 at 01:45:51AM +0200, Lev Stipakov wrote:
>  #ifdef ENABLE_ASYNC_PUSH
>    /* arm inotify watcher */
> -  event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&file=
_shift);
> +  if (c->options.mode =3D=3D MODE_SERVER)
> +    event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&fi=
le_shift);
>  #endif

I find this a non-robust approach to this.

What is wrong with

   if ( c->c2.inotify_fd > 0 )
     {
       event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&fi=
le_shift);
     }

(as I suggested on IRC yesterday evening)?

This will ensure that inotify is armed *if* it got prepped, independent of
"whatever other flags are active in the system" - next thing, someone adds
a "--no-inotify" run-time switch, and you'll have to revisit this place
again - or someone else finds a use for inotify in client mode, and this
will also need touching.

It will fix the issue at hand, but is not good code.

Also, braces.  See CodingStyle in the wiki.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yKmnPmKxJBqIz68t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYR8X7AAoJEB2Cnv7KVigSjccL/1uK7Ltp/g3v0OMlbBOpSrt0
IwSdxKwRHgZVW6yGoCLNuEhPJ9wk+0KgFMAWY5YeIdSS4AjWnxL4FvO8zV2++CKr
26TndUItaHQOFzHYjeAY0caJFA2WkF/lYcLiXMP4TZwYnOuOt3zeqsfAH96lqFHf
tPtcGedIvmARZ0YfW4d/2t/WquAde5dEMu31rpVc+qoCGl5FWWB4Zx6+88A6wbiW
FRo2ii4R+3spI0CXuj/vGY2OP4tD9bDlasdElwDHyUv8ZdAvWfz03zS06gtE+M/G
MvQoVA1e6pOiBiNcPV1vVvU7bUDJBKUCS2TeY+Bja7QPG7D6LZ8gZkza9Ee8bMua
90TwqKzjcUh0HYQ7aHXN7nWMtHssB6URboAwcAwHB6ddII8kfjZXPhHM4cSmwbCj
i6m+FFlav8lZ0d8/cBz8dfKzqTIdFBX3emnXU6pj5EEqPD2IseD4Y3OiqewkvQSV
szJHQErCzZzF3Fig2FWqKEbnKJY+B47IbmicIpLH6g==
=leH5
-----END PGP SIGNATURE-----

--yKmnPmKxJBqIz68t--

