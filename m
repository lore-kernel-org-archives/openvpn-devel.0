Date: Sun, 7 Aug 2022 12:23:52 +0200 (CEST)
Message-Id: <202208071023.277ANqVH099833@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220807095329.28819-1-a@...2181...>
References: <20220807095329.28819-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: disable DCO if
 --allow-compress yes/asym was specified
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

Same functionality as v1, wording as suggested.  Tested, does the job :-)

Client with "--allow-compression yes --comp-lzo" -> 

 2022-08-07 12:20:16 Note: '--allow-compression' is not set to 'no', disabling data channel offload.

Client with "--allow-compression no --comp-lzo" -> 

  Options error: Cannot set comp-lzo to '(null)', allow-compression is set to 'no'

(this error message could use a bit of improvement, though)

Client with "--allow-compression no #--comp-lzo" -> 

 2022-08-07 12:22:15 DCO device tun7 opened


We might find ourselves returning here, and the release notes for 2.6 need
careful tending to ensure the interaction of DCO with "all these options" is
communicated really well.


Your patch has been applied to the master branch.

commit c984d0b17056f87cd580260edd2e89874c601566
Author: Antonio Quartulli
Date:   Sun Aug 7 11:53:29 2022 +0200

     dco: disable DCO if --allow-compress yes/asym was specified

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220807095329.28819-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24834.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


