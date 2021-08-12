Date: Thu, 12 Aug 2021 13:02:09 +0200 (CEST)
Message-Id: <202108121102.17CB29DO003890@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210812085300.4738-1-a@...2181...>
References: <20210812085300.4738-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: do not define
 mbedtls_ctr_drbg_update_ret when not needed
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks :-) (verified on that slightly old NetBSD 8.1 buildslave,
and on more current installations)

Your patch has been applied to the master branch.

commit 2b9bbaadf44d4978c07abfdb5cce147c71cd9e8d
Author: Antonio Quartulli
Date:   Thu Aug 12 10:53:00 2021 +0200

     mbedtls: do not define mbedtls_ctr_drbg_update_ret when not needed

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20210812085300.4738-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22734.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


