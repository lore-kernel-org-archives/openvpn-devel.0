Date: Thu, 23 Mar 2023 18:24:23 +0100 (CET)
Message-Id: <202303231724.32NHONL5046938@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230323170601.1256132-1-arne@...1227...>
References: <20230323170601.1256132-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify --compress parsing in
 options.c
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

Acked-by: Gert Doering <gert@...1296...>

"git show -w" shows that this is mostly whitespace changes and
streq()'ing alg instead of p[1] - with alg defaulting to "stub"
now (instead of having an else{} clause for "no option" that does
the same).

There is a minor difference, as "compress <no args>" would set
COMP_F_SWAP beforehand, and now adds COMP_F_ADVERTISE_STUBS_ONLY,
which might warrant an update to the documentation (it says "Additionally,
'stub' and 'stub-v2' will disable announcing lzo and lz4 compression",
so there is a documented difference to 'empty').

Client-side tested on Linux / t_client with and without compression.

Your patch has been applied to the master and release/2.6 branch.

commit bfc00a01c10bbdd9683aab5db2c2e7dcbb2f7378 (master)
commit 5fed4be1bf4b2c6e4ff0117bceb9613fa68b412d (release/2.6)
Author: Arne Schwabe
Date:   Thu Mar 23 18:05:58 2023 +0100

     Simplify --compress parsing in options.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230323170601.1256132-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26501.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


