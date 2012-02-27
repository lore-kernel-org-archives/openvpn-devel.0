Message-ID: <4F4B4A0E.6020804@...1114...>
Date: Mon, 27 Feb 2012 10:17:02 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-13-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-13-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 12/35] Remove easy-rsa
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am
> |    1 - easy-rsa/1.0/README                        |  161
> ------------ easy-rsa/1.0/build-ca                      |   13 - 
> easy-rsa/1.0/build-dh                      |   12 - 
> easy-rsa/1.0/build-inter                   |   19 -- 
> easy-rsa/1.0/build-key                     |   20 -- 
> easy-rsa/1.0/build-key-pass                |   20 -- 
> easy-rsa/1.0/build-key-pkcs12              |   21 -- 
> easy-rsa/1.0/build-key-server              |   22 -- 
> easy-rsa/1.0/build-req                     |   18 -- 
> easy-rsa/1.0/build-req-pass                |   18 -- 
> easy-rsa/1.0/clean-all                     |   19 -- 
> easy-rsa/1.0/list-crl                      |   18 -- 
> easy-rsa/1.0/make-crl                      |   18 -- 
> easy-rsa/1.0/openssl.cnf                   |  255 ------------------- 
> easy-rsa/1.0/revoke-crt                    |   18 -- 
> easy-rsa/1.0/revoke-full                   |   29 --- 
> easy-rsa/1.0/sign-req                      |   18 -- easy-rsa/1.0/vars
> |   49 ---- easy-rsa/2.0/Makefile                      |   13 - 
> easy-rsa/2.0/README                        |  229 ----------------- 
> easy-rsa/2.0/build-ca                      |    8 - 
> easy-rsa/2.0/build-dh                      |   11 - 
> easy-rsa/2.0/build-inter                   |    7 - 
> easy-rsa/2.0/build-key                     |    7 - 
> easy-rsa/2.0/build-key-pass                |    7 - 
> easy-rsa/2.0/build-key-pkcs12              |    8 - 
> easy-rsa/2.0/build-key-server              |   10 - 
> easy-rsa/2.0/build-req                     |    7 - 
> easy-rsa/2.0/build-req-pass                |    7 - 
> easy-rsa/2.0/clean-all                     |   16 -- 
> easy-rsa/2.0/inherit-inter                 |   39 --- 
> easy-rsa/2.0/list-crl                      |   13 - 
> easy-rsa/2.0/openssl-0.9.6.cnf             |  265 ------------------- 
> easy-rsa/2.0/openssl-0.9.8.cnf             |  290
> --------------------- easy-rsa/2.0/openssl-1.0.0.cnf             |
> 285 --------------------- easy-rsa/2.0/pkitool                       |
> 379 ---------------------------- easy-rsa/2.0/revoke-full
> |   40 --- easy-rsa/2.0/sign-req                      |    7 - 
> easy-rsa/2.0/vars                          |   74 ------ 
> easy-rsa/2.0/whichopensslcnf               |   26 -- 
> easy-rsa/Windows/README.txt                |   44 ---- 
> easy-rsa/Windows/build-ca-pass.bat         |    8 - 
> easy-rsa/Windows/build-ca.bat              |    4 - 
> easy-rsa/Windows/build-dh.bat              |    4 - 
> easy-rsa/Windows/build-key-pass.bat        |    8 - 
> easy-rsa/Windows/build-key-pkcs12.bat      |   10 - 
> easy-rsa/Windows/build-key-server-pass.bat |    8 - 
> easy-rsa/Windows/build-key-server.bat      |    8 - 
> easy-rsa/Windows/build-key.bat             |    8 - 
> easy-rsa/Windows/clean-all.bat             |   13 - 
> easy-rsa/Windows/init-config.bat           |    1 - 
> easy-rsa/Windows/revoke-full.bat           |   13 - 
> easy-rsa/Windows/serial.start              |    1 - 
> easy-rsa/Windows/vars.bat.sample           |   40 --- 55 files
> changed, 0 insertions(+), 2667 deletions(-) delete mode 100644
> easy-rsa/1.0/README delete mode 100755 easy-rsa/1.0/build-ca delete
> mode 100755 easy-rsa/1.0/build-dh delete mode 100755
> easy-rsa/1.0/build-inter delete mode 100755 easy-rsa/1.0/build-key 
> delete mode 100755 easy-rsa/1.0/build-key-pass delete mode 100755
> easy-rsa/1.0/build-key-pkcs12 delete mode 100755
> easy-rsa/1.0/build-key-server delete mode 100755
> easy-rsa/1.0/build-req delete mode 100755 easy-rsa/1.0/build-req-pass 
> delete mode 100755 easy-rsa/1.0/clean-all delete mode 100644
> easy-rsa/1.0/list-crl delete mode 100644 easy-rsa/1.0/make-crl delete
> mode 100644 easy-rsa/1.0/openssl.cnf delete mode 100644
> easy-rsa/1.0/revoke-crt delete mode 100755 easy-rsa/1.0/revoke-full 
> delete mode 100755 easy-rsa/1.0/sign-req delete mode 100644
> easy-rsa/1.0/vars delete mode 100644 easy-rsa/2.0/Makefile delete mode
> 100644 easy-rsa/2.0/README delete mode 100755 easy-rsa/2.0/build-ca 
> delete mode 100755 easy-rsa/2.0/build-dh delete mode 100755
> easy-rsa/2.0/build-inter delete mode 100755 easy-rsa/2.0/build-key 
> delete mode 100755 easy-rsa/2.0/build-key-pass delete mode 100755
> easy-rsa/2.0/build-key-pkcs12 delete mode 100755
> easy-rsa/2.0/build-key-server delete mode 100755
> easy-rsa/2.0/build-req delete mode 100755 easy-rsa/2.0/build-req-pass 
> delete mode 100755 easy-rsa/2.0/clean-all delete mode 100755
> easy-rsa/2.0/inherit-inter delete mode 100755 easy-rsa/2.0/list-crl 
> delete mode 100755 easy-rsa/2.0/openssl-0.9.6.cnf delete mode 100755
> easy-rsa/2.0/openssl-0.9.8.cnf delete mode 100755
> easy-rsa/2.0/openssl-1.0.0.cnf delete mode 100755
> easy-rsa/2.0/pkitool delete mode 100755 easy-rsa/2.0/revoke-full 
> delete mode 100755 easy-rsa/2.0/sign-req delete mode 100755
> easy-rsa/2.0/vars delete mode 100755 easy-rsa/2.0/whichopensslcnf 
> delete mode 100644 easy-rsa/Windows/README.txt delete mode 100644
> easy-rsa/Windows/build-ca-pass.bat delete mode 100644
> easy-rsa/Windows/build-ca.bat delete mode 100644
> easy-rsa/Windows/build-dh.bat delete mode 100644
> easy-rsa/Windows/build-key-pass.bat delete mode 100644
> easy-rsa/Windows/build-key-pkcs12.bat delete mode 100644
> easy-rsa/Windows/build-key-server-pass.bat delete mode 100644
> easy-rsa/Windows/build-key-server.bat delete mode 100644
> easy-rsa/Windows/build-key.bat delete mode 100644
> easy-rsa/Windows/clean-all.bat delete mode 100644
> easy-rsa/Windows/index.txt.start delete mode 100755
> easy-rsa/Windows/init-config.bat delete mode 100644
> easy-rsa/Windows/revoke-full.bat delete mode 100644
> easy-rsa/Windows/serial.start delete mode 100644
> easy-rsa/Windows/vars.bat.sample
> 

ACK.  These files will be pulled into a separate git repository, so this
makes a lot of sense.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LSgwACgkQDC186MBRfroViQCfR+t1pZJJ6lF6Ge82YtOgeaMB
6s4AoJz+q60torElpk/vNw5Z6846Mqxk
=o2nV
-----END PGP SIGNATURE-----

