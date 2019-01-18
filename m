Date: Fri, 18 Jan 2019 20:57:47 +0100 (CET)
Message-Id: <201901181957.x0IJvlQ2003900@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190101233547.10100-1-simon@...2293...>
References: <20190101233547.10100-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Strip _stdcall suffixes (@nn)
 for 32-bit builds
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

You really do not like this calling convention, do you?  ;-) - learned
something new today, what "-Wl,--kill-at" does...  (while the original
round of stdcall discussion was MSVC, here's the mingw variant)

Your patch has been applied to the master branch.

commit f9f1605194281a6103d889298d4f303f94bc9d96
Author: Simon Rozman
Date:   Wed Jan 2 00:35:47 2019 +0100

     Strip _stdcall suffixes (@nn) for 32-bit builds

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190101233547.10100-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18077.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


