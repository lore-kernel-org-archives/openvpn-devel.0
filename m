Date: Tue, 4 Jul 2023 13:45:53 +0200 (CEST)
Message-Id: <202307041145.364BjrFO079201@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230703153925.48990-1-frank@...2641...>
References: <20230703153925.48990-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: Throw a clear error when
 config.h in top-level source directory
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

Sounds & looks reasonable.  Not that I could really verify this, or have
tested it, but that's what we have an ACK from Arne for :-)

Your patch has been applied to the master branch.

commit 0652ae84f4528daa57da344eee28b7385a6659a1
Author: Frank Lichtenheld
Date:   Mon Jul 3 17:39:25 2023 +0200

     CMake: Throw a clear error when config.h in top-level source directory

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230703153925.48990-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26809.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


