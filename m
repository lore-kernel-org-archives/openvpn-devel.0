Date: Sat, 30 Jan 2021 12:07:45 +0100 (CET)
Message-Id: <202101301107.10UB7jjF099430@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201214172407.30451-1-arne@...1227...>
References: <20201214172407.30451-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove inetd support from
 OpenVPN
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

stared-at-code (which is quite a lot of changes, some of which want "-w"), 
ran on the client and server test rigs (breaks --inetd mode, whoa, but 
everything else works :-) ).  Looks good!

Removal of --inetd has been pending for multiple months now (since before
the release of 2.5.0) and nobody has ever asked for it to stay - so, gone
it is, now.

Your patch has been applied to the master branch.

commit ce652e7d3865dcdebfdc9233d9f46dfbcc2a6e2b
Author: Arne Schwabe
Date:   Mon Dec 14 18:24:07 2020 +0100

     Remove inetd support from OpenVPN

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201214172407.30451-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21360.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


