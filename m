MIME-Version: 1.0
Date: Sat, 05 Jul 2014 12:46:14 +0200
From: caritas.moral@...1919...
Message-Id: <20140705104614.C1FB0C00CF@...1920...>
Subject: [Openvpn-devel] Security fix: Patch RSA key length from 4096 to
	16384 bits to support enough security for negotiation of AES-256.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Patch:
In
https://github.com/OpenVPN/openvpn/blob/55af8e9a4138db0c9de6f6e29dec9839231ec798/src/openvpn/ssl.h#L113
you have to change
            #define TLS_OPTIONS_LEN 512
(512 bytes = 4096 bit)
to
             #define TLS_OPTIONS_LEN 2048
(2048 bytes = 16384 bit)


NSA says you have to protect an AES-256 key with RSA/Diffie Hellman 15360 bit.
http://www.nsa.gov/business/programs/elliptic_curve.shtml

4096 bit RSA/Diffie Hellman is only secure for AES-128.
NSA: "To use RSA or Diffie-Hellman to protect 128-bit AES keys one should use 3072-bit parameters"

EU says you have to protect an AES-256 key with RSA 15424 bit.
http://ec.europa.eu/information_society/apps/projects/logos/6/216676/080/deliverables/001_DSPA20.pdf
 Page 30 (39 of 121) Table 7.2

Please support 16384 bit RSA/Diffie Hellman keys like NSS/OpenSSL.

Thank you.

PS:
Most people don't know that using RSA 4096 bit with Diffie Hellman 1024 bit results to a security as you would use a RSA 1024 bit key.
So additionally you should implement a check that RSA and DH key have the same lengths.
Notice: In OpenSSL's "crypto/dh/dh.h" is a 10000 bit limit for Diffie Hellman parameters. So it's currently not possible to use DHE as protection for nothing over AES-128 bits. The devs don't react to my mails.


