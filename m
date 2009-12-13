Message-ID: <50497.64.217.16.45.1260735536.squirrel@...1166...>
Date: Sun, 13 Dec 2009 14:18:56 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Sommerseth wrote:
> - -             const char *return_value = NULL;
> +               aresp[i].resp = NULL;
>
> This I didn't think about, but I saw another potential leak.
> However, your idea here is clever!  But I would probably
> suggest:
>
>       if( aresp[i].resp ) {
>               free(aresp[i].resp);
>               aresp[i].resp = NULL;
>       }
>
> But!  The potential culprit here is if the aresp[i] struct is not
> zeroed before usage.  If it is not and this pointer is pointing
> at something it do not own, your patch is definitely more the
> correct approach.

It was already nulled at post-patch line 558.  I think that the
additional NULLing makes the code more readable but strictly
speaking it is not necessary.

Daniel Johnson
progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkslSP8ACgkQ6vGcUBY+ge+69gCgwHLbuJsf03uuWXTbP9iI0r9a
RdAAn13l4KIRFa1WR38lDWs3SHu3iJxU
=5kly
-----END PGP SIGNATURE-----




