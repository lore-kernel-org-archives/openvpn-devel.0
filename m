Date: Sun, 9 Oct 2022 16:33:09 +0200 (CEST)
Message-Id: <202210091433.299EX9CI028350@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221009140042.1560899-1-arne@...1227...>
References: <20221009140042.1560899-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable -Werror on macOS builds
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

Acked-by: Gert Doering <gert@...1296...>

Tested on "master + this patch" via my GitHub fork.  Builds all green!

  https://github.com/cron2/openvpn/actions/runs/3214397115

Your patch has been applied to the master branch.

commit 0ff633f750a57d0a4d48481be0bd915196a0bd32 (master)
Author: Arne Schwabe
Date:   Sun Oct 9 16:00:42 2022 +0200

     Enable -Werror on macOS builds

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221009140042.1560899-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25369.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


