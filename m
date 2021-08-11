Date: Wed, 11 Aug 2021 14:41:45 +0200 (CEST)
Message-Id: <202108111241.17BCfjsn082869@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210810061644.20353-1-maximilian.fillinger@...2507...>
References: <20210810061644.20353-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace deprecated mbedtls DRBG
 update function
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

I have only done a cursory look ("it's like v1 with the compat function"),
and done a minimal test compile (Linux, mbedTLS 2.26.0, and FreeBSD,
mbedTLS 2.16.11) + t_client test run.  No surprises.

Your patch has been applied to the master branch.

commit b99fa3fd4fc41862354be709edb9877aae3e138c
Author: Max Fillinger
Date:   Tue Aug 10 08:16:44 2021 +0200

     Replace deprecated mbedtls DRBG update function

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210810061644.20353-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22711.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


