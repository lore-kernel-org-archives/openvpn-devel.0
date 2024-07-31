From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 31 Jul 2024 09:17:02 +0000
In-Reply-To: <gerrit.1721982049000.Ia593f72f6baa6e16d2fd9b21b383b709682f9499@...2715...>
References: <gerrit.1721982049000.Ia593f72f6baa6e16d2fd9b21b383b709682f9499@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b681ebca87960c51cf9e22911e5aeed018bc3d31-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AKkH6jFfxRE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for TLV
 parsing in the PROXY protocol
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AKkH6jFfxRE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail

to look at the new patch set (#2).


Change subject: Add support for TLV parsing in the PROXY protocol
......................................................................

Add support for TLV parsing in the PROXY protocol

Version 2 of the PROXY protocol appends extra data in Type-Length-Value
vector format at the end of the header. This commit parses and processes
or stores the additional information extracted from TLVs.

Change-Id: Ia593f72f6baa6e16d2fd9b21b383b709682f9499
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/haproxy_protocol.c
M src/openvpn/haproxy_protocol.h
M tests/unit_tests/openvpn/test_haproxy_protocol.c
3 files changed, 448 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/686/2

diff --git a/src/openvpn/haproxy_protocol.c b/src/openvpn/haproxy_protocol.c
index 1786d2f..cc7cfb6 100644
--- a/src/openvpn/haproxy_protocol.c
+++ b/src/openvpn/haproxy_protocol.c
@@ -40,6 +40,74 @@
     HAPROXY_PROTOCOL_PARSING_STATE_IGNORE =3D 1,
 } haproxy_protocol_parsing_state_t;

+static const uint32_t CRC32C_TABLE[256] =3D
+{
+    0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,
+    0xC79A971FL, 0x35F1141CL, 0x26A1E7E8L, 0xD4CA64EBL,
+    0x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,
+    0x4D43CFD0L, 0xBF284CD3L, 0xAC78BF27L, 0x5E133C24L,
+    0x105EC76FL, 0xE235446CL, 0xF165B798L, 0x030E349BL,
+    0xD7C45070L, 0x25AFD373L, 0x36FF2087L, 0xC494A384L,
+    0x9A879FA0L, 0x68EC1CA3L, 0x7BBCEF57L, 0x89D76C54L,
+    0x5D1D08BFL, 0xAF768BBCL, 0xBC267848L, 0x4E4DFB4BL,
+    0x20BD8EDEL, 0xD2D60DDDL, 0xC186FE29L, 0x33ED7D2AL,
+    0xE72719C1L, 0x154C9AC2L, 0x061C6936L, 0xF477EA35L,
+    0xAA64D611L, 0x580F5512L, 0x4B5FA6E6L, 0xB93425E5L,
+    0x6DFE410EL, 0x9F95C20DL, 0x8CC531F9L, 0x7EAEB2FAL,
+    0x30E349B1L, 0xC288CAB2L, 0xD1D83946L, 0x23B3BA45L,
+    0xF779DEAEL, 0x05125DADL, 0x1642AE59L, 0xE4292D5AL,
+    0xBA3A117EL, 0x4851927DL, 0x5B016189L, 0xA96AE28AL,
+    0x7DA08661L, 0x8FCB0562L, 0x9C9BF696L, 0x6EF07595L,
+    0x417B1DBCL, 0xB3109EBFL, 0xA0406D4BL, 0x522BEE48L,
+    0x86E18AA3L, 0x748A09A0L, 0x67DAFA54L, 0x95B17957L,
+    0xCBA24573L, 0x39C9C670L, 0x2A993584L, 0xD8F2B687L,
+    0x0C38D26CL, 0xFE53516FL, 0xED03A29BL, 0x1F682198L,
+    0x5125DAD3L, 0xA34E59D0L, 0xB01EAA24L, 0x42752927L,
+    0x96BF4DCCL, 0x64D4CECFL, 0x77843D3BL, 0x85EFBE38L,
+    0xDBFC821CL, 0x2997011FL, 0x3AC7F2EBL, 0xC8AC71E8L,
+    0x1C661503L, 0xEE0D9600L, 0xFD5D65F4L, 0x0F36E6F7L,
+    0x61C69362L, 0x93AD1061L, 0x80FDE395L, 0x72966096L,
+    0xA65C047DL, 0x5437877EL, 0x4767748AL, 0xB50CF789L,
+    0xEB1FCBADL, 0x197448AEL, 0x0A24BB5AL, 0xF84F3859L,
+    0x2C855CB2L, 0xDEEEDFB1L, 0xCDBE2C45L, 0x3FD5AF46L,
+    0x7198540DL, 0x83F3D70EL, 0x90A324FAL, 0x62C8A7F9L,
+    0xB602C312L, 0x44694011L, 0x5739B3E5L, 0xA55230E6L,
+    0xFB410CC2L, 0x092A8FC1L, 0x1A7A7C35L, 0xE811FF36L,
+    0x3CDB9BDDL, 0xCEB018DEL, 0xDDE0EB2AL, 0x2F8B6829L,
+    0x82F63B78L, 0x709DB87BL, 0x63CD4B8FL, 0x91A6C88CL,
+    0x456CAC67L, 0xB7072F64L, 0xA457DC90L, 0x563C5F93L,
+    0x082F63B7L, 0xFA44E0B4L, 0xE9141340L, 0x1B7F9043L,
+    0xCFB5F4A8L, 0x3DDE77ABL, 0x2E8E845FL, 0xDCE5075CL,
+    0x92A8FC17L, 0x60C37F14L, 0x73938CE0L, 0x81F80FE3L,
+    0x55326B08L, 0xA759E80BL, 0xB4091BFFL, 0x466298FCL,
+    0x1871A4D8L, 0xEA1A27DBL, 0xF94AD42FL, 0x0B21572CL,
+    0xDFEB33C7L, 0x2D80B0C4L, 0x3ED04330L, 0xCCBBC033L,
+    0xA24BB5A6L, 0x502036A5L, 0x4370C551L, 0xB11B4652L,
+    0x65D122B9L, 0x97BAA1BAL, 0x84EA524EL, 0x7681D14DL,
+    0x2892ED69L, 0xDAF96E6AL, 0xC9A99D9EL, 0x3BC21E9DL,
+    0xEF087A76L, 0x1D63F975L, 0x0E330A81L, 0xFC588982L,
+    0xB21572C9L, 0x407EF1CAL, 0x532E023EL, 0xA145813DL,
+    0x758FE5D6L, 0x87E466D5L, 0x94B49521L, 0x66DF1622L,
+    0x38CC2A06L, 0xCAA7A905L, 0xD9F75AF1L, 0x2B9CD9F2L,
+    0xFF56BD19L, 0x0D3D3E1AL, 0x1E6DCDEEL, 0xEC064EEDL,
+    0xC38D26C4L, 0x31E6A5C7L, 0x22B65633L, 0xD0DDD530L,
+    0x0417B1DBL, 0xF67C32D8L, 0xE52CC12CL, 0x1747422FL,
+    0x49547E0BL, 0xBB3FFD08L, 0xA86F0EFCL, 0x5A048DFFL,
+    0x8ECEE914L, 0x7CA56A17L, 0x6FF599E3L, 0x9D9E1AE0L,
+    0xD3D3E1ABL, 0x21B862A8L, 0x32E8915CL, 0xC083125FL,
+    0x144976B4L, 0xE622F5B7L, 0xF5720643L, 0x07198540L,
+    0x590AB964L, 0xAB613A67L, 0xB831C993L, 0x4A5A4A90L,
+    0x9E902E7BL, 0x6CFBAD78L, 0x7FAB5E8CL, 0x8DC0DD8FL,
+    0xE330A81AL, 0x115B2B19L, 0x020BD8EDL, 0xF0605BEEL,
+    0x24AA3F05L, 0xD6C1BC06L, 0xC5914FF2L, 0x37FACCF1L,
+    0x69E9F0D5L, 0x9B8273D6L, 0x88D28022L, 0x7AB90321L,
+    0xAE7367CAL, 0x5C18E4C9L, 0x4F48173DL, 0xBD23943EL,
+    0xF36E6F75L, 0x0105EC76L, 0x12551F82L, 0xE03E9C81L,
+    0x34F4F86AL, 0xC69F7B69L, 0xD5CF889DL, 0x27A40B9EL,
+    0x79B737BAL, 0x8BDCB4B9L, 0x988C474DL, 0x6AE7C44EL,
+    0xBE2DA0A5L, 0x4C4623A6L, 0x5F16D052L, 0xAD7D5351L
+};
+
 static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;
 static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;
 static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;
