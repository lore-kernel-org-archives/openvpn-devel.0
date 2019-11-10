Date: Sun, 10 Nov 2019 14:22:19 +0100 (CET)
Message-Id: <201911101322.xAADMJxO001180@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191110124407.8734-1-a@...2181...>
References: <20191110124407.8734-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: get rid of 'broadcast' argument
 when configuring the tun device
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

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Patch looks good ("stared-at-code") and since the buildbot army 
is running sufficient t_client tests nowadays to actually catch runtime
brokenness for "standard cases", this looks good.

I'll amuse myself testing /31 across the platforms in the next days, just
because I want to know :-)

Your patch has been applied to the master branch.

commit 6c8b33f28970bbadcba5dac3e324550836c573cc
Author: Antonio Quartulli
Date:   Sun Nov 10 13:44:07 2019 +0100

     get rid of 'broadcast' argument when configuring the tun device

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191110124407.8734-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20191110124407.8734-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


