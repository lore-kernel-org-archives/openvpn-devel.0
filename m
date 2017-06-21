Date: Wed, 21 Jun 2017 12:06:17 +0200 (CEST)
Message-Id: <201706211006.v5LA6HwR073890@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1497864520-12219-6-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-6-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix potential double-free in
 --x509-alt-username (CVE-2017-7521)
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit cb4e35ece4a5b70b10ef9013be3bff263d82f32b (master)
commit 040084067119dd5a9e15eb3bcfc0079debaa3777 (release/2.4)
commit 1dde0cd6e5e6a0f2f45ec9969b7ff1b6537514ad (release/2.3)
Author: Steffan Karger
Date:   Mon Jun 19 11:28:40 2017 +0200

     Fix potential double-free in --x509-alt-username (CVE-2017-7521)

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Guido Vranken <guidovranken@...277...>
     Message-Id: <1497864520-12219-6-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1497864520-12219-6-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


