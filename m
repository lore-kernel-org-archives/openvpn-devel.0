Date: Thu, 25 Feb 2016 13:29:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160225122928.GC24952@...1296...>
References: <1456171763-44172-1-git-send-email-fish.thss@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3RuZSzpzy06PzMYS"
Content-Disposition: inline
In-Reply-To: <1456171763-44172-1-git-send-email-fish.thss@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add lz4 support to MSVC project.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--3RuZSzpzy06PzMYS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 22, 2016 at 03:09:23PM -0500, Fish wrote:
> - Include lz4 code and header in VC project files.
> - Fix an issue in comp-lz4.h that prevents it from compiling under MSVC.

The patch does not apply for me

Applying: Add lz4 support to MSVC project.
error: patch failed: src/openvpn/openvpn.vcxproj.filters:461
error: src/openvpn/openvpn.vcxproj.filters: patch does not apply

... because my vcxproj.filters file looks totally different in the
surrounding code - mine ends with:

    <ClInclude Include=3D"tun.h">^M
      <Filter>Header Files</Filter>^M
    </ClInclude>^M
    <ClInclude Include=3D"win32.h">^M
      <Filter>Header Files</Filter>^M
    </ClInclude>^M
  </ItemGroup>^M
  <ItemGroup>^M
    <ResourceCompile Include=3D"openvpn_win32_resources.rc">^M
      <Filter>Resource Files</Filter>^M

while your context has "resource.h" as previously-last file in there...

Please re-send (and it would be nice if you could do "git commit -s"
for the signed-off-by: - David can explain better what the significance
of that is, but "since we all do it", it's convention)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3RuZSzpzy06PzMYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVs7zqKkuBuNlUUl1AQIQ4wQAgg7mqqTuVTnNA9dE60Uk1Vn0cQlqWtOs
rq/WQqSpwRNDoVrUmJBx7dc3kSbNX6iF3bXQ2dq2A0jHG/BawrFgb/SeteIvlxqj
krHZ1Byx1faY87y1H30esjrmGx3L+DCtdbMIwJXVnw3BJTsL6zPgMg0JTtCVGZ0Y
Z6ywtS6bU0A=
=pLzD
-----END PGP SIGNATURE-----

--3RuZSzpzy06PzMYS--

