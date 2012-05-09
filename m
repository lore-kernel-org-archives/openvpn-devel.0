Message-ID: <4FAAFCB4.8040606@...1227...>
Date: Thu, 10 May 2012 01:24:36 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
In-Reply-To: <CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> I need a better description of the tun process... so far I did not
> understand why you cannot use standard approach of creating persistent
> tun with non root access and then use the iproute2 wrapper with suid
> or sudo to setup its configuration.
>
> Alon.

I have no root access on the telephone. But Android 4.0 provides an API
for VPNs
(http://developer.android.com/reference/android/net/VpnService.html).
Looking at my method at the method that opens the tun device to passed
over managment socket might also give an idea how it is done in Android:
http://code.google.com/p/ics-openvpn/source/browse/src/de/blinkt/openvpn/OpenVpnService.java#220

Arne

