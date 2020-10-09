Date: Fri, 9 Oct 2020 20:55:12 +0200 (CEST)
Message-Id: <202010091855.099ItC03074725@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201009144755.39719-1-steffan@...1856...>
References: <20201009144755.39719-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify key material exporter
 backend API
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

I have stared at the code a bit ("amazingly straightforward, no crypto
convolutions at all :-)") and tortured the result a bit on the server 
and client test bed.  No complaints.

(I have excercised the "key-derivation tls-ekm" path, but not the 
generic EKM path - no test case for that one yet... need to add one,
it seems)

Your patch has been applied to the master branch.

commit f0734e499562175a6ebbefbfa12b730c976e2507
Author: Steffan Karger
Date:   Fri Oct 9 16:47:55 2020 +0200

     Simplify key material exporter backend API

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20201009144755.39719-1-steffan@...1856...>
     URL: https://www.mail-archive.com/search?l=mid&q=20201009144755.39719-1-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


