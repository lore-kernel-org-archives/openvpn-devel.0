Date: Tue, 16 Jan 2024 12:12:44 +0100 (CET)
Message-Id: <202401161112.40GBCifV040041@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240116101556.2257-1-gert@...1296...>
References: <20240116101556.2257-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement the --tls-export-cert
 feature
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

Tested a few times.  Single difference between v11 and v12 is that
it no longer calls unlink(NULL) for "no cert file created" - GHA found
that.  All the rest is as fine as it was in v11, and a reasonable
re-implementation of the code removed due to the relicensing project.

Your patch has been applied to the master and release/2.6 branch
(re-implement missing functionality).

commit c58c7c3c669461805956dabc703c1279fe58eeee (master)
commit d27cb14891f3ac40e86062c475df139bbe2c6066 (release/2.6)
Author: Arne Schwabe
Date:   Tue Jan 16 11:15:56 2024 +0100

     Implement the --tls-export-cert feature

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240116101556.2257-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28014.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


