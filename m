MIME-Version: 1.0
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
In-Reply-To: <20200818063212.GW75094@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 18 Aug 2020 10:29:52 +0300
Message-ID: <CAGyAFMVKVbWKJ+yRNoLAafpXo7h9n5fJN2Z50Mt54skP5JK03Q@...278...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
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
To: Gert Doering <gert@...1296...>
Cc: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Continueing this thought: I think we might want to abort earlier in
> the OpenVPN startup in this case, that is, "wintun and no iservice pipe".

.. and not running under NT AUTHORITY\SYSTEM.

> Lev, what do you think?

Depends if amount of code to check the above mentioned condition would
outweigh its benefits.

-- 
-Lev

