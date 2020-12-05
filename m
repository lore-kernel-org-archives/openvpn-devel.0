From: tincanteksup <tincanteksup@...277...>
Message-ID: <99e4c953-c5e0-bdf2-7268-c7987952aaed@...277...>
Date: Sat, 5 Dec 2020 22:55:17 +0000
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel]  Man sections: typo (No patch)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Sorry for lack of patch.

diff --git a/doc/man-sections/renegotiation.rst 
b/doc/man-sections/renegotiation.rst
index b817cfa8..c5484404 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -35,7 +35,7 @@ separate ephemeral encryption key which is rotated at 
regular intervals.
    pseudo-uniform-randomized between ``min`` and ``max``.

    With the default value of :code:`3600` this results in an effective per
-  session value in the range of :code:`3240`..:code:`3600` seconds for
+  session value in the range of :code:`3240` .. :code:`3600` seconds for
    servers, or just 3600 for clients.

    When using dual-factor authentication, note that this default value may

