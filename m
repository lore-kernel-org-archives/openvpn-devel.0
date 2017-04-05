From: Arne Schwabe <arne@...1227...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
	<f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
	<e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
Message-ID: <85b77b9a-a206-5a73-39fc-bffae999a50c@...1227...>
Date: Wed, 5 Apr 2017 18:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Simon Matter <simon.matter@...2249...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


would probably be a good idea to enable that.

> As I understand it client and server have 60 min. by default. Whatever is
> configured, the smaller value wins. That means, bad clients can set their
> reneg-sec to very low values and trash the server on the other end. From
> the server side this looks more or less like a DDOS.
>
> In our environment we have set reneg-sec=0 on all clients because we want
> the server to have control over it. That's fine because we have only
> trusted clients. Making it pushable could be a solution to overwrite bad
> settings in clients. A more radical solution was to just remove the option
> on the client side.
At its heart OpenVPN is still p2p instead of client of server, (Actually
client is p2p mode). So removing a client setting removes it also for p2p.

I would also say have a 5% random component by default (makes 3 minutes
for the 1h default) but let the user specify it as explicit range when
then second (optional) parameter is present.

Either

reneg-sec 3600 3500 for 3500s-3600s (absolute)
or
reneg-sec 3600 100 for 3500s-3600s (relative)

I think percent based for user inputs are always creating confusion.

Arne



