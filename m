Message-ID: <22a3c27a-0404-ac58-4ae5-5f8b46ffb75c@...2181...>
Date: Fri, 13 Jan 2023 09:37:49 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230111235052.24855-1-a@...2181...>
 <Y8EJzGoG6yEJaGmU@...1296...>
 <A4236869-0DD6-48AF-8CD0-3758E2FA4C70@...1376...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <A4236869-0DD6-48AF-8CD0-3758E2FA4C70@...1376...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristof Provost <kp@...1376...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/01/2023 09:32, Kristof Provost wrote:
> I’m not sure how we’d cope with supporting building on older releases 
> though. Not a worry just yet, because FreeBSD main is the only version 
> with DCO support in it, but it’ll be a problem sooner or later.

OpenVPN ships its own "recent"| version of the if_ovpn.h file, no?
So as long as the file contains all the enums it will compile just fine.

Cheers,


-- 
Antonio Quartulli