@@ -90,6 +158,17 @@
     }
 }

+uint32_t
+haproxy_protocol_crc32c(const uint8_t *data, int len)
+{
+    uint32_t crc =3D 0xFFFFFFFF;
+    while (len-- > 0)
+    {
+        crc =3D (crc >> 8) ^ CRC32C_TABLE[(crc ^ (*data++)) & 0xFF];
+    }
+    return (crc ^ 0xFFFFFFFF);
+}
+
 /*
  * Parse a port number from a string.
  *
@@ -317,6 +396,271 @@
 }

 /*
+ * Parse a string based TLV and store the value in 'out'.
+ *
+ * @param tlv_info - The struct containing the garbage collector.
+ * @param out - The output variable to store the parsed value.
+ * @param type_str - A string representation of the TLV type (for logging).
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+haproxy_protocol_parse_string_tlv(struct haproxy_protocol_tlv_info *tlv_in=
fo,
+                                  char **out, char *type_str,
+                                  const uint16_t len, const uint8_t *value)
+{
+    if (len =3D=3D 0)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: %s TLV empty", type_str);
+        return;
+    }
+
+    *out =3D (char *)gc_malloc(len + 1, false, &tlv_info->gc);
+    memcpy(*out, value, len);
+    (*out)[len] =3D '\0';
+
+    if (type_str)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: %s TLV: %s", type_str, *out);
+    }
+}
+
+/*
+ * Parse the CRC32C TLV and check if it matches the calculated CRC32C.
+ * If there's a mismatch set the parsing state to invalid to drop the head=
er->
+ *
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ *
+ * @return - true if the CRC32C value matches the calculated CRC32C.
+ */
+bool
+haproxy_protocol_parse_crc32c_tlv(const uint16_t len, const uint8_t *value)
+{
+    if (len !=3D 4)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: CRC32C TLV invalid length");
+        parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_INVALID;
+        return false;
+    }
+
+    uint32_t expected =3D ntohl(*(uint32_t *)value);
+
+    /* fill the crc32c field with 0s to calculate the crc32c */
+    *(uint32_t *)value =3D 0;
+    uint32_t calculated =3D haproxy_protocol_crc32c((const uint8_t *)heade=
r, header_len);
+
+    if (expected !=3D calculated)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: CRC32C mismatch, expected: 0x%=
08x calculated: 0x%08x.", expected, calculated);
+        parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_INVALID;
+        return false;
+    }
+    msg(M_DEBUG, "PROXY protocol v2: CRC32C match");
+    return true;
+}
+
+/*
+ * Parse the UNIQUE_ID TLV and store the value in hpi->unique_id
+ * (and hpi->unique_id_len).
+ *
+ * @param tlv_info - The struct to store the parsed data.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+haproxy_protocol_parse_uid_tlv(struct haproxy_protocol_tlv_info *tlv_info,
+                               const uint16_t len, const uint8_t *value)
+{
+    if (len =3D=3D 0)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: UNIQUE_ID TLV empty");
+        return;
+    }
+    else if (len > HAPROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: UNIQUE_ID TLV too long");
+        return;
+    }
+
+    tlv_info->unique_id_len =3D len;
+    memcpy(tlv_info->unique_id, value, len);
+    msg(M_DEBUG, "PROXY protocol v2: UNIQUE_ID: %.*s", (int)tlv_info->uniq=
ue_id_len, tlv_info->unique_id);
+}
+
+/*
+ * Parse the SSL TLV (and eventually its sub-TLVs) and store the values in
+ * hpi->tlv_info.
+ *
+ * @param tlv_info - The struct to store the parsed data.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+haproxy_protocol_parse_ssl_tlv(struct haproxy_protocol_tlv_info *tlv_info,
+                               const uint16_t len, const uint8_t *value)
+{
+    const struct haproxy_protocol_tlv_ssl *ssl =3D (const struct haproxy_p=
rotocol_tlv_ssl *)(value);
+    uint16_t pos =3D sizeof(*ssl);
+
+    if (len =3D=3D 0)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: SSL TLV empty");
+        return;
+    }
+
+    if (!ssl->client)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: SSL TLV invalid client field");
+        return;
+    }
+    if (ssl->client & HAPROXY_PROTOCOL_V2_CLIENT_SSL)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client connected over SSL/TLS");
+    }
+    if (ssl->client & HAPROXY_PROTOCOL_V2_CLIENT_CERT_CONN)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client provided a certificate ove=
r the "
+            "current connection");
+    }
+    if (ssl->client & HAPROXY_PROTOCOL_V2_CLIENT_CERT_SESS)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client provided a certificate at =
least "
+            "once over the TLS session this connection belongs to");
+    }
+
+    msg(M_DEBUG, "PROXY protocol v2: client certificate verification statu=
s: %s",
+        ssl->verify ? "failure" : "success");
+    tlv_info->ssl_client =3D ssl->client;
+    tlv_info->ssl_verify =3D ssl->verify;
+
+    while (pos < len)
+    {
+        const struct haproxy_protocol_tlv *sub =3D (const struct haproxy_p=
rotocol_tlv *)(value + pos);
+        uint16_t sub_len =3D (sub->length_hi << 8) | sub->length_lo;
+        if (pos + sizeof(*sub) + sub_len > len)
+        {
+            msg(M_NONFATAL, "PROXY protocol v2: SSL sub-TLV length (%d) "
+                "exceeds buffer size (%d)",
+                sub_len, (int)(len - pos - sizeof(*sub)));
+            return;
+        }
+        switch (sub->type)
+        {
+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION:
+                haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->ssl=
_version,
+                                                  "SSL_VERSION", sub_len, =
sub->value);
+                break;
+
+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CN:
+                haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->ssl=
_cn,
+                                                  "SSL_CN", sub_len, sub->=
value);
+                break;
+
+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER:
+                haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->ssl=
_cipher,
+                                                  "SSL_CIPHER", sub_len, s=
ub->value);
+                break;
+
+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG:
+                haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->ssl=
_sig_alg,
+                                                  "SSL_SIG_ALG", sub_len, =
sub->value);
+                break;
+
+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG:
+                haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->ssl=
_key_alg,
+                                                  "SSL_KEY_ALG", sub_len, =
sub->value);
+                break;
+
+            default:
+                msg(M_NONFATAL, "PROXY protocol v2: SSL unknown sub-TLV ty=
pe 0x%02x", sub->type);
+                break;
+        }
+        pos +=3D sizeof(*sub) + sub_len;
+    }
+}
+
+/*
+ * Parse a TLV and store the value in the haproxy protocol info structure.
+ *
+ * @param hpi - The haproxy protocol info structure to store the parsed da=
ta.
+ * @param type - The TLV type.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+haproxy_protocol_parse_tlv(struct haproxy_protocol_tlv_info *tlv_info,
+                           const uint8_t type, const uint16_t len,
+                           const uint8_t *value)
+{
+    switch (type)
+    {
+        case HAPROXY_PROTOCOL_TLV_TYPE_ALPN:
+            haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->alpn, "=
ALPN", len, value);
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_AUTHORITY:
+            haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->authori=
ty, "AUTHORITY", len, value);
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_CRC32C:
+            haproxy_protocol_parse_crc32c_tlv(len, value);
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_NOOP:
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID:
+            haproxy_protocol_parse_uid_tlv(tlv_info, len, value);
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_SSL:
+            haproxy_protocol_parse_ssl_tlv(tlv_info, len, value);
+            break;
+
+        case HAPROXY_PROTOCOL_TLV_TYPE_NETNS:
+            haproxy_protocol_parse_string_tlv(tlv_info, &tlv_info->netns, =
"NETNS", len, value);
+            break;
+
+        default:
+            msg(M_NONFATAL, "PROXY protocol v2: unknown TLV type 0x%02x", =
type);
+            break;
+    }
+}
+
+/*
+ * Parse the TLVs in the PROXY protocol v2 header->
+ *
+ * @param hpi - The haproxy protocol info structure to store the parsed da=
ta.
+ * @param buf - The buffer containing the TLVs.
+ * @param buf_len - The length of the buffer.
+ *
+ * @return - The number of bytes parsed or -1 if an error occurred.
+ */
+int
+haproxy_protocol_parse_tlvs(struct haproxy_protocol_tlv_info *tlv_info,
+                            const uint8_t *buf, const int buf_len)
+{
+    const uint8_t *end =3D buf + buf_len;
+    const uint8_t *start =3D buf;
+
+    tlv_info->gc =3D gc_new();
+    while (buf < end && parsing_state =3D=3D HAPROXY_PROTOCOL_PARSING_STAT=
E_OK)
+    {
+        const struct haproxy_protocol_tlv *tlv =3D (const struct haproxy_p=
rotocol_tlv *)buf;
+        uint16_t tlv_len =3D (tlv->length_hi << 8) | tlv->length_lo;
+        if (buf + sizeof(*tlv) + tlv_len > end)
+        {
+            msg(M_NONFATAL, "PROXY protocol v2: TLV length exceeds buffer =
size");
+            return -1;
+        }
+        haproxy_protocol_parse_tlv(tlv_info, tlv->type, tlv_len, tlv->valu=
e);
+        buf +=3D sizeof(*tlv) + tlv_len;
+    }
+    return (int)(buf - start);
+}
+
+/*
  * Parse the PROXY protocol v2 header
  *
  * @param hpi - The haproxy protocol info structure to store the parsed da=
ta.
@@ -452,7 +796,9 @@
         {
             if ((header->v2.ver_cmd & HAPROXY_PROTOCOL_V2_VER_MASK) =3D=3D=
 HAPROXY_PROTOCOL_V2_VER)
             {
-                haproxy_protocol_parse_v2(hpi);
+                const int pos =3D haproxy_protocol_parse_v2(hpi);
+                haproxy_protocol_parse_tlvs(&hpi->tlv, buf + pos,
+                                            header_len - pos);
                 if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)
                 {
                     msg(M_DEBUG, "PROXY protocol v2: %s header",
@@ -484,4 +830,5 @@
     header =3D NULL;
     header_len =3D 0;
     parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_OK;
+    gc_free(&hpi->tlv.gc);
 }
diff --git a/src/openvpn/haproxy_protocol.h b/src/openvpn/haproxy_protocol.h
index 5ffcfa5..6415bf2 100644
--- a/src/openvpn/haproxy_protocol.h
+++ b/src/openvpn/haproxy_protocol.h
@@ -88,6 +88,22 @@
     HAPROXY_PROTOCOL_VERSION_2,
 } haproxy_protocol_version_t;

+struct haproxy_protocol_tlv
+{
+    uint8_t type;
+    uint8_t length_hi;
+    uint8_t length_lo;
+    uint8_t value[0];
+};
+
+#pragma pack(push, 1)
+struct haproxy_protocol_tlv_ssl
+{
+    uint8_t client;
+    uint32_t verify;
+} __attribute__((packed));
+#pragma pack(pop)
+
 #pragma pack(push, 1)
 typedef union
 {
@@ -127,12 +143,32 @@
 } __attribute__((packed)) haproxy_protocol_header_t;
 #pragma pack(pop)

+struct haproxy_protocol_tlv_info
+{
+    struct gc_arena gc;
+
+    char *alpn;
+    char *authority;
+    uint8_t unique_id[HAPROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN + 1];
+    uint16_t unique_id_len;
+    uint8_t ssl_client;
+    uint32_t ssl_verify;
+    char *ssl_version;
+    char *ssl_cn;
+    char *ssl_cipher;
+    char *ssl_sig_alg;
+    char *ssl_key_alg;
+    char *netns;
+};
+
 struct haproxy_protocol_info
 {
     haproxy_protocol_version_t version;
     int sock_type;
     struct openvpn_sockaddr src;
     struct openvpn_sockaddr dst;
+
+    struct haproxy_protocol_tlv_info tlv;
 };

 /*
diff --git a/tests/unit_tests/openvpn/test_haproxy_protocol.c b/tests/unit_=
tests/openvpn/test_haproxy_protocol.c
index 0464315..f1070ce 100644
--- a/tests/unit_tests/openvpn/test_haproxy_protocol.c
+++ b/tests/unit_tests/openvpn/test_haproxy_protocol.c
@@ -121,6 +121,19 @@
     HP2_V4_DST_PORT,
 };

+static uint8_t HP2_TEST_WRONG_CRC32C[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x7c, /* length */
+    HP2_V4_SRC_ADDR,
+    HP2_V4_DST_ADDR,
+    HP2_V4_SRC_PORT,
+    HP2_V4_DST_PORT,
+    HP2_TLV,
+    0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00 /* crc32c */
+};
+
 static uint8_t HP2_TEST_PROXY_TCP4[] =3D {
     HP2_SIG,
     HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
@@ -232,9 +245,30 @@
 }

 static bool
