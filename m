Resent-Message-Id: <201507220650.t6M6oWBf002384@...1295...>
Date: Thu, 16 Jul 2015 20:38:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150716183812.GI382@...1296...>
References: <55A41225.2020705@...1856...>
	<201507131954.t6DJsbow006496@...1295...>
	<55A7CB2B.7090904@...1800...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6l5M6k90JZH9RJfY"
Content-Disposition: inline
In-Reply-To: <55A7CB2B.7090904@...1800...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix --askpass not allowing
	for password input via stdin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Tancsa <mike@...1800...>
Cc: James Geboski <jgeboski@...277...>, openvpn-devel@lists.sourceforge.net

--6l5M6k90JZH9RJfY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2015 at 11:18:03AM -0400, Mike Tancsa wrote:
> 	Is this fix going to generate a new version of OpenVPN?  I ran into
> this bug this morning and manually patched it up for my installation.
> But if no new version is planned, I was going to ask the FreeBSD port
> maintainer to add this as a version patch for the port.

It will be in 2.3.8, to be released "soonish" (I'd say next week or
the week after that).  Depending how many more --daemon related corner
cases show up...

I won't object to having it in the FreeBSD port until then...  funny
enough, we broke --askpass (stdin) in 2.3.2 and it did not *really*=20
have an impact on people...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6l5M6k90JZH9RJfY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVaf6FKkuBuNlUUl1AQJvawP+JBVnMNhEL7+GpS2bLh3eUyt/RfJKDWFT
uLrXtobYzm3CwbGfBZGhnR0MB/Yq6cbW0DWHVS2lSXf7IywnHrwMDFl8PehAV3NA
VD5Ppfp6zQm9wkFi8xzi0oV5U8PCHDjubcP7JZcpdJbCNa2duNnswUCdrhpoXbtj
n/Rcp1ykstA=
=n8np
-----END PGP SIGNATURE-----

--6l5M6k90JZH9RJfY--

