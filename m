Date: Wed, 12 Feb 2025 19:02:18 +0100 (CET)
Message-Id: <202502121802.51CI2IS3014767@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250212161311.16888-1-gert@...1296...>
References: <20250212161311.16888-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement epoch key data format
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

Finally!

I think I've tested all there is in my repertoire (run this code against
itself and against earlier "non epoch" OpenVPN versions, both as client
and as server) - and managed to find a few nice explosions in v17+18 :-)

MaxF has done the crypto review, both on "is the OpenVPN protocol
documentation in the RFC-to-be cryptographically sound" and "does the
code confirm to the documentation" and +2'ed the last patch now... in
it goes!

Your patch has been applied to the master branch.

commit 9f4670fc718a8c16280d60c3e2d4ad29cffa04c4
Author: Arne Schwabe
Date:   Wed Feb 12 17:13:11 2025 +0100

     Implement epoch key data format

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250212161311.16888-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30845.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


