Date: Fri, 19 Mar 2021 08:53:33 +0100 (CET)
Message-Id: <202103190753.12J7rXLk028211@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210318181258.89704-1-juliusz@...2525...>
References: <20210318181258.89704-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Add support for
 pkg-config < 0.28 for old autoconf versions
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
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have amended the commit message to point out what David found out, that 
this is related to pkg-config version and not autoconf itself.  The patch
itself is unchanged.

I have thrown this branch towards all our buildbots first, and everything
builds again (well, it builds syntactically correct "configure" scripts,
that then fail at "missing lz4", but that's not your fault).  THANKS!

commit 60c18b45c04f4c86241d9f6e4dc422c5c07405a1
Author: Juliusz Sosinowicz
Date:   Thu Mar 18 19:12:58 2021 +0100

     build: Add support for pkg-config < 0.28 for old autoconf versions

     Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20210318181258.89704-1-juliusz@...2525...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21708.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


