Date: Wed, 7 Apr 2021 09:07:31 +0200 (CEST)
Message-Id: <202104070707.13777V68098798@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210406162518.4075-1-arne@...1227...>
References: <20210406162518.4075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove check for socket
 functions and Win XP compatbility code
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

Since Antonio did all the testing, I can take the blame :-) - we dropped
support for Windows XP quite a while ago, and I think also for Vista -
the "give me IPv6 routing info!" code new in 2.4 is not available on
older Windows versions, but since they are all out of support anyway,
we decided to "not care".

I have not *tested* the resulting MinGW-built Windows binary, but from
looking at the actual changes I do not expect runtime errors - either
it blows up at compilation/link time, or works.

Your patch has been applied to the master branch.

commit 17f91332069b4adc317bf11cb4d710b00ee139c5
Author: Arne Schwabe
Date:   Tue Apr 6 18:25:14 2021 +0200

     Remove check for socket functions and Win XP compatbility code

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210406162518.4075-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22052.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


