Message-ID: <951b0ff7-9fb7-405b-bf6e-ef4ebf12afaf@...68...>
Date: Sat, 15 Feb 2025 19:58:27 +0100
MIME-Version: 1.0
Content-Language: de-CH
From: corubba <corubba@...68...>
Subject: [Openvpn-devel] [PATCH 0/2] x509-username-fields improvements
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

This patchset contains two small improvements for the
x509-username-fields option. The first patch removes the long-deprecated
and only for backwards-compatibility kept uppercasing of the fieldnames.
The second patch documents a long available but until now undocumented
way to specify fields by their oids.

I ran into several issue with the uppercasing, and while coming up with
a bugfix, I figured its easier to instead just finally remove it.


Corubba Smith (2):
  Remove x509-username-fields uppercasing
  Document x509-username-fields oid usage

 Changes.rst                      |  5 +++++
 doc/man-sections/tls-options.rst | 12 ++++--------
 src/openvpn/options.c            | 27 +--------------------------
 3 files changed, 10 insertions(+), 34 deletions(-)

--
2.48.1

