Date: Wed, 22 Mar 2023 17:03:48 +0100 (CET)
Message-Id: <202303221603.32MG3m0U019594@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322151550.1596669-1-selva.nair@...277...>
References: <20230322151550.1596669-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make error in setting metric
 for IPv6 interface non-fatal
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

Acked-by: Gert Doering <gert@...1296...>

"Trivially correct" according to #294 - same code, just ignoring errors.

I have MinGW-build-tested this, but didn't feel like disabling IPv6 on
one of my dear machines to test for real (plus, I currently do not have
a working "MinGW build with iservice" setup).

I have added an explanatory comment on why we are intentionally not 
checking errors in this place while we do it everywhere else (otherwise
someone will come in 6 months and point out that "you are missing an
return value check there!" :-) ).

Your patch has been applied to the master and release/2.6 branch.

commit b8ee8c43fd81988a58343da466999d2e30ae6221 (master)
commit 5babbc78fa27f84039e94b545d03c7049c8bd9c9 (release/2.6)
Author: Selva Nair
Date:   Wed Mar 22 11:15:50 2023 -0400

     Make error in setting metric for IPv6 interface non-fatal

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230322151550.1596669-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26477.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


