MIME-Version: 1.0
References: <20200731100629.24611-1-arne@...1227...>
In-Reply-To: <20200731100629.24611-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Aug 2020 12:02:39 +0300
Message-ID: <CAGyAFMVr=sPnGN9WP4jKjPqzfAN9jO2d0dFOWGJJb+drPzaN8g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Skip existing interfaces on opening the
 first available utun on macOS
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

 +            ASSERT(snprintf(ifname, sizeof(ifname), "utun%d", utunnum));

Not sure about ASSERT here, because according to
https://linux.die.net/man/3/snprintf

> If an output error is encountered, a negative value is returned.

which won't trigger assert.

Otherwise looks good.

Compiled and tested on macOS.

Maybe Gert could remove ASSERT wrapping before commiting.

Acked-by: Lev Stipakov <lstipakov@...277...>

