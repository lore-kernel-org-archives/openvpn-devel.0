Message-ID: <4F9C4CF3.1040201@...1114...>
Date: Sat, 28 Apr 2012 22:02:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: windows: convert resources to
 UTF-8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/12 20:29, Alon Bar-Lev wrote:
> Visual Studio 2010 editor supports UTF-8 files, we can store files
> in standard encoding.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> src/openvpn/openvpn_win32_resources.rc   |    4 +++- 
> src/openvpnserv/openvpnserv_resources.rc |    4 +++- 2 files
> changed, 6 insertions(+), 2 deletions(-)

I'm not giving it a NACK, just thinking aloud.  Would it make the
world simpler and easier if we just skipped this fancy copyright
symbol with '(C)'?  Unless there are other characters "outside 7 bit
ASCII" table in these files, maybe that would be just as good?

Just a thought.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+cTO8ACgkQDC186MBRfrpIywCeMiq07E+i6P18ghguRQqpLP5j
+HIAnicYeKF7iuEUjLjtG7+s4+9bwkLa
=5c8o
-----END PGP SIGNATURE-----

