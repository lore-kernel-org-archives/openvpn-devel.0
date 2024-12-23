Date: Mon, 23 Dec 2024 10:27:44 +0100 (CET)
Message-Id: <202412230927.4BN9Ri9g030433@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241222214541.11021-1-gert@...1296...>
References: <20241222214541.11021-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move initialisation of implicit
 IVs to init_key_ctx_bi methods
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This basically "just moves code around", but adjusts calling conventions
and the subsequent code changes (no more "key_len", so the ASSERT() now
checks MAX_HMAC_KEY_LENGTH - which was the only "len" ever used.  Passing
"key" instead of "key->hmac" now, adjusting memcpy(). etc.).

Side benefit: unit test does not need to have its local copy of
init_implicit_iv() anymore.

One bit not obvious to me at first was "what about other callers to
init_key_ctx_bi() that do not have key_ctx_update_implicit_iv() today?"
(like tls-crypt-v2) - this is not a problem, as those are not using AEAD
ciphers (today), so the extra call ends up doing nothing.

Your patch has been applied to the master branch.

commit f0c26b02a7e394287052d524ef6d6bc738635692
Author: Arne Schwabe
Date:   Sun Dec 22 22:45:41 2024 +0100

     Move initialisation of implicit IVs to init_key_ctx_bi methods

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241222214541.11021-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30170.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


