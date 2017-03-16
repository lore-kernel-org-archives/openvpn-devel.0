Date: Thu, 16 Mar 2017 11:05:30 +0100 (CET)
Message-Id: <201703161005.v2GA5UJu099403@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1489655537-19164-1-git-send-email-steffan@...1856...>
References: <1489655537-19164-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix non-C99-compliant builds:
	don't use const size_t as array length
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks ("stared at code, ran my test suite").

Your patch has been applied to the master and release/2.4 branch.

Hopefully this should build with MSVC now :-)

commit db1b4d96bfe7e744a0dec8f86cb041c32fb87964 (master)
commit ce40258ddd0170df60633baab2c3d17f2c104671 (release/2.4)
Author: Steffan Karger
Date:   Thu Mar 16 10:12:17 2017 +0100

     Fix non-C99-compliant builds: don't use const size_t as array length

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1489655537-19164-1-git-send-email-steffan@...1856...>
     URL: http://www.mail-archive.com/search?l=mid&q=1489655537-19164-1-git-send-email-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


