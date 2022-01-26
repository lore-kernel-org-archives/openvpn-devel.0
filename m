Date: Wed, 26 Jan 2022 14:58:45 +0100 (CET)
Message-Id: <202201261358.20QDwjMK060486@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220120162645.13881-1-selva.nair@...277...>
References: <20220120162645.13881-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix a potential memory leak in
 tls_ctx_use_management_external_key
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

Thanks.

Even if, as Antonio noticed, we will only leak memory for a very short
time before hitting the M_FATAL message in "cleanup"...

Your patch has been applied to the master branch.

commit 0f7cd474118deeced48168ed9cec0806e7f4cc15
Author: Selva Nair
Date:   Thu Jan 20 11:26:45 2022 -0500

     Fix a potential memory leak in tls_ctx_use_management_external_key

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220120162645.13881-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23610.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


