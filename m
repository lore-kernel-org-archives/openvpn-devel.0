Date: Mon, 23 May 2022 15:46:11 +0200 (CEST)
Message-Id: <202205231346.24NDkBef045356@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220523103546.3425388-2-arne@...1227...>
References: <20220523103546.3425388-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Translate OpenSSL 3.0 digest
 names to OpenSSL 1.1 digest names
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Wording mangled as instructed, and tested for the case reported today
("ossl3 client with --auth sha256 talking to oss1.1 server, reporting
mismatch on sha2-256 <-> sha2").

--auth sha2-256 works as well (on the oss3 side), as expected.

Your patch has been applied to the master branch.

commit 88342ed8277c579704c0e67feb4278aeaa544027
Author: Arne Schwabe
Date:   Mon May 23 12:35:46 2022 +0200

     Translate OpenSSL 3.0 digest names to OpenSSL 1.1 digest names

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220523103546.3425388-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24423.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


