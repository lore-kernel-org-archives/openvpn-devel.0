Date: Fri, 5 Jan 2024 15:46:08 +0100 (CET)
Message-Id: <202401051446.405Ek8FO036056@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240105140540.14757-1-gert@...1296...>
References: <20240105140540.14757-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make it more explicit and
 visible when pkg-config is not found
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

This should be really helping clearing up user confusion, which our
current messages don't do ("but I do have all the libraries, why is
it still failing?").  Thanks, Antonio, for testing and ACKing.

I have not explicitly tested anything, just pushed to GHA and buildbot,
to be sure it's not accidently breaking some oddball plattform.

Your patch has been applied to the master and release/2.6 branch.

commit c0f38019b4a2044c1fe873d7d33c13ce571d3386 (master)
commit d602fc03e9719681fd3c9f45922fbca9470e3afa (release/2.6)
Author: Arne Schwabe
Date:   Fri Jan 5 15:05:40 2024 +0100

     Make it more explicit and visible when pkg-config is not found

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20240105140540.14757-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27939.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


