From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 08:20:55 +0000
References: <gerrit.1721982049000.Ia593f72f6baa6e16d2fd9b21b383b709682f9499@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4b41e7fbc7214bc2edc607fad91eb430d960a29f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NSQ2oIYjFYM="; charset=UTF-8
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

--NSQ2oIYjFYM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail

to review the following change.


Change subject: Add support for TLV parsing in the PROXY protocol
......................................................................

Add support for TLV parsing in the PROXY protocol

Version 2 of the PROXY protocol appends extra data in Type-Length-Value
vector format at the end of the header. This commit parses and processes
or stores the additional information extracted from TLVs.

Change-Id: Ia593f72f6baa6e16d2fd9b21b383b709682f9499
Signed-off-by: Ralf Lici <ralflici95@...277...>
---
M src/openvpn/proxy_protocol.c
M src/openvpn/proxy_protocol.h
2 files changed, 372 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/686/1

diff --git a/src/openvpn/proxy_protocol.c b/src/openvpn/proxy_protocol.c
index 10a68c2..7f72313 100644
--- a/src/openvpn/proxy_protocol.c
+++ b/src/openvpn/proxy_protocol.c
@@ -38,6 +38,74 @@
     PROXY_PROTOCOL_PARSING_STATE_IGNORE =3D 1,
 } proxy_protocol_parsing_state_t;

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
 static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;
 static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;
 static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;
@@ -88,6 +156,17 @@
     }
 }

