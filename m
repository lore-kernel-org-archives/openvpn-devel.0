Date: Fri, 4 Feb 2022 15:19:01 +0100 (CET)
Message-Id: <202202041419.214EJ1eW021064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220204114201.5632-1-gert@...1296...>
References: <20220204114201.5632-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair --inactive with 'bytes'
 argument larger 2Gbytes.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch (bugfix).

I'm fairly sure this particular use case was broken "since ever", but
I'm not backporting this to 2.4 and 2.3 today.

commit cae1a7fcf14e6ded34ab5a1e8842c3034cc89608 (master)
commit 1e573aa9b31d9270bd43d8c5a448314508a3311f (release/2.5)
Author: Gert Doering
Date:   Fri Feb 4 12:42:01 2022 +0100

     Repair --inactive with 'bytes' argument larger 2Gbytes.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220204114201.5632-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23720.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


