MIME-Version: 1.0
References: <20221111111619.21415-1-frank@...2641...>
 <20221111121212.25167-1-frank@...2641...>
In-Reply-To: <20221111121212.25167-1-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Nov 2022 14:19:43 +0200
Message-ID: <CAGyAFMU3d347hbMqo1bTS6nyr=pp7D5h09zpwiMFEhXb1bqbYA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: always call git-version.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Don't know if I can ack the patch to which I've contributed - but
anyway, the makefile change looks
good and the python script doesn't regenerate version header (which
would trigger recompilation of some files).

Tested locally and GHA is happy.

Acked-by: Lev Stipakov <lstipakov@...277...>

