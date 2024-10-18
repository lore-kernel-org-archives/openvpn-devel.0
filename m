From: Gert Doering <gert@...1296...>
Date: Fri, 18 Oct 2024 08:31:23 +0200
Message-ID: <20241018063123.11631-1-gert@...1296...>
In-Reply-To: <gerrit.1729216832000.Ib480e57b62ea33f2aea52bee895badaf5607b72d@...2715...>
References: <gerrit.1729216832000.Ib480e57b62ea33f2aea52bee895badaf5607b72d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove unused methods write_key/read_key
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

From: Arne Schwabe <arne@...1227...>

These were used in the key-method 1 that we remove by commit
36bef1b52 in 2020.  That commit unfortunately missed that these
methods were only used for directly sending/receiving key material
over the control channel.

Change-Id: Ib480e57b62ea33f2aea52bee895badaf5607b72d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/784
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 064e59e..8f34eaa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1540,87 +1540,6 @@
     }
 }
 
-/* given a key and key_type, write key to buffer */
-bool
-write_key(const struct key *key, const struct key_type *kt,
-          struct buffer *buf)
-{
-    ASSERT(cipher_kt_key_size(kt->cipher) <= MAX_CIPHER_KEY_LENGTH
-           && md_kt_size(kt->digest) <= MAX_HMAC_KEY_LENGTH);
-
-    const uint8_t cipher_length = (uint8_t)cipher_kt_key_size(kt->cipher);
-    if (!buf_write(buf, &cipher_length, 1))
-    {
-        return false;
-    }
-
-    uint8_t hmac_length = (uint8_t)md_kt_size(kt->digest);
-
-    if (!buf_write(buf, &hmac_length, 1))
-    {
-        return false;
-    }
-    if (!buf_write(buf, key->cipher, cipher_kt_key_size(kt->cipher)))
-    {
-        return false;
-    }
-    if (!buf_write(buf, key->hmac, hmac_length))
-    {
-        return false;
-    }
-
-    return true;
-}
-
-/*
- * Given a key_type and buffer, read key from buffer.
- * Return: 1 on success
- *        -1 read failure
- *         0 on key length mismatch
- */
-int
-read_key(struct key *key, const struct key_type *kt, struct buffer *buf)
-{
-    uint8_t cipher_length;
-    uint8_t hmac_length;
-
-    CLEAR(*key);
-    if (!buf_read(buf, &cipher_length, 1))
-    {
-        goto read_err;
-    }
-    if (!buf_read(buf, &hmac_length, 1))
-    {
-        goto read_err;
-    }
-
-    if (cipher_length != cipher_kt_key_size(kt->cipher) || hmac_length != md_kt_size(kt->digest))
-    {
-        goto key_len_err;
-    }
-
-    if (!buf_read(buf, key->cipher, cipher_length))
-    {
-        goto read_err;
-    }
-    if (!buf_read(buf, key->hmac, hmac_length))
-    {
-        goto read_err;
-    }
-
-    return 1;
-
-read_err:
-    msg(D_TLS_ERRORS, "TLS Error: error reading key from remote");
-    return -1;
-
-key_len_err:
-    msg(D_TLS_ERRORS,
-        "TLS Error: key length mismatch, local cipher/hmac %d/%d, remote cipher/hmac %d/%d",
-        cipher_kt_key_size(kt->cipher), md_kt_size(kt->digest), cipher_length, hmac_length);
-    return 0;
-}
-
 void
 prng_bytes(uint8_t *output, int len)
 {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index d91de74..074dad6 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -313,11 +313,6 @@
 
 bool check_key(struct key *key, const struct key_type *kt);
 
-bool write_key(const struct key *key, const struct key_type *kt,
-               struct buffer *buf);
-
-int read_key(struct key *key, const struct key_type *kt, struct buffer *buf);
-
 /**
  * Initialize a key_type structure with.
  *