+uint32_t
+proxy_protocol_crc32c(const uint8_t *data, int len)
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
@@ -316,6 +395,231 @@
 }

 /*
+ * Parse a string based TLV and store the value in 'out'.
+ *
+ * @param ppi - The proxy protocol info structure used for memory allocati=
on.
+ * @param out - The output variable to store the parsed value.
+ * @param type_str - A string representation of the TLV type (for logging).
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+proxy_protocol_parse_string_tlv(struct proxy_protocol_info *ppi, char **ou=
t, char *type_str, const uint16_t len, const uint8_t *value)
+{
+    if (len =3D=3D 0)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: %s TLV empty", type_str);
+        return;
+    }
+
+    *out =3D (char *)gc_malloc(8, false, &ppi->gc);
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
+ * If there's a mismatch the parsing state is set to invalid so that the h=
eader
+ * is dropped.
+ *
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ *
+ * @return - true if the CRC32C value matches the calculated CRC32C.
+ */
+bool
+proxy_protocol_parse_crc32c_tlv(const uint16_t len, const uint8_t *value)
+{
+    if (len !=3D 4)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: CRC32C TLV invalid length");
+        parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;
+        return false;
+    }
+
+    uint32_t expected_crc32c =3D ntohl(*(uint32_t *)value);
+
+    /* fill with 0s the crc32 field to calculate the actual crc32 */
+    *(uint32_t *)value =3D 0;
+    uint32_t calculated_crc32c =3D proxy_protocol_crc32c((const uint8_t *)=
&header, header_len);
+
+    if (expected_crc32c !=3D calculated_crc32c)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: CRC32C mismatch, expected: 0x%=
08x calculated: 0x%08x. Dropping header", expected_crc32c, calculated_crc32=
c);
+        parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;
+        return false;
+    }
+    msg(M_DEBUG, "PROXY protocol v2: CRC32C match");
+    return true;
+}
+
+/*
+ * Parse the UNIQUE_ID TLV and store the value in ppi->unique_id
+ * (and ppi->unique_id_len).
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+proxy_protocol_parse_uid_tlv(struct proxy_protocol_info *ppi, const uint16=
_t len, const uint8_t *value)
+{
+    if (len =3D=3D 0)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: UNIQUE_ID TLV empty");
+        return;
+    }
+    else if (len > PROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: UNIQUE_ID TLV too long");
+        return;
+    }
+
+    ppi->unique_id_len =3D len;
+    memcpy(ppi->unique_id, value, len);
+    msg(M_DEBUG, "PROXY protocol v2: UNIQUE_ID: %.*s", (int)ppi->unique_id=
_len, ppi->unique_id);
+}
+
+/*
+ * Parse the SSL TLV and store the value in ppi->ssl_client and ppi->ssl_v=
erify.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+proxy_protocol_parse_ssl_tlv(struct proxy_protocol_info *ppi, const uint16=
_t len, const uint8_t *value)
+{
+    const struct proxy_protocol_tlv_ssl *ssl =3D (const struct proxy_proto=
col_tlv_ssl *)(value);
+
+    if (!ssl->client)
+    {
+        msg(M_NONFATAL, "PROXY protocol v2: SSL TLV invalid");
+        return;
+    }
+
+    if (ssl->client & PROXY_PROTOCOL_V2_CLIENT_SSL)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client connected over SSL/TLS");
+    }
+    if (ssl->client & PROXY_PROTOCOL_V2_CLIENT_CERT_CONN)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client provided a certificate ove=
r the current connection");
+    }
+    if (ssl->client & PROXY_PROTOCOL_V2_CLIENT_CERT_SESS)
+    {
+        msg(M_DEBUG, "PROXY protocol v2: client provided a certificate at =
least once over the TLS session this connection belongs to");
+    }
+
+    msg(M_DEBUG, "PROXY protocol v2: client certificate verification stat:=
 %s", ssl->verify ? "failure" : "success");
+    ppi->ssl_client =3D ssl->client;
+    ppi->ssl_verify =3D ssl->verify =3D=3D 0;
+}
+
+/*
+ * Parse a TLV and store the value in the proxy protocol info structure.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param type - The TLV type.
+ * @param len - The length of the TLV value.
+ * @param value - The TLV value.
+ */
+void
+proxy_protocol_parse_tlv(struct proxy_protocol_info *ppi, const uint8_t ty=
pe, const uint16_t len, const uint8_t *value)
+{
+    switch (type)
+    {
+        case PROXY_PROTOCOL_TLV_TYPE_ALPN:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->alpn, "ALPN", len, =
value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_AUTHORITY:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->authority, "AUTHORI=
TY", len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_CRC32C:
+            proxy_protocol_parse_crc32c_tlv(len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_NOOP:
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID:
+            proxy_protocol_parse_uid_tlv(ppi, len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_SSL:
+            proxy_protocol_parse_ssl_tlv(ppi, len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->ssl_version, "SSL_V=
ERSION", len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CN:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->ssl_cn, "SSL_CN", l=
en, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->ssl_cipher, "SSL_CI=
PHER", len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->ssl_sig_alg, "SSL_S=
IG_ALG", len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->ssl_key_alg, "SSL_K=
EY_ALG", len, value);
+            break;
+
+        case PROXY_PROTOCOL_TLV_TYPE_NETNS:
+            proxy_protocol_parse_string_tlv(ppi, &ppi->netns, "NETNS", len=
, value);
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
+ * Parse the TLVs in the PROXY protocol v2 header.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param buf - The buffer containing the TLVs.
+ * @param buf_len - The length of the buffer.
+ *
+ * @return - The number of bytes parsed or -1 if an error occurred.
+ */
+int
+proxy_protocol_parse_tlvs(struct proxy_protocol_info *ppi, const uint8_t *=
buf,
+                          const int buf_len)
+{
+    const uint8_t *end =3D buf + buf_len;
+    const uint8_t *start =3D buf;
+
+    ppi->gc =3D gc_new();
+    while (buf < end && parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE_=
OK)
+    {
+        const struct proxy_protocol_tlv *tlv =3D (const struct proxy_proto=
col_tlv *)buf;
+        uint16_t tlv_len =3D (tlv->length_hi << 8) | tlv->length_lo;
+        if (buf + sizeof(*tlv) + tlv_len > end)
+        {
+            msg(M_NONFATAL, "PROXY protocol v2: TLV length exceeds buffer =
size");
+            return -1;
+        }
+        proxy_protocol_parse_tlv(ppi, tlv->type, tlv_len, tlv->value);
+        buf +=3D sizeof(*tlv) + tlv_len;
+    }
+    return (int)(buf - start);
+}
+
+/*
  * Parse the PROXY protocol v2 header.
  *
  * @param ppi - The proxy protocol info structure to store the parsed data.
@@ -435,7 +739,7 @@
         {
             if ((header.v2.ver_cmd & PROXY_PROTOCOL_V2_VER_MASK) =3D=3D PR=
OXY_PROTOCOL_V2_VER)
             {
-                proxy_protocol_parse_v2(ppi);
+                int pos =3D proxy_protocol_parse_v2(ppi);
                 if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE_IGNO=
RE)
                 {
                     msg(M_DEBUG, "PROXY protocol v2: ignoring header");
@@ -445,6 +749,21 @@
                 {
                     return false;
                 }
+
+                if (pos < header_len) /* there's extra TLV data to parse */
+                {
+                    pos +=3D proxy_protocol_parse_tlvs(ppi, (uint8_t *)(&h=
eader) + pos,
+                                                     header_len - pos);
+                    if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE_=
INVALID)
+                    {
+                        return false;
+                    }
+                    if (pos < header_len)
+                    {
+                        msg(M_NONFATAL, "PROXY protocol v2: could not corr=
eclty parse TLV data");
+                    }
+                }
+
                 msg(M_DEBUG, "PROXY protocol v2: header parsed");
                 return true;
             }
diff --git a/src/openvpn/proxy_protocol.h b/src/openvpn/proxy_protocol.h
index 8e9af03..a492f85 100644
--- a/src/openvpn/proxy_protocol.h
+++ b/src/openvpn/proxy_protocol.h
@@ -60,6 +60,25 @@
 #define PROXY_PROTOCOL_V2_TP_STREAM (0x1 << 0)
 #define PROXY_PROTOCOL_V2_TP_DGRAM  (0x2 << 0)

+#define PROXY_PROTOCOL_TLV_TYPE_ALPN            0x01
+#define PROXY_PROTOCOL_TLV_TYPE_AUTHORITY       0x02
+#define PROXY_PROTOCOL_TLV_TYPE_CRC32C          0x03
+#define PROXY_PROTOCOL_TLV_TYPE_NOOP            0x04
+#define PROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID       0x05
+#define PROXY_PROTOCOL_TLV_TYPE_SSL             0x20
+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION  0x21
+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CN       0x22
+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER   0x23
+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG  0x24
+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG  0x25
+#define PROXY_PROTOCOL_TLV_TYPE_NETNS           0x30
+
+#define PROXY_PROTOCOL_V2_CLIENT_SSL          0x01
+#define PROXY_PROTOCOL_V2_CLIENT_CERT_CONN    0x02
+#define PROXY_PROTOCOL_V2_CLIENT_CERT_SESS    0x04
+
+#define PROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN 128
+
 typedef enum
 {
     PROXY_PROTOCOL_VERSION_INVALID =3D -1,
@@ -69,6 +88,22 @@
     PROXY_PROTOCOL_VERSION_2,
 } proxy_protocol_version_t;

+struct proxy_protocol_tlv
+{
+    uint8_t type;
+    uint8_t length_hi;
+    uint8_t length_lo;
+    uint8_t value[0];
+};
+
+#pragma pack(push, 1)
+struct proxy_protocol_tlv_ssl
+{
+    uint8_t client;
+    uint32_t verify;
+} __attribute__((packed));
+#pragma pack(pop)
+
 /* HAProxy PROXY protocol header */
 typedef union
 {
@@ -115,6 +150,23 @@
     int sock_type;
     struct openvpn_sockaddr src;
     struct openvpn_sockaddr dst;
+
+    /* data extracted from TLVs */
+    char *alpn;
+    char *authority;
+
+    uint8_t unique_id[PROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN + 1];
+    uint16_t unique_id_len;
+
+    uint8_t ssl_client;
+    uint32_t ssl_verify;
+    char *ssl_version;
+    char *ssl_cn;
+    char *ssl_cipher;
+    char *ssl_sig_alg;
+    char *ssl_key_alg;
+
+    char *netns;
 };
=20
 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia593f72f6baa6e16d2fd9b21b383b709682f9499
Gerrit-Change-Number: 686
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--NSQ2oIYjFYM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add support for TLV parsing in the PROXY protocol<br><br>Vers=
ion 2 of the PROXY protocol appends extra data in Type-Length-Value<br>vect=
or format at the end of the header. This commit parses and processes<br>or =
stores the additional information extracted from TLVs.<br><br>Change-Id: Ia=
593f72f6baa6e16d2fd9b21b383b709682f9499<br>Signed-off-by: Ralf Lici &lt;ral=
flici95@...277...&gt;<br>---<br>M src/openvpn/proxy_protocol.c<br>M src/ope=
nvpn/proxy_protocol.h<br>2 files changed, 372 insertions(+), 1 deletion(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/6=
86/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/proxy_protocol.c b/src/openvpn/proxy_=
protocol.c</span><br><span>index 10a68c2..7f72313 100644</span><br><span>--=
- a/src/openvpn/proxy_protocol.c</span><br><span>+++ b/src/openvpn/proxy_pr=
otocol.c</span><br><span>@@ -38,6 +38,74 @@</span><br><span>     PROXY_PROT=
OCOL_PARSING_STATE_IGNORE =3D 1,</span><br><span> } proxy_protocol_parsing_=
state_t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static const uint32_t CRC32C_TABLE[256] =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0xC79A971FL, 0x35F1141=
CL, 0x26A1E7E8L, 0xD4CA64EBL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x4D43CFD0L, 0xBF284CD3L,=
 0xAC78BF27L, 0x5E133C24L,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0x105EC76FL, 0xE235446CL, 0xF165B798L, 0x030E349BL,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0xD7C45070L, 0x25AFD373L, 0x=
36FF2087L, 0xC494A384L,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x9A879FA0L, 0x68EC1CA3L, 0x7BBCEF57L, 0x89D76C54L,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0x5D1D08BFL, 0xAF768BBCL, 0xBC2=
67848L, 0x4E4DFB4BL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x20BD8EDEL, 0xD2D60DDDL, 0xC186FE29L, 0x33ED7D2AL,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0xE72719C1L, 0x154C9AC2L, 0x061C69=
36L, 0xF477EA35L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0xAA64D611L, 0x580F5512L, 0x4B5FA6E6L, 0xB93425E5L,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x6DFE410EL, 0x9F95C20DL, 0x8CC531F9L=
, 0x7EAEB2FAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x30E349B1L, 0xC288CAB2L, 0xD1D83946L, 0x23B3BA45L,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0xF779DEAEL, 0x05125DADL, 0x1642AE59L, 0=
xE4292D5AL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xBA=
3A117EL, 0x4851927DL, 0x5B016189L, 0xA96AE28AL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0x7DA08661L, 0x8FCB0562L, 0x9C9BF696L, 0x6E=
F07595L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x417B1=
DBCL, 0xB3109EBFL, 0xA0406D4BL, 0x522BEE48L,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    0x86E18AA3L, 0x748A09A0L, 0x67DAFA54L, 0x95B17=
957L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xCBA24573=
L, 0x39C9C670L, 0x2A993584L, 0xD8F2B687L,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0x0C38D26CL, 0xFE53516FL, 0xED03A29BL, 0x1F682198=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x5125DAD3L, =
0xA34E59D0L, 0xB01EAA24L, 0x42752927L,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x96BF4DCCL, 0x64D4CECFL, 0x77843D3BL, 0x85EFBE38L,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xDBFC821CL, 0x2=
997011FL, 0x3AC7F2EBL, 0xC8AC71E8L,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0x1C661503L, 0xEE0D9600L, 0xFD5D65F4L, 0x0F36E6F7L,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x61C69362L, 0x93AD=
1061L, 0x80FDE395L, 0x72966096L,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    0xA65C047DL, 0x5437877EL, 0x4767748AL, 0xB50CF789L,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0xEB1FCBADL, 0x197448A=
EL, 0x0A24BB5AL, 0xF84F3859L,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0x2C855CB2L, 0xDEEEDFB1L, 0xCDBE2C45L, 0x3FD5AF46L,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x7198540DL, 0x83F3D70EL,=
 0x90A324FAL, 0x62C8A7F9L,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0xB602C312L, 0x44694011L, 0x5739B3E5L, 0xA55230E6L,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0xFB410CC2L, 0x092A8FC1L, 0x=
1A7A7C35L, 0xE811FF36L,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0x3CDB9BDDL, 0xCEB018DEL, 0xDDE0EB2AL, 0x2F8B6829L,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0x82F63B78L, 0x709DB87BL, 0x63C=
D4B8FL, 0x91A6C88CL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x456CAC67L, 0xB7072F64L, 0xA457DC90L, 0x563C5F93L,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0x082F63B7L, 0xFA44E0B4L, 0xE91413=
40L, 0x1B7F9043L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0xCFB5F4A8L, 0x3DDE77ABL, 0x2E8E845FL, 0xDCE5075CL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x92A8FC17L, 0x60C37F14L, 0x73938CE0L=
, 0x81F80FE3L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x55326B08L, 0xA759E80BL, 0xB4091BFFL, 0x466298FCL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0x1871A4D8L, 0xEA1A27DBL, 0xF94AD42FL, 0=
x0B21572CL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xDF=
EB33C7L, 0x2D80B0C4L, 0x3ED04330L, 0xCCBBC033L,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    0xA24BB5A6L, 0x502036A5L, 0x4370C551L, 0xB1=
1B4652L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x65D12=
2B9L, 0x97BAA1BAL, 0x84EA524EL, 0x7681D14DL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    0x2892ED69L, 0xDAF96E6AL, 0xC9A99D9EL, 0x3BC21=
E9DL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xEF087A76=
L, 0x1D63F975L, 0x0E330A81L, 0xFC588982L,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    0xB21572C9L, 0x407EF1CAL, 0x532E023EL, 0xA145813D=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x758FE5D6L, =
0x87E466D5L, 0x94B49521L, 0x66DF1622L,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    0x38CC2A06L, 0xCAA7A905L, 0xD9F75AF1L, 0x2B9CD9F2L,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0xFF56BD19L, 0x0=
D3D3E1AL, 0x1E6DCDEEL, 0xEC064EEDL,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    0xC38D26C4L, 0x31E6A5C7L, 0x22B65633L, 0xD0DDD530L,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x0417B1DBL, 0xF67C=
32D8L, 0xE52CC12CL, 0x1747422FL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    0x49547E0BL, 0xBB3FFD08L, 0xA86F0EFCL, 0x5A048DFFL,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x8ECEE914L, 0x7CA56A1=
7L, 0x6FF599E3L, 0x9D9E1AE0L,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    0xD3D3E1ABL, 0x21B862A8L, 0x32E8915CL, 0xC083125FL,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x144976B4L, 0xE622F5B7L,=
 0xF5720643L, 0x07198540L,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0x590AB964L, 0xAB613A67L, 0xB831C993L, 0x4A5A4A90L,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    0x9E902E7BL, 0x6CFBAD78L, 0x=
7FAB5E8CL, 0x8DC0DD8FL,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    0xE330A81AL, 0x115B2B19L, 0x020BD8EDL, 0xF0605BEEL,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0x24AA3F05L, 0xD6C1BC06L, 0xC59=
14FF2L, 0x37FACCF1L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x69E9F0D5L, 0x9B8273D6L, 0x88D28022L, 0x7AB90321L,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    0xAE7367CAL, 0x5C18E4C9L, 0x4F4817=
3DL, 0xBD23943EL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  0xF36E6F75L, 0x0105EC76L, 0x12551F82L, 0xE03E9C81L,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x34F4F86AL, 0xC69F7B69L, 0xD5CF889DL=
, 0x27A40B9EL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0=
x79B737BAL, 0x8BDCB4B9L, 0x988C474DL, 0x6AE7C44EL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    0xBE2DA0A5L, 0x4C4623A6L, 0x5F16D052L, 0=
xAD7D5351L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static c=
onst size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;</span><br><span> static=
 const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;</span><br><span> stat=
ic const size_t PROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;</span><br><span>@@=
 -88,6 +156,17 @@</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protocol_crc32c(const =
uint8_t *data, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t c=
rc =3D 0xFFFFFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while (len-- &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cr=
c =3D (crc &gt;&gt; 8) ^ CRC32C_TABLE[(crc ^ (*data++)) &amp; 0xFF];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return (crc ^ 0xFFFFFFFF);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Parse =
a port number from a string.</span><br><span>  *</span><br><span>@@ -316,6 =
+395,231 @@</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse a string based TL=
V and store the value in &#39;out&#39;.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param ppi - The proxy protocol info structure used for memory alloca=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param out =
- The output variable to store the parsed value.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param type_str - A string representation o=
f the TLV type (for logging).</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param len - The length of the TLV value.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param value - The TLV value.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+proxy_protocol_parse_string_tlv(struct proxy_protocol_in=
fo *ppi, char **out, char *type_str, const uint16_t len, const uint8_t *val=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v=
2: %s TLV empty&quot;, type_str);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    *out =3D (char *)gc=
_malloc(8, false, &amp;ppi-&gt;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    memcpy(*out, value, len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    (*out)[len] =3D &#39;\0&#39;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (type_str)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_DEBUG, &quot;PROXY protocol v2: %s TLV: %s&quot;, type_s=
tr, *out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Parse the CRC32C TLV and check if it matches the calculated CRC32C.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * If there&#39;s a mismat=
ch the parsing state is set to invalid so that the header</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * is dropped.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param len - The length of the TLV value.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param value - The TLV value.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return - true if the CRC32C value=
 matches the calculated CRC32C.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protocol_pars=
e_crc32c_tlv(const uint16_t len, const uint8_t *value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (len !=3D 4)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_NONFATAL, &quot;PROXY protocol v2: CRC32C TLV invalid leng=
th&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
arsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint32_t expected_crc32c =3D ntohl(*(uint32_t *)value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* fill with 0s the crc32 field to calculate t=
he actual crc32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   *(uint32_t *)value =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint32_t calculated_crc32c =3D proxy_protocol_crc32c((const ui=
nt8_t *)&amp;header, header_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (expected_crc32c !=3D calculated_crc32c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: CRC32C mismatch, =
expected: 0x%08x calculated: 0x%08x. Dropping header&quot;, expected_crc32c=
, calculated_crc32c);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_DEBUG, &quot;PROXY protocol v2:=
 CRC32C match&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Parse the UNIQUE_ID TLV and store the value in ppi-&=
gt;unique_id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (and=
 ppi-&gt;unique_id_len).</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pp=
i - The proxy protocol info structure to store the parsed data.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param len - The length of t=
he TLV value.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram value - The TLV value.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protocol_parse_uid=
_tlv(struct proxy_protocol_info *ppi, const uint16_t len, const uint8_t *va=
lue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol =
v2: UNIQUE_ID TLV empty&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (len &gt; PROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;PROXY protocol v2: UNI=
QUE_ID TLV too long&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ppi-&gt;unique_id_len =3D=
 len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(ppi=
-&gt;unique_id, value, len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(M_DEBUG, &quot;PROXY protocol v2: UNIQUE_ID: %.*s&quot;, (=
int)ppi-&gt;unique_id_len, ppi-&gt;unique_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the SSL TLV and st=
ore the value in ppi-&gt;ssl_client and ppi-&gt;ssl_verify.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param ppi - The proxy protocol info structure to=
 store the parsed data.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param len - The length of the TLV value.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param value - The TLV value.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+proxy_protocol_parse_ssl_tlv(struct proxy_protocol_info *ppi, co=
nst uint16_t len, const uint8_t *value)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct proxy_protocol_tlv_ssl *ssl =3D (const struct proxy_prot=
ocol_tlv_ssl *)(value);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ssl-&g=
t;client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, =
&quot;PROXY protocol v2: SSL TLV invalid&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ssl-&gt;client &amp; PROXY_PROTOCOL_V2_CLIENT_SSL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol v2: client conne=
cted over SSL/TLS&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ssl-&gt;client &amp; PROXY_PROTOCOL_V2_CLIENT_CERT_CONN)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol v2: client=
 provided a certificate over the current connection&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (ssl-&gt;client &amp; PROXY_PROTOCOL_V2_CL=
IENT_CERT_SESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBU=
G, &quot;PROXY protocol v2: client provided a certificate at least once ove=
r the TLS session this connection belongs to&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(M_DEBUG, &quot;PROXY protocol v2: client certificate verification =
stat: %s&quot;, ssl-&gt;verify ? &quot;failure&quot; : &quot;success&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ppi-&gt;ssl_cl=
ient =3D ssl-&gt;client;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ppi-&gt;ssl_verify =3D ssl-&gt;verify =3D=3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse a TLV an=
d store the value in the proxy protocol info structure.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param ppi - The proxy protocol info structure to sto=
re the parsed data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param type - The TLV type.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param len - The length of the TLV value.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param value - The TLV value.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+proxy_protocol_parse_tlv(struct proxy_protocol_info *ppi=
, const uint8_t type, const uint16_t len, const uint8_t *value)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    switch (type)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case PROXY_PROTOCOL_TLV_TYPE_ALPN:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            proxy_protocol_parse_string_t=
lv(ppi, &amp;ppi-&gt;alpn, &quot;ALPN&quot;, len, value);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        case PROXY_PROTOCOL_TLV_TYPE_AUTHORITY:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            proxy_protocol_pa=
rse_string_tlv(ppi, &amp;ppi-&gt;authority, &quot;AUTHORITY&quot;, len, val=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_TLV_TYP=
E_CRC32C:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  proxy_protocol_parse_crc32c_tlv(len, value);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case PROXY_PROTOCOL_TLV_TYPE_NOOP:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case PROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            proxy_protocol_parse_uid_=
tlv(ppi, len, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY=
_PROTOCOL_TLV_TYPE_SSL:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            proxy_protocol_parse_ssl_tlv(ppi, len, value);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            proxy_p=
rotocol_parse_string_tlv(ppi, &amp;ppi-&gt;ssl_version, &quot;SSL_VERSION&q=
uot;, len, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PR=
OTOCOL_TLV_SUBTYPE_SSL_CN:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            proxy_protocol_parse_string_tlv(ppi, &amp;ppi-&gt;ssl_cn=
, &quot;SSL_CN&quot;, len, value);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            proxy_protocol_parse_string_tlv(ppi,=
 &amp;ppi-&gt;ssl_cipher, &quot;SSL_CIPHER&quot;, len, value);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            proxy_p=
rotocol_parse_string_tlv(ppi, &amp;ppi-&gt;ssl_sig_alg, &quot;SSL_SIG_ALG&q=
uot;, len, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PR=
OTOCOL_TLV_SUBTYPE_SSL_KEY_ALG:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            proxy_protocol_parse_string_tlv(ppi, &amp;ppi-&gt;s=
sl_key_alg, &quot;SSL_KEY_ALG&quot;, len, value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case PROXY_PROTOCOL_TLV_TYPE_NETNS:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            proxy_protocol_parse_string_t=
lv(ppi, &amp;ppi-&gt;netns, &quot;NETNS&quot;, len, value);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_NONFATAL, &quot;PROXY protocol v2: unkno=
wn TLV type 0x%02x&quot;, type);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Parse the TLVs in the PROXY protocol v2 header.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param ppi - The proxy protocol info s=
tructure to store the parsed data.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param buf - The buffer containing the TLVs.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param buf_len - The length o=
f the buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return - The number=
 of bytes parsed or -1 if an error occurred.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_p=
rotocol_parse_tlvs(struct proxy_protocol_info *ppi, const uint8_t *buf,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
   const int buf_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_=
t *end =3D buf + buf_len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const uint8_t *start =3D buf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ppi-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while (buf &lt; end &amp;&amp; parsing_state =3D=3D PROXY_PRO=
TOCOL_PARSING_STATE_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst struct proxy_protocol_tlv *tlv =3D (const struct proxy_protocol_tlv *)b=
uf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t=
 tlv_len =3D (tlv-&gt;length_hi &lt;&lt; 8) | tlv-&gt;length_lo;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (buf + sizeof(*tlv)=
 + tlv_len &gt; end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_NONFATAL, &quot;PROXY protocol v2: TLV length exceeds buffer size&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        proxy_proto=
col_parse_tlv(ppi, tlv-&gt;type, tlv_len, tlv-&gt;value);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf +=3D sizeof(*tlv) + tlv_l=
en;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (int)(buf - start);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span>  * Parse the PROXY protocol v2 heade=
r.</span><br><span>  *</span><br><span>  * @param ppi - The proxy protocol =
info structure to store the parsed data.</span><br><span>@@ -435,7 +739,7 @=
@</span><br><span>         {</span><br><span>             if ((header.v2.ve=
r_cmd &amp; PROXY_PROTOCOL_V2_VER_MASK) =3D=3D PROXY_PROTOCOL_V2_VER)</span=
><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                proxy_protocol_parse_v2(ppi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                int pos =3D proxy_protocol_pa=
rse_v2(ppi);</span><br><span>                 if (parsing_state =3D=3D PROX=
Y_PROTOCOL_PARSING_STATE_IGNORE)</span><br><span>                 {</span><=
br><span>                     msg(M_DEBUG, &quot;PROXY protocol v2: ignorin=
g header&quot;);</span><br><span>@@ -445,6 +749,21 @@</span><br><span>     =
            {</span><br><span>                     return false;</span><br>=
<span>                 }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (pos &lt; header_len) /* there&#39;s extra TLV data to parse */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    pos +=3D=
 proxy_protocol_parse_tlvs(ppi, (uint8_t *)(&amp;header) + pos,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                      header_len - pos);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    if (parsing_state =3D=3D PROXY_PRO=
TOCOL_PARSING_STATE_INVALID)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    if (pos &lt; header_len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       msg(M_NONFATAL, &quot;PROXY protocol v2: could not correclty parse T=
LV data&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>                 msg(M_DEBUG, &quot;PROXY protocol v2: header =
parsed&quot;);</span><br><span>                 return true;</span><br><spa=
n>             }</span><br><span>diff --git a/src/openvpn/proxy_protocol.h =
b/src/openvpn/proxy_protocol.h</span><br><span>index 8e9af03..a492f85 10064=
4</span><br><span>--- a/src/openvpn/proxy_protocol.h</span><br><span>+++ b/=
src/openvpn/proxy_protocol.h</span><br><span>@@ -60,6 +60,25 @@</span><br><=
span> #define PROXY_PROTOCOL_V2_TP_STREAM (0x1 &lt;&lt; 0)</span><br><span>=
 #define PROXY_PROTOCOL_V2_TP_DGRAM  (0x2 &lt;&lt; 0)</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_=
TLV_TYPE_ALPN            0x01</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define PROXY_PROTOCOL_TLV_TYPE_AUTHORITY       0x02</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_TLV_TYPE_=
CRC32C          0x03</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define PROXY_PROTOCOL_TLV_TYPE_NOOP            0x04</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID=
       0x05</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
PROXY_PROTOCOL_TLV_TYPE_SSL             0x20</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION  0x=
21</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PRO=
TOCOL_TLV_SUBTYPE_SSL_CN       0x22</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER   0x23</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_TLV=
_SUBTYPE_SSL_SIG_ALG  0x24</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define PROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG  0x25</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_TLV_TYPE_NET=
NS           0x30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCO=
L_V2_CLIENT_SSL          0x01</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define PROXY_PROTOCOL_V2_CLIENT_CERT_CONN    0x02</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_CLIENT_C=
ERT_SESS    0x04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL=
_V2_TLV_UNIQUE_ID_MAX_LEN 128</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> typedef enum</span><br><span> {</span><br><span=
>     PROXY_PROTOCOL_VERSION_INVALID =3D -1,</span><br><span>@@ -69,6 +88,2=
2 @@</span><br><span>     PROXY_PROTOCOL_VERSION_2,</span><br><span> } prox=
y_protocol_version_t;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct proxy_protocol_tlv</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint8_t type;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint8_t length_hi;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint8_t length_lo;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t value[0];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma pack(push, 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct proxy_protoco=
l_tlv_ssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t client;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t verify;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+} __attribute__((packed));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma pack(pop)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* H=
AProxy PROXY protocol header */</span><br><span> typedef union</span><br><s=
pan> {</span><br><span>@@ -115,6 +150,23 @@</span><br><span>     int sock_t=
ype;</span><br><span>     struct openvpn_sockaddr src;</span><br><span>    =
 struct openvpn_sockaddr dst;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* da=
ta extracted from TLVs */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *alpn;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *authority;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t uniq=
ue_id[PROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t unique_id_len;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t ssl_client;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t ssl_verify;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *ssl_version;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *ssl_cn;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *ssl_cipher;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *ssl_sig_alg;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *ssl_key_alg;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *netns;</span><br><span> };</span><br><spa=
n> </span><br><span> /*</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail">change 68=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/686?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia593f72f6baa6e16d2fd9b21b38=
3b709682f9499 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 686 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--NSQ2oIYjFYM=--

