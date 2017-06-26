References: <3275c6bd-8194-2e23-2e64-3d3fd5d2f090@...2080...>
	<1492184450-11994-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cb53ce61-141d-7845-d0a2-b6685eb74ccc@...1227...>
Date: Mon, 26 Jun 2017 16:32:29 +0200
MIME-Version: 1.0
In-Reply-To: <1492184450-11994-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add --tls-cert-profile option for
 mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 14.04.17 um 17:40 schrieb Steffan Karger:
> This allows the user to specify what certificate crypto algorithms to
> support.  The supported profiles are 'preferred' (default), 'legacy' and
> 'suiteb', as discussed in <84590a17-1c48-9df2-c48e-4160750b2e33@...1435...>
> (https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14214.html).
> 
> This only implements the feature for mbed TLS builds, because for mbed it
> is both more easy to implement and the most relevant because mbed TLS 2+
> is by default somewhat restrictive by requiring 2048-bit+ for RSA keys.
> 

ACK so far as the code goes. As for the whole MD5 stuff is at the moment
blowing up with OSSL 1.1, we need a md5 allowing option (with a fat
warning probably).

And the other thing is that OpenSSL has a similar feature in 1.1:
Security levels. Which can be specified as part of tls-cipher or set
independently by
https://www.openssl.org/docs/manmaster/man3/SSL_CTX_set_security_level.html

The levels are similar to the proposed level here but not identical.
Should we somehow align these two features? Configuring it for one
library in tls-cipher and for the other in tls-cert-profile is bit strange.

Also shouldn't be tls-min-version included in the preferred/legacy options?

And suiteb would be tls-cipher SUITEB128 in OpenSSL

Arne

