MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 19 May 2017 10:28:31 -0400
Message-ID: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
Subject: [Openvpn-devel] Problem with sig for 2.3.16?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

When I try to verify the signature on openvpn-2.3.16.tar.gz (using
openvpn-2.3.16.tar.gz.asc) from the "Downloads" page [1], I get the
following:

     gpg: assuming signed data in `XXX/openvpn-2.3.16.tar.gz'
     gpg: Signature made Thu May 18 16:56:48 2017 EDT using RSA key ID 8CC2B034
     gpg: Can't check signature: public key not found

The signatures on openvpn-2.3.15.tar.gz (downloaded last week) and on
openvpn-2.4.2.tar.gz both verify fine.

I think this is because Samuli's new key's ID is not 8CC2B034, it is
40864578 (if I understand correctly what is meant by "ID".)

Is 8CC2B034 the "Security mailing list GPGP key" on the "GnuPG Public
Key" page [2]? The link on that page to that key is broken (and
includes Javascript!).

Best regards,

Jon

[1] https://openvpn.net/index.php/open-source/downloads.html
[2] https://openvpn.net/index.php/open-source/documentation/sig.html

