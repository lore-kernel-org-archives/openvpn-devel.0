Date: Sun, 8 Dec 2024 14:52:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z1Wks89eIpA1DrX-@...1296...>
References: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ybF5OKr3SMjp8Vy2"
Content-Disposition: inline
In-Reply-To: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix IPv6 in port-share journal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--ybF5OKr3SMjp8Vy2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 08, 2024 at 12:17:05AM +0100, corubba via Openvpn-devel wrote:
> getpeername() and getsockname() will truncate the result if it is
> larger than the passed-in length. Because here always the size of the
> `sa` IPv4 union member was passed in, all larger (aka IPv6) results
> were truncated. Instead use the size of the `addr` union, which is the
> maximum size of all union members.

Thanks for digging into this.  The fix looks correct according to
structure definitions, "man getpeername()" etc. - and now matches
other parts of the code, like socket.c / socket_do_accept()

...
    socklen_t remote_len =3D sizeof(act->dest.addr);
...
        new_sd =3D getpeername(sd, &act->dest.addr.sa, &remote_len);

The commit ID you found introduces IPv6 transport support :-) - so before
that, there was no ambiguity here.

So

Acked-By: Gert Doering <gert@...1296...>

will proceed to merge ASAP.  (I'll change the Trac reference to be
just "Trac: #1358" as this is our standard format).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ybF5OKr3SMjp8Vy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnVaSzAAoJEB2Cnv7KVigShG8L/3sgyzs7St4lYvQB4US7lFuA
UPuE+2wUGmhicw1CKMakGt551REQKghXNjZ2PdtV9XyUnvqBJchF1MtkRZaS15v6
60zxRina2taPKTP+8ZLVPBx4QJYtESozG7gs2F+SMfWopFFg/sH1J6PPydEuiSF4
t6BWKizRY1deCEt/4BQw+hDg6xUMgfFgdc0lJkXMKPw3ZUiBIWpBJA42rbrLzFw4
dilP3Mu7ygp0UiCs3Iir0h5imuE5FSFHiPd1iNDw92X2+RMnrpoSvr+dNdoE1yVg
7CVmonvef8Qt2VIFz35oGUHxuYPHPFoyqJA/qwrluWVjpakqh53qEErBVgkVI/X0
WgXay+OOSqRYZa6Dxq+ZczM+JL2sJKHX52EJ4eYHimf6gLhmPocsYUtGOquff9XL
URxiD7YSTK4+Jpv2oYqaUX+I+5o+vsU+tI0QT5fBqZ2SEezMFJuuEQfWDZfezIta
5+U6iUeLF7Mb7FeGWg+jDXiuhWNkt9yFNS99ybl+mA==
=/KEz
-----END PGP SIGNATURE-----

--ybF5OKr3SMjp8Vy2--

