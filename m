Message-Id: <201404281504.s3SF4A96017619@...309...>
In-Reply-To: Your message of "Thu, 24 Apr 2014 12:32:22 EDT."
	<53593C96.1040404@...1901...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1398697450-26302-2"
Content-Transfer-Encoding: binary
Date: Mon, 28 Apr 2014 16:04:10 +0100
From: George Ross <gdmr@...308...>
Subject: Re: [Openvpn-devel] Topics for today's community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format...

------------=_1398697450-26302-2
Received: from eden.inf.ed.ac.uk (eden.inf.ed.ac.uk [129.215.24.11])
	by crunchie.inf.ed.ac.uk (8.14.4/8.14.4) with ESMTP id s3SF49GR021562; 
	Mon, 28 Apr 2014 16:04:09 +0100
Received: from eden.inf.ed.ac.uk (localhost [127.0.0.1])
	by eden.inf.ed.ac.uk (8.14.4/8.14.4) with ESMTP id s3SF4A96017619;
	Mon, 28 Apr 2014 16:04:10 +0100
Message-Id: <201404281504.s3SF4A96017619@...309...>
X-Mailer: exmh version CVS-20111221 with nmh-1.3
X-Image-Url: http://homepages.inf.ed.ac.uk/gdmr/gdmr.tif
X-Url: http://homepages.inf.ed.ac.uk/gdmr/
X-Pgp-Keyid: AD758CC5
X-Pgp-Fingerprint: B91E D430 1E0D 5883 EF6A  426C B676 5C2B AD75 8CC5
X-Pgp-Url: http://homepages.inf.ed.ac.uk/gdmr/PGP-DSA-key.asc
To: Timothe Litt <litt@...1901...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] Topics for today's community meeting
In-Reply-To: Your message of "Thu, 24 Apr 2014 12:32:22 EDT."
	<53593C96.1040404@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1398697450_8243P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Apr 2014 16:04:10 +0100
From: George Ross <gdmr@...308...>

--==_Exmh_1398697450_8243P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1398697283_82430"

This is a multipart MIME message.

--==_Exmh_1398697283_82430
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Any of the suggested patches should determine that.  The quickest and
> simplest is in
>
> src/openvpn/ssl_openssl.c
> ...

OK, with the attached patch it does appear to work for me.  I'll give it
some more exercise tomorrow morning, but in a quick test the tunnel does
now appear to come up properly.


--==_Exmh_1398697283_82430
Content-Type: text/plain ; name="openvpn-no-tls12-patch"; charset=us-ascii
Content-Disposition: inline
Content-Description: openvpn-no-tls12-patch

--- openvpn-2.3.3/src/openvpn/ssl_openssl.c.dist	2014-04-28 15:40:11.000000000 +0100
+++ openvpn-2.3.3/src/openvpn/ssl_openssl.c	2014-04-28 15:40:39.000000000 +0100
@@ -208,6 +208,7 @@
   /* process SSL options including minimum TLS version we will accept from peer */
   {
     long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
+    sslopt |= SSL_OP_NO_TLSv1_2;
     const int tls_version_min = (ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
     if (tls_version_min > TLS_VER_1_0)
       sslopt |= SSL_OP_NO_TLSv1;

--==_Exmh_1398697283_82430
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

George D M Ross MSc PhD CEng MBCS CITP, University of Edinburgh,
School of Informatics, 10 Crichton Street, Edinburgh, Scotland, EH8 9AB
Mail: gdmr@...308...   Voice: 0131 650 5147   Fax: 0131 650 6899
PGP: 1024D/AD758CC5  B91E D430 1E0D 5883 EF6A  426C B676 5C2B AD75 8CC5

The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.

--==_Exmh_1398697283_82430--



--==_Exmh_1398697450_8243P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Exmh version 2.7.2 2005/01/04

iEYEARECAAYFAlNebeoACgkQtnZcK611jMWclQCfSPHV5iNKUPGnOG/ZqMtL42iQ
C/UAoIhwPvVJezdTZ7HkGUC4v6YX5BAn
=OVLh
-----END PGP SIGNATURE-----

--==_Exmh_1398697450_8243P--

------------=_1398697450-26302-2
MIME-Version: 1.0
X-Mailer: MIME-tools 5.420 (Entity 5.420)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-Description: Edinburgh University charitable status

The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.

------------=_1398697450-26302-2--

