MIME-Version: 1.0
Date: Tue, 28 Feb 2012 19:05:35 +0200
Message-ID: <CAOazyz0_D7b+oyDDQ8y2gjWUD6F8Dkp-r3UT-VNT+0dXx6J5RQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] Another undocumented feature:
	management-external-key
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, David Sommerseth <openvpn.list@...1114...>

Hello David,

Please also work to document this commit (management-notes, man).
It is extrenely important feature, for example it can be used to move
the whole smartcard
interaction to the UI.

This feature should be extended to provide X.509 certificate as well,
it is incomplete without this.

Alon

---

commit cf69617bbea45a15423c4188daa9386debcbe1ec
Author: James Yonan <james@...515...>
Date:   Thu Dec 9 11:21:04 2010 +0000

    Added "management-external-key" option.  This option can be used
    instead of "key" in client mode, and allows the client to run
    without the need to load the actual private key.  When the SSL
    protocol needs to perform an RSA sign operation, the data to
    be signed will be sent to the management interface via a
    notification as follows:

      >RSA_SIGN:[BASE64_DATA]

    The management interface client should then sign BASE64_DATA
    using the private key and return the signature as follows:

      rsa-sig
      [BASE64_SIG_LINE]
      .
      .
      .
      END

    This capability is intended to allow the use of arbitrary
    cryptographic service providers with OpenVPN via the
    management interface.

