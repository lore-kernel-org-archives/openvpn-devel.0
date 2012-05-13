MIME-Version: 1.0
In-Reply-To: <20120513090153.GG1359@...1296...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
Date: Sun, 13 May 2012 12:10:48 +0300
Message-ID: <CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, May 13, 2012 at 12:01 PM, Gert Doering <gert@...1296...> wrote:
> Try to build Xorg or teTeX yourself, from packages, and learn from it.

We are not xorg... [yet].
Anyway, I think the modular xorg and kde processes are a great success.
It allowed them to delegate maintenance, and handle shorter release
cycles for each component. Now people can update their xinit without
receiving ~50 unneeded changes. Stabilization process is also much
shorter now, as most of the components are static.

I showed Eric that the freebsd already maintains[1] the auth-radius,
auth-ldap in modular way. Not sure why the auth-pam and down-root are
any different.

We need to strive to join efforts with these other plugin maintainer,
hosting them on the openvpn project resources, and build healthy
community.

And, if not split, they these two plugins should integrated within
build system. The custom make files are not doing any good, but I
still don't understand the difference between these two and other
plugins out there.

Alon.

[1] http://www.freebsd.org/cgi/ports.cgi?query=openvpn&stype=all

