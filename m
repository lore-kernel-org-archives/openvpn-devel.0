Date: Mon, 10 Dec 2007 16:18:17 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20071210131817.GA7561@...1066...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Using OpenVPN with non-default cryptoalgorithms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

I'm trying to use OpenVPN with GOST cryptoalgorithms, which are now
available in the OpenSSL 0.9.9 (development version).

I've found some things which looks strange to me, and want to know 
why some design decisions are made :

1. CBC mode. Why CBC mode is so prefered over CFB or OFB?
   GOST 28147  doesn't define CBC mode at all, although CBC mode for GOST is
   defined in RFC 4357, it is considered "substandard" and current
   ccgost engine in OpenSSL doesn't implement it. I've always thought
   that CBC is least secure mode of cipher.  But openvpn require rebuild
   with special define to use non-CBC ciphers. And error message
   mistakenly tells that CFB ciphers would be supported only in TLS
   mode, while they do work in shared-secret mode. 

2. Assertion that EVP_CipherFinal would return buffer with size equal to
   cipher's iv length. 
   Such assertion is found in file crypto.c line 168. (both 2.0.9 and
   2.1_rc4 versions)
   But it is not always true. For CFB cipher with blocksize of 1
   EVP_CipherFinal would always return 0 bytes.

3. --dh argument is required in TLS server mode. It is really needed
  only if  ciphersuites with ephemeral DH key exchange are enabled.
  But there are lot of other ciphersuites which do not require  DH
  parameters at all (or require some other parameters such as EECDH
  ciphersuites).

Can somebody enlighten me - why these decisions were made?

				Regards, Victor Wagner.

