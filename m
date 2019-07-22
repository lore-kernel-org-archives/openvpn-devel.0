Date: Mon, 22 Jul 2019 20:54:14 +0200 (CEST)
Message-Id: <201907221854.x6MIsEvG010586@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190218153129.3818-1-bengen@...2496...>
References: <20190218153129.3818-1-bengen@...2496...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not set pkcs11-helper 'safe
 fork mode'
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
To: Hilko Bengen <bengen@...2496...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch (bugfix).

Taking Steffan's comments on the list and AlonBL's comments in trac as
ACK.  David had issues on CentOS, but this might have been a problematic
version of pkcs11-helper - which should be tested, though.

I have not really tested this as I have no pkcs11 test environment today
(but since Steffan has, and this has been part of OpenVPN-NL for a while
now, I assume it is good).

commit 59e45a8bbc9084329c683730325bc5b676058e71 (master)
commit 59e45a8bbc9084329c683730325bc5b676058e71 (release/2.4)
Author: Hilko Bengen
Date:   Mon Feb 18 16:31:28 2019 +0100

     Do not set pkcs11-helper 'safe fork mode'

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20190218153129.3818-1-bengen@...2496...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18218.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


