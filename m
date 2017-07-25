References: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <1b497734-161b-50ee-e72b-87e0656c8380@...1435...>
Date: Tue, 25 Jul 2017 16:38:38 +0200
MIME-Version: 1.0
In-Reply-To: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: introduce tls_crypt_kt()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 25-07-17 16:33, Steffan Karger wrote:
> Because cipher_ctx_block_size() is a static function we now need to
> include tls_crypt.c from the tests, rather than tls_crypt.h.

Hm, something went wrong with the paste buffers.
s/cipher_ctx_block_size/tls_crypt_kt/

-Steffan

