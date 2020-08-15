From: Magnus Kroken <mkroken@...277...>
Date: Sat, 15 Aug 2020 14:05:20 +0200
Message-Id: <20200815120522.1404-1-mkroken@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] Fix mistyped option names
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
To: openvpn-devel@lists.sourceforge.net

While preparing a 2.5_beta1 package, I had to look
back and forth betwenn various sources to get option
names right. It seems that in some places names are
altered to make grammatical sense, which I find
confusing.

"Data cipher" and "compression" are simply words, and
it makes sense to use the grammatically correct form 
whenever they are used. However I interpret --data-cipher, 
``--data-cipher`` and --compression as literal, as the dashes
and code highlighting hints that this is exactly how these
are used in configuration and commands. There is no option
--data-cipher in OpenVPN, so I would not expect the literal
--data-cipher to appear anywhere, even when a sentence refers
to one singular cipher in the list of --data-ciphers.

Magnus Kroken (2):
  Changes.rst: fix mistyped option names
  doc: fix typos in cipher-negotiation.rst

 Changes.rst                             | 10 +++++-----
 doc/man-sections/cipher-negotiation.rst |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.20.1


