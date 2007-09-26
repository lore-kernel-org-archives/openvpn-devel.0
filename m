Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 26 Sep 2007 14:59:03 -0400
Message-ID: <DADDB5EF81658E429476B192618805675B45@...1055...>
From: "Jacob Wilkins" <jwilkins@...1054...>
Subject: [Openvpn-devel] Feature Request: OpenVPN support for fips 140-2
	validated OpenSSL.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Howdy,

OpenSSL has been FIPS 140-2 validated for a few months now.

The "fips mode" within OpenSSL is not automatic, and requires some
invocation from within the calling app.

See here for details:

http://www.openssl.org/docs/fips/UserGuide-1.1.1.pdf

Running in this mode disables all ciphers besides AES and 3DES.

Are these features feasible for OpenVPN? If so, our company would like
to see support added, and could be willing to fund the development. If
anyone is interested in a contract for this project, please contact me
directly.

Thanks,

Jacob Wilkins, CISSP
Appriss, Inc

