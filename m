Date: Thu, 18 May 2023 08:47:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZGXKCwNgcA2P7Hiu@...1296...>
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ojzKXvCQMM2aUn7m"
Content-Disposition: inline
In-Reply-To: <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

--ojzKXvCQMM2aUn7m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 17, 2023 at 04:43:01PM -0400, Kristof Provost wrote:
> Fwiw: I usually don???t bother handling malloc failure in userspace,
> because modern systems all overallocate anyway, so the first thing
> you know about lack of memory is the out-of-memory killer terminating
> you. It???s a policy choice for the project, so I don???t object
> to handling it either.

In OpenVPN, we do check malloc() returns :-) - and there's cases where
it actually hit, like running with too low ulimits and --mlock.

If a malloc fail is not recoverable, we have check_malloc_return(p),
which will do

void
out_of_memory(void)
{
    fprintf(stderr, PACKAGE_NAME ": Out of Memory\n");
    exit(1);
}
static inline void
check_malloc_return(const void *p)
{
    if (!p)
    {
        out_of_memory();
    }
}

so it depends a bit on the context if "return an error upstream, and
wait for the next allocation to fail" or "abort right away" is the best
choice.  In low level functions, "return error" might lead to a better
error message from upstream (or not).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ojzKXvCQMM2aUn7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkZcoLAAoJEB2Cnv7KVigSpnsL/jFfw8XSUmH/7fyKb7X3aqZy
0LRhMWkYxJ5iraBgwK+Eoe2DHC/vfuAspYbBjQ20AfkUHPubqodjMZ6qAJmHmQzf
M5sWvE5thBQU4CYxcvy56IYmywzJbqssSdqVF/XQEA/FGo6SYeKXPZ5Ldr8NgHyb
CCqIyKUsL1eq+p/dFM1IOB3yJN6YXKE0teuPWFI36oZyIGFtGjcLJ238BSGnJ4Hc
M+vf7drTURbvdt0m2z4hRLPuYShjHKsC7g2CxDzWZ3BEJQI8OiACX188FtYoMee3
ebnMvyWLVEcrcQHnR2jFK9/fbW5g2et64jbmTfLDJCEVpkUkeThFrbule8qNaPLw
J5w1UNDmWJn8xNUDIYyQ2y5sdt+04QnJmKrt/HQqmHy/WriLJb5Nm5acE+csFecf
gLt0K7jHNN2ArYygfFWn+q6YCZjtDA2N+uSwh0MhNkMHNm4jU4hl49UxM+bZovtK
DaOVWcOeKGG6AmRp0A/+q5GoVZzKISanUUvL5/1mOg==
=7SVP
-----END PGP SIGNATURE-----

--ojzKXvCQMM2aUn7m--

