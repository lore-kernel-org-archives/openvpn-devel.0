From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:09:45 +0200
Message-Id: <20170906230945.23592-1-davids@...515...>
In-Reply-To: <20170819203735.8681-1-fragmentux@...277...>
References: <20170819203735.8681-1-fragmentux@...277...>
Subject: Re: [Openvpn-devel] [PATCH applied] man: Corrections to
 doc/openvpn.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: fragmentux@...277...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.

Thanks a lot for putting efforts into improving this.  It will for
sure make various distribution packagers happy, as this should remove
several potential complaints from lint/sanity checkers.  Plus it
fixes a glaring and ugly typo for --verify-x509-name.

I did a quick on-the-fly update, changing the Copyright year 2010
to 2017.

Your patch has been applied to the following branches

commit 510c8ade804566868a1e0aa4e046a69e576f4478  (master)
commit b437bf1c0f60cc5e42d70334bde83a2f9e09be88  (release/2.4)
Author: Richard Bonhomme
Date:   Sat Aug 19 21:37:35 2017 +0100

     man: Corrections to doc/openvpn.8

     Signed-off-by: Richard Bonhomme <fragmentux@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170819203735.8681-1-fragmentux@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15297.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsIA1AAoJEIbPlEyWcf3y/M4P/30R8DzRSt5GgblnijteLwa6
EWVxv5G94DF3e2XBIT3qkL0JaReaB3hPTh9yQGQPAQh0/bh+x0MSDsVPdpj1l8lY
8uITiS6n1uIXqi/35JgOvCcjCa7rRJP5w/J9tglAjkzxw+qM7Y5DUuyyVBYspLjf
z0z9YBE6OtMnlr/H96b22IjrsDtKk2dqo06aXjk0CsTZHqAkwWgZy8AJHLjMRkSr
PHgsHwSIBgX0+RnpKF/trVDKFXq1QHjJxmeYlzSPLMOJJ035MUpIU+zwEWWOz63C
v/NXbOzf9pj9ZbKaqE68Pja3BM8jbCYLxwooUM5MIko3VgPAWUG8iEQcl7Mb/G/e
Tnxju2OYd3FwoFp0YTKR25WwB9yEzlXX9EyTlLmkGf5Eg8+5jOXv+3c62u4CzXk2
xzcAv5xUALj1h7t419UKk2PZxpw34hRjwXHr67BtRtDIsaZNE2152147u/c7NVgU
zG9zZNliSeLo4gNK6ae0Mc4bAqmFUOJs4hxAzXgToQg3wpRXafH8xQxh6FXG4pEe
dY+JJlc50g8kdK7DWlPCp57642u8EJYxIsMGBYnDfpAkbmgPoYAQ++knBuA6r9mK
pS3izYw+4C3twOLXhg7eDwaq2VIcLLl2qRf/y1jzH3Dix7n+GgM4Mrs59d06n7Bw
cNLsORRojTRj6ugpJ8ZY
=bD+x
-----END PGP SIGNATURE-----

