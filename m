Date: Sat, 20 Jan 2018 14:07:49 +0100 (CET)
Message-Id: <201801201307.w0KD7nen027458@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171126141555.25930-2-steffan@...1856...>
References: <20171126141555.25930-2-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for TLS 1.3 in
 --tls-version-{min, max}
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

Acked-by: Gert Doering <gert@...1296...>

Straightforward extention of the current code to add another branch
for 1.3.  Since it's really trivial, does not change existing code paths,
and we want 2.4 to be "ready for TLS 1.3 when it shows up", applied to 2.4 
as well.

Your patch has been applied to the master and release/2.4 branch.

commit 8ca9eda119638a88863118affd69dfaf8b867c92 (master)
commit 59dbb8602f30d278bd152a4a736c2af8345368eb (release/2.4)
Author: Steffan Karger
Date:   Sun Nov 26 15:15:54 2017 +0100

     Add support for TLS 1.3 in --tls-version-{min, max}

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171126141555.25930-2-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15932.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


