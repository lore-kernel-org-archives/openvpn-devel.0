Date: Wed, 22 Feb 2017 22:14:04 +0100 (CET)
Message-Id: <201702222114.v1MLE4O5050723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
References: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
	access to the internal of X509_STORE
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit f05665df4150c6a345eec5432a02fd799bea0f2c (master)
commit 24bca7bee2ee5c48880a197ce9727bbc5a0149e5 (release/2.4)
Author: Emmanuel Deloget
Date:   Fri Feb 17 23:00:41 2017 +0100

     OpenSSL: don't use direct access to the internal of X509_STORE

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14076.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


