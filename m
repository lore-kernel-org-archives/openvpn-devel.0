Date: Wed, 27 Aug 2025 11:13:12 +0200 (CEST)
Message-Id: <202508270913.57R9DCrg098659@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826185007.22157-1-gert@...1296...>
References: <20250826185007.22157-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: comp: Make sure comp flags are
 treated as unsigned
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Stared a bit at the change - this is all values well within the range
of all integers involved (max value is 1<<7) so the impact *should* be
zero, and BB confirms that everything still works - minus a few integer
conversion warnings...

Your patch has been applied to the master branch.

commit 2f6467f7db8273e8094656e46a6ae60cbc1d0af9
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:50:00 2025 +0200

     comp: Make sure comp flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826185007.22157-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32689.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


