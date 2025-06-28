Date: Sat, 28 Jun 2025 18:29:50 +0200 (CEST)
Message-Id: <202506281629.55SGTorG082063@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250627082500.17075-1-gert@...1296...>
References: <20250627082500.17075-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: create NRPT registry key
 if it doesn't exist
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond "does it compile on a MinGW buildhost" (it
does), and "what does this function do?" (open a registry key if it exists,
and create a new key if it doesn't exist yet) - so this all seems to make
sense, and Lev confirms that it does what it wants to achieve ;-)

Your patch has been applied to the master branch.

commit df4863aa0e43544ea82ab9d98966a03a95c62334
Author: Heiko Hund
Date:   Fri Jun 27 10:24:53 2025 +0200

     dns: create NRPT registry key if it doesn't exist

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250627082500.17075-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32001.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


