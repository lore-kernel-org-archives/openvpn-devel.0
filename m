From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:53 +0200
Message-ID: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/28] Refactor OpenSSL crypto functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi everyone,

This is the second series of patches for the master branch. 

This patch separates the OpenSSL crypto functions (those in crypto.c) into a separate OpenSSL backend. The API for this backend is defined in crypto_backend.h.

Note that I also migrated all functions within OpenVPN that use crypto primitives, for compatibility with other SSL backends. The exception here is the functions in ssl.c, since they will be migrated in the next series of patches.

Enjoy!

Regards,
Adriaan de Jong


