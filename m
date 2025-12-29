Date: Mon, 29 Dec 2025 17:12:43 +0100 (CET)
Message-Id: <202512291612.5BTGChWt030387@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251216111544.27133-1-gert@...1296...>
References: <20251216111544.27133-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Warn about failing read
 in multi_process_file_closed()
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

Backport of the relevant pieces of commit 18d1b1fe008 and 5e5ead5ba01,
and since this is a bugfix (missing/broken error handling branch), relevant
to release/2.6.  Thanks :-)

Your patch has been applied to the release/2.6 branch.

commit d8a30a5bf20eb3f57c8ccd66525b719d743df6fa
Author: Frank Lichtenheld
Date:   Tue Dec 16 12:15:39 2025 +0100

     multi: Warn about failing read in multi_process_file_closed()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1444
     Message-Id: <20251216111544.27133-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35113.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


