Message-ID: <d7c52354-8263-4423-8a4f-39bab3bd4d97@...68...>
Date: Sun, 8 Dec 2024 00:19:35 +0100
MIME-Version: 1.0
From: corubba <corubba@...68...>
References: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
Content-Language: de-CH
In-Reply-To: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix port-share journal doc
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

Filename and content descriptions were switched.

Signed-off-by: corubba <corubba@...68...>
---
 doc/man-sections/server-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 0632e314..3fe9862c 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -429,7 +429,7 @@ fast hardware. SSL/TLS authentication must be used in t=
his mode.

   ``dir`` specifies an optional directory where a temporary file with name
   N containing content C will be dynamically generated for each proxy
-  connection, where N is the source IP:port of the client connection and C
+  connection, where C is the source IP:port of the client connection and N
   is the source IP:port of the connection to the proxy receiver. This
   directory can be used as a dictionary by the proxy receiver to determine
   the origin of the connection. Each generated file will be automatically
--
2.47.1


