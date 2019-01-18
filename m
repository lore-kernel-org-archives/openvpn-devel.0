Date: Fri, 18 Jan 2019 20:36:52 +0100 (CET)
Message-Id: <201901181936.x0IJaqHN003639@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219202611.2144-1-simon@...2293...>
References: <20181219202611.2144-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make DriverCertification MSI
 property public
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

To be honest, I have no idea what this does.  But I don't need to :-) - it's
infrastructure for stuff you need and nobody else depends on, and the code
change itself isn't introducing any new code constructs that might bring
dangers.  And it fixes a bug in the error reporting!

Compile tested on Ubuntu 16.04/mingw.

Your patch has been applied to the master branch.

commit fc2e28badf3736114bbc427f241961664235165c
Author: Simon Rozman
Date:   Wed Dec 19 21:26:08 2018 +0100

     Make DriverCertification MSI property public

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181219202611.2144-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18037.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


