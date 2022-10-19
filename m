Date: Wed, 19 Oct 2022 16:13:41 +0200 (CEST)
Message-Id: <202210191413.29JEDfSU076673@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221019133627.2918110-1-arne@...1227...>
References: <20221019133627.2918110-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix regression of ignoring
 --user
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

Glad that this obscure AS option caught this breakage... *sigh* - that's
what you get for "just fix this compiler warning" (which I am usually
quite reluctant to do, but "it looked straightforward enough").

The new code is less magic, and much easier to understand - good.

Lightly tested only ("run one instance with --user or --group, see
if log and ps output agree").

Your patch has been applied to the master branch.

commit 66f6a3b7991d5316116ce7cb91dfa4d71d4df42f
Author: Arne Schwabe
Date:   Wed Oct 19 15:36:27 2022 +0200

     Fix regression of ignoring --user

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221019133627.2918110-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25430.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


