MIME-Version: 1.0
References: <20211115115309.GA29441@...2643...>
In-Reply-To: <20211115115309.GA29441@...2643...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 15 Nov 2021 14:45:53 +0200
Message-ID: <CAGyAFMWRiAKE_P-9CKkGqma2Br27Xv5eC+eS9OeVy-VfGxVn+w@...278...>
Subject: Re: [Openvpn-devel] Start openvpn gui before windows login
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
To: Ruben Herold <ruben@...1302...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

A few years back we made a Proof-of-Concept with OpenVPN 3 and Windows
UWP API. Performance-wise it was on tap-windows6 level (which is not
impressive), there were some issues with UDP transport (which were
solved by MSFT later) and usability related to UWP app model - for
example application might be "paused" when it is not on the
foreground, which means inability to send ping packets and disconnect.

Things might have changed since then, but our priorities now are
releasing 2.6 with the new dco/dco-win drivers, which significantly
improve performance. We might have a look at UWP VPN after that again.

Are you sure your problem cannot be solved with openvpn service?

See, for example,
https://openvpn.net/community-resources/running-openvpn-as-a-windows-service/
Also this discussion might be relevant:
https://github.com/OpenVPN/openvpn-gui/issues/77

--
-Lev

