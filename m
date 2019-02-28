Date: Thu, 28 Feb 2019 16:45:40 +0100 (CET)
Message-Id: <201902281545.x1SFjeBP041694@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190224181621.27020-1-simon@...2293...>
References: <20190224181621.27020-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Limit tapctl.exe and
 openvpnmsica.dll to TAP-Windows6 adapters only
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

Thanks for the change.  I have *not* tested it, just test compiled it
(the usual ubuntu 16.04/mingw combo), but staring at the code, this look
reasonable.  Actually the change seems to make the code *more simple*
(in FindTAPInterfaces() ) which is always welcome...

Your patch has been applied to the master branch.

commit f20dd0ee77c37c5d99106d0cbf29658b3c57fd3f
Author: Simon Rozman
Date:   Sun Feb 24 19:16:21 2019 +0100

     Limit tapctl.exe and openvpnmsica.dll to TAP-Windows6 adapters only

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190224181621.27020-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18234.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


