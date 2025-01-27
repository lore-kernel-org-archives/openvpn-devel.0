Date: Mon, 27 Jan 2025 14:39:11 +0100 (CET)
Message-Id: <202501271339.50RDdBKc058739@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250127122531.13105-1-gert@...1296...>
References: <20250127122531.13105-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print warnings/errors when
 numerical parameters cannot be parsed
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

Stared long and hard at the "trivial" changes in v3..v7, and the result
now looks good and improves our reporting of config file errors, without
bloating all the option-by-option parsing.  Passes my client/server tests,
which excercise a bit of the config parser (though only half of it, maybe).

Unit-tests incoming in gerrit#876, which is even better ;-)

(JFTR, v7...v8 in gerrit are just different wrt rebasing, on top of something
totally unrelated, so using the v7 already on the list)

Your patch has been applied to the master branch.

commit 40518dc66d9d04e6ec7e04439d7a6bc7fd6ac20f
Author: Arne Schwabe
Date:   Mon Jan 27 13:25:31 2025 +0100

     Print warnings/errors when numerical parameters cannot be parsed

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250127122531.13105-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30627.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


