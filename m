Message-ID: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
Date: Wed, 7 Dec 2022 01:54:00 +0100
MIME-Version: 1.0
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@...2704...>
Subject: [Openvpn-devel]  [PATCH] support PKCS11 lib dependencies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Modify the Win32-PE search path to find dependencies
in shared object origin location.

Needs https://github.com/OpenSC/pkcs11-helper/pull/59 to work.

Would be nice if this could still be included for v2.6,
an additional pkcs11-helper patch may be added to preempt the PR.

