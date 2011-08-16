MIME-Version: 1.0
Date: Tue, 16 Aug 2011 22:34:34 +0300
Message-ID: <CAOazyz0G7jzP0O0iD1OjynHf4gEP8j+6VFfS_fRcZPKBJG7zvw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] pkcs11-helper-1.09 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: opensc-announce@...1496..., OpenSC Development <opensc-devel@...1496...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello,

pkcs11-helper-1.09 is available.

Fixed issue introduced in 1.08 related to OpenSSL engine signature.

ChangeLog

2011-08-16 - Version 1.09

 * Do not retry if CKR_BUFFER_TOO_SMALL and none NULL target.
 * Fixup OpenSSL engine's rsa_priv_enc to use RSA size output buffer.

