Date: Mon, 14 Feb 2022 08:16:45 +0100 (CET)
Message-Id: <202202140716.21E7GjQL009246@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220214021054.3750071-2-arne@...1227...>
References: <20220214021054.3750071-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add Werror to github action
 ubuntu build
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

Makes sense.  The code should be warning-free on Linux no, so enforce it.

(I seem to remember we already added this elsewhere for Linux CI builds)

Your patch has been applied to the master branch.

commit afa875bc7036edc78c89f4b2215deb0169807daa
Author: Arne Schwabe
Date:   Mon Feb 14 03:10:54 2022 +0100

     Add Werror to github action ubuntu build

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220214021054.3750071-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23778.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