+compare_hpi_tlv(void **state, struct haproxy_protocol_info *actual, struct=
 haproxy_protocol_info *expected)
+{
+    return strcmp(actual->tlv.alpn, expected->tlv.alpn) =3D=3D 0
+           && strcmp(actual->tlv.authority, expected->tlv.authority) =3D=
=3D 0
+           && actual->tlv.unique_id_len =3D=3D expected->tlv.unique_id_len
+           && memcmp(actual->tlv.unique_id, expected->tlv.unique_id, actua=
l->tlv.unique_id_len) =3D=3D 0
+           && actual->tlv.ssl_client =3D=3D expected->tlv.ssl_client
+           && actual->tlv.ssl_verify =3D=3D expected->tlv.ssl_verify
+           && strcmp(actual->tlv.ssl_version, expected->tlv.ssl_version) =
=3D=3D 0
+           && strcmp(actual->tlv.ssl_cn, expected->tlv.ssl_cn) =3D=3D 0
+           && strcmp(actual->tlv.ssl_cipher, expected->tlv.ssl_cipher) =3D=
=3D 0
+           && strcmp(actual->tlv.ssl_sig_alg, expected->tlv.ssl_sig_alg) =
=3D=3D 0
+           && strcmp(actual->tlv.ssl_key_alg, expected->tlv.ssl_key_alg) =
=3D=3D 0
+           && strcmp(actual->tlv.netns, expected->tlv.netns) =3D=3D 0;
+}
+
+static bool
 compare_hpi(void **state, struct haproxy_protocol_info *actual, struct hap=
roxy_protocol_info *expected)
 {
-    return compare_hpi_basic(state, actual, expected);
+    if (actual->version !=3D HAPROXY_PROTOCOL_VERSION_2)
+    {
+        return compare_hpi_basic(state, actual, expected);
+    }
+    return compare_hpi_basic(state, actual, expected) && compare_hpi_tlv(s=
tate, actual, expected);
 }

 static int
