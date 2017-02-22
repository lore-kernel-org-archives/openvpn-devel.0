From: James Yonan <james@...515...>
Message-ID: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
Date: Wed, 22 Feb 2017 11:48:00 -0700
MIME-Version: 1.0
Subject: [Openvpn-devel] Should we use mbedTLS certificate profiles?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

mbedTLS 2 has a new feature that allows rejection of certificates if the 
key size is too small or the signing hash is weak.

The feature is controlled via struct mbedtls_x509_crt_profile.

For example, you could specify that certificates must be at least 2048 
bits and use a SHA-2 signing alg.

Wondering if we should enable this via an option, or tie it into the 
existing tls-version-min.

The granular approach would be to have specific options for each limit, 
such as ssl-min-key-size, ssl-require-sha2

The bundled approach would be to take an existing option such as 
tls-version-min and add additional constraints onto it.  For example, if 
tls-version-min is 1.2 or higher, then also require minimum key size to 
be 2048 and certificate signing hash to be SHA-2.

James

