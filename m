MIME-Version: 1.0
References: <20200724141445.302-1-lstipakov@...277...>
 <20200724184020.GJ1431@...1296...>
 <CAGyAFMXkD2LJ+z8hVo8DphZL2pJC77ABqVeHxtYzx6Pj9AsUxQ@...278...>
 <20200724194053.GK1431@...1296...>
In-Reply-To: <20200724194053.GK1431@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Jul 2020 22:49:07 +0300
Message-ID: <CAGyAFMVE_sEzCZjOPwsgN0JzVdgFo9yQR-=xfOgmF+HvUJiqzQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve Windows version detection with
 manifest
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

> How do you build?  I use the "build-snapshot" script, and that does
> a "make dist" somewhere in between.

ubuntu@...2570...:~/openvpn-build/windows-nsis$
OPENVPN_VERSION=fix-remove-impersonation
OPENVPN_URL=https://github.com/lstipakov/openvpn/archive/fix/remove-impersonation.zip
./build-complete --use-depcache

-- 
-Lev

