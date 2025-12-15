Date: Mon, 15 Dec 2025 18:25:39 +0100 (CET)
Message-Id: <202512151725.5BFHPd4x063170@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251215155652.23362-1-gert@...1296...>
References: <20251215155652.23362-1-gert@...1296...>
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

Not sure how this can fail, but if it does, we should not silently
ignore it (... as this would likely cause other issues later on, like
not cleaning up ACF files, etc.) -> this makes sense, in it goes.

Your patch has been applied to the master branch.

commit 18d1b1fe008a4bbfd5a56ca7bb59f6f8cb58114a
Author: Frank Lichtenheld
Date:   Mon Dec 15 16:56:47 2025 +0100

     multi: Warn about failing read in multi_process_file_closed()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1443
     Message-Id: <20251215155652.23362-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35095.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


