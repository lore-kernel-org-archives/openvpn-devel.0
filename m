From: David Sommerseth <davids@...515...>
Date: Fri, 11 Aug 2017 22:13:02 +0200
Message-Id: <20170811201302.11766-1-davids@...515...>
In-Reply-To: <20170809074237.31291-1-a@...2181...>
References: <20170809074237.31291-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] OpenSSL: remove unreachable
 call to SSL_CTX_get0_privatekey()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: antonio@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the following branches

commit 5b004f99d069fe0238aacbb0b3288872a4d7ae17  (master)
commit a0ee61b31ced8c49ed3926adaf8c42dca4702b49  (release/2.4)
Author: Antonio Quartulli
Date:   Wed Aug 9 15:42:37 2017 +0800

     OpenSSL: remove unreachable call to SSL_CTX_get0_privatekey()

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Message-Id: <20170809074237.31291-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15186.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZjg/NAAoJEIbPlEyWcf3y1F4QAJyow7lPlSCgFUc5Yq7Yh5jy
de+FtUTELHC9lostek1wGDEQc4xloAQKMUaJRRAMUAGOOpI7Td+rbRZ+MqkUg975
dvPnJloFAFdzwVHcRjfhS/fCZ78jAmgosCXwcz4kLj+TR6ZaYRDnlIbKV+KrNISD
gMXoQnkaGcQRNkYIJJYIJ/13Eqh46Es2+O5UjSy3m/giSOfhOvy71o58WC4RwD3x
jxsjObiR4tCFEj1VbqtL8zUc6e1YkBCHmLNMcDKIiHo7tPRxo6U2FfHq0KwFqo2R
ZYn2VlzOeG332F33jqtXAUKPNLP9KrFIiFXeL++1jJWSwUoPlcW0oEBXclu6rUGG
w+DiucOp/ZwI4sir1i7aZbZwqK1L9RIT9C0DI25bJ5BgukxIyz+zBR0IvcOtPnST
OAvnbqM89uwf2KagJ0SPrfqNcGJoQ8jkJV2tm0UeNQGM+BB3fmEzRN+e82f7prbW
5rUy20NChdJc8LYNBO0jpfrabUSLQNSTbToEC6/pcG4CbLvVH6f+wTsmJVWzvcWB
fGpHaBIyZ/emKJSorMByxYXFQRgOmN+i8LG3B3nEPM9ylQ0XKF0lfHdQq/AbAFdW
PqcH4SEgSlXtP/FbVBydPbBKFZhtbePttfCQOtP6DdazSXUlOF2TztbwOghoWW7T
1FWTnln2Xy23ADls0Axm
=oLsD
-----END PGP SIGNATURE-----

