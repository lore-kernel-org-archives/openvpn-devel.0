From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200927231513.27608-1-themiron@...2010...>
 <20200927233224.2859-1-themiron@...2010...>
 <b2adda31-c5e5-f05f-68c2-2b4d56e5174e@...1227...>
In-Reply-To: <b2adda31-c5e5-f05f-68c2-2b4d56e5174e@...1227...>
Date: Fri, 2 Oct 2020 03:47:31 +0500
Message-ID: <032e01d69844$d8d93540$8a8b9fc0$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH] Speedup TCP remote hosts connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

> Okay, I looked at the code and you are right. That code is a mess. It bas=
ically
> calls select/pool with a timeout of 0, then actively does select/pool in
> management for 1s and does this in a loop. That this totally wrong indeed.
>=20
> I think we should be more radical here. Always do a 1s poll/select timeou=
t and
> do a 0s management sleep/poll. That will also make the code a bit simpler.

Othe thing, management_sleep(0) results in infinite wait, so I;ve changed a=
pi in subsequent patch.
Now, management_sleep() can handle only non-negative value and managemet_ev=
ent_loop_n_seconds() can take negative values to have infinite wait, if nec=
essary.
Since there were no negative or zero parameter for management_sleep() users=
, no side effect behavior change is expected.
Seems, a bit simpler can't be achieved :)

--
Best Regards, Vladislav Grishenko



