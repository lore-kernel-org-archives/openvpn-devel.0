From: Maximilian Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 17 Nov 2021 19:00:19 +0000
Message-ID: <a1cf22225ad1419a970d234512256d5f@...2507...>
References: <20211117175424.17195-1-maximilian.fillinger@...2507...>
 <YZVOeK0S7+TOLfyN@...1296...>
In-Reply-To: <YZVOeK0S7+TOLfyN@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Don't "undo" ifconfig when given
 --ifconfig-noexec
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> ... so why is "did_ifconfig_setup" true, if ifconfig wasn't done?
>=20
> Or, phrased differently, what is did_ifconfig_setup used for, across the
> code, and can we just "not set it to true" if ifconfig-noexec is in
> effect?  Or does it have nasty side effects?

tt->did_ifconfig_setup is set in init_tun, which sets up the tuntap struct =
but
doesn't do ifconfig yet. This is executed independently of --ifconfig-noexe=
c.
There are probably some things to refactor there. Maybe we could remove
did_ifconfig_setup and instead use did_ifconfig on all platforms.

But to be honest, I'm scared of touching it.

Also, could we backport it to 2.5? If so, isn't it better to keep the fix s=
mall?

