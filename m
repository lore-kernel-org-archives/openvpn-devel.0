Date: Thu, 17 Jan 2019 19:52:50 +0100 (CET)
Message-Id: <201901171852.x0HIqo8O093932@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181127002808.19200-1-simon@...2293...>
References: <20181127002808.19200-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a MSI custom actions to
 close and relaunch OpenVPN GUI
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looks reasonable (the big picture "how does the installer know if there
is a GUI in the first place?  does it ask?" is missing, but I assume this
is in the WiX pieces).  Test compiled on Ubuntu 16.04/mingw.

Your patch has been applied to the master branch.

commit 597972bcc3124964df3ccc484df4c0efa6ec0dbc
Author: Simon Rozman
Date:   Tue Nov 27 01:28:08 2018 +0100

     Add a MSI custom actions to close and relaunch OpenVPN GUI

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181127002808.19200-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17959.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


