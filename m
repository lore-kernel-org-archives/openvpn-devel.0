Message-ID: <eac80c73-e702-4d5c-b90a-fdaf4edd74f1@...68...>
Date: Sat, 15 Feb 2025 20:01:44 +0100
MIME-Version: 1.0
From: corubba <corubba@...68...>
References: <951b0ff7-9fb7-405b-bf6e-ef4ebf12afaf@...68...>
Content-Language: de-CH
In-Reply-To: <951b0ff7-9fb7-405b-bf6e-ef4ebf12afaf@...68...>
Subject: [Openvpn-devel] [PATCH 2/2] Document x509-username-fields oid usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

When built against OpenSSL, the parameters of the x509-username-fields
option are in extract_x509_field_ssl() fed through OBJ_txt2obj() [0]
which accepts "long names and short names [...] as well as numerical
forms." Because of this, you can for example use `x509-username-field
2.5.4.41` to make OpenVPN read the `name` field [1].

x509-username-fields is currently not implemented for mbed TLS, so that
can be ignored.

[0] https://docs.openssl.org/1.1.1/man3/OBJ_nid2obj/
[1] https://oidref.com/2.5.4.41

Signed-off-by: Corubba Smith <corubba@...68...>
---
 doc/man-sections/tls-options.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 7882e924..0638d095 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -744,11 +744,13 @@ If the option is inlined, ``algo`` is always :code:`S=
HA256`.
   ::

      x509-username-field emailAddress
+     x509-username-field 1.2.840.113549.1.9.1
      x509-username-field ext:subjectAltName
      x509-username-field CN serialNumber

-  The first example uses the value of the :code:`emailAddress` attribute
-  in the certificate's Subject field as the username. The second example
+  The first two examples use the value of the :code:`emailAddress` attribu=
te
+  in the certificate's Subject field as the username, where the first exam=
ple
+  uses the name while the second example uses the oid. The third example
   uses the :code:`ext:` prefix to signify that the X.509 extension
   ``fieldname`` :code:`subjectAltName` be searched for an rfc822Name
   (email) field to be used as the username. In cases where there are
--
2.48.1


