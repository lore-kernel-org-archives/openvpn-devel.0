Date: Thu, 25 Mar 2021 12:07:12 +0100 (CET)
Message-Id: <202103251107.12PB7Css004413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210324222330.455-1-arne@...1227...>
References: <20210324222330.455-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make buffer related function
 conversion explicit when narrowing
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

Read through the code changes, seem to all make sense.  Verified the
fread() change according to FreeBSD man page.  The only hunk that 
slightly confuses me is that the patch removes a "const" which seems
to be "correctly before the change" - but not sure this is relevant
at all.  Compile tested on Ubuntu/MinGW, lightly tested on FreeBSD
and Linux.

Your patch has been applied to the master branch.

commit 7fc608da4ec388c9209bd009cd5053ac0ff7df38
Author: Arne Schwabe
Date:   Wed Mar 24 23:23:27 2021 +0100

     Make buffer related function conversion explicit when narrowing

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210324222330.455-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21805.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


