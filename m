Date: Mon, 4 Nov 2024 17:13:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Zyjyqilvfsmrx_yv@...1296...>
References: <fd473a5552ce4f91a95abf8c8b91df4e@...2828...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aKxP2hacVdN5Ihy6"
Content-Disposition: inline
In-Reply-To: <fd473a5552ce4f91a95abf8c8b91df4e@...2828...>
Subject: Re: [Openvpn-devel] [PATCH] Add calls to nvlist_destroy to avoid
 leaks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?R=E9mi?= FARAULT <Remi.FARAULT@...2828...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--aKxP2hacVdN5Ihy6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so, I had the ACK from Kristof in GH#636 and was going to apply it,
but "this patch does not compile"

On Wed, Oct 30, 2024 at 10:31:57AM +0000, R=E9mi FARAULT via Openvpn-devel =
wrote:
>      if (remoteaddr)
>      {
> -        nvlist_add_nvlist(nvl, "remote", sockaddr_to_nvlist(remoteaddr));
> +        remote_nvl =3D sockaddr_to_nvlist(remoteaddr);
> +        nvlist_add_nvlist(nvl, "remote", remove_nvl);
>      }

There is an "remove" here, not "remote"...

Can you please fix & send a v2 ("git send-email -v2")?

While at it, please add all the stuff that's in the GH MR to the commit
message ;-)  - I'm happy to do that for "infrequent contributors", but
project rules disallow me to change actual code.  So when doing the
new version, you can just add:

----------------------------------------------------
    Add calls to nvlist_destroy to avoid leaks
=20=20=20=20
    Some memory leaks were detected by valgrind on the openvpn daemon, using
    DCO mode on a FreeBSD platform.  The leaks are caused by missing
    nvlist_destroy calls in the file dco_freebsd.c.
=20=20=20=20
    Calls to nvlist_destroy were added, sometimes using local variables to
    store nvlist pointers temporarly.  A valgrind run on the updated daemon
    confirmed that  the leaks were gone.
=20=20=20=20
    Github: OpenVPN/openvpn#636
    Signed-off-by: R<A9>mi Farault <remi.farault@...2828...>
----------------------------------------------------

(sorry for the name mangling, I do my best to make the commit UTF8
correct, but to/from e-mail tends to be... interesting)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aKxP2hacVdN5Ihy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnKPKqAAoJEB2Cnv7KVigSmTIL/2WnXzV5Z0hkjvtGQ7NZ7hg8
YgNNtkxaAf5SATt9V2w8YZxqrytAqipW9syGWlJlL2InFvrWgwoKNnGHoVkKM2vS
6vrnvjVhCuScV7swRr8f/XHOyGBCY4tAQ+/XBIOYzi+mjPLeUrGFBH6ZmaPoo5Hc
xZMB+zm56NJDSCsvue2+0rzueMa2GKciIU5pkUUYJ3UI2se99VPWoQ0QDPXygzw/
Bvu1vEMnpb/P2bv87bUjUaUnMrM3keItPTl3y11dPuP05Yppwkq/oxHy9bjRx7uv
FBq0KGy3HaPhkcgWjjrrUdX4OudYUDIkNurauX6BZgsvRJacqS+rtMy3Tek5Ql5N
g8hdwMCxrBTolUss6Fho0RdgU4BmzO6VL3fNUNFlbnPqNL8AMXGw5menQMatMCh5
jxH8KCvbAkqchpO9Zg2d3DTPflIA7zgimxjzEFBabBKZtnuto78uiB/zNjv5JCZA
rqYZnbRt7WggBbaceKpWeBW6JgWcKwDy4DFGjAOZ5Q==
=g0ic
-----END PGP SIGNATURE-----

--aKxP2hacVdN5Ihy6--

