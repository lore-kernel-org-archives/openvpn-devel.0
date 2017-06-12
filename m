Date: Mon, 12 Jun 2017 19:51:06 +0200 (CEST)
Message-Id: <201706121751.v5CHp62u062010@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494859483-16466-1-git-send-email-steffan.karger@...1435...>
References: <1494859483-16466-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Skip tls-crypt unit tests if
 required crypto mode not supported
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

ACK.  The patch looks generally reasonable ("if there is no such cipher,
do not try to use it but print a clear message") though I have not been
able to verify actual *failure* - tried on FreeBSD 9.3, which' openssl
claims "no AES-256-CTR", but still, "PASS: tls_crypt_testdriver"

Since this is *test* infrastructure not "core code", this is still
good enough to me.

Your patch has been applied to the master and release/2.4 branch.

commit 534c8f24bd8ceeaebb326f53363a4e40e970df1e (master)
commit 84372cb6a67d1c088b01ed253697199995a8ab85 (release/2.4)
Author: Steffan Karger
Date:   Mon May 15 16:44:43 2017 +0200

     Skip tls-crypt unit tests if required crypto mode not supported

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1494859483-16466-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14657.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


