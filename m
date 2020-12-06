From: Antonio Quartulli <a@...2181...>
Message-ID: <a7450cf9-f278-4e51-0c96-fa9aabddd169@...2181...>
Date: Sun, 6 Dec 2020 17:09:16 +0100
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] [ovpn-dco] AES-CCM available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi all,

Some people have expressed interest in ovpn-dco supporting AES-CBC.

However, since ovpn-dco is currently using the AEAD kernel crypto API
only, introducing support for CBC mode would require quite some
refactoring and we do not really want to do that (the community believes
that as of now AEAD ciphers should always be preferred moving forward).

In a previous discussion on this mailing list, it was highlighted that
AES-CCM is nothing else than AES-CBC in disguise as AEAD cipher.

(for the curious: it is AES "Counter with CBC-MAC", known as CCM and
described in RFC3610).

For this reason I decided to give AES-CCM a try and I implemented in it
the "aes-ccm" branch of the ovpn-dco repo.

I am not sure if we're going to merge it to master yet, but for now it
would be interesting to gather feedback from those interested in this
cipher.

Please note that OpenVPN3 does not yet support this cipher, therefore
the only way to test AES-CCM in ovpn-dco is to use the ovpn-cli tool
provided in the tests/ folder.


To do so, just specify "aes-ccm" as algorithm when setting a new key.


Cheers,


-- 
Antonio Quartulli

