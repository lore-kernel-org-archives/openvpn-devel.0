Date: Wed, 5 Feb 2020 21:13:02 +0100 (CET)
Message-Id: <202002052013.015KD2fY030171@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200205124615.15758-3-domagoj@...2540...>
References: <20200205124615.15758-3-domagoj@...2540...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix linking issues on MinGW
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have slightly modified the commit message to explain the underlying
issue better ("if compiled without -O2").  No change code-wise to your
patch.  Makes sense :-)

commit 5822e52c6b0f86f9e4de946f9fb1374c6fad95f1
Author: Domagoj Pensa
Date:   Wed Feb 5 13:46:15 2020 +0100

     Fix linking issues on MinGW

     Signed-off-by: Domagoj Pensa <domagoj@...2540...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200205124615.15758-3-domagoj@...2540...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19356.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


