Date: Mon, 22 Mar 2021 10:10:42 +0100 (CET)
Message-Id: <202103220910.12M9Ag1E095423@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210322074359.527-1-simon@...2293...>
References: <20210322074359.527-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: Resolve MSVC C4996
 warnings
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
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

It's the same code change as in v1, just the comment rewritten as Arne 
asked for (I found the other one okay-ish, but this is more in line with 
our other code, and indeed "less thinking required on read") and a new
helper variable for the total length.

Code looks good, test build on Ubuntu 18/MingW also had no complaints.

Your patch has been applied to the master branch.

commit ef5b922aedead7159718ddbf40fc9f5be1b2b203
Author: Simon Rozman via Openvpn-devel
Date:   Mon Mar 22 08:43:59 2021 +0100

     tapctl: Resolve MSVC C4996 warnings

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210322074359.527-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


