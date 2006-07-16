Date: Sun, 16 Jul 2006 13:10:28 +0100
From: "Dave Shaw" <Dave.Shaw@...702...>
MIME-Version: 1.0
Message-ID: <WorldClient-F200607161310.AA10280361@...702...>
Subject: [Openvpn-devel] OpenVPN using ECDSA & ECDH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: OpenVPN-Devel Mailing List <openvpn-devel@lists.sourceforge.net>

Hi,

I have deployed OpenVPN on various *nix/Windows based systems with minimal
difficulty.  However I have encountered some problems when trying to
implement ECDSA as the X.509 digital cert & ECDH as the key exchange (as
described in RFC3279)

I have generated the keys using openssl (I am running a snapshot of a very
recent openssl) but when I try to specify the parameters in the
server.conf I get the following error:

Options error: Unrecognized option or missing parameter(s) in
local.conf:93: ecdh (2.0.7)

Does OpenVPN support the ECC ciphersuite as included in current versions
of OpenSSL?  I was under the impression OpenVPN supported everything
available in the OpenSSL libraries.  If anyone has already got this
working or has any answers, that would be most appreciated!

Regards,

Dave Shaw



-----------------------------------------------
Kaleidovision
The Dovecote
Brickendonbury
Brickendon
Hertford
SG13 8NP
Tel: 01992 503773
Fax: 01992 503754


