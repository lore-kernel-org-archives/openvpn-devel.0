Message-ID: <535D6431.5000308@...1856...>
Date: Sun, 27 Apr 2014 22:10:25 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>	<1398064204-26476-4-git-send-email-james@...515...>
	<20140427175312.GJ16637@...1296...>
In-Reply-To: <20140427175312.GJ16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
 revert to original versioning approach.
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

On 27-04-14 19:53, Gert Doering wrote:
> On Mon, Apr 21, 2014 at 01:10:04AM -0600, James Yonan wrote: The
> attached patch is what I intend to commit to release/2.3 *only*,
> not to master - as agreed at the IRC meeting.  "Please ACK" :-)

Sorry, but NAK. The OpenSSL bits look fine, but the PolarSSL bits
would also allow for SSL_MINOR_VERSION_0, which is SSLv3 and thus a
reduction in security (and actually increases the handshake complexity).

I think the ssl_polarssl.c can stay the way it is, one has to specify
tls cipher suites anyway to restrict the handshake. Or am I missing
something here?

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTXWQgAAoJEJgCyj0AftKILQoH+wa0ojSrip0vhrPKq/AOa6Bw
cpVaDzTo6v7KiOoPf+xWfaEw9aNybd5a8GCVZlCGgSB+vOn53bLtJ7hSPL5fVzb1
8UQw5hWhWyjiZRksyCJNyYEHgzE7ZiRK/LhSd/RhYHlwUTPJfJQ6nYHlM/oMMthz
mvj0juA6jCYGCznUD/2fioy5JtpGUqpwkJzQ2hIMtqV8sxyHgJ90R6DpV6cP2nRd
AAQndNYVRhC5dQfaQtX+4TStMQK65Q7ZlHZDYb3h6TpKk93y/nWdm5tsew1oLbZ+
E27hMtswug0CSWqnSFtT+bW1shYJgrveDnHu7K1Tgh9KJ9DD2SbvXlgADCaao1U=
=uc7+
-----END PGP SIGNATURE-----