@@ -305,6 +339,11 @@
     memset((actual), 0, sizeof(struct haproxy_protocol_info));
     assert_false(haproxy_protocol_parse(actual, HP2_TEST_LOCAL, sizeof(HP2=
_TEST_LOCAL)));

+    /* v2 wrong crc32c */
+    haproxy_protocol_reset(actual);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    assert_false(haproxy_protocol_parse(actual, HP2_TEST_WRONG_CRC32C, siz=
eof(HP2_TEST_WRONG_CRC32C)));
+
     /* v2 TCP4 */
     haproxy_protocol_reset(actual);
     haproxy_protocol_reset(expected);
@@ -318,6 +357,18 @@
     expected->dst.addr.in4.sin_family =3D AF_INET;
     expected->dst.addr.in4.sin_port =3D ntohs(1195);
     expected->dst.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1401);
+    expected->tlv.alpn =3D "h23";
+    expected->tlv.authority =3D "example.com";
+    expected->tlv.unique_id_len =3D 15;
+    memcpy(expected->tlv.unique_id, "\x75\x6E\x69\x71\x75\x65\x2D\x69\x64\=
x2D\x76\x61\x6C\x75\x65", 15);
+    expected->tlv.ssl_client =3D HAPROXY_PROTOCOL_V2_CLIENT_SSL;
+    expected->tlv.ssl_verify =3D 0;
+    expected->tlv.ssl_version =3D "TLS1.3";
+    expected->tlv.ssl_cn =3D "client";
+    expected->tlv.ssl_cipher =3D "AES256";
+    expected->tlv.ssl_sig_alg =3D "SHA256";
+    expected->tlv.ssl_key_alg =3D "RSA2048";
+    expected->tlv.netns =3D "netns-1";
     haproxy_protocol_parse(actual, HP2_TEST_PROXY_TCP4, sizeof(HP2_TEST_PR=
OXY_TCP4));
     assert_true(compare_hpi(state, actual, expected));

@@ -334,6 +385,18 @@
     expected->dst.addr.in6.sin6_family =3D AF_INET6;
     expected->dst.addr.in6.sin6_port =3D ntohs(1195);
     inet_pton(AF_INET6, "2001:db8:20::1", &expected->dst.addr.in6.sin6_add=
r);
+    expected->tlv.alpn =3D "h23";
+    expected->tlv.authority =3D "example.com";
+    expected->tlv.unique_id_len =3D 15;
+    memcpy(expected->tlv.unique_id, "\x75\x6E\x69\x71\x75\x65\x2D\x69\x64\=
x2D\x76\x61\x6C\x75\x65", 15);
+    expected->tlv.ssl_client =3D HAPROXY_PROTOCOL_V2_CLIENT_SSL;
+    expected->tlv.ssl_verify =3D 0;
+    expected->tlv.ssl_version =3D "TLS1.3";
+    expected->tlv.ssl_cn =3D "client";
+    expected->tlv.ssl_cipher =3D "AES256";
+    expected->tlv.ssl_sig_alg =3D "SHA256";
+    expected->tlv.ssl_key_alg =3D "RSA2048";
+    expected->tlv.netns =3D "netns-1";
     haproxy_protocol_parse(actual, HP2_TEST_PROXY_TCP6, sizeof(HP2_TEST_PR=
OXY_TCP6));
     assert_true(compare_hpi(state, actual, expected));


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia593f72f6baa6e16d2fd9b21b383b709682f9499
Gerrit-Change-Number: 686
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-MessageType: newpatchset

--AKkH6jFfxRE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add support for TLV parsing in the PROXY protocol<br><br>Version 2 of=
 the PROXY protocol appends extra data in Type-Length-Value<br>vector forma=
t at the end of the header. This commit parses and processes<br>or stores t=
he additional information extracted from TLVs.<br><br>Change-Id: Ia593f72f6=
baa6e16d2fd9b21b383b709682f9499<br>Signed-off-by: Ralf Lici &lt;ralf@...2788...=
6...&gt;<br>---<br>M src/openvpn/haproxy_protocol.c<br>M src/openvpn/haprox=
y_protocol.h<br>M tests/unit_tests/openvpn/test_haproxy_protocol.c<br>3 fil=
es changed, 448 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/86/686/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/haproxy_protocol.c b/src/openvpn/haproxy_protocol.c</span><br><spa=
n>index 1786d2f..cc7cfb6 100644</span><br><span>--- a/src/openvpn/haproxy_p=
rotocol.c</span><br><span>+++ b/src/openvpn/haproxy_protocol.c</span><br><s=
pan>@@ -40,6 +40,74 @@</span><br><span>     HAPROXY_PROTOCOL_PARSING_STATE_=
IGNORE =3D 1,</span><br><span> } haproxy_protocol_parsing_state_t;</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static con=
st uint32_t CRC32C_TABLE[256] =3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0xC79A971FL, 0x35F1141CL, 0x26A1E7E8L=
, 0xD4CA64EBL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0x4D43CFD0L, 0xBF284CD3L, 0xAC78BF27L, 0=
x5E133C24L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x10=
5EC76FL, 0xE235446CL, 0xF165B798L, 0x030E349BL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0xD7C45070L, 0x25AFD373L, 0x36FF2087L, 0xC4=
94A384L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x9A879=
FA0L, 0x68EC1CA3L, 0x7BBCEF57L, 0x89D76C54L,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    0x5D1D08BFL, 0xAF768BBCL, 0xBC267848L, 0x4E4DF=
B4BL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x20BD8EDE=
L, 0xD2D60DDDL, 0xC186FE29L, 0x33ED7D2AL,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0xE72719C1L, 0x154C9AC2L, 0x061C6936L, 0xF477EA35=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xAA64D611L, =
0x580F5512L, 0x4B5FA6E6L, 0xB93425E5L,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x6DFE410EL, 0x9F95C20DL, 0x8CC531F9L, 0x7EAEB2FAL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x30E349B1L, 0xC=
288CAB2L, 0xD1D83946L, 0x23B3BA45L,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0xF779DEAEL, 0x05125DADL, 0x1642AE59L, 0xE4292D5AL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xBA3A117EL, 0x4851=
927DL, 0x5B016189L, 0xA96AE28AL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    0x7DA08661L, 0x8FCB0562L, 0x9C9BF696L, 0x6EF07595L,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x417B1DBCL, 0xB3109EB=
FL, 0xA0406D4BL, 0x522BEE48L,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x86E18AA3L, 0x748A09A0L, 0x67DAFA54L, 0x95B17957L,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0xCBA24573L, 0x39C9C670L,=
 0x2A993584L, 0xD8F2B687L,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0x0C38D26CL, 0xFE53516FL, 0xED03A29BL, 0x1F682198L,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0x5125DAD3L, 0xA34E59D0L, 0x=
B01EAA24L, 0x42752927L,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x96BF4DCCL, 0x64D4CECFL, 0x77843D3BL, 0x85EFBE38L,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0xDBFC821CL, 0x2997011FL, 0x3AC=
7F2EBL, 0xC8AC71E8L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x1C661503L, 0xEE0D9600L, 0xFD5D65F4L, 0x0F36E6F7L,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0x61C69362L, 0x93AD1061L, 0x80FDE3=
95L, 0x72966096L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0xA65C047DL, 0x5437877EL, 0x4767748AL, 0xB50CF789L,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0xEB1FCBADL, 0x197448AEL, 0x0A24BB5AL=
, 0xF84F3859L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x2C855CB2L, 0xDEEEDFB1L, 0xCDBE2C45L, 0x3FD5AF46L,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0x7198540DL, 0x83F3D70EL, 0x90A324FAL, 0=
x62C8A7F9L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xB6=
02C312L, 0x44694011L, 0x5739B3E5L, 0xA55230E6L,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0xFB410CC2L, 0x092A8FC1L, 0x1A7A7C35L, 0xE8=
11FF36L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x3CDB9=
BDDL, 0xCEB018DEL, 0xDDE0EB2AL, 0x2F8B6829L,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    0x82F63B78L, 0x709DB87BL, 0x63CD4B8FL, 0x91A6C=
88CL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x456CAC67=
L, 0xB7072F64L, 0xA457DC90L, 0x563C5F93L,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0x082F63B7L, 0xFA44E0B4L, 0xE9141340L, 0x1B7F9043=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xCFB5F4A8L, =
0x3DDE77ABL, 0x2E8E845FL, 0xDCE5075CL,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x92A8FC17L, 0x60C37F14L, 0x73938CE0L, 0x81F80FE3L,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x55326B08L, 0xA=
759E80BL, 0xB4091BFFL, 0x466298FCL,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0x1871A4D8L, 0xEA1A27DBL, 0xF94AD42FL, 0x0B21572CL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xDFEB33C7L, 0x2D80=
B0C4L, 0x3ED04330L, 0xCCBBC033L,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    0xA24BB5A6L, 0x502036A5L, 0x4370C551L, 0xB11B4652L,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x65D122B9L, 0x97BAA1B=
AL, 0x84EA524EL, 0x7681D14DL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x2892ED69L, 0xDAF96E6AL, 0xC9A99D9EL, 0x3BC21E9DL,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0xEF087A76L, 0x1D63F975L,=
 0x0E330A81L, 0xFC588982L,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0xB21572C9L, 0x407EF1CAL, 0x532E023EL, 0xA145813DL,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0x758FE5D6L, 0x87E466D5L, 0x=
94B49521L, 0x66DF1622L,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x38CC2A06L, 0xCAA7A905L, 0xD9F75AF1L, 0x2B9CD9F2L,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0xFF56BD19L, 0x0D3D3E1AL, 0x1E6=
DCDEEL, 0xEC064EEDL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0xC38D26C4L, 0x31E6A5C7L, 0x22B65633L, 0xD0DDD530L,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0x0417B1DBL, 0xF67C32D8L, 0xE52CC1=
2CL, 0x1747422FL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0x49547E0BL, 0xBB3FFD08L, 0xA86F0EFCL, 0x5A048DFFL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x8ECEE914L, 0x7CA56A17L, 0x6FF599E3L=
, 0x9D9E1AE0L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
xD3D3E1ABL, 0x21B862A8L, 0x32E8915CL, 0xC083125FL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0x144976B4L, 0xE622F5B7L, 0xF5720643L, 0=
x07198540L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x59=
0AB964L, 0xAB613A67L, 0xB831C993L, 0x4A5A4A90L,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0x9E902E7BL, 0x6CFBAD78L, 0x7FAB5E8CL, 0x8D=
C0DD8FL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xE330A=
81AL, 0x115B2B19L, 0x020BD8EDL, 0xF0605BEEL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    0x24AA3F05L, 0xD6C1BC06L, 0xC5914FF2L, 0x37FAC=
CF1L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x69E9F0D5=
L, 0x9B8273D6L, 0x88D28022L, 0x7AB90321L,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0xAE7367CAL, 0x5C18E4C9L, 0x4F48173DL, 0xBD23943E=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xF36E6F75L, =
0x0105EC76L, 0x12551F82L, 0xE03E9C81L,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x34F4F86AL, 0xC69F7B69L, 0xD5CF889DL, 0x27A40B9EL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x79B737BAL, 0x8=
BDCB4B9L, 0x988C474DL, 0x6AE7C44EL,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0xBE2DA0A5L, 0x4C4623A6L, 0x5F16D052L, 0xAD7D5351L</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static const size_t HAP=
ROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;</span><br><span> static const size_t=
 HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;</span><br><span> static const si=
ze_t HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;</span><br><span>@@ -90,6 +1=
58,17 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_crc32c(const uint8_t=
 *data, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t crc =3D =
0xFFFFFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e (len-- &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        crc =3D (=
crc &gt;&gt; 8) ^ CRC32C_TABLE[(crc ^ (*data++)) &amp; 0xFF];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return (crc ^ 0xFFFFFFFF);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Parse a port =
number from a string.</span><br><span>  *</span><br><span>@@ -317,6 +396,27=
1 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Parse a string based TLV and s=
tore the value in &#39;out&#39;.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param tlv_info - The struct containing the garbage collector.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param out - The output variab=
le to store the parsed value.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param type_str - A string representation of the TLV type (for=
 logging).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 len - The length of the TLV value.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param value - The TLV value.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ha=
proxy_protocol_parse_string_tlv(struct haproxy_protocol_tlv_info *tlv_info,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
               char **out, char *type_str,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                  const uint16_t len=
, const uint8_t *value)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, =
&quot;PROXY protocol v2: %s TLV empty&quot;, type_str);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *out =3D (char *)gc_malloc(len + 1, false, &amp;tlv_info-&gt;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(*out, value, =
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (*out)[len=
] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (type_str)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY pr=
otocol v2: %s TLV: %s&quot;, type_str, *out);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Parse the CRC32C TLV and check if it m=
atches the calculated CRC32C.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * If there&#39;s a mismatch set the parsing state to invalid to =
drop the header-&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param len - =
The length of the TLV value.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param value - The TLV value.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return - true if the CRC32C value matches the calculated CRC32C.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+haproxy_protocol_parse_crc32c_tlv(const uint16_t len=
, const uint8_t *value)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len !=
=3D 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &qu=
ot;PROXY protocol v2: CRC32C TLV invalid length&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        parsing_state =3D HAPROXY_PROTO=
COL_PARSING_STATE_INVALID;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t expected =
=3D ntohl(*(uint32_t *)value);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* f=
ill the crc32c field with 0s to calculate the crc32c */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    *(uint32_t *)value =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t calculated =3D h=
aproxy_protocol_crc32c((const uint8_t *)header, header_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (expected !=3D calculated)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: CRC3=
2C mismatch, expected: 0x%08x calculated: 0x%08x.&quot;, expected, calculat=
ed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        parsing=
_state =3D HAPROXY_PROTOCOL_PARSING_STATE_INVALID;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(M_DEBUG, &quot;PROXY protocol v2: CRC32C match&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Parse the UNIQUE_ID TLV and store the value in hpi-&gt;unique_id</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (and hpi-&gt;uniqu=
e_id_len).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tlv_info - The s=
truct to store the parsed data.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param len - The length of the TLV value.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param value - The TLV value.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+haproxy_protocol_parse_uid_tlv(struct haproxy_protocol_t=
lv_info *tlv_info,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                              const uint16_t len, const uint8_t *value)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: UNIQ=
UE_ID TLV empty&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (l=
en &gt; HAPROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: UNIQUE_ID=
 TLV too long&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tlv_info-&gt;unique_id_len =3D =
len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(tlv_=
info-&gt;unique_id, value, len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(M_DEBUG, &quot;PROXY protocol v2: UNIQUE_ID: %.*s&quot=
;, (int)tlv_info-&gt;unique_id_len, tlv_info-&gt;unique_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the =
SSL TLV (and eventually its sub-TLVs) and store the values in</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * hpi-&gt;tlv_info.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param tlv_info - The struct to store the pars=
ed data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param l=
en - The length of the TLV value.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param value - The TLV value.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hapr=
oxy_protocol_parse_ssl_tlv(struct haproxy_protocol_tlv_info *tlv_info,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
       const uint16_t len, const uint8_t *value)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct haproxy_protocol_tlv_ssl *ssl =3D (const struct=
 haproxy_protocol_tlv_ssl *)(value);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint16_t pos =3D sizeof(*ssl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (len =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_NONFATAL, &quot;PROXY protocol v2: SSL TLV empty&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!ssl-&gt;client)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: SSL TLV invalid cl=
ient field&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ssl-&gt;cli=
ent &amp; HAPROXY_PROTOCOL_V2_CLIENT_SSL)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_DEBUG, &quot;PROXY protocol v2: client connected over=
 SSL/TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ssl-&gt;c=
lient &amp; HAPROXY_PROTOCOL_V2_CLIENT_CERT_CONN)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol v2: client provid=
ed a certificate over the &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;current connection&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (ssl-&gt;client &amp; HAPROXY_PROTOCOL_V2_CL=
IENT_CERT_SESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBU=
G, &quot;PROXY protocol v2: client provided a certificate at least &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;onc=
e over the TLS session this connection belongs to&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    msg(M_DEBUG, &quot;PROXY protocol v2: client certificate verificat=
ion status: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ssl-&gt;verify ? &quot;failure&quot; : &quot;success&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tlv_info-&gt;ssl_cli=
ent =3D ssl-&gt;client;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    tlv_info-&gt;ssl_verify =3D ssl-&gt;verify;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    while (pos &lt; len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const struct haproxy_protocol_tlv *sub =3D (const struct hapr=
oxy_protocol_tlv *)(value + pos);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uint16_t sub_len =3D (sub-&gt;length_hi &lt;&lt; 8) |=
 sub-&gt;length_lo;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (pos + sizeof(*sub) + sub_len &gt; len)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;PROXY protocol v2: S=
SL sub-TLV length (%d) &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;exceeds buffer size (%d)&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sub_len, (int)(=
len - pos - sizeof(*sub)));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      switch (sub-&gt;type)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                haproxy_protocol_parse=
_string_tlv(tlv_info, &amp;tlv_info-&gt;ssl_version,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
         &quot;SSL_VERSION&quot;, sub_len, sub-&gt;value);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CN=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ha=
proxy_protocol_parse_string_tlv(tlv_info, &amp;tlv_info-&gt;ssl_cn,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                       &quot;SSL_CN&quot;, sub_len, sub-&gt;value);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                break;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            case HAPROXY_PROTOCOL_TLV_SUB=
TYPE_SSL_CIPHER:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             haproxy_protocol_parse_string_tlv(tlv_info, &amp;tlv_info-&gt;=
ssl_cipher,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                          &quot;SSL_CIPHER&quot;, sub_len, =
sub-&gt;value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            case HAP=
ROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                haproxy_protocol_parse_string_tlv(tlv_in=
fo, &amp;tlv_info-&gt;ssl_sig_alg,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                  &quot;SSL_=
SIG_ALG&quot;, sub_len, sub-&gt;value);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            case HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                haproxy_protocol=
_parse_string_tlv(tlv_info, &amp;tlv_info-&gt;ssl_key_alg,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
              &quot;SSL_KEY_ALG&quot;, sub_len, sub-&gt;value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            default:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(M_NONFATAL, &quot;PROXY pr=
otocol v2: SSL unknown sub-TLV type 0x%02x&quot;, sub-&gt;type);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                break;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        pos +=3D sizeof(*sub) + sub_l=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse =
a TLV and store the value in the haproxy protocol info structure.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param hpi - The haproxy protocol info stru=
cture to store the parsed data.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param type - The TLV type.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param len - The length of the TLV value.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param value - The TLV v=
alue.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+haproxy_protocol_parse_tlv(struct haproxy_pro=
tocol_tlv_info *tlv_info,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                           const uint8_t type, const uint16_t len,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     const uint8_t *value)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch =
(type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOC=
OL_TLV_TYPE_ALPN:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          haproxy_protocol_parse_string_tlv(tlv_info, &amp;tlv_info-&gt;alp=
n, &quot;ALPN&quot;, len, value);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case HAPROXY_PROTOCOL_TLV_TYPE_AUTHORITY:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            haproxy_protocol_parse_string_tlv(tlv_i=
nfo, &amp;tlv_info-&gt;authority, &quot;AUTHORITY&quot;, len, value);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_TLV_TYPE_CRC32C=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            haprox=
y_protocol_parse_crc32c_tlv(len, value);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case HAPROXY_PROTOCOL_TLV_TYPE_NOOP:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case HAPROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            haproxy_protocol_parse_uid_=
tlv(tlv_info, len, value);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case =
HAPROXY_PROTOCOL_TLV_TYPE_SSL:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            haproxy_protocol_parse_ssl_tlv(tlv_info, len, value)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_TLV_TYPE=
_NETNS:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
haproxy_protocol_parse_string_tlv(tlv_info, &amp;tlv_info-&gt;netns, &quot;=
NETNS&quot;, len, value);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        defaul=
t:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M=
_NONFATAL, &quot;PROXY protocol v2: unknown TLV type 0x%02x&quot;, type);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the TL=
Vs in the PROXY protocol v2 header-&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param hpi - The haproxy protocol info structure to store the parsed =
data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf =
- The buffer containing the TLVs.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param buf_len - The length of the buffer.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return - The number of bytes parsed or -1 if an =
error occurred.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_parse_tlvs(struct h=
aproxy_protocol_tlv_info *tlv_info,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            const uint8_t *buf, const int b=
uf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *end =3D buf=
 + buf_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t *start =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tlv_info-=
&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (buf &lt; end &amp;&amp; parsing_state =3D=3D HAPROXY_PROTOCOL_P=
ARSING_STATE_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const str=
uct haproxy_protocol_tlv *tlv =3D (const struct haproxy_protocol_tlv *)buf;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t tl=
v_len =3D (tlv-&gt;length_hi &lt;&lt; 8) | tlv-&gt;length_lo;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (buf + sizeof(*tlv) + =
tlv_len &gt; end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_NONFATAL, &quot;PROXY protocol v2: TLV length exceeds buffer size&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        haproxy_protoc=
ol_parse_tlv(tlv_info, tlv-&gt;type, tlv_len, tlv-&gt;value);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        buf +=3D sizeof(*tlv) + t=
lv_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)(buf - sta=
rt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span>  * Parse the PROXY protocol v2 h=
eader</span><br><span>  *</span><br><span>  * @param hpi - The haproxy prot=
ocol info structure to store the parsed data.</span><br><span>@@ -452,7 +79=
6,9 @@</span><br><span>         {</span><br><span>             if ((header-=
&gt;v2.ver_cmd &amp; HAPROXY_PROTOCOL_V2_VER_MASK) =3D=3D HAPROXY_PROTOCOL_=
V2_VER)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                haproxy_protocol_parse_v2(hpi);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const int pos =
=3D haproxy_protocol_parse_v2(hpi);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                haproxy_protocol_parse_tlvs(&amp;hpi-&gt;tl=
v, buf + pos,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                      header_len - pos);</span><br><span>  =
               if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)</s=
pan><br><span>                 {</span><br><span>                     msg(M=
_DEBUG, &quot;PROXY protocol v2: %s header&quot;,</span><br><span>@@ -484,4=
 +830,5 @@</span><br><span>     header =3D NULL;</span><br><span>     heade=
r_len =3D 0;</span><br><span>     parsing_state =3D HAPROXY_PROTOCOL_PARSIN=
G_STATE_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;hpi-&gt;tlv.gc);</span><br><span> }</span><br><span>diff --git a/s=
rc/openvpn/haproxy_protocol.h b/src/openvpn/haproxy_protocol.h</span><br><s=
pan>index 5ffcfa5..6415bf2 100644</span><br><span>--- a/src/openvpn/haproxy=
_protocol.h</span><br><span>+++ b/src/openvpn/haproxy_protocol.h</span><br>=
<span>@@ -88,6 +88,22 @@</span><br><span>     HAPROXY_PROTOCOL_VERSION_2,</=
span><br><span> } haproxy_protocol_version_t;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct haproxy_protocol_tlv</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t type;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t length_hi;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint8_t length_lo;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint8_t value[0];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma pack(push, 1)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct haproxy_protocol_tlv_ssl</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t client;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint32_t verify;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+} __attribute__((packed));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma pack(pop)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #pragma pack(push, 1)</span><br><span> typedef un=
ion</span><br><span> {</span><br><span>@@ -127,12 +143,32 @@</span><br><spa=
n> } __attribute__((packed)) haproxy_protocol_header_t;</span><br><span> #p=
ragma pack(pop)</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+struct haproxy_protocol_tlv_info</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *alpn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
authority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8=
_t unique_id[HAPROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN + 1];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint16_t unique_id_len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t ssl_client;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ssl_verif=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ssl_ver=
sion;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ssl_=
cn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ssl_ci=
pher;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ssl_=
sig_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *s=
sl_key_alg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 *netns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct hap=
roxy_protocol_info</span><br><span> {</span><br><span>     haproxy_protocol=
_version_t version;</span><br><span>     int sock_type;</span><br><span>   =
  struct openvpn_sockaddr src;</span><br><span>     struct openvpn_sockaddr=
 dst;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct haproxy_protocol_tlv_i=
nfo tlv;</span><br><span> };</span><br><span> </span><br><span> /*</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_haproxy_protocol.c b/tes=
ts/unit_tests/openvpn/test_haproxy_protocol.c</span><br><span>index 0464315=
..f1070ce 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_haprox=
y_protocol.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_haproxy_pr=
otocol.c</span><br><span>@@ -121,6 +121,19 @@</span><br><span>     HP2_V4_D=
ST_PORT,</span><br><span> };</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static uint8_t HP2_TEST_WRONG_CRC32C[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_SIG,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_VER | =
HAPROXY_PROTOCOL_V2_PROXY_CMD,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00, 0x7c, /* =
length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V4=
_SRC_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V=
4_DST_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_=
V4_SRC_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2=
_V4_DST_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP=
2_TLV,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x03, 0x0=
0, 0x04, 0x00, 0x00, 0x00, 0x00 /* crc32c */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> static uint8_t HP2_TEST_PROXY_TCP4[] =3D {</span>=
<br><span>     HP2_SIG,</span><br><span>     HAPROXY_PROTOCOL_V2_VER | HAPR=
OXY_PROTOCOL_V2_PROXY_CMD,</span><br><span>@@ -232,9 +245,30 @@</span><br><=
span> }</span><br><span> </span><br><span> static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+compare_hpi_tlv(void **state, struct hap=
roxy_protocol_info *actual, struct haproxy_protocol_info *expected)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return strcmp(actual-&gt;tlv.alpn, expect=
ed-&gt;tlv.alpn) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+           &amp;&amp; strcmp(actual-&gt;tlv.authority, expected-&gt;t=
lv.authority) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           &amp;&amp; actual-&gt;tlv.unique_id_len =3D=3D expected-&gt;t=
lv.unique_id_len</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &amp;&amp; memcmp(actual-&gt;tlv.unique_id, expected-&gt;tlv.unique=
_id, actual-&gt;tlv.unique_id_len) =3D=3D 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &amp;&amp; actual-&gt;tlv.ssl_client =3D=
=3D expected-&gt;tlv.ssl_client</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           &amp;&amp; actual-&gt;tlv.ssl_verify =3D=3D expected=
-&gt;tlv.ssl_verify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           &amp;&amp; strcmp(actual-&gt;tlv.ssl_version, expected-&gt;tlv.s=
sl_version) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           &amp;&amp; strcmp(actual-&gt;tlv.ssl_cn, expected-&gt;tlv.ssl_c=
n) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
   &amp;&amp; strcmp(actual-&gt;tlv.ssl_cipher, expected-&gt;tlv.ssl_cipher=
) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
  &amp;&amp; strcmp(actual-&gt;tlv.ssl_sig_alg, expected-&gt;tlv.ssl_sig_al=
g) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
   &amp;&amp; strcmp(actual-&gt;tlv.ssl_key_alg, expected-&gt;tlv.ssl_key_a=
lg) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
    &amp;&amp; strcmp(actual-&gt;tlv.netns, expected-&gt;tlv.netns) =3D=3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span> compare_hpi(void **state,=
 struct haproxy_protocol_info *actual, struct haproxy_protocol_info *expect=
ed)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return compare_hpi_basic(state, actual, expected);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (actual-&gt;version !=3D HAPROXY=
_PROTOCOL_VERSION_2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n compare_hpi_basic(state, actual, expected);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return compare_hpi_basic(state, actual, expected) &amp;&amp=
; compare_hpi_tlv(state, actual, expected);</span><br><span> }</span><br><s=
pan> </span><br><span> static int</span><br><span>@@ -305,6 +339,11 @@</spa=
n><br><span>     memset((actual), 0, sizeof(struct haproxy_protocol_info));=
</span><br><span>     assert_false(haproxy_protocol_parse(actual, HP2_TEST_=
LOCAL, sizeof(HP2_TEST_LOCAL)));</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* v2 wrong crc32c */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(actual);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset((actual), 0=
, sizeof(struct haproxy_protocol_info));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(haproxy_protocol_parse(actual, HP2_TE=
ST_WRONG_CRC32C, sizeof(HP2_TEST_WRONG_CRC32C)));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     /* v2 TCP4 */</span><br=
><span>     haproxy_protocol_reset(actual);</span><br><span>     haproxy_pr=
otocol_reset(expected);</span><br><span>@@ -318,6 +357,18 @@</span><br><spa=
n>     expected-&gt;dst.addr.in4.sin_family =3D AF_INET;</span><br><span>  =
   expected-&gt;dst.addr.in4.sin_port =3D ntohs(1195);</span><br><span>    =
 expected-&gt;dst.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1401);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.alpn =3D=
 &quot;h23&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  expected-&gt;tlv.authority =3D &quot;example.com&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.unique_id_len =
=3D 15;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(e=
xpected-&gt;tlv.unique_id, &quot;\x75\x6E\x69\x71\x75\x65\x2D\x69\x64\x2D\x=
76\x61\x6C\x75\x65&quot;, 15);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    expected-&gt;tlv.ssl_client =3D HAPROXY_PROTOCOL_V2_CLIENT_S=
SL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt=
;tlv.ssl_verify =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    expected-&gt;tlv.ssl_version =3D &quot;TLS1.3&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.ssl_cn =3D &qu=
ot;client&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 expected-&gt;tlv.ssl_cipher =3D &quot;AES256&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.ssl_sig_alg =3D &quo=
t;SHA256&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
expected-&gt;tlv.ssl_key_alg =3D &quot;RSA2048&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.netns =3D &quot;netn=
s-1&quot;;</span><br><span>     haproxy_protocol_parse(actual, HP2_TEST_PRO=
XY_TCP4, sizeof(HP2_TEST_PROXY_TCP4));</span><br><span>     assert_true(com=
pare_hpi(state, actual, expected));</span><br><span> </span><br><span>@@ -3=
34,6 +385,18 @@</span><br><span>     expected-&gt;dst.addr.in6.sin6_family =
=3D AF_INET6;</span><br><span>     expected-&gt;dst.addr.in6.sin6_port =3D =
ntohs(1195);</span><br><span>     inet_pton(AF_INET6, &quot;2001:db8:20::1&=
quot;, &amp;expected-&gt;dst.addr.in6.sin6_addr);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.alpn =3D &quot;h23&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;t=
lv.authority =3D &quot;example.com&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expected-&gt;tlv.unique_id_len =3D 15;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(expected-&gt;tlv.un=
ique_id, &quot;\x75\x6E\x69\x71\x75\x65\x2D\x69\x64\x2D\x76\x61\x6C\x75\x65=
&quot;, 15);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ected-&gt;tlv.ssl_client =3D HAPROXY_PROTOCOL_V2_CLIENT_SSL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.ssl_verify =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-=
&gt;tlv.ssl_version =3D &quot;TLS1.3&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expected-&gt;tlv.ssl_cn =3D &quot;client&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tl=
v.ssl_cipher =3D &quot;AES256&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    expected-&gt;tlv.ssl_sig_alg =3D &quot;SHA256&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;tlv.=
ssl_key_alg =3D &quot;RSA2048&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    expected-&gt;tlv.netns =3D &quot;netns-1&quot;;</span>=
<br><span>     haproxy_protocol_parse(actual, HP2_TEST_PROXY_TCP6, sizeof(H=
P2_TEST_PROXY_TCP6));</span><br><span>     assert_true(compare_hpi(state, a=
ctual, expected));</span><br><span> </span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Dema=
il">change 686</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia593f72f6baa6e16d2fd9b21b38=
3b709682f9499 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 686 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--AKkH6jFfxRE=--

