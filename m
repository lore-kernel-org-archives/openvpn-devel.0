From: Lisa Minogue <lminogue@...1892...>
Message-ID: <9453768.108293.1413591263095.JavaMail.root@...1893...>
In-Reply-To: <CAFHpkQFXzF6D3X8DYHHLzb+gpvYDcVoHR8JKGG1p+o4w_GtFVw@...278...>
References: <13177950.74478.1413544590694.JavaMail.root@...1893...>
	<54411BA1.9080402@...1227...>
	<17844314.87425.1413555693684.JavaMail.root@...1893...>
	<CAFHpkQFXzF6D3X8DYHHLzb+gpvYDcVoHR8JKGG1p+o4w_GtFVw@...278...>
MIME-Version: 1.0
Date: Sat, 18 Oct 2014 02:14:23 +0200 (CEST)
Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform that
 incorporate OpenSSL 1.0.1j
Reply-To: Lisa Minogue <lminogue@...1892...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?B?Pz8/PyA/Pz8/Pz8/?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

OpenSSL Security Advisory [15 Oct 2014]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SRTP Memory Leak (CVE-2014-3513)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Severity: High

A flaw in the DTLS SRTP extension parsing code allows an attacker, who
sends a carefully crafted handshake message, to cause OpenSSL to fail
to free up to 64k of memory causing a memory leak. This could be
exploited in a Denial Of Service attack. This issue affects OpenSSL
1.0.1 server implementations for both SSL/TLS and DTLS regardless of
whether SRTP is used or configured. Implementations of OpenSSL that
have been compiled with OPENSSL_NO_SRTP defined are not affected.

OpenSSL 1.0.1 users should upgrade to 1.0.1j.

This issue was reported to OpenSSL on 26th September 2014, based on an orig=
inal
issue and patch developed by the LibreSSL project. Further analysis of the =
issue
was performed by the OpenSSL team.

The fix was developed by the OpenSSL team.


Session Ticket Memory Leak (CVE-2014-3567)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Severity: Medium

When an OpenSSL SSL/TLS/DTLS server receives a session ticket the
integrity of that ticket is first verified. In the event of a session
ticket integrity check failing, OpenSSL will fail to free memory
causing a memory leak. By sending a large number of invalid session
tickets an attacker could exploit this issue in a Denial Of Service
attack.

OpenSSL 1.0.1 users should upgrade to 1.0.1j.
OpenSSL 1.0.0 users should upgrade to 1.0.0o.
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.=20

This issue was reported to OpenSSL on 8th October 2014.

The fix was developed by Stephen Henson of the OpenSSL core team.


SSL 3.0 Fallback protection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Severity: Medium

OpenSSL has added support for TLS_FALLBACK_SCSV to allow applications
to block the ability for a MITM attacker to force a protocol
downgrade.

Some client applications (such as browsers) will reconnect using a
downgraded protocol to work around interoperability bugs in older
servers. This could be exploited by an active man-in-the-middle to
downgrade connections to SSL 3.0 even if both sides of the connection
support higher protocols. SSL 3.0 contains a number of weaknesses
including POODLE (CVE-2014-3566).

OpenSSL 1.0.1 users should upgrade to 1.0.1j.
OpenSSL 1.0.0 users should upgrade to 1.0.0o.
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.=20

https://tools.ietf.org/html/draft-ietf-tls-downgrade-scsv-00
https://www.openssl.org/~bodo/ssl-poodle.pdf

Support for TLS_FALLBACK_SCSV was developed by Adam Langley and Bodo Moelle=
r.


Build option no-ssl3 is incomplete (CVE-2014-3568)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Severity: Low

When OpenSSL is configured with "no-ssl3" as a build option, servers
could accept and complete a SSL 3.0 handshake, and clients could be
configured to send them.

OpenSSL 1.0.1 users should upgrade to 1.0.1j.
OpenSSL 1.0.0 users should upgrade to 1.0.0o.
OpenSSL 0.9.8 users should upgrade to 0.9.8zc.=20

This issue was reported to OpenSSL by Akamai Technologies on 14th October 2=
014.

The fix was developed by Akamai and the OpenSSL team.


> ----------------------------------------
> From: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 <chipitsine@...277...>
> Sent: Fri Oct 17 21:59:04 CEST 2014
> To: Lisa Minogue <lminogue@...1892...>
> Subject: Re: [Openvpn-devel] New OpenVPN bundles for Windows platform tha=
t incorporate OpenSSL 1.0.1j
>=20
>=20
> can you please describe carefully, how those vulnerabilities do affect Op=
enVPN ?
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

