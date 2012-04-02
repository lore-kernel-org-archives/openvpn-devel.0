Message-ID: <4F797A66.8050502@...1114...>
Date: Mon, 02 Apr 2012 12:07:34 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
In-Reply-To: <CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
 RNG
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
To: Fabian Knittel <fabian.knittel@...1547...>, Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/04/12 11:55, Fabian Knittel wrote:


The only advantage I see at runtime switching, is that it's easier for
distributors to support both SSL/crypto library platforms.  Except of
that, I don't see much benefits of it.

And f.ex. in the use case of OpenVPN-NL, I doubt this will be
considered interesting at all, as they do static linking against the
SSL/crypt libraries - to ensure that the libraries Fox-IT have
reviewed and certified for governmental usage are used, and not a
potentially compromised or weakened third-party library.

To be very honest, I don't think it's worth the effort of adding
dynamic loading of SSL/crypto libraries at run time.  Having it at
compile-time provides the needed flexibility.  Yes, distribution can
benefit from it, but is that burden so big we need to modify OpenVPN
for it?  Let's rather stay cool now and rather discuss and consider
such a move for OpenVPN 2.4.  Then we will know more what distributors
thing about it.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95elsACgkQDC186MBRfrpVfACdEJgl6vYDeGH3DxL1foYET118
u5gAn2mA6Zy5TIhtqYnV8qCP2XTJiyyr
=K25q
-----END PGP SIGNATURE-----

