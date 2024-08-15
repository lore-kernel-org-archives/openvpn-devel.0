Date: Thu, 15 Aug 2024 14:30:33 +0200 (CEST)
Message-Id: <202408151230.47FCUXIG080183@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240214132719.3031492-1-frank@...2641...>
References: <20240214132719.3031492-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement support for AEAD tag
 at the end
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

After some discussion it was decided to keep the "two independent options",
partially because "these two patches have been out there for a while,
been stared-at, and tested quite a bit" - also, IV_PROTO_V4 might end
up with a different combination, we'll see.  507 will ensure that for
IV_PROTO_V3 the two new options (AEAD at the end and 64 bit counters)
will only ever be used together, or not at all - reduce the amount of
protocol versions to implement in all datapaths, and combinations to
test.

I have tested this against older code (t_client -> 2.6 etc, and
t_server <- 2.2...2.6) and nothing broke.  Also, tested against itself,
and that worked as well.  Of course it does not actually *do* anything
yet, as the logic to push "aead-tag-end" does not exist...

(FTR, in case one of you is wondering - this is v3, and gerrit has "v8"
of the patch - but it's the same code change, just being pushed again
as part of "other pushes" after being rebased)

Your patch has been applied to the master branch.

commit 233e10aeec7de02d34fa5c517b44612d38ccc00f
Author: Arne Schwabe
Date:   Wed Feb 14 14:27:19 2024 +0100

     Implement support for AEAD tag at the end

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240214132719.3031492-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28239.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


