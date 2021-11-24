MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Nov 2021 12:03:37 +0200
Message-ID: <CAGyAFMUGzo9HUF9WyhYen04_K2f-29ME86oF+VBxqftoMp2Z5w@...278...>
Subject: [Openvpn-devel] Dropping vcpkg overlay triplets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

In our codebase we have vcpkg overlay triplets:

  openvpn\contrib\vcpkg-triplets
    arm64-windows-ovpn.cmake
    x64-windows-ovpn.cmake
    x86-windows-ovpn.cmake

They exist only to support static linking of lz4. All other libraries
(lzo, libss, libcrypto, libpkcs11-helper) are linked dynamically. The
reason for static linking in MSVC is to maintain compatibility with
the generic build system, which links lz4 statically.

Since we don't use the generic build system for building releases, we
could drop --enable-lz4 option support from it and link lz4 in MSVC
dynamically. This would allow us to simplify the MSVC build system,
get rid of custom triples and remove some code.

Thoughts?

-- 
-Lev

