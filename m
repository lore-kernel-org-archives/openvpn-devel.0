References: <1495285075-4957-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4649a444-b819-2143-a102-dd54a0e1c035@...1227...>
Date: Sun, 18 Jun 2017 14:04:36 +0200
MIME-Version: 1.0
In-Reply-To: <1495285075-4957-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix mbedtls fingerprint calculation
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 20.05.17 um 14:57 schrieb Steffan Karger:
> Commit 'Migrate to mbed TLS 2.x' (86d8cd68) introduced a bug in mbedtls
> builds where we would calculate the certificate fingerprint over the
> (too-short) 'to-be-signed' length of the certificate, rather than over the
> certificate including the signature.  Fix that.
> 
> The security impact of the incorrect calculation is very minimal; the last
> few bytes (max 4, typically 4) are not verified by the fingerprint.  We
> expect no real-world impact, because users that used this feature before
> will notice that it has suddenly stopped working, and users that didn't
> will notice that connection setup fails.
> 
> Even if the user managed to somehow extract the incorrect hash (e.g. by
> reading out the tls_digest_* env vars using a --tls-verify script), the
> impact is miminal: the last 4 bytes must still be properly signed by the
> CA, and typically contain extension fields, or the last bytes of the
> public key (which are hard to choose).  The most important bits of the
> certificate were always checked: the version, serial, signature algorithm,
> issuer, validity and subject.
> 

ACK and I agreee that we should not include backbwards compatible
behaviour for the buggy hash.

Arne


