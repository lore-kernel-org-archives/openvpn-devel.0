Date: Sun, 22 May 2016 09:31:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160522073101.GV53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWR1SOPHjVEF5txq"
Content-Disposition: inline
In-Reply-To: <1463892387-4793-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--JWR1SOPHjVEF5txq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:
>          {
>            size +=3D 10;
> -          handles =3D realloc (handles, size * sizeof (HANDLE));
> -          if (handles =3D=3D NULL)
> -            return ERROR_OUTOFMEMORY;
> +          LPHANDLE tmp =3D realloc (handles, size * sizeof (HANDLE));
> +          if (tmp =3D=3D NULL)

... oh, and this might actually fail MSVC compilation, due to=20
"variable declared after other code parts" (size +=3D 10)...

>                if (error)
>                  {
> +                  ReturnError (pipe, error, L"Insufficient reources to s=
ervice new clients", 1, &exit_event);
> +                  /* Update wait handles again after removing the last w=
orker thread */
> +                  RemoveListItem (&threads, CmpHandle, thread);
> +                  UpdateWaitHandles (&handles, &handle_count, io_event, =
exit_event, threads);
>                    TerminateThread (thread, 1);
>                    CloseHandleEx (&thread);
>                    CloseHandleEx (&pipe);
> -                  SetEvent (exit_event);

So we do not exit anymore when this fails, except if WAIT_FAILED?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JWR1SOPHjVEF5txq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0FgNKkuBuNlUUl1AQKBzQP/X1O+ehCh/JOcj/Z1EyAFo2rOJ6wLHk/6
ySp4F7Unb1zVDLMAndpeMprxUbwgPl07Ubmm/0Hb77j776bFDOOJDM7GnTsr6GQ7
mvHqrbOxUt+BHa5G5I1uGXWFCBb/Ypltg7DFEuST132GBWmrkvPo35QWqOZw7moY
2U+MSUdNTSo=
=D9QA
-----END PGP SIGNATURE-----

--JWR1SOPHjVEF5txq--

