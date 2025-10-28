Date: Tue, 28 Oct 2025 15:05:51 +0100 (CET)
Message-Id: <202510281405.59SE5pRC004688@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028101642.11874-1-gert@...1296...>
References: <20251028101642.11874-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Canonicalize config_dir before
 comparing with the config file location
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK from Arne, extra check from Lev, BB all green, so let's see if the
windows t_client test (run by github magic only after pushing to the official
repo...) finds something else.

Also, as Lev remarked, we might want to apply this to 2.6 "if 2.6 is broken
on windows 7 anyway" or see what to do about the original report on Win7,
if anything at all.

Your patch has been applied to the master branch.

commit 05a8ba8080c7a7c3dc6cc681b3fc3cf8c559e053
Author: Selva Nair
Date:   Tue Oct 28 11:16:36 2025 +0100

     Canonicalize config_dir before comparing with the config file location

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1318
     Message-Id: <20251028101642.11874-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33923.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


